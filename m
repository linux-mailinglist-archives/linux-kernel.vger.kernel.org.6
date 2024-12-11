Return-Path: <linux-kernel+bounces-440958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4FE9EC712
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A928188C18D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 08:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021FE1D8E06;
	Wed, 11 Dec 2024 08:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dNquNOXT"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE1C1D88DC
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 08:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733905550; cv=none; b=aUeyVeCiHjNbieY27e+hwxIC/EPomj7kdn4BmY4DiljZLt4/AREUTsOp97wqLJSByp8hNDOdqrLxgc7sHHEJGryR2ov8tURtIXnwW3QLqccogkaQgQDA4Lvxwupt4KgJYK9PeVz7Qg1OzUrusknwoZxHwuNzhDFnq2HAA6wYswg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733905550; c=relaxed/simple;
	bh=pbxla0yTksNMB/yfJqiplYk5I6ztCJkCMOXdq941Wsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NiKrRUHlDXD23gJCtQAk3UnagLFuSY5ZrIKFvutkY2n4AHfyLVWgvUvSyCXz1ulKfeEw/QPBWkUqT554wuUGFQ952m+Bh+T9NgO176UYeS/Qm1YnMMACiQrfYbjALdfmdohekgzLPFWH1tU5IZda3fk9KmZxjennMo1rgToKSMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dNquNOXT; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-725f4623df7so2745097b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 00:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733905548; x=1734510348; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aMeiDMRxTxRMOSHecISft1Z76qFjuaNBQ/+kSc1K3bY=;
        b=dNquNOXT+/SdX+Vo4fA5TC+vWQjSF5I67BlFst0C+KkeoS2hYPdweD3XpjM7qvgjoF
         s5ZPdo3BXovjdiLibt8aHHEh2WkI9lGjiGiBNJnVficOZuA+qBOQSYSqHDri/+SpqiCn
         7YsTrY7gblC7S/0Pym8BT+1hmwZYANZMCbxu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733905548; x=1734510348;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aMeiDMRxTxRMOSHecISft1Z76qFjuaNBQ/+kSc1K3bY=;
        b=vqmAF3XkQwTG3oj3r/u69uj12p1YTj8LhODGz7HfFMw3fKjJOn4OUVOE+QeUxgYpc5
         B/LFkxP7vrWhq3vsOewQm0kH+8/xmxOVOhk7oDz2G0vNr+XzF0aBRB9ioE/BeUim4DX8
         U5Gdap3o4hYFLvro3vSc7Av1jRqIYkdwGgdLrfQwoH7E5z+QQ/kKXrSlhOGjtf7nUxjT
         z/QZh4gO9g/zmEhT1zIFMPqo4HefDfXa+W/+s4Rfg2sidJpMpspOdNQzTUfD/+kUy6pu
         mCO7fkjVDqCWnfoUx4DZM31ZR53oosavQ2Rb0kAYEctSzpzkAbbUHTjp6/xG9Pn9Nqsk
         ne8Q==
X-Forwarded-Encrypted: i=1; AJvYcCULaTWZb5b7pw7KVQDVIPZU0krfEAmZXoXGEgMQ0F09KnBHqMsGrAyFlPExtjC4YWQAJ+s0KrU1C4fIaX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTL1GtYi3sfXrvPUi+tEZEMF4KAamXxtCGz8Jgl24ckevX2e+t
	LAHzGGHlIGOjLEoTvew+BY9FZ76pSfxLPGU1NfF68WTXx7u3ZZ3KeXO2ca6Eu6/rPPMSj/Nny8s
	=
X-Gm-Gg: ASbGncvx8EuUJA1ZSl1q8s9e9kL3mrVtPQA0BZCx97/lUFUwvE39BWNUfXbi1i2W6Lm
	Ql8qiOxLt+Sa3DYuzDOuarv1LvJ6gr62JX/0Ocw4qGcnJh7a/sE1x6QR1lzLsT6B/ftjStAt07Q
	xoVB7IL/0BDvKgCk9ftP7yf1wcrK5RvMXw4DRpoo33mdiwfoQqdihMybYF91afjhgbAIS0ShHsS
	lbl/Tujwj92LR7EvJcYdcsvLmnMthWdQRN+5zmgTJ0B00qAQFCkfbdwZb7YRsAgFgV1+g06FjrD
	LFZvg4YWWz8WPZi3
X-Google-Smtp-Source: AGHT+IHdoMteOErvkxYfCx+gl75QfkwI5eKMYqojcLIIfMm5lxb+nCxZIXqqkaEUxsJlnKdhBbNcIA==
X-Received: by 2002:a05:6a00:1a8f:b0:725:9608:67c0 with SMTP id d2e1a72fcca58-728ed47e49fmr3293862b3a.25.1733905547832;
        Wed, 11 Dec 2024 00:25:47 -0800 (PST)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com. [209.85.216.47])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725dad8ada1sm6936115b3a.140.2024.12.11.00.25.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 00:25:46 -0800 (PST)
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ee6dd1dd5eso5112480a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 00:25:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVOFJp+Nz8p33kTLth2ZOiQ0r4A2brNQ+3IFbOuRFGSrJ7eZFXrkAIOlpPq4sRWTsPZisOnWQ5MNr4J/JQ=@vger.kernel.org
X-Received: by 2002:a17:90b:1650:b0:2ee:a4f2:b311 with SMTP id
 98e67ed59e1d1-2f127f55cacmr3203942a91.8.1733905545661; Wed, 11 Dec 2024
 00:25:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
 <20241210-fix-ipu-v3-7-00e409c84a6c@chromium.org> <20241211091954.42a5c778@foz.lan>
In-Reply-To: <20241211091954.42a5c778@foz.lan>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 11 Dec 2024 09:25:33 +0100
X-Gmail-Original-Message-ID: <CANiDSCsHk+QbF3BtrFU8G3UOgZZjTbQf4RhwkYCr+BeFiTYrEg@mail.gmail.com>
X-Gm-Features: AZHOrDlU23tnNgp0likxdl9TeO5EWHsYT3mOqJQICrAuiOLJ0FM89Lhe827RLJA
Message-ID: <CANiDSCsHk+QbF3BtrFU8G3UOgZZjTbQf4RhwkYCr+BeFiTYrEg@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] media: ipu-bridge: Remove unneeded conditional compilations
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

[only Mauro]

On Wed, 11 Dec 2024 at 09:20, Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Em Tue, 10 Dec 2024 19:56:04 +0000
> Ricardo Ribalda <ribalda@chromium.org> escreveu:
>
> > The ACPI headers have introduced implementations for some of their
> > functions when the kernel is not configured with ACPI.
> >
> > Let's use them instead of our conditional compilation. It is easier to
> > maintain and less prone to errors.
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/pci/intel/ipu-bridge.c | 28 +++++-----------------------
> >  1 file changed, 5 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
> > index be82bc3e27d0..1db994338fdf 100644
> > --- a/drivers/media/pci/intel/ipu-bridge.c
> > +++ b/drivers/media/pci/intel/ipu-bridge.c
> > @@ -2,6 +2,7 @@
> >  /* Author: Dan Scally <djrscally@gmail.com> */
> >
> >  #include <linux/acpi.h>
> > +#include <acpi/acpi_bus.h>
> >  #include <linux/cleanup.h>
> >  #include <linux/device.h>
> >  #include <linux/i2c.h>
> > @@ -107,7 +108,6 @@ static const char * const ipu_vcm_types[] = {
> >       "lc898212axb",
> >  };
> >
> > -#if IS_ENABLED(CONFIG_ACPI)
> >  /*
> >   * Used to figure out IVSC acpi device by ipu_bridge_get_ivsc_acpi_dev()
> >   * instead of device and driver match to probe IVSC device.
> > @@ -127,11 +127,11 @@ static struct acpi_device *ipu_bridge_get_ivsc_acpi_dev(struct acpi_device *adev
> >               const struct acpi_device_id *acpi_id = &ivsc_acpi_ids[i];
> >               struct acpi_device *consumer, *ivsc_adev;
> >
> > -             acpi_handle handle = acpi_device_handle(adev);
> > +             acpi_handle handle = acpi_device_handle(ACPI_PTR(adev));
> >               for_each_acpi_dev_match(ivsc_adev, acpi_id->id, NULL, -1)
> >                       /* camera sensor depends on IVSC in DSDT if exist */
> >                       for_each_acpi_consumer_dev(ivsc_adev, consumer)
> > -                             if (consumer->handle == handle) {
> > +                             if (ACPI_PTR(consumer->handle) == handle) {
> >                                       acpi_dev_put(consumer);
> >                                       return ivsc_adev;
> >                               }
> > @@ -139,12 +139,6 @@ static struct acpi_device *ipu_bridge_get_ivsc_acpi_dev(struct acpi_device *adev
> >
> >       return NULL;
> >  }
> > -#else
> > -static struct acpi_device *ipu_bridge_get_ivsc_acpi_dev(struct acpi_device *adev)
> > -{
> > -     return NULL;
> > -}
> > -#endif
> >
> >  static int ipu_bridge_match_ivsc_dev(struct device *dev, const void *adev)
> >  {
> > @@ -261,9 +255,8 @@ static enum v4l2_fwnode_orientation ipu_bridge_parse_orientation(struct acpi_dev
> >       struct acpi_pld_info *pld = NULL;
> >       acpi_status status = AE_ERROR;
> >
> > -#if IS_ENABLED(CONFIG_ACPI)
> > -     status = acpi_get_physical_device_location(adev->handle, &pld);
> > -#endif
> > +     status = acpi_get_physical_device_location(ACPI_PTR(adev->handle),
> > +                                                &pld);
> >       if (ACPI_FAILURE(status)) {
> >               dev_warn(ADEV_DEV(adev), "_PLD call failed, using default orientation\n");
> >               return V4L2_FWNODE_ORIENTATION_EXTERNAL;
> > @@ -498,9 +491,7 @@ static void ipu_bridge_create_connection_swnodes(struct ipu_bridge *bridge,
> >       if (sensor->csi_dev) {
> >               const char *device_hid = "";
> >
> > -#if IS_ENABLED(CONFIG_ACPI)
> >               device_hid = acpi_device_hid(sensor->ivsc_adev);
> > -#endif
> >
> >               snprintf(sensor->ivsc_name, sizeof(sensor->ivsc_name), "%s-%u",
> >                        device_hid, sensor->link);
> > @@ -671,11 +662,7 @@ static int ipu_bridge_connect_sensor(const struct ipu_sensor_config *cfg,
> >       struct acpi_device *adev = NULL;
> >       int ret;
> >
> > -#if IS_ENABLED(CONFIG_ACPI)
> >       for_each_acpi_dev_match(adev, cfg->hid, NULL, -1) {
> > -#else
> > -     while (true) {
> > -#endif
> >               if (!ACPI_PTR(adev->status.enabled))
> >                       continue;
>
> Heh, that's what I pointed on patch 1: you don't need it there, as this
> will be handled on patch 2.
>
> >
> > @@ -768,15 +755,10 @@ static int ipu_bridge_ivsc_is_ready(void)
> >       unsigned int i;
> >
> >       for (i = 0; i < ARRAY_SIZE(ipu_supported_sensors); i++) {
> > -#if IS_ENABLED(CONFIG_ACPI)
> >               const struct ipu_sensor_config *cfg =
> >                       &ipu_supported_sensors[i];
> >
> >               for_each_acpi_dev_match(sensor_adev, cfg->hid, NULL, -1) {
> > -#else
> > -             while (false) {
> > -                     sensor_adev = NULL;
> > -#endif
> >                       if (!ACPI_PTR(sensor_adev->status.enabled))
> >                               continue;
> >
> >
>
> Considering that you drop patch 1, and keep the ACPI dependencies
> at the header, as proposed by patches 2-6:
>
> Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kerenel.org>
I will fix the typo in your email


>
> Thanks,
> Mauro



-- 
Ricardo Ribalda

