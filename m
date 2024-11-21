Return-Path: <linux-kernel+bounces-416559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B11129D46DB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 05:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 316CCB24255
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 04:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD55E1C6F54;
	Thu, 21 Nov 2024 04:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRBtq78u"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963741F956;
	Thu, 21 Nov 2024 04:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732163789; cv=none; b=IWrQn0J8lmQ0B+/Groj2G393m7+BMtLhSmUYG4ySziVoTpzQdxXmnVgyxbrfNCKNC/ZKG9skrcEjAvl4/w2JvaS7l/K9L/6/PzO94woM6HKyeMQlA/MWLGc5MHjePQTsdka7Uy+38SJJorp6JwOxGHidIlofa4EKaR6TKnFRvs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732163789; c=relaxed/simple;
	bh=FgpAIoX+4e+QQroE4QsDxMK/L1w728/CM4HFCE+TVtE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d+5bRoT4rSMr6+wFhRcacOpRkvVpZIKJtRvKtDUWOGcMN7ctEJ2GI57lY2xM/rYOJVUr+V5PaIutL0R8McPDOwYffS2VsE9vlBX025vVmcoiN3tQsgbSZQFygAqgxpLGraDMoe6WI96sNlSJ5SSlt0+pFN0Sr2vaPEegfh1lx5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRBtq78u; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e387e50d98eso380621276.2;
        Wed, 20 Nov 2024 20:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732163786; x=1732768586; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nuyF7+8Fz7Mpttrs+fI8NL75TsOEWtX+J92XFGbgaKU=;
        b=PRBtq78uCNMP51RqrJDOGkYqpuzt+c2qsBQTG/dU0SM+HSQwCHHyoPkw1DM7zbefrd
         mBEd6nH8DeXy0ZuC2Qeq6F+IWDz8e+MXWlCFis0ajnUgcrYA8h4Gb5D83zm/sChTOHfT
         0sHdxn/cMWxkp5zHlCtj/3VFa2TIu/2FfDseZ7T0oHiyuqwcoKKvF1GvYuFQL2iryVh5
         pC7y4dTwq205r2s6A08zFDSQdW0Oh+uv7Si2PDsAA+lh0HMZH0GxuHRsoVek9bcmrBKd
         WQALtHXs4oB62+MF+UqfiXhEZ+BakaVO6Xdv9gt1v/Jh2I/Se0MgYb8VAnDTRgsplP3l
         0yeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732163786; x=1732768586;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nuyF7+8Fz7Mpttrs+fI8NL75TsOEWtX+J92XFGbgaKU=;
        b=w3wX1FCKnAsEgNNLD+quCzCGkRRDpViD90W/dlSDl1G8H+jnA/DjW8uqHM04bUeuVJ
         5ylHl4qNPMW1eWncRnrc+5e5iEAG4+6gWzqYHlqvVd0w/gAcP059MV7F4Qna7mtA59lX
         tP1nIyAXkjSkGUN4C4VkwOlVR5SdhljDwLojz7BHKdLlbYvCDxATWp5GOKRss8qfKoh9
         dc6ok8y5WnxFR+cqYqe0qfe/qOPEkTvjE1k++EL+FpxUwlwfGQxaox0eg+o/w72+L1cw
         8RnNj2C2nVMKu/GvcWvkuY/LxOvgI/FPTlyIcrAPggUlWkn2TNcXWlJKlggikTN6JViB
         71iQ==
X-Forwarded-Encrypted: i=1; AJvYcCXB3rNjdj8o63gCpzYda0sQUaonSJhoPF7DF+X70F3z3ffC3n3ynDw56b5+9j1cTeUAvd9/BPqGkG2FMG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXrYFdVOdMXEMOykt24rjMDc7JfJjtoj4cpb6mhgpIhjSQ37g9
	2Xq0WeRi8rUOrLTkKc8MGCkiXReSeVfsSjN3wY5ETABwF2EZ6MX6
X-Gm-Gg: ASbGncvpVDMVqngPjr+WeesACsF6U8kj2zmKO0My4rXm4m6m26g1eNfpxCevrSqXtUQ
	+VUD8oOb0zMLpTRxhl1+rGVdFzgL0sEXIy9n/7A2n2UXzXPjnDK1TjMbRzHflgeVv5na5V8jg+8
	hSeDkrg1/iiIo9+kYEAjbD6d/5zhntTmNv4b11ctjT1aj6S59czZpDqReiA7QcElisVPwz3Cq4q
	67yx3uzyTkB99ghlsejrDRQatjMAjwxtJMk6dWzH1pcMZht+R7328AxwMYoG80Vd+E6T7RfHE2a
	rAvK5P3a4VJ3KWn/ZPHp5GVzdG0=
X-Google-Smtp-Source: AGHT+IF30ME5s1gaJATBRjBcX8Rto6d8Elgy0z54nRN46cpfTIYfKGmrsKdWfd4s/uRCQcRBSZkQDA==
X-Received: by 2002:a05:6902:2742:b0:e30:99c0:af7d with SMTP id 3f1490d57ef6-e38cb60dd1fmr4909115276.52.1732163786614;
        Wed, 20 Nov 2024 20:36:26 -0800 (PST)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbb64e11fcsm402013a12.15.2024.11.20.20.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 20:36:26 -0800 (PST)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 21 Nov 2024 12:34:04 +0800
Subject: [PATCH 1/2] ARM: dts: aspeed: catalina: revise ltc4287
 shunt-resistor value
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241121-catalina-dts-20241120-v1-1-e4212502624b@gmail.com>
References: <20241121-catalina-dts-20241120-v1-0-e4212502624b@gmail.com>
In-Reply-To: <20241121-catalina-dts-20241120-v1-0-e4212502624b@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732163781; l=968;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=FgpAIoX+4e+QQroE4QsDxMK/L1w728/CM4HFCE+TVtE=;
 b=BICNuLr+vifOMwP7TqOnU1nthYmDGgU8Prg5w33jLmWC6dvW4VwWc/9Zu3wGhVdjBIjx0EDd5
 qUdPwWFlLp7CjHJHpQKpOCBj3RbEa9Xfty41tXlgOVXDhtTrMhVEUOJ
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Fix wrong shunt-resistor settings of two ltc4287 nodes.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index 82835e96317d..417c0d12635c 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -512,12 +512,12 @@ i2c1mux0ch4: i2c@4 {
 			power-monitor@42 {
 				compatible = "lltc,ltc4287";
 				reg = <0x42>;
-				shunt-resistor-micro-ohms = <200>;
+				shunt-resistor-micro-ohms = <100>;
 			};
 			power-monitor@43 {
 				compatible = "lltc,ltc4287";
 				reg = <0x43>;
-				shunt-resistor-micro-ohms = <200>;
+				shunt-resistor-micro-ohms = <100>;
 			};
 		};
 		i2c1mux0ch5: i2c@5 {

-- 
2.31.1


