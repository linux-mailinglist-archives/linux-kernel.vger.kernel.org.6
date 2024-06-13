Return-Path: <linux-kernel+bounces-213157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F24906DB9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 457721C22AE8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBC2143C52;
	Thu, 13 Jun 2024 11:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VhM/Gqmj"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314651494B3
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 11:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279950; cv=none; b=s+JVRw1GSOxOKatvzqYWOGHday3jPudbPhprpWyHv/pVmfQyq2gcQWeIr1TkN6kjg79GQgpBGNRdo4e75Q85jTYwLTGykk4qh0fO89WJYOo24I5/mNZpwIakL4IdLg69xhBoOfK3tG0BRtwe2pk+EnJ3msDnfpjKNMsO+f5ZD1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279950; c=relaxed/simple;
	bh=XA3LxLv++dOYbRHQaJqJk1tOLTd7fkkXOPEi1MhFA5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=phMj57pcZKtt3w54j05GU/VC8/bxyEVM8JqLJBkG3A06fHkGjgFpHdHnGNxBhl9gp4Tomv4dvaGqUm70H1Imw3jqOKywURh1GJoeqSlcL5J25Mhigxsek+ykVj1nRMCFeybQJz3AapiwHMO8d47gzObYMDg8mnsMDXkdKWVDavQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VhM/Gqmj; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-6bce380eb9bso558965a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 04:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718279948; x=1718884748; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6xHqGzbGEnyXYOufhYAT+1jOvdAL9AF1EdfNf7hRahk=;
        b=VhM/Gqmj5Sk+iKoMxUn182nhiKnlhswED2r/JucIutDDU+0o1DOvyhpfuY5vOCc5P7
         ZXa1EpODmbECGpa9bkJRZdqF5XyW3ooQsbKYUlvM8+j3h3K9o69ff3cPldq65vz4Fkzr
         mYba7ydIURhr8utka/7uLIGxJVfRGgR+2QSWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718279948; x=1718884748;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6xHqGzbGEnyXYOufhYAT+1jOvdAL9AF1EdfNf7hRahk=;
        b=Mv/KX531Ht/3bTvSq+/5eG3mZceyVeoOdfpJEaaFMzo4sSYkZphPb7zDX++vhZnZqY
         ccfK9jh9o5EGPDiy+mfSX3rF8Xrs17AxaRoiukP48Dwt8tc6Ouo7Ht++cqeVXeUyoW2C
         DuaLfA9JIf2Vx8O7Ikq1tsX8ajTsHZV9IUIJbjvbJbCTczT14OQhwrxSyC2p9z3iO80Q
         uh0Z3yT0skYpKgxB9SZDGy6VlmoCi4Sr5SorhsaadVSEccD2lLNgk6KnfTVRho6R6Lh+
         ylAQzhDoClKTbGriYisGIqk4YDTwJtqdgbQrYsZ7u8vgXd7JuPDt2lrx9aflf3Q/7tY7
         bg1g==
X-Forwarded-Encrypted: i=1; AJvYcCVQILVQlFwwHm0wKuP0cQOE6o2p1U3Y4302BDeSZqgVPnGFUVWzfi32uRVI9PEZUzn0nhT1hd/KO+WEytj1GAA4aJgNhSMn11JcAUnp
X-Gm-Message-State: AOJu0Yzudmr6jS3uOFzUtxxr5VHyDJ0OhPcd+Y+8wyObzr4635afQm33
	b2tAV1qUiYapILAfAlE9UOUKNwDkWLDTJ4jKP7cxvCmt39IqrsnNtFMvIy7SnA==
X-Google-Smtp-Source: AGHT+IEUzLyoz7lt27fPBDlUwSbmLIUoS+0m0haC8TQCTmDUAzTepAUQd32xctUWuwr+KsV5RI+pwg==
X-Received: by 2002:a17:90a:5d98:b0:2c2:4107:1fc3 with SMTP id 98e67ed59e1d1-2c4a76d3777mr4729921a91.38.1718279948594;
        Thu, 13 Jun 2024 04:59:08 -0700 (PDT)
Received: from yuanhsinte.c.googlers.com (60.252.199.104.bc.googleusercontent.com. [104.199.252.60])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4c466c3desm1453505a91.46.2024.06.13.04.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 04:59:08 -0700 (PDT)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Thu, 13 Jun 2024 11:58:55 +0000
Subject: [PATCH v2 2/2] arm64: dts: rockchip: rk3399-gru: Fix the value of
 `dlg,jack-det-rate` mismatch
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240613-jack-rate-v2-2-ebc5f9f37931@chromium.org>
References: <20240613-jack-rate-v2-0-ebc5f9f37931@chromium.org>
In-Reply-To: <20240613-jack-rate-v2-0-ebc5f9f37931@chromium.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, Hsin-Te Yuan <yuanhsinte@chromium.org>
X-Mailer: b4 0.13.0

According to Documentation/devicetree/bindings/sound/dialog,da7219.yaml,
the value of `dlg,jack-det-rate` property should be "32_64" instead of
"32ms_64ms".

Fixes: dc0ff0fa3a9b ("ASoC: da7219: Add Jack insertion detection polarity")
Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
index 789fd0dcc88b..3cd63d1e8f15 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
@@ -450,7 +450,7 @@ da7219_aad {
 			dlg,btn-cfg = <50>;
 			dlg,mic-det-thr = <500>;
 			dlg,jack-ins-deb = <20>;
-			dlg,jack-det-rate = "32ms_64ms";
+			dlg,jack-det-rate = "32_64";
 			dlg,jack-rem-deb = <1>;
 
 			dlg,a-d-btn-thr = <0xa>;

-- 
2.45.2.505.gda0bf45e8d-goog


