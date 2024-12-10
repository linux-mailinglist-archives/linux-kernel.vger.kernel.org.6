Return-Path: <linux-kernel+bounces-438688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA059EA464
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 02:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79C51282526
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 01:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E5A19DFB5;
	Tue, 10 Dec 2024 01:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGwJnGdu"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34736155308;
	Tue, 10 Dec 2024 01:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733794233; cv=none; b=FrP8a8xgWdn2M09dOEfCmbJWIUpl6nPkdua/mxMsVK2a8OAROrDazpP8fmmNYHqjZeVB45mNMnnLe7+HRyV5K2jQCCvevrc2eoAd17dgx3XQIXoGebaY4hwNG1+u2HQto/FCSuBnKuZtc2dH1LFrVk3s0zQxeO0pQAKIj708mUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733794233; c=relaxed/simple;
	bh=DUbLOQDRS/uCD9wQoNVZebUfm7GeL5XJwHgnz9Pasc8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mXuFlvb9q/LQ1WGkuiXm19n6TKziQxsCCCerexBNRGaElPaGxq/wMyYsw5Us9m0Z7ir7bieKHWNxkdNWKWf/fKlY7zuwhPGmcgdO9Yb/Slaf4fHuZRg1Vqy9zAMmeKU0mGp8JqhESPojNYhEB4RBZPbgOmo//t3+6eAjJNQ7rxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fGwJnGdu; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6d88d3d1eb6so48206676d6.0;
        Mon, 09 Dec 2024 17:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733794231; x=1734399031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ryxhFq/D6uK4o3TwTQ7Wdb4StN8ThF9XTxHXMGYXkM=;
        b=fGwJnGdudVZV1qgFDVN+9CH0z8ac/hYJHh+CBPQ4j8+rTh74s2c19A6XBjfIY0eM8A
         Ss5QR3EwG6YDWRyZe4NlTgAjeGIoqIqPGIUY2ql925iNRkGJq4XmfkdYTOy8xTVM/Sf5
         4S52ieo9ZpHo2gxN0+dkLQjRVWN7meg31GmFawtaDT43SX+FDErikEKMgosoLid/D7Xa
         A7vOd2JWOJqMjFIBQxkVY13rBWmfp6uHrASWvtr1hv5PAS0JeL/Cobgdy72PDOjCw4+G
         ShZuVFRA+FGRkm55c4Y+kbtbs73LH1GPjoaCHthg9Egqs00ixBJj563zDWbj+nqYK3t+
         t5Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733794231; x=1734399031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ryxhFq/D6uK4o3TwTQ7Wdb4StN8ThF9XTxHXMGYXkM=;
        b=FXKBegJXnT91Hs/PKurXsxKhzr2f7zGy7Y7eoGxdu1qiuPWaORpqQ+xzNLWIhTQBBx
         SlRYFDvUP46D9l8UfroaoEOGddLK5b1VuLVEd8GWxLpm8rn/vf75ooqax1gEgqtUVrq+
         +Kng2TxbzoprW62Rf2LEEohQlcWv752MUyKPVhKHbuGSdY8ofOKXqfxHBi/IrBSTCruG
         /yB8nTx8fXepZjMuVtwJYdMEwEtqmWDKvu/BhQL58bc2WHvYwBwyCKaaIbxVdZiVKv1n
         jKNUtQL5b1uSM0rF60GaPWHrxkJ+hYZPXPjLsJEH1xGvD6vYoLW1os1VmH7zZOoxMx4I
         2GgA==
X-Forwarded-Encrypted: i=1; AJvYcCWLj80ISvnRL6iZ2XgNRIUvJdrTMWwVngGBlDYenIeec4f565+Y7vR5552neLZFrtPKLPLfJyRKbD6IQGRS@vger.kernel.org, AJvYcCXOEvM4adXz3vjITR+A4HAC9cTa6+OMnD5fKDDxsCPINnCkvZXEjg3nGlK6XCG+5ni996rA1rS2v7D3@vger.kernel.org
X-Gm-Message-State: AOJu0YzJnYO5MEUFmHImNXFACa+Saaog9uFJgD6G+h6O1MPRGoQIP6de
	jEdXFLEVaKb5YbbMaFXpAVgrNAqXYyXcStE0OdUFmCT74c0aRamO
X-Gm-Gg: ASbGnctzFKaO4apnd/Lg8uAy+rwWlCSixsIsTxiRket0zrorJCgB6feymGp17WEGg1R
	TJSGbcqnit78+PJmUTQ2dJ4Iw3Xg75cwnZ9THzh41iVwFSJ7Y/Z0IOFmHpETsAoZfzNH7F0Lw9T
	o4GlvIesivL1g9R6s3kUPz2c/ZZtRxVrUH/cjvD8tggMm0SUTt4tvcYoq7vzxpjwV+TIicx1Vap
	9v8ihHdOWzOcI+TVDxZf38FL1BBOYTOrTF1MPJMCoMwjo6jtxtevrGhfjNOL02XaQ==
X-Google-Smtp-Source: AGHT+IGnHu4GKol3hVAzHldnP2oJaYa4cSwD67AUlgoZTcrdM6Y6t8bZ454xDQJ+meiSiuoKJRyJhw==
X-Received: by 2002:a0c:edcd:0:b0:6d4:287d:b8d9 with SMTP id 6a1803df08f44-6d92128fb74mr27104106d6.2.1733794230935;
        Mon, 09 Dec 2024 17:30:30 -0800 (PST)
Received: from master-x64.sparksnet ([204.111.53.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8f429a79csm36834346d6.72.2024.12.09.17.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 17:30:29 -0800 (PST)
From: Peter Geis <pgwipeout@gmail.com>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Peter Geis <pgwipeout@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Diederik de Haas <didi.debian@cknow.org>,
	Dragan Simic <dsimic@manjaro.org>,
	Johan Jonker <jbx6244@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH 3/6] arm64: dts: rockchip: remove ethernet alias from rk3328-roc
Date: Tue, 10 Dec 2024 01:30:07 +0000
Message-Id: <20241210013010.81257-4-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241210013010.81257-1-pgwipeout@gmail.com>
References: <20241210013010.81257-1-pgwipeout@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the ethernet alias added back in during the rk3328-roc dtsi
conversion.

Fixes: f3c6526d6fb2 ("arm64: dts: rockchip: Convert dts files used as parents to dtsi files")
Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---

 arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi b/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
index b5bd5e7d5748..f782c8220dd3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
@@ -9,7 +9,6 @@
 
 / {
 	aliases {
-		ethernet0 = &gmac2io;
 		mmc0 = &sdmmc;
 		mmc1 = &emmc;
 	};
-- 
2.39.5


