Return-Path: <linux-kernel+bounces-353445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD6F992DEA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD98C1C22EBD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBED1D54F0;
	Mon,  7 Oct 2024 13:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lS8ZamyX"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA5B1D47D9
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 13:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728309323; cv=none; b=XCjdqZ8QeiQmwDNWQIgBoVnM1qz3oioT2Y7P2G/T83SSLj7wPcbV0RL55Lk3mWkaJjGpG5ls+umbIcHHMh4c2HRIDoaSCLKgjUyLRrjgMoSt3dpsDjUogzYhEezJmhIBS5fUZcSX6MIpqXLk4UOeCYGLNIZ8a5yxX9UF6i9b0dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728309323; c=relaxed/simple;
	bh=WkIFA3Bbn+M2B5VzgzqBsaRxhzbrBeYNIHEndslM8DI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FiFcE4FJV74Y7uNB085O2KDJXDNk4cRTC+0/TWwwWvyUJoFuMZ9wfCv2m+yPSET5Zo4DF82xn7Y7znwhPtkYP4NE1JtuecVben9yIqO26V4Nm8KKagr1V1UxYeVtWPziLbhVMCFIgscdWMwhDA2P0IeVkJUSVZXSxUu/2Bk1Xng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joychakr.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lS8ZamyX; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joychakr.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e260b122770so6592936276.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 06:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728309320; x=1728914120; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CblMzpCPNydZZpvacmjghKpdVLiy01vOQxnw0IUvqWY=;
        b=lS8ZamyXxnbKqpKuIf5E/mv6YmXlWu1PXd7stmV5YK6mPT1cpUsbGUNeh/1cvuhfZg
         Ii98egDa2o0NtsmB3+qqd36NXK2ZDI0hUXJ8NrxPljeMVBltr9CFsPN6gyvGozi9Pl6P
         +niv8NgHQJgPHT+7foJFoqKlc/Mm4WxYpF66j5TbLahdIofcVrXfDe4HLkEEkIPHHmjy
         XgtluDG0TO48R3OwQhJ+UgxleVRsOIREi9nZyXDSEQ60UpxmVPbz1dMnK2o/yxhMEK/O
         7qzdNk3PSz6xb5/w3csMac79WYCnHXmQPOeeTfPxBAzAEQ7l/piXnIwwMZcAM41CsRjz
         CyEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728309320; x=1728914120;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CblMzpCPNydZZpvacmjghKpdVLiy01vOQxnw0IUvqWY=;
        b=UXXXDJXA9dQbhvzyvc+tCTZg1AYnQlXe9+7C5VHundrnQY/7ILExe6G/6k+IPcCwgU
         MwPG5NaFzQ/V1oQ16/W6Yw1iQGVSLCsuMD3NCw8mWqiPWdMmnYlbM2tumtVYB30TTvvj
         aaigAS8VB+cFVblFvY6hHiCdWRnrrk5JZfYU+JWA6NUvZ/ZT3BLDtJH4z7c44fmCJELP
         B7cCfGlcprqLHTmhUQxgl5u0B9T77UupUIxpc47tcgfo8X8/7QcbPmVzBHqCRv11JtNY
         +xVPm4LCbCgXU6xp6lElWzu53uxykJ0p2rrQtLjyf9WKv7U1F+eDanSJPjT4Md27CSUe
         NCKA==
X-Forwarded-Encrypted: i=1; AJvYcCUhyKFUywJI5IbqVbHHX7E4eO0KvW/GmvXie0m2R6Ug+LrvWN9cDZtd/OiP889Gh+psdJPE59WoYyuXqAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEUFLnVJk52AL/HGrfda3BxETOVK8rziKcx0kzqYnxH/UDrWEk
	TWdSHxTJ8KOMIil0KxF2J7LHBE2qOvq0PrJCC6Q+dtCVUhyfG49fBZsWUl909h+dJ04EnzVogoC
	WkRSVRqOgCw==
X-Google-Smtp-Source: AGHT+IHENiCfXeLIY8OuGdXiRZ0mZC1NUSLuuz9kZp63rvGsqpTXO15oaagthIfQlsuXinVnTY8fy8lvpJBe2w==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a25:dc86:0:b0:e1a:6bf9:aa83 with SMTP id
 3f1490d57ef6-e28936d0742mr52400276.3.1728309320208; Mon, 07 Oct 2024 06:55:20
 -0700 (PDT)
Date: Mon,  7 Oct 2024 13:55:05 +0000
In-Reply-To: <20241007135508.3143756-1-joychakr@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241007135508.3143756-1-joychakr@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241007135508.3143756-2-joychakr@google.com>
Subject: [PATCH 1/2] dt-bindings: usb: dwc3: Add binding for USB Gen2 de-emphasis
From: Joy Chakraborty <joychakr@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Felipe Balbi <balbi@kernel.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Joy Chakraborty <joychakr@google.com>
Content-Type: text/plain; charset="UTF-8"

PIPE4 spec defines an 18bit de-emphasis setting to be passed from
controller to the PHY.
TxDeemph[17:0] is split as [5:0] C-1, [11:6] C0, [17:12] C+1 for 3 tap
filter used for USB Gen2(10GT/s).

Signed-off-by: Joy Chakraborty <joychakr@google.com>
---
 Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index 1cd0ca90127d..a1f1bbcf1467 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -190,6 +190,18 @@ properties:
       - 1 # -3.5dB de-emphasis
       - 2 # No de-emphasis
 
+  snps,tx_gen2_de_emphasis_quirk:
+    description: When set core will set Tx de-emphasis for USB Gen2
+    type: boolean
+
+  snps,tx_gen2_de_emphasis:
+    description:
+      The 18bit value of Tx deemphasis defined in PIPE4 spec driven to PHY
+      for normal operation.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 0x3ffff
+
   snps,dis_u3_susphy_quirk:
     description: When set core will disable USB3 suspend phy
     type: boolean
-- 
2.47.0.rc0.187.ge670bccf7e-goog


