Return-Path: <linux-kernel+bounces-373410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7C89A565E
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 21:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5788CB26837
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 19:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F2019E99F;
	Sun, 20 Oct 2024 19:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kd2jBmVt"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9AB19DFA2;
	Sun, 20 Oct 2024 19:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729453262; cv=none; b=e5SWV7MvQikM42UgFYV16+PdGDvdyEiyeLo71UzVpH0II5WxyZsbIiTcrEKrkDO1wAyAJWS8KPRmraltspYwR9yUp5th2YJC/OFNWpxDyNesKRWUerxD70uELO6HXlaSB9UXgadWIex2IxHB+ecf1gzla5kPiiGuXhBZkSQbXvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729453262; c=relaxed/simple;
	bh=vQuT3L6rc9vWaZ/EWtF1G9rYOOkIEaEfIlJv70IODv4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RiKV0MaLMAyZJ4Q2ZjfgKZFHX7IWDfHVew0IqWqoeYanpBQgq/hgsefcIjnEvDpe84kOFawTFdKatNdkEjJSMOF9L87BWpJujM1sfV6MrgBOJnrcV4jnBMPpAW9X84fCJtg20tYMjhUVXiWhEwPZC0ySmdh1YTWBNKveV1vOnqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kd2jBmVt; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c937982445so623103a12.2;
        Sun, 20 Oct 2024 12:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729453259; x=1730058059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=42eiRTlqppEPdlQyYP4ty5FmuBaDsgsIxAXPLaOUkSU=;
        b=Kd2jBmVtz6au1D2YMAe7Oqd0lftJPjWhUqB55r4fFq6nDL7dIJUSEqdDNFT0/amsN8
         F6UTVlACe/wrNm7DpEEAumseecX7UHdwRMWRuzgCx/Gu4fGo1vPFTwtxKpNy//8iqSkP
         a1S9Nyg96/Up/sLQaFcQHMTS4JM/u4C4nZgYPYQDgHTYbOrkI3WBXJftFYzhbRh5ytt8
         iY5wKRFG6JnW3kufF0OwlzU4741c6KjMw07D1TIrtsf9WvlyX6E8kw+4ZYs3oC0S03gd
         1UNq0TuRLU5N+TeSlxOaZQLjc0jSvj1Va85oLhqTXsUgdlPWVItR+E/iiUtpKJaldrid
         m0Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729453259; x=1730058059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=42eiRTlqppEPdlQyYP4ty5FmuBaDsgsIxAXPLaOUkSU=;
        b=cON6szkRoBxnWH9xLbTSwXtN4e4Yv1n/UF6juPxtKSP47zi3AoTgmgORWreG2EC9wl
         5HqkwrFB9bsXvy7gqkv4CY2M/cl/gG05U5OsetMD7ifEb8J/niJ+aS26B+Hy32sZDWhk
         5DjtR0F4zGvugoEFYwlQPinlxi78wdR3q8ZCucOy3rSScVnKdK5J2qeevldBZYvJIGqW
         iJQYDrnxk4k9FGkv1f1QGbFC0UNzLuzOp6PZQMognCkchmmSQjt7KFIhP8yl/t4ECc5m
         tHqHsc90ds1MNBc5Yt6ZfMTQrVuYza8GgxM0JXRsjuWQqSdysTqlIR+FPkJEGw4CLlyK
         NCdA==
X-Forwarded-Encrypted: i=1; AJvYcCURZrh7Ezf0wylx+FCxrMNDDlUurKK+L8iArdmMVLWnxUuzBQw3p0yHXpWzwqpX3yoyHhz13yaWRvbcQwAs@vger.kernel.org, AJvYcCXVmmT8fRLcqaVuRm60Dv9OMD7uTRGbYIeGdYc+2Zpfw5BsRdEvtS37jRQ9dcyCR/fm/pvHWsvgEudR@vger.kernel.org
X-Gm-Message-State: AOJu0YyVNCd+bKrrkQiGhQiCfUc/aHmYS0oexBqNidwiODOCxwFJH5tc
	sFWaM4NCmaf23MXBdkQwaJE8E6Y0XVeNN7AgIB5pv9PR9UewUUkD
X-Google-Smtp-Source: AGHT+IEFKctm5ORYyOyPM6Xv7NfTtbynkwsp309tnoapY4KhVkrTEmVnb5VkNGHFo0aiPdIk3QK2MA==
X-Received: by 2002:a17:907:6d0b:b0:a99:5f45:cb66 with SMTP id a640c23a62f3a-a9a69c92d01mr446679266b.11.1729453258576;
        Sun, 20 Oct 2024 12:40:58 -0700 (PDT)
Received: from e8ff02ae9b18.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91578129sm120576966b.186.2024.10.20.12.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 12:40:58 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	marex@denx.de,
	s.trumtrar@pengutronix.de
Cc: l.rubusch@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv2 20/23] dt-bindings: altera: add Mercury AA1 combinations
Date: Sun, 20 Oct 2024 19:40:25 +0000
Message-Id: <20241020194028.2272371-21-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241020194028.2272371-1-l.rubusch@gmail.com>
References: <20241020194028.2272371-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update binding with combined .dts for the Mercury+ PE1, PE3 and ST1
carrier boards with the Mercury+ AA1 SoM.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 Documentation/devicetree/bindings/arm/altera.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/altera.yaml b/Documentation/devicetree/bindings/arm/altera.yaml
index 31af6859d..51f10ff8e 100644
--- a/Documentation/devicetree/bindings/arm/altera.yaml
+++ b/Documentation/devicetree/bindings/arm/altera.yaml
@@ -32,6 +32,9 @@ properties:
         items:
           - enum:
               - enclustra,mercury-pe1
+              - enclustra,mercury-aa1-pe1
+              - enclustra,mercury-aa1-pe3
+              - enclustra,mercury-aa1-st1
               - google,chameleon-v3
           - const: enclustra,mercury-aa1
           - const: altr,socfpga-arria10
-- 
2.25.1


