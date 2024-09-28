Return-Path: <linux-kernel+bounces-342311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D98C8988D81
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 04:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0FC61C212B9
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 02:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96EF1B285;
	Sat, 28 Sep 2024 02:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fk8ZqjlJ"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FE81804F;
	Sat, 28 Sep 2024 02:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727489700; cv=none; b=NeYAQu5KbMNCFOIw3JzzRST4hiVd+/wa0qbhWB0QLrX/XgxSGEAhMQOYOvS4M6VU0B+SMwQRzufICB5QE9/f4z0WeTyxEuAlzPHQQtL1ASISoEYBd29HyzmmlB7fxrmqZp7ypsHqxGwCjKLtt6bKF6R6CHROhcL+w10qe1D+fE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727489700; c=relaxed/simple;
	bh=0N9z9QkdKLDNcbh5vPuhtWxnbaagBATs4qiwqABmrFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FUHQ8KCUezBG4fLByPDwq5SIJo/BTZoHHe1d6dPhX9aC2PIczs3/ELSUcytdH9jKsAu+D/J7LNzoQ83jkjRPRMnza2f403hzcbZm+zQEC0aoCpxsRc1fiPcbqLTMBCVHf1ghiDbaTYhefgI8zGzZyrxZDkUtI19s0+TD1DgXLPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fk8ZqjlJ; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71c5df16b10so851522b3a.0;
        Fri, 27 Sep 2024 19:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727489698; x=1728094498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wqrgAdB0rZN+RLFsmGURscFhnQ+qvKVFVUuv62yRYuE=;
        b=fk8ZqjlJ3v2snZgDELStBvFRPTjvO2gNz9Lpf0EoMnnf03AWQIwc5A7br2BzSTU+vB
         66LKZlPN5/71IP1C8V4Ddt0AZRLUpOIuEw92qx+NKUmTHJrQzGoT5sqTLHNnXf12WgoU
         Rl47Vvd/hf92SWMGb8gaB6Kk2U1iDG0wReMxc9DW7uOHwEZmxQszJppjtCOmFFFPmJ5H
         4loyWQVmKeWFW4UWSzS/lixsOt3xH0/NRcFQ45iQ14+wrxc+68XZfD7iBesFLFRLW09s
         xpy2B6ksqY2sMVkYhOi1OGaLCA3/l73MCsCaBeyuscuJ0n6mnfRcxVVuvGUe1dSVPzE7
         7sUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727489698; x=1728094498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wqrgAdB0rZN+RLFsmGURscFhnQ+qvKVFVUuv62yRYuE=;
        b=cOZ/r0ck2xurJ0K7MasLdeibYIstea6NKWR5oUaB2NF67gdzgiA79YwOd8sjS69XgG
         8nsudQJzy3Meyom2RHfAdGXE47LMzHer8F5HsbS/3QjMZvs1mdwBq7Ort/eqxfXbSaG+
         avuWqXiLGpcMDj6B+Z96T9YnkDnq8ZrSscI+g/hJu8cOnoVZvMdSX0qzNP49lwGouo4l
         9jRQWEf88sl6LAGjgJHRZ1E+vCZ2dhUWUVbHAvng79WDY++x5Gh4SWIto/UyZ5JrcJCR
         A+L2izSRJsg7KsC1hh/x38xKCXNcVQRMF0MubhgncTtlevTOEeDg5j3TwBiUy5rbh1Ij
         zR7g==
X-Forwarded-Encrypted: i=1; AJvYcCUvhwNOZN/g07puzgn9EPhJa1cpEANWSoc5zab6c4YEk8dQ4gNNCZ24OczaqASQhmn+Hkgk9pkO6OOFy4U=@vger.kernel.org, AJvYcCVXPkxs4UsKn6fy+KBabofxGGwsu/+Yrfhd4YwJWLgTbySc3SC5XqF94lXMXGrdX+jAR1fQJVPyGCPXaJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcV8u4zruL3D4jOZFQ74qFWOYH4Bt9yKski9hes9+JS8j4UxXC
	VZ+oOEXwPlxUvlQHdTQxwwKIwFSLBiETIroRu06sQ/2S/UZ1PF18
X-Google-Smtp-Source: AGHT+IHuTV7WYUUPQwB5pjr/BMdyWBPHJHV6WFyqQ8PRIEao1mkbuWDVSHjGDHU6SDAviEAnNHG2Cw==
X-Received: by 2002:a05:6a20:4393:b0:1cf:edad:3bc7 with SMTP id adf61e73a8af0-1d4fa639f28mr7601337637.7.1727489698047;
        Fri, 27 Sep 2024 19:14:58 -0700 (PDT)
Received: from embed-PC ([2401:4900:889d:8638:3e48:c969:47ab:86b2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db2928f7sm2312087a12.5.2024.09.27.19.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 19:14:57 -0700 (PDT)
Date: Sat, 28 Sep 2024 07:44:48 +0530
From: Abhishek Tamboli <abhishektamboli9@gmail.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: perex@perex.cz, tiwai@suse.com, kailang@realtek.com,
	sbinding@opensource.cirrus.com, simont@opensource.cirrus.com,
	josh@joshuagrisham.com, foss@athaariq.my.id,
	rf@opensource.cirrus.com, rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Add a quirk for HP Pavilion 15z-ec200
Message-ID: <ZvdmmIHsUjWq4bp/@embed-PC>
References: <20240926155112.8079-1-abhishektamboli9@gmail.com>
 <ad6b7073-4fcf-41f9-b6ff-e01bf7089017@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad6b7073-4fcf-41f9-b6ff-e01bf7089017@linuxfoundation.org>

Hi Shuah,
Thanks for the feedback.

On Thu, Sep 26, 2024 at 10:12:03AM -0600, Shuah Khan wrote:
> On 9/26/24 09:51, Abhishek Tamboli wrote:
> > Add the quirk for HP Pavilion Gaming laptop 15z-ec200 for
> > enabling the mute led. The fix apply the ALC285_FIXUP_HP_MUTE_LED
> > quirk for this model.
> 
> Were you able to test  this on HP Pavilion Gaming laptop? If so
> please add that to the change log.
The person who reported the bug confirmed that the patch resolved 
the issue on his device. 
For your reference: https://bugzilla.kernel.org/show_bug.cgi?id=219303

> > Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
> > ---
> >   sound/pci/hda/patch_realtek.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> > index 4ca66234e561..94125a977f08 100644
> > --- a/sound/pci/hda/patch_realtek.c
> > +++ b/sound/pci/hda/patch_realtek.c
> > @@ -10315,6 +10315,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
> >   	SND_PCI_QUIRK(0x103c, 0x8786, "HP OMEN 15", ALC285_FIXUP_HP_MUTE_LED),
> >   	SND_PCI_QUIRK(0x103c, 0x8787, "HP OMEN 15", ALC285_FIXUP_HP_MUTE_LED),
> >   	SND_PCI_QUIRK(0x103c, 0x8788, "HP OMEN 15", ALC285_FIXUP_HP_MUTE_LED),
> > +	SND_PCI_QUIRK(0x103c, 0x88DD, "HP Pavilion 15z-ec200", ALC285_FIXUP_HP_MUTE_LED),
> >   	SND_PCI_QUIRK(0x103c, 0x87b7, "HP Laptop 14-fq0xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
> >   	SND_PCI_QUIRK(0x103c, 0x87c8, "HP", ALC287_FIXUP_HP_GPIO_LED),
> >   	SND_PCI_QUIRK(0x103c, 0x87d3, "HP Laptop 15-gw0xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
> 
> Looks like this has been fixed:
> 
> https://lore.kernel.org/lkml/20220918171300.24693-1-dhould3@gmail.com/t/#m0c6aeebe5cc89c9a4228d49f56f4a0a4c516e012
No, this patch seems to be for the HP OMEN 16. 

Thanks,
Abhishek

