Return-Path: <linux-kernel+bounces-238239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8DA924752
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 20:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88B50B22F02
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 18:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B47158DD1;
	Tue,  2 Jul 2024 18:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3IIdxIq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005FA15B0FE
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 18:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719945156; cv=none; b=j34cSqf6UDuMpAMaT4z+n9HpPtRP6TkuklOuK2arAbUo7qb+x+twewPp0zRObQC/PscgoiTMQyFNvRm2ken4VhVYSKfdyjs/Tr7j06ul5ZV9kf9tJR8IbuvnppiwLRPF4crZvsPbrsUmseZgKVjQ7IxqmQB4cnffYTdN92gXysk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719945156; c=relaxed/simple;
	bh=Ijwt3t6RGj94zzsfSM5vtcMFHfqpvDdnYaHDUHFtmQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d6qW/kUmL7F4CBNeJ3Fe/mYZ2hGSw1iixlbUNu04Jb/MswcekYEcTedLtRlPCqCMnPR7+IPkGmrQoTCMEsNB+0vQ9qzzAkQp4WEgcccHEpjOxTj213TcLwHYn7Xkp5YHH2ERXQm9x8MBfpXXV+rBNdcETmO6MRDfwQ2Jk/09s+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3IIdxIq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89068C4AF10
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 18:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719945155;
	bh=Ijwt3t6RGj94zzsfSM5vtcMFHfqpvDdnYaHDUHFtmQQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=f3IIdxIqFIpP8qvlg04PCAIlEUgsWJaGzTtW2+nGFQn6VQNDTVeHbulbqrVWhWXlF
	 CxH014hxOtdWB63Es6Ry4e8AZzddS3MTxZYRGFH3WCsJifw8xYEiltf2qbzPmc54VJ
	 CkvcWag5590OWJwq4/yP3HrU8Ex5uCdyu7bayyI8+VJPhgzCgVkfQGepr6rWBjoiw5
	 KVoJDRoNmreQ0JemUbMQgjdeqJd7AxpGSAh/A33Jd2PWqEnZZ+46Pu0UrCxF5j3/zz
	 ohEO6lQ1J6ZZOPzmPxn7Rlqlyqqwx3UHAjeiLdCnsv1w6QA+Dw0v1H8sm+0uzpnOxu
	 7wUjOpm2SYPzg==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ee794ebffbso12216181fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 11:32:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUvBMHt+c5t4O2pJEXV6sICm2m+fbvnR4yNXlR3Y/aLiwFFFF78fUxtW5FT0MlBQmuHeYTq+uNtN0bVsmy/vdGd7YnA3066iC1RT9Va
X-Gm-Message-State: AOJu0YyiHJ2kbcB0rQtiVuDq73K2cQ2DXIN+M6tMWSHfULPE97P4gnvl
	1+AaBDnId0SVXy9pcCRKz3Rgxh52z8FC7Wiwsg+4AzsRNQsNmxyrj+LfBditQwPy0xZS70vYu8q
	STTnOsO/KmVt7AVBEctByj8D3p10=
X-Google-Smtp-Source: AGHT+IEFBdp2NYkhhGlphnnpgmJ2f9sJZsmLcRuohyYXagxlA5d9BR8Ije+vsuujrFjW6o26dBV9hPZMYy8cdvRMMEU=
X-Received: by 2002:a05:651c:a0c:b0:2ec:4d8a:785a with SMTP id
 38308e7fff4ca-2ee5e38002dmr88975241fa.4.1719945153840; Tue, 02 Jul 2024
 11:32:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520183633.1457687-1-steve.wahl@hpe.com> <20240613152826.GKZmsQGnO3OthLH3Vu@fat_crate.local>
 <ZmsbZCF9rFzuB3rO@swahl-home.5wahls.com> <20240616202533.GDZm9KPZtpDKw5aXWX@fat_crate.local>
 <ZnBR6MgS-jzjgA8A@swahl-home.5wahls.com> <20240621131742.GEZnV9dn_0XVH0IZ58@fat_crate.local>
 <ZnmNKAE5qT48yhrI@swahl-home.5wahls.com> <20240701142704.GGZoK8uDt-2VVtclHl@fat_crate.local>
 <20240702174425.GHZoQ8edlTfB1falcO@fat_crate.local>
In-Reply-To: <20240702174425.GHZoQ8edlTfB1falcO@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 2 Jul 2024 20:32:22 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGsjU5CpF655me1XNA8-5nbk3020vT2Bu5ZoFY25igovg@mail.gmail.com>
Message-ID: <CAMj1kXGsjU5CpF655me1XNA8-5nbk3020vT2Bu5ZoFY25igovg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Resolve problems with kexec identity mapping
To: Borislav Petkov <bp@alien8.de>
Cc: Steve Wahl <steve.wahl@hpe.com>, Ashish Kalra <ashish.kalra@amd.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-kernel@vger.kernel.org, Pavin Joseph <me@pavinjoseph.com>, 
	Eric Hagberg <ehagberg@gmail.com>, Simon Horman <horms@verge.net.au>, 
	Eric Biederman <ebiederm@xmission.com>, Dave Young <dyoung@redhat.com>, Sarah Brofeldt <srhb@dbc.dk>, 
	Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Yuntao Wang <ytcoode@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Joerg Roedel <jroedel@suse.de>, Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Jul 2024 at 19:45, Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Jul 01, 2024 at 04:27:04PM +0200, Borislav Petkov wrote:
> > On Mon, Jun 24, 2024 at 10:13:44AM -0500, Steve Wahl wrote:
> > > These accesses are a problem because they happen prior to establishing
> > > the page fault interrupt handler that would mend the identity map.  I
> > > know very little about the AMD SEV feature but reading the code I
> > > think it may be required to do this before setting up that handler.
> >
> > Yeah, from looking at it, we should be able to establish a #PF handler that
> > early too but the devil's in the detail, especially in that early boot code.
> >
> > Lemme poke some things and people...
>
> Ard, from EFI perspective and boot services exiting, do you see any potential
> issues if we enable a pagefault handler in load_stage1_idt() in
> arch/x86/boot/compressed/head_64.S already or is the EFI pagetable not really
> "reliable" then?
>

For the first boot, this shouldn't be needed - EFI maps all of RAM so
I wouldn't expect the PF handler to fire, except when writing to code
regions that were mapped ROX by the firmware. But even then, things
should just keep working, although from a security pov, it would be
better if the r/o regions remain r/o

> Would solve the issue in this thread where the EFI config table ends up not
> mapped on some hw configurations, elegantly...
>

The #PF handler makes sense when entering via the 32-bit entrypoint,
where the asm can only map the lower 4G and is in no position to
reason about where RAM lives.

For kexec on a 64-bit system, I would expect the high-level support
code to be capable of simply mapping all of DRAM 1:1, rather than
playing these games with #PF handlers and on-demand mapping.

