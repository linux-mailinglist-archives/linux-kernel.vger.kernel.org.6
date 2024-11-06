Return-Path: <linux-kernel+bounces-398786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC699BF60E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 20:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05A8BB245F8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EA020A5D7;
	Wed,  6 Nov 2024 19:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aefVvPlb"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9926D20823B;
	Wed,  6 Nov 2024 19:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730919965; cv=none; b=epfNIueQ3/X5Go6B6hbxN00KA7wfUl3UEmi76j5brOu4dnev4jpLYqDSMVgEd7dqXTkR78W6A02Xy3ZyP/a7GUwxCoBp7Lz5UEgyvG9KjIQeVMgeALxLAJPq0bCJjFFCy+VrJmUBIqmGOhH4rVuRCj73KZzqAOne4UAYfeaAzHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730919965; c=relaxed/simple;
	bh=R6KQynz/e0fXEKEnL4JMvH5TU3YB7IKAqun5AWRELE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GVzg+5g0JwnwGAX3hD2u852Ft66yYM0jpwObmN12icD4giAdHmZfriAPR0YSGLzG3v4TGDJe/CvhF5/adijZjh1C8veI1wL2jBM3qitnRJtaT1LKIEzwmtuqCBlzdWFuzQ6a9vjq5CpXtPDmPy8dE9RIS9EfetdqWkkd7c/OqgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aefVvPlb; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9e8522c10bso25880366b.1;
        Wed, 06 Nov 2024 11:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730919962; x=1731524762; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IgGvRXAJpj726ODsHfIG2S7bKnZ+OBr0kVdo6l+s/Hc=;
        b=aefVvPlbiPf2V/WbXA/2nS5m/BTk8FdDrSYaSBYQGqXTfjGQJcO+vDOAuDVO+Ela/v
         6oH2k4XvapR2tgwAI2Zc7TzXZNWdj/Kuz16kAuqkMIKUXEPRlgt08+RakCXiioSpZoG9
         GHDU4Z4630dSPIyTPS+ab797tF0WMXhROgzu9w6t2TAlJQ0Ur79hMgGn1HK3utXe5q92
         f8q9Szv03Md0Nlvxh8gHknY/+0gJzdS+Mnl0wInmuIfcgi1jLMvxglvD+lU5rCQH3WqK
         j2fo9sTeN0KXOyMchmhGc/tKPFw9vKyBOT0Y+H0bFQVFGDlUMMRhpj2rhSCPc5X1RHKT
         D9ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730919962; x=1731524762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IgGvRXAJpj726ODsHfIG2S7bKnZ+OBr0kVdo6l+s/Hc=;
        b=FLQBj1PZWl0ckC6QQge6cijW9O7JgHx2TIajB7x15JtTnk8aGu+4CpgQRGrY36MF/a
         ZLxZ9SqUUuHvkftKvqT9UK1DPuh6HATHGDAww3bBh3VJb7moOClmtg2bMoKtrn5KXkOv
         LhL5luo+bWX+wl4BzPPe6TRGlHXbmd5hm3H5OHsjp8wcwwXs60G5qG+R4pxatP9XE2F+
         +d/OEdm+8cG+oxsQfX4Ur0L9idx5OyB7rDgGpDafwXF9R5o1j2EtArmpaNYLmGHuA32s
         dN5MHje3ZCEO/DTzxrSuHEUjCc/fs3YHC38VuH3eEQ4vn4+RrzWCWYG/8JLl8vvSfFa1
         Qj5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWL/DMXuwUO36Ox41w1enXCcI2H9FyKjjE47PRUIDc3bkbYX8B0YD/gc7XljwqZaASWLA8M1X1XtnX0cnk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8hB8uLtjlwumqI7FYwQz+rE+L1NiktPdyW8aG023NDYlaRD9z
	ywrufoNMi5JEF3im+K94dvQb1dB3kesVGKQH+iN+CR9cWkAMgaN0
X-Google-Smtp-Source: AGHT+IHJzr9hbdLpV0PDZSH3MlBedQIIjCpH5cN/ogIiMjoiS6oKXKwoy7Qju43dBWT7plFuZ3cNUw==
X-Received: by 2002:a17:906:d542:b0:a9e:b08f:867e with SMTP id a640c23a62f3a-a9ed4cb4df9mr40078066b.16.1730919961922;
        Wed, 06 Nov 2024 11:06:01 -0800 (PST)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb16d9774sm324040166b.65.2024.11.06.11.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 11:06:01 -0800 (PST)
Date: Wed, 6 Nov 2024 20:05:59 +0100
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] arm64: dts: sprd: sc9863a: reorder clocks,
 clock-names per bindings
Message-ID: <d235438fbbd53c28b63cada2cf7e1234c120355e.1730918663.git.stano.jakubek@gmail.com>
References: <cover.1730918663.git.stano.jakubek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730918663.git.stano.jakubek@gmail.com>

DT bindings expect the SC9863A clock-controller clocks/clock-names to be
in a specific order, reorder them.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
Changes in V2:
- new patch

 arch/arm64/boot/dts/sprd/sc9863a.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/sprd/sc9863a.dtsi b/arch/arm64/boot/dts/sprd/sc9863a.dtsi
index 31172ac44adc..e97000e560e7 100644
--- a/arch/arm64/boot/dts/sprd/sc9863a.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc9863a.dtsi
@@ -163,18 +163,18 @@ gic: interrupt-controller@14000000 {
 		ap_clk: clock-controller@21500000 {
 			compatible = "sprd,sc9863a-ap-clk";
 			reg = <0 0x21500000 0 0x1000>;
-			clocks = <&ext_32k>, <&ext_26m>;
-			clock-names = "ext-32k", "ext-26m";
+			clocks = <&ext_26m>, <&ext_32k>;
+			clock-names = "ext-26m", "ext-32k";
 			#clock-cells = <1>;
 		};
 
 		aon_clk: clock-controller@402d0000 {
 			compatible = "sprd,sc9863a-aon-clk";
 			reg = <0 0x402d0000 0 0x1000>;
-			clocks = <&ext_26m>, <&rco_100m>,
-				 <&ext_32k>, <&ext_4m>;
-			clock-names = "ext-26m", "rco-100m",
-				      "ext-32k", "ext-4m";
+			clocks = <&ext_26m>, <&ext_32k>,
+				 <&ext_4m>, <&rco_100m>;
+			clock-names = "ext-26m", "ext-32k",
+				      "ext-4m", "rco-100m";
 			#clock-cells = <1>;
 		};
 
-- 
2.43.0


