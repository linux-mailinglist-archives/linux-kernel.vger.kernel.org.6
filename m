Return-Path: <linux-kernel+bounces-351561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 435FB99131A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 01:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B204282593
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 23:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC11155301;
	Fri,  4 Oct 2024 23:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GX5T5NDW"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FF114E2C2
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 23:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728084944; cv=none; b=HhvaolDmGC7tzygo64oXr+RdkIvXoYXOhikiY4LkJjS3o7+mhCT5h0Gb88SOWI5RgeS3QgTvNGtGk+GpAjg+SPpkw+c1tO29xnBkddkufLNYPRkE0y357OAw6Ie34irjAR7P7nm7D6fahf82V54BGI4OHXit34ThPQGlxM6nv8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728084944; c=relaxed/simple;
	bh=TJWsV+qKaw7VQCBA5KTrr1eddmxWHeeUvwOdqC1q1aE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Urx0EKTozj/alnCGN7J4er/YJQCsA+llZpVTudxQrKo5H1mKGwOXZGqrwum2Zx3wC4NhWtEX4Wo3TfzDoFtwswD/BnqhOnl9MstlDEdCdvI+Kt2wfsqhlkJ5CH4evyKZlWKLk2uyUN6XyCJL9tIneNpozTklKmv/V4eTzZPbXoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GX5T5NDW; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c896b9b3e1so3454179a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 16:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728084941; x=1728689741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xHK0D1s9Qo1IqE2HKTU0otYR/E6L/9tQTdG+2dwbQok=;
        b=GX5T5NDWroSH36/kWzhrKKa9XU8rgmYQfKrAkb4jXN++N7wkocm6S8A5W0crqFRwKt
         m5iBiUTQRmi+HQk+ZdKky00reP2RrnEMduOuA3M9G8V33+DB2qPkKtY24KG17YPxvTRE
         fxFNtggaY+p+hTJJ3IX0NlMW2ZR+FGbtJm7dIqvLKFH/a7BaVImhwHjvdMrjVusZgvJ0
         FGzWhSDaLeHSohOAJcMPIV7Na9a6NaybGMM/iP+uVpgQ49wWPsDz+vQQQE54QqIjcJy9
         W3e2EbZmpPNQjYAweBNIYMsru0QqSPgWRloRLt61DxSXPUd1f57V81Op2cbu37FPJJNe
         Fdtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728084941; x=1728689741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xHK0D1s9Qo1IqE2HKTU0otYR/E6L/9tQTdG+2dwbQok=;
        b=VRPW+a0eXIkr3yWntwNqDBk+xviDIZyxhQYlu1IU6IQ0+eqyUUVfngdyl01DLcTtqL
         JxgQB/pz58z6E8bk9dS+nSkxrQTEarf4jU8jmeDqNoMSSDUSRvc2OxkYzhG3yF8NXYAW
         Yx482ilkCbD69FkUX6eLjaX3HcqoXqiuve1r8wsTFZdSdILOlxpIEKvdEznIKd/NtY7B
         jjlcaj3WPoCcLFh7IO/21IRmISuJPjq29YlcQGtfdHwHzRu6bMjo4J7Ehugm81wHs1V9
         GUuvUiejDx+Pdg9A98dIkdG3ANYfZgEQTPs6lj4jJHb8H90kSr9AZZT8MqZyRvZJqAzS
         z62A==
X-Forwarded-Encrypted: i=1; AJvYcCXmg6on2/jROf+WwTAJpSCVR4VNqfIZpjptvA90bFMAClHBg9z3f1c1CiphT14yYxiMuTZDzsvWMLYPTbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNOBdtWBGQhLfJrP0GGfKeOt/bqxqE5baV4sbwWGSxZZDxdIV5
	aMFdfCigmHVrIbBSL4fwFNGnNNcGr8DmwcnkZZ9oEiJ2VY3QkkpokVg8m3O6F4zXBGzdLzYun4M
	BIIPT1iywBkFuEygM3xvREJRxmeY=
X-Google-Smtp-Source: AGHT+IGPfIHH+Zp5Rrnp/4cdlv7+ntavMlTz4b8lvAgp1HxlYv3oA5g7pPdRzZ2UO6t4p9o6uvu5sZ7C/5KdcLit40Y=
X-Received: by 2002:a05:6402:2709:b0:5c8:9722:f9d1 with SMTP id
 4fb4d7f45d1cf-5c8d2dfdba7mr2858346a12.5.1728084940798; Fri, 04 Oct 2024
 16:35:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004034131.1363813-1-CFSworks@gmail.com> <20241004034131.1363813-2-CFSworks@gmail.com>
 <d8e12243-20d2-4a37-92d1-df6b9b32dc63@broadcom.com>
In-Reply-To: <d8e12243-20d2-4a37-92d1-df6b9b32dc63@broadcom.com>
From: Sam Edwards <cfsworks@gmail.com>
Date: Fri, 4 Oct 2024 16:35:29 -0700
Message-ID: <CAH5Ym4jTidgY9MdWzHN1=30DpOSUKf_h8nXBw21XR1VFuXn6fw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] phy: usb: Fix missing elements in BCM4908 USB init array
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Justin Chen <justin.chen@broadcom.com>, Al Cooper <alcooperx@gmail.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 9:14=E2=80=AFAM Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
> On 10/3/24 20:41, Sam Edwards wrote:
> > The Broadcom USB PHY driver contains a lookup table
> > (`reg_bits_map_tables`) to resolve register bitmaps unique to certain
> > versions of the USB PHY as found in various Broadcom chip families. A
> > recent commit (see 'fixes' tag) introduced two new elements to each chi=
p
> > family in this table -- except for one: BCM4908. This resulted in the
> > xHCI controller not being initialized correctly, causing a panic on
> > boot.
>
> Yes, I think I see what happened here, we took the patch in the "fixes"
> tag from the our downstream tree, and it applied just fine, we will keep
> a closer eye on other entries in the future.
>
> >
> > The next patch will update this table to use designated initializers in
> > order to prevent this from happening again. For now, just add back the
> > missing array elements to resolve the regression.
>
> Out of curiosity, can you check whether building with
> -Wmissing-field-initializers would have caught this?

It appears that the answer is no, at least here on Clang. I also just
tried -Wextra to see if any warning would catch it and didn't see one.
My understanding is that -Wmissing-field-initializers is for struct
fields, and a construct like:
int array[3] =3D {1, 2};
...does not result in a warning because it's considered perfectly
valid standards-compliant C per C's default initialization rule.

Cheers,
Sam

>
> >
> > Fixes: 4536fe9640b6 ("phy: usb: suppress OC condition for 7439b2")
> > Signed-off-by: Sam Edwards <CFSworks@gmail.com>
>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
>
> > ---
> >   drivers/phy/broadcom/phy-brcm-usb-init.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/phy/broadcom/phy-brcm-usb-init.c b/drivers/phy/bro=
adcom/phy-brcm-usb-init.c
> > index 39536b6d96a9..5ebb3a616115 100644
> > --- a/drivers/phy/broadcom/phy-brcm-usb-init.c
> > +++ b/drivers/phy/broadcom/phy-brcm-usb-init.c
> > @@ -220,6 +220,8 @@ usb_reg_bits_map_table[BRCM_FAMILY_COUNT][USB_CTRL_=
SELECTOR_COUNT] =3D {
> >               0, /* USB_CTRL_SETUP_SCB2_EN_MASK */
> >               0, /* USB_CTRL_SETUP_SS_EHCI64BIT_EN_MASK */
> >               0, /* USB_CTRL_SETUP_STRAP_IPP_SEL_MASK */
> > +             0, /* USB_CTRL_SETUP_OC3_DISABLE_PORT0_MASK */
> > +             0, /* USB_CTRL_SETUP_OC3_DISABLE_PORT1_MASK */
> >               0, /* USB_CTRL_SETUP_OC3_DISABLE_MASK */
> >               0, /* USB_CTRL_PLL_CTL_PLL_IDDQ_PWRDN_MASK */
> >               0, /* USB_CTRL_USB_PM_BDC_SOFT_RESETB_MASK */
>
>
> --
> Florian

