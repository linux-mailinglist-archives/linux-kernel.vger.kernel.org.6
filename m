Return-Path: <linux-kernel+bounces-347730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1808498DD7F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49A821C233D3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C2A1D1315;
	Wed,  2 Oct 2024 14:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gSXDvcHH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6AF1D079C;
	Wed,  2 Oct 2024 14:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727880414; cv=none; b=PU+65WK1mvAbGSgDENy2w01UWhGN45xUGb1T+h+vxt45gHTPBa4xxUfJCoT7YITTrhGso6VXPhfP2NXHu4mME0isBLnCfEjCSy2/VvfLVXxJXaoQYB2yqtcVoC29DkY1lBYQ3oMoe+MylMTHQt1fr4CarlPjF2x/FeKmvIqOj6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727880414; c=relaxed/simple;
	bh=tSD05QZFRghjYBYf6Lq0GTszx2jvSxZqQZSLF77cqRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SfY5atLSxMsU93ngyW0o8OQPH0tePzYR8b8ebupnIXa3eGeh5A7rML2M4uGNCrhUqfo1Axpz5u3Sq6RJyDlamr2tSUjYq2YhrKS9Hz19kAoLpdxhUktzz+rjSKg2xSo4W1nipRq4xuCqy5tnqNqvcrTmDW0oiPgY6nb/nA2N8y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gSXDvcHH; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727880413; x=1759416413;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tSD05QZFRghjYBYf6Lq0GTszx2jvSxZqQZSLF77cqRM=;
  b=gSXDvcHHEpj8BWBk3EQz3ODTB8UJh+ZhiHFJ/Jyt63m9gAdXqfzGvrhn
   JPmZVVLtIWFpIl4VgeaV4KFhyxBM4nA6xkFjAA+iNZH4JYMeYxpNT/0En
   91WuyVgckIrv8lBs0gxDjSnPrj8JJQWmOsbsoWQx6HGbtKhXqYk/itwhj
   wJi3SrS5pkK12PWVnMgf+QTvHX+7TN5l8xEwBCWTHbBH5sbdyShGjsY5Q
   zb07Dq41152hgvLRWH+WaNpoiYa3ghAwJwDiBrw+fMmCf6ob5pGZYxS8U
   dJyOoodjZqApKo+LUs/IgRWXz0o17iRTiXc8qYXTQZ8HTIG7f1WhWeUOT
   w==;
X-CSE-ConnectionGUID: bGLZPtPMRMO4xyLMbHM0uQ==
X-CSE-MsgGUID: GYpnJJT0TA+xuK+x4w7EXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="52451091"
X-IronPort-AV: E=Sophos;i="6.11,171,1725346800"; 
   d="scan'208";a="52451091"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 07:46:52 -0700
X-CSE-ConnectionGUID: /VrnPfsQQHqZ2ugb18go7Q==
X-CSE-MsgGUID: vFCnqwFwQV+H7po5WH4dIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,171,1725346800"; 
   d="scan'208";a="74006240"
Received: from unknown (HELO [10.125.181.172]) ([10.125.181.172])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 07:46:50 -0700
Message-ID: <fdda8f74-4d9a-4aff-ad5b-c7a1f2b0ab0b@linux.intel.com>
Date: Wed, 2 Oct 2024 07:46:49 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] x86/bugs: Clean-up verw mitigations
To: Nikolay Borisov <nik.borisov@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org
Cc: hpa@zytor.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 pawan.kumar.gupta@linux.intel.com
References: <20240924223140.1054918-1-daniel.sneddon@linux.intel.com>
 <20240924223140.1054918-7-daniel.sneddon@linux.intel.com>
 <fe2dfd0b-6b2a-496e-b059-0600d2ae474c@suse.com>
Content-Language: en-US
From: Daniel Sneddon <daniel.sneddon@linux.intel.com>
In-Reply-To: <fe2dfd0b-6b2a-496e-b059-0600d2ae474c@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/2/24 07:20, Nikolay Borisov wrote:
>> +	if (boot_cpu_has_bug(X86_BUG_MDS)) {
>>   		mds_mitigation = MDS_MITIGATION_FULL;
>>   		mds_select_mitigation();
>> +	}  else {
>> +		mds_mitigation = MDS_MITIGATION_OFF;
>>   	}
> 
> BUt with this logic if CONFIG_MITIGATION_MDS is deselected meaning 
> mds_mitigations will have the value MDS_MITIGATION_OFF, yet now you will 
> set it to _FULL thereby overriding the compile-time value of the user. 
> So shouldn't this condition be augmented to alsoo consider 
> CONFIG_MITIGATION_MDS compile time value?

CONFIG_MITIGATION_MDS is used to set the value of the mds_mitigation variable.
Same goes for all the other mitigations touched here. Those variables are
checked in verw_mitigations_disabled() which is called just before this code. If
all of them are configured off, we return without enabling any of the mitigations.

