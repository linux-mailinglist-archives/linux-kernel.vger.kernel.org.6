Return-Path: <linux-kernel+bounces-558408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D41BA5E573
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 21:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BCE0179CD7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 20:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AABE1EE002;
	Wed, 12 Mar 2025 20:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RrulL0Fh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7371EBFE4
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 20:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741811604; cv=none; b=R45jdB2XNo31PXH4IO+cxI6/GOFXxDSoWojVelEzBTsPYSucHMHNN/3N3khF5D2ADnH2CjV4zFmqtP5tbeA/DOlbpnGF/WBB+e9/oywHGIJG8Sf/5qjZcHk7z5+0VibwU8dY5MWMyqliVx93ySnVApQsLRXsc/juWZwe/0tbWIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741811604; c=relaxed/simple;
	bh=88GBzbK7SHQe3MsJcPgR8t63Je+MXumEN25cwFg8WLE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=W+iXsvAOQDds9UikcybxBNgPhNbaleUgT0XnGM6zpmnaS2SIawjnInw+yfR86G6tPxVJYZ+oUKcKfjeMdk3hY/QI+LQEspoJnpAMpC9E/1KG6kUgnB8dTCS2oA63CS8MziaFA6FVPxEV4itTFajyEXt2/BH0mI4hTI3doKnOm/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RrulL0Fh; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741811603; x=1773347603;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=88GBzbK7SHQe3MsJcPgR8t63Je+MXumEN25cwFg8WLE=;
  b=RrulL0FhxtuwnR/WVIwHwHd2uE+xCDpvCHgcs+vEA403vWALT+zknMoM
   COvk6qn2fLTYxT2udA/6fevXupbERGS56Q9GaoiE11vWpvEhhniCTXgEq
   m7uRdniAU5Ld8wXGfXrpRMBgLySHHXhbYAd/HmA4MnhHN8z6rFKIzSU7m
   E1xx+UFEkgysf/OaZTzI3NsBpfcBZOKKQg91FFLrNPRE59SN0lv/xrPTe
   HZQ08uRXaWyFgH3sM5rNe4Tdd2XhDH8p7OZpewdJQz71bRHSA/oEpvaen
   gxfRxcH6+s7iLWczA5ClI+aym4IhaCFDp5Hf/Bjzs90gxIIcItyqtGuHa
   w==;
X-CSE-ConnectionGUID: 1xSAqtG5QmKZdPU5nYYeXQ==
X-CSE-MsgGUID: /wiNVB//QwSjZFd8TPCnkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="46819847"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="46819847"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 13:33:22 -0700
X-CSE-ConnectionGUID: CUU320IxSsC1p8pmhEJVAg==
X-CSE-MsgGUID: xdDkkXWCSf2inGz7F6reKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="125922456"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.108.3]) ([10.125.108.3])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 13:33:22 -0700
Message-ID: <527a8fc8-3154-4822-8a78-43bd0696221b@intel.com>
Date: Wed, 12 Mar 2025 13:33:21 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/1] Accept unaccepted kexec segments' destination
 addresses
From: Dave Hansen <dave.hansen@intel.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: akpm@linux-foundation.org, Baoquan He <bhe@redhat.com>,
 "Kirill A. Shutemov" <kirill@shutemov.name>, kexec@lists.infradead.org,
 Yan Zhao <yan.y.zhao@intel.com>, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, x86@kernel.org, rick.p.edgecombe@intel.com,
 security@kernel.org
References: <20241213094930.748-1-yan.y.zhao@intel.com>
 <xgycziy2o56hnom3oau7sbqed3meoni3razc6njj7ujatldnmm@s7odbl4splbn>
 <Z4T1G4dwzo7qdwSP@MiWiFi-R3L-srv>
 <87zfjuoj3i.fsf@email.froward.int.ebiederm.org>
 <f38f1b56-a5df-4644-be59-56c70499ed92@intel.com>
 <fslhdizolr4twqm4ixevzj6ai5l5qg6mxky25jasn3yctsnvt4@hpwphlmfs5cp>
 <4599571f-804b-40d8-b5c8-e19478a3ad18@intel.com>
 <wk7tfjqtpzgmsvilgszlgqnqjgm5kg2vfxboaspd3qyfs6uqb3@nbgacwb3kcb6>
 <87o6ygskb8.fsf@email.froward.int.ebiederm.org>
 <99cc1c36-ba3d-40c7-a5bd-d13655fba171@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <99cc1c36-ba3d-40c7-a5bd-d13655fba171@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/4/25 11:16, Dave Hansen wrote:
> On 3/4/25 10:49, Eric W. Biederman wrote:
>> How goes the work to fix this horrifically slow firmware interface?
> The firmware interface isn't actually all that slow.

Hey Eric,

I've noticed a trend on this series. It seems like every time there's
some forward progress on a fix, you pop up, and ask a question. Someone
answers the question. Then, a couple of months later, you seem to pop up
again and ask another form of the same question. It kinda seems to me
like you may not be thoroughly reading the answers from the previous
round of discussion. Or, maybe you're like me and have a hard time
recalling any discussions more than a week ago. ;)

Either way, I hope you're finally convinced that the hardware design
here is reasonable.

If not, I'd really like to continue the conversation now when this is
all fresh in our heads instead of having to poke at cold brain cells in
another month.

Any more questions, or can we finally put this issue to bed?

