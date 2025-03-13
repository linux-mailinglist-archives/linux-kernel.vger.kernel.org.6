Return-Path: <linux-kernel+bounces-559434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3438FA5F3C4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F28418879EC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D679266B71;
	Thu, 13 Mar 2025 12:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ByOxMmi8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFE2266B5F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 12:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741867577; cv=none; b=VcOu1j3fLGv9sP+Vwk+f2888CFxffDFTa4v/64veUPSr9qFE0LYdoP+seXPsJ7lUZxP98RmLk7/VSbVbHUHa1bpN7mKeQX4meTjpBqai78IA0uk4hzgVWsNwaRj6cKuPnOKBlaN7Ej6SB83PcIb07Blk5egSz3tyqDf716c/lJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741867577; c=relaxed/simple;
	bh=8EWHkY1EdcknZHAuO+B/5Jp6uGVfXGJsqIRow7BI+fA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcTXAZwMpSGmy7z3LtFydmkcS/gI240MqUqCdl021HpfCf2pwqWJagPhfmy5fu+rJ1HXyOAT1+9MqF+cpaH/Ts2UydAkV3FH9cvbmyS+qqd6TxNrRjOOKn1IkNER/5ZMz/gegf1Xk4mwXfS2TSRTVSpLDob4z6r8opxPvEaqhyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ByOxMmi8; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741867576; x=1773403576;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8EWHkY1EdcknZHAuO+B/5Jp6uGVfXGJsqIRow7BI+fA=;
  b=ByOxMmi8uSWPKJUM2jsUnpY3DijqTEIi0Ud8YXfKhsZDLj2Mqkg95loD
   f1oGWyQTzEgK/C6QmhN3axkfBMvuebrMdg+lXlpyszs6h9wOYLVmRPa/S
   vywbirFO4pZ4kPVGa9yK5RS/OO6T8MrxaGEZ+ryGhTYHTGza4eMozc2f6
   9FrojpXM6nqDcHczBY7B1WBTjLXMO3IMKrz/3X2N4f1OCnVmLdb0QeSb3
   khSXcsBkbL+MQ0gkQuKMtrE2T/ltzW5aHLtpsIfQYHbhvBmBcCsN0FlWT
   KCCUCSweY8UgZLEFZRwIlnFDgKIC+9EFYXVk7MTNXxdKHNrGx75tM3YVU
   Q==;
X-CSE-ConnectionGUID: /ckRUvwaQFaLFAq/MnzHhQ==
X-CSE-MsgGUID: oHEUkyTpRi+OCThEBrbkPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="53617328"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="53617328"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 05:06:15 -0700
X-CSE-ConnectionGUID: Lqq54mWoRVCVh/5AhMopZQ==
X-CSE-MsgGUID: oUn3eD1CTkmpsTnx2xrYjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="121634489"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 13 Mar 2025 05:06:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id F23241FC; Thu, 13 Mar 2025 14:06:11 +0200 (EET)
Date: Thu, 13 Mar 2025 14:06:11 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <bhe@redhat.com>, 
	"Kirill A. Shutemov" <kirill@shutemov.name>, ebiederm@xmission.com, kexec@lists.infradead.org, 
	Yan Zhao <yan.y.zhao@intel.com>, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	x86@kernel.org, rick.p.edgecombe@intel.com
Subject: Re: [PATCH v2 0/1] Accept unaccepted kexec segments' destination
 addresses
Message-ID: <qj43ayg7qtdqlsi7y7c2mr3clq2tmcbvfg6e5j25liu54u7lzg@h3djemts5qro>
References: <20241213094930.748-1-yan.y.zhao@intel.com>
 <xgycziy2o56hnom3oau7sbqed3meoni3razc6njj7ujatldnmm@s7odbl4splbn>
 <Z4T1G4dwzo7qdwSP@MiWiFi-R3L-srv>
 <20250304154353.a79c330bffb4d21dce2dad9c@linux-foundation.org>
 <20250304155327.4499dcbbfa2445f76927c6c3@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304155327.4499dcbbfa2445f76927c6c3@linux-foundation.org>

On Tue, Mar 04, 2025 at 03:53:27PM -0800, Andrew Morton wrote:
> Yan, please go back through the discussion and incorporate reviewer
> feedback into the changelogs: describe the possible issues which people
> have raised and your responses to those.  Then resend and then let us
> restart the review process.  With less reviewer latency please!

Just in case it got missed, the updated patch is here:

https://lore.kernel.org/all/20250307084411.2150367-1-kirill.shutemov@linux.intel.com

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

