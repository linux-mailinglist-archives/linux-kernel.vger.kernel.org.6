Return-Path: <linux-kernel+bounces-378838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 446E89AD627
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 23:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD56E1F23E96
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 21:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BA01FAC50;
	Wed, 23 Oct 2024 20:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b="ZQs9Umhy"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29F1200BA4
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 20:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729717192; cv=none; b=PJ1ADmx25NNG64bpHqEXxu5ST2Ij5gspNQD8ui+uQAsA3iuacIEWxRqU/jsfh/NrCyfYrq33EtVMfGwd9fcKnDpx49Nl3SYWvmthjg8arsjyhwtofGsEdwhX5AfcSViljNwrezUE1jVMlOsEObrZJzRgKouY4/8FPVEEVTWqnbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729717192; c=relaxed/simple;
	bh=TmutFJlUmdw0uYuqWKttwwFvJkpqSd7B7EwyjgnGLm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NGr0eaQdZQ+WHChe/yIBKTxXyM1xJ6b5gdwrPscjoq95dk/tQy1FMl34IFQJcJq2dWVSNws3Llbkve8Dfbk2IxCxFiq6TVlGzFpBvy3yuzPeoi9VJE97vEoDwM7G0ioVsI7z0TLLb2OMCHBIU7Zezovt6CkcZgY+JJJx3hU3guw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np; spf=pass smtp.mailfrom=everestkc.com.np; dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b=ZQs9Umhy; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everestkc.com.np
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37d49a7207cso107489f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 13:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc-com-np.20230601.gappssmtp.com; s=20230601; t=1729717186; x=1730321986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RqBQuVSIycI00hdpx3lR5ACuKRsYQWaJxf8hFYYXxOk=;
        b=ZQs9UmhyP5w5eImHzv6nBklBaN8oBLxDW8t6CojGL8L0v8qyFBrFG+2z/1OXkzsm2t
         zu46USKJuP4puRXWo1NkFCAXgmyzui5ASDEXqL5v+3wCqgveGh6nlMdcRPpPH3SlDo+M
         WbKHIQKHEnu5ZNLTBpm0bPH4JrwRZx84YZhfGJWD78W1h+YM4eYHmSSidWSn6cj3C4yd
         zV3p9QRMKlS97SkEl5oEnLOQtliAo3F9Y/SSSxnI+dK3pgqS3oTWQt3wj9ZBoE064q4S
         ApEdCws/9b2DqEYcMNYoqsWR2LZacOJ3wyBFqjwNGjqUyUtWO8TfBEp88QJnxu4cVjRC
         40nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729717186; x=1730321986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RqBQuVSIycI00hdpx3lR5ACuKRsYQWaJxf8hFYYXxOk=;
        b=k/aK8bhwfYKGxG6vDx3z0acyQErVi3/eHqxg1Q/DJip/nwyVXNdCMVRM40etrUAo+C
         nRLNdPjsDztf2fHGTOBzpYs1Zk0GTRIoZ+oZA8YKLIFDurE7ktfbFVZQWydMb7nYDw3+
         nhLROPZmtu0fdjYs67WcOSuTStHaMAkMzTFy+Wws6Rave1/Nwpn/FjpBxjmIA6asq2Tp
         y0YMQXV0fcGBOpgVOA75nhAuOn7hvqyIKM26l7t9dAqM56uHxfX2nmgtBHyvBm+0ZbhD
         HcpIEtDenmGMO48Koqvo5k5dQrj2Nc6mJSBx6XjDBgTkdRSxHqtigoV+470734frsDl+
         orpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWISqRLTnwYIZNpD8oumbwf1mFG+Kma+cmOh3bIK+1kEWwvnXWYylQhxTwRlcVY4Lb6XqK9NBNNgVpR+l8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzme76k5Mq20DJxoss3Mr6ICeaitWjplR3aNl69XIsnKG+o3EK3
	FgdwHvT9HUzViH+kxJhyHPloLRr0ABWo5wyDbudTBqqeD7nN6DPgjYCoGKwz9hLdThbNtwqW5kr
	gkN6s/qnvKPYhtlqGNswd8TuL1FVaDULnjohDLg==
X-Google-Smtp-Source: AGHT+IELL8lRAg7cArEXQHvrs//3nuGQjeroLsRRDAQdATMPf9GdpSIb/13x+Z9wrbZRpZVIDhudm8c3MtPuKR4g+mo=
X-Received: by 2002:a5d:5b92:0:b0:37d:43f1:57fd with SMTP id
 ffacd0b85a97d-37efcef528emr2325118f8f.6.1729717185866; Wed, 23 Oct 2024
 13:59:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010165801.3913-1-everestkc@everestkc.com.np> <ZxlYbVOLPQv-oWrv@intel.com>
In-Reply-To: <ZxlYbVOLPQv-oWrv@intel.com>
From: "Everest K.C." <everestkc@everestkc.com.np>
Date: Wed, 23 Oct 2024 14:59:34 -0600
Message-ID: <CAEO-vhGzRxths0OG_MJEPqocyQ5C0hDXvJRWfYYv74qnCbCVCg@mail.gmail.com>
Subject: Re: [PATCH V4] drm/xe/guc: Fix dereference before NULL check
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: lucas.demarchi@intel.com, thomas.hellstrom@linux.intel.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, skhan@linuxfoundation.org, 
	dan.carpenter@linaro.org, michal.wajdeczko@intel.com, 
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 2:11=E2=80=AFPM Rodrigo Vivi <rodrigo.vivi@intel.co=
m> wrote:
>
> On Thu, Oct 10, 2024 at 10:57:59AM -0600, Everest K.C. wrote:
> > The pointer list->list is dereferenced before the NULL check.
> > Fix this by moving the NULL check outside the for loop, so that
> > the check is performed before the dereferencing.
> > The list->list pointer cannot be NULL so this has no effect on runtime.
> > It's just a correctness issue.
> >
> > This issue was reported by Coverity Scan.
> > https://scan7.scan.coverity.com/#/project-view/51525/11354?selectedIssu=
e=3D1600335
> >
> > Fixes: 0f1fdf559225 ("drm/xe/guc: Save manual engine capture into captu=
re list")
> > Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
> > Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> > V3 -> V4: - Corrected the Fixes tag
> >           - Added Reviewed-by tag
>
> For some reason it looks like nor CI nor lore has this v4 version.
Yeah, I just checked that and it's something strange.
> could you please resubmit it?
Yes, let me send it right away.
> > V2 -> V3: - Changed Null to NULL in the changelog
> >           - Corrected typo in the changelong
> >           - Added more description to the changelong
> >         - Fixed the link for Coverity Report
> >         - Removed the space after the Fixes tag
> > V1 -> V2: - Combined the `!list->list` check in preexisting if statemen=
t
> >         - Added Fixes tag
> >         - Added the link to the Coverity Scan report
> >
> >  drivers/gpu/drm/xe/xe_guc_capture.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/xe/xe_guc_capture.c b/drivers/gpu/drm/xe/x=
e_guc_capture.c
> > index 41262bda20ed..947c3a6d0e5a 100644
> > --- a/drivers/gpu/drm/xe/xe_guc_capture.c
> > +++ b/drivers/gpu/drm/xe/xe_guc_capture.c
> > @@ -1531,7 +1531,7 @@ read_reg_to_node(struct xe_hw_engine *hwe, const =
struct __guc_mmio_reg_descr_gro
> >  {
> >       int i;
> >
> > -     if (!list || list->num_regs =3D=3D 0)
> > +     if (!list || !list->list || list->num_regs =3D=3D 0)
> >               return;
> >
> >       if (!regs)
> > @@ -1541,9 +1541,6 @@ read_reg_to_node(struct xe_hw_engine *hwe, const =
struct __guc_mmio_reg_descr_gro
> >               struct __guc_mmio_reg_descr desc =3D list->list[i];
> >               u32 value;
> >
> > -             if (!list->list)
> > -                     return;
> > -
> >               if (list->type =3D=3D GUC_STATE_CAPTURE_TYPE_ENGINE_INSTA=
NCE) {
> >                       value =3D xe_hw_engine_mmio_read32(hwe, desc.reg)=
;
> >               } else {
> > --
> > 2.43.0
> >

With Regards,
Everest K C

