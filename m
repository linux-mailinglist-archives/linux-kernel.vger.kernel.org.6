Return-Path: <linux-kernel+bounces-420494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBE19D7BA6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 07:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16CD428226C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 06:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656EB17D354;
	Mon, 25 Nov 2024 06:47:11 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8B01E517
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 06:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732517231; cv=none; b=uXonjSlhRuwEX01jg4/Zyz59JftFHoRKm2O8x6ZyUC8HFKl6pPRkWuU+Yvu1/uwbQss5qmM1jS6jgqLHQjl4hdpWu+Q2otrKkFnXc5iShEQh/2cHrgMirC8Zjcb19brO5P/5cYM03Sp8ZeTvO3ocQ27DbMtnqjKSq1UoBFCHAdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732517231; c=relaxed/simple;
	bh=ze0c3DqCvty4zkPqtXq5b6wyAHZPx65vKhF8pzAOnmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hrWxjTWa2lnjZdxlgK+/iP1dUOQPLcPHi3ghxF+sr4KK7s2JJciLN+np3kCk0hmE70JinPh0NzZePSUj+ELb4QECLko+/sVvmfr2uFk9yc20AV4dLzYk/3bBtMry3r6zFlhDnpK1a06uuegFIfgkMDScwsRu5F22NBhehrRduSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A3ADF68D09; Mon, 25 Nov 2024 07:46:58 +0100 (CET)
Date: Mon, 25 Nov 2024 07:46:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>,
	Paul Webb <paul.x.webb@oracle.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Phil Auld <pauld@redhat.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Ramanan Govindarajan <ramanan.govindarajan@oracle.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nicky Veitch <nicky.veitch@oracle.com>
Subject: Re: [External] : Re: [bug-report] 5-9% FIO randomwrite ext4 perf
 regression on 6.12.y kernel
Message-ID: <20241125064658.GA14937@lst.de>
References: <392209D9-5AC6-4FDE-8D84-FB8A82AD9AEF@oracle.com> <0cfbfcf6-08f5-4d1b-82c4-729db9198896@nvidia.com> <d6049cd0-5755-48ee-87af-eb928016f95b@kernel.dk> <20241121113058.GA394828@pauld.westford.csb> <a01ead6b-bd1d-4cd3-ade6-59ad905273e7@kernel.dk> <181bcb70-e0bf-4024-80b7-e79276d6eaf7@oracle.com> <20241122121304.GA25877@lst.de> <188e08f4-2eb3-41ad-a331-63fd5bb0e7f6@oracle.com> <14F95ECE-2AB7-4A50-AE45-C98EC426312C@oracle.com> <Z0Dy8H0A3Wj45ZQn@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0Dy8H0A3Wj45ZQn@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Nov 22, 2024 at 02:09:04PM -0700, Keith Busch wrote:
> Could you instead try deleting the NVME_QUIRK_DEALLOCATE_ZEROES quirk
> for this device? The driver apparently uses this to assume you meant to
> do a Discard, but it sounds like the device wants an actual Write Zeroes
> command here.

From the logs it sounds like the device does not support the DSM command
at all.  Which is a bit weird, but might be an odd OEM firmware of some
kind.  If that's the case, the patch below should fix it:

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1a8d32a4a5c3..ca57086ba038 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2068,7 +2068,8 @@ static bool nvme_update_disk_info(struct nvme_ns *ns, struct nvme_id_ns *id,
 	lim->physical_block_size = min(phys_bs, atomic_bs);
 	lim->io_min = phys_bs;
 	lim->io_opt = io_opt;
-	if (ns->ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES)
+	if ((ns->ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES) &&
+	    (ns->ctrl->oncs & NVME_CTRL_ONCS_DSM))
 		lim->max_write_zeroes_sectors = UINT_MAX;
 	else
 		lim->max_write_zeroes_sectors = ns->ctrl->max_zeroes_sectors;

