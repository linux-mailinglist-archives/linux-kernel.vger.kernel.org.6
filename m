Return-Path: <linux-kernel+bounces-573062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DFFA6D282
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 01:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C1797A501F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 00:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D564C76;
	Mon, 24 Mar 2025 00:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wV9rqLZ3"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827A7A41
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 00:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742774961; cv=none; b=CF5fUoVBuG8Q7/c/X+mvTB7sqvHNhZURKhG4+5biAcDcjCwA5o3LEoFAPQAnpSpsCXd5horfCfrzSwCWq0mh1r3Vl0xrRnsKGnBym4W0CRfYNB7wWwU4LRDNo1AiH1PaXxB0xgPB/jeF7sF3ZkSviTOhWDWQxrlynplvTyiBQdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742774961; c=relaxed/simple;
	bh=4SE6Vemd7wCvaQkb0zYO/4W5da96PGXTFuikVtM5DMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n58amsrlq9KdJ4LNJTC9GGqpmOQBnORlAIVqh3snehx7D0IdBrRBEmQZvXdm4hLv04LB3qyqMmC3XHEyluWgkqo7Y7ap5qVFQY+5lkNXfYYInVG7F2Ay/gxydGqEU0HDsELSab4pLIVhes9pM6zVPRv91FLHkt7cwnEN3o962m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wV9rqLZ3; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4394a823036so38346705e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 17:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742774956; x=1743379756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gauWOuFMhrQoOGnZl7R840UuLn45kjs8rhjq8TVBvu4=;
        b=wV9rqLZ3zdKTASl+lMLx4pBUKy/BUtgv4M0p0bYluRmaeKHw89dO1Ps8pWzwOeQBNI
         Er06OSzxDOCD9VFtdE7A8/ncsa5VMPnhN2vUHw76f9VzQZdVMwXtWz+ViBGvLoy/0zUt
         0UR+8BseIC4WRpvCv9YxxKqdqiN5LY2LDIiz39n68kz4Dj/eQX6YMXBzGcqwmTH9r8lM
         lWJrfakvSr7X5eLbtVN0pjqMuU8PkrRXQ4rUYAlvNMWJ8XQ4DlglhX+bBj/B6tAakgIL
         c7fnpy9TsQ2nEZh1SeB7+qrKARLo6fDaXOseKeXjk2c1NMxH3c8MSD6BfyCVB1yVJuMN
         TL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742774956; x=1743379756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gauWOuFMhrQoOGnZl7R840UuLn45kjs8rhjq8TVBvu4=;
        b=wDUJAGirt1Xv37m6KoE+IBWFr98fWv9kq+ytSqAcV0WxYHhQxC4wTYCniYvj3+w+vl
         Mr4peu2oRXJ0FlOGoe5FhYTxukP9ppUa8nrE8lqiSso7Z6Ikh1Xgoyj71KBjFCxSymEf
         V8c5pk2aUxDNEC99ui9jLxAuk3d7RHKMqwfYnlLU9sY/5xKwprn+05NKHHC4dRo+Nbr+
         /i9hCv+H82rCmbEQSgaaBKezMAH8dqJdaXLvAhxFJ06h4ee8UfMY0dEgcrdOKT1mtf5O
         WYMM0P5zxYCuohE8giR69q4xDqmNcj32hLuasASu04yjoJOLJLf0caKc9me0blEWNZwb
         Uqhg==
X-Forwarded-Encrypted: i=1; AJvYcCXORowDTGAXLIJ7p18//UZmELxUAPEWjNv5E4VR+vB22JhGPQz3jaYEKfMGkRoWHt7iCq0YTABfYzLZEmc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylsu2wRc+YheTQbODLyMvRin0TbkioFICX4bMsFmNMCMR5CgVy
	vdr9RSsgiZa+txorY/glNLO5N5D2k+diSclG5mq8SB9PHn5gp6bYCQVwoPqozJU=
X-Gm-Gg: ASbGncvAhYQcUojvpSwDvh+pZxoFPap+hAgOwUOFqTWfiDtw1m/U+nsQJaPnba8WqBX
	esAJL17L+RKLMBj2jDKQHOD9eXeCxHUUKoLmImD7vmtzPNpyGyc3ple+iXCEhvN8sgTeo/utsd4
	qrWii/CgJ4lVvoz6CdY/EhpoxHgvP5q8nLCfCtKjQnIRsRdnt3WMCULgBWrtvAWcfHgZ6rIJaks
	9LUUnqgCCQB3oWrY95R9tAUEdHhR7NgopNerjgYYMch3xzeRztIC4QJwPfIszYxZBSwQlgQx+to
	E3TPiiLU2/N4VCqwvJ8d42ikqOONubTFx42Xefg7WD+Wx6Zx1/Yt80r4fqj1yL0fbaRHIKSQ0uB
	bxTC2SuRVbkv7Fzu3PQa5qjsH
X-Google-Smtp-Source: AGHT+IER+yqN/cM6kd9faSy6V83DVxh7Xz9oy23ZPLx/sUlAswJ8Qvfspc/M7havH/WOMCaE9dvfCw==
X-Received: by 2002:a05:600c:1c18:b0:43d:7a:471f with SMTP id 5b1f17b1804b1-43d5ddec8f2mr43639035e9.18.1742774955623;
        Sun, 23 Mar 2025 17:09:15 -0700 (PDT)
Received: from inspiron14p-linux.ht.home (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fcea6ecsm103160875e9.5.2025.03.23.17.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 17:09:15 -0700 (PDT)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To: hdegoede@redhat.com,
	mchehab@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	sakari.ailus@linux.intel.com,
	hverkuil@xs4all.nl
Cc: linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH 0/1] Add OV02C10 dt yaml description
Date: Mon, 24 Mar 2025 00:09:11 +0000
Message-ID: <20250324000912.105662-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319145927.70534-1-hdegoede@redhat.com>
References: <20250319145927.70534-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here's a yaml descripition to accompany the V10 OV02C10 driver currently on-list.

Link: https://lore.kernel.org/linux-media/20250319145927.70534-1-hdegoede@redhat.com

This yaml passes dtbs_check and dt_binding_check against the following dts for the Dell XPS 

Link: https://tinyurl.com/4a2w3vje

This patch should probably be applied before the driver patch to fix

Applying this patch before the driver will fixup the following warning

WARNING: DT compatible string "ovti,ov02c10" appears un-documented -- check ./Documentation/devicetree/bindings/
#1030: FILE: drivers/media/i2c/ov02c10.c:991:
+	{ .compatible = "ovti,ov02c10" },

Which happens because of the OF compat code I added in.

Bryan O'Donoghue (1):
  media: dt-bindings: Add OmniVision OV02C10

 .../bindings/media/i2c/ovti,ov02c10.yaml      | 117 ++++++++++++++++++
 1 file changed, 117 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov02c10.yaml

-- 
2.49.0


