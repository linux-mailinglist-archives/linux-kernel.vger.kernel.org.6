Return-Path: <linux-kernel+bounces-342512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9B0988FCE
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 17:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD686B21939
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 15:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297671DA23;
	Sat, 28 Sep 2024 15:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="svyDSdjj"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE43F58210;
	Sat, 28 Sep 2024 15:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727535685; cv=none; b=GD6BAv9C2MBBS4fB+GsOxmgGTVDTaUqGNeYIubVV8u/JVjaofgqzs/JiizmBpRhJ4JXX3hjehtzASE3p9Md/gqwQNWY5+pnZVhFnuH7z2vi6YwAf9FiRKmCuiWdSmCwDHYxalLn87DBGYLqcGq3SpeoNYMyQjH/S3mCFCQuNA2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727535685; c=relaxed/simple;
	bh=9lLVuvIbeyrvV/2rHADtuhi7iK9i5+lub1PZCJM46HQ=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=FRLSr3E8rmnxQTP0kiTUQTDgPljFzXViqkzshIOmCYdMbYHgrIxltOTUVJsrkLfiNgo76bJbsVmC4MugB6jkVkjRHJjwvU87hV9drJqyO9GVzgAIlhAW3hQ7Mv/2q13jrUlcky/oQCAitzfPw2osoqgTVOTA10yM1JWCdM2r2bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=svyDSdjj; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1727535680;
	bh=9lLVuvIbeyrvV/2rHADtuhi7iK9i5+lub1PZCJM46HQ=;
	h=Date:From:To:Subject:From;
	b=svyDSdjj99lc2cfgyvWRkpN1b0Mb75TDI0Qm+2ev/VyoQtXStfvLhGHmE4/HBnzQX
	 NloZy6yycdgwMgSsWyqW19ekfYBTUt15qb/HoOkg+NxcAZekCFUpLzRO9as/N63iB0
	 Sg8qHuoIHOid2fm4++46SH4CYuGPqY5NjDDdQmmfv6t2ua/34HJ8UyTiiJL2fkh7tq
	 hub6lwOLw3Vt/U+JdVAbPR6VIbPmjmvtNC/74oVjpXw7rykCfc5KHsWcIv14GdPmRr
	 JWjdmjRvCHEykzRrea48ypY0ra/3hFJFm5R8raYWLG09miWhf/mzHCCmOUrBbJXQz3
	 oTtaxA08OcxFg==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XG9X0517Cz1cPx;
	Sat, 28 Sep 2024 11:01:20 -0400 (EDT)
Message-ID: <e367cf33-e113-4fb8-9f48-94bb7a531604@efficios.com>
Date: Sat, 28 Sep 2024 10:59:17 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: lttng-dev@lists.lttng.org, diamon-discuss@lists.linuxfoundation.org,
 linux-trace-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RELEASE] LTTng-modules 2.13.15 (Linux kernel tracer)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

This is a stable release announcement for the LTTng kernel tracer,
an out-of-tree kernel tracer for the Linux kernel.

The LTTng project provides low-overhead, correlated userspace and
kernel tracing on Linux. Its use of the Common Trace Format and a
flexible control interface allows it to fulfill various workloads.

* New in this release: Introduce support for Linux v6.11.

Detailed change log:

2024-09-28 (Ask a Stupid Question Day) LTTng modules 2.13.15
         * Fix: scsi: sd: Atomic write support added in 6.11-rc1
         * Fix: block_start removed from btrfs_get_extent in 6.11-rc1
         * Fix: block_len removed frmo btrfs_get_extent in 6.11-rc1
         * Fix: orig_start removed from btrfs_get_extent in 6.11-rc1
         * Fix: ext4_da_reserve_space changed in 6.11-rc1
         * Fix: kfree_skb changed in 6.11-rc1
         * Fix: event notifier: set eval_capture to false for kprobe and uprobe

Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

