Return-Path: <linux-kernel+bounces-385113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAFA9B328E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4183282EDA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5E11DD54C;
	Mon, 28 Oct 2024 14:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DO83F7hW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935801D2B1B
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 14:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730124425; cv=none; b=lffTpsmeKc/CrSp3N/dKGzX3qW7NbEZefci5WTwqqFFP/Lj5Hcxf+o1gQYszbGaNJWcqc+/VYPE6s2nYRgMnMgg2da+eWW5Zalzgqx+nZV8MjUnz+45uYlKlbVy72ESyMUdRTGvQmwobo3KeyIYMub+TZDRRXem1oM39gYqPQCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730124425; c=relaxed/simple;
	bh=E07VelKPI0n5vZ79YilSgh5WSQb3mkfXVY5jKAZIgDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZ07JSB18r4KFUkgilJiZXBNfbq02rXy1PcQ9nHrImlPcxC5MbAQitP/Pkxx1040Yz4NiK7YsZDztX+zhdM4izVpa5I0zw9hdi70V0PXk98+ufZbZh5GGrjzJB6twbzo14WLlnRXFculqZS88hujPjDM2hamE3GaZwjqbvnYR6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DO83F7hW; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730124424; x=1761660424;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E07VelKPI0n5vZ79YilSgh5WSQb3mkfXVY5jKAZIgDg=;
  b=DO83F7hWOUP48oi85giobNOic0bhYXgiVGHOseyGq3kzjK5n/h8YfwKy
   mpjdbrSmt3XJkjfLI28AMpsXevy99OVjyQkB2mWNaPUVEzEMba8YI5LPN
   Iqiyc5yHhiRbktdJ76p3Se2c8NlKa37rTOV9GvvsE5CBEeCIfPldh/GDw
   lxMvxXcDM30gTh/bpb5VXkp5TIzidp/mdqOLE6cnGQM2b783KL4HtUlQp
   E8fRXghCDzMbCPfnbL61yk4o2yN8hjs3Bqa2g2y9bH4vDD77djoiWbqYq
   Peb1oaqiy7x2qg3t7F1erHoA55rCNAExWDpoMU6C1jSLrz2ulKnEEj75S
   g==;
X-CSE-ConnectionGUID: lAa+pVifTSaEyYfsKJIlxA==
X-CSE-MsgGUID: 37Q+y1xLQ8iQRhNV6sZ9OQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="29831094"
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="29831094"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 07:07:03 -0700
X-CSE-ConnectionGUID: QZdKtSS3SgOD0Lregg+Ijg==
X-CSE-MsgGUID: OjGDCUlmQheDMUXIlZ00xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="82056399"
Received: from rvedam-mobl.amr.corp.intel.com (HELO desk) ([10.125.149.30])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 07:07:03 -0700
Date: Mon, 28 Oct 2024 07:06:34 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Breno Leitao <leitao@debian.org>
Cc: bp@alien8.de, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/bugs: Use cpu_smt_possible helper
Message-ID: <20241028140634.yjr7i4hwxj7keokm@desk>
References: <20241015105107.496105-1-leitao@debian.org>
 <20241015105107.496105-2-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015105107.496105-2-leitao@debian.org>

On Tue, Oct 15, 2024 at 03:51:05AM -0700, Breno Leitao wrote:
> There is a helper function to check if SMT is available. Use this helper
> instead of performing the check manually.
> 
> The helper function cpu_smt_possible() does exactly the same thing as
> was being done manually inside spectre_v2_user_select_mitigation().
> Specifically, it returns false if CONFIG_SMP is disabled, otherwise
> it checks the cpu_smt_control global variable.
> 
> This change improves code consistency and reduces duplication.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

