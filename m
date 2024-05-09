Return-Path: <linux-kernel+bounces-174738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 987768C1427
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 19:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FE512818DE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 17:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1E24DA05;
	Thu,  9 May 2024 17:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bZBhO6XJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB4729402;
	Thu,  9 May 2024 17:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715276182; cv=none; b=L1RVb0XG33ibFkTz9qCi+4Hj3nzb+ghuW+XexZnZ5mvvzq2gweQRC0EnrzNBAMNbaEmgJAgNR4jB+4Be5fPzEEbgkBFunM10T9AD66Z9eQDt8jHrEzzgIy9+OptVWARzIAN3TF3msbw8cc3so23kvfwmFl0cgU7yBaAqIf3rOyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715276182; c=relaxed/simple;
	bh=5VFBIPnrVFf4x4OvHP0Zp5lkQSs1/BhTUl/W3QazAzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cRxJTvo4Xbru3PhC1Mqzn1FPhpZ6iZgi+uCWhBDplBMIYvfUEefJEBOSPUkXSRxoMqT4BeNZ1MLOxtWSCfmQ98T7QVlijjKqg24N4XUVbRS844vvjhmAU1Re60wJq+HQJPkMHt3a3zHli3mBHGQkDLgHr388rd5NezqXkRflPvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bZBhO6XJ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715276180; x=1746812180;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5VFBIPnrVFf4x4OvHP0Zp5lkQSs1/BhTUl/W3QazAzg=;
  b=bZBhO6XJ8rmMc4cQD/r3oqzTpQwH/kZycwcwjbySb6Yl/E3wme828zt7
   1rKaAkquKhsIoNhD7GaAmGjQGz9/rck5+zIyjRsUTHOHDffdWxf3rcK0W
   QBveFIRtLOtiHMU8ZXWyu1X4ehxxr7+sSWh0+tIQGxc4Hn4VRzLMZ9kxr
   iMibY+EFxsao6EGQT0W4TEWeG3EnEgf9zVrIxU/ibwqjVb4KdeQJj5bQP
   v/KLGI5LHaibIuVZoRLZIKu8vtfrsDDZ3duA1DC82LJc+QfXKXSDWCKro
   TgTyDLnhDjoWC+1R1LnpQqVQTNmfaV4NzEp7XMqg86i9uCu/aCnzi1oAO
   g==;
X-CSE-ConnectionGUID: +sLz2YubSnaxO2yz1fNUpw==
X-CSE-MsgGUID: FyAy4VhfQsyNFuke+A+tlA==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="22612701"
X-IronPort-AV: E=Sophos;i="6.08,148,1712646000"; 
   d="scan'208";a="22612701"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 10:36:18 -0700
X-CSE-ConnectionGUID: 8njCEuWlSyGjc8L8CnFGyQ==
X-CSE-MsgGUID: Lq19GTVbQwGbvxYIxqb4Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,148,1712646000"; 
   d="scan'208";a="29381534"
Received: from epinckar-mobl.amr.corp.intel.com (HELO [10.209.98.74]) ([10.209.98.74])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 10:36:17 -0700
Message-ID: <fde6149c-7ddf-488f-98c0-04f336b7092e@intel.com>
Date: Thu, 9 May 2024 10:36:16 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] x86/fpu: Extend kernel_fpu_begin_mask() to
 initialize AMX state
To: "Chang S. Bae" <chang.seok.bae@intel.com>, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, platform-driver-x86@vger.kernel.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, tony.luck@intel.com,
 ashok.raj@intel.com, jithu.joseph@intel.com
References: <20240430212508.105117-1-chang.seok.bae@intel.com>
 <20240507235344.249103-1-chang.seok.bae@intel.com>
 <20240507235344.249103-2-chang.seok.bae@intel.com>
 <f82879a5-f3ca-436f-8c4a-96d4c5d90354@intel.com>
 <7e589b35-4ff8-43fa-99dd-d3b17f56d3ea@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <7e589b35-4ff8-43fa-99dd-d3b17f56d3ea@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/8/24 17:29, Chang S. Bae wrote:
> +void kernel_fpu_reset(void)
> +{
> +       kernel_fpu_begin();
> +       if (cpu_feature_enabled(X86_FEATURE_AMX_TILE))
> +               tile_release();
> +       kernel_fpu_end();
> +}
> +EXPORT_SYMBOL(kernel_fpu_reset);
> +
..
> --- a/drivers/platform/x86/intel/ifs/runtest.c
> +++ b/drivers/platform/x86/intel/ifs/runtest.c
> @@ -188,6 +188,8 @@ static int doscan(void *data)
>         /* Only the first logical CPU on a core reports result */
>         first = cpumask_first(cpu_smt_mask(cpu));
> 
> +       kernel_fpu_reset();
> +
>         wait_for_sibling_cpu(&scan_cpus_in, NSEC_PER_SEC);

Remember, kernel_fpu_begin/end() mark a section of code that needs the
FPU.  Once code calls kernel_fpu_end(), it no longer owns the FPU and
all bets are off.  A interrupt could theoretically come in and do
whatever it wants.

I _assume_ that this is practically impossible since the stop_machine()
infrastructure keeps interrupts at bay.  But it's rather subtle.

I'd probably just do this:

+	kernel_fpu_begin();
+	// AMX *MUST* be in the init state for the wrmsr() to work.
+	// But, the more in the init state, the less state the test
+	// has to save and restore.  Just zap everything.
+	restore_fpregs_from_fpstate(&init_fpstate,	
+				    fpu_user_cfg.max_features);
+
        wrmsrl(MSR_ACTIVATE_SCAN, params->activate->data);
        rdmsrl(MSR_SCAN_STATUS, status.data);

+	kernel_fpu_end();

That's dirt simple.  It doesn't require new infrastructure.  It doesn't
call an opaque new helper.  It doesn't require a feature check.  It
probably makes the IFS test run faster.  It will also magically work for
any fancy new feature that comes along which *ALSO* needs to be in its
init state ... with zero changes to this code.  For bonus points, this
code is quite universal.  It will work, as-is, in a bunch of kernel
contexts if future deranged kernel developer copies and pastes it.  The
code you suggested above can race unless it's called under
stop_machine() and isn't safe to copy elsewhere.

Three lines of code:

	1. IFS declares its need to own the FPU for a moment, like any
	   other kernel_fpu_begin() user.  It's not a special snowflake.
	   It is boring.
	2. IFS zaps the FPU state
	3. IFS gives up the FPU

Am I out of my mind?  What am I missing?  Why bother with _anything_
more complicated than this?

