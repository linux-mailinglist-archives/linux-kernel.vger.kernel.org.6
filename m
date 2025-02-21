Return-Path: <linux-kernel+bounces-525966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF9DA3F7E9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62B904242EB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75CF215177;
	Fri, 21 Feb 2025 14:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Pk0i6+Z0"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2B0214A85
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 14:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740149854; cv=none; b=XDFwOqKM3DT9QFdqNh8Kcwma7DMMY7AxZNH8/2nfpmoOY/YZo+z6vlwV4/qq+sNzpMCpKOCNBU3ICumdtL0xocUb0ZtpIC1UQdoIfrL0U2gYW37kIeEZgIx0E3EEAgmG+T+2bx/l8whdTT8fI0ypnspCQuKdL8BQjRjf65DqGus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740149854; c=relaxed/simple;
	bh=HCTDVZLc27RfB3QlgUMKi3V9KsZa8/51pTH+CsMD1z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M1LHK+wj6IPscpT8M5y9axUfo6ocbLUT1HMysS9V9mMOhy1hEM3jmdGMCZGSMlWGBcsatMqVjihjMCoHCavQxatFbi7mb2AEbigBW/D3MADTO3SNHz1BC6dgfpiqnfLxWhTXAuLQH/OG8I3lmS17pL5xx5AUDBy8dowEQ7r2T/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Pk0i6+Z0; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so1234441f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 06:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1740149851; x=1740754651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KvHP2BboCGauKM0TvBqQfBu7j1TlN9OaRIMMc+Vl6gA=;
        b=Pk0i6+Z0qSTHDbSi7KKQaSTvabwve26HdAs2xo9c8VJs1vDK/aFQFj2BRzyT6C1MdO
         CB4WJxlwuAH6H6GvmnVD0tSstSeEuUeqFz3Yy1rbEIBfGgln7TWG3oaN9iag00MimKf4
         Neg3LYXep9ZHVwn9XECMs+Lxb8b6oAcj430OdMvcwy9rE9SneHAwjTaTbldi6S44cgIE
         4gDtwHTax/D1NY5yjP0UWDJLvhy5MCKAb9jSsD3cxj85ncj+OpdBSdpgSqSV2ZrQyJlV
         BXNW6wy3qzUD/ifB4yHNe72mhkibLOv5gZupwbj0+PReW7MwjC65HYhEF0iqX2SwUz+0
         1Cgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740149851; x=1740754651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KvHP2BboCGauKM0TvBqQfBu7j1TlN9OaRIMMc+Vl6gA=;
        b=cpdfyrvAHYCRDzACnG0Z/+WICHpP9mlddoozdpFLf8bXqjo2zLLPhPpTKMblMZHG8W
         QeOaLv7D7F3h7+Rb9Ci6Cg4ZunhMIminNbm7lJhXDqQCyNcDLD6uAbyw4c3R7t7Xxrk4
         +7jlKtPxF9IaVfiA2gYSCS+izB3wqdyj0LYjiwEzDk9mdSHm3HRXAMLJO6VQzsg1+HK2
         CuC2ONhI/1fsE1fXnBZhWAdQTyLCpCZ4LolmRlh1tzYM9LTekuTpL/vfsJKnOu2mx/64
         LqF5G0P//SZz6MqddmlAAHWucDtiyLwbRiP//+REiPw/zED6PcPExqAYMAWxoaZUYRIM
         WiSg==
X-Forwarded-Encrypted: i=1; AJvYcCVpWkS3NzhXYQoE4xgA0iwcP5WrDWu+mqsBVlSoF/ombzCDJdl8HQHnUP2qYLqSn7HbcwQfk2NYsDaFmfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXF3o8JijvW82J55eOapEfhTmoFtcU69XlEuUC3kEQchfqADVh
	N6g8YbHaCbwH9FprdoPq1/N4DvMzt2qMHXUX23ETAaZ7gpPCUdtt15DvAKc0Bm0=
X-Gm-Gg: ASbGncvvqvZrlYrE5MZyRtnSQAgzr9sHFOAcqQ4vgYVX5+02lFQRGH3Y8BS6dsyII+y
	rUPzzNxaexd+FH7c9cRzPPumAodbmrGQOn7Wj64yCmQp7QkueQYMaGLDSXea1ylBnTM74fZreTC
	MVvXulHbmNZ+Qv8pr3/ff3GE5cXSkR8P+4yin+qyN2usGkPIAdoAc223W+/xqpQuqpbbNdMu2c3
	hTADmGFoTP8NaXG4LqeSohZbJzU9RqaYJijAD2RGybah18q3XNBYC3KQqcpdVeiIC9jwjEdN4+r
	PLDb3NLay+OYyw==
X-Google-Smtp-Source: AGHT+IHcoDd+Wx7yCfHbXvCGdFs5uIccGxXcfrSZqLhmSwNHn36B0PnuR7cIJZPeqdU6yBBLobUiMA==
X-Received: by 2002:a05:6000:1a8c:b0:38f:2113:fba0 with SMTP id ffacd0b85a97d-38f6f0c3acfmr3393343f8f.50.1740149850872;
        Fri, 21 Feb 2025 06:57:30 -0800 (PST)
Received: from localhost ([2a02:8308:a00c:e200::766e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02d6974sm19479585e9.14.2025.02.21.06.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 06:57:30 -0800 (PST)
From: Andrew Jones <ajones@ventanamicro.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	charlie@rivosinc.com,
	cleger@rivosinc.com,
	alex@ghiti.fr,
	Anup Patel <apatel@ventanamicro.com>,
	corbet@lwn.net
Subject: [PATCH v2 8/8] Documentation/kernel-parameters: Add riscv unaligned speed parameters
Date: Fri, 21 Feb 2025 15:57:27 +0100
Message-ID: <20250221145718.115076-18-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221145718.115076-10-ajones@ventanamicro.com>
References: <20250221145718.115076-10-ajones@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document riscv parameters used to select scalar and vector unaligned
access speeds.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index fb8752b42ec8..9e3c5fecfa52 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7477,6 +7477,22 @@
 			Note that genuine overcurrent events won't be
 			reported either.
 
+	unaligned_scalar_speed=
+			[RISCV]
+			Format: {slow | fast | unsupported}
+			Allow skipping scalar unaligned access speed tests. This
+			is useful for testing alternative code paths and to skip
+			the tests in environments where they run too slowly. All
+			CPUs must have the same scalar unaligned access speed.
+
+	unaligned_vector_speed=
+			[RISCV]
+			Format: {slow | fast | unsupported}
+			Allow skipping vector unaligned access speed tests. This
+			is useful for testing alternative code paths and to skip
+			the tests in environments where they run too slowly. All
+			CPUs must have the same vector unaligned access speed.
+
 	unknown_nmi_panic
 			[X86] Cause panic on unknown NMI.
 
-- 
2.48.1


