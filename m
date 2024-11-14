Return-Path: <linux-kernel+bounces-408586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 592E39C80C2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 03:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E3851F261DF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 02:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DE11E493F;
	Thu, 14 Nov 2024 02:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i13HH6NY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558FF1885B4
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 02:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731551219; cv=none; b=ccTVOsK/d253S08ONgQOK5lJ78+skCLBEzj+F1g5VdGgMW/+E8RogNWirJfGMtJwnSxNDgKiGKuDDK0JN6l2Igf7rqKywmRSsjRVICRQmFgYTaerC38LpmFvwKIDna05yQimEpqkpvCq2l3ZA9oPGxc2Wr/K+5560hMRMZkhoKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731551219; c=relaxed/simple;
	bh=/ms4a1d2rjK5ppuE2Wzu7BQbNS9vvaZkwjcaxfoBSos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZ17vS8FcG92+MLzloAJNJ3QZwDlyQ27yWV5mH/Xl+yX3sEHTPj6TVT3c5FHScCOl3GNCvJW9ewvtuHb0rgiS9Ah6zjoTHLd5lfr9bhRu/sxxJfQbcq1PGyVmuCQ/o7ZR7tHbT2lAUoy2VrJwnXkVERn/qa8+/388rpi6zJrI1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i13HH6NY; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731551218; x=1763087218;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/ms4a1d2rjK5ppuE2Wzu7BQbNS9vvaZkwjcaxfoBSos=;
  b=i13HH6NYfG+s781KiiSi/I8ATY8Nof3fJGGDgM6VdIwaCVU6XNV5dDuz
   IzBTLDHttbO7F4TtNqJXll0+4YxHr7r+sqllupEeSdhtJ+0gOWtS7abpg
   Uc2AKkjbHtQLpuf+oWfOcG/HXswVJmZHRJhWEPnprc/s4qHbJh/V4vEpj
   upr3HvT7p0Zg9um9aM/y8rOJdQ71KnnJ2HOHGJf28wTqH1VEEBQhFkksX
   6835yuakPX+upSukJ5F7Pm3rdv4/8mUi93xJ3PPdOIcyc4+5D8m6kBKdQ
   EiSi4TnWG5Rz/xhEeCuqaHcTxZ5scaZsYZ8R+NYNaHo2E2+tFZsSRUwuy
   w==;
X-CSE-ConnectionGUID: SSzc2b1bRsSI4glrf9NZ9Q==
X-CSE-MsgGUID: VtJizurvQpya1qXoPmpYmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11255"; a="31576874"
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="31576874"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 18:26:57 -0800
X-CSE-ConnectionGUID: gAV9EYPzQH+z0cQ7RBIK4Q==
X-CSE-MsgGUID: MebwxVt8Rj6kwyzmDyIIPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="125563126"
Received: from beginmax-mobl.amr.corp.intel.com (HELO desk) ([10.125.147.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 18:26:57 -0800
Date: Wed, 13 Nov 2024 18:26:54 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: David Kaplan <david.kaplan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/35] x86/bugs: Add AUTO mitigations for
 mds/taa/mmio/rfds
Message-ID: <20241114022654.qr35ebyspjh4zayj@desk>
References: <20241105215455.359471-1-david.kaplan@amd.com>
 <20241105215455.359471-4-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105215455.359471-4-david.kaplan@amd.com>

On Tue, Nov 05, 2024 at 03:54:23PM -0600, David Kaplan wrote:
> @@ -1995,6 +2004,7 @@ void cpu_bugs_smt_update(void)
>  		update_mds_branch_idle();
>  		break;
>  	case MDS_MITIGATION_OFF:
> +	case MDS_MITIGATION_AUTO:

This implies AUTO and OFF are similar, which is counter intuitive.
While mitigation selection code ...

> +	if (mds_mitigation == MDS_MITIGATION_AUTO)
> +		mds_mitigation = MDS_MITIGATION_FULL;
> +

... indicates that AUTO is equivalent to FULL. So, I think AUTO should be
handled the same way as FULL in cpu_bugs_smt_update() as well.

Same for TAA and MMIO below.

>  		break;
>  	}
>  
> @@ -2006,6 +2016,7 @@ void cpu_bugs_smt_update(void) break;
>  	case TAA_MITIGATION_TSX_DISABLED:
>  	case TAA_MITIGATION_OFF:
> +	case TAA_MITIGATION_AUTO:
>  		break;
>  	}
>  
> @@ -2016,6 +2027,7 @@ void cpu_bugs_smt_update(void)
>  			pr_warn_once(MMIO_MSG_SMT);
>  		break;
>  	case MMIO_MITIGATION_OFF:
> +	case MMIO_MITIGATION_AUTO:
>  		break;
>  	}

