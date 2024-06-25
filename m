Return-Path: <linux-kernel+bounces-229019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7141F9169C5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C6BB281F93
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3221649C6;
	Tue, 25 Jun 2024 14:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHzd1s9o"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892A0146A83;
	Tue, 25 Jun 2024 14:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719324096; cv=none; b=tLLDuWzlYX2W8phUubKTT2WRA271Q3L7NC2SyHGP8CugAKOV1r0S879DOqdMoncz4C9wgzalmMBAKyT90pLzBXPHj93+JjSZgcLpGFB7hJCaRd8sLnRKd5dacRv7DxwI1mB3ifzgXYYA1MPxiCuTCwNSybamdR1p2A1uB8fo/+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719324096; c=relaxed/simple;
	bh=X3Iggen6O1cM2G21L94wXloIh4QAzGgxW3l06iUP3Ok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dbWDgsn47ZSfC5ZikBXQfsIlu1GHwOuZEjD6464FW8colVwt4PLiAN8X1mNWx2hAXWosUsy21X4319cSF7umk1MpDd+T1P6UsS/GgDeB/aXoOHX828fwYbTIDgdenQrdH8jB6VHqIR/g8qyk/VX3R4pc7VS6l59NGfxTfPxEb10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHzd1s9o; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-711b1512aeaso4336467a12.3;
        Tue, 25 Jun 2024 07:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719324095; x=1719928895; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X3Iggen6O1cM2G21L94wXloIh4QAzGgxW3l06iUP3Ok=;
        b=aHzd1s9oUHALAtdaI0hrPgrJgapDHnyLMuZf1QJz54ZSuLw9jDmV5Iya9EIat8FHBT
         B38IaIJ7ei/Lb4+qCrXsxOTLuuxEA4rR/Z06VE0PnHdJr23FSlNj3u7G7aGlHLv3EK+o
         z7xEEwMbZkLcx0cFwJY5kmt1zf7kVkQzYLbcQQpD0ohT9JNmgCqC0lIJmYtRqZKlXXEx
         r4DDem125YQewcBvVAF+LiD1Pn/WwJdo2yh2hTud2aTjJitV8Yxeeqi3Dg4pEHPVVy8K
         BIspJQAMVXVU6wQny5ZZF+ubcuyEbp46LYP/PTm42YmcAZTCYE3vSWRoydcSCBxUZERB
         QmTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719324095; x=1719928895;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X3Iggen6O1cM2G21L94wXloIh4QAzGgxW3l06iUP3Ok=;
        b=Kk5c8wFUXCK4uCQpnGKeFH3fg/+rcYDWkx3yc9GyHtQ4jGvjYn5E1hOtOnKih2FwyG
         PshVPB8JeciU0z5NirSKkuOlqzAGU8wcgTbhqsTb2a4H72LPTdjzP/DQmpzlP80UgQJJ
         g8KTq8y/W4vRJoGuewuzD25rx9z7BFF/C4FOmRb21+suOS++cFYVu7+jy8EQjnjnrIm7
         pPU4sht87JgpCH2yKLcrySXw8sCdtL7Y2BkC9B0UNFCvG8pHELtc0hiM474Ctuc4amRf
         XoFQO6Vq028/PII5ezY8iC7B2aG6BqX9dWGm18VfiC2+g4tAuYkjWS3B6971JjFQ71T8
         KhEw==
X-Forwarded-Encrypted: i=1; AJvYcCVDcuRYELVJ613UZRyBm9x6DEP86UQCsXjuVgvAbMqMKSNink7GzWqhRDyO0Ob3E3oq53biJDcJXKYm2QECQI3fwwdh/Vi0m7QSGRvpxsqPhFHfcfL0pwbqBjA4k6RUe97rYArIL9hbhWw=
X-Gm-Message-State: AOJu0Yyi8u10rYPUt5QaD360IquTlMG6lWv//GCYRhSFOUsLKpiVAY9B
	ts8X/pPEfOAgtMARipg8/9pDs2XARbSuRVNO6jgiofXglNm1mX111gv+Ti9nZah17+/zZ2y6cNT
	UcSG8KDHaI+rOMRKi0qo2f9Pfg0A=
X-Google-Smtp-Source: AGHT+IEd+EBC/NWsf+VOsO01Za2baDweXjbJ43MpcDB03jH0q2mwqFAep7ly9pDQAeDiOXTil5t1xngphUxrU/41kEQ=
X-Received: by 2002:a17:90a:7444:b0:2c8:84b:580e with SMTP id
 98e67ed59e1d1-2c85829734amr7015577a91.41.1719324094452; Tue, 25 Jun 2024
 07:01:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240615125457.167844-1-rauty@altlinux.org> <2c9ba341bc95d4b9010bf5f8794c0d14b1c57dc9.camel@irl.hu>
 <CAGpJQTHoBAixmxta2WuZfjHjiK9GXF=hkfPyV7PBD5rt9Z_0WA@mail.gmail.com>
 <CAGpJQTGqxEkfp003QLsp-syUgzDFCmHSmNaoOaem0ZMVf7_=bg@mail.gmail.com>
 <c0a9e15e7926e098bdea97a7d31c32427e0910c9.camel@irl.hu> <871q4lm9dp.wl-tiwai@suse.de>
In-Reply-To: <871q4lm9dp.wl-tiwai@suse.de>
From: Rauty <rautyrauty@gmail.com>
Date: Tue, 25 Jun 2024 17:00:57 +0300
Message-ID: <CAGpJQTFF=gKN2h105dGhBOEhN0Q1Tpj5hJWpSdQ_-nCoUTzj5A@mail.gmail.com>
Subject: Re: [PATCH v2] ALSA: hda/realtek: Enable headset mic on IdeaPad
 330-17IKB 81DM
To: Takashi Iwai <tiwai@suse.de>, Gergo Koteles <soyer@irl.hu>, alsa-devel@alsa-project.org
Cc: tiwai@suse.com, perex@perex.cz, kailang@realtek.com, 
	sbinding@opensource.cirrus.com, luke@ljones.dev, shenghao-ding@ti.com, 
	simont@opensource.cirrus.com, foss@athaariq.my.id, rf@opensource.cirrus.com, 
	wzhd@ustc.edu, linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Jun 2024 at 16:32, Gergo Koteles <soyer@irl.hu> wrote:
> I still think this breaks Duet 7 sound, because snd_hda_pick_fixup
> function picks the PCI SSIDs before Codec SSIDs.

a piece of lspci from Lenovo IdeaPad 330-17IKB 81DM:
00:1f.3 Audio device [0403]: Intel Corporation Sunrise Point-LP HD
Audio [8086:9d71] (rev 21)
Subsystem: Lenovo Device [17aa:3837]
Kernel driver in use: snd_hda_intel

Since PCI SSIDs are in priority, I will specify it (0x3837).
Then this patch will not break the sound in the laptop and the change
will be minimal.

