Return-Path: <linux-kernel+bounces-286569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2985951C9E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AA72B287B1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE3D1B374F;
	Wed, 14 Aug 2024 14:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2QHk+DR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20641B32A1;
	Wed, 14 Aug 2024 14:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723644407; cv=none; b=SsotddxmvsXUJotjIOI8HIXb2BMVZQIaXvgOMXFqEYGdlYnlurchvLR6UqHZCCkSgEHXZ7f/QCGb3JOs3vbSWxiNNahK2Al8O9DA8C1KxEnF6kp7vOq6nTjGsmM56nmxJnZqsV1EVKL1YXQfd20FVB9uvypCrYSBAKg+3ODKBF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723644407; c=relaxed/simple;
	bh=AGZAKlecmLZEHhHdoIyuP0KBetIGYeA3xA2HQiMjzTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9ihIMroTwwUEIep5oy8EOfMNiRXY1QMNU84EBueZmeCkt6R1Obo7kEwF2RU2YAc2mw4Ylf72VekwASL0ML98QL83GuQkXhmBT3PwS4xaq45qy2+7I1lnYE6iMAHaZbdrS1X5VrrCTSctW2t02F/h9tM8vGhQlf1VKs7MUiDpBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g2QHk+DR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66242C116B1;
	Wed, 14 Aug 2024 14:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723644407;
	bh=AGZAKlecmLZEHhHdoIyuP0KBetIGYeA3xA2HQiMjzTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g2QHk+DRt80uEPNhETIusk1gqul5VFfpYKmiwNTv/2DSjRyOqW8VwzEYXb7fKYxF9
	 JZ+KIvwRoiy7xp6WFksJqrGJndtiHUHHytT09pVvb9yFsvg8xkDnt4ta+V6mVmuD1l
	 yBTs/sm9UMaP7ODoPV7JkCEOf7TepnO0APbnd7dVCp4EUpGHfPIaIU1RLUtbwqlgnt
	 ohDdOzHsLGc6H1ffnQhwkaSGg5nwoWpIWUSXgeTwW0nkMK5yBcc7JljkQB3LskKBLa
	 IVnjIu2fGvxOFWXKwDuvfq1b99Vte6IGI0xfAufOXfJkEYry93JSae+1iFEO2/QaA9
	 Ck5+tS4eyQLLA==
Date: Wed, 14 Aug 2024 16:06:42 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: =?utf-8?B?S29sYmrDuHJu?= Barmen <linux-ppc@kolla.no>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org,
	=?utf-8?B?Sm9uw6HFoQ==?= Vidra <vidra@ufal.mff.cuni.cz>,
	Christoph Hellwig <hch@lst.de>, linux@roeck-us.net
Subject: Re: Since 6.10 - kernel oops/panics on G4 macmini due to change in
 drivers/ata/pata_macio.c
Message-ID: <Zry58qB80V80uS38@ryzen.lan>
References: <62d248bb-e97a-25d2-bcf2-9160c518cae5@kolla.no>
 <3b6441b8-06e6-45da-9e55-f92f2c86933e@ufal.mff.cuni.cz>
 <Zrstcei9WN9sRfdX@x1-carbon.wireless.wdc>
 <87sev81u3f.fsf@mail.lhotse>
 <Zrt028rSVT5hVPbU@ryzen.lan>
 <87jzgj1ejc.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87jzgj1ejc.fsf@mail.lhotse>

On Wed, Aug 14, 2024 at 10:20:55PM +1000, Michael Ellerman wrote:
> Niklas Cassel <cassel@kernel.org> writes:
> > On Tue, Aug 13, 2024 at 10:32:36PM +1000, Michael Ellerman wrote:
> >> Niklas Cassel <cassel@kernel.org> writes:
> >> > On Tue, Aug 13, 2024 at 07:49:34AM +0200, Jonáš Vidra wrote:
> ...
> >> >> ------------[ cut here ]------------
> >> >> kernel BUG at drivers/ata/pata_macio.c:544!
> >> >
> >> > https://github.com/torvalds/linux/blob/v6.11-rc3/drivers/ata/pata_macio.c#L544
> >> >
> >> > It seems that the
> >> > while (sg_len) loop does not play nice with the new .max_segment_size.
> >> 
> >> Right, but only for 4KB kernels for some reason. Is there some limit
> >> elsewhere that prevents the bug tripping on 64KB kernels, or is it just
> >> luck that no one has hit it?
> >
> > Have your tried running fio (flexible I/O tester), with reads with a very
> > large block sizes?
> >
> > I would be surprised if it isn't possible to trigger the same bug with
> > 64K page size.
> >
> > max segment size = 64K
> > MAX_DCMDS = 256
> > 256 * 64K = 16 MiB
> > What happens if you run fio with a 16 MiB blocksize?
> >
> > Something like:
> > $ sudo fio --name=test --filename=/dev/sdX --direct=1 --runtime=60 --ioengine=io_uring --rw=read --iodepth=4 --bs=16M
> 
> Nothing interesting happens, fio succeeds.
> 
> The largest request that comes into pata_macio_qc_prep() is 1280KB,
> which results in 40 DMA list entries.
> 
> I tried with a larger block size but it doesn't change anything. I guess
> there's some limit somewhere else in the stack?
> 
> That was testing on qemu, but I don't think it should matter?
> 
> I guess there's no way to run the fio test against a file, ie. without a
> raw partition? My real G5 doesn't have any spare disks/partitions in it.


You can definitely run fio against a file.

e.g.
$ dd if=/dev/random of=/tmp/my_file bs=1M count=1024

$ sudo fio --name=test --filename=/tmp/my_file --direct=1 --runtime=60 --ioengine=io_uring --rw=read --iodepth=4 --bs=16M


Perhaps try with 32M block size, so that it is larger than
max segment size = 64K
MAX_DCMDS = 256
256 * 64K = 16 MiB

Perhaps also try with and without --direct.
It could be interesting to use the page cache if you do --rw=readwrite
that might possibly result in larger bios.


Kind regards,
Niklas

