Return-Path: <linux-kernel+bounces-249516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 743DB92EC9F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 18:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ACA7284D11
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 16:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27A816CD21;
	Thu, 11 Jul 2024 16:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="VQUsvQdw"
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52FA8F72
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 16:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720715122; cv=none; b=td13F4MKsVHdGjiea/SXDUS3aniDqSMAvtg8q5FY6vUZKFNtmsjd9luIeou3d0aqW5sOTTd4r+gH+hq1VsTFG5zLntvwFwR8nNW/eM1AeWFnEON+Xg0Hw3HG3W60ZHGYqFNu2bPiLuz9ptR4qzvVhXWBQxvIiNNfMIxIf3TqsCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720715122; c=relaxed/simple;
	bh=by8drg7BkwyPqnnrBo9joy/euqUdnROj+pyxhwVy4W4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UZ+NrP+wEruYYem5WSksX+61sUOMkHFQknAJAR5zBFZ8Rny0t5q7ga++G+kXk9kpsn5OzZYCS3wu65PCyXl7M2+u6fDU28XCRSgqV+ekomvR55h5X56o2lJYphlsW71OMJTKfBSFT/Sx0GEkkV5TqUMa6iMuk1KzFg0kfYTfF/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=VQUsvQdw; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5005a.ext.cloudfilter.net ([10.0.29.234])
	by cmsmtp with ESMTPS
	id RcWKsVIKhumtXRwbZs3wXL; Thu, 11 Jul 2024 16:25:13 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id RwbYsddx9eCxMRwbYsS1Ho; Thu, 11 Jul 2024 16:25:13 +0000
X-Authority-Analysis: v=2.4 cv=M/yGKDws c=1 sm=1 tr=0 ts=66900769
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=4kmOji7k6h8A:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=Q-fNiiVtAAAA:8 a=bLk-5xynAAAA:8 a=yPCof4ZbAAAA:8
 a=4U04rXiFe3vrU3-RqrIA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=Fp8MccfUoT0GBdDC_Lng:22 a=zSyb8xVVt2t83sZkrLMb:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=l7dJmZsHDRRtYA6jqLTJ+nJTV8ksdPp6ErT4krrc1nI=; b=VQUsvQdwHQbARSRkuj05QVoX1J
	uJiaTp1lX5LbB6yQ+4o/kEOEpJxWlsa5XN+nLLs+ulsGCK3w2HcJ4bHcj3vsHQ/FZZIrhv3OewiwY
	tmj/Vzx80+thZO5Sr6krZP0XI6n27La08d1CuyLn+1f8wjrO7xbFw6VeLFLqK5qruCll7jrVPGccJ
	7j5v0YLDW66bIwlCjIAvTyIi6zT5KBNm33z2EnblaJP5ja6i2wt+yMSH0aX4sJ7i7Q355q/2Hxetr
	SnDcHtPDF00Ndt30X5OUH4Yb5Pnc3uAoniz1PiajjUnpPQYaIPBV3cI4mwx4zm8WN3qz1rGJfkY1O
	paLQh4uQ==;
Received: from [201.172.173.139] (port=55644 helo=[192.168.15.4])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sRwbX-0002St-0G;
	Thu, 11 Jul 2024 11:25:11 -0500
Message-ID: <8381a68e-5dcd-454a-bca3-d00bb0420a28@embeddedor.com>
Date: Thu, 11 Jul 2024 10:25:09 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] scsi: mpi3mr: struct mpi3_sas_io_unit_page1: Replace
 1-element array with flexible array
To: Kees Cook <kees@kernel.org>,
 Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>
Cc: Kashyap Desai <kashyap.desai@broadcom.com>,
 Sumit Saxena <sumit.saxena@broadcom.com>,
 Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Ranjan Kumar <ranjan.kumar@broadcom.com>, mpi3mr-linuxdrv.pdl@broadcom.com,
 linux-scsi@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240711155446.work.681-kees@kernel.org>
 <20240711155637.3757036-4-kees@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240711155637.3757036-4-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.139
X-Source-L: No
X-Exim-ID: 1sRwbX-0002St-0G
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.4]) [201.172.173.139]:55644
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 44
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHq9/fc8wHAsZpYquev95jqOd6fD+jVXXesr2lj5aWfMg7JQaT11e4xk0a8S+FWs3XSuw+5+TnaM/8RemHazQRb0bJcyydxmRrPP7EUyrglg0QHeNqrw
 lrtUVQc8WORjHKtIIHdCXDIEW0HgFljJ8DKDCitFY3aevxIkYw8ATQ0whvdqdPA//nfvrCHqFZxD1/iWKqwfgYkxLDo1dxQRCzHqvCnaN+u0fO/4ARRPwrlB



On 11/07/24 09:56, Kees Cook wrote:
> Replace the deprecated[1] use of a 1-element array in
> struct mpi3_sas_io_unit_page1 with a modern flexible array.
> 
> No binary differences are present after this conversion.
> 
> Link: https://github.com/KSPP/linux/issues/79 [1]
> Signed-off-by: Kees Cook <kees@kernel.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
> Cc: Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>
> Cc: Kashyap Desai <kashyap.desai@broadcom.com>
> Cc: Sumit Saxena <sumit.saxena@broadcom.com>
> Cc: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: Ranjan Kumar <ranjan.kumar@broadcom.com>
> Cc: mpi3mr-linuxdrv.pdl@broadcom.com
> Cc: linux-scsi@vger.kernel.org
> ---
>   drivers/scsi/mpi3mr/mpi/mpi30_cnfg.h | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/scsi/mpi3mr/mpi/mpi30_cnfg.h b/drivers/scsi/mpi3mr/mpi/mpi30_cnfg.h
> index 66cca35d8e52..4b7a8f6314a3 100644
> --- a/drivers/scsi/mpi3mr/mpi/mpi30_cnfg.h
> +++ b/drivers/scsi/mpi3mr/mpi/mpi30_cnfg.h
> @@ -1603,9 +1603,6 @@ struct mpi3_sas_io_unit1_phy_data {
>   	__le32             reserved08;
>   };
>   
> -#ifndef MPI3_SAS_IO_UNIT1_PHY_MAX
> -#define MPI3_SAS_IO_UNIT1_PHY_MAX           (1)
> -#endif
>   struct mpi3_sas_io_unit_page1 {
>   	struct mpi3_config_page_header         header;
>   	__le16                             control_flags;
> @@ -1615,7 +1612,7 @@ struct mpi3_sas_io_unit_page1 {
>   	u8                                 num_phys;
>   	u8                                 sata_max_q_depth;
>   	__le16                             reserved12;
> -	struct mpi3_sas_io_unit1_phy_data      phy_data[MPI3_SAS_IO_UNIT1_PHY_MAX];
> +	struct mpi3_sas_io_unit1_phy_data      phy_data[];
>   };
>   
>   #define MPI3_SASIOUNIT1_PAGEVERSION                                 (0x00)

