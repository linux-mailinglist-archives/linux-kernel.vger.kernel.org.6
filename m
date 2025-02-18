Return-Path: <linux-kernel+bounces-518590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 595D5A3915D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 04:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 423013AF78E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 03:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50691188580;
	Tue, 18 Feb 2025 03:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3KyWvDU"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CDA17C77;
	Tue, 18 Feb 2025 03:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739849937; cv=none; b=Gca4OaTKCX8dkedPf3g6vXpSeC5j20j3CpYhoixnnTW+3R2ny1zLkdV9SEUd9WViGK4AuDVUwoaUcFZBj61NtHuy766V52kII/cuXbw2MbK606Xrjx/KHJ0nI+cMZvXDhG0hrteeuJAvJhSWoio8c1Q8dpyEUsKD11hN6S3tP0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739849937; c=relaxed/simple;
	bh=ODxPYTsXExWrZFgcL3sfYH0HWgoLCM5DTy1lzZUJQik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JZZ559GTqKdiW5ket9/BMc/kBXnQf9WY8/9TiSMew+1vHrO/TG+fjpk7/WQp29jKrgb5URWStcrLnT8lVxV2kn7SezXRnyMe4Sc1t5Kph9mcaEqqtBhqKo1zFIkHBFCbfgx/EGOJ36mhHinRrYqvlfn7lQbeoem6DNCjs5YdtgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V3KyWvDU; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fbf706c9cbso1222072a91.3;
        Mon, 17 Feb 2025 19:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739849935; x=1740454735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BpIhM0zsF5MRaXYqddzsaHiNvWZ/pZsLy5qS/qUhHO0=;
        b=V3KyWvDUVJri+/NI2se17koolnHGmPl28jqGq2h6nM+t+sazPzHz0DOMGP4mXJhIkE
         0Pb1O4KewYEn7epJfmGCVkdvSiTc5jgWJkKYQnSSfQT9cJO3edznkoL9glnGARWEHz26
         yvBLUN/KHN6N5ufUJs53QNaHFZMQ4G2bBazdmJk56L4tEoKR9YvA4VJ+ymwD3EE0WF96
         wfGEd0XmeP65BqwvLC2YhP9kzQApfxPynX13w63sC2cEG+0hjUisHo1UYOl3dt3tm9m0
         IhyAEM+k8LlJogLO8yXPWDsPrY+xqijxPzWyqa4Ft4t73e4qreWpwDqqdbYlwdWG7F2z
         4jgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739849935; x=1740454735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BpIhM0zsF5MRaXYqddzsaHiNvWZ/pZsLy5qS/qUhHO0=;
        b=tmI9F3DbEw7IIuvgmMSegmTXgNBd62LXmZyL3cobgDv36oOLB1qlJ4ZVmlQ/aifnJb
         shOa8ghI5GNvEn9o3iEmBYhCvLaHRVXR8Zy0v00reAcTx30ZWofaID08x4VJ0VwOynW3
         +X2I2CdfXxGipxFUzTCwNhjC5ZkUkWkkD8h2mCgHvOhe/XN4L4Ampw9NMVOm2LtdWVLs
         qQf1xi91eDngYvqwZZFReDcGgO+BfFKwWr5AyWihx8UhYmCC8WcSxC6K7eTA6/ZFtx8u
         KNh6vbWksa/NUq//76UesJQa4semXBNi/yxu/U+0KhjqW9KCCk1x+BQ3C2nW4AxjRslK
         LXkw==
X-Forwarded-Encrypted: i=1; AJvYcCUkU0011ivVynqMc0KRVsvjV5GfpY1G/jsGTDCEsWl5eEmHP/jOKdR2qXzS4+/0Eii4suGN5vB3vG0q7jEP@vger.kernel.org, AJvYcCWSBTWmDGRi06l2G90bjp2YwuhUadiksEu8fFYIVrFU7KTEFBJ+ArL5NSWkDjVQ07GtDL9KTlf+nM8w@vger.kernel.org
X-Gm-Message-State: AOJu0YwbmafqhsYaUUhNAv63BpWfpWBVPj+e9sKYvf9IrlmDv/ivuUAf
	PDMRjQl4vHnirSPD89pgGuGEincUAaGlFHYSogH+oVtn1Ac9pHFG
X-Gm-Gg: ASbGncsTlalzEufXuPBnsQj21oqy9gCHr2E22vMRJTKnqt+lSxE2UzSdC/K5qBQpzZH
	TxEHW1InNHiPdrpaMAB+FwJtO+oOp5Syzywz6gLfKINpEHXlqBuSXJGLwp4tvEs/PfUpfZO1Ze3
	IPkkFYM+6W3lzzYZT9VFlplxv9hLlfZzY3EXROdcisRADhn+I00m1sryf9iIUuvWh9RAnq7XbyY
	fntFgjuh3VyAla1d7UFD+G/afG1TXteBTB3bM+pNN7SMvsXen8chPPtnzcrs02rWsI0MwTc5BY9
	KKqu3d3PTjKWZV1iC35g
X-Google-Smtp-Source: AGHT+IHp51ZpR11Xenf1xc5xrATpU2b9pYP8ziEHbXQ3EXKCqj44fPEbRUBGOVevxEXu+GXioUS4wg==
X-Received: by 2002:a05:6a00:198c:b0:732:2923:b70e with SMTP id d2e1a72fcca58-73261446955mr7067310b3a.0.1739849935459;
        Mon, 17 Feb 2025 19:38:55 -0800 (PST)
Received: from rock-5b.. ([221.220.131.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73271b4a8b6sm3947699b3a.2.2025.02.17.19.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 19:38:54 -0800 (PST)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: cristian.ciocaltea@collabora.com
Cc: airlied@gmail.com,
	andy.yan@rock-chips.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	heiko@sntech.de,
	hjc@rock-chips.com,
	kernel@collabora.com,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	liujianfeng1994@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	robh@kernel.org,
	simona@ffwll.ch,
	tzimmermann@suse.de
Subject: Re: [PATCH 3/4] arm64: dts: rockchip: Add HDMI1 PHY PLL clock source to VOP2 on RK3588
Date: Tue, 18 Feb 2025 11:38:46 +0800
Message-ID: <20250218033846.1251897-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1b3234ce-4526-4735-b9c0-c242e6cc3cf0@collabora.com>
References: <1b3234ce-4526-4735-b9c0-c242e6cc3cf0@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

On Tue, 18 Feb 2025 01:33:34 +0200, Cristian Ciocaltea wrote:
>@Jianfeng: Did you encounter any particular issue with the current approach?

This patch is adding a dependency of hdptxphy1 to vop for all rk3588
boards, but not all rk3588 boards have dual hdmi, armsom sige7 is an
example. At runtime I will get errors because there is no hdptxphy1
enabled in devicetree:

[    2.945675] rockchip-drm display-subsystem: [drm] *ERROR* failed to get pll_hdmiphy1

Overwrting vop node at board level to remove the dependency of hdptxphy1
can fix the issue.

Best regards,
Jianfeng

