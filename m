Return-Path: <linux-kernel+bounces-285027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD8C950852
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 16:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADE81286E88
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA7919F46D;
	Tue, 13 Aug 2024 14:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eH410bYa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C97319B3D3;
	Tue, 13 Aug 2024 14:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723561184; cv=none; b=MIZh2tMUDexIvS+67EEIiZvipUCvySI3G6BlnRfmdiyCZjc/W20d6+tXhTTTYLPTdIDPNKi/TJuoZg08q9lR4gB4rmuQWNplM5mHypc/PMZ/i4cIxGJi3BiTrSsG+zhbIGoIbjTcXn9GH8KEbos2M/0hbsVaQ0cEkQeHwqt/oWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723561184; c=relaxed/simple;
	bh=qSfuUarH+bTINxI+kIHMwUvIA0drlUi4ImBMCpFBLUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3gce5dC4OPrU+TU0bc0I16uBqYb9+odYlGgUYfEs2lR+TNfS7hwN+0+hryUiXC2t7z/UOFCSIK6SyqPRdLk+M6Przx8DLCf1+kwKiTzqagUP/FTYJvL2cuOnKjdgr1pBNo4ercNN9MCW8gLiW8JBKXl24B4sp1jCANiCCVfZ0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eH410bYa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2948BC4AF09;
	Tue, 13 Aug 2024 14:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723561184;
	bh=qSfuUarH+bTINxI+kIHMwUvIA0drlUi4ImBMCpFBLUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eH410bYaPNBZz5UB7LoYId/0HGq6u6pa5CK+k4sL4pHLBSi8JgCU+dMQWzS6mYSTh
	 e2S5zxVPMclRjcZ19Msj58Zqe0wP0mo+5I86jGYfgmyr1vXRP1/z4bUddxJnKCP+wu
	 b5Ug8gLtA2cfMUCzyjD6jWWEN+vhayPCu8luW2u/pcI4wH9F2GK4DXGZp9Eqs5FQO4
	 hH1x853y/aMAcmy4wTC5VI4zbRYBslxRR+QFCdp5w3KGsS3ogn2cZmnPKwNS0nuPvP
	 4RMMpvca6Zr+eHG2F2b4Ecq94uJ4GkLsrY0n4TwOEjcRv658OmoRBxZFUT02j+Fqeb
	 LrnxNUTcieJlw==
Date: Tue, 13 Aug 2024 16:59:39 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: =?utf-8?B?S29sYmrDuHJu?= Barmen <linux-ppc@kolla.no>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org,
	=?utf-8?B?Sm9uw6HFoQ==?= Vidra <vidra@ufal.mff.cuni.cz>,
	Christoph Hellwig <hch@lst.de>, linux@roeck-us.net
Subject: Re: Since 6.10 - kernel oops/panics on G4 macmini due to change in
 drivers/ata/pata_macio.c
Message-ID: <Zrt028rSVT5hVPbU@ryzen.lan>
References: <62d248bb-e97a-25d2-bcf2-9160c518cae5@kolla.no>
 <3b6441b8-06e6-45da-9e55-f92f2c86933e@ufal.mff.cuni.cz>
 <Zrstcei9WN9sRfdX@x1-carbon.wireless.wdc>
 <87sev81u3f.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sev81u3f.fsf@mail.lhotse>

Hello Michael,

On Tue, Aug 13, 2024 at 10:32:36PM +1000, Michael Ellerman wrote:
> Niklas Cassel <cassel@kernel.org> writes:
> > Hello Jonáš, Kolbjørn,
> >
> > thank you for the report.
> >
> > On Tue, Aug 13, 2024 at 07:49:34AM +0200, Jonáš Vidra wrote:
> >> On Tue 13. Aug 2024 0:32:37 CEST, Kolbjørn Barmen wrote:
> >> > Ever since 6.10, my macmini G4 behaved unstable when dealing with lots of
> >> > I/O activity, such as sync'ing of Gentoo portage tree, unpacking kernel
> >> > source tarball, building large software packages (or kernel) etc.
> >> > 
> >> > After a bit of testing, and patient kernel rebuilding (while crashing) I
> >> > found the cuplit to be this commit/change
> >> > 
> >> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/diff/?id=09fe2bfa6b83f865126ce3964744863f69a4a030
> >> 
> >> I've been able to reproduce this pata_macio bug on a desktop PowerMac G4
> >> with the 6.10.3 kernel version. Reverting the linked change
> >> ("ata: pata_macio: Fix max_segment_size with PAGE_SIZE == 64K") makes
> >> the errors go away.
> >
> > Michael, as the author of the this commit, could you please look into
> > this issue?
> 
> I can. My commit was really just working around the warning in the SCSI
> core which appeared after afd53a3d8528, it was supposed to just fix the
> warning without changing behaviour. Though obviously it did for 4KB
> PAGE_SIZE kernels.
> 
> I don't have easy access to my mac-mini so it would be helpful if you
> can test changes Jonáš and/or Kolbjørn.
> 
> > We could revert your patch, which appears to work for some users,
> > but that would again break setups with PAGE_SIZE == 64K.
> > (I assume that Jonáš and Kolbjørn are not building with PAGE_SIZE == 64K.)
> 
> Yes they are using 4K, it says so in the oops.
> 
> >> ------------[ cut here ]------------
> >> kernel BUG at drivers/ata/pata_macio.c:544!
> >
> > https://github.com/torvalds/linux/blob/v6.11-rc3/drivers/ata/pata_macio.c#L544
> >
> > It seems that the
> > while (sg_len) loop does not play nice with the new .max_segment_size.
> 
> Right, but only for 4KB kernels for some reason. Is there some limit
> elsewhere that prevents the bug tripping on 64KB kernels, or is it just
> luck that no one has hit it?

Have your tried running fio (flexible I/O tester), with reads with a very
large block sizes?

I would be surprised if it isn't possible to trigger the same bug with
64K page size.

max segment size = 64K
MAX_DCMDS = 256
256 * 64K = 16 MiB
What happens if you run fio with a 16 MiB blocksize?

Something like:
$ sudo fio --name=test --filename=/dev/sdX --direct=1 --runtime=60 --ioengine=io_uring --rw=read --iodepth=4 --bs=16M


Kind regards,
Niklas

