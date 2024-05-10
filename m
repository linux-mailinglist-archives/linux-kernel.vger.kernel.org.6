Return-Path: <linux-kernel+bounces-175879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DEA8C2694
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 16:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B7AE1C21EDF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACCB16D336;
	Fri, 10 May 2024 14:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="omrWThs4"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1597A12C494
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 14:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715350759; cv=none; b=h7O1HOklgkUbk03q8jjRRKY03Vdn+j3B2f25vqDq2LIMoTLvfZP0kVPPLArw1nxNUTHFDh6icsWhXNZ5ipLJx1ibBBxPrzGUilzlv4MERGqrUTofVIOzSS6Hf1Ur/C8G8gQdCrBrNfkzUzcJmo/5TJSyodimcLDyXhOHN5DT2KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715350759; c=relaxed/simple;
	bh=xxx4t59lacJdCYKqV1TwqAC4SVodzhIeAGYW6khLtXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JW7h5v4Dw+1uArc6J2cMhZj8Ei9iOtN+lkC8z1FLiYcRscwwMwFTOMluwy7n0tM359DAX9H8NoSjtSeek8yQgvlg9B0j4KYalp5nLYIzulHzYNjt/uKKNjp+IdQIfBhX7lW6PLVvbvj8i87ekoZ6YYobIEB2v5YUGhYRCM+rH7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=omrWThs4; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2e538a264f7so11439641fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 07:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715350754; x=1715955554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p2Vlnws5FiAdjm8Du8XlBvr/Ou/c9kQRn48QLmV0BFs=;
        b=omrWThs4Nv+j/ZDfWNiUKVjk9RZL2eE494DUT6Pj2My0lTtFxCzxmuLdZNTlGjdUJ8
         LVchddRJ/OrsdmsSu7esGYAWu3T9YGgxZ9FoYkt8b5865ReoQQrK8rz2lg+OXBSite/4
         A6g9Ui3X61sPnSzzTa9jlP0oPU/F59p9iMQl74z8aIZUbb9j8imdRolMC5Q4eagfsxO0
         182U5SFXkYr0vftFrkq5bY4SuwKMjjqE66IQRaB/UHtwGBYbU2n7Pmh6GjEtM16h8vaG
         BXY2KCfpb34EXjEFPZnBhasXY3nBKJSfmeezhkS8seYrPxQ6KQTXmsVm8xzoWCjK7vJX
         6ykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715350754; x=1715955554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p2Vlnws5FiAdjm8Du8XlBvr/Ou/c9kQRn48QLmV0BFs=;
        b=vyWNfe66wnf8gn+eblBqrbDxuPa7i7uLK7aWf/VBTq5ubcbMUsD2y3xfWiiwPQ1tvU
         wW6LUb4/GPBPH0Yf5wQx1BMrDXvP59lzIc1UVZ2Z2vgKB+xy4yDhtmCRYB7ItQ0nBovR
         kQfqIadUjGggOaHFs6y/hBt/ckbgOtkNQRWKVR55Yl8Cz68oJ4yw1G6PCsIdGrA5fytH
         5VvRcWP1aQOWOjINYp4HloGKEKrjbyKGF2qLxztHqYS7siKbMVQOZSuC296vqwIXEJHi
         wK/DEgR+HMRcI0VdRSSrI2DVqNkkDhtHq0jqXAJ9rMdG4QcDGDTM+kyj5+mY1slOSgTp
         TfSg==
X-Forwarded-Encrypted: i=1; AJvYcCXKxzn9ZM3Z0N9Vrq8tLsZyEnB7wj+T7oJka8jrNZWj/pYH3Am25+L66lG4t34kJu5JIxQrEkHJgWWdBr08ou4DphdSUjMiNdE7VhSS
X-Gm-Message-State: AOJu0Yw7sq0oGlGY5zDsYOn2aV90ErS8z0bc27bVYvrhXDPTnFlJN8j0
	T4ho+AFygl7KZ2L73RoNm63nGxndcJS9+51wPmzBbWxmAL0Ncl1YBTSkt5EpTA0=
X-Google-Smtp-Source: AGHT+IGpJWrJsfoOoQk4zUMuiUHP+YlLGjm6rvptjOJOKUVTGe3fh/K/iMDcN0xqxLz1thXwhYEQOg==
X-Received: by 2002:a2e:b0d9:0:b0:2d6:c43e:f0b3 with SMTP id 38308e7fff4ca-2e5203a50a2mr16994981fa.50.1715350754136;
        Fri, 10 May 2024 07:19:14 -0700 (PDT)
Received: from localhost.localdomain (host-79-47-39-74.retail.telecomitalia.it. [79.47.39.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fd97e842csm56111875e9.24.2024.05.10.07.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 07:19:13 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
To: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: nuno.sa@analog.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Angelo Dureghello <adureghello@baylibre.com>
Subject: [PATCH 1/3] dt-bindings: iio: dac: add ad35xxr single output variants
Date: Fri, 10 May 2024 16:18:34 +0200
Message-ID: <20240510141836.1624009-1-adureghello@baylibre.org>
X-Mailer: git-send-email 2.45.0.rc1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Angelo Dureghello <adureghello@baylibre.com>

Add support for ad3541r and ad3551r single output variants.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 .../devicetree/bindings/iio/dac/adi,ad3552r.yaml       | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
index 8265d709094d..17442cdfbe27 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
@@ -19,7 +19,9 @@ description: |
 properties:
   compatible:
     enum:
+      - adi,ad3541r
       - adi,ad3542r
+      - adi,ad3551r
       - adi,ad3552r
 
   reg:
@@ -128,7 +130,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: adi,ad3542r
+            enum:
+              - adi,ad3541r
+              - adi,ad3542r
     then:
       patternProperties:
         "^channel@([0-1])$":
@@ -158,7 +162,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: adi,ad3552r
+            enum:
+              - adi,ad3551r
+              - adi,ad3552r
     then:
       patternProperties:
         "^channel@([0-1])$":
-- 
2.45.0.rc1


