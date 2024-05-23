Return-Path: <linux-kernel+bounces-187315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0E18CD014
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FD041F223B3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C57D13E897;
	Thu, 23 May 2024 10:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aXCKIBQZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989F313DDA3
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 10:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716459276; cv=none; b=jLolZkiN5wEmOTfMsoPFgWm5bmTa1rc0ZiF0dO+kH/AnLDUCkzQcAHmOlR+rfsKL3lBwA5nuDMtENG6QC5n4rmRU1+rP9hTnWI7R8NNy/5EsZ2Mr1dchOEmCyI/WvVbTId9wJHKqOqtQEDPK9wbIVxfXxh4uBcRDIFZRKkxBXkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716459276; c=relaxed/simple;
	bh=/iBsBSSY36qg1ntH/L641V63e2jJqPM62jX3pmzZfBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kd95nNDo8uOxrPr3mivgQokDuehzTzIjD9s49sV/aJfrlDhjuBHI//aucLxJiQjWbwVuHHn7fcqquenmUc/84D0jcPmFnCF7LoS6w/84m8J3HJTOGvs3vq/28FRh8N0Od5cOfI28a0n8Lh7j0XJTLM77qNeGFg4JwDtSTjci+ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aXCKIBQZ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716459275; x=1747995275;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/iBsBSSY36qg1ntH/L641V63e2jJqPM62jX3pmzZfBI=;
  b=aXCKIBQZwVEZCZcTtS5jpb4HCsnNM8gTLjGXbQJO1ugLoGtKSt+rN6Or
   k7P31SNCqBkAPQSFoMmOwpbUtbXUGJcb3C+sWd5Q48ZJKzwwvUn6eUJVk
   y7xbRM1CGBufGhPXskZHqK6xSKd2jWHI4IqxqW0/bA/UHG0pY926ZaH/I
   MOm4fBU1rO5tNln0ipdJAR45n11EiGZ7V6UJfQNcepZswitMggeT14Zlt
   NlQ/qQc4lPSVMS+kzTzG80/NlddyST9e0Fic4vk6N3gAxvDBBOPmIcftv
   q5owItGmeUzXqrAlIu3tiEtRYB9iGQrE22JR+jKAO2lro2ykj8Y2VR36m
   Q==;
X-CSE-ConnectionGUID: UoR6xfvvRgGVjJrgFx+Psw==
X-CSE-MsgGUID: aqMC+SYdRcSveEtsOAg7ig==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="12994672"
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; 
   d="scan'208";a="12994672"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 03:14:35 -0700
X-CSE-ConnectionGUID: J5CZK5LoR4CTGoSR4wse1A==
X-CSE-MsgGUID: sDpxEzTfQt2U9SNspZFgGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; 
   d="scan'208";a="64835066"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 23 May 2024 03:14:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 0EEA7E7; Thu, 23 May 2024 13:14:30 +0300 (EEST)
Date: Thu, 23 May 2024 13:14:30 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, cho@microsoft.com, decui@microsoft.com, 
	John.Starks@microsoft.com
Subject: Re: [PATCH] x86/tdx: Generate SIGBUS on userspace MMIO
Message-ID: <ngl63zhudmeskbcga3i3hsdtensd7bfoztnsiu7yj7pxbyzx47@tj5szegw6qrd>
References: <20240521073505.2190633-1-kirill.shutemov@linux.intel.com>
 <38dec9ee-1dde-4b3b-87c7-a65161d4a015@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38dec9ee-1dde-4b3b-87c7-a65161d4a015@linux.intel.com>

On Tue, May 21, 2024 at 06:35:49AM -0700, Kuppuswamy Sathyanarayanan wrote:
> 
> On 5/21/24 12:35 AM, Kirill A. Shutemov wrote:
> > Currently attempt to do MMIO from userspace in TDX guest leads to
> > warning about unexpect #VE and SIGSEGV being delivered to the process.
> >
> > Enlightened userspace might choose to deal with MMIO on their own if
> > kernel doesn't emulate it.
> 
> Any specific use cases ? Like who is using it?

Microsoft folks wanted it. Chris, Dexuan, John, any comments?

But it is generally right thing to do. SIGBUS is right signal to deliver.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

