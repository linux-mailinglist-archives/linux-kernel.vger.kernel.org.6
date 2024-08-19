Return-Path: <linux-kernel+bounces-291914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F229568D6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04A2F1C219CC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D4915DBC6;
	Mon, 19 Aug 2024 10:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZzSqXxF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17893165EF8;
	Mon, 19 Aug 2024 10:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724065167; cv=none; b=uT/hfTYRCrWRzcVUJQU9ueyPbX6X1tHw01HBKsRR0hEuCcqzg23gwiAOXlnABRLUgLxV/L3LUANLPFT+0YKiAhoj92Z9jWUs5jBLNcf38kFt2wbifvDZsRRTYR8+H/UQZaMMiPShxeEpSYrxqRlQTumJiJyWIh31qsSJJ7LmHTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724065167; c=relaxed/simple;
	bh=hlQRKMvIVi+Q0mKMmyy/v+wsbia93WzDYzawIplhG+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nvTsMxIz9WeLR67CG+zx35kDA5SgDinuYSlzV+E+15WhxkidiDLVCHXvvV3sRe52LROFr5DvZmYE/2kZt+GLp472OT9mp6Euk3JI58XgB9Tig8ToR9ePwyhKerS7imebmDuInlHgMMuG3Ipfzfh8zPZFrDD9ZUG3mFi8FOBNbTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZzSqXxF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92020C4AF09;
	Mon, 19 Aug 2024 10:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724065166;
	bh=hlQRKMvIVi+Q0mKMmyy/v+wsbia93WzDYzawIplhG+o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tZzSqXxF0hus3h2zJnJK0IiIhWFhqIE2EL5Z/ifJIoArC01d1+PP/DndklflaoHnG
	 rismGNWnrVRiG5aGvm6wTBqXlDlkhliJT/5MpUrA4YIvcZYR6lzFS4Df11qcA73tlJ
	 H/296WhgVF+z+pV3aT47M27w4GRpSeTcN50ZX2CytG5QC+uwFFHQJ75dYRcgUq6G8e
	 k5Fe3NflxLFRbkajXkcFsaQac4kNmLUKUKPx8bKt/bEpjpz7OMWaQgzJxGw5txJ+yh
	 YHfMNX6aLhjma81x7Hk46aaeGrCScK74HOM2sPFhSFFxR6X9VyG9EnAVbY6dqXVJft
	 hh6kLIhSU5YGA==
Message-ID: <b651ae17-0d60-46b5-9571-cf82769ab07c@kernel.org>
Date: Mon, 19 Aug 2024 19:59:24 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: pata_macio: Fix DMA table overflow
To: Michael Ellerman <mpe@ellerman.id.au>, cassel@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, hch@lst.de, linux-ppc@kolla.no,
 vidra@ufal.mff.cuni.cz
References: <20240819101755.489078-1-mpe@ellerman.id.au>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240819101755.489078-1-mpe@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/19/24 19:17, Michael Ellerman wrote:
> Kolbjørn and Jonáš reported that their 32-bit PowerMacs were crashing
> in pata-macio since commit 09fe2bfa6b83 ("ata: pata_macio: Fix
> max_segment_size with PAGE_SIZE == 64K").
> 
> For example:
> 
>   kernel BUG at drivers/ata/pata_macio.c:544!
>   Oops: Exception in kernel mode, sig: 5 [#1]
>   BE PAGE_SIZE=4K MMU=Hash SMP NR_CPUS=2 DEBUG_PAGEALLOC PowerMac
>   ...
>   NIP pata_macio_qc_prep+0xf4/0x190
>   LR  pata_macio_qc_prep+0xfc/0x190
>   Call Trace:
>     0xc1421660 (unreliable)
>     ata_qc_issue+0x14c/0x2d4
>     __ata_scsi_queuecmd+0x200/0x53c
>     ata_scsi_queuecmd+0x50/0xe0
>     scsi_queue_rq+0x788/0xb1c
>     __blk_mq_issue_directly+0x58/0xf4
>     blk_mq_plug_issue_direct+0x8c/0x1b4
>     blk_mq_flush_plug_list.part.0+0x584/0x5e0
>     __blk_flush_plug+0xf8/0x194
>     __submit_bio+0x1b8/0x2e0
>     submit_bio_noacct_nocheck+0x230/0x304
>     btrfs_work_helper+0x200/0x338
>     process_one_work+0x1a8/0x338
>     worker_thread+0x364/0x4c0
>     kthread+0x100/0x104
>     start_kernel_thread+0x10/0x14
> 
> That commit increased max_segment_size to 64KB, with the justification
> that the SCSI core was already using that size when PAGE_SIZE == 64KB,
> and that there was existing logic to split over-sized requests.
> 
> However with a sufficiently large request, the splitting logic causes
> each sg to be split into two commands in the DMA table, leading to
> overflow of the DMA table, triggering the BUG_ON().
> 
> With default settings the bug doesn't trigger, because the request size
> is limited by max_sectors_kb == 1280, however max_sectors_kb can be
> increased, and apparently some distros do that by default using udev
> rules.
> 
> Fix the bug for 4KB kernels by reverting to the old max_segment_size.
> 
> For 64KB kernels the sg_tablesize needs to be halved, to allow for the
> possibility that each sg will be split into two.
> 
> Fixes: 09fe2bfa6b83 ("ata: pata_macio: Fix max_segment_size with PAGE_SIZE == 64K")
> Cc: stable@vger.kernel.org # v6.10+
> Reported-by: Kolbjørn Barmen <linux-ppc@kolla.no>
> Closes: https://lore.kernel.org/all/62d248bb-e97a-25d2-bcf2-9160c518cae5@kolla.no/
> Reported-by: Jonáš Vidra <vidra@ufal.mff.cuni.cz>
> Closes: https://lore.kernel.org/all/3b6441b8-06e6-45da-9e55-f92f2c86933e@ufal.mff.cuni.cz/
> Tested-by: Kolbjørn Barmen <linux-ppc@kolla.no>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  drivers/ata/pata_macio.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
> index 1b85e8bf4ef9..eaffa510de49 100644
> --- a/drivers/ata/pata_macio.c
> +++ b/drivers/ata/pata_macio.c
> @@ -208,6 +208,19 @@ static const char* macio_ata_names[] = {
>  /* Don't let a DMA segment go all the way to 64K */
>  #define MAX_DBDMA_SEG		0xff00
>  
> +#ifdef CONFIG_PAGE_SIZE_64KB
> +/*
> + * The SCSI core requires the segment size to cover at least a page, so
> + * for 64K page size kernels it must be at least 64K. However the
> + * hardware can't handle 64K, so pata_macio_qc_prep() will split large
> + * requests. To handle the split requests the tablesize must be halved.
> + */
> +#define MAX_SEGMENT_SIZE SZ_64K
> +#define SG_TABLESIZE (MAX_DCMDS / 2)
> +#else
> +#define MAX_SEGMENT_SIZE MAX_DBDMA_SEG
> +#define SG_TABLESIZE MAX_DCMDS
> +#endif

These names are rather generic and could clash with some core layer ditions. So
maybe prefix the macro names with PATA_MACIO_ ?
Also please tab-align the values to make this a little easier to read.
Other than this, looks good to me.

>  
>  /*
>   * Wait 1s for disk to answer on IDE bus after a hard reset
> @@ -912,16 +925,10 @@ static int pata_macio_do_resume(struct pata_macio_priv *priv)
>  
>  static const struct scsi_host_template pata_macio_sht = {
>  	__ATA_BASE_SHT(DRV_NAME),
> -	.sg_tablesize		= MAX_DCMDS,
> +	.sg_tablesize		= SG_TABLESIZE,
>  	/* We may not need that strict one */
>  	.dma_boundary		= ATA_DMA_BOUNDARY,
> -	/*
> -	 * The SCSI core requires the segment size to cover at least a page, so
> -	 * for 64K page size kernels this must be at least 64K. However the
> -	 * hardware can't handle 64K, so pata_macio_qc_prep() will split large
> -	 * requests.
> -	 */
> -	.max_segment_size	= SZ_64K,
> +	.max_segment_size	= MAX_SEGMENT_SIZE,
>  	.device_configure	= pata_macio_device_configure,
>  	.sdev_groups		= ata_common_sdev_groups,
>  	.can_queue		= ATA_DEF_QUEUE,

-- 
Damien Le Moal
Western Digital Research


