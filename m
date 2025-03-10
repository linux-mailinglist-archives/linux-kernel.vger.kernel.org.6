Return-Path: <linux-kernel+bounces-554079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7FFA592B2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DCD83AE468
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5738F22155C;
	Mon, 10 Mar 2025 11:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dw/9mUhE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A6921E0B2
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 11:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741605848; cv=none; b=Fkn1aW4A+xkBv8O2kLmsX/DxGWaPINW5uKi61AW+kABElAkwMGv+OM45JJI7tI+ruaItnb0eo7WdHimLQ5cESotRkLR2t6tK3/47XYjFKwp1yudBnW2cskegTHy8PBZTTxDvSOi92ngFQCxzChfWybTsNZu7KTGOWIzOiSkshOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741605848; c=relaxed/simple;
	bh=OVxeJv8tEguFEVHqMcAK9wTwDs4k5rlSLED7iFr0Ai8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MaaLkKjX9iMvcXH1jAdPwshwwMHk2m2Htt3fepi47RB9wbClqYHD6bXTXeSguoUv1ORBnqOxbb2FQm9Cycq+c9pSs9NqOdrk52hjxwZEE/aUaamikrfJD6WH7vxJqFjrlER0dGy99U18oFuaMrt53jcri85xRe5nmwUVgVsea1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dw/9mUhE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ECA7C4CEE5;
	Mon, 10 Mar 2025 11:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741605848;
	bh=OVxeJv8tEguFEVHqMcAK9wTwDs4k5rlSLED7iFr0Ai8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dw/9mUhEUOhGBFF0e+TPWemhtnjvHh4R14Dw8OUmhe4HMdMK0vLyJeCdDoJzaUwtw
	 0v7LpCP0T9ppOPb2fnLRQZW0b8xrYJpO5ARSMWlUgdK2WHZTTq9Z4umoKWs1y6NRVn
	 /oSFCS01Bkb8B44E23L9+X0hkRjrxgIVHD7Xfx6RP+tlu9mHOmAEILh46F94UHiuok
	 cf8sgLt8qYWXeYDyKtSFSiWOhVvAwvbZsXazHVaadpUnEAwkxbuBkJGDlyJRurkoDU
	 370DHpiqb5GhAd8WYFJrw41+zSaojRNtsgik0I12VotP+Ur40t0nUXZSd5gjKU7eHz
	 LXrxFnMG7ClaA==
Date: Mon, 10 Mar 2025 12:24:01 +0100
From: Alexey Gladkov <legion@kernel.org>
To: Joerg Roedel <joro@8bytes.org>
Cc: "Alexey Gladkov (Intel)" <alexey.gladkov@intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@intel.com>, Borislav Petkov <bp@alien8.de>,
	Joerg Roedel <jroedel@suse.de>, Ingo Molnar <mingo@kernel.org>,
	x86@kernel.org, hpa@zytor.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
	Larry.Dewey@amd.com
Subject: Re: [PATCH] x86/sev: Make SEV_STATUS available via SYSFS
Message-ID: <Z87L0bRi8tcAIsDw@example.org>
References: <20250305113155.GCZ8g2K1XEdgynTA9D@fat_crate.local>
 <Z8g4sU_dsZgY0PuS@gmail.com>
 <20250305115035.GEZ8g6i7NTiSfkxk7J@fat_crate.local>
 <Z8hYEsHvwUwlOold@suse.de>
 <20250305153705.GKZ8hvoaz2GPt2rGtu@fat_crate.local>
 <b0cf4bfc-bf22-4986-9e76-62e3f54179ea@intel.com>
 <2koe2zg26fndx6d6jcmbg6dzybbgldgrjufupj74nvmav2dmqg@w6bknhosl64h>
 <Z8le_TWUJNebrfs7@8bytes.org>
 <Z8l66FFgPu5hWtuI@agladkov-desk>
 <Z86-3n1-MArVLM9Z@8bytes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z86-3n1-MArVLM9Z@8bytes.org>

On Mon, Mar 10, 2025 at 11:28:46AM +0100, Joerg Roedel wrote:
> On Thu, Mar 06, 2025 at 11:37:28AM +0100, Alexey Gladkov (Intel) wrote:
> > I was thinking to suggest something like that
> > 
> > /sys/firmware/coco/tdx/...
> > /sys/firmware/coco/sev/...
> 
> So on a second thought I'd like to vote for the /sys/hypervisor/
> hierarchy. The `firmware` term is a bit amibious here, the TDX module
> can be seen as a kind of firmware for the guest OS, but realistically it
> is more like another hypervisor sitting between KVM and the guest.
> 
> Also the settings on the SEV side that need to be exposed (VMPL and
> SEV_STATUS) are CPU properties, but on the other side also set by some
> form of hypervisor (either KVM/QEMU, the SVSM, or some other paravisor
> in-between).
> 
> Overall /sys/hypervisor/ seems to be the best-fitting location for all
> this data. To avoid ambiguation I propose:
> 
> 	/sys/hypervisor/common/[coco/]tdx/
> 	/sys/hypervisor/common/[coco/]sev/

The /sys/hypervisor requires CONFIG_SYS_HYPERVISOR=y. Now, this parameter
is not required for the minimum TDX guest configuration.

As I can see right now [1] this directory is used exclusively by xen team.
It's part of their ABI stable. I'm not sure we can go in there.

/sys/hypervisor/compilation/compile_date
/sys/hypervisor/compilation/compiled_by
/sys/hypervisor/compilation/compiler
/sys/hypervisor/properties/capabilities
/sys/hypervisor/properties/changeset
/sys/hypervisor/properties/features
/sys/hypervisor/properties/pagesize
/sys/hypervisor/properties/virtual_start
/sys/hypervisor/type
/sys/hypervisor/uuid
/sys/hypervisor/version/extra
/sys/hypervisor/version/major
/sys/hypervisor/version/minor
/sys/hypervisor/start_flags/*
/sys/hypervisor/guest_type
/sys/hypervisor/pmu/pmu_mode
/sys/hypervisor/pmu/pmu_features
/sys/hypervisor/properties/buildid

[1] Documentation/ABI/stable/sysfs-hypervisor-xen

> Using `common` makes it clear that this directory does not point to some
> sort of Hypervisor, but to data common to all hypervisors. Using another
> `coco` subdirectory is not necessary in my view, but if people think it
> should exist I am fine with that.
> 
> Is this something we can agree on?
> 
> Regards,
> 
> 	Joerg

-- 
Rgrds, legion


