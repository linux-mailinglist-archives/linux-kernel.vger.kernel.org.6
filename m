Return-Path: <linux-kernel+bounces-249550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 798BA92ED2A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 18:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2920F28506F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 16:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CEF16D4FB;
	Thu, 11 Jul 2024 16:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="eG2O+ml2"
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F364416D4EC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 16:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720716963; cv=none; b=fGcQPvbepMWWfBy5+NR3l3Uln/BSvOU60EqgTKmoL7DT1sObZBh3rJBohF2CBXFOkjM49qUTdnuFD383x74aAdXE6tOTyJZdJ/Z6nX0zzuDZAer0cvuARjQ78QoooeOMKUgCP+mzYZrlpM/HXmBhhfg3hTM/4SctNfP6ANI/6GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720716963; c=relaxed/simple;
	bh=2iYVbONDaBq6JV/7qJFLtv3UBiUya7pvZXvPB51GSE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P3ygoDjaDBhJ4LaB7dZA+QcsOrd5kkT1zlzVJhGGDRVCMO7zyAnAHnXRXSeDp7p64hnrbAtO9RnnAOoB09Vz7WOZlgWaMCblcLLEchyLTlb9tSe6+g2CjYDcjDNTmMRDX4Q/ULBdVuxPfZ31IYFRkbWu8s+UqmLhr9j7JPWfAmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=eG2O+ml2; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5007a.ext.cloudfilter.net ([10.0.29.141])
	by cmsmtp with ESMTPS
	id RvrasoUYQg2lzRx5NsKSib; Thu, 11 Jul 2024 16:56:01 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id Rx5Lsuq5jTnvcRx5Msr3Ms; Thu, 11 Jul 2024 16:56:00 +0000
X-Authority-Analysis: v=2.4 cv=c9StQw9l c=1 sm=1 tr=0 ts=66900ea0
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=4kmOji7k6h8A:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=Q-fNiiVtAAAA:8 a=bLk-5xynAAAA:8 a=yPCof4ZbAAAA:8
 a=BgCAbCOdkOygMcBay5MA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=Fp8MccfUoT0GBdDC_Lng:22 a=zSyb8xVVt2t83sZkrLMb:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=olFfmXh0pIyFs0WXsAhOmo1AA3OqVFBo3TyzIH79O9Y=; b=eG2O+ml2DqwWw7JzxJY+7gGZ4h
	AjfNziXEI5gLZAqEkFp2iWJ76A8GJPxlfuHlhYpYFQtR+E6MOlPhYIqvdvoaEo8v5h/LfND7yNaCC
	QFamol47XUYDjlCeP+FSzXYt/hxAF0HoFKA0TvoTRSJhZ4fJDOKE2N4EdED+A7Z+GKoj7kKcW8161
	MCT0YtBEblKFOKi54OXKh/bAA24+f4vW0ApQxwmdzcefYRuSvOIi3vPfvghUbpMk3F+FQPr+/LigX
	gBSOeDJBe1wXfMDgubgC3Xs8C9tu8l+0NxFu08AIi2H3ymJoZb7PWVwQCsjKys0QBS3jKILBt/8ud
	tqIxptSQ==;
Received: from [201.172.173.139] (port=55332 helo=[192.168.15.4])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sRx5L-000eHk-10;
	Thu, 11 Jul 2024 11:55:59 -0500
Message-ID: <58418596-5d8f-4bec-9d4c-64ed8ef0ff9e@embeddedor.com>
Date: Thu, 11 Jul 2024 10:55:57 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: megaraid_sas: struct MR_HOST_DEVICE_LIST: Replace
 1-element array with flexible array
To: Kees Cook <kees@kernel.org>, Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Sumit Saxena <sumit.saxena@broadcom.com>,
 Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
 Chandrakanth patil <chandrakanth.patil@broadcom.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20240711155841.work.839-kees@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240711155841.work.839-kees@kernel.org>
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
X-Exim-ID: 1sRx5L-000eHk-10
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.4]) [201.172.173.139]:55332
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 69
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJBfVDvNASWw8fGgIOYUxT03V/5aPgetThMryLT6PTA7elgmpQC/9GadNEud4ILsrCR4MRfx9b99bITk6lK8Kz+1E4aVt8QEY16AFpb0SHa4ytpeD4Ar
 IYcd5wZo274pNc1KiPpwEzf2rHd3KK5rh0BHrCdH2B+4YxcI5kLtulyDSwovUw/B/50VXKDR8ICTOuXoTo7U9bisjkE8IVPCMgc6+nYcJwYB7pgkrGz5uMCN



On 11/07/24 09:58, Kees Cook wrote:
> Replace the deprecated[1] use of a 1-element array in
> struct MR_HOST_DEVICE_LIST with a modern flexible array.
> 
> One binary difference appears in megasas_host_device_list_query():
> 
>          struct MR_HOST_DEVICE_LIST *ci;
> 	...
>          ci = instance->host_device_list_buf;
> 	...
>          memset(ci, 0, sizeof(*ci));
> 
> The memset() clears only the non-flexible array fields. Looking at the
> rest of the function, this appears to be fine: firmware is using this
> region to communicate with the kernel, so it likely never made sense to
> clear the first MR_HOST_DEVICE_LIST_ENTRY.

Yeah, clearing that fist entry seems odd/buggy. So, this patch is probably
even fixing a bug. :)

> 
> Link: https://github.com/KSPP/linux/issues/79 [1]
> Signed-off-by: Kees Cook <kees@kernel.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
> Cc: Kashyap Desai <kashyap.desai@broadcom.com>
> Cc: Sumit Saxena <sumit.saxena@broadcom.com>
> Cc: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
> Cc: Chandrakanth patil <chandrakanth.patil@broadcom.com>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: megaraidlinux.pdl@broadcom.com
> Cc: linux-scsi@vger.kernel.org
> ---
>   drivers/scsi/megaraid/megaraid_sas.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/megaraid/megaraid_sas.h b/drivers/scsi/megaraid/megaraid_sas.h
> index 84cf77c48c0d..088cc40ae866 100644
> --- a/drivers/scsi/megaraid/megaraid_sas.h
> +++ b/drivers/scsi/megaraid/megaraid_sas.h
> @@ -814,12 +814,12 @@ struct MR_HOST_DEVICE_LIST {
>   	__le32			size;
>   	__le32			count;
>   	__le32			reserved[2];
> -	struct MR_HOST_DEVICE_LIST_ENTRY	host_device_list[1];
> +	struct MR_HOST_DEVICE_LIST_ENTRY	host_device_list[] __counted_by_le(count);
>   } __packed;
>   
>   #define HOST_DEVICE_LIST_SZ (sizeof(struct MR_HOST_DEVICE_LIST) +	       \
>   			      (sizeof(struct MR_HOST_DEVICE_LIST_ENTRY) *      \
> -			      (MEGASAS_MAX_PD + MAX_LOGICAL_DRIVES_EXT - 1)))
> +			      (MEGASAS_MAX_PD + MAX_LOGICAL_DRIVES_EXT)))
>   
>   
>   /*

