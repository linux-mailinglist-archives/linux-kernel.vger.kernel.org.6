Return-Path: <linux-kernel+bounces-535599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DC2A474EB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 962393B14A0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 04:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744063FB0E;
	Thu, 27 Feb 2025 04:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lH0OLVvG"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89132270022;
	Thu, 27 Feb 2025 04:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740631965; cv=none; b=Y50HesSWFiYQ7U6zolhEJIMzxWDEQaz32Wy853fnTBtud5kC2wyTel1YgJzZ6y6RwIp32RKu9ws5Pf1fXZkNSWT9nyP/EjjrTP0Y80hT/0GtIwYlEjk7feH5WQ0s+M5W9nYjHc8nk4hqEkQmKiaYDxdbc/ZJ6ASFamQ21k3E97I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740631965; c=relaxed/simple;
	bh=tuYNKQgyX5O6FR4LUMVu38G3HkU8er1qpaOkfa4P30I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UOKiIxyTaqPXQ3GpWVFVB5AQ7Ra3c4CBvEgAPO5nfA80VCBO3d4RXOxYXMqb5woVVe4m8I+BYVYEfLI7EXHS5wl4flys5cV5l+saEUIFgeEqTMsCPQ+qbKa9wIJs+BtK2G+ipjHh0kQcq3I4SQuJ2o2V6WRZXZVN+f3NWskCIAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lH0OLVvG; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2234338f2bbso1048675ad.3;
        Wed, 26 Feb 2025 20:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740631963; x=1741236763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tuYNKQgyX5O6FR4LUMVu38G3HkU8er1qpaOkfa4P30I=;
        b=lH0OLVvGYP7JUMMOi1XoJOHy6mz55HQFWv3gGHAIxs+b09DCLpJjcTU9VRzrCIVJpI
         jYX3ZGORhEAxyNQ6DXMCPR1f9Z+sw9MerzjhiS9gVFUfkdezgajxRQ+nkLGsI7y/vjVs
         8rhIokAVe1M+NrFstH9zUQu9Zto9f6FgxwEUvwVxIfWxET3w9cYDIBk/CnDnTixaufii
         eFokPkoscGLZuFFOZuKNQZVtvPVMODdeTI9rq4I5TP+x8zomlqRk+lkkxD85tgBDK61q
         LP00VZR3q3tlrrpudgvQW8Qm5u7aO+jSty4XjHEDrvFK8y0wbmkPe3T1oYPy3PJUCyOd
         QtYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740631963; x=1741236763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tuYNKQgyX5O6FR4LUMVu38G3HkU8er1qpaOkfa4P30I=;
        b=gw0+zZ1Eb8Dzwv3dQKiZ7GhzpIRS5dNu0R4RtGAJ9E5xPIZX9qxOkft2nS3WhaAt58
         oylNuAfDixL43Sjwr7Cymfei97F9BBqj/dZoV2qRJnaRrybGO9wGSunVs1jSTbLqrGKk
         wQmz42vybQ/AHnbvIZ5bCjCpdzo99rf+IW/QkuP4iHD8Z1OmL9qLOXRzPNYciyUvYZIK
         5JZwBAvBUi1/5YfbOfvuuzZoah16MqIdr22tQurpEwRhTciUAmjhMxaeeLGOMfSSFjaC
         SBa3tiCK/aRoh90VTMOH2fCTG7cJXWo1cKEHiiPW4cpX1hXjOOf078pO8l2iDLxFRisH
         gx7g==
X-Forwarded-Encrypted: i=1; AJvYcCU+IHLMV7+8TcYA8mMUdDQr7SgV0vNgep2UcNQmpTfnFFnQBC9s7CNe6zTjvAzBfFPvyvVQMNIePLsHwvaI@vger.kernel.org, AJvYcCVRom95oZmwAcpeFG8GpZ0kgjfwhjQCuDp60KveLpW1xYXYkylRODRGXAHGAVrb3Rw8Y/zCJJdetePi@vger.kernel.org
X-Gm-Message-State: AOJu0YxwnwKG9zldxZUXqsj4cbDPiEEDyts6O2cRatdrLrg96mYNL0AT
	qqqdUJCLvvJPqyc8xvL5hfh9QqKONIIQ30ocNerHzjHJ+p8RqJax
X-Gm-Gg: ASbGnct8AgjArfEP7Fd/OcinFCldZydNFLqmSq9gEb2enc1y02ZWSGHFv2RpSofeshF
	+Lm5IzRRkDncY006vK+amVE01rQg0/S/mrpS8m7jKP9h9S9SQ1UXDM1odDqWEbcHbKDOzYF0/dC
	HRLUFtrhWPlhxlQhItjTcCRRgU0lepgsC13DG0HqPSOVS0esiWFEO47g3vUfNTezY/fRclaJTrh
	vS2XDnceaCMNmMc543cnAu3fRpTwg3RbJtNXbN+bqeXxvlSeAHpsOWC1/65jBcclaAD8BIQC/Se
	qVEdTzkBPyJHxnihD9QG8nNKAztH9II=
X-Google-Smtp-Source: AGHT+IFOTe85+dVh9Nr1Nayx3OAw0R9L2wT1EgUsr9R1XRN4JWbVGSkLM9SWP8BSj7wZqZPgFTcRFg==
X-Received: by 2002:a05:6a00:641a:b0:734:3d2e:18b1 with SMTP id d2e1a72fcca58-7343d2e19b4mr12435868b3a.2.1740631962677;
        Wed, 26 Feb 2025 20:52:42 -0800 (PST)
Received: from rock-5b.. ([221.220.131.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe2b7d5sm535629b3a.6.2025.02.26.20.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 20:52:42 -0800 (PST)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: peter.chen@cixtech.com
Cc: arnd@arndb.de,
	catalin.marinas@arm.com,
	cix-kernel-upstream@cixtech.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	marcin@juszkiewicz.com.pl,
	robh@kernel.org,
	will@kernel.org
Subject: Re: [PATCH v2 0/6] arm64: Introduce CIX P1 (SKY1) SoC
Date: Thu, 27 Feb 2025 12:52:36 +0800
Message-ID: <20250227045236.2830419-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250226012136.854614-1-peter.chen@cixtech.com>
References: <20250226012136.854614-1-peter.chen@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Peter,

I'm really happy to see the linux mainline upstream work sent. And I have
also reveived radxa orion o6 before the Chinese new year. I have heard
that CIX is testing vendor kernel with ACPI. And now the mainline upstream
work is based on devicetree. I want to know what the upstream work of CIX
would go in the future, are we going to toggle to ACPI instead of
devicetree?

And it would be good to let outsiders know the plan/roadmap of upstream.
For example collaboara is doing good job on upstreaming rockchip[1][2] and
mediatek[3] socs.

[1] https://gitlab.collabora.com/hardware-enablement/rockchip-3588/notes-for-rockchip-3588/-/blob/main/mainline-status.md
[2] https://gitlab.collabora.com/hardware-enablement/rockchip-3588/notes-for-rockchip-3576/-/blob/main/mainline-status.md?ref_type=heads
[3] https://gitlab.collabora.com/mediatek/aiot/wiki/-/blob/main/mainline-status.md

Best regards,
Jianfeng

