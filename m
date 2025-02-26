Return-Path: <linux-kernel+bounces-535083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BBEA46EA3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 23:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B76F16DA7C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016E3258CE5;
	Wed, 26 Feb 2025 22:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jrTj0Swo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E368425D8F4
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 22:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740609266; cv=none; b=LiH2lFkQPvoP+JqXuTP6pl/OhXl0Hl8sjDacctElHbO1+liTtt2hPLFtRs1n4ZcmSJs2ptiOlpVz37IlCS2VAQ7zgDXI7mqZpzcYjThE7FRY3HgJDw/M2d0Btga622oFBdu2pGM57mfKximteZidaoD67ospmlY1MO3KmYsyIoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740609266; c=relaxed/simple;
	bh=kB67aXgZyoDNpQIVobWHgHnQeePRhb+j/OqfST83Zh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pwn1/8w7wfH6WUM8dYd1mRoF9D5g2SFmfIXHBfjeMvdelVt+z7CasZjb1HO1XCEQjakUwt7tPkxA9nJOZBmqtX47ruysYNH/N7dEU3vTsU+QoDuf6Ddv3o6F2S1ntiU6++0hs0qZiLzWV3xbyBf6bz55Fs0t/3Ni/Wam31mewso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jrTj0Swo; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740609265; x=1772145265;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kB67aXgZyoDNpQIVobWHgHnQeePRhb+j/OqfST83Zh4=;
  b=jrTj0SwoQ/oI0QvMU0OuuVvgnBUl699495G6qmip7Tj9JzkLk19nTw+F
   O3BCtvTncqlgP7oRo/difl8bt+d9E9h0QjCbwEyA+0x5SoU85CBfnosyT
   b5x54o61vdOCLlMeXoN+k773Mka0jlfVz9caqAoQF0cvnEzbEK7poNuH8
   B7vSiloSHKXENFL5kJ87EO5DqxMNDvlW2L5/HifnVbs1b2t58KEGmsf4o
   Y91mBwAu+ftlVVN+bzpU8G3CtTNrsw2KwBOmrYckXazsyc/BjvdSC2anv
   I3++0xKADa7Eb2wLdNc3Fxxo5UxGKzTi6+f6aWS2hNyqjFLgduJhAt+hI
   A==;
X-CSE-ConnectionGUID: gfQGLwcaTqKhbBAHg6qKdw==
X-CSE-MsgGUID: /1j2nmH+QIiNWOrd1nEwmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="45132919"
X-IronPort-AV: E=Sophos;i="6.13,318,1732608000"; 
   d="scan'208";a="45132919"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 14:34:24 -0800
X-CSE-ConnectionGUID: /zj3KAbWQt+XjXkJ9n2UQg==
X-CSE-MsgGUID: It/cinhqSlmZFwVgli3SxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,318,1732608000"; 
   d="scan'208";a="121850877"
Received: from unknown (HELO desk) ([10.125.145.169])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 14:34:24 -0800
Date: Wed, 26 Feb 2025 14:34:16 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: "Kaplan, David" <David.Kaplan@amd.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 20/35] x86/bugs: Define attack vectors
Message-ID: <20250226223416.kdrzblkw7nvyc2vq@desk>
References: <20250217233928.k3oem3bm7w63jzfr@jpoimboe>
 <LV3PR12MB9265041C9D8D4F3E5760F0B694FA2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250218070501.7mwcxqgsuxl3meef@jpoimboe>
 <20250218085203.GDZ7RKM6IyPDQAkZ8A@fat_crate.local>
 <20250220220440.ma5yfebhiovkqojt@jpoimboe>
 <LV3PR12MB9265DE3082FA0A7FDF9B587594C22@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250226201453.jgg6kucaathzmcvs@desk>
 <LV3PR12MB9265F875F52317BBCDF953EC94C22@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250226221324.hq2nevnnnrpgo75n@desk>
 <LV3PR12MB9265BC33F465DB7D2735290394C22@LV3PR12MB9265.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LV3PR12MB9265BC33F465DB7D2735290394C22@LV3PR12MB9265.namprd12.prod.outlook.com>

On Wed, Feb 26, 2025 at 10:18:51PM +0000, Kaplan, David wrote:
> No.  I'm saying that mitigations=off would be equivalent to the above
> command line.  The <vuln>_select_mitigation() functions wouldn't have to
> call cpu_mitigations_off() anymore, they'd just naturally chose no
> mitigation because no attack vectors would be selected.

Ohk, thanks for the clarification.

