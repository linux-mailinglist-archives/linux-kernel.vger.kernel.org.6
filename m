Return-Path: <linux-kernel+bounces-292248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 405BE956D08
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73FC51C22BD2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC0716CD1A;
	Mon, 19 Aug 2024 14:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="VIwZYXWv"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A727616CD02
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 14:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724077166; cv=none; b=RiblvHazI/my+9DC5/ez4vgkg64FzZjDb8+ZXmInQiIr2st3GFPEXoEu5gjcD6NSHC54/r2337NZtnm/Th+PGhZOxObiEZQb6MxGsnSaDbsv6HVVQo0z093uNSX4avpRy8Y/WLJRq3VeGMr4q+Zs9Cg8e+/5GDPLg/ge98mHVTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724077166; c=relaxed/simple;
	bh=qS7ZSrFqh4rU5Ft5q1twy5K9515FjzeEZNzbn0Q+UyU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r7igMXY9/X+BvBA2ktyqPxU2c4N3sR2LCAl7onyf0AX5XYZXdNYbRZe1unTryLdky6pBd8YPQRNbGnPZ1tWjLn0RjueGyPKZ7KmYz0YaPbZqRpRlsxcuGXPDiwHeuOvEszi0CIua/T6V+mJSaiFCvEc49luGID1Vs01KfGEMqMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=VIwZYXWv; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a86412d696cso8955566b.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 07:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1724077163; x=1724681963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RFS3Wv8nLSrNGmJ2U9Jj6TGefpKqXVtUCaCEYux9qa8=;
        b=VIwZYXWvtEY20GoQQfRDk+zFxgo1jSlxGLaxs7dYKKpbp0q0QV5owq4RXimhVurWy2
         EQSGEjyzkx9YjRThWWEKP/QMnWmIQeI4DyMBjWCoGMKRwETwyMBelpoMHEbv8it4F/3G
         dh7Owu074MH1F02i2xIke23pHxt8vLEb3PqXHkJeDKd4zQf+EWTBU9McpQ9WAzw6fvQL
         Pm9AZ2AXHDwYOoyz74dpmTkovHxEHoVMeuUQXYmvcJuSepBhvTLG51itil37CfsQirs9
         HxA4RXzJ+UtsrPa+S/8652QU/T2HNgLjFhayttMgheQIrc/mRQq8OZjoH494AmECRhPO
         1H5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724077163; x=1724681963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RFS3Wv8nLSrNGmJ2U9Jj6TGefpKqXVtUCaCEYux9qa8=;
        b=oVH9PAn7K1nRB06iir4sGvCXzScw76EaK7TCxdKoSVRvsYZq6E67b3yrHHky9amqTA
         M9eXQkNMBACBWnd+MAiT8SAzj2++xjdu+ndKQZrembziLRC3MYWO6j33xy9aa5uIZuHw
         qpKsWuORS3z98gyfJZAsUvHZ0ZBh4kbkB+8PoARkoOdMGAyBDYH+lpRZWyUuu6vcGzEx
         AbDqENAIKMQ6i4TwTHSloa8rYQnUohnHe1MAD9aW5cb9DHc5/E/xQbzOL13zdy1xffx9
         LLF0caxW3sciFSa3AzqRKHhX/flWqLXv9cVpdCrkyqTC4zDQ9WUDZh+V/92gqc0k+KzO
         nfOw==
X-Forwarded-Encrypted: i=1; AJvYcCXgaGgUxbCvLvW2vJbZWSfoROiqWS0rQmEE+c318vDNxMLdXtXiYS8mpMeDe3d/I5mCg58Mv4cyvpmfqmlELxe6pUCcxisf83wyGrC+
X-Gm-Message-State: AOJu0YwTXUYO9K1dk36C822u+e9U5HUEOz1LMKUdk3EbwZS7+FHp0PfT
	V9N6Ubi7JdLV4uNFzIQWgt+5yhcUAmXceIC76g/2kAPFNYLNL2C2TWjPCyE6dRtyo0zg7ljUGd7
	prJY=
X-Google-Smtp-Source: AGHT+IEcN/Sjk7o3QNL1D2HctPW1wo0igtSMNE6KnvXG9XGrBUFPctC4HUtzHRg0JtJLyL/iKhgYUQ==
X-Received: by 2002:a17:907:60d6:b0:a77:cd4f:e4ed with SMTP id a640c23a62f3a-a8392a47a15mr745465466b.63.1724077162735;
        Mon, 19 Aug 2024 07:19:22 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-163.dynamic.mnet-online.de. [62.216.208.163])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383947799sm646235366b.177.2024.08.19.07.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 07:19:22 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: herbert@gondor.apana.org.au,
	davem@davemloft.net
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] crypto: jitter - Use min() to simplify jent_read_entropy()
Date: Mon, 19 Aug 2024 16:18:44 +0200
Message-ID: <20240819141843.875665-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the min() macro to simplify the jent_read_entropy() function and
improve its readability.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 crypto/jitterentropy.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/crypto/jitterentropy.c b/crypto/jitterentropy.c
index d7056de8c0d7..3b390bd6c119 100644
--- a/crypto/jitterentropy.c
+++ b/crypto/jitterentropy.c
@@ -146,6 +146,7 @@ struct rand_data {
 #define JENT_ENTROPY_SAFETY_FACTOR	64
 
 #include <linux/fips.h>
+#include <linux/minmax.h>
 #include "jitterentropy.h"
 
 /***************************************************************************
@@ -638,10 +639,7 @@ int jent_read_entropy(struct rand_data *ec, unsigned char *data,
 			return -2;
 		}
 
-		if ((DATA_SIZE_BITS / 8) < len)
-			tocopy = (DATA_SIZE_BITS / 8);
-		else
-			tocopy = len;
+		tocopy = min(DATA_SIZE_BITS / 8, len);
 		if (jent_read_random_block(ec->hash_state, p, tocopy))
 			return -1;
 
-- 
2.46.0


