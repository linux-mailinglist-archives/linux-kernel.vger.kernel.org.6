Return-Path: <linux-kernel+bounces-418753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E5C9D653B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 22:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C163282BC2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 21:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85EE185935;
	Fri, 22 Nov 2024 21:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ioe1YIOO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE6F4A0C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 21:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732309748; cv=none; b=M5o9aI1Tx3Pd4+z9waTRUKPX6i19IxI4LYtJ7AV6mpb7l+OeVqSt3pENNvHbL1OHfL0mazETpZnKDUGPOtcKyBOXhv7gbhlzd0Tz5Gi2Aj1Pb8/20OXNRuioXSwHEN8uDCYAEj6odZSc1WdMENa/N8funIz5fk5Jtc4r/vBfZQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732309748; c=relaxed/simple;
	bh=zeo9E58IJwopEbyH4KMEk8UyvZ6VvHKNIKWK1GklwMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IdgahHDG6We6qsfHAHDn87S6ZGw+5lXRPRnJEgy0BJvqSx0q9MTlXJcZaNDcYGFjbtYSOxLLkBh57a09CTiXmOy18JIFxYSpuFzY2Ewd83HSgui1A7KLAfn/7X3d7s/Q8+8PPPppSPKfQPACV1CJJp30WWb5j4JRgZoj2D07qJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ioe1YIOO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 996E2C4CECE;
	Fri, 22 Nov 2024 21:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732309747;
	bh=zeo9E58IJwopEbyH4KMEk8UyvZ6VvHKNIKWK1GklwMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ioe1YIOOXk1orgEFpo+uwpfVdTnl2sYch4yvR51Lsno2C95n+JF0efE9X5WbFyfSM
	 Rmq77Crh2KFozPb57/Eu4BLq/uwbdlu0hpP+mgfRc+inueyzz07nwhE3eS8AyRyxEs
	 nV4ShmSTi7ESXIzbgZAGDGMKSiBQreqqcNEiZVFwn5fldvyOz7vXy/ue30A8eNI1Bq
	 fDL27TdeuFXJe7KfAB4I8xPtfTd51yKEnJgNSB5TbNs0BXQcYsyA+tK+j4f5mK74F5
	 VcprUrNxQV6Jt+2U32J9MfiUdEfvoEI4nC2CYZMKGrlq+XLNWvyRdyumcaAalTtoUO
	 vtYOLqfdMLDrQ==
Date: Fri, 22 Nov 2024 14:09:04 -0700
From: Keith Busch <kbusch@kernel.org>
To: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Cc: Paul Webb <paul.x.webb@oracle.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Phil Auld <pauld@redhat.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Ramanan Govindarajan <ramanan.govindarajan@oracle.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nicky Veitch <nicky.veitch@oracle.com>
Subject: Re: [External] : Re: [bug-report] 5-9% FIO randomwrite ext4 perf
 regression on 6.12.y kernel
Message-ID: <Z0Dy8H0A3Wj45ZQn@kbusch-mbp.dhcp.thefacebook.com>
References: <392209D9-5AC6-4FDE-8D84-FB8A82AD9AEF@oracle.com>
 <0cfbfcf6-08f5-4d1b-82c4-729db9198896@nvidia.com>
 <d6049cd0-5755-48ee-87af-eb928016f95b@kernel.dk>
 <20241121113058.GA394828@pauld.westford.csb>
 <a01ead6b-bd1d-4cd3-ade6-59ad905273e7@kernel.dk>
 <181bcb70-e0bf-4024-80b7-e79276d6eaf7@oracle.com>
 <20241122121304.GA25877@lst.de>
 <188e08f4-2eb3-41ad-a331-63fd5bb0e7f6@oracle.com>
 <14F95ECE-2AB7-4A50-AE45-C98EC426312C@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <14F95ECE-2AB7-4A50-AE45-C98EC426312C@oracle.com>

On Fri, Nov 22, 2024 at 06:26:46PM +0000, Saeed Mirzamohammadi wrote:
> FYI, Tried disabling write zeros but still getting the same errors:
> [ 326.097275] operation not supported error, dev nvme2n1, sector 10624 op 0x9:(WRITE_ZEROES) flags 0x800 phys_seg 0 prio class 0
> [ 338.496217] nvme0n1: Dataset Management(0x9) @ LBA 10928, 256 blocks, Invalid Command Opcode (sct 0x0 / sc 0x1) DNR
> ... 
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index d3bde17c818d5..ad2ce6008062e 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3425,7 +3425,8 @@ static const struct pci_device_id nvme_id_table[] = {
>                 .driver_data = NVME_QUIRK_STRIPE_SIZE |
>                                 NVME_QUIRK_DEALLOCATE_ZEROES |
>                                 NVME_QUIRK_IGNORE_DEV_SUBNQN |
> -                               NVME_QUIRK_BOGUS_NID, },
> +                               NVME_QUIRK_BOGUS_NID |
> +                               NVME_QUIRK_DISABLE_WRITE_ZEROES, },
>         { PCI_VDEVICE(INTEL, 0x0a55),   /* Dell Express Flash P4600 */
>                 .driver_data = NVME_QUIRK_STRIPE_SIZE |
>                                 NVME_QUIRK_DEALLOCATE_ZEROES, },

Could you instead try deleting the NVME_QUIRK_DEALLOCATE_ZEROES quirk
for this device? The driver apparently uses this to assume you meant to
do a Discard, but it sounds like the device wants an actual Write Zeroes
command here.

