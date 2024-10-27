Return-Path: <linux-kernel+bounces-383679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACAE9B1EFD
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 15:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CB691C20DE9
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 14:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFA5170A13;
	Sun, 27 Oct 2024 14:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="kNoFgAm9"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FFE79C2
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 14:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730040426; cv=none; b=GqlKQ1SI7yzTiBi1Aj6LpNbGXHyeAJ5pPqIXrgaCyVTdqfQMDxdStT+vNxDCa/dtBIpqHwJOD3TAVCLVzy6G0mR8xKhKxbmQmCpQNFib6gJcqtuR085+E7y+bZZBskY1vg9y7OOWDsGYdFi8S0F1Ckjg1Mck2PQVdVSxeftJkAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730040426; c=relaxed/simple;
	bh=sO+w+fAL5s94WEBiP5UxfNlfvHOrE9sZu1guEAtuEEk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dD+REhYeX4M/PWvpcN6JbxKtrrNR9tRcno4v2Md1dKU6/nu4xUi9TsIVdFshMOQnPyi9wOTPU+Hmgd/zxcQP8lAQ0OyAhdr9utLkn3CEAkQemgaDWRrhysg1+GkCqZ4mJYQ5NmyFkbYabqdKmHtcYaTaX9rdAAePTtm+mfX9pQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=kNoFgAm9; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71e52582cf8so2490426b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 07:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1730040423; x=1730645223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4GIeGGDuOvllBO+Y9jQ/t9+qEbNG0Nmk817vsmjLiw=;
        b=kNoFgAm99wPRlhh+uyJMv+GXE/Wv2CvvZzAiHwinZxTzEaTnfZAJ+nKOSQlz7QU/nO
         vQeqjDXSPUQjEn731MRY3I3W01tuiSzLQu0OcPFDuUdh023MBuoyYzuhbqyT1B+OItP9
         6Cd1RQRRh+upytpMBjkV6oYoBW6KfAKj2/mAiZfF0pbhj1a43xM44f1TS+ypc+E1ktlI
         k4RCR4n06HLopPlD5RvGiN0dbqFKtYIr3OtTaOEQVDcweMRGOBAXh7UyvAN/D1vwr/XR
         iKQ5u3wyCEyHHRxrim3HFuAmikZpiuaeSO5DrTQ+ZVdoTHyqMGheVjv74RkyvumDeOnd
         69oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730040423; x=1730645223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M4GIeGGDuOvllBO+Y9jQ/t9+qEbNG0Nmk817vsmjLiw=;
        b=NEQ1x9ug4Dxt5+eK4KOxX89hrMBghuO67otlq+iTVAYY24qORm9N9eVbwkxLFJ1GC7
         WJerjqWX3An2phdGxZ31NKtQ16FBGjDcaXdhhZK59mgh/cKnolrN8Pdnr7jKgdnjdig3
         6UzsmtzJ99kiVw23YylSC7DOYLnzj+V0C4T1RJUV+0s3JUO0QhLY8MPzvIyTmG3HWiQT
         95U0OOiKzJn1sIvfjv5QJLO9GrZwNFucibXID7SkWrQDtk7/2cS7MGJU7auPaKxLPQeK
         sV/LzoVJzWtXe4Dz0ji+z5RuOjO5bhe9o2tLu0xRAq4d8CCFVEcFSkMYNSV8/nPE8/KG
         4tbg==
X-Forwarded-Encrypted: i=1; AJvYcCWtuwoDF/KHxgj6JuLAsz22mTAozMAWU/8ICSL+m2zas4hI9f9ziO3tCMUROKwAYANYZlN751x47xtgtZs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9FcTDqXLbIGw5nfqzmNfEAxjQa+UwaEzLaRNwXKg6Kt2yooKz
	FSG514EI2EKwLCG+Mb/JSCgDruFOU8Eur8KheWXGnABt26kKvBV2b6MO+/AJA6U=
X-Google-Smtp-Source: AGHT+IGc+yGjvgSTs9oPY7Y6tGkDYIk9TB4OVA42DSvWRUo5dUztajHsh/RICDMaunwtF0trrzElzg==
X-Received: by 2002:a05:6a00:2d8d:b0:71e:21:d2d8 with SMTP id d2e1a72fcca58-72062f836f2mr9281823b3a.7.1730040423607;
        Sun, 27 Oct 2024 07:47:03 -0700 (PDT)
Received: from localhost.localdomain ([2a11:3:200::401b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a0cb06sm4065110b3a.115.2024.10.27.07.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 07:47:03 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	rafal@milecki.pl,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Michael Zhu <michael.zhu@starfivetech.com>,
	Drew Fustini <drew@beagleboard.org>,
	Alexandru Stan <ams@frame.work>,
	Daniel Schaefer <dhs@frame.work>,
	Sandie Cao <sandie.cao@deepcomputing.io>,
	Yuning Liang <yuning.liang@deepcomputing.io>,
	Huiming Qiu <huiming.qiu@deepcomputing.io>,
	Alex Elder <elder@riscstar.com>,
	linux@frame.work,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Guodong Xu <guodong@riscstar.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>
Subject: [PATCH v6 4/5] dt-bindings: riscv: starfive: add deepcomputing,fml13v01
Date: Sun, 27 Oct 2024 22:44:47 +0800
Message-Id: <20241027144448.1813611-5-guodong@riscstar.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241027144448.1813611-1-guodong@riscstar.com>
References: <20241027144448.1813611-1-guodong@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sandie Cao <sandie.cao@deepcomputing.io>

Add "deepcomputing,fml13v01" as a StarFive SoC-based board.

The DeepComputing FML13V01 board incorporates a StarFive JH7110 SoC, and
it's designed for the Framework Laptop 13 Chassis, which has (Framework)
SKU FRANHQ0001.

Signed-off-by: Sandie Cao <sandie.cao@deepcomputing.io>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
[elder@riscstar.com: considerably shortened the description]
Signed-off-by: Alex Elder <elder@riscstar.com>
Signed-off-by: Guodong Xu <guodong@riscstar.com>
Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
v6: Added Emil's Reviewed-by
v5: Removed extra "From:" line in the commit message
v4: Added Rob's Ack
    Updated description
    Changed board name from fm7110 to fml13v01
v3: No change
v2: Add deepcomputing,fm7110 into model compatible list

 Documentation/devicetree/bindings/riscv/starfive.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/riscv/starfive.yaml b/Documentation/devicetree/bindings/riscv/starfive.yaml
index 4d5c857b3cac..7ef85174353d 100644
--- a/Documentation/devicetree/bindings/riscv/starfive.yaml
+++ b/Documentation/devicetree/bindings/riscv/starfive.yaml
@@ -26,6 +26,7 @@ properties:
 
       - items:
           - enum:
+              - deepcomputing,fml13v01
               - milkv,mars
               - pine64,star64
               - starfive,visionfive-2-v1.2a
-- 
2.34.1


