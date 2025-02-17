Return-Path: <linux-kernel+bounces-516922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67182A379BF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 03:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41CAA188E894
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 02:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A50137C35;
	Mon, 17 Feb 2025 02:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIGidd8e"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB5AC8FE;
	Mon, 17 Feb 2025 02:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739759730; cv=none; b=qEAdKoRMDbqPkI6rJo78QiG/+hjObX2Gw4C079TKrmzBiHbzRMvhj5xRHUOJOtdm6R4IJzyN+fXRjtl3FEay9DLE0iqqz6Uf+NCapBDde+wDcY4juD5C6HzH7xcszNBcqo3hxO4xrUWsuK2SBvuCLhj4i9+W1qvc8WT12cqsSSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739759730; c=relaxed/simple;
	bh=HtSCAHnhXrrW423RWds7zex65LvGwUzS1qiyQKel6G8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DD065xdV3OGQkVmBBhgnXHsyjVmTMSjUAuYEPyQJZRhp7PgyZky668MWO6NPa0RbAAh9Vpgc+koCsKDoIDrfB1DIrxUkcPmHoBzinN0hGuhDqXmaH4wzQd/q4Aq0NY7z08b0PtsUd8oGeW7uiifIGvLkCcNXj9zTLSNyNrZApBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIGidd8e; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220cd9959f6so7937265ad.1;
        Sun, 16 Feb 2025 18:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739759728; x=1740364528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jd4HwW3C0GzbkZ4o5YXYERwcRmz2KQTD3y8I//0WkKo=;
        b=AIGidd8eUBu5YAPfHAqjOxx7YMFWxlzI2s+/QqZk0HmGrlM/60Yw66vAQuRFzR7Mi8
         NNuX0mCVZSG6ZSClc45TVBM8wjaqrluhyD6vQ2nav921PHOtxBrJ0DVYBFQqBO7cE8wl
         mIoScMpA5oo/itnvWCIb75ynNIXNbhlL0u+lFZTZjPN5+t5vzhGdRyt63pKJ9RCiB2x6
         Vm7H5sTCzvyQCOCaLHSlGef/DjvmEydOdFyT+izeI4KPlTXur0gWKg3U4sPOC7ZSrzME
         jpvT1MmQiBiMOi63U1GE1Qs1l91vrlcx5WJfZcd33SiPzlT6bDb1k3CfkeZbSs21DcZq
         Hrfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739759728; x=1740364528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jd4HwW3C0GzbkZ4o5YXYERwcRmz2KQTD3y8I//0WkKo=;
        b=PjVk9phDFwPbu1Sf24fw8ev+tnVZhnqNgGRTmXnDizwRYtvbA93u/LCaj3/18Yr6FX
         IF4+Idrh2JDgjRjm5wm47SkXmsdc4X/mIFBKJ2Blo4X8canCC1h55R5bvm3t5X2vfkUi
         /p32Wsdqmd/UZu2GgFbXcluvhKYaMaFQR88tPkSZu14eVEEW2m7pcU6ufL2RV+t+943F
         mjr4XDTdRzC9j0WgX7dW7aNVfxPAC9j8NN5cbfnKUoU1muvNIlfReV/WEtO4lkdQgBrC
         nRLh1HqAZbRQvgO7nR4z4ZxsGMfaStW8AvhJnbZ1AxDv/qwR4lA6T7Pg7++7v7hgx3Sv
         V6zw==
X-Forwarded-Encrypted: i=1; AJvYcCVHyv/ZZjvXWwZI/7FKjKyCi05Mcs1KmbXPxN0LG+JHizKANVFadLXl/RVWSra6nUnDl8UzOIZ1r+uBxMf9@vger.kernel.org, AJvYcCXpNFlWs4Twc5KMvuIzWC++EVQF3XGOOtfdyWRNdsoRh0rG0wtFdYng3XJLbDJ89fxdkpdEFF7v3DDH@vger.kernel.org
X-Gm-Message-State: AOJu0YwRuWee1s+ouhBZqTo9q3+ijSGP/RvIUeQqrgV3xYxprJGCIDmJ
	RFix7zui3shVE7gokKKsxfO8qFm7LapMpQ/Tr4zaeFx4Ekz97vg+
X-Gm-Gg: ASbGncvHP1mJUenlSfE6nn5uI+kEdJHoA04YDO6jRW8Q+kEhK37T+3AE4+jUEuKNkzG
	y1aVMuM82Eh9PNpL5Y9H3KRP/yMKtom6Z04qSzbNa70sN5XuP+Jv+dxJ7LiICDbpmcMrzBGjub7
	VBwGirPrhn/Icm9AjSQVxWPCwgpbqIYUZQsfIpPrGAkq356sWnQFTVGskKKi3QGy6KR9+OzOCzB
	UC+kRwgJTHKeh2pRyGSGcxtTHL1mz+C8qEw5NdikdbUgBPhrHmFqV5iPL9Kf55gTQ4eNNqoSWUl
	Igq1den3aLQBQQ2LPl5T
X-Google-Smtp-Source: AGHT+IGNbbo7ikAW7Im+6gY74ZetG4o01fHwxCYPD6wtGVa+4XQqxJ9KfHcssadTuHK692BYrU0wVA==
X-Received: by 2002:a05:6a21:78a1:b0:1ea:ddd1:2fe4 with SMTP id adf61e73a8af0-1ee8c9aa127mr5494706637.0.1739759728075;
        Sun, 16 Feb 2025 18:35:28 -0800 (PST)
Received: from rock-5b.. ([221.220.131.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73260f9e6e2sm3702199b3a.79.2025.02.16.18.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 18:35:27 -0800 (PST)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: piotr.oniszczuk@gmail.com
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	liujianfeng1994@gmail.com,
	robh@kernel.org,
	sfr@canb.auug.org.au
Subject: Re: [PATCH] arm64: dts: rockchip: add hdmi1 support to ROCK 5 ITX
Date: Mon, 17 Feb 2025 10:35:21 +0800
Message-ID: <20250217023521.35071-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2FE649E5-61FE-4299-81D1-F838298A04A5@gmail.com>
References: <2FE649E5-61FE-4299-81D1-F838298A04A5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

On Sun, 16 Feb 2025 20:53:27 +0100, Piotr Oniszczuk wrote:
>[    0.531139] rockchip-drm display-subsystem: bound fdea0000.hdmi (ops dw_hdmi_qp_rockchip_ops)

It seems that hdmi qp driver is built in kernel, while armbian builds it
as module. I don't know if this is related. And here is the dmesg output
of drm on armbian:

jfliu@rock-5-itx:~$ sudo dmesg |grep drm
[    2.190256] panthor fb000000.gpu: [drm] clock rate = 198000000
[    2.191470] panthor fb000000.gpu: [drm] mali-g610 id 0xa867 major 0x0 minor 0x0 status 0x5
[    2.191478] panthor fb000000.gpu: [drm] Features: L2:0x7120306 Tiler:0x809 Mem:0x301 MMU:0x2830 AS:0xff
[    2.191482] panthor fb000000.gpu: [drm] shader_present=0x50005 l2_present=0x1 tiler_present=0x1
[    2.195853] panthor fb000000.gpu: [drm] Firmware protected mode entry not be supported, ignoring
[    2.196019] panthor fb000000.gpu: [drm] Firmware git sha: 814b47b551159067b67a37c4e9adda458ad9d852
[    2.196407] panthor fb000000.gpu: [drm] CSF FW using interface v1.1.0, Features 0x0 Instrumentation features 0x71
[    2.221006] [drm] Initialized panthor 1.3.0 for fb000000.gpu on minor 0
[    2.566800] rockchip-drm display-subsystem: bound fdd90000.vop (ops rockchip_drm_fini [rockchipdrm])
[    2.567523] rockchip-drm display-subsystem: bound fdea0000.hdmi (ops rockchip_drm_fini [rockchipdrm])
[    2.567882] [drm] Initialized rockchip 1.0.0 for display-subsystem on minor 1
[    2.740995] rockchip-drm display-subsystem: [drm] fb0: rockchipdrmfb frame buffer device

>Is it possible to provide me url with kernel package you are using (wich works ok for you)?

I'm working on 6.14-rc2 now and this patch is included in this armbian pr:
https://github.com/armbian/build/pull/7835

And here is the kernel deb I built, which is confirmed working:
https://cdn.haguro.top/share/kernel-rockchip64-edge_6.14-rc2-rock5itx-hdmi1_arm64.tar

Best regards,
Jianfeng

