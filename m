Return-Path: <linux-kernel+bounces-521615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D06B8A3BFEF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DF751887ABA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68821E378C;
	Wed, 19 Feb 2025 13:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="wQlZEMN+"
Received: from lamorak.hansenpartnership.com (lamorak.hansenpartnership.com [198.37.111.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9B61DDA36
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 13:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.37.111.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739971772; cv=none; b=GnzUleJ0DccPEBBNdHRxM6KzkhqCCq4KQHA03ySpDy7aofxHFCFcWUfvawD5qMKQi4HGw2Gwr/jDiw1DoIFGXrHkX75xXOLE+A3TTIvEZHP6IXSPn6FTctcwrP1tdzzM2HhdPIP4tHRsYlJAmLA6vRpgopwHv1Wq1C7uFKVN6Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739971772; c=relaxed/simple;
	bh=f3+RAkc3ZpUbZhOn5p6ZjFcH7X6q7BtO8Zhj5tMpTK8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iDhbQyJK47n3ib7Y6PxBs43VoecErOXk1jtrYhvpnKltNKczLAaAaRNeId2WfRm1B1ypZI2j6P8zO8LXW7nnHQek6kwWA7odAXq7H0kdUXIhsX+yEI+ti8SL7ZxEa7mXrABfmAx9AvpmoPgHrNm2jN9HtdKE8Waz0CPqLg5VR2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=wQlZEMN+; arc=none smtp.client-ip=198.37.111.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1739971767;
	bh=f3+RAkc3ZpUbZhOn5p6ZjFcH7X6q7BtO8Zhj5tMpTK8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=wQlZEMN+wn9UQ9Gl9OoF8N8h9sreUZL1tSeHY4zQ7xe5vpnYjGrCbLmyZDQ9Kopeh
	 5sNlNEb+01YMY3d76U4UjoP2qouebcVzYqq3PdO9Nr4sUILhI5o9yp+x1Vvp18laH7
	 okai5xyLM7PWN8TpVK3i2qZkPL+HsAxhMl/Wg6nI=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::db7])
	by lamorak.hansenpartnership.com (Postfix) with ESMTPSA id 6FCFE1C255A;
	Wed, 19 Feb 2025 08:29:27 -0500 (EST)
Message-ID: <cccce005fc19dc05caf67c454bd669d524c862bf.camel@HansenPartnership.com>
Subject: Re: [PATCH 0/4] tsm: Unified Measurement Register ABI for TVMs
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Dionna Amalie Glaze <dionnaglaze@google.com>, Dave Hansen
	 <dave.hansen@intel.com>
Cc: Dan Middleton <dan.middleton@linux.intel.com>, "Xing, Cedric"
 <cedric.xing@intel.com>, Dan Williams <dan.j.williams@intel.com>, "Kirill
 A. Shutemov" <kirill.shutemov@linux.intel.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,  x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, 
 linux-coco@lists.linux.dev, Kuppuswamy Sathyanarayanan
 <sathyanarayanan.kuppuswamy@linux.intel.com>
Date: Wed, 19 Feb 2025 08:29:26 -0500
In-Reply-To: <CAAH4kHYye2ApqYb3GmHSt2Ge4B1m55mA54Ch-f1RCzh3GZuHOw@mail.gmail.com>
References: <20250212-tdx-rtmr-v1-0-9795dc49e132@intel.com>
	 <15c69d57-4ffb-4ea1-8cbc-0ba6d3d7b14f@intel.com>
	 <be7e3c9d-208a-4bda-b8cf-9119f3e0c4ce@intel.com>
	 <015cdddb-7f74-4205-af8a-b15cad7ddc22@intel.com>
	 <d8f3eb33-d902-4391-adc7-005e4895b471@intel.com>
	 <c7894df2-2b27-4f67-b428-3eca312503f9@intel.com>
	 <c2cf2184-7753-454e-ac99-8c4f3c9c3d16@intel.com>
	 <01fc0997-a0e7-4086-b0aa-67b4a51b328a@intel.com>
	 <12ed2ab1-e97d-4a20-8370-8c60cabffc77@intel.com>
	 <ab2036d5-5b6f-4fa9-995a-fba63c0a5209@linux.intel.com>
	 <f4d344de-70c2-4fd4-bb18-2912cf0f3f98@intel.com>
	 <CAAH4kHYq7_3vLXQaCA7iKF+mC5Pg0cn-1FsB-iCbN7Jim9a-OQ@mail.gmail.com>
	 <650b6236-50d3-4932-b5bc-056fd29c93a7@intel.com>
	 <CAAH4kHYye2ApqYb3GmHSt2Ge4B1m55mA54Ch-f1RCzh3GZuHOw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2025-02-18 at 19:21 -0800, Dionna Amalie Glaze wrote:
> On Tue, Feb 18, 2025 at 4:41 PM Dave Hansen <dave.hansen@intel.com>
> wrote:
> > 
> > On 2/18/25 15:57, Dionna Amalie Glaze wrote:
> > > > If there are actual end users who care about this, it would be
> > > > great to see their acks on it as well.
> > > > 
> > > We would like to have this for Google Confidential Space and
> > > Kubernetes Engine.
> > > 
> > > Acked-by: Dionna Glaze <dionnaglaze@google.com>
> > 
> > Great! Thanks for chiming in. Can you talk for a second, though,
> > about why this is useful and how you plan to use it? Is it for
> > debugging?
> 
> Confidential space on SEV depends on the hypervisor-provided vTPM to
> provide remotely attestable quotes of its PCRs, and the corresponding
> event logs.
> https://github.com/google/go-tpm-tools/blob/main/launcher/agent/agent.go#L97
> 
> On TDX and ARM CCA (maybe RISC-V CoVE someday), we don't want to have
> to depend on the vTPM.

I still don't get why one of the goals seems to be to artificially
separate AMD Confidential Computing from Intel (and now Arm and RISC-
V).

> There are runtime measurement registers and the CCEL.
> When we have a sysfs interface to extend these registers, it makes
> the user space evidence manager's life easier.
> When Dan Williams forced the issue about configfs-tsm, we were told
> that it is bad for the kernel to have many platform-specific
> interfaces for attestation operations.
> This patch series is a way to unify behind the tsm.

You say "unify behind", but this proposal doesn't include AMD and it
could easily.  All these RTMR systems are simply subsets of a TPM
functionality with non-standard (and different between each of them)
quoting mechanisms.  The only real substantive difference between RTMR
systems and TPM2 is the lack of algorithm agility.  If everyone is
determined to repeat the mistakes of history, TPM2 can easily be
exposed with a pejorative algorithm, so it could fit into this
structure with whatever the chosen hash is and definitely should be so
the interface can really become a universal one applying to both Intel
*and* AMD.

The only real argument against adding a TPM that I've seen is that it
potentially expands the use beyond confidential VMs, which, in an
interface claiming to be universal, I think is actually a good thing. 
There are many non-CC use cases that would really like a non-repudiable
logging system.

Just on algorithm agility, could I make one more plea to add it to the
API before it's set in stone.  You might think sha384 will last
forever, but then that's what the TPM1 makers thought of sha1 and that
design decision hasn't been well supported by history.  The proposal is
here:

https://lore.kernel.org/linux-coco/86e6659bc8dd135491dc34bdb247caf05d8d2ad8.camel@HansenPartnership.com/

Worst case is I'm wrong and you're right and we have an additional
directory in the configfs tree (and you never get to see my tiktok I
told you so dance).  But if I'm right, we've got algorithm agility
(especially if post-quantum has some impact on hashes that hasn't been
foreseen) built in from the get go instead of having to be welded on
after the fact when we run into problems.

All I need at this stage is crypto agility in the configfs ABI.  I can
add vTPM code to that without anyone at Intel having to worry about it.

Regards,

James


