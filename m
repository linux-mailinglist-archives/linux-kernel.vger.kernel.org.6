Return-Path: <linux-kernel+bounces-238026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE45924256
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 17:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E8AF1F2503C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8197E1BC07A;
	Tue,  2 Jul 2024 15:28:07 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108C41BA89E;
	Tue,  2 Jul 2024 15:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719934087; cv=none; b=HXbDZHZmZgtr7OsCpD6Wax3mf0Vf2jfYpSDKG/beihgNQb43fx9k99y8sJagYBw1vtFRb/Mzs7d3Nq89hj28AiulWYznHFWW1MNzU72Asu8Kg9qtI6nxJPInI8+zCuBxKacU0bp2+1jNMX3iM2aPxUeAzviIX1iSFWd1zZTPaTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719934087; c=relaxed/simple;
	bh=pDeHVRV9Y0UmQbfvePSna4sC2ujf3+Vy3QX1aGdopPw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VE7RGtYtuv/nmsl4F336BJqlZyGdi3tU4RW+EvmlG+FTqW7lZSoWuCr0/3j9RA6tkFnDgxRLeTj65GjuTjY8YJHEUWK5synIsbpHG0unGCC8ydqp1TUukEA2kfdkjz0VwlewXdk5HvQxb9mtd1TNWt9tP07gKa2pa5UbqT/Ne3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 036FDC116B1;
	Tue,  2 Jul 2024 15:28:03 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V2 0/2] LoongArch: Add Loongson-3 CPUFreq driver support
Date: Tue,  2 Jul 2024 23:27:35 +0800
Message-ID: <20240702152737.1184244-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series add architectural preparation and CPUFreq driver for
Loongson-3 (based on LoongArch).

Some of LoongArch processors support DVFS, their IOCSR.FEATURES has
IOCSRF_FREQSCALE set. And they has a micro-core in the package called
SMC (System Management Controller) to scale frequency, voltage, etc.

V1 -> V2:
1, Use module_platform_driver() instead of module_init()/module_exit();
2, Move the lock protection into do_service_request();
3, Add light-weight hotplug support with help of online()/offline() callbacks;
4, Simplify loongson3_freq_data by removing cur_cpu_freq;
5, Remove unneeded cpu_online() checking.

Huacai Chen(2):
 LoongArch: Add architectural preparation for CPUFreq.
 cpufreq: Add Loongson-3 CPUFreq driver support.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
2.27.0


