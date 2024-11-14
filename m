Return-Path: <linux-kernel+bounces-410001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD909C9546
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 23:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0743B25202
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 22:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271591B4F1A;
	Thu, 14 Nov 2024 22:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D0PqCBqv"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF0A1B4F24
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 22:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731623856; cv=none; b=bohnU2rD9ziXzcQKfdtUm2iTGTCCODIuxzn36mu/uMiPu40tx6ThUCiXRMJgsJg9wgBSe1hTv7mdiGkdV4WZJbF5uyliuL31h9s+0N9oPa63oEPHXWCEm6PW94rYxeMh38zXy18/xxDvrX8oFx1NoGqUv/028p0FwrXgfw+3k30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731623856; c=relaxed/simple;
	bh=5mWLFYI478bNp1POrIyNj/oiYZL8O4x/nC2FuTe8uEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZaPQ6zXnYFA9IbXwSD53RoC2vC3lkbk+xk/UJDACdTs14mV98qooKNrkt7kSgwJn36bNoBkjmn/2cy5ZWIWChodLRuIEFqOUOdN0xeayYrBt4fvsXh/EXAgoCvJQN86KSbvCTjQhYEsCILpOgFEeGXvrhTjK1ywTuP1AaSTdL+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=D0PqCBqv; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539ee1acb86so1195122e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 14:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731623851; x=1732228651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zrADbJtEOFmA5PPe2GqiGzYRsqhWbiQIwK7iBvvP7Y=;
        b=D0PqCBqviBeNk2xbjL6LtwtTw4/IUyTysEQ/HeQZ/6WnoGK7x54aTzfBYOOc5MM8fZ
         UZO1Fy40HpqYdFIRks0bI0nn8RnE10oQifi9804e7Qrgnri+UDTlP2O+e5B3faKciJnv
         7OOBHFDpPnTFy44TOBC95BaZ1x05M0eKrSIV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731623851; x=1732228651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2zrADbJtEOFmA5PPe2GqiGzYRsqhWbiQIwK7iBvvP7Y=;
        b=SrcDd0Z66BlbSKh4wKQviiy6AlVL0bXLAnPPrsEoXmCLeav7nM0JVYwf5HxYTn3gq2
         i6DvYmwGznNx8f2aeOE+h251NLJ18omSK8TagmkqflR6imoSXZw1LtRmzL3OkC+UTsfX
         lZjHWjnKvmnNfHc+i3NavFvGb7aRJyA2XXAqoGKkSeGj6XwZMZvhALsIjrbeeLuVQUpF
         qLB/wgY1NMl5Gr7+KHVwDLLR4u+D4VDDELrhFtXD1ihE5HscQVYrgD+dAju9kIYXWzv8
         LNnqbAvRcSm+GX5PZB+ZW+1jZh1aWLjNAWsjLkUxqaPwK5gcNjSRXsGmxVBxvJ6FqkWW
         RAmg==
X-Forwarded-Encrypted: i=1; AJvYcCV0EdsFeMHF6yDs3FgrRBLFlVr0aTDg4ZGH8Y1I9lfKWjzZsutHaNO686vIlKIDeVhwBxqgRjRFY3vRIs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXK9rHzr9C0aK0yyYatEjtCEYgwUKq9re32AGszefCTXHUI8PT
	gAnwOSrYF6Koe18x9H7uS1nharytGAiEQraEuGGrG3fUQnjYuY2RR2JS0mzfhTH+3EqQODuIuSd
	4aw==
X-Google-Smtp-Source: AGHT+IEArKKgRJrKXp3/a274RFoKsTmWiknpvWkKDP9KLcX15FBCPZO4nxc/w5+Rufxo1VfIZjWC6Q==
X-Received: by 2002:a05:6512:3409:b0:536:a52d:f94b with SMTP id 2adb3069b0e04-53dab2893c8mr156152e87.8.1731623850848;
        Thu, 14 Nov 2024 14:37:30 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53da6500d72sm329466e87.86.2024.11.14.14.37.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 14:37:29 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53da2140769so1255350e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 14:37:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVmCH/A/OEzxYBhslWokhYzgBk8evcPbCpJJ97dz4g84Q+oDzmOCHiYg/FOHE1vGuH6zm6anr/EJ97izxc=@vger.kernel.org
X-Received: by 2002:a05:6512:3d90:b0:539:d10b:e38b with SMTP id
 2adb3069b0e04-53dab2b4229mr156166e87.39.1731623849023; Thu, 14 Nov 2024
 14:37:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024111339-shaky-goldsmith-b233@gregkh> <2024111342-lagoon-reapprove-5e49@gregkh>
In-Reply-To: <2024111342-lagoon-reapprove-5e49@gregkh>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 14 Nov 2024 14:37:17 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XjK_vYnNiWfXXMBJq8Nkt-4e5bHN6NCu23S0EumAAdbw@mail.gmail.com>
Message-ID: <CAD=FV=XjK_vYnNiWfXXMBJq8Nkt-4e5bHN6NCu23S0EumAAdbw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] USB: make to_usb_device_driver() use container_of_const()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, stern@rowland.harvard.edu, 
	linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, 
	Grant Grundler <grundler@chromium.org>, Yajun Deng <yajun.deng@linux.dev>, 
	Oliver Neukum <oneukum@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 13, 2024 at 6:04=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> Turns out that we have some const pointers being passed to
> to_usb_device_driver() but were not catching this.  Change the macro to
> properly propagate the const-ness of the pointer so that we will notice
> when we try to write to memory that we shouldn't be writing to.
>
> This requires fixing up the usb_driver_applicable() function as well,
> because it can handle a const * to struct usb_driver.
>
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Grant Grundler <grundler@chromium.org>
> Cc: Yajun Deng <yajun.deng@linux.dev>
> Cc: Oliver Neukum <oneukum@suse.com>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> v2: reordered patches, goes on top of series submitted at https://lore.ke=
rnel.org/r/2024111322-kindly-finalist-d247@gregkh
>
>  drivers/usb/core/driver.c | 4 ++--
>  drivers/usb/core/usb.h    | 2 +-
>  include/linux/usb.h       | 3 +--
>  3 files changed, 4 insertions(+), 5 deletions(-)

This looks reasonable to me. Assuming that there are no compiler
errors reported:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

