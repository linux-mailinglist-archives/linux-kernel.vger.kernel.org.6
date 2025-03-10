Return-Path: <linux-kernel+bounces-553961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CE0A5912A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95F8016C660
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA6222686B;
	Mon, 10 Mar 2025 10:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="co7ImiSq"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C6122655F
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 10:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741602531; cv=none; b=ZiE+e6D6PFVVh2EZ6bLMvM5/G8HypsjJg3Op1zW/1dxTyCtG23fPeb5AHYAuppNAEEIYcIk29cSyqY+JQzi8WsLy0NWnXrXAXwdbUjtcfACEe5sMD/TcUwYYTXR9ZE8LehKPn3CoyyfA/29ZBBMG+jLEz8vX1vlOpyqfzXGM6DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741602531; c=relaxed/simple;
	bh=kLfnEMOXAxhAFecv9HaLPhaymuo+G/PKU83ccJFceLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGeZWk+y09TERXvR0IRObkKKKSUy5q3LqDB2+cVK92zF+SFowPzLRX8ifk+zfKKBNeoXfkD9Es4g50JQhL4vVisfzdZzzRxOq9Il1vO4RFuJrlThPw+ZsH77lVaXehXnTLlwWpZVFRyINYmG9hnMt89S5madUV4mEzePO0Y7w8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=co7ImiSq; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 4F01044F29;
	Mon, 10 Mar 2025 11:28:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1741602527;
	bh=kLfnEMOXAxhAFecv9HaLPhaymuo+G/PKU83ccJFceLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=co7ImiSqZPwgYs7VEgmBOb6mK5f8wwq0UQWAuQkpe1QtRkTVO8kZcn1G7LNsI1+34
	 40kQC+H+AROkoTQ+Le6cbSFO/htA0SpP8KZMsE+Q/1MlxfknYRezFAz85t3FgRI3K2
	 KyG34DA5MB/FIkZU3ODXjMvQZSTBcdBhXr28sOpLiU+8QvD4fvDkFWwoOBeFQa1HRo
	 zULELbSO6JQTUpT3ZNA1E7bkUPWxIfhCRAOChrQdx5DGJ7/rpfhIrdRtqVQxnUwDi6
	 ri+aRuWTU2XaC69Ld1XYPbDDurnudvskb/U4vUGkgkWa4QcZNggh0Sp5TxFmcIxbW5
	 sa60PWX3UvMWA==
Date: Mon, 10 Mar 2025 11:28:46 +0100
From: Joerg Roedel <joro@8bytes.org>
To: "Alexey Gladkov (Intel)" <alexey.gladkov@intel.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@intel.com>, Borislav Petkov <bp@alien8.de>,
	Joerg Roedel <jroedel@suse.de>, Ingo Molnar <mingo@kernel.org>,
	x86@kernel.org, hpa@zytor.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
	Larry.Dewey@amd.com
Subject: Re: [PATCH] x86/sev: Make SEV_STATUS available via SYSFS
Message-ID: <Z86-3n1-MArVLM9Z@8bytes.org>
References: <Z8g01YhM_FtdB5n6@gmail.com>
 <20250305113155.GCZ8g2K1XEdgynTA9D@fat_crate.local>
 <Z8g4sU_dsZgY0PuS@gmail.com>
 <20250305115035.GEZ8g6i7NTiSfkxk7J@fat_crate.local>
 <Z8hYEsHvwUwlOold@suse.de>
 <20250305153705.GKZ8hvoaz2GPt2rGtu@fat_crate.local>
 <b0cf4bfc-bf22-4986-9e76-62e3f54179ea@intel.com>
 <2koe2zg26fndx6d6jcmbg6dzybbgldgrjufupj74nvmav2dmqg@w6bknhosl64h>
 <Z8le_TWUJNebrfs7@8bytes.org>
 <Z8l66FFgPu5hWtuI@agladkov-desk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8l66FFgPu5hWtuI@agladkov-desk>

On Thu, Mar 06, 2025 at 11:37:28AM +0100, Alexey Gladkov (Intel) wrote:
> I was thinking to suggest something like that
> 
> /sys/firmware/coco/tdx/...
> /sys/firmware/coco/sev/...

So on a second thought I'd like to vote for the /sys/hypervisor/
hierarchy. The `firmware` term is a bit amibious here, the TDX module
can be seen as a kind of firmware for the guest OS, but realistically it
is more like another hypervisor sitting between KVM and the guest.

Also the settings on the SEV side that need to be exposed (VMPL and
SEV_STATUS) are CPU properties, but on the other side also set by some
form of hypervisor (either KVM/QEMU, the SVSM, or some other paravisor
in-between).

Overall /sys/hypervisor/ seems to be the best-fitting location for all
this data. To avoid ambiguation I propose:

	/sys/hypervisor/common/[coco/]tdx/
	/sys/hypervisor/common/[coco/]sev/

Using `common` makes it clear that this directory does not point to some
sort of Hypervisor, but to data common to all hypervisors. Using another
`coco` subdirectory is not necessary in my view, but if people think it
should exist I am fine with that.

Is this something we can agree on?

Regards,

	Joerg

