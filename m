Return-Path: <linux-kernel+bounces-256638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A088D93515A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 19:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92076B22CE7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 17:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEEB145A09;
	Thu, 18 Jul 2024 17:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="iQsLU4nW"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9061459EA;
	Thu, 18 Jul 2024 17:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721324977; cv=none; b=VLV05iluyDcwg88/vinbOQz0Tb1hJqt13kErdVJehk1zH+QgUeFm3jfs7+aw5n8nvnhGhgyItDqTJOh4Fv/c/2XsfdAuN4oJZX6yMibm73BhHVVtO/95DhfTvX+O0YkCWSdP21MkxhQY0jQRpghjj+JWlIoJCJKbzzZEvTrm8gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721324977; c=relaxed/simple;
	bh=g1TQ46VdnW5+VtnXZyRKV8WnbNrgJQgrvGX5iUx0Qqk=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=RH77S33RvtY3gr8Rcy7qSa3p6kD+qbrHXNqOeUAAx1DYwvERHKLW6Zo5+nC+0T3GEutmhs/Sa0HTn8TnJ8VptJeEEMhRVLj5vMyluCBPEyY273lolwV8qoGUjR/ptZEKI95/OBDvX2xk0LbrNTEboaE2fDiwFgH9fDVbvhy4GIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=iQsLU4nW; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1721324645;
	bh=g1TQ46VdnW5+VtnXZyRKV8WnbNrgJQgrvGX5iUx0Qqk=;
	h=Date:From:To:Subject:From;
	b=iQsLU4nWKCXKpcYbtcqMgsFJEuYboryJzb7i5aQ5xSZA61cB7FYQ49KJZkyTCYsYh
	 MwsNe8IhCh7GkjeWP2PCQG6LJSTZZCI5MaqfvJrE/oEwo4G7p5bLk2UKovuqaAOz7y
	 0Y6haUSUmdSFqR/MEMhxWzlI+67eD6cTzBPdfxQqZqC5k7hOpzDeO7nF/Ydpq3v1oD
	 hPbhMW3lGMRdSOdPDWUTtGMa3ifWbGwb5MyO6AfeDPqXroQupY6tI4kS7hhIvmycb1
	 UbP1mSpMhhpLAM8a/c1G0a5+A1LDlDMo+9Mt8MmnTSPxUFgWlBjavJNfbU+g0OZuyT
	 6kyHCukcBSk5w==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4WQ0Y11PRqz1D2N;
	Thu, 18 Jul 2024 13:44:05 -0400 (EDT)
Message-ID: <1b61d65c-6c0e-4312-9939-cfdd3fd627ac@efficios.com>
Date: Thu, 18 Jul 2024 13:44:04 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
To: lttng-dev <lttng-dev@lists.lttng.org>,
 Diamon discuss <diamon-discuss@lists.linuxfoundation.org>,
 linux-trace-users <linux-trace-users@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Subject: [RELEASE] LTTng-modules 2.13.14 and 2.12.18 (Linux kernel tracer)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

This is a stable release announcement for the LTTng kernel tracer,
an out-of-tree kernel tracer for the Linux kernel.

The highlight of these releases is the added support for Linux v6.10
in LTTng-modules v2.13.14.

The LTTng project provides low-overhead, correlated userspace and
kernel tracing on Linux. Its use of the Common Trace Format and a
flexible control interface allows it to fulfill various workloads.

New in these releases:

* LTTng-modules 2.13.14:

   - Introduce support for Linux v6.10.
   - Fix build on CentOS 9 Stream 2024-6.
   - Fix mm_vmscan_lru_isolate tracepoint build against RHEL 9.4 kernels

* In both LTTng-modules 2.12.18 and 2.13.14:

   - Fix kvm_mmio event NULL pointer dereference in KVM instrumentation.
     This is triggered in case of unsatisfied MMIO read.
   - Fix fdtable wrapper (lttng_lookup_fd_rcu()) for kernel ranges
     5.10.220+.

As usual feedback is welcome!

Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

