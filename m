Return-Path: <linux-kernel+bounces-205582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F16458FFDC2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B0771F231F1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 08:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A9115AD99;
	Fri,  7 Jun 2024 08:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuJEPIG4"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1FA15A872;
	Fri,  7 Jun 2024 08:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717747488; cv=none; b=SWYHz7+Hf5sm16c3aP9VQzXwgOWNgz6KbpKRlRoDwJUQKvx8UcOqWeY9t38GM1je2E5RqbxKASEaiTxkVLyfo520vf4fJvmZNLwidPlLXs16UuXY4ls7xNdOyT624e/OgN4V3XoK2zssuGs2bQrQBjmWO4fCREp3ils8x2dDPQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717747488; c=relaxed/simple;
	bh=iRk1YNV1eMtLeNp3Te4u3uEFiIR1fWxkiAtwTd6JHN4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=G4bCfYXnlvLsSRWtw/S0tqpcHSsLlFq+gp+rvde8ufU6qtwoTPMCV+TBWjVt2W4JjtqEqRQKRq7tfFaXrDofYMul5aKGxAI7MrK5mhQiuGd2Hb1uHT5xGjK/uNPKjOsM8kcRjcctn8Nve4mncXYB4EOE0T+X3ojM7CP+tkauThM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TuJEPIG4; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a6c8537bfa0so194422666b.3;
        Fri, 07 Jun 2024 01:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717747485; x=1718352285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vHTEB/VzVlwsDqiMfVQQnNEOGkiSg21MmPi/eavWhB0=;
        b=TuJEPIG48RSCeddpQYxijJ0YK8sXDjZSObewldM0tCyUSxE5nUiglO138FThAsURPL
         BxWSXqHe1qaxW7OGj4phmX2d2JS1lwyM9keWz6BucVPdIaSMgHI6i9kBtt8La+cL2Mvj
         6EIOgcW6MI/KNwkyYrXAYMfVC7872WO7jEMnpNVTRv1ESkDU5CoOHv4GchiCiW7zbasF
         Z4LUn2RSo1mbcHwGtF5JuuQ1DRdxGxmncprkXCMgBWqztUsTxVtmNb1zzZgn/rN8zeUw
         aph/kGx86xgAfRthRvLfZ2qfG0cYNCUw10QTBbSCIosifbsd5RY2z2KlNBdwx5FD1YzU
         i/Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717747485; x=1718352285;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vHTEB/VzVlwsDqiMfVQQnNEOGkiSg21MmPi/eavWhB0=;
        b=qgdL1u7a00Vm9Dr1MNPvQib+iVNmSu4QpDPA11smAp/7dxLBlG7lSBYt0+sOwuG3M8
         kRXD6xjOednHofsof7I1791O9YxHLfybGLDM9gDjlbJ/F1b5x54zncmRcV9SA6lmkDbG
         6DW89fPJNaNS4a9PZMobzEKQP0NSGPIRXQTQBiA8rWRnZjE0rhXrh++EsWyKSBil1NOw
         f4m4iySTxuHYHGqRQaa+jr97nfmRhxArIhECLvWdXDURpszBro0eSurXWpie6Mdtf383
         9TeEMFchfsXBsw9UTZiyTKD6kYRmMrjJyBgQIkVy4U+9SsBknm2wCUzcS9egcDO6X/nI
         379g==
X-Forwarded-Encrypted: i=1; AJvYcCXVXqMQEjixJBayi3g3obomIekZJGmyNB6rjXfSbv28H68vYBxoeZKLaYzoirYzEcHxzp7RToI1VvD9Y3kuAtC3m7Be8Q5UU6AHx0IvBmdyIa+ShyxwWfQX55fMPqRnSn0vZgfFz6MI+g8=
X-Gm-Message-State: AOJu0Yx+AhqXAWD/mnWo50/YmVnTEZbGY8hL26empFpe4//AC29cUKO/
	xR55AzFqGX+ub4Wjbb7Y7+sE3GucQuE2M3AlxED1aCbi5LQOsPEn
X-Google-Smtp-Source: AGHT+IExgnAQUcrdORoGg6TV/9qPh9JBwUAmzwB2cHbzIem0i3Xhw9fMo2vk9TjEW4CIT6IHMAkpMg==
X-Received: by 2002:a17:907:7211:b0:a6e:a97c:fc9a with SMTP id a640c23a62f3a-a6ea97cfd20mr31412166b.8.1717747485112;
        Fri, 07 Jun 2024 01:04:45 -0700 (PDT)
Received: from localhost (host-95-246-50-43.retail.telecomitalia.it. [95.246.50.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c84aa8351sm183122066b.142.2024.06.07.01.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 01:04:44 -0700 (PDT)
Date: Fri, 07 Jun 2024 10:04:43 +0200
From: Matteo Martelli <matteomartelli3@gmail.com>
To: Maxime Ripard <mripard@kernel.org>, 
 Matteo Martelli <matteomartelli3@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, 
 Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Marcus Cooper <codekipper@gmail.com>, 
 =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>, 
 linux-sound@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org
Message-ID: <6662bf1b61bbc_2f51737023@njaxe.notmuch>
In-Reply-To: <20240606-savvy-wallaby-of-champagne-d4a50e@houat>
References: <20240529140658.180966-2-matteomartelli3@gmail.com>
 <20240529140658.180966-3-matteomartelli3@gmail.com>
 <20240606-savvy-wallaby-of-champagne-d4a50e@houat>
Subject: Re: [PATCH 1/1] ASoC: sunxi: sun4i-i2s: fix LRCLK polarity in i2s
 mode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Maxime Ripard wrote:
> > -	/*
> > -	 * DAI clock polarity
> > -	 *
> > -	 * The setup for LRCK contradicts the datasheet, but under a
> > -	 * scope it's clear that the LRCK polarity is reversed
> > -	 * compared to the expected polarity on the bus.
> > -	 */
> 
> I think we should keep that comment somewhere.

I think that keeping that comment would be very misleading since the LRCLK
setup would not contradict the datasheet anymore [1][2].

Also, do you recall any details about the mentioned scope test setup? Was i2s
mode tested in that occasion? It would help clarify the situation.

Could anyone verify this patch against H3/H6 SoCs?

[1]: https://linux-sunxi.org/images/4/4b/Allwinner_H3_Datasheet_V1.2.pdf
section 8.6.7.2
[2]: https://linux-sunxi.org/images/4/46/Allwinner_H6_V200_User_Manual_V1.1.pdf
section 7.2.5.2

Thanks,
Matteo Martelli

