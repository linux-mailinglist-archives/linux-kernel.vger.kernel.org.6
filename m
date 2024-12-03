Return-Path: <linux-kernel+bounces-428693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 536B89E122B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 05:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A066282E1D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 04:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455DC148FED;
	Tue,  3 Dec 2024 04:03:55 +0000 (UTC)
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCEE224F0
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 04:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733198634; cv=none; b=fxn3nsTa1/E2/n4VY5vzeBFdnT50wmuW2C3xTiNa95KG0m1bJVBKxljWk/IndDs3a0Bt87UfiwqR/dfOL0e+fOuA+7mr3QTLedZhYupxMWoj4KC6wylJcjnRub378q3HTmM+jydwdIdUviFPR3HRFoGE8jPoq+wb/sV6BPvQknI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733198634; c=relaxed/simple;
	bh=rDiizQUE/yXLb41PumDxioqw5EGCdPok7nuTx80yqPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=elOJn/K0IW7PU/J/hqfdk4iNrdJXFeYon8pZo22B5ZndSoPBSo8zpU2o9+s8E9HKoAXgHN7ajAu8oOXboOBXHEGsQVpC1qn0Ne5QvdYq9XPKpys7LIasNmXu18RxQevvQw9fspZl0K8WtSsp7FHygF5UPoW3AZWJSqR3YIXY7D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 8F63272C90B;
	Tue,  3 Dec 2024 07:03:50 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
	by imap.altlinux.org (Postfix) with ESMTPSA id 810EE36D0178;
	Tue,  3 Dec 2024 07:03:50 +0300 (MSK)
Date: Tue, 3 Dec 2024 07:03:50 +0300
From: Vitaly Chikunov <vt@altlinux.org>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	james.morse@arm.com, linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org, mark.rutland@arm.com
Subject: Re: v6.13-rc1: Internal error: Oops - Undefined instruction:
 0000000002000000 [#1] SMP
Message-ID: <20241203040350.4soyvaeqs75kjqoj@altlinux.org>
References: <20241202045830.e4yy3nkvxtzaybxk@altlinux.org>
 <20241202153618.GA6834@willie-the-truck>
 <86ttbmt71k.wl-maz@kernel.org>
 <20241202155940.p267a3tz5ypj4sog@altlinux.org>
 <86ser6t6fs.wl-maz@kernel.org>
 <20241202223119.k3uod4ksnlf7gqh2@altlinux.org>
 <Z05cuuMMurzp1jx5@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <Z05cuuMMurzp1jx5@linux.dev>

Oliver, Marc,

On Mon, Dec 02, 2024 at 05:19:54PM -0800, Oliver Upton wrote:
> On Tue, Dec 03, 2024 at 01:31:19AM +0300, Vitaly Chikunov wrote:
> > Marc,
> > 
> > On Mon, Dec 02, 2024 at 04:07:03PM +0000, Marc Zyngier wrote:
> > > On Mon, 02 Dec 2024 15:59:40 +0000,
> > > Vitaly Chikunov <vt@altlinux.org> wrote:
> > > > 
> > > > Marc,
> > > > 
> > > > On Mon, Dec 02, 2024 at 03:53:59PM +0000, Marc Zyngier wrote:
> > > > >
> > > > > What the log doesn't say is what the host is. Is it 6.13-rc1 as well?
> > > > 
> > > > No, host is 6.6.60.
> > > 
> > > Right. I wouldn't be surprised if:
> > > 
> > > - this v6.6 kernel doesn't hide the MPAM feature as it should (and
> > >   that's proably something we should backport)
> > 
> > How to confirm this? Currently I cannot find any (case-insensitive)
> > "MPAM" files in /sys, nor mpam string in /proc/cpuinfo, nor MPAM strings
> > in `strace -v` (as it decodes some KVM ioctls) of qemu process.
> 
> If you can attach to the QEMU gdbstub of the VM, info registers will
> dump ~everything.
> 
> If the value of ID_AA64PFR0_EL1.MPAM (bits 43:40) is nonzero then the
> host KVM is erroneously advertising MPAM to the guest.

I don't find such register. There is what I get:

  (gdb) target remote :1234
  Remote debugging using :1234
  0x0000000040000000 in ?? ()

  (gdb) pipe i r | grep ID_AA64PFR

  ID_AA64PFR1_EL1 0x0                0
  ID_AA64PFR2_EL1_RESERVED 0x0       0
  ID_AA64PFR3_EL1_RESERVED 0x0       0
  ID_AA64PFR6_EL1_RESERVED 0x0       0
  ID_AA64PFR7_EL1_RESERVED 0x0       0
  (gdb)

This seems to be MPAM_frac, and it's 0, so "MPAM Extension not implemented"[1].

Thanks,

[1] https://developer.arm.com/documentation/ddi0595/2021-06/AArch64-Registers/ID-AA64PFR1-EL1--AArch64-Processor-Feature-Register-1?lang=en#fieldset_0-19_16

> 
> -- 
> Thanks,
> Oliver

