Return-Path: <linux-kernel+bounces-348637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8750F98E9F9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6D891C2209A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE8B83CC7;
	Thu,  3 Oct 2024 07:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T+vBdrG5"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2EE83A14
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 07:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727938911; cv=none; b=KJYl1PfDWTW7RsUAo28SDtyEEGjZm2oWJysCJRcD4MNOYLGlStrFNOxAJUoBh/fNpjvBzxljJsyV/lYShEk+VPNOtNza3ArzdbQyrf6FyFs+3hSxC7D6fX6RdRFKKHdX+6RaTAH7r0azRjoYlh/NA7230jZh8PzabHXyuumGAeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727938911; c=relaxed/simple;
	bh=8UypYrlWqk4JErxk8uVv4PjIsoX+682r515rUWNlgKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uf/sSqTz4anzw+QJ9W9tWso2oIQa3u9riFwE7xobzG9EYn6z6uZHBJmCtszLxXUez6EyNkWXp1Nk05DbliJTEu5dfCA2pdqsNEeojSaivMRFmRVqlPajWJ1+ZYIfXwnshk57prZW8o+g+ka3bGDmwHJZeHCegpon+RTaXMk00NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=T+vBdrG5; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7e6afa8baeaso479165a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 00:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727938909; x=1728543709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oe/n9hHH0mKojPtYx3rZSCjoPpBX5CErclQAFbwUbmw=;
        b=T+vBdrG5qNb/JbdR9bU6I/Z+OceRF3Wn8FdB2lb5Ic5BHaDASu3WnqRfh9++bjaw0u
         p3b/l6zZkmSMfqWQ+bzLY93b+Wm5driu0OIrdvy0yG+vuc61b6I7kZbYwqSlbZnMamHs
         jsLExpK3xSI5WkEhkNkZXQPZdfEhfdFaALVIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727938909; x=1728543709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oe/n9hHH0mKojPtYx3rZSCjoPpBX5CErclQAFbwUbmw=;
        b=oalhmTQ7QHa97haoe7UYuTj0OSFziJt2F2d9iRLvEBWaZnwlKyPUn+EhiavMFHWJKz
         L76iUaS9/Z9suRIdwpHfbPmLDbr71aFcc12fws/RgrpZ+rsdMCKMwtH7ryG3txF1wpsG
         b3HOlFto+EXPguTRXbyLD5fjgvmTSvvW4WVHXlNmeXtRaA0NurFGCvoBU/kKMmVVOCbj
         jjBCd47fpQg+7J6b7pvEL6iKBV7IpDo3N9WwsfZazH0SqZv+Td1qcYCwJi4EWRfd9Ti/
         Q70bzDAYaN4qg+dk9cj0+RHAocEdYNS/zY2DJbeNxwfDY4eytq48tHINrNzkcOq0cvBX
         beww==
X-Forwarded-Encrypted: i=1; AJvYcCX1CRvqsviNGDe0/GvKO5HxFKxkwZ4CsQNnF38qXV501XgbV/OLecFu8JgrFxPCBsMxunPBEBpqVGPQbKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6pWlVd0k5zQQBshKlugIBZ0gZNYy7ixbayVAckYYsz4rtuK+N
	gpDtFl0s5vCEtk6i2VpYTLCb6J11dUqCqZAxD6s0wXPU0YeBCgtdRyz500E/gw==
X-Google-Smtp-Source: AGHT+IHnCV7kmSOR4DccXhZDS0a+MPrHfdhqHJncrbL+gRJDUqEcGORVVOObqAVae6mIpY+s/kJRIQ==
X-Received: by 2002:a05:6a20:c797:b0:1d5:388f:275c with SMTP id adf61e73a8af0-1d5db14c8d3mr8114513637.20.1727938909295;
        Thu, 03 Oct 2024 00:01:49 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:3bd0:d371:4a25:3576])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dd9d8e473sm633782b3a.81.2024.10.03.00.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 00:01:48 -0700 (PDT)
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
Subject: [PATCH v2 1/9] arm64: dts: mediatek: mt8188: Assign GCE aliases
Date: Thu,  3 Oct 2024 14:59:55 +0800
Message-ID: <20241003070139.1461472-2-fshao@chromium.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
In-Reply-To: <20241003070139.1461472-1-fshao@chromium.org>
References: <20241003070139.1461472-1-fshao@chromium.org>
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
2.46.1.824.gd892dcdcdd-goog


