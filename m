Return-Path: <linux-kernel+bounces-347415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2088B98D26C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51B661C21651
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 11:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E31200107;
	Wed,  2 Oct 2024 11:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bpZE3VUo"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379AC200104
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 11:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727869613; cv=none; b=JUw8wbNDSEKFNeZqcSweFNhffNNwUlHu4WqZxKuqkYjt7XruZ/Y/QGEelEKSkE3HGScX1y72MF1p7RIGZiBaNLI05lr+7WvAyx/Ug3lrEr0iw8g7oXvZnGGb/4RHOv1DCbGauP3dANCsD9XtEGfnkF+Sqxb5aMugpEJiv3ErA7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727869613; c=relaxed/simple;
	bh=QTGH4vttplaUn43XLxb9PnFRDrlWhMRsg+2iEh6QeFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Egg/Q46OqIVJdMdQFmyVPJjT2kpUCpSpw08tWW13EHO+LG5JWcYpQuGAKJqDC1AMcYoIxgwT6UXTJ/c7LcOxREyq0KyBVcR7y9oW00wUGGk5cSpxgMSbt5kE4Qu5hyMCMfer0RI0NblokyzRQ9isxTseHCvwfv5oA2fDy+66wZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bpZE3VUo; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71dc4451fffso1120081b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 04:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727869611; x=1728474411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JAY/dXsUs9CkME3PSfZ8rKUo2mav2/+CmW1Y+16arGU=;
        b=bpZE3VUov/5UoGGZwz+Y3lStaMzCQWeyZIOBaTBy6rOvqFoGECSr1zuO9M0aEMnfGJ
         HUEB4zgLK/09VjrY3IkHdEiku4maGLYue6dSGIDAFk73FajvkX0+2wR1QGS+E9pvxcAW
         ELmdQp+T/tTFopfTzq3FpIIBV4LBQs1qSHqhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727869611; x=1728474411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JAY/dXsUs9CkME3PSfZ8rKUo2mav2/+CmW1Y+16arGU=;
        b=l6wu9LopY8aXJ1AjMw7Zu+rB5xy6TdGkAMUt3eX+ue+h9sCCKkdPcpK1S6C4ZqrOM+
         GfWPyAFdgV3egW1p1D3pz7q/x4VHgZgnNeUqWa4/RKE9+t4AFvXYsCMOrzRysb4IDq4S
         vY6J5edGowyDyFXayvy4Z5hbINaeZmg7DPHaXkRfeyp1hZzZytQGpV8feK1XbZ6iecFo
         6696418X2CCzArQkNnk2FGmDZH9s7cHea7BN3aFcW7WK9ro9+SecmkCsWg97oWGyg6gq
         pec1PBUJI2C1E8VmiqaUX5BWxsOJYWFZy+HnhHaHDZI16M3cafzD7Ubkavv2ptG19vDO
         jmCw==
X-Forwarded-Encrypted: i=1; AJvYcCVmP+yBUHoKuT5OJyTTVCg8j1kh4CihJkdtDwrcXBHEa5TqaJ6+SPVCDAzo5k0IPYY/zVZsc38hxiQMa7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRdxsWlZSkYdzHug1gn+7CwmAfZ6HKFnTpYPDGXS9+w7IkYb/S
	a9271xi7nVKDYkIc501jQ+j1Z+T5UQdidZB1MjAtPm5JYfTHp96JjmBYy/TrYQ==
X-Google-Smtp-Source: AGHT+IHSlrdMuVKexAIEnpb0LlSgDCgS0LJ5jiyqKYhPJ24XMB513q/IRWvodzvlblB9Cry7cgSZxQ==
X-Received: by 2002:a05:6a00:198b:b0:717:950e:b589 with SMTP id d2e1a72fcca58-71dc5d429f1mr4913086b3a.19.1727869611476;
        Wed, 02 Oct 2024 04:46:51 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:3bd0:d371:4a25:3576])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b2652baefsm9639627b3a.180.2024.10.02.04.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 04:46:50 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Fei Shao <fshao@chromium.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 1/9] arm64: dts: mediatek: mt8188: Assign GCE aliases
Date: Wed,  2 Oct 2024 19:41:41 +0800
Message-ID: <20241002114614.847553-2-fshao@chromium.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
In-Reply-To: <20241002114614.847553-1-fshao@chromium.org>
References: <20241002114614.847553-1-fshao@chromium.org>
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
2.46.1.824.gd892dcdcdd-goog


