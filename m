Return-Path: <linux-kernel+bounces-428570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6B69E10B8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 02:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E142281B21
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 01:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AF2262A3;
	Tue,  3 Dec 2024 01:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SEPcGcz1"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9B010F2
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 01:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733188808; cv=none; b=Wi+uFhMfZcK/+xKoihJWQiLSJiEEwU7EgCLG/kLyQW2hg3+Oco7MXgcIkh+oGbciiIrhEwZDChWlqjizqrFrrAaIjI4LBvii3Ijr5rcK9vZkKuDESIqlB95+vtF+guOZCoetEgWuEB5psGtZtiSSwpbKmVEV4ICpg+FpL4dTD00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733188808; c=relaxed/simple;
	bh=4Ra7lJoBgJ2Yvzcalw2O2mV6cgfk9TtUsa05GESd904=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SOc1mW/mzEOqhZ/f0dFs9xAkPg4KBNzIgHwLR8nc/NjbdJc9uFRpOuzhypfPTMwtts58bLRD7+yOmn0F23wCSBoFSmi0BMQpQghYdEhL5zhwgve9XVzpg0oCIyedhJdhbylPj7bLNR1MuFZk+nAEK447au8pXua4RWRxg/Z+Z8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SEPcGcz1; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 2 Dec 2024 17:19:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733188800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G7tKWX1j0TJc1AZqeUpwVF9dIXqKxSoumxFecXZ6Pkk=;
	b=SEPcGcz1mSLl64Ld90WUSVmBIm4CdmjhLZaoqZ2AkGy6JQVaGDxUN9hZerEjBSl0dvpU4d
	kz0tYnceZbgEMGGOeJ7C55bjisVbgrxJKbcYHbAMkMJ2PY3RcYxCH5+DfEIJzD2ietZ9aX
	I/l43pcPt82s44XSi10PPdtVB8kMZ6k=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Vitaly Chikunov <vt@altlinux.org>
Cc: Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	james.morse@arm.com, linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org, mark.rutland@arm.com
Subject: Re: v6.13-rc1: Internal error: Oops - Undefined instruction:
 0000000002000000 [#1] SMP
Message-ID: <Z05cuuMMurzp1jx5@linux.dev>
References: <20241202045830.e4yy3nkvxtzaybxk@altlinux.org>
 <20241202153618.GA6834@willie-the-truck>
 <86ttbmt71k.wl-maz@kernel.org>
 <20241202155940.p267a3tz5ypj4sog@altlinux.org>
 <86ser6t6fs.wl-maz@kernel.org>
 <20241202223119.k3uod4ksnlf7gqh2@altlinux.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202223119.k3uod4ksnlf7gqh2@altlinux.org>
X-Migadu-Flow: FLOW_OUT

On Tue, Dec 03, 2024 at 01:31:19AM +0300, Vitaly Chikunov wrote:
> Marc,
> 
> On Mon, Dec 02, 2024 at 04:07:03PM +0000, Marc Zyngier wrote:
> > On Mon, 02 Dec 2024 15:59:40 +0000,
> > Vitaly Chikunov <vt@altlinux.org> wrote:
> > > 
> > > Marc,
> > > 
> > > On Mon, Dec 02, 2024 at 03:53:59PM +0000, Marc Zyngier wrote:
> > > >
> > > > What the log doesn't say is what the host is. Is it 6.13-rc1 as well?
> > > 
> > > No, host is 6.6.60.
> > 
> > Right. I wouldn't be surprised if:
> > 
> > - this v6.6 kernel doesn't hide the MPAM feature as it should (and
> >   that's proably something we should backport)
> 
> How to confirm this? Currently I cannot find any (case-insensitive)
> "MPAM" files in /sys, nor mpam string in /proc/cpuinfo, nor MPAM strings
> in `strace -v` (as it decodes some KVM ioctls) of qemu process.

If you can attach to the QEMU gdbstub of the VM, info registers will
dump ~everything.

If the value of ID_AA64PFR0_EL1.MPAM (bits 43:40) is nonzero then the
host KVM is erroneously advertising MPAM to the guest.

-- 
Thanks,
Oliver

