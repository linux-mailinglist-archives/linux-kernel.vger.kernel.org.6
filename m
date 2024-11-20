Return-Path: <linux-kernel+bounces-416300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC9A9D42F9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 21:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 860972823C5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 20:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51881BBBE0;
	Wed, 20 Nov 2024 20:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k+j35Qt/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27B3170A30
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 20:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732134251; cv=none; b=ZGZZOLY5LOYJWToE1vh6tjkRSaRsqYd3HgC4PMw6FEXjaX/nPjNETPWrCLyQPBhUNxDhkZP6KjJafT/g50m1g9vhkKdn9zeXAmPJv8/SN5DRMFPf2XnROyT2vbi1UJAH3ngS2fJwmvRyqhNaCOkbhtaIwA2fLcJBnKJOAmVxP+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732134251; c=relaxed/simple;
	bh=m7M1TGPyVgjk+q+1ivxJElAxU83jVaAQJgodn4Z27Ck=;
	h=Subject:To:Cc:From:Date:Message-Id; b=PNhEVug+RDx7YZny9TxcvRJo57WJp6WEy2c36NP7aIAEQ2iktq70J3C+ffiLZAbqO2p+Kz8CChocunSACz2js1ZU4a4b6Z7x+qxLkroX+Ko0GV0AFtqk5G1hqMLEm288PPWMS3H0gp67ugou/wbtAG/IjhZ1wuYXY9KO+rOvLCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k+j35Qt/; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732134250; x=1763670250;
  h=subject:to:cc:from:date:message-id;
  bh=m7M1TGPyVgjk+q+1ivxJElAxU83jVaAQJgodn4Z27Ck=;
  b=k+j35Qt/VLBW5b3t9v75DqovGOeMzGc6/bYLpAS/KjoWanLgrD5Xnys7
   s1B+MgRsQ1ruerAhQDJmfWfjdDrYbNvoMHj8TZiRL/QChuFGjpO0prB5y
   IlBnWUUbaFFMSdQqlonHMV8HnBLhl4kE3m3wUtRabEB+8vmWFC3YRVJKL
   E2BqhV3t/KgoXsh7PP0US+sjH6+Q1sFlq/QaDmRJAamGCnzdS1HJ6OtBE
   OHZ3xwGU76dhDps3JJIY85n0rqENmRPd32gqz/DilGGAI2rjpWy5sOjKW
   M9qqKtDYWuGIEKRluJRn9cHKyDs6L6xgzuGkcIoOfQ9Z8+LTA5MbR2txo
   w==;
X-CSE-ConnectionGUID: 3P452BpJSVyFy5fNcxjxhw==
X-CSE-MsgGUID: La3xGH7XRRiZbjFG6tw3rw==
X-IronPort-AV: E=McAfee;i="6700,10204,11262"; a="42855758"
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="42855758"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 12:24:09 -0800
X-CSE-ConnectionGUID: Q9BHEnBQSIqRyZk4ZOveXQ==
X-CSE-MsgGUID: RzhF4ZBtRWWHI4a2RGmPxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="90407605"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by fmviesa010.fm.intel.com with ESMTP; 20 Nov 2024 12:24:10 -0800
Subject: [RFC][PATCH 0/4] x86/cpu: Remove duplicate microcode version matching infrastructure
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,tglx@linutronix.de,bp@alien8.de,kan.liang@linux.intel.com,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 20 Nov 2024 12:24:08 -0800
Message-Id: <20241120202408.0A7215EF@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

x86 has generic CPU matching infrastructure. This lets you build
tables of CPUs with some property.  It's mostly used for enumerating
model-specific features, but it is quite a bit more flexible than
that. In includes a facility to match steppings and microcode
versions. This generic infrastructure is built around 'struct
x86_cpu_id'.

There is a less generic, parallel CPU matching facility built around
'struct x86_cpu_desc'. It is used only for matching specific microcode
revisions.  All of the 'struct x86_cpu_desc' users can be converted to
'struct x86_cpu_id'.

Do that conversion then remove the 'struct x86_cpu_desc'
infrastructure.

Testing or acks would be much appreciated!

--

 events/intel/core.c         |   72 +++++++++++++++++++-------------------
 include/asm/cpu_device_id.h |   55 ++++++++++-------------------
 kernel/cpu/amd.c            |    8 ++--
 kernel/cpu/match.c          |   28 ++------------
 4 files changed, 63 insertions(+), 100 deletions(-)


