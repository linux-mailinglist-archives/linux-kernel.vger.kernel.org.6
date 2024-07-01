Return-Path: <linux-kernel+bounces-235802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB6091D9D3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD5BD283413
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E01D78C67;
	Mon,  1 Jul 2024 08:20:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD5A7E76F
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 08:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719822055; cv=none; b=KzmzO7FsKjUv5RBT4Ik5LzJ07Ecx05X42x6yZRHIrF5DkOd8tMJrpohmYKb2Bi2hZHKYu7xgP+Ul9ritd6LIbizmC6b4PRF3yKVTSK+kyOei3Eu+iApoG/OLsjf0Ox3qB2UuoI9xqHrQx8nsGSoEowy6yqWzASgFB05+Hb5J/gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719822055; c=relaxed/simple;
	bh=O94vOjp3+ujD68xcP3wUh31tK/G7hu4FFfyJ48XoHN8=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=HZ8SfSnudtHkMjVWPPsn0P5XjTO8b8AHEkpF8Mjnwq20qFLZG+N/AE9BC6uwegKLfcsejVSbRCMmkdnte4fHtlGUUSgM85NpZ03g/TtJxjABEvs3qOj/PlmglJ2CgZTtXH8Pk4YFdQD/uBlBcE9bUSexLcuokeL8qFn8cybCyqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACF62339;
	Mon,  1 Jul 2024 01:21:17 -0700 (PDT)
Received: from [10.1.27.16] (e127648.arm.com [10.1.27.16])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E21FF3F766;
	Mon,  1 Jul 2024 01:20:51 -0700 (PDT)
Message-ID: <9469d35a-f641-45c9-a6b0-6e43addb7646@arm.com>
Date: Mon, 1 Jul 2024 09:20:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: yury.norov@gmail.com, linux@rasmusvillemoes.dk,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH] cpumask: Correct cpumask_weight_andnot() doc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The documentation of cpumask_weight_andnot() was the same as
cpumask_weight_and() which is obviously wrong. Document the
actual behavior.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 include/linux/cpumask.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 23686bed441d..325dd80bbc76 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -788,10 +788,10 @@ static inline unsigned int cpumask_weight_and(const struct cpumask *srcp1,
 
 /**
  * cpumask_weight_andnot - Count of bits in (*srcp1 & ~*srcp2)
- * @srcp1: the cpumask to count bits (< nr_cpu_ids) in.
- * @srcp2: the cpumask to count bits (< nr_cpu_ids) in.
+ * @srcp1: the cpumask to count set bits (< nr_cpu_ids) in.
+ * @srcp2: the cpumask to count clear bits (< nr_cpu_ids) in.
  *
- * Return: count of bits set in both *srcp1 and *srcp2
+ * Return: count of bits set in *srcp1 and clear in *srcp2
  */
 static inline unsigned int cpumask_weight_andnot(const struct cpumask *srcp1,
 						const struct cpumask *srcp2)
-- 
2.34.1

