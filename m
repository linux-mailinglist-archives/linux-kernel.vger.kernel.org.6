Return-Path: <linux-kernel+bounces-545032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC3AA4E854
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA53A19C3A1D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18D9298CC5;
	Tue,  4 Mar 2025 16:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="UKXAJCR1"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A352980D0
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 16:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107009; cv=none; b=avK1IZ42bv2lXusIHO3hiii6foMTxv3mUy/D30fxQFOLvjZx7lTrLTXTCSa2DjAn7n0Ryjen88FYsxJMtbdL4NmBf++TTQ5snbZUCyDL22ZVE49kCpstx6q9+sFHoNFyGrwdUa48432iUI3ozKqAF2ZHSwLgOmMf5IOwen2k4kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107009; c=relaxed/simple;
	bh=L8HHTMU8DmC+6N2WJp3kjc3+BlXX6m9YnXOf1KwXSx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KHOmL3J92aBVUg9hH3PqwgzdzmumzODnk4WJ0FUctz74tIh4IwGzx9VDt7OfYKBmRGxoOhfIhCqjem3N+9U32+9NA064NA/2FQ4RONJ/BcSb0aEj9RGbL0mpM1EO9fR+ge9CjN4sHu3ckFzY1OBteMG18ADCTGjyh11dv+/cyYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=UKXAJCR1; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2bcc0c6c149so5118050fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 08:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1741107006; x=1741711806; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FFC/0VaDOfAur/tgnlAkpmmS5lpWwryf/b8rBN6y4bk=;
        b=UKXAJCR1/tTwsmoZ4x9nqIHt3iJiOx3wg33jD7tZPm4GLZj0FXhiwRnDlQRI/UFsRM
         tHKZcH9BJP8yWCXszhuuYxWjUZOvTT6tVJxqCkm4gBKbN+ayHH9Q9A14mcBlJfzYH6PC
         8PToCT73Xt0d8SlldeLUsM5g/ZQBOPRrDY1dsJBF3XQJs9Nev83VvY/mB4RaklGM2N0E
         0SSdfPRgLIwVPAFR0kEDKq8cSUXXMgV/5m3hRWmcxM//NO5gfr9sld21ztQXusoRUeMf
         AaFS1gA5FrXeKYYzznxCqHaquThoDbNg6ESjB/hsD8NmTsb0E0iWBLdj89MfdQZRrNKU
         D/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741107006; x=1741711806;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FFC/0VaDOfAur/tgnlAkpmmS5lpWwryf/b8rBN6y4bk=;
        b=ClrzvGzXTw7ZdUsSXTlOnImWFh5dmGCjXuWQieSyyUS0aAuXImq+PmHEDRUtUvkMR5
         UPPy7YD5MzceKJx9S8Qd26gZyhncYQtYB9qjWfVG0N5d3RtAKylCudtrks24MV4656Ex
         cwbV28Gu+cgQHoLBoJxg5t4dm8B/y/KRpJ195+/GY+QOcchZ/S8BCZ0C+EFXukrLye3W
         qDuFbVjQpt2LqW18SZmdA5GXu6CRbuuJ6tyI2ejFRhUAur479B6i4ytCzy0O+1zmb2g6
         Iy/N1E+qdG+abagO/uAWN0SVq3TvwR+9WwWjDsaJ/xJDwz4gEs9ewRrezC9AYpe6OqpN
         I5hw==
X-Forwarded-Encrypted: i=1; AJvYcCWtrPuhfBBMn7sMwueE38P0V0iNBSS/IXhCwlOAxw4mloYiBbDPg0Wg6ljHOfNcyc1Vfn7mvug+Ted4VDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGCH8psL/hy4PIbJvHIpf0vplS7H4/3h1poN5APfEZU20dpvmn
	9RQwc1FDvEymNpLuAOYxF+8C0F+nEmEht5atpFO+EdJqNC1Fex3ziVlUHFSbZzM=
X-Gm-Gg: ASbGnctvXIE4YzdZD3Uy8Iwwv5xoLEiemad2VGnax74hZ5IDVh5aBN2v3rVUzmJdmYy
	INC7RZxwDdpsEZiIjvhUOabXC6Rh96wiULDbes2jPMF8Zjn5aQz0Dh+/kyWs/M7Law6GFSqZOZH
	VH23As0iH8wmeVih0DNBCFE1c7FQl9Nf1upZKXHaJYWQjElNnsgFrOigKthrNNubmrqGAXZMmmd
	1/s8/ltLsue4tqnymBaIVFf3qsbgIjArWm80dKEfYRofJ1JQNdlDqph7P6M/z3RJ8tNF78fY4nM
	D7E8gJTxDV95mxHV66o4E1gSlvWExlYFd0WLx57IZGqhfeN84icvkS4MngfSt6VfMuLeO/evwpG
	ENuRaXCyO
X-Google-Smtp-Source: AGHT+IENf5TzZy2paUOp2+yHiImyvpIf605z0YIuqY3weTYHuWBj9XQYDXLVtnPEtkn/E/5Jk+cT9w==
X-Received: by 2002:a05:6871:53c9:b0:29d:c5e8:e41f with SMTP id 586e51a60fabf-2c1782c5bb3mr11456642fac.5.1741107005688;
        Tue, 04 Mar 2025 08:50:05 -0800 (PST)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c15c45e81bsm2333459fac.50.2025.03.04.08.50.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 08:50:05 -0800 (PST)
Message-ID: <f8a6aea3-fa69-4c59-bccc-ae6e5021d5f3@riscstar.com>
Date: Tue, 4 Mar 2025 10:50:03 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] net: ipa: Fix v4.7 resource group names
To: Luca Weiss <luca.weiss@fairphone.com>, Alex Elder <elder@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250227-ipa-v4-7-fixes-v1-0-a88dd8249d8a@fairphone.com>
 <20250227-ipa-v4-7-fixes-v1-1-a88dd8249d8a@fairphone.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20250227-ipa-v4-7-fixes-v1-1-a88dd8249d8a@fairphone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/25 4:33 AM, Luca Weiss wrote:
> In the downstream IPA driver there's only one group defined for source
> and destination, and the destination group doesn't have a _DPL suffix.
> 
> Fixes: b310de784bac ("net: ipa: add IPA v4.7 support")
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

FYI, I used this to check what you're saying:
  
https://git.codelinaro.org/clo/la/platform/vendor/opensource/dataipa/-/blob/clo/main/drivers/platform/msm/ipa/ipa_v3/ipa_utils.c

This looks good, thanks a lot for the patch.

Reviewed-by: Alex Elder <elder@riscstar.com>

> ---
>   drivers/net/ipa/data/ipa_data-v4.7.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ipa/data/ipa_data-v4.7.c b/drivers/net/ipa/data/ipa_data-v4.7.c
> index c8c23d9be961b1b818e8a1592a7f7dd76cdd5468..7e315779e66480c2a3f2473a068278ab5e513a3d 100644
> --- a/drivers/net/ipa/data/ipa_data-v4.7.c
> +++ b/drivers/net/ipa/data/ipa_data-v4.7.c
> @@ -28,12 +28,10 @@ enum ipa_resource_type {
>   enum ipa_rsrc_group_id {
>   	/* Source resource group identifiers */
>   	IPA_RSRC_GROUP_SRC_UL_DL			= 0,
> -	IPA_RSRC_GROUP_SRC_UC_RX_Q,
>   	IPA_RSRC_GROUP_SRC_COUNT,	/* Last in set; not a source group */
>   
>   	/* Destination resource group identifiers */
> -	IPA_RSRC_GROUP_DST_UL_DL_DPL			= 0,
> -	IPA_RSRC_GROUP_DST_UNUSED_1,
> +	IPA_RSRC_GROUP_DST_UL_DL			= 0,
>   	IPA_RSRC_GROUP_DST_COUNT,	/* Last; not a destination group */
>   };
>   
> @@ -81,7 +79,7 @@ static const struct ipa_gsi_endpoint_data ipa_gsi_endpoint_data[] = {
>   		},
>   		.endpoint = {
>   			.config = {
> -				.resource_group	= IPA_RSRC_GROUP_DST_UL_DL_DPL,
> +				.resource_group	= IPA_RSRC_GROUP_DST_UL_DL,
>   				.aggregation	= true,
>   				.status_enable	= true,
>   				.rx = {
> @@ -128,7 +126,7 @@ static const struct ipa_gsi_endpoint_data ipa_gsi_endpoint_data[] = {
>   		},
>   		.endpoint = {
>   			.config = {
> -				.resource_group	= IPA_RSRC_GROUP_DST_UL_DL_DPL,
> +				.resource_group	= IPA_RSRC_GROUP_DST_UL_DL,
>   				.qmap		= true,
>   				.aggregation	= true,
>   				.rx = {
> @@ -197,12 +195,12 @@ static const struct ipa_resource ipa_resource_src[] = {
>   /* Destination resource configuration data for an SoC having IPA v4.7 */
>   static const struct ipa_resource ipa_resource_dst[] = {
>   	[IPA_RESOURCE_TYPE_DST_DATA_SECTORS] = {
> -		.limits[IPA_RSRC_GROUP_DST_UL_DL_DPL] = {
> +		.limits[IPA_RSRC_GROUP_DST_UL_DL] = {
>   			.min = 7,	.max = 7,
>   		},
>   	},
>   	[IPA_RESOURCE_TYPE_DST_DPS_DMARS] = {
> -		.limits[IPA_RSRC_GROUP_DST_UL_DL_DPL] = {
> +		.limits[IPA_RSRC_GROUP_DST_UL_DL] = {
>   			.min = 2,	.max = 2,
>   		},
>   	},
> 


