Return-Path: <linux-kernel+bounces-359399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE38998C30
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 17:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A347FB2C2E2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512831D432A;
	Thu, 10 Oct 2024 15:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUddM4OS"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3516D1CF2A9;
	Thu, 10 Oct 2024 15:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728572684; cv=none; b=irDQUroJXuk+nbYP108iYttaygF04aluqqutxWBvEpE9tjMBi9x4HFrpA5FrelYazxF3DavuZkzRMYrQhpq1q3s5cyh0KbsGR0vRdqc0t4mtFt/UVkvbNo0KbND8s/Ik95FSM+QUDVW4oNnii+RTQvHTACEKmK18bW9yHXFySZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728572684; c=relaxed/simple;
	bh=/9fet0mV81IMt6TUgVnymNSZH6mUpPem0YYVQKdBYOE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ao8DzzT2ARgnBElWAkKz60EdefYM0N/fBa1CGnOCrIaJYRtywbEyHk/yLYzB5Y5HvDHQCL3BQa9F16Svqq3N7UEcO65t19GnGJCJYum6+EvS969MCqAxAV50m5SSLrsndIX9WcQmA+x2iCt3CoH1YpPwBy1wqEUkrbpiAI9F7mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUddM4OS; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7afcd322cabso82457885a.1;
        Thu, 10 Oct 2024 08:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728572682; x=1729177482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VDBs9g7Exo9jbwU1s45HbWQ5xfBXJX4cZMECKhlIRjk=;
        b=TUddM4OSTCkr2FYSoY+sKA39KwrWQmlLOueP9OPz5vlbRcaJlYilPyAZxkkp/PJAJG
         6QCtFxgB1FGe5Z/e/fM9mu79vW4dr+YGHXIyCKrrxIeYmjlalNlMjfvo2obI1xyPKuO2
         XAPJThv8BUnPBhD2NzAD0CCfRcSI24tieNBWNuoll+Bm8yNJr6ZBxOALjYnA82xxEgqM
         F0GTv3JD3qm4wWBHN1LRbrk59TwRIKnXMvEwlVWGAbEz8j/wIXGVZosuVLvC/ZwsmjdT
         kiNEIruRm45PiwgWRmdxQbWZM9lBym+No8ND4mICMakrfI/C67hpSQjWWEoZ27xxan21
         sVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728572682; x=1729177482;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VDBs9g7Exo9jbwU1s45HbWQ5xfBXJX4cZMECKhlIRjk=;
        b=Y6oztWob4UX+MWq/uWjivceHwjNxgBWvS39R66ci+5IccKoSqxTMq5369uZZ9cj3Rh
         VcAX/f/slSoMGx4rvtZjML2tbQKeCd+jxcYl4NpQWLpq/LEHqiUF9CoK2t8pBncaJNzr
         MGvxtsjmsd/7rBq56f8qyZtnVRWAFq7KP4OeesdSt7pP8hc6v9grcVmzH9KMAdcBzMK8
         qRekGk7hh56v4LKLQfe27jswM3iNr+KlvIANqStmd7fCEYdztXBcFGyWJXjwjURzdsZI
         UuoFDKZ/ZnhSKFH84ehallscj3n50Saa0YrnliLiabJBjbgo/mz4/JcP1MlfMa6k/vI6
         +Onw==
X-Forwarded-Encrypted: i=1; AJvYcCU9ELzvGekOlKorYU4u25kpFxU/Z8rsbBq6kFOi4U9JqzTifGBHwqSW4uVgVZhwoCE+BNng9xoDGX4JaP7d@vger.kernel.org, AJvYcCXSxpdN9EPRGN/PxeCYCwdwv3q+1kbqImwoRoq8yg0lvp3gAJ0c7uW+3tQlWucq/j8OmU1s62I6mtSW@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc7lP4JQNHdsZVx2uT/bmnz4BwnRjFMcCGlQk78XYr1zVcQZEH
	u3I/ZkKoX5/ryNniRwCoeB4CVjSoCpkFz0/pzBnq5TvhPa7qELVW
X-Google-Smtp-Source: AGHT+IFWoWeleiFs45265SL2LaB5CWkvksgRRig/bDFYcewRmkluWXBw7NA7LIQxRS6uimBroB7yOg==
X-Received: by 2002:a05:620a:25cd:b0:7ac:e832:905e with SMTP id af79cd13be357-7b0874dacdemr1115471785a.63.1728572681955;
        Thu, 10 Oct 2024 08:04:41 -0700 (PDT)
Received: from localhost.localdomain (weaver-lab.eece.maine.edu. [130.111.218.24])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b11497d7a4sm52529885a.118.2024.10.10.08.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 08:04:41 -0700 (PDT)
From: Willow Cunningham <willow.e.cunningham@gmail.com>
X-Google-Original-From: Willow Cunningham <willow.e.cunningham@maine.edu>
To: 
Cc: willow.e.cunningham@maine.edu,
	Willow Cunningham <willow.e.cunningham@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Andrea della Porta <andrea.porta@suse.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: broadcom: Fix L2 linesize for Raspberry Pi 5
Date: Thu, 10 Oct 2024 11:04:07 -0400
Message-Id: <20241010150409.262087-1-willow.e.cunningham@maine.edu>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willow Cunningham <willow.e.cunningham@gmail.com>

Fixes: faa3381267d0 ("arm64: dts: broadcom: Add minimal support for
Raspberry Pi 5")

Set the cache-line-size parameter of the L2 cache for each core to the
correct value of 64 bytes.

Previously, the L2 cache line size was incorrectly set to 128 bytes
for the Broadcom BCM2712. This causes validation tests for the
Performance Application Programming Interface (PAPI) tool to fail as
they depend on sysfs accurately reporting cache line sizes.

The correct value of 64 bytes is stated in the official documentation of
the ARM Cortex A-72, which is linked in the comments of
arm64/boot/dts/broadcom/bcm2712.dtsi as the source for cache-line-size.

Signed-off-by: Willow Cunningham <willow.e.cunningham@maine.edu>
---
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
index 6e5a984c1d4e..26a29e5e5078 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
@@ -67,7 +67,7 @@ cpu0: cpu@0 {
 			l2_cache_l0: l2-cache-l0 {
 				compatible = "cache";
 				cache-size = <0x80000>;
-				cache-line-size = <128>;
+				cache-line-size = <64>;
 				cache-sets = <1024>; //512KiB(size)/64(line-size)=8192ways/8-way set
 				cache-level = <2>;
 				cache-unified;
@@ -91,7 +91,7 @@ cpu1: cpu@1 {
 			l2_cache_l1: l2-cache-l1 {
 				compatible = "cache";
 				cache-size = <0x80000>;
-				cache-line-size = <128>;
+				cache-line-size = <64>;
 				cache-sets = <1024>; //512KiB(size)/64(line-size)=8192ways/8-way set
 				cache-level = <2>;
 				cache-unified;
@@ -115,7 +115,7 @@ cpu2: cpu@2 {
 			l2_cache_l2: l2-cache-l2 {
 				compatible = "cache";
 				cache-size = <0x80000>;
-				cache-line-size = <128>;
+				cache-line-size = <64>;
 				cache-sets = <1024>; //512KiB(size)/64(line-size)=8192ways/8-way set
 				cache-level = <2>;
 				cache-unified;
@@ -139,7 +139,7 @@ cpu3: cpu@3 {
 			l2_cache_l3: l2-cache-l3 {
 				compatible = "cache";
 				cache-size = <0x80000>;
-				cache-line-size = <128>;
+				cache-line-size = <64>;
 				cache-sets = <1024>; //512KiB(size)/64(line-size)=8192ways/8-way set
 				cache-level = <2>;
 				cache-unified;
-- 
2.39.2


