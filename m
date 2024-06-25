Return-Path: <linux-kernel+bounces-229037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA06F916A12
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A02FB2373E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EC9169AD0;
	Tue, 25 Jun 2024 14:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfFsXmCU"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A90813B295;
	Tue, 25 Jun 2024 14:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719325055; cv=none; b=qwmpZPJL46ef6fu32pS2tD8Gi7iP3EnFLpYSUvTLE62Ak1FCK+825F7K4YH7kj35QWEYUUBE+Mf18AICBScW5kDkgaD7hnU9TZXAAwXqlmzH9/4dBoINCphQQzaMW0xrU9QUyvqer6m+NEf3TQFzG/Ahk9NpF/jMHNnrUaI4xEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719325055; c=relaxed/simple;
	bh=dNv7RNmIhoI1Vd5UKHN/136wv1r6HCioWcj5Hz4gunM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oxGZsowN4wELbxCZjFFEqmoRe1QxtQanYK+zu0bfXYLMVljQja2A+l4p1ehmPHHFFULz7AIUG0+RQhpoYGi8u1Gkz4VUSox10X30sNDsmGjH1NLP/2Nvo3DPYpUDMvHV/HpVkEnKFYoYfhrJjeW8TKb9YbmL90RS6Z9rj1qV1Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WfFsXmCU; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2c7dbdc83bfso4316527a91.1;
        Tue, 25 Jun 2024 07:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719325053; x=1719929853; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dNv7RNmIhoI1Vd5UKHN/136wv1r6HCioWcj5Hz4gunM=;
        b=WfFsXmCUKsFdlOGA5f5oGFikYReLm5S1P3hT6NRfA0cNxLc2GB2OGM6usFtec3WtBu
         dGN5AcmE1+3nVpib+KVInCuMsn3S23GF9ijUdyTs5nFnXEfsqjbIdlm4FwCV4Yl5N99Q
         KO38bfEMAYZqlYAVt0m2EHOCNclZHpl7r5b4tlvcsz+GeXArpZO+7sS4GYZwxkhLiDQQ
         f6HLj2i3JYoFyCw2+x+UgrDXuTBT8u90uGVCf+92BlMuz48nB1Mt1fu1waD9xnEU9/Iv
         7jUiMcV5800dSlU3xTqCoWbYPnpp+Rfc5sR9fULEcD4dmcOZWhyscOOuW/2WtjMLFq/Y
         Buhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719325053; x=1719929853;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dNv7RNmIhoI1Vd5UKHN/136wv1r6HCioWcj5Hz4gunM=;
        b=lCeSQjZ5NptYy1wOnwpgAqWINOAXwsA863uzPTWb0cny7ZwMPOZFJj253LI60+RqLy
         l0hDFMZLQDIcIH19mk7vLylmSoGmWPgT1aStNPPl2McBcrMieST0AVPhXLjvPaAe7Tuz
         hrNwDxw9Vl8ITBXQgeqCPehhubkQVuDyCEYvb5BVch+1au+OLYtoZwuwdtIob1cxgP4M
         aXBTcxOvJpkyWGPEfe6nwRR1iTlQwyAF5WEpfqN5RckF+Plru6mqFgyyG5CCHrJirBhA
         GMeeGFWPVCof6v+mhbNcmTAQVTL26Q/j/AOUqTZxMgv+Uqm+jbrsXt9oMPDvzyoGsxlr
         nxIg==
X-Forwarded-Encrypted: i=1; AJvYcCU5XUHOTXuHDg+RtbdOQM9RTN5Z2PvBgaVwLy9fZj0lvUu/7zBtT3PQikw5zXjLnX1NAgkP78qUxoqE/C7woW+csxm6BWdqWodnSXl2hDroxl50j1QBbn10MctAoOrrWrJIoyzEJkotVfc=
X-Gm-Message-State: AOJu0YwIRaXgX8Znnef9oKrTf70B3+siibm3tp5Gd88lkHHr5H9GnfSt
	rLcVchkxXMSe9dpHWBYm46Yit5ZfyMv9rwUxVkcVH/3ynEN0rwExr2RqVWXrt33DQKSZwqOdPR3
	fwwSmKwuQ7JuRMUipYSwWksocc+Q=
X-Google-Smtp-Source: AGHT+IHY7Moi01QIYMw8+dg60IWdW1gG2DDDcZwhJsFqksbTDefj52yE4EiZx3Z6hOL2VBFqe9ICXoFxbyCzGwhsxSE=
X-Received: by 2002:a17:90a:b014:b0:2c2:c61f:e09 with SMTP id
 98e67ed59e1d1-2c8613d204dmr6953843a91.20.1719325053001; Tue, 25 Jun 2024
 07:17:33 -0700 (PDT)
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
 <CAGpJQTFF=gKN2h105dGhBOEhN0Q1Tpj5hJWpSdQ_-nCoUTzj5A@mail.gmail.com>
 <87tthhktdz.wl-tiwai@suse.de> <87sex1kt6t.wl-tiwai@suse.de>
In-Reply-To: <87sex1kt6t.wl-tiwai@suse.de>
From: Rauty <rautyrauty@gmail.com>
Date: Tue, 25 Jun 2024 17:16:56 +0300
Message-ID: <CAGpJQTGR5WKuHUFGFUC286TUkOXYgcqigZRDb4K5deyE9uuz8w@mail.gmail.com>
Subject: Re: [PATCH v2] ALSA: hda/realtek: Enable headset mic on IdeaPad
 330-17IKB 81DM
To: Takashi Iwai <tiwai@suse.de>
Cc: wzhd@ustc.edu, Gergo Koteles <soyer@irl.hu>, alsa-devel@alsa-project.org, 
	tiwai@suse.com, perex@perex.cz, kailang@realtek.com, 
	sbinding@opensource.cirrus.com, luke@ljones.dev, shenghao-ding@ti.com, 
	simont@opensource.cirrus.com, foss@athaariq.my.id, rf@opensource.cirrus.com, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Jun 2024 at 17:11, Takashi Iwai <tiwai@suse.de> wrote:
> Zihao, do you still have the access to this machine?
> If yes, could you give alsa-info.sh output, or a proc file output?

He sent it to me:
https://alsa-project.org/db/?f=268601dbdb76f9a4c18d71e210091ffed4bf2818

