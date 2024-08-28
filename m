Return-Path: <linux-kernel+bounces-305589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 602689630E2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 21:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A999282439
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 19:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D2B1AAE38;
	Wed, 28 Aug 2024 19:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="vj4C0Hy9"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F83487BE
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 19:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724872964; cv=none; b=OKqCInS8ytQ0yTzELX12cnfhGTT8sCTcvGs55Kn+GthOmfk7jnEs7HPlPdt88cE/VuRtIpwxTsM2OV5iULJeTITGSB64rNUdwhw8ZKEl4rhG7gnGgY+epg5U7EdkPdBkgqsl6JBSVof/MdT1rH5klCmI1GCm4ImFcmWBMmMrrvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724872964; c=relaxed/simple;
	bh=vJzR3WTp9F72bQTzjO1HU6dUUlOXoslEqBXF9zeQz9Q=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=NNjUUkuPVUY7kNeNtjRC1VRnbeFr6PXGpNPHmYEFytFCrwL5nIj1/SbpO7glQDid7XwsHGdl3DkGM7dEl8PI6O7pd7uyA4WMjGb4OnySCwhkon/fpum2O6x39f0iUApccD/MywODYm9JL+zWg6CNqlvbZHLbX/YPt9IlmGtB+tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=vj4C0Hy9; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1724872960;
	bh=vJzR3WTp9F72bQTzjO1HU6dUUlOXoslEqBXF9zeQz9Q=;
	h=Date:From:To:Cc:Subject:From;
	b=vj4C0Hy9e5yo5Y7C57oSSKvmmDU1hX54RVwJ6/l4J9Gb93olmvzQ0RSrDma5ZKGtp
	 VgOnWbxO17aKSjz+/0I9fMEgLlgqLqpjFgCprii/tB24Fodxzlyr8KERMUqMEF0Wkc
	 7uP1HkKug+zM3A/Vwa1G67PBSoaYZo7Qxb6vd2AhUNkCOyJURB83aJKUy+cRgS0zal
	 fqNSwpsua1t2+KWbNaZr8F3ltPgeDlJYGUhEJfJWfi5r6+PATvBL2OM4OHaEZxiXBC
	 xijYe8S1a4DlCHC2oA6waEFkzBnkPD2LDOpVMmQKGgeeskawC7eTxvgf9Ud0Ol4GSx
	 FevDExhM1Sgjw==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4WvDnr5Zckz1JQQ;
	Wed, 28 Aug 2024 15:22:40 -0400 (EDT)
Message-ID: <aeb6373f-9bdb-4ae4-8740-c0dcdd825ea1@efficios.com>
Date: Wed, 28 Aug 2024 15:22:16 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>,
 Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [RELEASE] Userspace RCU 0.14.1 and 0.13.4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

This is a release announcement for the version 0.14.1 and 0.13.4
of the liburcu project.

Included in those releases are bug fixes, new architecture support,
OpenBSD support, and documentation updates.

liburcu is a LGPLv2.1 userspace RCU (read-copy-update) library. This
data synchronization library provides read-side access which scales
linearly with the number of cores. It does so by allowing multiple
copies of a given data structure to live at the same time, and by
monitoring the data structure accesses to detect grace periods after
which memory reclamation is possible.

liburcu-cds provides efficient data structures based on RCU and
lock-free algorithms. Those structures include hash tables, queues,
stacks, and doubly-linked lists.

* New in these releases:

v0.14.1:

2024-08-28 Userspace RCU 0.14.1
         * Fix: missing typename in URCU_FORCE_CAST
         * Allow building with GCC >= 13.3 on RISC-V
         * pointer.h: Fix the rcu_cmpxchg_pointer documentation
         * Adjust shell script to allow Bash in other locations
         * fix: handle EINTR correctly in get_cpu_mask_from_sysfs
         * Relicense src/compat-smp.h to MIT
         * ppc.h: use mftb on ppc
         * Fix: allow clang to build liburcu on RISC-V
         * Fix -Walloc-size
         * urcu/uatomic/riscv: Mark RISC-V as broken
         * Fix: urcu-bp: misaligned reader accesses
         * LoongArch: Document that byte and short atomics are implemented with LL/SC
         * Add LoongArch support
         * tests/regression/rcutorture: Add wait state
         * urcu-wait: Initialize node in URCU_WAIT_NODE_INIT
         * Fix: urcu-wait: add missing futex.h include
         * Adjust shell scripts to allow Bash in other locations
         * Add support for OpenBSD
         * Revert "compiler.h: Introduce caa_unqual_scalar_typeof"
         * rculfhash: Use caa_container_of_check_null in cds_lfht_entry
         * compiler.h: Introduce caa_container_of_check_null
         * compiler.h: Introduce caa_unqual_scalar_typeof
         * Avoid calling caa_container_of on NULL pointer in cds_lfht macros
         * Fix: revise urcu_read_lock_update() comment
         * Fix: uatomic powerpc comment about lwsync
         * fix: aarch64: allow RHEL7 gcc 4.8.5-11
         * fix: warning 'noreturn' function does return on ppc
         * Fix: use __noreturn__ for C11-compatibility

v0.13.4:

2024-08-28 Userspace RCU 0.13.4
         * Allow building with GCC >= 13.3 on RISC-V
         * pointer.h: Fix the rcu_cmpxchg_pointer documentation
         * fix: handle EINTR correctly in get_cpu_mask_from_sysfs
         * Relicense src/compat-smp.h to MIT
         * ppc.h: use mftb on ppc
         * Fix: allow clang to build liburcu on RISC-V
         * Fix -Walloc-size
         * urcu/uatomic/riscv: Mark RISC-V as broken
         * Fix: urcu-bp: misaligned reader accesses
         * tests/regression/rcutorture: Add wait state
         * urcu-wait: Initialize node in URCU_WAIT_NODE_INIT
         * Fix: urcu-wait: add missing futex.h include
         * Adjust shell scripts to allow Bash in other locations
         * Add support for OpenBSD
         * Revert "compiler.h: Introduce caa_unqual_scalar_typeof"
         * rculfhash: Use caa_container_of_check_null in cds_lfht_entry
         * compiler.h: Introduce caa_container_of_check_null
         * compiler.h: Introduce caa_unqual_scalar_typeof
         * Avoid calling caa_container_of on NULL pointer in cds_lfht macros
         * Fix: revise urcu_read_lock_update() comment
         * Fix: uatomic powerpc comment about lwsync
         * fix: aarch64: allow RHEL7 gcc 4.8.5-11
         * fix: warning 'noreturn' function does return on ppc
         * Fix: use __noreturn__ for C11-compatibility

Project website: https://liburcu.org
Git repository: git://git.liburcu.org/urcu.git
-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

