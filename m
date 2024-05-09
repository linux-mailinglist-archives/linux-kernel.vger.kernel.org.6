Return-Path: <linux-kernel+bounces-174683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0E88C12D6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 18:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03DBA282695
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 16:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4771172BAC;
	Thu,  9 May 2024 16:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="PkueXnTt"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77290171E4B
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 16:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715272075; cv=none; b=Xftj5ipfzCzfLxUodUOjHzwpeYM0ykKD3F0uXnQps2bJFnSuwQvjdVPSpMMdZp3Kg5y/qHmgxnf2wl/SaU3dkzcWB7pzUFHVy61Wuus29wYtjRaMGmVS8j6P7riQdS7b7k5Bmn2wEG/UuhnX5yEu2b8mHA4OOnkKb1cRNjpc9SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715272075; c=relaxed/simple;
	bh=HTwXq4dfdPMm84nIH+ARCZR286B+TcB5da8GClM6ty0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UyhAdmy67dHIw6wDAw5/KRNSBc8QMSNA7CIFKtR7zReUHCRGDUAG8pqQuedBZb07h/cbDcbOIHzb03Kpt1QS8mzkTi6fpvGIDDybuPVn/x22BaS+EFaT2h0dR5iIjl0zWp5FD7D0FjNYnP65USLVeDwZk8e3MHzfp3ndvZHV9cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=PkueXnTt; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1ecd9a81966so15650545ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 09:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1715272073; x=1715876873; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v6E6ZusRhlxuRh8LTz85NPr0A8l1rMIJWkDOWsfceGk=;
        b=PkueXnTtm40OBoZIeBuLVdEIXpBbAURfIsmrhwk1q1lNml4u0vSdJixASTgFqkW35d
         nRFySHk+EfISxgffazee+bex3NptjMArrgRSITxcmOiyX97SwBMW31bfEltSL+VE4CHd
         RU+TGy3fMQHVhmDeTT6mxXjsg4i+e2IZctDgCLtKRwNZzSexxdn2EPmfD8+4R6Pm7rje
         vuObQvQt9kMSJfdeY3vUpbl1JpjNSsMDaLCK7S1MxUHa/7Aq/oLFk8IG41VmspxbejnF
         2oBI0dTJyFtLOGB4vQh/pdyacLhytWyGNSRmmg9Yfwut71Av0e7a2N4WUKzOcR3Yuugv
         GgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715272073; x=1715876873;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v6E6ZusRhlxuRh8LTz85NPr0A8l1rMIJWkDOWsfceGk=;
        b=CsDba5q7zjna43a5NZEO653YopCG+1Amk4ZZvW+Q9o/Dcgc3Cn73aAWFGyOvMb1B8/
         p8JZy85nDl5Nxglbo56j/iW6a/lcQ65uBoqp6miVWUIvdrdTCbm+fSrNanGJ5qrGeThh
         Tb5dCwfufBrhn9WOhyc2nbCZTzhHXYqToX/e6CA6wV9YMI9CLaB9uLFa/XaRIddN4JFa
         2DJbQY9PHnG5Kss/7/9us8KdReJRV13162ixccE71DxOZEFLLD7Mq43x6FWdmsbUWvMT
         hShLbmFJHzh2yc12N15Q60ORn4Yu7UJJ9WE5ro+6qile3fFsrceAtDZUJYyVFUxt9vL0
         niYg==
X-Forwarded-Encrypted: i=1; AJvYcCUVk4krdZkAvYEwnDfrp6Gdvemauy4JDD9wVjYY3tbqaWs9ji4xQAOcXV8EHKgfdpbSz8cRwEpIqRu3HW64IzAMKhXlYhnEzv4c8dlY
X-Gm-Message-State: AOJu0Yzfue9SsA9Gg2r6p+RDV6OzU5nMXb5HwPgQAcRpR1ww2xTxDxbN
	LsVQw1/JfAnUfuZEFM1HPZVjTWCBU8c48yEeJJNBgCYMP+jQTC6rYbioNy/0jYA=
X-Google-Smtp-Source: AGHT+IHxBUHRPrw0FqUS+OM/NY9GyC13nGox9W5GwUl+ZolYupUN16LsN4HIr69L69inYwc5kfUyjg==
X-Received: by 2002:a17:903:2301:b0:1e4:6253:2f15 with SMTP id d9443c01a7336-1ef42f74cfdmr2685595ad.16.1715272072597;
        Thu, 09 May 2024 09:27:52 -0700 (PDT)
Received: from [127.0.1.1] (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c13805asm16210285ad.264.2024.05.09.09.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 09:27:51 -0700 (PDT)
From: Andy Chiu <andy.chiu@sifive.com>
Date: Fri, 10 May 2024 00:26:58 +0800
Subject: [PATCH v5 8/8] selftest: run vector prctl test for ZVE32X
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-zve-detection-v5-8-0711bdd26c12@sifive.com>
References: <20240510-zve-detection-v5-0-0711bdd26c12@sifive.com>
In-Reply-To: <20240510-zve-detection-v5-0-0711bdd26c12@sifive.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor.dooley@microchip.com>, Heiko Stuebner <heiko@sntech.de>, 
 Andy Chiu <andy.chiu@sifive.com>, Guo Ren <guoren@kernel.org>, 
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Jonathan Corbet <corbet@lwn.net>, Evan Green <evan@rivosinc.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Palmer Dabbelt <palmer@rivosinc.com>, 
 Vincent Chen <vincent.chen@sifive.com>, 
 Greentime Hu <greentime.hu@sifive.com>, devicetree@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.13-dev-a684c

The minimal requirement for running Vector subextension on Linux is
ZVE32X. So change the test accordingly to run prctl as long as it find
it.

Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
---
Changelog v4:
 - new patch since v4
---
 tools/testing/selftests/riscv/vector/vstate_prctl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/riscv/vector/vstate_prctl.c b/tools/testing/selftests/riscv/vector/vstate_prctl.c
index 27668fb3b6d0..895177f6bf4c 100644
--- a/tools/testing/selftests/riscv/vector/vstate_prctl.c
+++ b/tools/testing/selftests/riscv/vector/vstate_prctl.c
@@ -88,16 +88,16 @@ int main(void)
 		return -2;
 	}
 
-	if (!(pair.value & RISCV_HWPROBE_IMA_V)) {
+	if (!(pair.value & RISCV_HWPROBE_EXT_ZVE32X)) {
 		rc = prctl(PR_RISCV_V_GET_CONTROL);
 		if (rc != -1 || errno != EINVAL) {
-			ksft_test_result_fail("GET_CONTROL should fail on kernel/hw without V\n");
+			ksft_test_result_fail("GET_CONTROL should fail on kernel/hw without ZVE32X\n");
 			return -3;
 		}
 
 		rc = prctl(PR_RISCV_V_SET_CONTROL, PR_RISCV_V_VSTATE_CTRL_ON);
 		if (rc != -1 || errno != EINVAL) {
-			ksft_test_result_fail("GET_CONTROL should fail on kernel/hw without V\n");
+			ksft_test_result_fail("SET_CONTROL should fail on kernel/hw without ZVE32X\n");
 			return -4;
 		}
 

-- 
2.44.0.rc2


