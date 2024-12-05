Return-Path: <linux-kernel+bounces-433437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6429E5867
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 005331683D0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 14:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64EC21A42B;
	Thu,  5 Dec 2024 14:21:50 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3878520D4E9;
	Thu,  5 Dec 2024 14:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733408510; cv=none; b=hfpAuEKSd0JEfnR7cuGvFTD1j0Vz5WdDDrqyeMqLE9VlYvnPy76Y+nyK83boVEPpS+OjoaulQxkVg+niRpa7ET28LjOHN16JscrWa6tv1828KWIyCKIfvI/8p81LPF9BHp2UDz3dXJXKGFM2uPqxOOlcWICrKmmnqvSNp/fQDZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733408510; c=relaxed/simple;
	bh=v7/MPZWkSYB1uJDNwAY/gzTAWOJj8JxYvrepuFBC4R8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jludfGLLZPHKJferpu3iA7atsf16atPameKYjC5M+tx8usYLp9SgH5hCRjZUExet6j9rdBsyYcAlrdaD5BGumBqwK9EePD/ad0Xi2jN3EUHDJi9YhBvPNfFX6G52IMzn0u0ui1xw6SygoMtkEzfWyO32WlZSLgbw2OpIa4eDx08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tJCjC-000000001Y6-0CP3;
	Thu, 05 Dec 2024 09:21:14 -0500
Message-ID: <f2f996fb5ee503512fbabd7496cc7498ecb2cdb2.camel@surriel.com>
Subject: Re: [tip:x86/mm] [x86/mm/tlb]  209954cbc7:
 WARNING:at_arch/x86/mm/tlb.c:#flush_tlb_func
From: Rik van Riel <riel@surriel.com>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org, 
	x86@kernel.org, Ingo Molnar <mingo@kernel.org>, Dave Hansen
 <dave.hansen@intel.com>,  Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Mel Gorman	 <mgorman@suse.de>
Date: Thu, 05 Dec 2024 09:21:13 -0500
In-Reply-To: <202412051551.690e9656-lkp@intel.com>
References: <202412051551.690e9656-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: riel@surriel.com

On Thu, 2024-12-05 at 16:43 +0800, kernel test robot wrote:
>=20

> [=C2=A0 210.338271][ T4668] ------------[ cut here ]------------
> [ 210.343902][ T4668] WARNING: CPU: 38 PID: 4668 at
> arch/x86/mm/tlb.c:815 flush_tlb_func (arch/x86/mm/tlb.c:815)

Huh, this is the warning below:

       WARN_ON_ONCE(local_tlb_gen > mm_tlb_gen);

This cannot happen on remote CPUs, because they
will check whether f->mm !=3D loaded_mm, but with
my patches it can happen on the _local_ CPU, if:

The current CPU:
- Is in the mm_cpumask for another mm
- Tries to flush the TLB for that other mm
- Calls flush_tlb_func locally with f->mm being
  that other mm.

It should be a fairly easy fix, pulling the
/* Can only happen on remote CPUs */ thing
out from the !local condition, since it can
now happen locally :)

I'll send a fix in a little bit.

--=20
All Rights Reversed.

