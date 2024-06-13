Return-Path: <linux-kernel+bounces-213535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47861907692
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8F43B21AE9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A682149DEA;
	Thu, 13 Jun 2024 15:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EShyHG8d"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96422149C54;
	Thu, 13 Jun 2024 15:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718292394; cv=none; b=mkVWZl1FpWkRZP7K36udHi7uu6BRirMiKi8qElMptiAiz3ui3B6fqCJzM2+1Fw62IODzcjI873eYSh03nBibWdS5vAgMzh5Ow+VewuNQjwtHXpH0V5lx0KgrRDjUoxr3lGJ1aeUoApj7Hb5XoMzNDp7IijgOt2CAVd3ICcJgkD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718292394; c=relaxed/simple;
	bh=FIJuzMpiAE6XElWDYJhHQOdb/cpByjr91DeyCzcLFJg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bDiR0rTOEj69ekGeXCbsG/uyEaD5Vl7Mn1jyeWEiW8dDQPvrA8Kxbem6eYAq9zg4UcvBHFMZuSMbD5YTFxdFy8Xs6ihL2/W7iUX581bhFZFxhZ/msYAnZZdGrtm6mMABf2QF7w0UNj88mGpjC+AR1kWIg0ZBvZdnbmwdW/GRVb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EShyHG8d; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-36ddf683ad7so4743795ab.2;
        Thu, 13 Jun 2024 08:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718292392; x=1718897192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jm/6BzaviY1u0xnF4/R18zgtmNVNPYtnZ73QHOb7/dY=;
        b=EShyHG8d4yGieqB65ipGsguLMCogeE89IubIUE9kLWDbqafu32sJ8iI9fAPINDVCny
         tnjY7nS3Cu+soGmsSRbd9zCzFguHxMY6fFLm5fNMXX0MwxbHVMWSv+Ex1Hx+iyi9IeWn
         9ouUjQHKfO9ubw8TZnDFeY0FyuDXFWC4fH/3DNd5w+kLBPUFoGe+WGIv9ph64QQmQ8nG
         tt4ZyVnAJ+FbkJFGOcD603V9+i8GlhC43YOVNrH39UbETeimaec64E6v1IMIGBlwrvw4
         gGRQE6CPNgtCd37DfBEVGV13q30i5iVQOFkZjX5a2/6Bj+Ae5Q+ct35kVSQ7efnLu9ul
         t3mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718292392; x=1718897192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jm/6BzaviY1u0xnF4/R18zgtmNVNPYtnZ73QHOb7/dY=;
        b=GK+ChYBoUvfN7AnzNimz5RTOiDR84svCQIKloeNULdUiiMlGhVO+JbBj+TwJw5s6+W
         cQM+lGoPg8BImTjNae8Wk12Ze+aFFhoRyBG9cJdB9iG/OdgcO0uTNB/HYiJoAs7e2X+o
         SlPcV3LlmJIH02VJIC75IZC7QmWFWOAZs5SnZnxhfCR6ltzBzqq2aWQKNWB8FLTiMFAT
         sszCCSkvS+7qivz0512FaF6RqnV0pSzsbUlMUPxhOB8Ihn2uDlHSw5IAbh9n/C+x76ld
         WY7g3nMHgQkvu1HPgWBRkN1QLQvFnyA7eCyj0z7Jb+cKyTh9N2wl3+TYpR9efy+tx7Pe
         mUaA==
X-Forwarded-Encrypted: i=1; AJvYcCUTZiQlZEbwRHNBqT9r9wzswVTHHKd8IHoESuuLMIhEIsUmVFWLzrnJFIDT6HchtmWLrtbsybJHss4Xex9lO2jl98bk2s3eeqRt6l/1TtZ2w24ymNNVuoUromLqOD7pkPvcKpsjPdEYkA==
X-Gm-Message-State: AOJu0YxPAlrIefziyNbbWLv72WDgKt5rhARDK5/F1thIHPigMn+o5T0D
	V6mTEyhK2NLbWL/KRdXHVIdp45YWzq+Z6917qlN5h/xOSNwae7QAq+75Ug==
X-Google-Smtp-Source: AGHT+IGa5DsLl/zZLbHkZItPNrjZHZht4Iydu4WtmU5bEERKH4wR+X+/U/92szyeUtIbFol0T8qeWA==
X-Received: by 2002:a05:6e02:1544:b0:375:9ecb:acd3 with SMTP id e9e14a558f8ab-375cd14a6f6mr53447555ab.9.1718292392615;
        Thu, 13 Jun 2024 08:26:32 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fee41663d2sm1198183a12.92.2024.06.13.08.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 08:26:32 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/7] ARM: dts: aspeed: Harma: revise hsc chip
Date: Thu, 13 Jun 2024 23:24:19 +0800
Message-Id: <20240613152425.1582059-2-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240613152425.1582059-1-peteryin.openbmc@gmail.com>
References: <20240613152425.1582059-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Revise HSC chip name and address to match LTC4287.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index e7f4823ca4b3..0d349ce1f3e6 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -276,11 +276,10 @@ temperature-sensor@49 {
 		reg = <0x49>;
 	};
 
-	power-monitor@22 {
-		compatible = "lltc,ltc4286";
-		reg = <0x22>;
-		adi,vrange-low-enable;
-		shunt-resistor-micro-ohms = <500>;
+	power-monitor@44 {
+		compatible = "lltc,ltc4287";
+		reg = <0x44>;
+		shunt-resistor-micro-ohms = <250>;
 	};
 };
 
-- 
2.25.1


