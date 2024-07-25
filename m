Return-Path: <linux-kernel+bounces-261742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 450E693BB91
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 06:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 717741C214F9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 04:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC8877F11;
	Thu, 25 Jul 2024 04:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="MYU/h2NY"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35A51C683
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 04:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721881012; cv=none; b=aagqeBqwXBCyWyvAT3rxc69iWUrlNh9qEFr49cK+aH1uh5I6nmTh8Bq0RJ15+IenX6akTY0EvUIqstsZngDEo8oCc9F7+zIV6YClCkCdKVu4SITL72tZEMfNeb6+xm8sf4se8KHxE5QgvW5Xx/fMqgMTI7SM4COjuGUxmsbo56w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721881012; c=relaxed/simple;
	bh=/awdvkpT37Pcv9l+R6WHhK0Ytr8TrWH5wurC23dujZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vq4Ayz9S9ELKMBu1y2j3/5G+AFBvR4ahSmbco2xeXjTl3PlN0pUR3FW6ZwJCCspgWx4tpopK/2qIVeCaxF3REiEu6lwjC9cPK9DO3ubQRdbJBMN1y5rP6gGiPOkR5bjzzhC+qWDUB5MaZrWID1BOO0ezO6/apkFM/1zysp5SSFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=MYU/h2NY; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fd90c2fc68so4242365ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 21:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721881010; x=1722485810; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7liFIbqG3XLVQtLXjuEuZ9H5FIup228+UAuRj2s502A=;
        b=MYU/h2NYxqbc3KLfgv5MLl8cXZHD/eOCpw5TEsVWH7tUO4Mu48K0Emc+yxxtMsWgk1
         d27vptFSUbgH12vcvwPChwsqhX0o8Z+I1Z1EtSvmN3z1EiVt0Q9y8GDINkoapd+fAwxV
         nk9w+0DFhyzUJbacs1qfDC5bKlzRDDFBdIp14zrH4XLXH9YCmsuQwsYriYEArODK6LHT
         pysbMqW1LuaYWNMnidiCSFkr3nSOFEdSmSScBg3zTU6114GA5UoyiAwDIPcN8RgX2loB
         InLkHJWns9X6uRCaozjsEsRFKfb8Jatmi10DUgAFsuHbzMbNq+4i5itQFBVlUx+CgJVz
         JAIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721881010; x=1722485810;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7liFIbqG3XLVQtLXjuEuZ9H5FIup228+UAuRj2s502A=;
        b=t2++7qIQ8pKl9W8ZXHH9vU6hKqpFryd9RF/IIglR1i+vm0ix6IZ/OS73tmV0I6gueJ
         tycaujzuBgeM2131clx6fvJ0cvGOIfLf/gR/Kof8K1BD61g7vli3/IC+pvo/AdpqWPyl
         QUCs/famCfPF7wKeim4bsdN3DkI8ZudS6X9mMjbF3dnKb4E91l4I0WYmn1Gzz1OBuXIN
         RShm/7CofnZEmejli2rpvuOZBZuZxdWTkWpogef8bgpZ5hGIaIbAZmvBs9LyjCHP7rp8
         VwNtlnqz1IK5xfYJ10MPYRMGHX0jeQxvYMaVDsTkLrFgkVTUGWu/np8rn7lZi/g8G1eP
         MHjA==
X-Forwarded-Encrypted: i=1; AJvYcCUmMamj7yqqJMe5v9xdsYxQCbqITcaY2NIqhsCwaZwv617yQM5pjiA56NdYwZbjXgE/3Z9adZswCMrwKD55v54ZOkuHQ9D3aDpvMkQ/
X-Gm-Message-State: AOJu0YxncrF5NGRFKnaIvnI2F+wyYPwmV5XMJpChTbdZ/oL7+b/Pu0QL
	hWHoqOwOk/aSLcunrz1grRCPBF8IRILerefDvI0MRxWjlCUjRVyrot8red01r74=
X-Google-Smtp-Source: AGHT+IG9p5ieQtAxVwtwRrKMsQ3tH0oS7hdi8tXU1NiTxKTEptmOQ6kEQXaoXkVzZB80bKpXwXAfnQ==
X-Received: by 2002:a17:902:c407:b0:1fa:fc6a:858a with SMTP id d9443c01a7336-1fed384285emr18528395ad.15.1721881009991;
        Wed, 24 Jul 2024 21:16:49 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f2b80bsm3781825ad.205.2024.07.24.21.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 21:16:49 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 24 Jul 2024 21:16:24 -0700
Subject: [PATCH v8 07/13] riscv: csr: Add CSR encodings for
 CSR_VXRM/CSR_VXSAT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240724-xtheadvector-v8-7-cf043168e137@rivosinc.com>
References: <20240724-xtheadvector-v8-0-cf043168e137@rivosinc.com>
In-Reply-To: <20240724-xtheadvector-v8-0-cf043168e137@rivosinc.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
 Guo Ren <guoren@kernel.org>, Evan Green <evan@rivosinc.com>, 
 Andy Chiu <andy.chiu@sifive.com>, Jessica Clarke <jrtc27@jrtc27.com>, 
 Andrew Jones <ajones@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>, Heiko Stuebner <heiko@sntech.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721880993; l=1045;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=/awdvkpT37Pcv9l+R6WHhK0Ytr8TrWH5wurC23dujZY=;
 b=mF9QzvOtJ0E+YvogarHlMEGaWmhoxEtzqz8fpE1XE4GA1FOcmeiBqgyml12mHdPeg4HK29G9Q
 k3wj39Bgwa2AfUMTGV1y098m1KBZgSQ0bod6LyBScyOjBMjAsLalkez
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The VXRM vector csr for xtheadvector has an encoding of 0xa and VXSAT
has an encoding of 0x9.

Co-developed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/csr.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 3eeb07d73065..c0a60c4ed911 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -300,9 +300,14 @@
 #define CSR_STIMECMP		0x14D
 #define CSR_STIMECMPH		0x15D
 
-#define VCSR_VXRM_MASK			3
-#define VCSR_VXRM_SHIFT			1
-#define VCSR_VXSAT_MASK			1
+/* xtheadvector symbolic CSR names */
+#define CSR_VXSAT		0x9
+#define CSR_VXRM		0xa
+
+/* xtheadvector CSR masks */
+#define CSR_VXRM_MASK		3
+#define CSR_VXRM_SHIFT		1
+#define CSR_VXSAT_MASK		1
 
 /* Supervisor-Level Window to Indirectly Accessed Registers (AIA) */
 #define CSR_SISELECT		0x150

-- 
2.44.0


