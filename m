Return-Path: <linux-kernel+bounces-363914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3226999C86D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D4511C247D3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADD91AAE2D;
	Mon, 14 Oct 2024 11:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Yj0BzIXs"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A64E1A7ADD
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 11:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728904277; cv=none; b=Ch5aZQ8Ku5xxE2xLizpLM0E832Ce37XtdgYzMGChDoLc9fhdwkx+WO/P1Vi2cB5urus2sXhX7kFvckw9Z2itVISF8is1dkLXE29BxY6UtfzzLNCNpKB8Lwsq1IoxTe8vdvJWU2Q4gD6rLPG/7mXn7UWAwmHnRjG6aPPyqLLFCaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728904277; c=relaxed/simple;
	bh=N6k3MjZRAPFaEyNmKluQmUs0Nkj2AbeajjN9nA+46hU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vFq7nWnGPvlHXSw4UaTMR2bMMirxBc6OWzIDHPkG0t9tLyU1Du1EXgRQKaJSLmzZzZCqkz7XcU4HFu5GB9eP16rpYal0fi9VjlQT0Ui6Q7cK96UER9C21DV7rsVM9rp2Rx8yIImxzltjEEO6qt+Z3GCznwT7aH2i1lgwWMIsbnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Yj0BzIXs; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20ce5e3b116so6524425ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 04:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728904276; x=1729509076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/b5fPLxKnk8ixP+B6dTshS60Kk9g27O3Ki9J1RjhYRQ=;
        b=Yj0BzIXswpHGQe8C5pmvGQvUPGy+Xs2i5kidw7INYMVykv27wfyfrwPqGHGDqFTmf9
         Xh/Cf8XBC2Y/kJvda2IMaHYb+g7hal3KP0sXzJGcNi0TH7wSxtPFjx4iyqgDaWr6SmmC
         VKP5iyTuQkNAQ1DNlr8q2L6M7wb5I+9g8qZl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728904276; x=1729509076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/b5fPLxKnk8ixP+B6dTshS60Kk9g27O3Ki9J1RjhYRQ=;
        b=Qy355YXJExgObMwvnNmsC+QS5v/8O4EAyYZ6JhQb7aaWyHkeZdmJjMtBC9lj7/DMoi
         6eMpg405XZncsZOnb7vsa+7alSU4J0/49rv/XnxDJPoIIOiKy+GFEPTn63RwPqpmWGtH
         27AU43YW+AmXC62vMb5d+cJ+81X6pXUuBRdrFJGKVt0dKjCnTvClo+iZH7u1s/PHJS+H
         kJa3Q5N0YDFga+y2sBUcBOvoDaRqjZ3+XlbF7dg7KSzq9E1l2gadn+hhBbr8FjDQOipN
         xmIluxldt81W7enA3HgSeeoYxkw85BKqcZypgdHaGu4V2pSIoj1rS6Qiry55EZ+Q1Mar
         6WKw==
X-Forwarded-Encrypted: i=1; AJvYcCWFMIm1CRF0AgdAfHZ/R79ZM1rm9Wz25kvr8gHAurRBdqXAKDK2yWMjTm3Snkejj7t4Ny6lqDDMAZO0z00=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDz/V+f8qG7oo12eWmpLlT4CQva95/FrLGrDsvTNNEX+ukLMSn
	UJDGa4+td7w/avzxzuI7AfjszalSQpD4gZ49q0M5fSdW8PF9fDLlEZo1AJNqsg==
X-Google-Smtp-Source: AGHT+IFDRAoJ7Z63lA0MZEZ+CdOcVFusjWYuKIU0aUZ+jje6f2o/eSKpoKgYTvF5qObMc6WriIpZSA==
X-Received: by 2002:a17:902:d48f:b0:20c:f9ec:cd8a with SMTP id d9443c01a7336-20cf9eccfcfmr31699065ad.7.1728904275775;
        Mon, 14 Oct 2024 04:11:15 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:4907:d52a:1a1a:58d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bc3e6fcsm63858285ad.118.2024.10.14.04.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 04:11:15 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>
Cc: Fei Shao <fshao@chromium.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v4 1/9] arm64: dts: mediatek: mt8188: Assign GCE aliases
Date: Mon, 14 Oct 2024 19:09:23 +0800
Message-ID: <20241014111053.2294519-2-fshao@chromium.org>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
In-Reply-To: <20241014111053.2294519-1-fshao@chromium.org>
References: <20241014111053.2294519-1-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create and assign aliases for the MediaTek GCE mailboxes.

Signed-off-by: Fei Shao <fshao@chromium.org>
---

(no changes since v1)

 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index bf15ac9901da..10195a4e4e9d 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -23,6 +23,11 @@ / {
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	aliases {
+		gce0 = &gce0;
+		gce1 = &gce1;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.47.0.rc1.288.g06298d1525-goog


