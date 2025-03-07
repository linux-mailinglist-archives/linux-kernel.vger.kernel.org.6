Return-Path: <linux-kernel+bounces-550615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C54D6A56207
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 08:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A739175C0F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 07:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C9B1A8F95;
	Fri,  7 Mar 2025 07:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="he2CqXxx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E575B1A3168
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 07:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741333909; cv=none; b=ejYw5S5fNRZ35NVCM5nuiF9t3oboMPtnhwf6n1XCKPgMcVYEQh8WJ70Uw4utPXLQwryB2i49UYG+WmmHXrQYPAMdLHWWdBSSfglYVMcblc8P9clvSUJZhcBzhLZTyc+9IOPYh87y1N1n+9aIlW7B2TuBYuKyAjs/K1UIjMy4qXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741333909; c=relaxed/simple;
	bh=F4i0GoYGir/9v+8oUXhoL089EGgJ8oe69PF12ReJouY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iG6ds1v4EKe7gVuHKZ9gNkjlTMEgdnnB0xzJd+MsYKEzDP5/ZKlyBqhKgzZgkdbgk7ByySXCXseT96ZdIxFWcP2YiiXzR6IlbTiSk9JhKl12O7VpcikKXAPkoW2R9s3xBhAShSSt2SRQUZezkWTC4GgAnPdHb+cLl7tc6pe4RXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=he2CqXxx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4CDEC4CED1;
	Fri,  7 Mar 2025 07:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741333908;
	bh=F4i0GoYGir/9v+8oUXhoL089EGgJ8oe69PF12ReJouY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=he2CqXxxR59UAosj9afHZ3nolMw9a64/Zp2ka+qPjetjig80Um1x52nhRNs6nb4kl
	 /626mIS2lebzdjHFWznHlgpbUnospoo9bfGE1UdmSFqq0tGS8JBZg56fZcZq1IZr2J
	 qeIMZpjLNS2xpu3eDaQB2iCWFN9/EgF2NAOgUyX1gZq4MdiWVbFj3AocY3OWKOr6Fi
	 93OZHLEzivxYHiqs2pO1WGU2GTxUpb2BYmzlSHoVywAhN4GyFvyhpy3m6bFMFjaHEu
	 gjgGNlJxhsD/KD692kjxp1ougMVIvY9xkYA9usFwNqMoDOzxr2+zx/za2J8ik+Oly7
	 KWxG6GZrD0Hww==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Keith Busch" <kbusch@kernel.org>
Cc: "Jens Axboe" <axboe@kernel.dk>,  "Christoph Hellwig" <hch@lst.de>,
  "Sagi Grimberg" <sagi@grimberg.me>,  <linux-nvme@lists.infradead.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [bug report] nvme: fio workload hangs on 16m random read
In-Reply-To: <Z8oKvwPd4UBY1awm@kbusch-mbp> (Keith Busch's message of "Thu, 06
	Mar 2025 13:51:11 -0700")
References: <87a59x6g5u.fsf@kernel.org>
	<6xoneGEavSMtUAvjbGdIem8Ul_-SpUQR6-PIpxUTiVpN2nyo_pMM7ytxJJ0gejZpCZGvXeAN3MfI0TwfcP3SbA==@protonmail.internalid>
	<Z8oKvwPd4UBY1awm@kbusch-mbp>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 07 Mar 2025 08:51:35 +0100
Message-ID: <87r0395ldk.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Keith Busch" <kbusch@kernel.org> writes:

> On Thu, Mar 06, 2025 at 09:46:37PM +0100, Andreas Hindborg wrote:
>> Hi All,
>>
>> My CI system has found an issue for the following fio workload:
>>
>> root@debian:~# insmod /mnt/v6.14-rc5-build/drivers/nvme/host/nvme-core.ko
>> root@debian:~# insmod /mnt/v6.14-rc5-build/drivers/nvme/host/nvme.ko poll_queues=1
>>
>> "fio" "--group_reporting" "--name=default" "--filename=/dev/nvme0n1"
>> "--readwrite=randread" "--blocksize=16777216" "--direct=1" "--numjobs=1"
>> "--ioengine=io_uring" "--iodepth=1" "--hipri=1" "--time_based=1"
>> "--runtime=3000"
>>
>> fio will hang, some times immediately, some times after a few minutes.
>>
>> I observed this on v6.14-rc1 and v6.14-rc5. It is not present in v6.13.
>>
>> Can any of you reproduce this? I was able to reproduce this on real
>> hardware and in qemu.
>
> Could you try adding this patch to your kernel?
>
> https://lore.kernel.org/io-uring/92b0a330-4782-45e9-8de7-3b90a94208c2@kernel.dk/

Thanks Keith, at first glance that seems to solve the issue. Will
restart my CI with this applied.


Best regards,
Andreas Hindborg



