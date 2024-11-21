Return-Path: <linux-kernel+bounces-417511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6832F9D54F8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 22:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2894C285357
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 21:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FAB1DE4C1;
	Thu, 21 Nov 2024 21:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nABexF3n"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125C41D89FE;
	Thu, 21 Nov 2024 21:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732225508; cv=none; b=I5vgGbPyYboolX0pLUFCcKd2hEzK0UMeHTjgODxeOxhqnuPzk0tvSB9C8i6FdDAkx9zmaDEBFT/hduKSiu/cEwym946qHnM/nmbXM0v+ws5tG5IIB8h/ZrfvhXGTM5aYeU6WJiWZ9rOeIG6Z2RsEU9FZ+SkAN3+OjwRxTnEk6yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732225508; c=relaxed/simple;
	bh=0LAXpjrIXDTGcDjf5bRQOuzZP1InxdcfDurREwzcnTQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G5d2BaM4gbLa7l11b8BJJwOShg1xbQYkw7ieUsH8OhZPihYDXQS53L3gh4Q6oqoNBrtVrRNCvs5cXuvsnD7U5hHD3VBvuNBkwa2HtzL8C0yrpjGonJPUPn3dRVNmFnh4MIzvz0BgUapTEysXl7ko82jA38AwwXrlawQT2rLuGoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nABexF3n; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3822ec43fb0so1066897f8f.3;
        Thu, 21 Nov 2024 13:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732225504; x=1732830304; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eo67Lrb2R1KJFTkaX2vbfvEw3YlDY32zvrK100N1eVo=;
        b=nABexF3nl5P1cToD9aRDW8mAPU86PUTI8Z6OmQG0DvbwhGwNQflaZjq6zHF138wo+1
         oFiOioC/oVwT/sbEDkZgf8IBA/+1ZcuUqGs1K0su83Le+uwrFjVa8OdDTsFmoaFVegKD
         mpxGi6mVDUb3+dQH9lMUNFIuJOBiQDTUY4c5WsvecRjBSmKjakmozQTmDnzBSaoUpbRS
         LaesVHHCJWjRDUmQ2UjVbdjCNjFvhuTu23mQWkvrYAW6WtAigOZzx495bffT6pX0qeeO
         TmJFnQfE+ax1n+pUzlwsaTQJ2QeLOLfVMCxpaBTKnJju8HlPQ2bVRN8qqiJ17+Q8FbA+
         KVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732225504; x=1732830304;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eo67Lrb2R1KJFTkaX2vbfvEw3YlDY32zvrK100N1eVo=;
        b=nuGdUKqKtcXGnCTDKuU81ObH+EmiDzILuTySvEfMNzMQf7oKqY6IkIccGsWIuFrPhL
         AWtRRf2Izd0TwbwQrD4924T0ICiMNx7L+jnwWASAeWebhrbRSEdkh05elq9tnu34D7B1
         fsIb+plCLSOm3UQ0Elw3bI8cMBNxMHJ7JbYUvNiXKTrAHuWmjgMQ8D7+14qYABJyOPl4
         67ipwP8oh1kCqCM2yQ1hHiJ/80rb5YiNdasWJTIsTerIcKgP6ycaFfWUGGKWh6DRIspG
         LxgrPIMYT4l+hwvdAnN7V92m8kYFkgUXhQ8LH3qfIoCCSIYNd6/4K1xcb/4vnvFAoVDQ
         TCYg==
X-Forwarded-Encrypted: i=1; AJvYcCXJxsEnwt06/ZhnVqpwZqdpJu39LJezIEEQPUjtkM+CuPgorqUVhskrwLW0PowzL7Vql52W5ZityIu2Vw==@vger.kernel.org
X-Gm-Message-State: AOJu0YybgOkfO71eLCN3HIPSodJ+cpxoeH016/sxeXfNVuC3EuLg8dYV
	tYdhtn9+tMCCkLeWLIKghkv6NJncIqFMZKMn+7lApNLT59O50XQG
X-Gm-Gg: ASbGncvOQEJwa0FKTG1bhPpKR4bpObHRxHclk3ClF4QMpTEKghceXN8Ymia87dGPdIJ
	LHw1aP41e2ghKE6KCTRytOi6kPrlnt/J6IUQbSXgWyFpyvEYjG7nOVLykI93rPLa+oVrbVnmOam
	d4tU8vNUcRRNTcNVMRJYErWSNblaom6AcijjXXrSIyu4EGe0qigEItgM6YtshWa2nTCwQgeLFoP
	h8jDtm25JimUo3SlfyvGzbUE0/Ff5VR1CPAW+qfyBzeTSJ1fQ6ASuo/1yQ50y/wwKsAldggdpon
	ZKLw0yXTGwJyShnhSNO5K3SJ6uz3JQ86fsxfHEsNs0CfIUGxanXt4O09igQdn61kz7W4q/nw
X-Google-Smtp-Source: AGHT+IENwl0u1jAvGV1j4IqYjte0F/icltzkCHHVniwwHntxK7xdgRyqdF4VU4jh6dTQTYsiByRC1Q==
X-Received: by 2002:a05:6000:389:b0:382:37b2:87ee with SMTP id ffacd0b85a97d-38260b581b7mr511271f8f.21.1732225504274;
        Thu, 21 Nov 2024 13:45:04 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-7b6a-90cc-9bcd-a2c3.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:7b6a:90cc:9bcd:a2c3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fb53858sm636694f8f.62.2024.11.21.13.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 13:45:03 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 21 Nov 2024 22:44:55 +0100
Subject: [PATCH 1/2] MAINTAINERS: Drop IIO from the title of the Chipcap 2
 hwmon driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241121-chipcap_no_iio-v1-1-6c157848a36f@gmail.com>
References: <20241121-chipcap_no_iio-v1-0-6c157848a36f@gmail.com>
In-Reply-To: <20241121-chipcap_no_iio-v1-0-6c157848a36f@gmail.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732225501; l=734;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=0LAXpjrIXDTGcDjf5bRQOuzZP1InxdcfDurREwzcnTQ=;
 b=jhJ6h9hUObbVBStEWbwVgH8AvgjAQcJGzcIjb6BzlYvuzzjsOdECp66P5VFoodfOL8uW4+X3L
 Gv1/L8d6weDDgSryfhOvmCQMIcJ7rNa4lWtNK2fYNMM1p2BzdvmUH9t
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The Chipcap 2 driver belongs to hwmon, and not to iio. When at it,
drop the sensor type description, as that is documented elsewhere.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 20df6282d1d2..91936a9ba56f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1226,7 +1226,7 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/rtc/amlogic,a4-rtc.yaml
 F:	drivers/rtc/rtc-amlogic-a4.c
 
-AMPHENOL CHIPCAP 2 HUMIDITY-TEMPERATURE IIO DRIVER
+AMPHENOL CHIPCAP 2 DRIVER
 M:	Javier Carrasco <javier.carrasco.cruz@gmail.com>
 L:	linux-hwmon@vger.kernel.org
 S:	Maintained

-- 
2.43.0


