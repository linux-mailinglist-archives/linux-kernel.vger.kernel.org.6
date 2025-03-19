Return-Path: <linux-kernel+bounces-568361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5085BA69462
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54173171FB5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2301DE4FA;
	Wed, 19 Mar 2025 16:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aykRC7O3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pSXToEV0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534731CAA7D
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 16:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742400595; cv=none; b=LxiuhAJJ6oD2GarDar95hJN+HeUbMtDQQd2lShKTORaDFc/WvVk3pRhGKq8/26v84nQEOYjUlhEZc9CxDL1sBwPAIG2k30APa/toFrdJCLHY8nOm4SD+TSqiTjBLU4voEVlxPmBee0Ac9nffuaUVDlVTzezi8DgIBFrRkOLMGNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742400595; c=relaxed/simple;
	bh=G0vg0m0oxHgCnikWHLlyIDDQchsns62NJVtCPtY37Nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/idcIzugTuYbxxiDchXP/Ozqt2hxNcKM+1ST5arhgqr6Ij6gCg1lUovPDPhZMXPBGi6RZpGoHzEQmo1R3m0ccczvYLi6Dakvcx2OzUBLmlPUT2ecD3fFRdD21ySbwVjD+rogfHQjEy+ha33hZ/9apvw4msYeubLl75KdySyRrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aykRC7O3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pSXToEV0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 17:09:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742400592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f3CF3UdUoe/ySTXFKSKClTZYWcZ5dr4XM27XFgv7WYE=;
	b=aykRC7O3V3CaIFFQJ4Uqh55u6HeqG/LB+N8Y8l3x8FMmwgZG5tf4s1J6mEgi2tkiR9dRlC
	/+UMn9BfXZYB+efafnIBv/yQbJpsSCfDSgFqS3WzwZy/GaV4xV49RBlEMRKgJlCubpGuFM
	L91LSv1CY8tw9V7IJAl0ht0kjPb2Xmk9K55zaUYiKpP7LUGZvaHPxaQnhPop8PF8HtEh76
	rdgodRXb6JBDoJUc/7j96akVfro3fo8VN9dTe5FyiHJJUc9ocJAMiZ7B/b7mpiQINkm5MQ
	Uccl0zhGiQanPKI5tB7xC7QnHsNeXecYcCuMToLOCfi14qXZj0JWvgPpKeZpdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742400592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f3CF3UdUoe/ySTXFKSKClTZYWcZ5dr4XM27XFgv7WYE=;
	b=pSXToEV0KYvqqCQ960nqZtPvNAJl+CSF3Iz3NtlO1nDEaE7KeQ6sFJZjchvDjPd08NcOc2
	14ECsS0WL1VVA4Bw==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: kernel test robot <lkp@intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>, oe-kbuild-all@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	John Ogness <john.ogness@linutronix.de>, x86@kernel.org,
	x86-cpuid@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 18/29] x86/cacheinfo: Use enums for cache descriptor
 types
Message-ID: <Z9rsTirs9lLfEPD9@lx-t490>
References: <20250317164745.4754-19-darwi@linutronix.de>
 <202503192150.Vhannmnp-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202503192150.Vhannmnp-lkp@intel.com>

Hi,

On Wed, 19 Mar 2025, kernel test robot wrote:
>
> arch/x86/include/asm/cpuid/types.h:56:1: sparse: sparse:
>   static assertion failed: "sizeof(enum _cache_table_type) == 1"
>

I've checked the error report and reproduced it on my machine:

    https://download.01.org/0day-ci/archive/20250319/202503192150.Vhannmnp-lkp@intel.com/reproduce

After cloning sparse git repo and playing around with its validation test
suite, I've realized that it does not understand __attribiute__((packed))
on enums.

Namely, applying below diff on top of sparse's git repo:

    |  diff --git a/validation/enum-min-size.c b/validation/enum-min-size.c
    |  index e8bd9fb1..e691b332 100644
    |  --- a/validation/enum-min-size.c
    |  +++ b/validation/enum-min-size.c
    |  @@ -1,5 +1,9 @@
    |   enum i { I = 1 };
    |   _Static_assert(sizeof(enum i) == sizeof(int), "int");
    |  +
    |  +enum k { X = 0} __attribute__((packed));
    |  +_Static_assert(sizeof(enum k) == sizeof(char), "char");
    |  +
    |   enum u { U = 1U };
    |   _Static_assert(sizeof(enum u) == sizeof(int), "uint");

Then running the modified test:

    sparse/$ cd validation
    sparse/validation$ ./test-suite enum-min-size.c

leads to the same error:

    TEST    enum-min-size (enum-min-size.c)
    +enum-min-size.c:5:31: error: static assertion failed: "char"
    error: FAIL: test 'enum-min-size.c' failed

After checking other kernel code which have __packed on enums, I found
this at <linux/rw_hint.h>, which is included by core SCSI code:

    /* Sparse ignores __packed annotations on enums, hence the #ifndef below. */
    #ifndef __CHECKER__
    static_assert(sizeof(enum rw_hint) == 1);
    #endif

So I'll add a similar CPP guard (in v4, since I've already posted v3.)

Thanks!

--
Ahmed S. Darwish
Linutronix GmbH

