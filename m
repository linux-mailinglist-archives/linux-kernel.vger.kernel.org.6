Return-Path: <linux-kernel+bounces-254248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 837D99330B6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39C221F24587
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 18:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A0E71B52;
	Tue, 16 Jul 2024 18:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dKiHe2IU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FB01643A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 18:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721155899; cv=none; b=U8Jl0PDEDVzZKRXhAPOKBFuCKmbqdM1skLBUzl2HB3zPnPwXZKH266wh6xhDDA8z0t+CcHkuJFJO5KTr0EQFlDW6hg5qg16fLmhq6kOCaAipL5sMO+bQOvm2RLT0qr62T7+fzfiYzw/do4fs677wlTdsheE1mNNelgqi1kpVi0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721155899; c=relaxed/simple;
	bh=tfVJ/+1KbYj1S9wQiiqJ/Wfrv4cX0tlJjh3DxE8BYEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZQnJnVwM/4YNvGX4RZLFtuOttm4oc32wf3S/jtr5rwoCfaxhBxv3orU0N3j3THEC1TqosYw/VR5CpBNqOwHHdvhrQAN8iaIiH+XsjS4BPq9jj1CV05ly/JoNr0rPKr7vtjAfDlxxttQXNZx18jYiDxAWBiKvecGP9QTpjovurcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dKiHe2IU; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721155898; x=1752691898;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tfVJ/+1KbYj1S9wQiiqJ/Wfrv4cX0tlJjh3DxE8BYEM=;
  b=dKiHe2IUwyi2F2TbxXUAlG4HaSUPNmgq11olNacC9YOe0yvFiSG2uP8+
   E+/Dypv0Av8f8/1P2SFLAB+KEFUr8e+jPpxzsLUqsXqIr7lacmGNl4FC1
   BG0UrFd3hJDXxxKtoTaRuXWLbm07CICa6HGHa6WBWYJx1wXnWZanjAa7t
   EiRHNx5eZJBAYoySqhcjspRbZ84agf6MNZpRc47VbN8yB61i5C3CpqLDC
   lQZlUKRftsNkXXFbDhfN7KYzD2qLeTZPQCnaW2fT0e2IBQOgB0mPksBT7
   Lt9hfjqz01uMad1BbchbgWgYw6PQ2G0XuZFjCS3EVKJWGmeqs4CPrdpvo
   g==;
X-CSE-ConnectionGUID: ts2ul0iLSI+SCBZoxEh3Hg==
X-CSE-MsgGUID: e6Y+7ib5TKyXb0+wZyJv1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11135"; a="18815587"
X-IronPort-AV: E=Sophos;i="6.09,212,1716274800"; 
   d="scan'208";a="18815587"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 11:51:37 -0700
X-CSE-ConnectionGUID: dalCEvOVQzeqUUkz5v69Kw==
X-CSE-MsgGUID: NFSXBK03TzmYAUK89QQWpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,212,1716274800"; 
   d="scan'208";a="54440322"
Received: from alicebur-mobl.amr.corp.intel.com (HELO [10.125.98.21]) ([10.125.98.21])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 11:51:35 -0700
Message-ID: <97041043-7198-4044-b1ec-f4865f614cf2@linux.intel.com>
Date: Tue, 16 Jul 2024 11:51:23 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/10] x86/bugs: Add a separate config for GDS
To: Borislav Petkov <bp@alien8.de>, Breno Leitao <leitao@debian.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, mingo@redhat.com,
 Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, linux-kernel@vger.kernel.org
References: <20240422165830.2142904-1-leitao@debian.org>
 <20240422165830.2142904-2-leitao@debian.org>
 <20240712172132.GFZpFmHBJHte2xS1fr@fat_crate.local>
 <ZpUSvl5eKgkLeJrg@gmail.com>
 <20240715121703.GAZpUTP-8TJpZBCWne@fat_crate.local>
Content-Language: en-US
From: Daniel Sneddon <daniel.sneddon@linux.intel.com>
In-Reply-To: <20240715121703.GAZpUTP-8TJpZBCWne@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/15/24 05:17, Borislav Petkov wrote:
> On Mon, Jul 15, 2024 at 05:14:54AM -0700, Breno Leitao wrote:
>> Sure, I will send a v4 and get rid of GDS_FORCE_MITIGATION completely.
> 
> I'm actually waiting on the people on Cc to chime in whether we really need
> it. The three distro configs we checked, don't set it.
> 

If no one is using it I don't see any reason to keep it. It's just cluttering up
the code at that point. End users can still set gather_data_sampling=force anyway.

