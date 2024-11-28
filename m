Return-Path: <linux-kernel+bounces-424888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C353A9DBAD7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 16:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26417B241D8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92691BD9C1;
	Thu, 28 Nov 2024 15:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YuOo5FSw"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581851BD9F4;
	Thu, 28 Nov 2024 15:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732808812; cv=none; b=uBru9DIR4o3F+f26oqyRgqYWAhKqdUEh/z67PVjzIz5Rj9w8JLKrrWrG0IwWqqCQAqyHCXjjmdYwCrwlWGKMfnqEpSmBeGmYpJSAb5ArRfqr8OnfB/xs/0orME07jnGWmxibnuHykm51ZdrfYW8h2mqujFcfYPap5ZhlM9qrQlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732808812; c=relaxed/simple;
	bh=gO+1X2k+laXeuczPhixpw6KqT4OtV7bvBEPrPNDyaPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kRqFSJz5G6KIWnhl8AGdYjGXUU7LrsYOjb60xFunf0Q5hWUrPK+8sa8QiH54KVZa6rFs8trQvzh4Nd74EpGFmDypDTVcgoBiLato8wio63a8PSC+U3QSavuwgBCxc6f+jjoD6s8jAOkqGjLFYYb+zESnblZd6oP51PBiORKpxnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YuOo5FSw; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa535eed875so134750366b.3;
        Thu, 28 Nov 2024 07:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732808809; x=1733413609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gySyX3xb7lz2NAGHoDoeS8CCZN0aAJNXyyTJzm5Bn3o=;
        b=YuOo5FSwovRP2rKrgDbq7Pot0QQHFfllfAd/JqMi/LIYg5kvshMEhgLlH9bVlB6FPW
         ufaEk4HqRjhe00HuprmS0fAy5SJH5eKEoeNSE0YLSf8BDz+Jr8iqsmoRO/SnpfMPrski
         j5IzKSAYqSlOG2EbQS5oVo/RAfizaJd+bHQm+bONZkXeK98HFGRWtazwoAVnqzb2Xmw+
         q+omshMurSdxZKCRTujIoOk1yOeBtmEmP5keLYWeput3gqe2MoELpKeJzwjf6qcnUh6e
         hIBoWqkpU3SwrKuVA7NPkO7MxP/J4v7mfsYfGBPxcn61+PzpjrlrZLiblcN10VJV/BX7
         kPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732808809; x=1733413609;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gySyX3xb7lz2NAGHoDoeS8CCZN0aAJNXyyTJzm5Bn3o=;
        b=WdIhdMS+jtUliwy8IfA4nmrJP3asA5XO3dcCBCScWJLe7hdwbQj07jP9Y8g1wTAr/g
         mhoZ6de4sQE62GFbW9/b7tFB4IMfOfUZIA2MKmdBJU5ChNhc/n9U9H9g651/ekF0LxAQ
         ZNWrIqwcd8+ViW6RroMaMAilK9oaPwGS/DXfZFPEwneIIf/onoroywduePHRtnmSh+Yq
         5ze4V9H758uE9e/9TtYHhMTVI/dAuSa3CE95kMnBdLgB8p2HqEkilbxMQUWniWJAC9Rq
         qbHbnlvc6FexZihstKqowfQMZxaeJ/dz0SJnmJx1Le4jzcpmpucylXd1qjXb9Ka2nYJR
         fRog==
X-Forwarded-Encrypted: i=1; AJvYcCWSVjHjJNKbiO/+ePvMF0e3UekhzUHl1IC7V8cVW9e0jIzEN6AnuFGI0w6wz3VEOJYsuIheQJVwhvwq@vger.kernel.org, AJvYcCWnjV9k3dk8yr/iGNUbYddNUi9nPiQXTEz4oX380FrQdyaLZGQEQ2xI21AF9zUTdqOAcyWI3yh/iTILwi4S@vger.kernel.org
X-Gm-Message-State: AOJu0YzhefRdhLr4jGwHeCDuf3zvBAn5nAouQW0OdVFuczgJdVdK0D5m
	j7a4JFvyus+5NAgXraSvUmmOC9B1P34z46uIvbi0d4xjykCpif9jioiDnB+T
X-Gm-Gg: ASbGncuDDR39f68IxRJWhD7HNEKBeamAaundNuM2vuN0kErdPpQkiEfPb6zkRd+sKMa
	6qOK4JQrHafYC28SPQ6s2utdCSd+T2s3M1DuDUU3hlZ622Xv0NSY3lZeBO9rPCfVcZo154QyiW/
	sbpUumOAbj2wNBJslywBhwB79VUL7fYKM9U8/SgY3zkf9PG5kIH9itYVjpWJkTfXxM49Rv2SJUX
	EzXIalU2zyXNhjAUvELuhCmmJij5wNDrmDdt4RMQdpxSAQ2PjZ1f2okC35y+UYURo6t5jZvYE4A
	m1vzSbf0Orx4a42SyNGdWIEOoNWSTldCv9qqjZA=
X-Google-Smtp-Source: AGHT+IGbYgbDaKacn6oy8Mz56jrQShpX/zaBxCgc1Y2PUaxFezDPqSG9ETGSHYc4z4+CFFxCm/VZhQ==
X-Received: by 2002:a17:906:3109:b0:aa1:e60e:6fe7 with SMTP id a640c23a62f3a-aa580ef31e1mr547320866b.11.1732808808516;
        Thu, 28 Nov 2024 07:46:48 -0800 (PST)
Received: from localhost.localdomain (229.140-242-81.adsl-dyn.isp.belgacom.be. [81.242.140.229])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa59991f215sm78390266b.158.2024.11.28.07.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 07:46:48 -0800 (PST)
From: Philippe Simons <simons.philippe@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner sunXi SoC support),
	linux-sunxi@lists.linux.dev (open list:ARM/Allwinner sunXi SoC support),
	linux-kernel@vger.kernel.org (open list)
Cc: Philippe Simons <simons.philippe@gmail.com>
Subject: [PATCH] Update H700 opp values
Date: Thu, 28 Nov 2024 16:45:56 +0100
Message-ID: <20241128154556.2743839-1-simons.philippe@gmail.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

My H700 (RG35XX-H, RG40XX-V and RG CubeXX) devices are very unstable,
especially with some OPPs.
Crashes were fairly easy to reproduce with any dynamic cpufreq governor
and some load on CPU, usually in matter of minutes.
Crashes manifested randomly as simply hanging or various kernel oops

Manufacturer (Anbernic) is using more conservative mircrovolt values,
so let's use these.
While using performance gov seems stables at 1.5Ghz, it still crashes
using a dynamic gov (even with Andre reparenting patch), so let's drop
it for now, like manufacturer does.

Signed-off-by: Philippe Simons <simons.philippe@gmail.com
---
 .../dts/allwinner/sun50i-h616-cpu-opp.dtsi    | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-cpu-opp.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616-cpu-opp.dtsi
index dd10aaf47..ac13fe169 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h616-cpu-opp.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-cpu-opp.dtsi
@@ -50,24 +50,21 @@ opp-1008000000 {
 			opp-microvolt-speed2 = <950000>;
 			opp-microvolt-speed3 = <950000>;
 			opp-microvolt-speed4 = <1020000>;
-			opp-microvolt-speed5 = <900000>;
+			opp-microvolt-speed5 = <950000>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
 			opp-supported-hw = <0x3f>;
 		};
 
 		opp-1032000000 {
 			opp-hz = /bits/ 64 <1032000000>;
-			opp-microvolt = <900000>;
+			opp-microvolt = <950000>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
 			opp-supported-hw = <0x20>;
 		};
 
 		opp-1104000000 {
 			opp-hz = /bits/ 64 <1104000000>;
-			opp-microvolt-speed0 = <1000000>;
-			opp-microvolt-speed2 = <1000000>;
-			opp-microvolt-speed3 = <1000000>;
-			opp-microvolt-speed5 = <950000>;
+			opp-microvolt = <1000000>;			
 			clock-latency-ns = <244144>; /* 8 32k periods */
 			opp-supported-hw = <0x2d>;
 		};
@@ -79,7 +76,7 @@ opp-1200000000 {
 			opp-microvolt-speed2 = <1050000>;
 			opp-microvolt-speed3 = <1050000>;
 			opp-microvolt-speed4 = <1100000>;
-			opp-microvolt-speed5 = <1020000>;
+			opp-microvolt-speed5 = <1050000>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
 			opp-supported-hw = <0x3f>;
 		};
@@ -93,7 +90,10 @@ opp-1320000000 {
 
 		opp-1416000000 {
 			opp-hz = /bits/ 64 <1416000000>;
-			opp-microvolt = <1100000>;
+			opp-microvolt-speed0 = <1100000>;
+			opp-microvolt-speed2 = <1100000>;
+			opp-microvolt-speed3 = <1100000>;
+			opp-microvolt-speed5 = <1160000>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
 			opp-supported-hw = <0x2d>;
 		};
@@ -102,9 +102,8 @@ opp-1512000000 {
 			opp-hz = /bits/ 64 <1512000000>;
 			opp-microvolt-speed1 = <1100000>;
 			opp-microvolt-speed3 = <1100000>;
-			opp-microvolt-speed5 = <1160000>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
-			opp-supported-hw = <0x2a>;
+			opp-supported-hw = <0x0a>;
 		};
 	};
 };
-- 
2.46.1


