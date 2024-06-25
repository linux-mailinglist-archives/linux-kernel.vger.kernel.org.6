Return-Path: <linux-kernel+bounces-229281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB65916DC6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B3E71C2341A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE1D17334B;
	Tue, 25 Jun 2024 16:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Uyh46b93"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD14817082D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 16:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719331677; cv=none; b=hBXf5cCl9wjTG+CQyNq/8Gmrdt4wLJT5xj0svM4C3F6U0sreVCNIYLvTTVKSymlr3qVbl80iKTylx5CDsWNF1z30RJtClJuKV6QvIzrfvQW/PD+5dpC+tYq3zVKgdIc8yzmwVPmNWo1brZ9R8cDjz2Lju4NAq6tG3WoteCnrdMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719331677; c=relaxed/simple;
	bh=MITC5Dpw59PNG3gH9LJkI2TRRsflwYIg4/sSfG8aFOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g4vm88tO1qYH/aLwd6djYYeylQJXFXd6GApcSDiOe6TFWFxmLQamXu8mPRkdkGhJkOc38mCopj8hcNZD1GWSb7y0T1ku+6/7B1LrKtvb9cddK3HvnWJieJv4azuh248l17kJergN/T7p51N/jpf3fU2rqjKMTxFF66BiJZ2JOWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Uyh46b93; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7eb85e80661so217132339f.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 09:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719331675; x=1719936475; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0MP9ThQ+daRDKC61/fbRCzsXnGThsgTesQ7WwlFfdMA=;
        b=Uyh46b9389kxL/t8N/4CMzoaYmjGi7YaepdvgWkrG/h7ACzLySV8TkaE8QuG0x4P0l
         yfav7s+YOcvmntuAwpcOJi09CNiik/oPuLqwf0aDqyhMX+ozfKdGLa3P3p6cHVlS8A4A
         6JeziXA5i69LrkkYBH1Ar7LeGQ3wgJ8f1Nnx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719331675; x=1719936475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0MP9ThQ+daRDKC61/fbRCzsXnGThsgTesQ7WwlFfdMA=;
        b=e6/t0dyHMGNRwyfLGVgnmQN1qsMmSE6zkVh/P/eXuV+wfR1I6JoiPYfYazH5nYBZGU
         rddM/wCxnSHqjuI5pyKmfEmMEmCdMdo3M9SUQe+rj2HOJ/fM6aAGpx89ON09uvvmBHbJ
         WUJRUwIoSzuwpzvCZVo4JobAfmf29wdB6vfXVRTn8xlW/jC9k2gaIEwLFRDDMMtHyyI2
         C4TTHM6O02IXp6wsA93WEAuMn4Qr+dVHk5Gr8p3lHhz3YOgA1yAEblO6kpb1h2wrYl9R
         PgGr5M/TYFC1dBP3Q7nGsbGm1KSYSuLxs6OyHPkOQUPKbHjTF5tTnrENYcZQZc6j3SOA
         TzdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiyyUFlEaZHxdATrB/MmUVh8bjlUnG17vXGRFn2ARqilM0EUvF3RPzQn8yU2LHQ6oy0K5qP6rOTWbNCiFmF/qQpHH6WE9VpLGcXD6S
X-Gm-Message-State: AOJu0YzNtC05t6oT1AuKE73yr0VqAc2FC8x/qsAT90TdslB7byQajNEG
	gjYMwMoUegKFzs/R0RGEhTe51GNg2pPGd4z0crjMIBkorXJ+VvwGZ25HYEP1Pp8v0btG2kxE9PI
	=
X-Google-Smtp-Source: AGHT+IFmpORz7FTl3zC3V3Mc8GsQORkCPn6Jex2m3rT9i9BCFGhLbaBTsW1U1XoDluMsGW6HyNjfnQ==
X-Received: by 2002:a05:6602:3f81:b0:7eb:b257:65ec with SMTP id ca18e2360f4ac-7f3a75e3622mr719116439f.20.1719331672894;
        Tue, 25 Jun 2024 09:07:52 -0700 (PDT)
Received: from localhost (11.249.122.34.bc.googleusercontent.com. [34.122.249.11])
        by smtp.gmail.com with UTF8SMTPSA id 8926c6da1cb9f-4b9ecf47885sm1829652173.140.2024.06.25.09.07.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 09:07:52 -0700 (PDT)
Date: Tue, 25 Jun 2024 16:07:51 +0000
From: Matthias Kaehlcke <mka@chromium.org>
To: Jameson Thies <jthies@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Benson Leung <bleung@google.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: misc: onboard_usb_dev: Add match function
Message-ID: <ZnrrV6A01WWbVNqv@google.com>
References: <20240612180448.1.I805556c176c626872c15ce001f0e8198e1f95ae1@changeid>
 <2024062032-bobbing-backspace-8bd5@gregkh>
 <CAMFSARehnCK-xEe31_diLV_oavMSctXgZZcJKARN8gg443R4nA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMFSARehnCK-xEe31_diLV_oavMSctXgZZcJKARN8gg443R4nA@mail.gmail.com>

On Tue, Jun 25, 2024 at 07:27:01AM -0700, Jameson Thies wrote:
> Hi Greg,
> this fixes an existing problem. On chromebooks using this driver for
> an onboard hub, connecting an external hub in this ID table fails to
> bind to the generic USB driver at the lock screen (devices default to
> unauthorized). We are still trying to figure out why the hub isn't
> able to bind to the generic USB driver after the onboard_usb_dev
> driver when the device is authorized after it enumerates. But, I think
> it would be preferable for this driver to not match external devices
> in the ID table. This resolves the issue for me.
> 
> Tested-by: Jameson Thies <jthies@google.com>
> Reviewed-by: Jameson Thies <jthies@google.com>

Thanks Jameson!

To Greg's question: from the perspective of the onboard usb dev driver
I would call the change an optimization, there is no point in binding
the device to the driver if it is known beforehand that probing will
fail.

With respect to the issue Jameson described the change is a workaround,
but not a proper fix.

