Return-Path: <linux-kernel+bounces-209028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F54B902C0B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 00:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03FAC281519
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C23A1527A0;
	Mon, 10 Jun 2024 22:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="QLbzE9IJ"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092B515533C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 22:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718060223; cv=none; b=exu8YASvYydikOrGnpGna+6UW9NR2lh41t0DNIJwd70IkBsryvedZ84b1kusTkaz7dUyGJS531z6gDqrbdmKtm0wF7aQYQnXnrCub+pm5MBhhoazuuiLEyUZ2I33LYPXSHTG4kXz+31obENGqB42YXrIWm+a9ToXmpzMZgGM9GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718060223; c=relaxed/simple;
	bh=YRbwjAEMooOC1Wqfne0YGBAOlvdWm2exzND7IqGSDDM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FLnHeJGlX3B3RVF4jguFIa/KVwYROdYawSfKzJw9jPfji7n2FwZEz2wshaboEEZqnPwxhshdtAaHG0Q/2VwD+wKn8MtyINNebwaMYBAQJvUK0G5WuIFA6OFce83HAO81tw35n4u8loeLeFDk8I1Y2GyWlj4r6vgd0kOhU76ElMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=QLbzE9IJ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-704189f1225so2706710b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 15:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718060221; x=1718665021; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7HBSOfNpcERRo+IfFfSUzbZmQ8OANKCSab29OA8NgQg=;
        b=QLbzE9IJ7OiNESxkyeN1jywesSy/24mBAcn/dMJm5hjMlCQrj2whZAXQMAJPXcgVsa
         /SQiPwbNkE8nrGXKwph/gRfUAnZ/GaHCasjqZqBXald9FcFRYWT2375bMbI04oe9Vw83
         pw9gFjxyMjyqdbPPxYK77e1j0hQderLwYXUNaTqY1ySapba15lnjwomBh/etwMcfUnQy
         FBuFzNC8G5sekaAl4tw+v8DRK/DC7DFLtmscMwP8wMEjNn4dHxqjh7zBoczo+rjuh7/T
         0Zr4zsbTxDJTJOaCECWEw2oiqxSh+uYNDsjYT2FtMkqagohWhmbqlpVUZMr8anM46DJ3
         Znfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718060221; x=1718665021;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7HBSOfNpcERRo+IfFfSUzbZmQ8OANKCSab29OA8NgQg=;
        b=mvaYCpAtZ0RWGM33PH5aiIe6pPmp0E9IBhCR5ywhCFQAwhu2gGfWSbAWImk4kdTUCy
         x6yo9oH1X0p+DJ0pERBoVVtbjuWJzqR5OYOv3joY2mx8BTT+Ftp21Z/nBBSupUIKPGcZ
         V8UkZ2BxTq6jpUaKC0w0PqCuOY7AukOECctFLxLlLa8lbkw1ZwM6hB5XUsF6PaJ0isW7
         AnkXymmT6ez93Lax49fVM3eSOLdOoedK0v8ljuyI3WFh0FZkWeKxgkviNPiGHV7B4jGR
         j2RI7xxgzRZahUhq0C/waNhe2/YOBzA9XdFbxJpLHv32VVmIDs99kIqKJ7naS74Jfvxc
         3Nog==
X-Forwarded-Encrypted: i=1; AJvYcCVyGzrQjzguu9cxSUifqygQrkAIdvQoGh5M7fq/U4ySsx9XPQEcgnDjJrh7ms+sVA/B4HbvLk7awBzcnvb78WJVDw2rwtTqMevq93yA
X-Gm-Message-State: AOJu0YxIFeBLGiQtv3Iz5oiuOLD7iWkrbK0Ok5edVXpk3xzDiEAXXwu/
	p4XjHAUkfqQzqEHFRidNiPHANyWct9kpDJtOyhJEhFhg4CkGpMGqZKkKWBLE83k=
X-Google-Smtp-Source: AGHT+IGIZbpFLMHE/lJ5GbefKME8Gn68phzhUe0FaeJN8+1dFczSl0GMa6MPZKO47tw63mwCQaqOEg==
X-Received: by 2002:a05:6a21:9991:b0:1b4:772d:2885 with SMTP id adf61e73a8af0-1b4772d29d3mr9114268637.3.1718060221031;
        Mon, 10 Jun 2024 15:57:01 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f71b597072sm18355865ad.99.2024.06.10.15.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 15:56:59 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 10 Jun 2024 15:56:44 -0700
Subject: [PATCH v2 07/13] riscv: csr: Add CSR encodings for
 VCSR_VXRM/VCSR_VXSAT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240610-xtheadvector-v2-7-97a48613ad64@rivosinc.com>
References: <20240610-xtheadvector-v2-0-97a48613ad64@rivosinc.com>
In-Reply-To: <20240610-xtheadvector-v2-0-97a48613ad64@rivosinc.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Evan Green <evan@rivosinc.com>, Andy Chiu <andy.chiu@sifive.com>, 
 Jessica Clarke <jrtc27@jrtc27.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>, Heiko Stuebner <heiko@sntech.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718060203; l=706;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=YRbwjAEMooOC1Wqfne0YGBAOlvdWm2exzND7IqGSDDM=;
 b=BM5m5V/nQRNhZjvOPuMabe0KTvggdAN05fZDbXe+2vVdatDi9tChErTOUmlzrP1AEH9N7fbby
 PcLGUrn7jT5APulSOlHctEyjRk1D0HhX5Gm8tzJtZGG2+4QDc9oh7fv
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The VXRM vector csr for xtheadvector has an encoding of 0xa and VXSAT
has an encoding of 0x9.

Co-developed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/csr.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 18e178d83401..9086639a3dde 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -220,6 +220,8 @@
 #define VCSR_VXRM_MASK			3
 #define VCSR_VXRM_SHIFT			1
 #define VCSR_VXSAT_MASK			1
+#define VCSR_VXSAT			0x9
+#define VCSR_VXRM			0xa
 
 /* symbolic CSR names: */
 #define CSR_CYCLE		0xc00

-- 
2.44.0


