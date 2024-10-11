Return-Path: <linux-kernel+bounces-360678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F21999E02
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D87B71C21E37
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 07:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4D320A5EA;
	Fri, 11 Oct 2024 07:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FLR8Rw4A"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA6820A5D1
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 07:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728632055; cv=none; b=RRpAyOavPkFRZ/dhtuMi3C9VKFyOECLt9uP/zrhuTcuzbNFYHLrFeQQ6icpDa588dOoCzC2oaD7cB/D7MdSmgICmwGgc5IIYqIjSPSs/YitZqn+h8FfZSGXDLFE1m2ZEKMKyg6CcAr8bsS4IV+VE9KEOAak/9h3Yy0JKG61Gri0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728632055; c=relaxed/simple;
	bh=rYT4uQmVdXAeVfVgATTeY2o325ruc+Os/sSnMHYh3Wc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HKRsdOLNqf0DPNQF2h+ZDmJUgGMDGztNKD7ApyxvZuhW6nzdosGhArsaaHolf148BoA32TfnqdKZQSEWkM+V4juQXRqw7lzlMrAN0Lznkef9gtugeJqA6dX58CKVvI5isGlVXrJ+Ts4GShzrioWlOIdqlpmhp0lJ5m3UshrOAu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FLR8Rw4A; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5398c2e4118so3571e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 00:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728632052; x=1729236852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w2LlN4EC7rQinlo0QxLPVDYc259IxpJpbWsupslGt9A=;
        b=FLR8Rw4ALl+FCz1vTNG0cetrTSfvTNueFmU/Th8Q2kwUHxfmAta9ss6i3N8+zxcUFH
         YApQT0Ci2vwQ+8Jb1fCVbNLB2q+jZn9SZzgOXPvJujOEB/YC2cGVH+SoKtbhM1Cu86QW
         AB6pp6UGOVymA1mdgT8PoU37YNdCXxgbNHcs+8whKrPAAk13mTjN3xZ7/PP6kaYEsl/z
         aTgLTVHR1xHBWR49zJzafYWCX3HJbX3YZD8q0VjinI8XAGyKOdfSjx/g0M+FkpkL3bjE
         AgBBNcib9F/BWD3Zgyk43fXofCT6PycNQLELiA4j7kUzdDReaLD9lxobJXIvjNoKFSNh
         PeXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728632052; x=1729236852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w2LlN4EC7rQinlo0QxLPVDYc259IxpJpbWsupslGt9A=;
        b=dxBFKaej7FVRZ90p2MKRK35gEOPNMBojssJvThLtVGUCC06Oeq7KZudhgtYpnmByv4
         rwqf52m+CwwbEcjT7ESXOKSnY03VGWZI/mP1i2yoLJGLHUAa80OqbMjfEMVzmw+sjln0
         eBUbtuDmx5mwNewdYrKHF2SEtLwTW5/Lzf7x6D3WA6zhVwF40iIFbu46zeZfwGxC1Xn1
         aK2OdrhG13TP3tM8WL79Tbu9PWMm2hl91x7QaT0M0heRKkK3adGmZvobfCBKrSR2eOEv
         Gb102fi3SFMKHbv6q+uvth7zL/kt093VJsBzHFNspPmRj8EJDk9siccGnujjVP86Dl/e
         sD8g==
X-Forwarded-Encrypted: i=1; AJvYcCVjBju+Ns/rkXI7fI6rVVC+al/88s0P5OO+0DmjIWj+2gN4MxrSxPDJlM8H688vztk1RYc7tN50Gh18+FE=@vger.kernel.org
X-Gm-Message-State: AOJu0YypSHqlh4R7ylmYLkD7zEUH/Mxr2BxgJCDwpFdQFc8BoGDZc3fV
	5MVDtIGccyuIJJu441Fm/Q97NcTIm9hTv6AlQpnvmejwySvvzzlbeaeOM8FYIgnhX3Uj0TIIPNp
	cfctqh6DDOxRpMeJklvfOjgfkfhBaelKj7GED
X-Google-Smtp-Source: AGHT+IHQhl4J5Wh7IGTJOZT4LmbIcd39vxI77m6/dL7wtCxN0nNQ42YfEeKIZCEvsbYuTVna8itZPBncU6/toHIEuFM=
X-Received: by 2002:a05:6512:3f26:b0:533:49ab:780e with SMTP id
 2adb3069b0e04-539d6659c02mr55119e87.2.1728632052129; Fri, 11 Oct 2024
 00:34:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009054429.3970438-1-guanyulin@google.com>
 <20241009054429.3970438-6-guanyulin@google.com> <2024100931-blabber-wilder-1ad1@gregkh>
In-Reply-To: <2024100931-blabber-wilder-1ad1@gregkh>
From: Guan-Yu Lin <guanyulin@google.com>
Date: Fri, 11 Oct 2024 15:34:00 +0800
Message-ID: <CAOuDEK1RGgOTWF3ja+UaAYzMbDU0kJ0GQ7b+wjSQVjr1Fo=40A@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] usb: host: enable sideband transfer during system sleep
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Thinh.Nguyen@synopsys.com, mathias.nyman@intel.com, 
	stern@rowland.harvard.edu, elder@kernel.org, oneukum@suse.com, 
	yajun.deng@linux.dev, dianders@chromium.org, kekrby@gmail.com, perex@perex.cz, 
	tiwai@suse.com, tj@kernel.org, stanley_chang@realtek.com, 
	andreyknvl@gmail.com, christophe.jaillet@wanadoo.fr, 
	quic_jjohnson@quicinc.com, ricardo@marliere.net, grundler@chromium.org, 
	niko.mauno@vaisala.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, badhri@google.com, 
	albertccwang@google.com, quic_wcheng@quicinc.com, pumahsu@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 8:47=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Wed, Oct 09, 2024 at 05:42:59AM +0000, Guan-Yu Lin wrote:
> > @@ -1583,6 +1583,11 @@ int usb_suspend(struct device *dev, pm_message_t=
 msg)
> >       struct usb_device       *udev =3D to_usb_device(dev);
> >       int r;
> >
> > +     if (msg.event =3D=3D PM_EVENT_SUSPEND && usb_sideband_check(udev)=
) {
> > +             dev_info(dev, "device active, skip %s", __func__);
>
> When drivers work properly, they are quiet.  Why all of the loud
> shouting in this patch as it goes about it's business?
>
> also, __func__ is redundant in dev_*() calls :)
>
> thanks,
>
> greg k-h

Thanks for the suggestions. Let me switch to dev_dbg and remove
__func__ in the next patch.

Regards,
Guan-Yu

