Return-Path: <linux-kernel+bounces-324733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4621397503E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DA4EB25FE2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D226619CC3C;
	Wed, 11 Sep 2024 10:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lzY/EZG1"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF9B19CC14
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 10:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726051946; cv=none; b=fn6fWwwBfXY69ozCM55yQW99HXEdF2HkKYwjSnS5m9iUgfhAjc1UMswdwB0ctUkzjPd73cGz2upvERl8MB5ZJCrynPFi8ZuAK9yN4DfAc1lfySdYKlA74YtgcpvxTb9c9XTJJq6NGvpCiQ23YimPUwC9FWu+YReOTWbqEITCQK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726051946; c=relaxed/simple;
	bh=qOuQg0DDsD+n5L9nc7IyguZnjP6TS9lpu/rn02ZrZN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E9kuR475h6OdqV6Oacvz4OPqrv9qmcBb66vWuVx9TJD8bynqsYISor0DPYxhB1+uAwrfKsLQw/ZN5z0wCwgBOmxnFi0vK+b5yZfZw719+LP748PMXw7oXG8YH9beEigLOf7rM1tO4vD/GwXYPdp023Zpky2dZneU7MZkgbJAMps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lzY/EZG1; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71790ed8c2dso5718980b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 03:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726051944; x=1726656744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rBK5HrwCcAQdUPHX8HmJCGl0lCk1GIRThLwD9xKBAaE=;
        b=lzY/EZG1Jb6i93DQTbPjhik2R6yxnOFhQotv5DyuxHe6VFG3v/3oHAVddgviw0boLs
         YXaxovColL3xqDiYPooMlFxxXdDLAxlXtbQW+UkKCk2coXNLHVixCh+NU7YbR1akmTJ/
         zsEcMknnCWP2dCK6aPPc/hmuRwBFnskof1KeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726051944; x=1726656744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rBK5HrwCcAQdUPHX8HmJCGl0lCk1GIRThLwD9xKBAaE=;
        b=jffC0GluR3vBATgh18jwcFKCFpSttgYaD2Fg+fV4FfX75aO4cZOFubY52oghlC2lQU
         Ayo52+lb14x5EHSx/iPmCh1nOtrQBNWdlTjoNNRbKotoXypti2EpfTg5l+k+8FgYRuoJ
         rPNSbH4oEIpbqZdVwR9+aEzkwMUkeBzsgvFFOVMlPvjNuRPHi0XKCQXJf9UzMDwRXK44
         us0WpkozSAUW9MhAme5a0XD7UtgcCVMuYnKcmhUW4zHGbLVOZFaVa0aaIpvHPAkMZzZ/
         xf0GT8p5Pwy2+q/vpG2oisHqcSU0gaSW3ua3wJfNZwGIEp7gQz041IfbW+qwv8TD416q
         92NQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcA4uY+sO95DpMr/BXbciaUw3jgeO20zssG4hUe9RSkYzAhH6lNMvLXqstllskH91V6xQ/oMT4jKzAa8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyyjuzU97gIjh6mno3ygoE8FMPZeMI7v4MYnueZehIaASBN0E/
	SZ/f9ZYQ3YmJC5PBU9SIQJPD8xeOBLgIQrlb1n2BdC91xXxFS/R0PWFyMKCuKw==
X-Google-Smtp-Source: AGHT+IG9YgMDxM6JH6QzsTZiuEKQdBS+aqMoSgP+yD4hhHJ4WT18x5zG3lCN0kR9XJqx6yodEhrX6Q==
X-Received: by 2002:a05:6a00:148a:b0:70d:2e24:af75 with SMTP id d2e1a72fcca58-718d5f06932mr27638808b3a.24.1726051944217;
        Wed, 11 Sep 2024 03:52:24 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:102f:d738:6069:fd4b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d8242b3d13sm7147352a12.52.2024.09.11.03.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 03:52:23 -0700 (PDT)
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
Subject: [PATCH v2 8/8] arm64: dts: mediatek: mt8188: Add socinfo nodes
Date: Wed, 11 Sep 2024 18:51:13 +0800
Message-ID: <20240911105131.4094027-9-fshao@chromium.org>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
In-Reply-To: <20240911105131.4094027-1-fshao@chromium.org>
References: <20240911105131.4094027-1-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add two socinfo efuse data nodes for the SoC information probing on
MT8188.

Signed-off-by: Fei Shao <fshao@chromium.org>
---

Changes in v2:
- Added socinfo nodes in v2

 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index f459e86d4024..37fd16691ec7 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -1904,6 +1904,14 @@ efuse: efuse@11f20000 {
 			lvts_efuse_data1: lvts1-calib@1ac {
 				reg = <0x1ac 0x40>;
 			};
+
+			socinfo-data1@7a0 {
+				reg = <0x7a0 0x4>;
+			};
+
+			socinfo-data2@7e0 {
+				reg = <0x7e0 0x4>;
+			};
 		};
 
 		gpu: gpu@13000000 {
-- 
2.46.0.598.g6f2099f65c-goog


