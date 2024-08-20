Return-Path: <linux-kernel+bounces-293627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 154A3958221
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6734284C12
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0441D18C336;
	Tue, 20 Aug 2024 09:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AhVoE2/j"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A497418C335
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 09:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724145942; cv=none; b=ZgM1/UOf8ZCPcGlzXzrb9dzn3CK+XCg8vUR6tRgqmRD1fOmhxvcAB148dDaeoSmLlvYj8zyeIkn8sE3lFjy+wjiWAhZ4iLXf5l4JSIN3hB6T4xVf/VCO2cyrzhcX7Rsf/5zQX3bQ+QojGEwi9IaZRr60qOcK9gOzv/HvD4aT8Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724145942; c=relaxed/simple;
	bh=Zp5StRD0HffbjlzPH36WnGqcnam9HBxTSS19jVDDucw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6S9tUQBEZ2s1KlHNFtdy4PcWY41SGUbuVecZssYL5rYoArG0ulP3TA83Rc8lFSdweYYznI3KhnJ9obwWFasvVAcvrb011fXg7GV497iA2WxlDKw/mkmnZm/2HkoQC9+PkMJuyTvIa7ktVZesTbCsd48STlGO9c6BLNzlCdaY1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AhVoE2/j; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724145941; x=1755681941;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zp5StRD0HffbjlzPH36WnGqcnam9HBxTSS19jVDDucw=;
  b=AhVoE2/jjodRE3/28x9/cjXEcRMJGc+NkFnoopp5Dz2nOTK2KKzLmRV7
   Zs955/ACm5BEjzk/vo5amDCxaaworLp/14BsAm4+7l98TwkYyzy01fLAa
   DBP3Aafnm3nxgICVwA9NsT15JT7TAHx6BMQ7LVxBEizCH/BuxYujHWqY1
   RQlLaW4tdNHE96Gg6mot7n6ZvuHivaGTJo1bc3Iy7JT7RXnCus/pSIuz7
   8wrJrvSpXQhaU5U7E6OoKJnHDdO1Q4bYlg/7s2JRY1M6VoVBUGuqbhAsS
   TsYFmwfuoFVo3KWA3eKNofQvn6JONiqsp3qfZw1qCrpjcA6WB3Gs2Yi8X
   A==;
X-CSE-ConnectionGUID: bVgAC0kKTMuhPQ8AQPI/mw==
X-CSE-MsgGUID: YVgg1CaWQOay9/lLtya47A==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="33587360"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="33587360"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 02:25:40 -0700
X-CSE-ConnectionGUID: 6bV/ya32S1iBBfJOnvFVSQ==
X-CSE-MsgGUID: 2pkM0bKnRqWbCswO9s9o9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="65626253"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 20 Aug 2024 02:25:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 57BA3152; Tue, 20 Aug 2024 12:25:36 +0300 (EEST)
Date: Tue, 20 Aug 2024 12:25:36 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Kai Huang <kai.huang@intel.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@intel.com, hpa@zytor.com, peterz@infradead.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, nik.borisov@suse.com
Subject: Re: [PATCH 2/2] x86/kexec: Add comments around swap_pages() assembly
 to improve readability
Message-ID: <bhcbfgxfzvzzm2kja6l2zkmsjdtdo3tmvm25xnug47exrczfbf@oig3isqlkh2v>
References: <cover.1724068916.git.kai.huang@intel.com>
 <2ee726723302df54460880ead6747bdb1eb95363.1724068916.git.kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ee726723302df54460880ead6747bdb1eb95363.1724068916.git.kai.huang@intel.com>

On Tue, Aug 20, 2024 at 12:21:12AM +1200, Kai Huang wrote:
> The current assembly around swap_pages() in the relocate_kernel() takes
> some time to follow because the use of registers can be easily lost when
> the line of assembly goes long.  Add a couple of comments to clarify the
> code around swap_pages() to improve readability.
> 
> Signed-off-by: Kai Huang <kai.huang@intel.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

