Return-Path: <linux-kernel+bounces-319612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8DC96FF7F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 05:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA3011F23F26
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 03:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BC71BDC8;
	Sat,  7 Sep 2024 03:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHCO61uH"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58401A923
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 03:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725678208; cv=none; b=nD1wSfmT/uPA/R8qRrDv9s1YYWVtA3kfnoMZHmzlm3xtMAqWUamKb0tBX4xpHSyrev3K1q+CiCQ3SRK7ENU5LEfAgY/PjkTPKYKFP7kD++8q1ID1RjxXFNTCuDdsnQcHuiA6c7qGl7ET6K+BSlQv7SINeMtsUx2ajO6VpmwvjEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725678208; c=relaxed/simple;
	bh=P9JiAE/6An9y9qC2N3Tsl48gDM4yioLSRt1wi0hMFKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XLM26erk4EbUDTivyb6p15PXG7wZxzjr6zChGkgnXS2aITBPAXX8fmNh2wIHA10m9X/LqI9ZUttGnTe+jNNzkNqHQVkP+Wgf9Duj7AO2VvFMGUOXQzlvvPaiv2b4P7dX5rcJ3nJTO+dME9CZfOqo/aPxUT1I2S6ABEgMhVS+JQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHCO61uH; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-27830bce86bso1557695fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 20:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725678206; x=1726283006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRAdeMKzd8GauuC39KSsRCc9kFo3QimzcrHIoNem7IU=;
        b=bHCO61uH7YbN1fTLrpPlcneoNUndLxGi4i9zGR9cwBOFyxl1uV1uW6+tIrh8zO5w7f
         j90BUu/Jjkt+CjrlR4YdzDWGwYCfPyBJL6C+tcdjVSEa//r7AQ8EohcoxRlKDBqASTjN
         2nkqGy2A7MyUrB6aJWbgmBWG+0V4UaL6xGh2e1jWMI3RNk1OSfRuv6Bx/CpGOuL6pm2q
         hbPse/K3ACrj6+bFYrmPnJ8OrXkuYXdaX5d8Ihi7s7r6ikw/oSRLfXBXDqX3To2SlWDT
         vGS0LVTf9pa6yoO+yrWxJ4LhWP17rGe73X/PR5q8eRtY+f3E3UFdW+XIoyXd+VVOh1C0
         vEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725678206; x=1726283006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BRAdeMKzd8GauuC39KSsRCc9kFo3QimzcrHIoNem7IU=;
        b=bo4mb3TpSLxFywH661wxGBTkb2+e+jF3lO++jxOMs7jnu7iKY83GfxjQpn28IDi0v8
         RJzJqYsDPKDEEEaVsxoGXxHh+2eKNlcpj3M5xRCimMZ9xNUpGBVryXCddSk0S6foe/mF
         jLPOJjocm/YSRw1wyaAPSBSLQsr6cH2xm27WcQWx1Nzjp0I/l4TaQUBfMa4Eqwf+j7O5
         3M3i1o8mDSHArnhwEaiQnAFao8OfJywDLMo5YxnkLK0I4IflcUFvFOXjpsI1vD2hN/b6
         ts4dODjJW9+WsQpF6LX162otDQkxGXW4Y8itKiW8ts5tWRbaXg/xLhvDjrtU0hnztSyZ
         iifw==
X-Forwarded-Encrypted: i=1; AJvYcCXQt6UOUjgAnNU1Adtsie+XPtxeH5ZdZV1tM0WQUS5UXDR3zGswAcMvEAwao3D53YeZWOalrO0NWquewXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbLeS0gpuMoHBH63oefH9lzY1WrpftSxATpifBPNInmSSsmgWJ
	94+vSy7qlMnIFOfvd/egDH8jN8yoXbLEK1cDUSEYKMZRs7731k0k
X-Google-Smtp-Source: AGHT+IGf+cTOg4F0hrHoR0BIG5sBf2EpDaf9/wE0zTHe1c2j8df+WSLWwxBuB56wKCCNV1Nhwmt+IQ==
X-Received: by 2002:a05:6870:6391:b0:27b:5890:bd38 with SMTP id 586e51a60fabf-27b9d7cca72mr1541424fac.7.1725678206135;
        Fri, 06 Sep 2024 20:03:26 -0700 (PDT)
Received: from localhost.localdomain (111-240-109-89.dynamic-ip.hinet.net. [111.240.109.89])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d825ab136asm156961a12.86.2024.09.06.20.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 20:03:25 -0700 (PDT)
From: Min-Hua Chen <minhuadotchen@gmail.com>
To: didi.debian@cknow.org
Cc: airlied@gmail.com,
	andy.yan@rock-chips.com,
	andyshrk@163.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	heiko@sntech.de,
	hjc@rock-chips.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	maarten.lankhorst@linux.intel.com,
	minhuadotchen@gmail.com,
	mripard@kernel.org,
	tzimmermann@suse.de
Subject: Re: [PATCH] drm/rockchip: include rockchip_drm_drv.h
Date: Sat,  7 Sep 2024 11:02:59 +0800
Message-ID: <20240907030259.1243487-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <D3Z5JMTKPQIS.2M5O5DY0S4U9G@cknow.org>
References: <D3Z5JMTKPQIS.2M5O5DY0S4U9G@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>FWIW: I didn't see it either, but I assumed I was missing the right
>context (i.e. patches) needed to trigger that warning.
>
FYI

I triggered the warning by the following step:

install 'sparse' first

git clone https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
cd linux
ARCH=arm64 LLVM=1 make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' mrproper defconfig all -j8


cheers,
Min-Hua

>
>> While implementing my feature, I happened to find that I need to
>> include rockchip_drm_drv.h in rockchip_drm_vop2.h
>
>Makes perfect sense :)
>But if the warning is indeed valid, it should be fixed on its own (IMO).
>
>Cheers,
>  Diederik


