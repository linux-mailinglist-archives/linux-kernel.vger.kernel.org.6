Return-Path: <linux-kernel+bounces-208172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2E59021DC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 14:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA6E228334D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 12:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0EF80617;
	Mon, 10 Jun 2024 12:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yT490YFF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I1gphHWH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A2D7FBDF
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 12:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718023598; cv=none; b=dWkr91ahKzGp82vB230MeboXuPJCPCo8069HuUA2wiyWNupvU155RIXzL2ggzgIbVg+eW199LY5ZohgYSacriWdonE1VxEO1BqBxQbJMc11VRPIRdpgw0ZlMcHByIfw57yDkynZJVcYPf0naKA5ArbsnJU9OEiQEu+seM6X/W+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718023598; c=relaxed/simple;
	bh=oCEqJwcxMYboMVgrrm6y7VEn7VWx+xeGRNPCQEOcPxs=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=riXsu6dU+7InbC/Ymip1W9IRri2kRcSm9gRYqzYrxrKIKRLapSgAx/zoTxvDWIn+QeO4ntLW+8kO93P3+YloCFQrQ2AffttHN/Dja5clBmbfewGsDOl1bExavN10i6HwUcrib2HcBUC4enFbIsxZiYcXzgb/IGhkKv9yRQFj4jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yT490YFF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I1gphHWH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240610124406.359476013@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718023595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=1aKSWv3sviyM2cko0BTe9cpwsTAoHAr5O414DpYJPMk=;
	b=yT490YFF6PPEGMHbNULktS2FmI18dVp7vUQgcqkZk9Ihkl31ng3C5NwZ75+shwEYv1cbyG
	0FcCeKnUzR5UQWA9BgMs3OZDjskAulz3rZGmXDKU3jIKz0hZnmsdHBN4n7eV/SZCQVIHUy
	8X5V+jgX3A/cWUsB+jUdCXZFlB7DnqII4yn6ehgGnuqC2r1tH22YYzPOl9ZTWa5m/ZJKg2
	cP/o6WQ4Dxm/tiIbTpa3N0cQDH0pYplra7xYB5Asmw/ZiE5WlLvy/23SWJFWgRmLcIZs6p
	Cuq909lmxmAogdb7PaSYZhfDB5T8pQ1AUshvoAv17tHBHioCHEjbfjMRrxORKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718023595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=1aKSWv3sviyM2cko0BTe9cpwsTAoHAr5O414DpYJPMk=;
	b=I1gphHWH0KTjYMrhYZnT9EZzhHiGS8b2a78TEoXv0YGJu2WmY7btuax/AD0tza2xFY1EOP
	j4KCEZePe3SqtkCQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Sam Sun <samsun1006219@gmail.com>,
 x86@kernel.org,
 syzkaller-bugs@googlegroups.com,
 xrivendell7@gmail.com
Subject: [patch 1/4] perf/x86: Serialize set_attr_rdpmc()
References: <87bk49xf15.ffs@tglx>
 <20240610124258.109097511@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Jun 2024 14:46:35 +0200 (CEST)

Yue and Xingwei reported a jump label failure. It's caused by the lack of
serialization in set_attr_rdpmc():

CPU0                           CPU1

Assume: x86_pmu.attr_rdpmc == 0

if (val != x86_pmu.attr_rdpmc) {
  if (val == 0)
    ...
  else if (x86_pmu.attr_rdpmc == 0)
    static_branch_dec(&rdpmc_never_available_key);

				if (val != x86_pmu.attr_rdpmc) {
				   if (val == 0)
				      ...
				   else if (x86_pmu.attr_rdpmc == 0)
     FAIL, due to imbalance --->      static_branch_dec(&rdpmc_never_available_key);

The reported BUG() is a consequence of the above and of another bug in the
jump label core code. The core code needs a separate fix, but that cannot
prevent the imbalance problem caused by set_attr_rdpmc().

Prevent this by serializing set_attr_rdpmc() locally.

Fixes: a66734297f78 ("perf/x86: Add /sys/devices/cpu/rdpmc=2 to allow rdpmc for all tasks")
Reported-by: Yue Sun <samsun1006219@gmail.com>
Reported-by: Xingwei Lee <xrivendell7@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Closes: https://lore.kernel.org/r/CAEkJfYNzfW1vG=ZTMdz_Weoo=RXY1NDunbxnDaLyj8R4kEoE_w@mail.gmail.com
---
 arch/x86/events/core.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2547,6 +2547,7 @@ static ssize_t set_attr_rdpmc(struct dev
 			      struct device_attribute *attr,
 			      const char *buf, size_t count)
 {
+	static DEFINE_MUTEX(rdpmc_mutex);
 	unsigned long val;
 	ssize_t ret;
 
@@ -2560,6 +2561,8 @@ static ssize_t set_attr_rdpmc(struct dev
 	if (x86_pmu.attr_rdpmc_broken)
 		return -ENOTSUPP;
 
+	guard(mutex)(&rdpmc_mutex);
+
 	if (val != x86_pmu.attr_rdpmc) {
 		/*
 		 * Changing into or out of never available or always available,


