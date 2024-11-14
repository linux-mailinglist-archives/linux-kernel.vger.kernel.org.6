Return-Path: <linux-kernel+bounces-410002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F16FC9C9547
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 23:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F709B2609D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 22:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7381B6CEC;
	Thu, 14 Nov 2024 22:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ahryUIYz"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE621B6CE1
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 22:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731623860; cv=none; b=Wvvn5eTb9MUMVWcGJwkBX5+XY/1+KZDzdKNyZhfvPOdoBx3/m3pD12eVasl6eG4WNH40cpcBDFWITHwXec0ZZtT6T/8JLVNuR8TJ4FMr4Vz978wDY9+UPBf6SdOAoHg1p39AMRT/HO6nrx5tZyusnL7NYdvuR2tfGoCZgjFo5yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731623860; c=relaxed/simple;
	bh=85ztcJGPwsa1N1byGv10pM/FRhozd8pTWNDn+7bp634=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L0kG2q2cB4VTBGHngOCV+ew+E1/BD5iy0LDL7zpQcMEsAKcA/PRk3NDafVxz6DOAlRO+U5YWmQhvi7x29M78AOZWQeitSDexQpJgkHunL4sINbXUKC+53pYArVWmh6iifzI9AqjNMaPr35RybhYpDddnpYFEJnEtuLj51Bifvlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ahryUIYz; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53b13ea6b78so1851635e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 14:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731623855; x=1732228655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RX6oh5hFqtJwErEUNmAu9JijbwwkjoSkmYP7pKJeT2U=;
        b=ahryUIYz47T480+nxg089cHszpSn7WNpXyng0Xx9lFY6bMxHFXFk1GvFfdrzO3uS3b
         MskgmG6iXFEacimvdyGK2D8aHj7N5oe0Di0OarEsi8sZcIcTh8oV7YS6nsPRRWd5h0i1
         25sav6Bg9UP5twI7sBsaJzQast35v5XI5Gxk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731623855; x=1732228655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RX6oh5hFqtJwErEUNmAu9JijbwwkjoSkmYP7pKJeT2U=;
        b=wZSknkAX2XW/0C1YnKFswNbWvlrS1cRrwNOUN4EfPsCAkBNO8qvJR6kDGbqH4Xmozw
         eK9GUa7wLCGoZC+sS5C9U9e4eHblmWdo8dECT1dZA7W3sqDronWGfWBA1xqPiFZN9KnA
         +Y64IJfA0x8Iw0jRrPhk4EaC1W+gBQkFcNjUlj/9TBAqwx3rhzpoo7MmEek3gPr6rtBc
         EQH0vtuFDtRp0rcv9Te/flWxzBkPCdazS7rjBBklk83H2jHVclvmjKiZof/7zehj3uEE
         wZcT2ea9En3SHOApEg71TWhSW//CrITY6iTwwhXaqXUBzCx3fGnxlE2F6La6+UA+ttxh
         Na9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWBohyuDj/3IgiN9x8/7ko5X0qn5StEtWT6OzxU/lQvz3tQ9yDOMIE+VxLFEsObU9Z5rPlYN7GMWWEuGxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJBE0dH+A39U2wk1cCa3j/ZsAfv0sjtwibcvnZLTkT/Z5xPRUr
	g7wuT5LxgiXRrxsJ99I2E/BVKFWw9BOP9CqMQLr0CJ3rrqQsPrAEnjwe3r961kDDURA2+umPwUf
	nhw==
X-Google-Smtp-Source: AGHT+IGZe0hEZcQbqaSBdIhf8xfUcivXyfwbZLCyu/UA5/LQoUrYRnETGB0ac+IV0YISBJIxTfQZTQ==
X-Received: by 2002:a05:6512:2820:b0:53b:154c:f75d with SMTP id 2adb3069b0e04-53dab2a9e83mr262418e87.31.1731623855030;
        Thu, 14 Nov 2024 14:37:35 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53da6501551sm325187e87.102.2024.11.14.14.37.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 14:37:34 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fb5fa911aaso20273651fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 14:37:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVpT2Uz4cTD06k/oxX9SZiQMNLgRo0r9U0TqCDj2DGlLZdll45tYMQNmfwKRRiNMtTH5oYUp+OX4AlsjPw=@vger.kernel.org
X-Received: by 2002:a05:651c:160d:b0:2ff:59dd:9242 with SMTP id
 38308e7fff4ca-2ff606fa75dmr5641741fa.35.1731623853616; Thu, 14 Nov 2024
 14:37:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024111339-shaky-goldsmith-b233@gregkh>
In-Reply-To: <2024111339-shaky-goldsmith-b233@gregkh>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 14 Nov 2024 14:37:22 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VUCH-6JKVciJ+wQKv1_4=xrgeqBm3QAmBB3fBktVP4eA@mail.gmail.com>
Message-ID: <CAD=FV=VUCH-6JKVciJ+wQKv1_4=xrgeqBm3QAmBB3fBktVP4eA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] USB: make to_usb_driver() use container_of_const()
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
> to_usb_driver() but were not catching this.  Change the macro to
> properly propagate the const-ness of the pointer so that we will notice
> when we try to write to memory that we shouldn't be writing to.
>
> This requires fixing up the usb_match_dynamic_id() function as well,
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
>  include/linux/usb.h       | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

This looks reasonable to me. Assuming that there are no compiler
errors reported:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

