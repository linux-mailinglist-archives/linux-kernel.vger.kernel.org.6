Return-Path: <linux-kernel+bounces-437616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DA79E95D5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E80D32821C2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4400722ACC8;
	Mon,  9 Dec 2024 13:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nWvRqKOq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E01621E0BC
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 13:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749566; cv=none; b=Ys+ASwibsG+llGh0p+e0Q1Se0j3P7Fmo7YSezyNnKzOXCv/iwIIgNCnH4Kp9/4ygh1pcbUVuxq37N1mB8DrbNPIOtm61K7mPX3LTdeqMeMgp0j8o55BwtekE25pM/0mT6Gbr3BAT84xOCo8xN9ENvAmhVvvU9eheyfESo9tQSY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749566; c=relaxed/simple;
	bh=AJinQxG90c1ARxvcbpUqpFNpEaS9eviKLv/hZF6n6Qg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=WAteJ9iCcBrvecInMy8NxNeTwxT9tIlXM2LbfmKoAC6wRRVJCs1lpJut6BOVzHA3HdO5VLgH3CiOWmgFDJ/CVgFku/CKWV9lA25kqaCh6rtvlU2Pa21gO1qecw/Iysprw/cePoRWci2qsqYqfQr0PHxhSzxlG2o5Rs6qwkViRqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nWvRqKOq; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733749565; x=1765285565;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=AJinQxG90c1ARxvcbpUqpFNpEaS9eviKLv/hZF6n6Qg=;
  b=nWvRqKOqYQiid5E6PFqSDH93As9F8k48wgQsBZ2l0USZOdlSFYL8BaJE
   AqimqMwseJPTqf9pG4+rtvW+XWC+rrAEiOUindGFvO4Xde8QfNO9RZHvP
   iBS9HkgPprf05pbM+7iRX1yOQFdnEh/vM4DV7AEloyH/sQpNIYFIk1Lcg
   pUTIXu05x17K+0fY+kbprgsm+kdxkarXESXqpbPfcrfsgJLyFEjfwigT6
   r5A8v+Y0DJyeniYj8jxzCPKVVUBv/k/hWyR8g1drnKTdtudW02gLJgN9H
   KjpPBhUpKQ4onZDhcc71C/cJrDWrsuruXb00Mwl79lkpKB95ww9BYFmaa
   Q==;
X-CSE-ConnectionGUID: uoSudA4kQCSRdMYMsWWuqw==
X-CSE-MsgGUID: IfoC0pdWRn+URDb7NaGJXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="44723024"
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="44723024"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 05:06:04 -0800
X-CSE-ConnectionGUID: sXmbbgvoQiOGM1AOKPIR1w==
X-CSE-MsgGUID: 4pAbJi0jRAagxLByeosA5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="95871542"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 05:06:01 -0800
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: dave.hansen@linux.intel.com
Cc: bp@alien8.de,
	kan.liang@linux.intel.com,
	linux-kernel@vger.kernel.org,
	mingo@kernel.org,
	pawan.kumar.gupta@linux.intel.com,
	peterz@infradead.org,
	tglx@linutronix.de,
	tony.luck@intel.com,
	x86@kernel.org,
	qiuxu.zhuo@intel.com
Subject: Re: [PATCH 0/5] x86/cpu: Remove duplicate microcode version matching infrastructure
Date: Mon,  9 Dec 2024 21:06:20 +0800
Message-Id: <20241209130620.71276-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241206193829.89E12D0B@davehans-spike.ostc.intel.com>
References: <20241206193829.89E12D0B@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi Dave,

> From: Dave Hansen <dave.hansen@linux.intel.com>
> [...]
> Changes from RFC:
>  * Convert stepping match helpers to always take a range and never
>    take a raw stepping bitmap. - Ingo
> 
> --
> 
> x86 has generic CPU matching infrastructure. This lets you build
> tables of CPUs with some property.  It's mostly used for enumerating
> model-specific features, but it is quite a bit more flexible than
> that. In includes a facility to match steppings and microcode
> versions. This generic infrastructure is built around 'struct
> x86_cpu_id'.
> 
> There is a less generic, parallel CPU matching facility built around
> 'struct x86_cpu_desc'. It is used only for matching specific microcode
> revisions.  All of the 'struct x86_cpu_desc' users can be converted to
> 'struct x86_cpu_id'.
> 
> Do that conversion then remove the 'struct x86_cpu_desc'
> infrastructure.
> 
> Testing or acks would be much appreciated!

I tested this series + v6.13-rc2 on both Intel Cascade Lake server and Sapphire Rapids server.

- Both systems booted successfully.
- Both {skx,i10nm}_edac drivers[1][2] worked well.

  [1] Covered patch2's drivers/edac/skx_base.c file.
  [2] Covered patch2's drivers/edac/i10nm_base.c file.

Feel free to add:

  Tested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

