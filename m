Return-Path: <linux-kernel+bounces-285765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C68951251
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 04:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5719E1C22B30
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 02:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AD11BDD0;
	Wed, 14 Aug 2024 02:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="d/Uotrwe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D8F33FE;
	Wed, 14 Aug 2024 02:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723602292; cv=none; b=JN4O+TmiM8L8XOhXwryCeXPhV+P97kZIGpON+tOycNvL53yC8KXuxJEuUwj2wfLBCi/K+5SsABxRbbvljzTa9uZTvGqM7CCWqnh5iXR0YLk9M75roZgOZHQgsaMrVred6pVPutiHk43qPZ4/tIxg/3giFGGVvRTni7zM4lyCAOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723602292; c=relaxed/simple;
	bh=XNe50K+rCudFjQYRv5L/yVRqiEKXGVEUTSUUuxQwDbk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GMeVk5SqzQgI04WQbKFB+yXrRJaAv+rBtWCKeBbhb8+iEgcJ/PtTKUUKEGg/hN9gNSvMBxzqaXw7Lz2LqAgQjF4T+9BwN634FCn8Q3WdMZcog6X6oiGsfySt2BDr3hoR/GO5rvlBZC9rH2NSV11OQ3cyNE1b2rzYnPr+QajB1eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=d/Uotrwe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 728B1C32782;
	Wed, 14 Aug 2024 02:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1723602291;
	bh=XNe50K+rCudFjQYRv5L/yVRqiEKXGVEUTSUUuxQwDbk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d/UotrweKieWQJMVqNd65dlj1ziTa+YKfYSjfpJ5Ff+GjhK9fax7aj8z3Q/w8dAm9
	 tB7a3lLTI0tZ7kvhqYLAG2QgSso/PO3eIJ0zP0pZhH2siTj+8V7t0CGAdDrt5EFBQ2
	 zJXoJ+rpG3glti1ufvD37kChpjAFWImUuo71uuT4=
Date: Tue, 13 Aug 2024 19:24:50 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jani Nikula <jani.nikula@intel.com>
Cc: linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 akinobu.mita@gmail.com, lucas.demarchi@intel.com, rodrigo.vivi@intel.com,
 thomas.hellstrom@linux.intel.com, robdclark@gmail.com,
 quic_abhinavk@quicinc.com, dmitry.baryshkov@linaro.org
Subject: Re: [PATCH 1/3] fault-inject: improve build for
 CONFIG_FAULT_INJECTION=n
Message-Id: <20240813192450.9aff86552e06a48924b7bbc1@linux-foundation.org>
In-Reply-To: <20240813121237.2382534-1-jani.nikula@intel.com>
References: <20240813121237.2382534-1-jani.nikula@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Aug 2024 15:12:35 +0300 Jani Nikula <jani.nikula@intel.com> wrote:

> The fault-inject.h users across the kernel need to add a lot of #ifdef
> CONFIG_FAULT_INJECTION to cater for shortcomings in the header. Make
> fault-inject.h self-contained for CONFIG_FAULT_INJECTION=n, and add
> stubs for DECLARE_FAULT_ATTR(), setup_fault_attr(), should_fail_ex(),
> and should_fail() to allow removal of conditional compilation.
> 
> --- a/include/linux/fault-inject.h
> +++ b/include/linux/fault-inject.h
>  
> -#include <linux/types.h>
> -#include <linux/debugfs.h>

Removing a nested include exposes all those sites which were
erroneously depending upon that nested include.  Here's what I have
found so far, there will be more.

--- a/mm/failslab.c~fault-inject-improve-build-for-config_fault_injection=n-fix
+++ a/mm/failslab.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/fault-inject.h>
 #include <linux/error-injection.h>
+#include <linux/debugfs.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
 #include "slab.h"
--- a/lib/fault-inject.c~fault-inject-improve-build-for-config_fault_injection=n-fix
+++ a/lib/fault-inject.c
@@ -2,6 +2,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/random.h>
+#include <linux/debugfs.h>
 #include <linux/sched.h>
 #include <linux/stat.h>
 #include <linux/types.h>
--- a/kernel/futex/core.c~fault-inject-improve-build-for-config_fault_injection=n-fix
+++ a/kernel/futex/core.c
@@ -34,6 +34,7 @@
 #include <linux/compat.h>
 #include <linux/jhash.h>
 #include <linux/pagemap.h>
+#include <linux/debugfs.h>
 #include <linux/plist.h>
 #include <linux/memblock.h>
 #include <linux/fault-inject.h>
_


