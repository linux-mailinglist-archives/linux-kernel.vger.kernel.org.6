Return-Path: <linux-kernel+bounces-512179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F068A3352C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 03:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 500F37A31B2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 02:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BB818E76B;
	Thu, 13 Feb 2025 02:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SyKJvh64"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5447187550;
	Thu, 13 Feb 2025 02:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739412568; cv=none; b=nqzvVM22HlliMioV8AErlipRvGX+Xu1efR9PEE+YPLhKPL91wXw6NygULDUo66YIfIwrJPmUpTeKpR26wOtpcblCjtF50E/nahmxXLpIdaNTdWjm9iVZxm8CYdu+ls26j0afrp2XPUz3Lkpa0Ro4jMNbk7SL599rRGXCnOKuJz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739412568; c=relaxed/simple;
	bh=NhnUO4VY33/Rp2hlD9lZ4FgNTSiuFYdXBAK1PePWIuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lshY1RtVud1PIEBQCiO7NH2Oc2SpQiQl+wKH9idoJkFf6ENdTz3/rztXFlw5W6JZalhVVmvGRFmNjpbWxFqDJImhWfhmnL0j1hSKwdOKW9h6K49vabN82j7cZd3FhgAsLHr8N/IISsFHgTw6IHcF3G8qx3ctnahhbJC8ZnRDlVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SyKJvh64; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c05dc87ad9so40142385a.3;
        Wed, 12 Feb 2025 18:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739412565; x=1740017365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vtFDrrT3rCYjoOZO0OfQ9Vc45JJv/q5OCfIu3p4OZZg=;
        b=SyKJvh64v5Ps31xvk3drirPqgm53Eeqs0Bswbwt0n9Ev7ojD7wo7h6OIcjG267dOWz
         fMqHUmLLxBXmpqArCBEyD9QllAgvzUKIfrcn4hB0SFZKAZbjzTaWI7cnc+gNMruv2KyU
         ludHN/awGRY7+yTRriLxTJdNbKf1fLWe9PIJvNhxS+TKMEXL0yhJz60rOIxO2agCsfsW
         gkT/KgpCwJDyqBICJw3iRde1qiDuyct0lyhdp592SgixlahIQnBpDyb8QNTagq27fnXV
         jLxaQRbZ3iVsnC/m9tWHarzlDabXQNI/4raCOftWxUq0xRe0I19Y6DxyklY5qbn+ADGF
         /bOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739412565; x=1740017365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vtFDrrT3rCYjoOZO0OfQ9Vc45JJv/q5OCfIu3p4OZZg=;
        b=ctghUGOz9/IeS+2ljXZCnOuEv7mO0E472ybp6Z3IHMrGHSUq3FSuFOb+PVcyAdR35R
         Pk7QfJzK2oLlPwbKkCzE+k5IeCyKvVojP53d+Y2Z2SkJS7+U46aMY8xfkDx7E1V2yB5Q
         4+uXw2WUlgnTnKXsCb0qxonMRpjhReLPipPlwruyN9/VmxF/O5xb00Whthg5aXA4taLe
         qK7DV5Nf0okqFAw0Ucjk/FxDlonbhRBABt5w3VM15unNzjnw69LL6CAFGpRmydmdTRhc
         n3NKu1XNnnmI2M8WTDUvyChXOkr2027EnrgB+4ov0Lg08535BoS79Sbdz1Ctcf9K6xEc
         HF2A==
X-Forwarded-Encrypted: i=1; AJvYcCUF/01xZFIxH7sr96v+0pdBBW5J3pcu7sKrZ2xSdQgOR+idL/VN7DpSbnDFvh+uGtsGbKjnsSZmKl/SfwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuY/0ETKkXPBE3jFKT1JDu0zU/O9Z0k+g8nP8QPcm8MvmtDqsn
	3DwY3hh7T5uhEOPiTtkKSdGx2pzZ/43s6v7G8+a8sCMu0F1Dx/SS
X-Gm-Gg: ASbGncvFft3KyFa2FCXUtZ8J/Ay5f79yR2BXz+Mm/sCdXEjWYsr7/J8h65DUroJf8al
	Hk3kOiqCDRNtrH/sX7sUCxSaKHX0JZ/2MMT0K8Cy1yxRvSjPNeNvD0PT8aXFcO6Bhqf6Q16FAs7
	HMoMW+qtabeDHzE2UBUqyiDychwO00jGNyu1rVlWpuRq1xo3ImdZJjbyNsROKIIC+qpxLMwCt/4
	PM++jLSLKdhw6AEamMJaLvMeWO+b96O5oWCPLNraroDQzrQXiYfJGqH51HrgaSSG88=
X-Google-Smtp-Source: AGHT+IE0LFF3/PieQBcv+/M0s57QuYZfV0AqSx58CzpD01bEJ/HlCWgUX1jFHn2Bh1WE/RrZetIfow==
X-Received: by 2002:a05:620a:4894:b0:7be:6fd2:938 with SMTP id af79cd13be357-7c06fce2424mr1035985585a.53.1739412565595;
        Wed, 12 Feb 2025 18:09:25 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c07c861552sm20492485a.79.2025.02.12.18.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 18:09:25 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Guo Ren <guoren@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH 4/4] riscv: dts: sg2042: Adapt reset generator for new binding
Date: Thu, 13 Feb 2025 10:08:57 +0800
Message-ID: <20250213020900.745551-5-inochiama@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213020900.745551-1-inochiama@gmail.com>
References: <20250213020900.745551-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the SG2042 reset controller reuse new binding, change the device
compatible with new string.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 arch/riscv/boot/dts/sophgo/sg2042.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
index e62ac51ac55a..1e29f5975af9 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -499,7 +499,7 @@ intc: interrupt-controller@7090000000 {
 		};
 
 		rstgen: reset-controller@7030013000 {
-			compatible = "sophgo,sg2042-reset";
+			compatible = "sophgo,sg2042-reset", "reset-simple-low";
 			reg = <0x00000070 0x30013000 0x00000000 0x0000000c>;
 			#reset-cells = <1>;
 		};
-- 
2.48.1


