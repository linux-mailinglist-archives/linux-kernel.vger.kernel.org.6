Return-Path: <linux-kernel+bounces-373988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 946C49A603D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 11:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC94CB29DFC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31A931A60;
	Mon, 21 Oct 2024 09:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="afBpTN5T"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B76192D69
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 09:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729503409; cv=none; b=UKP/LeQGW4xjwKLWny4QSBrqrOnOaVLZNipKUGC2x+IWOed8SxuqdvgJz99CGr4hiSQrKF6CcDfhKrVsyfmbCbYeUi388H0gu0b/JDnRAk5k9jbNQg0O/rCVjs6AfXUxC73D026Eff55V23LoTDvIJAxKC9PiVTX+RB6WxuW68M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729503409; c=relaxed/simple;
	bh=DjbT5uld7w6vhzj/KDwtvfauUcaiWhU36u1wDHVvUkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nQ0K/YmzDP8fSYQTtH5gJz7no9HnUq+taKe+LAGGmWuX15lWcdluJwoifxpggu5gMrUFL792sewJ4jJFTlV7J0ESV7tEqnpNOG5MtLwhyVkp+lwtGqa+9FjRpMNihqqy5Vnq9mYtdQE639DL2nrEIy9OT+Cv2q7eDBOC14lFB9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=afBpTN5T; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539e3f35268so2245894e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 02:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729503404; x=1730108204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SaA6MjCnzEXGANWWWWPr9A1xNlE9CLYxfxefrNOCSVU=;
        b=afBpTN5TJTvv/cIqqzzIjEdWhWNNYtioyjE5uzRB2+I7olp+06ZbRsUoR6maFaioMg
         B3o8DQ7Ibsqf8zuhrj6XHZMCSTZO/yMEKQAb9mRmGvyv4Uuy7diIaMNi9eGyu2BPWy7U
         02O2HkO2Vd24Ks/WKgrT/BiwbZ7/6uAgtlVGb2Lc/VmNESdHt4gWPANfCcRimn4skBvA
         npOYBPGivpfDwK5zv40NeyHtWkyMlDMUfYWvGFsjF3HnmQzk+0Rij5R3chMl8ODumT8f
         M/s/cCwpK/bDsy11Y98rR6IFpUO231L2UZr41q5Em2LTZcMv5bGJMqdNviKH1yfpcygk
         Lc6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729503404; x=1730108204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SaA6MjCnzEXGANWWWWPr9A1xNlE9CLYxfxefrNOCSVU=;
        b=G3UJLlviVRcmTlRM80hCnco+kykX9OqVYoN1l4TgTr5JKOfIQ2fnWOgjjEUxZTXGDB
         MBjzAp5mVacvHGDSEHUCRlV4OgwxMTtW47Gkg895XX5b7BP6nTuiaBCXpIo/5b8ntBOU
         f1HKGOu8tcEJw4YFgGdRONg2GOviybM/s2YxTVZjcO42AtUxy2RKzFezwCOrL7UXAnx1
         wGZART6E1DenUsN2DcZw6JuZGzBdsbFQTRmC2+SwNifg6TJYWcAToLfBUb97XWgU8eq9
         OwtaTL8hC1rPOTGv2D3hhUL/ItaabYjF0sE+t1VVjJJi8/d0IgpsFeJ/RbbSjzMxO0Kw
         egNA==
X-Forwarded-Encrypted: i=1; AJvYcCW7r0WfXI8oP+ekacxg96OH70g+wG3Awm5pkKH5CsqCpVpH2G5+lq2/Jc/3pDTJKREj/Zg3A0cbZUrY0ZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiJrs+ii3HO+ESkSEJGpxklXHfgXeDj4KJ+XTbk9qGNKX7TrAR
	ljRrpGn0/36dPesk/dPEqnc2k9ycRyb5XDM/uaX3sDUcN7Ge0Qrnu32fgpEjV+PScIqxdOe01Pz
	uewgp1a4/2Z1x2aqgfHt6dx/KhwN7JJhiqr2XVQ==
X-Google-Smtp-Source: AGHT+IGyxR3KLXD9voqeo0vrfplP7ht0srAq44lPfCneecMz/dqpegZprFIjW8SGAe3Y3LLv9qb/Gh5UmbrPs+b5/wU=
X-Received: by 2002:a05:6512:3a8d:b0:539:e510:d83f with SMTP id
 2adb3069b0e04-53a1520be23mr4815698e87.5.1729503403651; Mon, 21 Oct 2024
 02:36:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021091417.37796-1-brgl@bgdev.pl> <2024102113-shame-mooned-4f1b@gregkh>
In-Reply-To: <2024102113-shame-mooned-4f1b@gregkh>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 21 Oct 2024 11:36:32 +0200
Message-ID: <CAMRc=Mc0Qg9GkUsU-7QYPPQ-isZniABWYxtGLQ5KW1TAuZSA-A@mail.gmail.com>
Subject: Re: [PATCH] lib: string_helpers: fix potential snprintf() output truncation
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 11:34=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Mon, Oct 21, 2024 at 11:14:17AM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > The output of ".%03u" with the unsigned int in range [0, 4294966295] ma=
y
> > get truncated if the target buffer is not 12 bytes.
> >
> > Fixes: 3c9f3681d0b4 ("[SCSI] lib: add generic helper to print sizes rou=
nded to the correct SI range")
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  lib/string_helpers.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Hi,
>
> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> a patch that has triggered this response.  He used to manually respond
> to these common problems, but in order to save his sanity (he kept
> writing the same thing over and over, yet to different people), I was
> created.  Hopefully you will not take offence and will fix the problem
> in your patch and resubmit it so that it can be accepted into the Linux
> kernel tree.
>
> You are receiving this message because of the following common error(s)
> as indicated below:
>
> - You have marked a patch with a "Fixes:" tag for a commit that is in an
>   older released kernel, yet you do not have a cc: stable line in the
>   signed-off-by area at all, which means that the patch will not be
>   applied to any older kernel releases.  To properly fix this, please
>   follow the documented rules in the
>   Documentation/process/stable-kernel-rules.rst file for how to resolve
>   this.
>
> If you wish to discuss this problem further, or you have questions about
> how to resolve this issue, please feel free to respond to this email and
> Greg will reply once he has dug out from the pending patches received
> from other developers.
>
> thanks,
>
> greg k-h's patch email bot

Did something change? I typically don't add Cc: stable@vger.kernel.org
to the fixes I send and this is the first time I'm getting this email.

I can resend of course.

Bart

