Return-Path: <linux-kernel+bounces-353602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9729B993028
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15032B24E93
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F2B1D7E21;
	Mon,  7 Oct 2024 14:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/QtM07P"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D831D45FF;
	Mon,  7 Oct 2024 14:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728312917; cv=none; b=QWZJH518bwywdVe4vU6jXd9u5dadRvnwX3FduUYJWha8h4Rpl1Ww/64eC1j+Uh3L3iExNZCZSwKxaogIIcYzcia4SkWb8q8ylGqgcfDqxhtQ/zwboYge3aW99mSi74BJlPsLfGXdsFrUToCycSDh/MyB+6ILZhP5bqSCUg5cfs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728312917; c=relaxed/simple;
	bh=JPbykfA6c/4U8Ph23Stgc6eATluBuEF0b1PI5oO4ix4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C5nZMyPu1AorxspE1qMTf2uXFqLk//ctKv0lmfUZ6UqrpYi2swsww18FVdjue+cqdSLLYh0zpdSSxAzag05WNOo1dnwjZtkJbjRWz447du0tD87m655N5P8vNdm/5TbgGl2j21Ru+A5W06zhQ3tGZQmlZKZVJu4EpQlHG+nTYEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/QtM07P; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-45830ff5b70so36681461cf.1;
        Mon, 07 Oct 2024 07:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728312915; x=1728917715; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JPbykfA6c/4U8Ph23Stgc6eATluBuEF0b1PI5oO4ix4=;
        b=E/QtM07Pdoakc5dfzfgFWZfsZMPlodI/Xl4uH2pFB8BX0CGIRAck3pXfoa+YmWTYPl
         S5VpHSo2uxOi40LHfrh6oLivlzMigNuR8Kb/P3LpWhyeCtYCg3D8JUrv5uKLhDibYwfF
         9QqOpFlwD07nyvJtU+UMvYoojaaE3By35hbTWpN6A+RImtORaLqeXTus43F/+BUCeMS7
         z0Cqk6t4zmN5xLpSjOZuy5iAC8AgpJT2k2l6UdiWYcQPKz20kuiJawXDTQBeG1kpyHJC
         I6baUQB9b7XmqGS5wfXCwpxOmNxNpXvhGeRKDUm3j6QlCS29cmz65SMULXxbfJRHE5Ky
         NobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728312915; x=1728917715;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JPbykfA6c/4U8Ph23Stgc6eATluBuEF0b1PI5oO4ix4=;
        b=fP5LFuOySL4+HBPf1KLWW7XjcqNqiLtg1SbmTd5HKpcMvvFWk6wnzaGC+a5cnUjIQW
         y8uNPOKW1l8jYhCOygSxtu6Ar0VzlreN3oisFCNnqOzgk7vYQPT782dtqTxhPy1ukI1/
         uooACnAnqJV4sM7Ld3zaU1zFUOdvXLi6T//teSw5dACD46xOJ1nOKGOPerVJ+Kf0vQRL
         NLUbvrAg9dxmJnoGYgJ+H+GuzamQKcIpsK6k302YW3KkRta7SVAPHNw6RXnnJl5vwein
         E1Dj4cYv7CTyMAgCsDAhMrSxNZ/dkYWx+VRBlICMdVdsTfbLTUCcs9sjwRLkVJzVJAfc
         W+WQ==
X-Forwarded-Encrypted: i=1; AJvYcCXw851fvK1nVzk3Y42mGuH1osNECZlhRE/iPdddgJ8e85o9sdHHlvfipWVinLawJZMb5aDP5eohtIBNjiQ=@vger.kernel.org, AJvYcCXz7pwpOIMO780RUmbJjsfGFZ4Fji1m+kglbCOLhYcmPGJGUU3ATx4jVYNi97dxj++cCxdbv5gMTOjn+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzOYZTJfS3YqU7t/GGdxAxljPJ3pd/ZynPKqvU8xoFwSnXuReg6
	YzBmVBjawhzKAHfUf8TYX8CfC9MMeI1Qj9hxRs7NfiQTVsaIRznF/Mw2axvVyHbppKWozzdWNV1
	HfI4dxwutwYWApQSllLEu1oOf0Ou26DUurf8=
X-Google-Smtp-Source: AGHT+IFaENjB7jDhoaCKMP4hSUkymR0VzFFeXCD6QjbbPaGu/F56xC2Dpq6155bbRExsB1Tfn34E7Zj4G9igvSc2r+4=
X-Received: by 2002:ac8:5809:0:b0:45d:8684:4324 with SMTP id
 d75a77b69052e-45d9bb3a95cmr202639541cf.58.1728312914679; Mon, 07 Oct 2024
 07:55:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912092601.451692-1-arikalo@gmail.com>
In-Reply-To: <20240912092601.451692-1-arikalo@gmail.com>
From: Aleksandar Rikalo <arikalo@gmail.com>
Date: Mon, 7 Oct 2024 16:55:02 +0200
Message-ID: <CAGQJe6rH7JKg8bYTJL=D2f-wqqxiwFLJGOVck_dmbVyhrsepJw@mail.gmail.com>
Subject: Re: [PATCH v6 0/9] MIPS: Support I6500 multi-cluster configuration
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Chao-ying Fu <cfu@wavecomp.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Greg Ungerer <gerg@kernel.org>, 
	Hauke Mehrtens <hauke@hauke-m.de>, Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org, 
	linux-mips@vger.kernel.org, Marc Zyngier <maz@kernel.org>, 
	Paul Burton <paulburton@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Serge Semin <fancer.lancer@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"

Would anyone be able to take a look at this?
Thank you.

--
Aleksandar

