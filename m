Return-Path: <linux-kernel+bounces-408745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B3B9C8303
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 07:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9F6E284A2B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 06:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8651AF0DC;
	Thu, 14 Nov 2024 06:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jAXMGXxD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A803C2905
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 06:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731565268; cv=none; b=LAeFc7QytafN79twWb4awDzjKwiyfUlGUl+B+Pt8kaWsnM6urkFmySnqt0FBIxEghRXCMPhiiDgl1Uu4LY9otZF9+ES/yf+yb9plxWUhHWiGKsEx3MuDwZt7d0CO8I6edGAcSINPktKG/8jFd9CY3C1kww8UjEEGnPozWqS1P4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731565268; c=relaxed/simple;
	bh=VHjtEvSiOX4/hU4hFklOdr8XcJRkPgv1Flyua07SLLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cr0PYpAuBhBT+HzitOX53qFKY1ido6HnPcR6F6jz7Ul5EWO90aMta4EOnSZy3Ms4PAWAS9T1qBp4DjbC20ibumfXPVcEdwQjyULJwzFDNoEglRP70s2NFfATnkwF+dUdEOTf+zcEFSDzSe+BhAKhIGuk8g7alMn2foEZxKp4UGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jAXMGXxD; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731565263; x=1763101263;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VHjtEvSiOX4/hU4hFklOdr8XcJRkPgv1Flyua07SLLY=;
  b=jAXMGXxDheU0I+/i40cOtKh6qe154jM06T61s800Jqm/ZK+LlaHdvCow
   ec22e0D84YYltwq2Ukd2LhoQqQu8OMXjUfJkaUekbdGdInbCUMYsVRz7A
   aV2eCerpET1kVfaYrqfyH83PusCGQhIO/+A8SP9MvTTpOZfWpPAfVitDD
   Szpewal6b5VoSL8MqdM/ctL3a7F5lG4PGjEpqFvzfHRrv74MkoOOaFfVO
   TrMz7nJkVdI4+m94h9nW4DqouQxmpzEIQGoa2nLtelUTx3gHzB4dfteLL
   Byp+CnbVna4WFzDR15fSt08cQ9xhPZlyBNDjRdBDh9Bn8WcY+wJiwxxgF
   A==;
X-CSE-ConnectionGUID: 7HHc4TMOQjaGiVCDinbH7Q==
X-CSE-MsgGUID: OaGub8HNRWGD/ZEw++ROIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="35196953"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="35196953"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 22:21:02 -0800
X-CSE-ConnectionGUID: NJJvDORQTO2yKktJG0vyMQ==
X-CSE-MsgGUID: Cn2aY7yyToOwDhivsETEiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="93153480"
Received: from beginmax-mobl.amr.corp.intel.com (HELO desk) ([10.125.147.24])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 22:21:02 -0800
Date: Wed, 13 Nov 2024 22:21:06 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: David Kaplan <david.kaplan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/35] x86/bugs: Restructure gds mitigation
Message-ID: <20241114061527.efcdp47xuqc4vmjo@desk>
References: <20241105215455.359471-1-david.kaplan@amd.com>
 <20241105215455.359471-11-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105215455.359471-11-david.kaplan@amd.com>

On Tue, Nov 05, 2024 at 03:54:30PM -0600, David Kaplan wrote:
> @@ -892,7 +899,7 @@ static void __init gds_select_mitigation(void)
>  		} else {
>  			gds_mitigation = GDS_MITIGATION_UCODE_NEEDED;
>  		}
> -		goto out;
> +		return;
>  	}
>  
>  	/* Microcode has mitigation, use it */
> @@ -914,8 +921,14 @@ static void __init gds_select_mitigation(void)
>  		gds_mitigation = GDS_MITIGATION_FULL_LOCKED;
>  	}
>  

Nit, extra newline.

> +}

