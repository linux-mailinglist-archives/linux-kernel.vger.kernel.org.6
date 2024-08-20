Return-Path: <linux-kernel+bounces-293156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C12957B6B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 04:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CFC91F21BB3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 02:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF632AF1E;
	Tue, 20 Aug 2024 02:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="gwj4wl/0"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18ED0446D1;
	Tue, 20 Aug 2024 02:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724120927; cv=none; b=UCXCrui5U/za0Vk7BPberQNh+9Vpi3j9nNL/cMnnfQb/dE+lSPDR6cTJNkqhlzO3i3sYgLyNBNn+2lDt9BhyZkV3ZRepR4PH0NC6v2umuM+GkL98GQy6iybKhRDxgKThlsKPWXjak2enjHlAIw0g2fLyG0bXBxgBsYPZe0D8nNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724120927; c=relaxed/simple;
	bh=0RKsF157o3bKHtD19lzHYvs8hnVPCOMSKVn1abKcUyM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gTYSC5UMFcforAsA84m7cLCjyIqzKnKM2nhImWe7qdCKaIWuMZn2a8t+FpxpO/9qfY1Q70csFKJMRKajs7Bl8GA3laT2/Jjo6eg0XPMcLaXd9uEWfF+7Inlu3Qgz3dsfsRCm1u33uzhcYcG5YlQBJggUQUnjFBaiXKTWhXTHNW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=gwj4wl/0; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1724120922;
	bh=NPiOhm8IKIaayb+OQ2mU0VwOhYGdB0lFQCCi2+TtTDo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=gwj4wl/0Bl/hBHPv0AaRenGTc2wAJ0PB2CWQTbbuRiAG6ydYttXtHs6zpWfnP2yt5
	 KxztHLxRMaADnlMjFNT9evJ6SzPHI/pxBuk30e9m56MDIP3ZcoWjMW1dLT3QhkoUZu
	 yMHAhbj/lrAx0oN/dZNtG7RRN10vYZ/THx8ELK8rSuHtDqXtu5C/47tid3OiTdARyN
	 ySoYRo+oyjlU2G6B1NoRt3R/bFWEYf+IcqJHEg8w7benhsA0xNoQxnDKI75h1hNUY6
	 c7dXfcq1YofE33pC9IIfIDoC644BcGfmY3JPPERzZX5fMQtdUdVEejMuiYoviWlyxO
	 ijcQBEjBm17Mg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WntgW4MYRz4wcl;
	Tue, 20 Aug 2024 12:28:39 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Damien Le Moal <dlemoal@kernel.org>, cassel@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, hch@lst.de, linux-ppc@kolla.no,
 vidra@ufal.mff.cuni.cz
Subject: Re: [PATCH] ata: pata_macio: Fix DMA table overflow
In-Reply-To: <b651ae17-0d60-46b5-9571-cf82769ab07c@kernel.org>
References: <20240819101755.489078-1-mpe@ellerman.id.au>
 <b651ae17-0d60-46b5-9571-cf82769ab07c@kernel.org>
Date: Tue, 20 Aug 2024 12:28:38 +1000
Message-ID: <87ed6kszah.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Damien Le Moal <dlemoal@kernel.org> writes:
> On 8/19/24 19:17, Michael Ellerman wrote:
>> Kolbj=C3=B8rn and Jon=C3=A1=C5=A1 reported that their 32-bit PowerMacs w=
ere crashing
>> in pata-macio since commit 09fe2bfa6b83 ("ata: pata_macio: Fix
>> max_segment_size with PAGE_SIZE =3D=3D 64K").
>>=20
>> For example:
>>=20
>>   kernel BUG at drivers/ata/pata_macio.c:544!
>>   Oops: Exception in kernel mode, sig: 5 [#1]
>>   BE PAGE_SIZE=3D4K MMU=3DHash SMP NR_CPUS=3D2 DEBUG_PAGEALLOC PowerMac
>>   ...
>>   NIP pata_macio_qc_prep+0xf4/0x190
>>   LR  pata_macio_qc_prep+0xfc/0x190
>>   Call Trace:
>>     0xc1421660 (unreliable)
>>     ata_qc_issue+0x14c/0x2d4
>>     __ata_scsi_queuecmd+0x200/0x53c
>>     ata_scsi_queuecmd+0x50/0xe0
>>     scsi_queue_rq+0x788/0xb1c
>>     __blk_mq_issue_directly+0x58/0xf4
>>     blk_mq_plug_issue_direct+0x8c/0x1b4
>>     blk_mq_flush_plug_list.part.0+0x584/0x5e0
>>     __blk_flush_plug+0xf8/0x194
>>     __submit_bio+0x1b8/0x2e0
>>     submit_bio_noacct_nocheck+0x230/0x304
>>     btrfs_work_helper+0x200/0x338
>>     process_one_work+0x1a8/0x338
>>     worker_thread+0x364/0x4c0
>>     kthread+0x100/0x104
>>     start_kernel_thread+0x10/0x14
>>=20
>> That commit increased max_segment_size to 64KB, with the justification
>> that the SCSI core was already using that size when PAGE_SIZE =3D=3D 64K=
B,
>> and that there was existing logic to split over-sized requests.
>>=20
>> However with a sufficiently large request, the splitting logic causes
>> each sg to be split into two commands in the DMA table, leading to
>> overflow of the DMA table, triggering the BUG_ON().
>>=20
>> With default settings the bug doesn't trigger, because the request size
>> is limited by max_sectors_kb =3D=3D 1280, however max_sectors_kb can be
>> increased, and apparently some distros do that by default using udev
>> rules.
>>=20
>> Fix the bug for 4KB kernels by reverting to the old max_segment_size.
>>=20
>> For 64KB kernels the sg_tablesize needs to be halved, to allow for the
>> possibility that each sg will be split into two.
>>=20
>> Fixes: 09fe2bfa6b83 ("ata: pata_macio: Fix max_segment_size with PAGE_SI=
ZE =3D=3D 64K")
>> Cc: stable@vger.kernel.org # v6.10+
>> Reported-by: Kolbj=C3=B8rn Barmen <linux-ppc@kolla.no>
>> Closes: https://lore.kernel.org/all/62d248bb-e97a-25d2-bcf2-9160c518cae5=
@kolla.no/
>> Reported-by: Jon=C3=A1=C5=A1 Vidra <vidra@ufal.mff.cuni.cz>
>> Closes: https://lore.kernel.org/all/3b6441b8-06e6-45da-9e55-f92f2c86933e=
@ufal.mff.cuni.cz/
>> Tested-by: Kolbj=C3=B8rn Barmen <linux-ppc@kolla.no>
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> ---
>>  drivers/ata/pata_macio.c | 23 +++++++++++++++--------
>>  1 file changed, 15 insertions(+), 8 deletions(-)
>>=20
>> diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
>> index 1b85e8bf4ef9..eaffa510de49 100644
>> --- a/drivers/ata/pata_macio.c
>> +++ b/drivers/ata/pata_macio.c
>> @@ -208,6 +208,19 @@ static const char* macio_ata_names[] =3D {
>>  /* Don't let a DMA segment go all the way to 64K */
>>  #define MAX_DBDMA_SEG		0xff00
>>=20=20
>> +#ifdef CONFIG_PAGE_SIZE_64KB
>> +/*
>> + * The SCSI core requires the segment size to cover at least a page, so
>> + * for 64K page size kernels it must be at least 64K. However the
>> + * hardware can't handle 64K, so pata_macio_qc_prep() will split large
>> + * requests. To handle the split requests the tablesize must be halved.
>> + */
>> +#define MAX_SEGMENT_SIZE SZ_64K
>> +#define SG_TABLESIZE (MAX_DCMDS / 2)
>> +#else
>> +#define MAX_SEGMENT_SIZE MAX_DBDMA_SEG
>> +#define SG_TABLESIZE MAX_DCMDS
>> +#endif
>
> These names are rather generic and could clash with some core layer ditio=
ns. So
> maybe prefix the macro names with PATA_MACIO_ ?
> Also please tab-align the values to make this a little easier to read.
=20
OK.

> Other than this, looks good to me.

OK thanks, will send a v2.

cheers

