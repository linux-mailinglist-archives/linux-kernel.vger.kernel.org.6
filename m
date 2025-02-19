Return-Path: <linux-kernel+bounces-521643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D56A3C054
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A0F917829A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353C81E9B0B;
	Wed, 19 Feb 2025 13:41:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5718A45C14;
	Wed, 19 Feb 2025 13:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739972473; cv=none; b=PMnU75GFHLwE0m6UBiSqjECu2+HmSEGGh7hx+2bNrBQJ18Q3+5aGC+GrYsnRd8XmCsg1TYT1/8P4WxlFXr9HlvJVavE4jQ8489QV2dghjDoNb7si8ZpArpQ1D5uqVtOkpWZEolHQJWVKk6bMgyFnx8XKiddFN+2e9Y4GRn+lOQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739972473; c=relaxed/simple;
	bh=z3oU/+k+ZI8AERKJpGKypXZmHNAT00Wj8hIykkcfdNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FP4FdtqGgOZNziWhbXdkXvf3XL6+ZwUtPZgDJUeDLN52hMG3KFk2apnfn9vxyiAj/J4xio1Z8cTvIN2JuYmKPX5BFiA5zSnDYAarXh87APrVkNAS9sMlQUWTxYWnIjIvvuPbQ5D+pbZPtZNojNqi4ex5+sF5uooYAliR8YoVmC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 056F61682;
	Wed, 19 Feb 2025 05:41:30 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C9773F59E;
	Wed, 19 Feb 2025 05:41:07 -0800 (PST)
Date: Wed, 19 Feb 2025 13:41:05 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Babu Moger <babu.moger@amd.com>
Cc: corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	tony.luck@intel.com, peternewman@google.com, fenghua.yu@intel.com,
	x86@kernel.org, hpa@zytor.com, paulmck@kernel.org,
	akpm@linux-foundation.org, thuth@redhat.com, rostedt@goodmis.org,
	xiongwei.song@windriver.com, pawan.kumar.gupta@linux.intel.com,
	daniel.sneddon@linux.intel.com, jpoimboe@kernel.org,
	perry.yuan@amd.com, sandipan.das@amd.com, kai.huang@intel.com,
	xiaoyao.li@intel.com, seanjc@google.com, xin3.li@intel.com,
	andrew.cooper3@citrix.com, ebiggers@google.com,
	mario.limonciello@amd.com, james.morse@arm.com,
	tan.shaopeng@fujitsu.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, maciej.wieczor-retman@intel.com,
	eranian@google.com
Subject: Re: [PATCH v11 17/23] x86/resctrl: Auto assign/unassign counters
 when mbm_cntr_assign is enabled
Message-ID: <Z7XfcV05ZZkHm6bc@e133380.arm.com>
References: <cover.1737577229.git.babu.moger@amd.com>
 <2119b76ef8be21b1d8b2deedfab23e8e33ba724c.1737577229.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2119b76ef8be21b1d8b2deedfab23e8e33ba724c.1737577229.git.babu.moger@amd.com>

Hi,

On Wed, Jan 22, 2025 at 02:20:25PM -0600, Babu Moger wrote:
> Assign/unassign counters on resctrl group creation/deletion. Two counters
> are required per group, one for MBM total event and one for MBM local
> event.
> 
> There are a limited number of counters available for assignment. If these
> counters are exhausted, the kernel will display the error message: "Out of
> MBM assignable counters". However, it is not necessary to fail the
> creation of a group due to assignment failures. Users have the flexibility
> to modify the assignments at a later time.

If we are doing this, should turning mbm_cntr_assign mode on also
trigger auto-assingment for all extant monitoring groups?

Either way though, this auto-assignment feels like a potential nuisance
for userspace.

If the userspace use-case requires too many monitoring groups for the
available counters, then the kernel will auto-assign counters to a
random subset of groups which may or may not be the ones that userspace
wanted to monitor; then userspace must manually look for the assigned
counters and unassign some of them before they can be assigned where
userspace actually wanted them.

This is not impossible for userspace to cope with, but it feels
awkward.

Is there a way to inhibit auto-assignment?

Or could automatic assignments be considered somehow "weak", so that
new explicit assignments can steal automatically assigned counters
without the need to unassign them explicitly?

[...]

Cheers
---Dave

