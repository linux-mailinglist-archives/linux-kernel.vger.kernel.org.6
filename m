Return-Path: <linux-kernel+bounces-170095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D09E78BD1CC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 17:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D0AD1C21C8A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C0A155A59;
	Mon,  6 May 2024 15:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fwn/3u53"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276E715573E;
	Mon,  6 May 2024 15:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715010676; cv=none; b=fyarYlH3p2o/At4EWgZ30Aq1BN4CDoUgZnfR6XE2rsoLzdlJTxh7o9+PWwz8cEkbHM4eASwaA9wdnr9kyu5csUJG1Qm2QhldsdOB5QdY/4Rn6rlUXxiWwZ3xU+13IzzxZulCy6GxCKLwuhGORIGKZsvy2F+q7b5T+85Wr6ClOB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715010676; c=relaxed/simple;
	bh=pkw/VG+9hXfYiYxsbX8EtPzi4fCCqjOQh1Apk1PvvAI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WlV47cFfksUjiHOMjM0Fgi573mesqOWfS394+PtqWemmJvwEUlOjgGAzzVaWDsTEgK6MjNotfJAWe3epViUQcRLM/zFZSvMoAXERmVZEL2bYfW2BNGqYPqxcxDtvbEL1Z2OLYx3fBsYIfvTWSU7GlXBuLHcvRPnXDxLf/yhz7Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fwn/3u53; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5210684cee6so221899e87.0;
        Mon, 06 May 2024 08:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715010673; x=1715615473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F43+VbbAv63CP/l1KaJY4c5FRRfWXW7a7BiZxJ4p6TM=;
        b=Fwn/3u53/qra9/E0510fmyLjJQ22HVD70kx2KqGPb3tHCLCMpzrwJNn9z3t8Wls1vP
         JXWFPC5sImYgYRkX/KQ7LzEQWa0nrsdJPfE2EdeQON6VmXXr8qpLox1vNR1mW46KgA/d
         ltQt+JXtqbf62BWnDN1oZuG0c2YdzdA/ZrtGNahBUPsm5AW8evDzR+6OWQ/k7UzVfQHX
         eurT1QDj4JZ7/u/i3flPof8H6KjwVpVxHxsmE1MmZbMhAFbl9MZ+7yAHh2lYk9Ljg2+S
         Fhusr08E/2DtqQlJrZpdnk8vbTTIj81IEjnGOJ9tlwdqL6ed4MuwWyum8B7b7S5W2lOk
         1dMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715010673; x=1715615473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F43+VbbAv63CP/l1KaJY4c5FRRfWXW7a7BiZxJ4p6TM=;
        b=MfVpDWKDTzSnneH7dGSMnSZMvB4ue4U8cdUwfx4U5L0dWtMvAgzBRz9YS3RoCOJaaA
         xNPJGjTizbmF7d3PUWi3xVdbPAFQAJDC7rIR3zjyoq5AeGmd9HGfzIhKjaU2aCIb/1Hf
         8UFb0mm7qWOsqcc/FjmT/6TtSKffFqHj/evG/risG3lgBUSr2ftLiqhI/OfMaZfraejY
         UU7cDk9iW2gY59QvA1MpSRfcW50UXU5r0R9bB7/jQs5ylxccRgEFV8bp/g05FE1MR9a4
         PUrUE/SAOKjKB0YyvJeb7AUl+7/CACNt7vpMjG0QDWRRxuRvxoNuQ7vLwflp4DKRGFU4
         hvlw==
X-Forwarded-Encrypted: i=1; AJvYcCVPEm2mzqpb20FcdnRxQHA6V9VtrGopgAobU3tDMegNeOb4Mmu90I9Gu+6vQq3gbvGEjhIDIVpKEZsGvjzh7nM4D2lX9e3q9i1JRhsx
X-Gm-Message-State: AOJu0Yy9kdGbpflRTKvEzGUih6XxFcGhfgctI+K5ytqrCrnW4K3xyZMv
	AZBnt7jt9FhxuPXd0drJVL4KDov2wdSQDZ98puV8qtxVQ0qWMes=
X-Google-Smtp-Source: AGHT+IHylqTjWnk3bFeb8qCldzxVbY8wXHbt8BdYQi/hoIsi2Vat6SeNEbpUVpTgcIdugVwGm9wVSw==
X-Received: by 2002:a05:6512:32ac:b0:51e:543c:a45d with SMTP id q12-20020a05651232ac00b0051e543ca45dmr7353602lfe.20.1715010673176;
        Mon, 06 May 2024 08:51:13 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:1c62:e77:6753:5729])
        by smtp.gmail.com with ESMTPSA id y24-20020a170906071800b00a59cec38bf3sm1356230ejb.52.2024.05.06.08.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 08:51:12 -0700 (PDT)
From: Alex Bee <knaerzche@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH 0/2] Add RK3128's sound nodes
Date: Mon,  6 May 2024 17:51:01 +0200
Message-ID: <20240506155103.206592-1-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RK3128 has two I2S, and one S/PDIF controller. They are already supported
by the drivers and covered by the bindings. All it needs to make use of
them is exposing them in the SoC device tree.

Alex Bee (2):
  ARM: dts: rockchip: Add i2s nodes for RK3128
  ARM: dts: rockchip: Add spdif node for RK3128

 arch/arm/boot/dts/rockchip/rk3128.dtsi | 41 ++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

-- 
2.43.2


