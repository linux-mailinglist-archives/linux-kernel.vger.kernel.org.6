Return-Path: <linux-kernel+bounces-325615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E16975C0C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F13B4B22A27
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 20:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53A41487CD;
	Wed, 11 Sep 2024 20:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhAXULVu"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93301558BB;
	Wed, 11 Sep 2024 20:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726087810; cv=none; b=mXYd5yvlUnsetzVFsSjufaNjATXMxJB8ifr/lFNNXgxoGcQQbpykydRDghrvyMU4wYaJ6a1tvmn+a6wXRHlbU4UApYrbAwAGjrF4kDn9uEGmdp4MpDNrP+XrA7L+Aa1hRAW48nPAvq7nQq8xlqaPejUInJ3djnVIf1sAfstS2i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726087810; c=relaxed/simple;
	bh=5KbxmBEX9+53j/8stCzz/f86DO6BaQlRPGV8VaRClEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FFxlBVp6OEzeuwzjzyUuROEj2jRzxKSKEU9oPY8aB5xvdL+j3t9uQeRZA6NUTyQqWLaJMlYUVDsDZ+jwlBNegnUXv6trG/2mOhNwn5coJl4WA+AIUEWozX8P8gXl+Nsb0fdRonFVhAUPkZpSz65C8tNejk2+qD/bFH5XsVnO2g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhAXULVu; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cd46f3ac9so1699985e9.3;
        Wed, 11 Sep 2024 13:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726087807; x=1726692607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dCpSNY/fcLx6RtHV3fgxenagEPpv9Gy+adzBp1Qz8Lw=;
        b=OhAXULVuwHolNw8QDCDhrd1eeGQ6NNdkbodUqf1BitJtgCVGzK4UFnG9XQuzZZL+fV
         JpFTt/PriXGET0/C/grGovtgbS90tBgYkw9Uy5znCMrBfjWzxhcodGZ8C8Txoks6EDhK
         SuIfj+o4tEEMFj8Le2LZpePKEf1qSp3LQpd1js0Kw12c/udY/Vx6cb9dcXN4h+aMdmiI
         cA+04Wiz6YFQpQzb5oJtcleCYOFKNkEsXywIRC619f5W2tzYcKz3tQ4AIm1pjyIKeIIY
         m1RY6jz3ixA7eqWv1mGt/LsfhkqvRBw9PJoyOUyvWDrsxZxzJ/69MxhVDAjAT0iymdll
         GNbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726087807; x=1726692607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dCpSNY/fcLx6RtHV3fgxenagEPpv9Gy+adzBp1Qz8Lw=;
        b=jnfmaBnctJpz1Gsya5EP6QP9ligRO9ahaJ9gxFM8og3m5CRVYTFF36arYeIxMW8g7L
         ZZ4k7z5j+fJtg1u/QZkYBoblEfMKyhXKjAcNJRb/Y0gJ0U7OffIuXmVVQCUz71lmeqLH
         UV0zpccHr84Fja0Nl0l4QJyFGXewE9IUxmlCHunyuKNGU1pSowZJst7KfNgJbS+LUqPD
         EAh9YI9LN2dsgtsPkpVt2lM8+LbkfA6t320z2heacFiidxGJHQwhTbDVAgNMYMODan6d
         QLGPc7F88hFW8IdZiVuJT6s0NUnQvNlRTRXu6kXmXK5fIrrs+e+zX7pOBPN8fAlp92aH
         mG1A==
X-Forwarded-Encrypted: i=1; AJvYcCV/TiPCjHcc3cSYe1ERZoFCzw3LAa4e74TcwNT3gxOfJ61xkPOxR3N31O5wxgPidg5cMGmB/AV9Qh4Izk3N@vger.kernel.org, AJvYcCXFJqnY5C4vomGRS2lFAtdPzOV/QbjU8ZfG69zepqWblmAiwYhux6zdcvOOYV2HeBE6WeSpM49Y8ucy@vger.kernel.org
X-Gm-Message-State: AOJu0YycEq4Hciw60X3T3ie+7RQq8JoEp9VFOIjzyPArlFRvno+QDbAT
	fd3XRBKtckCZfny+l0oRtx8zjIkZz0eVbVYR05OTyxyBxl9zBJorGzxABw==
X-Google-Smtp-Source: AGHT+IGlzzF0GjCq9Jt0TGiDnSu7egPhKvCLVBvmjTBQkG0dpiNbS3jxM9Nj4mGLqjtQ/L0rf3GULQ==
X-Received: by 2002:a05:600c:46c5:b0:42c:b9c8:2bb0 with SMTP id 5b1f17b1804b1-42cdb538cb5mr5435175e9.4.1726087806419;
        Wed, 11 Sep 2024 13:50:06 -0700 (PDT)
Received: from localhost.localdomain ([37.72.3.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956de4b9sm12445941f8f.111.2024.09.11.13.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 13:50:06 -0700 (PDT)
From: =?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mikisabate@gmail.com>
To: robh@kernel.org
Cc: saravanak@google.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mikisabate@gmail.com>
Subject: [PATCH v2] drivers/of: Improve documentation for match_string
Date: Wed, 11 Sep 2024 22:49:38 +0200
Message-ID: <20240911204938.9172-1-mikisabate@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The description of the function now explicitly states that it's
an *exact* match for the given string (i.e. not a submatch). It also
better states all the possible return values.

Signed-off-by: Miquel Sabaté Solà <mikisabate@gmail.com>
---
 drivers/of/property.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 164d77cb9445..d66ea8a83562 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -452,12 +452,17 @@ EXPORT_SYMBOL_GPL(of_property_read_string);

 /**
  * of_property_match_string() - Find string in a list and return index
- * @np: pointer to node containing string list property
+ * @np: pointer to the node containing the string list property
  * @propname: string list property name
- * @string: pointer to string to search for in string list
+ * @string: pointer to the string to search for in the string list
  *
- * This function searches a string list property and returns the index
- * of a specific string value.
+ * Search for an exact match of string in a device node property which is a
+ * string of lists.
+ *
+ * Return: the index of the first occurrence of the string on success, -EINVAL
+ * if the property does not exist, -ENODATA if the property does not have a
+ * value, and -EILSEQ if the string is not null-terminated within the length of
+ * the property data.
  */
 int of_property_match_string(const struct device_node *np, const char *propname,
 			     const char *string)
--
2.46.0


