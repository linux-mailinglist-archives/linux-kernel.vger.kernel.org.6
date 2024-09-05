Return-Path: <linux-kernel+bounces-317888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D5096E514
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 23:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E020F1C22F75
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 21:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836391B3F33;
	Thu,  5 Sep 2024 21:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dRnkrqkC"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5508D1A4E6F
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 21:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725571664; cv=none; b=mtnu/gu3moufjgcr1qrn207sSwgo32b24hCb4tvLCbtbgvkhZdpTZuWRr7OCL9QPATjgDZwvXZPr2NNNHxdVfO48gsVFSSG53KjODC/4B8zqAMFwU/619/dr+dpL/sP+9yCNFRwz3RT5ZPJsBrKjD1/7edoufAjeo2S0evj5Vqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725571664; c=relaxed/simple;
	bh=BoFjoA7btKYN/a2xiwdwb3YHXN3Ss5zEpprRmZbL6zM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bt/Dj/NlBznHautD75vZTYC285eqn35qVbVzSmyP3AU+GyuJn5s2/mC/1jNK4hejrrzhSFnsk8gblOMI7DmxD5/xoFV6nU3GggZMVxfi5RR/zzPRPmFoWW7MK9Dht271vsTmdXN/haASKUMbp33+MPsxyFOARaH5XUwjYD57M9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dRnkrqkC; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id CBF0120B7428;
	Thu,  5 Sep 2024 14:27:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CBF0120B7428
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1725571662;
	bh=DvQEFrGjIlMyGz1xCchft1ZSDdtY/pvbsqDQhx7ilB4=;
	h=From:To:Cc:Subject:Date:From;
	b=dRnkrqkCE4URrUIHKqUw/tT6St5Y6bmCNppPtretUw0Kt9mifwGdt6UNjtM3bspBV
	 fiDdII7/ZHIJ1N2XD4YvbNpJJou5+AGN3fWbVWO7PUHlda8IlZ7LEeOE0MVAkarijX
	 xVy237odXKXbY+Wk90jRze9vPxRf6FeAeS2Pb0qc=
From: Roman Kisel <romank@linux.microsoft.com>
To: oleg@redhat.com,
	linux-kernel@vger.kernel.org
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	ssengar@microsoft.com,
	sunilmut@microsoft.com,
	vdso@hexbites.dev
Subject: [PATCH 0/1] Get tracer PID without reliance on the proc FS
Date: Thu,  5 Sep 2024 14:27:40 -0700
Message-Id: <20240905212741.143626-1-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For debugging, it might be useful to run the debug trap
instruction to break into the debugger. To detect the debugger
presence, the kernel provides the `/proc/self/status` pseudo-file
that needs to be searched for the "TracerPid:" string.

Provide a prctl command that returns the PID of the tracer if any.
That allows for much simpler logic in the user land, and makes it
possible to detect tracer presence even if PROC_FS is not enabled.

As an example where this might be useful, one might refer to
the standard C++ and Rust libraries. See these links for the details:

* https://en.cppreference.com/w/cpp/utility/breakpoint_if_debugging
* https://lists.llvm.org/pipermail/libcxx-commits/2024-May/083574.html
* https://patchwork-proxy.ozlabs.org/project/gcc/patch/20240601102446.878286-1-jwakely@redhat.com/#3321542
* https://www.open-std.org/jtc1/sc22/wg21/docs/papers/2022/p2546r0.html
* https://github.com/rust-lang/rust/pull/129019

Roman Kisel (1):
  ptrace: Get tracer PID without reliance on the proc FS

 include/uapi/linux/ptrace.h |  1 +
 kernel/ptrace.c             | 11 ++++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)


base-commit: ad618736883b8970f66af799e34007475fe33a68
-- 
2.34.1


