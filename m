Return-Path: <linux-kernel+bounces-517538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6329AA3822C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 12:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 003373B5191
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4282521A42B;
	Mon, 17 Feb 2025 11:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="MhHRHgdH"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6C4219E8F
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 11:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739792619; cv=none; b=tZMjDrN7KbsGvi2ynz/BjCchvRSr/hh1qvWl2s8v0HyvDajSzai01KlpjUUMp2j0ouXotsaGVYN9GROsHGRZk+hOtuF5dAVuh5EUjHDHw1yAiAF0yr8mTRTIOGs+EPYYSbTOQofJrrjaf6MTXPIlpLNisBe0JCtAyS31UHPsQJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739792619; c=relaxed/simple;
	bh=Jo1Z3lTHpP719r3iagWioDhuXVeVEAs6604CB/diJEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DsWUzijISIyUz8jdD+EsKdB2GZDbh5eFu+HleU5c9IskNlsMQF1zOq9RQGxNczT7Asr88Hf2NdChDffIdmvRuEy/3GNF/wxZuxdNMDKuZBJdvVuXaYCB8a1+WJnouhPJtC/bNnp6ruVqwalcb/1E1tCtFQVMHfcbBRWrLV4hjbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=MhHRHgdH; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4397dff185fso10187625e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 03:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1739792616; x=1740397416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvO6VVVrxL25G9tkhpz936tDjybjrpvtb36RnaeyFF0=;
        b=MhHRHgdHFHE+8MjhV4SeI9NC6maYXS/o1AG2pevFAc4NGb7Fllm4Im4dEvp8Ayu7PJ
         ZeU7sHXcPsQTmcYia+JdvwrQIogK/LW/cCc51rPKd2nUnplrD0snAaHQHDWMj+FzgZGg
         DxPLryJjPpqSsTtXiwGZbYU2LzhrD/8feGoAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739792616; x=1740397416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xvO6VVVrxL25G9tkhpz936tDjybjrpvtb36RnaeyFF0=;
        b=A4wy3McHPTPDYYLo4vm7Wp8KD75jIsfFa8A6QBDPdZs/CiXkCawZve30eFttLO7wPD
         3mEO7gMcxCfwmkOFMz8RBJXAxS4mslAwwArKpLGv8HKyvGK1bISV7AqCFvjpGB4KR16O
         HDKXxPw0xndFtnGQfPKutsSCGAJUBOt8vLINeQIJrCd6s+eHTuOxMGlsPbQrucTdnBQb
         G47a+MLk7/fiiO0hkFdmaCSr5vmTUff9fPb4FlUPhHzbdeDEmB4kSJKz6VdNGXW59SYz
         jplelDDe69lYsLB9ytpBDfnja89h9axIyVAfQfEJKWjWRnkZ8j9O3+gSs4l7ZHN631U0
         XRgg==
X-Gm-Message-State: AOJu0YwF3CpDyhkRJSxOyVR3xWODUzQW7TFsYWEpne7sonyIC7Pm1r+z
	cLG+L8StxOq/pXpWph4yWbZWt5AHhQzmBF1MMKsSV0iXX9QSCc38WxTCHP+z7aawGVQexPtqzNM
	q
X-Gm-Gg: ASbGncsNcXFkvIZeXschdNvBEQV/6FKt59DzYS46WELBB0pKuXbNiZnBNfkzrUghjBZ
	9HXmvWAkCAn5amrUQK8EwBXa3BdApdgIoTOTs8GnA9tOGk1iucUpFnkiwnkoxN6Z/8dQQ3sGBCg
	zwjqMLRCBdQ3U2gZtqlK+ORCPYgI3gWsBZBaFJHTNytGXVF/3ubTc2LlT1TU2sYLdyjNtKbl5mh
	GKBk5gdQDfJZ0c48blCH+xg1GB7FvZ0oQaIC/qAunTOyc2CGEyOJZZQWKN896mi8AfB5eH0eE4E
	/cDIGNt/WYpc0mDHr6jckatNMEZF7O/CI/GM3vYJHmq6n+OJodZMDSgZuXqNNEeC1D6k9lksztn
	mr0uDj/659aI=
X-Google-Smtp-Source: AGHT+IG1kMvLCwkIlZ/7WxOf9BHdIUQElSPpYHSnhNergf/DVzd0TcB4oDWYyjgd4zWn0XxpcWvmxw==
X-Received: by 2002:a05:600c:468a:b0:439:6ab6:5d45 with SMTP id 5b1f17b1804b1-4396e73742fmr77147445e9.28.1739792616186;
        Mon, 17 Feb 2025 03:43:36 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com ([2001:b07:6474:ebbf:78d7:ec72:38e9:87de])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43987088ecbsm18918465e9.31.2025.02.17.03.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 03:43:35 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 2/2] ARM: dts: stm32: add push button to stm32f746 Discovery board
Date: Mon, 17 Feb 2025 12:43:23 +0100
Message-ID: <20250217114332.1098482-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217114332.1098482-1-dario.binacchi@amarulasolutions.com>
References: <20250217114332.1098482-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add node for user push button.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 arch/arm/boot/dts/st/stm32f746-disco.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32f746-disco.dts b/arch/arm/boot/dts/st/stm32f746-disco.dts
index 8bdd10644bf1..b57dbdce2f40 100644
--- a/arch/arm/boot/dts/st/stm32f746-disco.dts
+++ b/arch/arm/boot/dts/st/stm32f746-disco.dts
@@ -86,6 +86,16 @@ led-usr {
 		};
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+		autorepeat;
+		button-0 {
+			label = "User";
+			linux,code = <KEY_HOME>;
+			gpios = <&gpioi 11 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
 	usbotg_hs_phy: usb-phy {
 		#phy-cells = <0>;
 		compatible = "usb-nop-xceiv";
-- 
2.43.0


