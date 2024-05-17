Return-Path: <linux-kernel+bounces-182164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE568C879A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 15:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B3A21F21274
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 13:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C4B55E49;
	Fri, 17 May 2024 13:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ndM3ozU3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30214F896
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 13:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715954155; cv=none; b=YCjVjfyfqjM08IBalyNHrpx1Yepf0GLs/hV77i8M6tyc7kBJvZbnQ4DWtDQWUZ0Aqid8B6d7LDsqDjAwM8JAdajsGxdg068atun5zEIwGaqwMkIt0Fm0RlX3/asBAwYTKO1k1kHiyCxjNujhe1lasgiaezlDYjMqrCSShbUdmxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715954155; c=relaxed/simple;
	bh=Zx71wp0+ZUyZy+QAnwGWH0R4N3tMIW4ToXLu0Ve/5MI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUq6C4T8ZLkJwrgpzDbJebHgYQe7V9Owj4/LjGZnXjKGDPmNPgXBCiB7oer9W46tvaCbWj74CmHTFnhHnxdc4I+peXPyvrccxttJoweZCmrkaO4277xnn3zz5h6+Hz4QaLI2nVXIiEfgWYF8taIzC0cuqDXLDZkWXMJ8y8mMYio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ndM3ozU3; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715954154; x=1747490154;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zx71wp0+ZUyZy+QAnwGWH0R4N3tMIW4ToXLu0Ve/5MI=;
  b=ndM3ozU3jNeIYQCE6HkRdOZhGThLcKhYwIqjzx/Xf4W+bLWO+dEf6Rbo
   499J9CpoJFR1WeDirfWddnoJ+SFH389k8G+Oz+7rcK8l96GkM11h7CK11
   D/8fNxYJKHY3OcYQ13xPXMPJJAxuTGWxjT9ts89GJ0cmfX53HbAStb+WY
   8dWiZLBGYq/Dz3zmast2+jWLO3ALfgRZEAkybHoC2k4XcxA30dkAcC6BN
   /kx/BhWGhvJlQ393LnTqvYJlccFBU6v6jR81OVfmHZrJkedpTvR0Zpv5w
   QgzHfsH4F0kUg7fCv5fXxfANHD9DOStFjzTUA5nWmymboQaCvZmaFmCw7
   A==;
X-CSE-ConnectionGUID: 8bdw88aMSPGsHBAQRqbfRQ==
X-CSE-MsgGUID: 4/2Q6W+jSZ6xnCrcIRpaIA==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="22805138"
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="22805138"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 06:55:53 -0700
X-CSE-ConnectionGUID: cqG2K85WSfSK22mc3P7LGA==
X-CSE-MsgGUID: kC61XqpfSiWdFXYnyF+feA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="31937696"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 17 May 2024 06:55:51 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id D712819E; Fri, 17 May 2024 16:55:49 +0300 (EEST)
Date: Fri, 17 May 2024 16:55:49 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-coco@lists.linux.dev, Dave Hansen <dave.hansen@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/kvm/tdx: Save %rbp in TDX_MODULE_CALL
Message-ID: <ohvjbokpaxagc26kxmlrujab7cw3bekgi5ln7dt46cbsaxcqqh@crvqeohfazmf>
References: <20240517121450.20420-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517121450.20420-1-jgross@suse.com>

On Fri, May 17, 2024 at 02:14:50PM +0200, Juergen Gross wrote:
> While testing TDX host support patches, a crash of the host has been
> observed a few instructions after doing a seamcall. Reason was a
> clobbered %rbp (set to 0), which occurred in spite of the TDX module
> offering the feature NOT to modify %rbp across TDX module calls.
> 
> In order not having to build the host kernel with CONFIG_FRAME_POINTER,
> save %rbp across a seamcall/tdcall.

There's a feature in TDX module 1.5 that prevents RBP modification across
TDH.VP.ENTER SEAMCALL. See NO_RBP_MOD in TDX Module 1.5 ABI spec.

I think it has to be enabled for all TDs and TDX modules that don't
support it need to be rejected.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

