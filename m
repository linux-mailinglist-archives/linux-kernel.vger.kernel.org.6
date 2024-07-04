Return-Path: <linux-kernel+bounces-241343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B7F9279FB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93340B23BE6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D783F1B1401;
	Thu,  4 Jul 2024 15:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nQaXHkA8"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31F01AE861
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 15:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720106711; cv=none; b=MlouauYTJm8h18z5ymqLc5ch88cSvla3xFzE8QO33hfdloK2u+/ziDjnLdGstuug18oevxKQEdU/9ZGhQYgOOfntPtbVDbzMWCjiRPxZhI3ItESh8w/irinuBLnX6UIh3AlyK22RMpcsFxGOEEcTBioaehjRBKOAPy0XxDe+/fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720106711; c=relaxed/simple;
	bh=L0fqthKwQoJ3/n3wTuxc8RAAQ0COsdCjZ1mWGK2Mepw=;
	h=Message-ID:Date:From:To:Cc:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=YCI0pd6hK2ZoKv9ZFVdRucnsEC0G6TYQEgBQBrH9HA7KDa0pWmURR0cyaNTMNzhnMU5afTykqCE6w29k0jQPGFlsHMCeFl1yPCVQZIKN+41FVUoLjh05EMP9ADdheeh004eBTMl+vOixQFW3Xy0MysdMtQ/uhxbP+yh+mnsY+Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nQaXHkA8; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5c229aa4d35so343563eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 08:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720106708; x=1720711508; darn=vger.kernel.org;
        h=content-disposition:mime-version:subject:cc:to:from:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7sFNJOnSmqtqKvPXuuEH/9m0mTzrSrkSfu1bDrkU8IU=;
        b=nQaXHkA8W9mW8J8bVh4lksG8sNjdzmiE0L2KEJo99bUiZZKzomIc/HX7qTbqhalHn7
         pPZfstVNyW8ku2/qeOKT3QmrcHsN66waiAU0uLUFyx+518GLENllFuka0H/NfFhNmZEc
         4JJQQfr5FowIEftD4L2O4QCImkjNR2bi6sir9jtUZ79Cr+wCpJQuLCP4pbCVMEmKFxkF
         BmoO1gUDIrHJlcRbYsYShprA+OjuWmQnjGgJqVOpLGpgwo2IisSOvEFz0cY+UITsIFHH
         jjzvo7ouyPBezol5S4XEVWKNh6jpFwlMxuordhp6ld+guvBIJJlQDbUgIoMkyN3Zd05S
         0OPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720106708; x=1720711508;
        h=content-disposition:mime-version:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7sFNJOnSmqtqKvPXuuEH/9m0mTzrSrkSfu1bDrkU8IU=;
        b=bo8chrq/G/KnLDsWlyNQptcDA7o1yBOOAVsEX8tU7s7KHUMP+BcYZ+LnedIj229szD
         aopFxkEF8ZiCI+SHziHhX5YPQgElB1SazjpCMVry+8M4VJ6P15RGG41zyvtVovE1In32
         E/zqbWNV74L7pPbonm4JUCIzYsZ7iejBj05bPIohdECqKL/zXCJwRZIE83cyKOk5iDwb
         bR4zKD293aQHIvIkkRvPLNRP5Tl/Wzcu2Na9MKOKlOAnUsRCNpa8h+3cNC+wyl4l43YA
         f7yUZYFCLvkeaJRgYA+c/RkPuBlINCjGk12CEuvEnzMniV1zuE678DfD4jDLZlv6APyg
         IPPA==
X-Forwarded-Encrypted: i=1; AJvYcCUbl5+2QAVwowzdtjVLhdYJ9BtuMPSwwIrM8WrCUTf9HlNPRndIWVr93glAgoFU2mmhsjlLE6ref70+5InzzvH9+vN5fbNkWvADrTPu
X-Gm-Message-State: AOJu0Yz0SGbxdnc3nsHORVzX36ewfonJKr1icEb9e8eGBwtojY82VaRl
	220KWRSeaCvaE5+pAm6ciYnIExhCVNmWXu5V/wshpLh5qDV0uK93k7lX4aoZwpk=
X-Google-Smtp-Source: AGHT+IFsO54HvV2syeU4YZ26SXAOrzkSz/Z2cJBBPKHT1L0d/gQhuA22lcmvQepFViKBwkpZQsYdug==
X-Received: by 2002:a4a:4b43:0:b0:5c2:1bdc:669c with SMTP id 006d021491bc7-5c646f7105dmr2315521eaf.6.1720106708143;
        Thu, 04 Jul 2024 08:25:08 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:96a0:e6e9:112e:f4c])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c44bba4eddsm1148760eaf.32.2024.07.04.08.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 08:25:07 -0700 (PDT)
Message-ID: <6686bed3.4a0a0220.6aa45.6c34@mx.google.com>
X-Google-Original-Message-ID: <@stanley.mountain>
Date: Thu, 4 Jul 2024 10:25:05 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Mimi Zohar <zohar@linux.ibm.com>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] crypto: lib/mpi: delete unnecessary condition
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

We checked that "nlimbs" is non-zero in the outside if statement so delete
the duplicate check here.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 lib/crypto/mpi/mpi-bit.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/lib/crypto/mpi/mpi-bit.c b/lib/crypto/mpi/mpi-bit.c
index 070ba784c9f1..e08fc202ea5c 100644
--- a/lib/crypto/mpi/mpi-bit.c
+++ b/lib/crypto/mpi/mpi-bit.c
@@ -212,12 +212,10 @@ void mpi_rshift(MPI x, MPI a, unsigned int n)
 			return;
 		}
 
-		if (nlimbs) {
-			for (i = 0; i < x->nlimbs - nlimbs; i++)
-				x->d[i] = x->d[i+nlimbs];
-			x->d[i] = 0;
-			x->nlimbs -= nlimbs;
-		}
+		for (i = 0; i < x->nlimbs - nlimbs; i++)
+			x->d[i] = x->d[i+nlimbs];
+		x->d[i] = 0;
+		x->nlimbs -= nlimbs;
 
 		if (x->nlimbs && nbits)
 			mpihelp_rshift(x->d, x->d, x->nlimbs, nbits);
-- 
2.43.0


