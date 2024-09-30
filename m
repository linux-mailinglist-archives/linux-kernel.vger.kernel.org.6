Return-Path: <linux-kernel+bounces-344285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D219598A7CF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 16:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A3A41F24899
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 14:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6734F198824;
	Mon, 30 Sep 2024 14:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gon3XZ66"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC61194C9D;
	Mon, 30 Sep 2024 14:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727707888; cv=none; b=j4bP0vHMbVVhFbIj4wqMnbLjQM0IaZstWEytqEB3/OWzaKMYQLQLBzsm5ZKdX9/FEGjj6vWafyA7Xmwz4Y6+C08CD35gZJrKehAKBdHj5olhHogppd3gZ7B4knJ6ljswMkhxRHJp5wodIjNUdDUuPyqzPw2I6OfnewMJgqN97c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727707888; c=relaxed/simple;
	bh=iq44ZSPXoH3DWyrORw+RLql2YfSaOsPWaY/yPc6+sr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+1ovXkRkCM7InrKRdd1/xDcuIg58eLmooE1/9nOZaw9ixX/6/3q2I0tpuryRKTarqHwTa9IzRMoGGty+li4QHDtVH74k1UX3Pp8ju6KVOaOoIyhgqxuFxx9COg8Lh2GNVZ2ln4NoV7vHIln+eUbUdljTEb8wCWwtswGpRiH+BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gon3XZ66; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7c1324be8easo4129096a12.1;
        Mon, 30 Sep 2024 07:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727707887; x=1728312687; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6x7ZALWOWCmXqdia15jd3S0YfQVz65PAFjVKeDGN2pU=;
        b=Gon3XZ66UaXaMyX774MVzvokF0rYDLhG3QOj46trxpi8eGFNSUsgWzQpZwOkucKcOV
         sK/wZYj7d3OBrPAavBYg7amHrcnasoCd8lzQORmsb/xaIsnDJrojGigel8D4Wfm8JMc8
         2BdMRgZxw/a3YNrQ38U5tEX+AAEOPZrgQgjiJFee8f3DZ6eMUlVvUGZRteNl/9S/3em7
         H1Rfvqywc8n9s5OK8BYfr1UlTOYmT5/X+Y/RDitbLEdCOrlgxHx8G9JxObCp0sWCcMm+
         CunHjWdhqXV+GAxgrwmHISoa17tpdKqFN4dXXTaDef03CffcTESDs4UBNlYC1sWGiWXl
         Pg3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727707887; x=1728312687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6x7ZALWOWCmXqdia15jd3S0YfQVz65PAFjVKeDGN2pU=;
        b=mTu4am8Yka4EmmQlmjByUSQ6DAQl9G4dEdVPsr9U0tOem0zW7hgzAJEyxwmMZwqtE4
         /W3vpcL/lmnDTO0FSlWtRvotPmXS897knx/AAbOxLoUaFojxZPHw+KmPt31H+SXGhGa9
         Tdd5IG+fIibFM1GEvlBVq7ndqXKoyNundWTK2XJPrrP1KbfE4xAHQTC7BpzQ/a2pnLnk
         PKbCPPxheowcJZTpoSaWpeJc7aZy+Z05WsZz5dqMEKWNlB2NoQZKGLKAF3C92YjzawEU
         q5Jzv/cfSsJFd1b+NlVolZ+tyYzpv+4c9GlQI7LbWXJEJdOhxFoNB8hvYUF3WmNXHL4a
         j1wQ==
X-Forwarded-Encrypted: i=1; AJvYcCU70F339WiO4jb2lvrQhqTFqk4EJ8HUq1GdpYsAsqsE1nPGGOE4FCurm+AsyMkNktHURZ2Xm8E14DSHL6o=@vger.kernel.org, AJvYcCXHA6aOUG02BpNuszE1/03fppqfp4ZHgNMx4AcVJSxtdn2YpVBvSEDmX2JpW3t53Cg9+7TXwtRvTUA8je0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzraia323vgeFyMMUmDU7+OESUcYTBKjFUtrHyYx8IgQgeJ5GPk
	pDc3O+HBp1oCpntR6kwMn2HehlL5ABWIIuZeT91cz/dGs6ZnpMaS
X-Google-Smtp-Source: AGHT+IHAhBDFglodz8Nwr8B8VPwGdmfLW6SddjDxnpRkxHHCt05UUbtuwZUux6z3aTbifAeKmwt5+Q==
X-Received: by 2002:a17:90a:8d12:b0:2d8:a943:87d1 with SMTP id 98e67ed59e1d1-2e09121b4c9mr24030612a91.13.1727707886389;
        Mon, 30 Sep 2024 07:51:26 -0700 (PDT)
Received: from embed-PC ([2401:4900:1c26:3294:a303:135d:2d56:fd2e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e0b6e2a53dsm7988225a91.55.2024.09.30.07.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 07:51:25 -0700 (PDT)
Date: Mon, 30 Sep 2024 20:21:17 +0530
From: Abhishek Tamboli <abhishektamboli9@gmail.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: perex@perex.cz, tiwai@suse.com, kailang@realtek.com,
	sbinding@opensource.cirrus.com, simont@opensource.cirrus.com,
	josh@joshuagrisham.com, foss@athaariq.my.id,
	rf@opensource.cirrus.com, skhan@linuxfoundation.org,
	rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Add a quirk for HP Pavilion 15z-ec200
Message-ID: <Zvq65ccNr9L27BEq@embed-PC>
References: <20240926155112.8079-1-abhishektamboli9@gmail.com>
 <878qv9k1gh.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878qv9k1gh.wl-tiwai@suse.de>

Hi Takashi,
Thanks for the feedback.

On Mon, Sep 30, 2024 at 10:09:02AM +0200, Takashi Iwai wrote:
> On Thu, 26 Sep 2024 17:51:12 +0200,
> Abhishek Tamboli wrote:
> > 
> > Add the quirk for HP Pavilion Gaming laptop 15z-ec200 for
> > enabling the mute led. The fix apply the ALC285_FIXUP_HP_MUTE_LED
> > quirk for this model.
> > 
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=219303
> > 
> > Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
> > ---
> >  sound/pci/hda/patch_realtek.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> > index 4ca66234e561..94125a977f08 100644
> > --- a/sound/pci/hda/patch_realtek.c
> > +++ b/sound/pci/hda/patch_realtek.c
> > @@ -10315,6 +10315,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
> >  	SND_PCI_QUIRK(0x103c, 0x8786, "HP OMEN 15", ALC285_FIXUP_HP_MUTE_LED),
> >  	SND_PCI_QUIRK(0x103c, 0x8787, "HP OMEN 15", ALC285_FIXUP_HP_MUTE_LED),
> >  	SND_PCI_QUIRK(0x103c, 0x8788, "HP OMEN 15", ALC285_FIXUP_HP_MUTE_LED),
> > +	SND_PCI_QUIRK(0x103c, 0x88DD, "HP Pavilion 15z-ec200", ALC285_FIXUP_HP_MUTE_LED),
> >  	SND_PCI_QUIRK(0x103c, 0x87b7, "HP Laptop 14-fq0xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
> >  	SND_PCI_QUIRK(0x103c, 0x87c8, "HP", ALC287_FIXUP_HP_GPIO_LED),
> >  	SND_PCI_QUIRK(0x103c, 0x87d3, "HP Laptop 15-gw0xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
> 
> The quirk table is sorted in PCI SSID order.  Could you try to put at
> the right position?
Ok I will put it in the order.
> Also, please use lower letters for the hex numbers there.
Sure.

Thanks,
Abhishek


