Return-Path: <linux-kernel+bounces-535155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B3EA46F9E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5507B3B0121
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 23:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E06027002A;
	Wed, 26 Feb 2025 23:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1VihLE0"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2F627002B;
	Wed, 26 Feb 2025 23:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740613398; cv=none; b=TtM9ZCIQnNuNA+r9Af3+Jj1K0DQ/fnssKxvoe6T7TwYJsmJyvDywPulBHPxZc6ATZefEcuZZplMljxf6uf7QhHAUazxY3xVTAsrE0IZSIQkl8+H70xDDadLaW5/qukRTfob97VQ1M33Md5+I9HxAyQpAJpjdMzmuko4Rr+SsyBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740613398; c=relaxed/simple;
	bh=Eh0Eo/Fkv7rimj8T89jrNFf3IIi3ia63rPOLD+dghLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C3Mo6Z//qw3GMTbYMzgVAFUNA7+HJmgOVnF7VLDbtKpldg6EwI+3rtUJjpNJD26fPF862go5yj588Q32iCKRGRJeOTtG/2Ri4wq5r9UOGJoYHqVqPBnh7Kq+AemD1t2Fe5SFD6V6vxbY0/st1pc9HfFXiYM/dv39tQ9jztLXxWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1VihLE0; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c0a159ded2so33504885a.0;
        Wed, 26 Feb 2025 15:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740613395; x=1741218195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2BPCE1EwJy/+4tZvxiVTXnB1pR5FYwCTo9rAvyHj8R0=;
        b=M1VihLE0to+xyPNWI8fNH10ahZ/gKMMyevUwXZbFqgIaz97pX0aTScraaY8NV2HPcW
         LJIYkz+wHYPrkWdZW0H5p4J29IMHUsWa8vs7qQg8gKR6acdDrrzjKtMwQS4xgBs5OhNf
         EiRl0RuVxtk7oTfc4Tsf5vO0kMVeDW+5dhIS6kEWkQUnETdSEVllHewW92+INXklEZc6
         q60Fv8nTD6yYOdbjH7aBpKbTeUz21pxczWGNQsuMJ3qEHkBwv952qEhjqjWCa3y0oMkR
         dJEmrulssFlu36bFY7Vc/NMovAmkRagUioG2UtSSmsWFews5Qaef0wxMjuGVGYmhBuvF
         utQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740613395; x=1741218195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2BPCE1EwJy/+4tZvxiVTXnB1pR5FYwCTo9rAvyHj8R0=;
        b=O0CYM06iOfIl7odIbA0Tnp/92W/7MGbONjwg+mtTWPs7thJpXJYzWhlpeaQMgD1YH2
         BrIP798IqPYZ8Zqn/rarF/z0wcKeyWW5P2XvOXYVzbR3ivY1umC0Dto5PJOZOvm6nMz+
         6zxsb5KdN5qIdFPY+YcP9/4FuBok1PxcVq3c08btxPBT6TBMWO4z08ZiQ7hui4Ai/vxL
         4BaiDa2AZq74jjdwAyG5S6PrEdW+d7atv25ieRiQDt6pOUap30GG64a8xfuahYH6ZHjn
         aGbO9Lvz++UYvXZ8KOHhcddtJnR76E5VCwYZuzqvDmVhnpRbhCoSf1y21W9gWvJmcK1n
         8DMg==
X-Forwarded-Encrypted: i=1; AJvYcCWsIGYbCxZBvFtvDPAo2pgfo7+5VWCMCt/RHmmETXKeGLWjuVWrjjpiIYT88q32N1l2BIETq/KNH1xktgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvDla1i8aOyYW0NQZug5K9roLOLinb1KuiRW8lc5h0ldXZm6yC
	s60tsJk623WLsZMR/s+VDAE2UU2cpfNOvuuCGS0U2RCj4tp3gP/E+ddv4g==
X-Gm-Gg: ASbGncunODSnezBRDqguqQhEPY7gH1J8cvg/kiYal34VDEnGEU61rD0iq9M/Vpao2rK
	LmKjsYU/lnmld1zzg/DeZ80nh0gv0vbiEqGyurh9d9z84KHzSuc47o+NulokIbKKBVi2rXENAXL
	ADD7UF5N3nxWKlXfzFrcF9DRdt6lIxs8mYW6uJ2076M1Q99Rnq7x/cjreMbGP1PnCFqglkF99qw
	DanbJnUkr8KZP5mhAiTJJSeN1zqxhBToZ/GGts9RUZiE88oPGiAw/gK/Kh2KQiT4quC6mjMAW6i
	hQ==
X-Google-Smtp-Source: AGHT+IExZ166ZnKNMVp2sWPEye4nK9gUSWKtplsD+DW3kIJ2K1CBVm+kQQbvv+biiRYF9M4XnPhnNw==
X-Received: by 2002:a05:620a:198e:b0:7c0:8978:d1e3 with SMTP id af79cd13be357-7c247fcc139mr765759485a.46.1740613395229;
        Wed, 26 Feb 2025 15:43:15 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c36fee9b74sm24836785a.9.2025.02.26.15.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 15:43:14 -0800 (PST)
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
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Guo Ren <guoren@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v2 5/5] riscv: dts: sg2042: Adapt reset generator for new binding
Date: Thu, 27 Feb 2025 07:42:33 +0800
Message-ID: <20250226234234.125305-6-inochiama@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250226234234.125305-1-inochiama@gmail.com>
References: <20250226234234.125305-1-inochiama@gmail.com>
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
 arch/riscv/boot/dts/sophgo/sg2042.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
index e62ac51ac55a..2be10cbba0ce 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -499,9 +499,10 @@ intc: interrupt-controller@7090000000 {
 		};
 
 		rstgen: reset-controller@7030013000 {
-			compatible = "sophgo,sg2042-reset";
+			compatible = "sophgo,sg2042-reset", "reset-simple";
 			reg = <0x00000070 0x30013000 0x00000000 0x0000000c>;
 			#reset-cells = <1>;
+			active-low;
 		};
 
 		uart0: serial@7040000000 {
-- 
2.48.1


