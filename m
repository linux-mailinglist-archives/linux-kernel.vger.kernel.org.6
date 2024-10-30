Return-Path: <linux-kernel+bounces-389616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 524BE9B6F08
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 22:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 178FA281828
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BB9217678;
	Wed, 30 Oct 2024 21:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BNf3tV/j"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62451217652
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 21:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730323995; cv=none; b=RKLKZErr/Hmmrxgdosw8/dKFyKKfRT5JUO5aX5A7USUSWcrU0oA7KAWZOqKjGMF8uCeXrCrzk3FED5hOF6fixlhReCA7olBsxFlH1U2a77LqMr0jSU99y3aDtZJd+wYOns6eoRstSjd6q4Dp+zoiQzT5Ggnzqfkq7LdvGlLNou8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730323995; c=relaxed/simple;
	bh=zoCULGUF9eun8XXR66Tf3txnUUXICFP0HDocXk+1RZ4=;
	h=Subject:To:Cc:From:Date:Message-Id; b=BVsdxDoSB5KB9dyAqutKh7FtmNEKyDH80WzKMuEVZLlP7tN7zpPlDDh/sRPuvYFJQIlZ4PY4ZIW+ZtGw6f/emcVXmbd+VP6K9HjTI1cNXEkwpog9jN7JHtb7vMs+oKcjdYNrBUaRkC7DRjmVKfZdLB3bJUeQDZQd/ZhjcPXuxbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BNf3tV/j; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730323993; x=1761859993;
  h=subject:to:cc:from:date:message-id;
  bh=zoCULGUF9eun8XXR66Tf3txnUUXICFP0HDocXk+1RZ4=;
  b=BNf3tV/jCGpAfCNYOK8dcx4c/cR4OfTfQDAShY4gUGMMVL9JvtpzymuE
   mY9R9U2bW/g7fz0dHOAj0rnKrZZbdfNikT5hlgGf7K29Po+8lFkPqsyqs
   WzuNMFkMxL+9l9bt9bNizRZPZJcLro6wFLF/+clVw+J3Sy1VkEwGoB5rh
   X5/7OY5N2OtyZfDAw4zeZKO6y2fAzzz6V3TLHtdKvH4UzcZ7kGgM7LgIY
   h9i0ooDvnL3JjD9ltgAW2e3qd2a0jHJBQ/nrVnZDXb6UZ1QDLGdIJXeGz
   9xkynIpxol7sxUDOvB4M3ufJtGPbJ0NsQmdviNw7bgGuC4JPYlF88XHOV
   Q==;
X-CSE-ConnectionGUID: amSn+wDqSSSnNz3ZgnV5Xg==
X-CSE-MsgGUID: cv6a/+M1QTaf50cS8c7S/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29904662"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29904662"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 14:33:13 -0700
X-CSE-ConnectionGUID: YBwTfLF8QLOygxhR7T4b8A==
X-CSE-MsgGUID: l6NdC+KYSiGQHhW5rs0Wyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="82090427"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by fmviesa007.fm.intel.com with ESMTP; 30 Oct 2024 14:33:11 -0700
Subject: [PATCH 00/11] x86/cpu: Centralize and standardize CPUID leaf naming
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,tglx@linutronix.de,bp@alien8.de,rafael@kernel.org,lenb@kernel.org,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 30 Oct 2024 14:33:10 -0700
Message-Id: <20241030213310.C4861EC0@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

I noticed that the MWAIT code was rather haphazard in how it deals
with CPUID leaf levels.  As a result, there were a ton of unnecessary
checks for ->cpuid_level.  It is truly the worst offender because
there's arch/x86, intel_idle and ACPI that want to poke at it.

Move several of the leaf definitions to one place (cpuid.h).  Use
the definitions to get rid of magic numbers.  Simplify the code
when the CPUID feature level dependencies can be used.  Lastly,
change all the leaf names to be consistent.

This does not get *ALL* the leaves.  The topology and cache ones
are left along for now, but they can also be converted over.

