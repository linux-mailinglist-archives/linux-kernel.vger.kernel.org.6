Return-Path: <linux-kernel+bounces-208059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B7C902016
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 13:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DB98283864
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 11:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8247379DDB;
	Mon, 10 Jun 2024 11:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwTLyyU7"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F71271743;
	Mon, 10 Jun 2024 11:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718017464; cv=none; b=dAcdAWUnVbWbBxXsjEE1SI9etQ2RJ2xSDSMrq9ZxBtkkiCp1O3tJ2UvWxFxK3/ReZrC6frLeDK/vNvYNrHXO8nZsETNk9pvt84eD6/094NliMff9+2jly1+bXF1INwq4GwwL3qVuEmmJsT1dSynKkJ0nF5ZinvKjCLSGOzY/2aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718017464; c=relaxed/simple;
	bh=Rhd4C7jBJpIrZYQpt64Sk3uGVn0B6WNcWi3RaRBDXNU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Zz5M2zOZ2MZcbXhVv4W/ktWFHCy4ydX+mBfRu5CNYIrS5N3iELn8tEf/Kw+6HCncemjwm4LWrQ8pk4+aG0lLP18ChjTrTFcUFxGKVBLBeXnO+R9qv0il+EVTH8/T7WwXvPqbnIvK81AZjlF94hdnmciWwxSskRAePn0Ml8VkDHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BwTLyyU7; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4217dbeb4caso11816075e9.1;
        Mon, 10 Jun 2024 04:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718017461; x=1718622261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R/xEDXAqitO13KlKYmS1iY3HLgQqG3WKHFlTJtXJMTM=;
        b=BwTLyyU7NKRymtCrGOzF0Nacwg0Iya/fq9t8lcNhanCiV4/rFztbaxUOn4cZB9GZYI
         pR70TXLPZawvXrggOLVeevXzPFK0FzjSjOvoD2OZdI7mT1UJW6q4FxzFaqURoKTP2699
         X48D3F1Y0LDhE28KJXDO5HELsGPodjmHtBZnluqVGCF/wCGGzWBZM87rKe+P8s9ggnN8
         EBaNQ5wjrTJjKde383splqFx+LeEZ9BHfIuYYeAZih/5+EVw42v7R3iaLlBDNGLeFiNY
         rHyaN7EhKEzLmBbNp2Sdm04+efo4uYxlt2TI5HP0FIDmlOHf9T07yabTrRNAyTCfNflF
         Lw9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718017461; x=1718622261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R/xEDXAqitO13KlKYmS1iY3HLgQqG3WKHFlTJtXJMTM=;
        b=gSTkKmh212hRNiKAdgIxOzLt/G2dPzGJQqTf+/E613CLvJqvGNqN2kGQU0bnI2HroO
         X8OjBLqZyJ8yzIahUDHLjFdGiTHGazHMwxEFRvut4yiW0TwMi5/S3FU0X9wjtDleBsGS
         jxzZUd5jQblZEIwyhipxDmJjvxEyx+Unb0Huc4sbV6hKiRGXavLWu3hgGbUzhPS2yYpG
         ybMZPAr9f8wftjlwbEMvm7MRTp+BLCzILtprbPLm7uq1pFcUYXn1SY3tOQRNesfuJKr1
         4gPBmkCqdvrOup2FFzznH5tsIcdnInppqFow4ba358zRBacEP+u931QOoO14FywawTSx
         DESA==
X-Forwarded-Encrypted: i=1; AJvYcCW6v82Gm/RzlSg9cosLS/1cNB5Ni3fqW6gma3diCMB8RAwpjl+E/8bHtKQ2XSVVOTNGhSGOWr6yF8AqOtBXyQdMY/rdfMJjSdTJkzed
X-Gm-Message-State: AOJu0YyIAvAx3YqyOnPDCa3eug/k7GuWyRUgYllUZYLkP8Q52lll9f7M
	Cp3cQU7S1hyIQgF89/X5hsm7ovX199lEEKlEtDa2MV3sUh0C3LH5dH+eYQ==
X-Google-Smtp-Source: AGHT+IFHLs7sssFzIgkEDDuyNz7KVYkd1lIFh30BGBJsPUnyIiVXR/ZOVUYDkb16miqQYVL7Tc+6uQ==
X-Received: by 2002:a05:600c:1f85:b0:421:21d2:abf5 with SMTP id 5b1f17b1804b1-42164a32882mr93746495e9.31.1718017461177;
        Mon, 10 Jun 2024 04:04:21 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421580fe3a5sm173550055e9.5.2024.06.10.04.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 04:04:20 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] scripts/spelling.txt: add more spellings to spelling.txt
Date: Mon, 10 Jun 2024 12:04:19 +0100
Message-Id: <20240610110419.1060732-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Some of the more common spelling mistakes and typos that I've found while
fixing up spelling mistakes in the kernel since December 2023.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 scripts/spelling.txt | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index edec60d39bbf..702a50ae1ad1 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -261,6 +261,7 @@ broadcase||broadcast
 broadcat||broadcast
 bufer||buffer
 bufferred||buffered
+bufferur||buffer
 bufufer||buffer
 cacluated||calculated
 caculate||calculate
@@ -368,6 +369,7 @@ completly||completely
 complient||compliant
 componnents||components
 compoment||component
+componend||component
 comppatible||compatible
 compres||compress
 compresion||compression
@@ -394,6 +396,7 @@ configuretion||configuration
 configutation||configuration
 conider||consider
 conjuction||conjunction
+connction||connection
 connecetd||connected
 connectinos||connections
 connetor||connector
@@ -431,6 +434,7 @@ correponding||corresponding
 correponds||corresponds
 correspoding||corresponding
 cotrol||control
+couldnt||couldn't
 cound||could
 couter||counter
 coutner||counter
@@ -438,6 +442,7 @@ creationg||creating
 cryptocraphic||cryptographic
 cummulative||cumulative
 cunter||counter
+curent||current
 curently||currently
 cylic||cyclic
 dafault||default
@@ -467,6 +472,7 @@ deintializing||deinitializing
 deintialize||deinitialize
 deintialized||deinitialized
 deivce||device
+deley||delay
 delared||declared
 delare||declare
 delares||declares
@@ -591,6 +597,7 @@ eigth||eight
 elementry||elementary
 eletronic||electronic
 embeded||embedded
+enale||enable
 enabledi||enabled
 enbale||enable
 enble||enable
@@ -619,6 +626,7 @@ equiped||equipped
 equivelant||equivalent
 equivilant||equivalent
 eror||error
+erro||error
 errorr||error
 errror||error
 estbalishment||establishment
@@ -704,10 +712,12 @@ followign||following
 followings||following
 follwing||following
 fonud||found
+forcebly||forcibly
 forseeable||foreseeable
 forse||force
 fortan||fortran
 forwardig||forwarding
+forwared||forwarded
 frambuffer||framebuffer
 framming||framing
 framwork||framework
@@ -748,9 +758,11 @@ grahpical||graphical
 granularty||granularity
 grapic||graphic
 grranted||granted
+grups||groups
 guage||gauge
 guarenteed||guaranteed
 guarentee||guarantee
+gueue||queue
 halfs||halves
 hander||handler
 handfull||handful
@@ -761,6 +773,7 @@ hardare||hardware
 harware||hardware
 hardward||hardware
 havind||having
+heigth||height
 heirarchically||hierarchically
 heirarchy||hierarchy
 heirachy||hierarchy
@@ -769,6 +782,7 @@ hearbeat||heartbeat
 heterogenous||heterogeneous
 hexdecimal||hexadecimal
 hybernate||hibernate
+hiearchy||hierarchy
 hierachy||hierarchy
 hierarchie||hierarchy
 homogenous||homogeneous
@@ -823,6 +837,7 @@ independed||independent
 indiate||indicate
 indicat||indicate
 inexpect||inexpected
+infalte||inflate
 inferface||interface
 infinit||infinite
 infomation||information
@@ -838,6 +853,7 @@ initalise||initialize
 initalize||initialize
 initation||initiation
 initators||initiators
+initialiased||initialized
 initialiazation||initialization
 initializationg||initialization
 initializiation||initialization
@@ -1052,6 +1068,7 @@ nerver||never
 nescessary||necessary
 nessessary||necessary
 none existent||non-existent
+notfify||notify
 noticable||noticeable
 notication||notification
 notications||notifications
@@ -1163,6 +1180,7 @@ phoneticly||phonetically
 plaform||platform
 plalform||platform
 platfoem||platform
+platfomr||platform
 platfrom||platform
 plattform||platform
 pleaes||please
@@ -1185,6 +1203,7 @@ preceeding||preceding
 preceed||precede
 precendence||precedence
 precission||precision
+predicition||prediction
 preemptable||preemptible
 prefered||preferred
 prefferably||preferably
@@ -1263,6 +1282,7 @@ querrying||querying
 queus||queues
 randomally||randomly
 raoming||roaming
+readyness||readiness
 reasearcher||researcher
 reasearchers||researchers
 reasearch||research
@@ -1409,6 +1429,7 @@ sequencial||sequential
 serivce||service
 serveral||several
 servive||service
+sesion||session
 setts||sets
 settting||setting
 shapshot||snapshot
@@ -1502,6 +1523,7 @@ superseeded||superseded
 suplied||supplied
 suported||supported
 suport||support
+supporte||supported
 supportet||supported
 suppored||supported
 supporing||supporting
@@ -1597,6 +1619,7 @@ transormed||transformed
 trasfer||transfer
 trasmission||transmission
 treshold||threshold
+trigged||triggered
 triggerd||triggered
 trigerred||triggered
 trigerring||triggering
-- 
2.39.2


