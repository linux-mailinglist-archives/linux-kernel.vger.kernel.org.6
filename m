Return-Path: <linux-kernel+bounces-382699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC7D9B1258
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 00:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28F971C21AA9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 22:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D32320BB42;
	Fri, 25 Oct 2024 22:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDmxDR8s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF97E217F53
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 22:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729894276; cv=none; b=fdYhPKv+iNOZdqb7xddr3svQr7jjGOSzv6Knn7mKwFMRlW3IolWL7CU/iw7R26IEscI6UXD9k+NdlqdSMBHZ5yo5VE4VeZXNqH6MNFD587GxRhvf/witISTYRUHLfIHFwZSw7tv14AyNTg1r+lARrt43JsYANRlErA1Z+hIgziQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729894276; c=relaxed/simple;
	bh=uT+1EB1n0yJWltMD5gkZ7m9cFroC05EeN9hrvKQRecI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=snAm2K6MiOgVeh6sy2ka64cj2zsb80wooHtbK8ExtOk548RQo/pyJipE0yDmnjZdzBdOs1EDzDwSw0/tsRAjEqAmTFl0XswJ3nwodLrVBqccEfuOaa5PwNkO7EsslMrlkr41xlFWRPGs617SIET+VkFy0Jz92l3XV/PtzMTLkjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDmxDR8s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61991C4CEC3;
	Fri, 25 Oct 2024 22:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729894275;
	bh=uT+1EB1n0yJWltMD5gkZ7m9cFroC05EeN9hrvKQRecI=;
	h=Date:From:To:Cc:Subject:From;
	b=jDmxDR8s3QOQA+sduyqNkae9X/AJ4I2IY7szMpvqAtiGCq/qESIHfl3hhESxAo5Ga
	 vOYD0sFcOM4r50utZaYho0Vzwihyrb+xZjBrhm0Yvv9P7QrFx56r3iFlf0hLcEIaYE
	 tJLqcY2+0vlr8zgsR0w5vaPhWkFfVFWYfwWvWvlZFNfLid7KTA9zggmXi2wObSJFRf
	 xOnmesB4mMemp+AALLkrCm+oMjMeW9CJA+dSi6AHcyTRsGm+hn/E9lkFvc98tX11RA
	 HGrOUeKFjm43PVLitihLkxEEbwRye1AJJmuYTvodc3uVK5yK2XBzaKsmm0ST8MRSpk
	 qa3d0NaGEn45w==
Date: Fri, 25 Oct 2024 12:11:14 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, sched-ext@meta.com
Subject: [PATCH sched_ext/for-6.12-fixes] sched_ext: Make cast_mask() inline
Message-ID: <ZxwXgmKQ2B3OmIea@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

cast_mask() doesn't do any actual work and is defined in a header file.
Force it to be inline. When it is not inlined and the function is not used,
it can cause verificaiton failures like the following:

  # tools/testing/selftests/sched_ext/runner -t minimal
  ===== START =====
  TEST: minimal
  DESCRIPTION: Verify we can load a fully minimal scheduler
  OUTPUT:
  libbpf: prog 'cast_mask': missing BPF prog type, check ELF section name '.text'
  libbpf: prog 'cast_mask': failed to load: -22
  libbpf: failed to load object 'minimal'
  libbpf: failed to load BPF skeleton 'minimal': -22
  ERR: minimal.c:20
  Failed to open and load skel
  not ok 1 minimal #
  =====  END  =====

Signed-off-by: Tejun Heo <tj@kernel.org>
Fixes: a748db0c8c6a ("tools/sched_ext: Receive misc updates from SCX repo")
---
 tools/sched_ext/include/scx/common.bpf.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 27749c51c3ec..248ab790d143 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -320,7 +320,7 @@ u32 bpf_cpumask_weight(const struct cpumask *cpumask) __ksym;
 /*
  * Access a cpumask in read-only mode (typically to check bits).
  */
-const struct cpumask *cast_mask(struct bpf_cpumask *mask)
+static __always_inline const struct cpumask *cast_mask(struct bpf_cpumask *mask)
 {
 	return (const struct cpumask *)mask;
 }

