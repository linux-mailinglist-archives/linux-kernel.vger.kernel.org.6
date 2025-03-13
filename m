Return-Path: <linux-kernel+bounces-559633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F31A5F6C7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA87216FBA4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70ED92686B3;
	Thu, 13 Mar 2025 13:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SG/d2maK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139CA267F71
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 13:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741873941; cv=none; b=K3BeU89Taz+7dnRlmbtZ2Pklxk/uhKJnlRQxZ2kW2EyIn1aGjVwY3bQrz9Vh86t5DcmH4GBHbIV5/ZhnUATNAZvQCRpB97NbfY2OOL2Q8p+wb6bXB1OoJnzTRc24BjdtTYQTj/Nw517GVu/xzm9hdN6IRAI9/feEvpPJXNVktyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741873941; c=relaxed/simple;
	bh=+nzZx9ajjnQBt2TeA0HnBToTjx+jVg3oi9qxFXOv9R4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KAaXfENg0sooT0nu9M1x9bgx5N48ELpyR037ivHkscgADzZiClOhmZGKdVkwKCJm9jmgLnCGT6xlJjFJ6+nN0S/4/FEMhH0Nb6R85hnOJXrxzAldbFRPoru9gocAzijLO5ohAR59Lr/N5fE7igw7HhN2tsY4N4UgsZXNhyuirz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SG/d2maK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741873938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Al2zSVYkpwujGOmTgK9tfuhK7r0I1FYHf0bUIOZ4izs=;
	b=SG/d2maKiC/0hG65LU5mj06gCNS6q3NPPtcCsMv95xqKRxYM3UuMli9M5MmjLhEIHCIlQO
	Kv/R7cfP4YaDSN46PYqa67F/peoq+r/75KwEBw3dI6k9tpc4M7vJbwgK8oV6AiyjQxzYUt
	XMYXZySxqdeR/C5/82jmFiCHEfw9Pj0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-pLV8MbhpPKOzRzGCs551hw-1; Thu, 13 Mar 2025 09:52:15 -0400
X-MC-Unique: pLV8MbhpPKOzRzGCs551hw-1
X-Mimecast-MFC-AGG-ID: pLV8MbhpPKOzRzGCs551hw_1741873934
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43935e09897so7496985e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 06:52:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741873934; x=1742478734;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Al2zSVYkpwujGOmTgK9tfuhK7r0I1FYHf0bUIOZ4izs=;
        b=C8uymBdh9ZFPQjoA/zg6aFxkwnrGAbKoKn6M9tSqJEePu15JTReIxWreL5R1HBKxCx
         PtniW+t20xdm3itqe6Bpka1tY6ddAbaX/pCTe7SCBoLzNo7mJBivEHBnlmXBhUrMmoDJ
         AJBe2fAoDpTF2FrDUQWCD25fzXSPj65/2G5thNMyOGSa2KcIXHOydg75qYjzcTwPXdGz
         yxn4j3cWfgVK5T7wNDfxlnwbyOPiFrF9HY/8hs2keBExaqoObxAbPiEDkjCd/vmuJ4Po
         Tta90APHRJGQLNnMB6NZc0OEORo1SicevwW2TuBB8j39XpadxLZDCvNvHLTHl2rqna/d
         EdLw==
X-Forwarded-Encrypted: i=1; AJvYcCXSC/MtuVqxeM87v/L6kNjJRkKpyvh1+UOP/pxoWxX95uAn9nnCo5eflq2sKgfKAviqc/7MuGTHAGzT4N4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIfBaOcahEc5buLE8xF1ERluWuk/N6giZwnR19hVicJQBuvqBs
	Jd4fdWa6CUlVVPmm1hniUl4suDv7nDnVECfwD2aR8WAkDoAjwtw3uvRa6pZmrJqu+hejXu7XWeR
	qfHZEz/rEqIny8pxv7BVtK6iPUjtNLL9yhkTdJBUSkw6w4Flcuo7vt3w9n2HV/g==
X-Gm-Gg: ASbGncvdzdmNQThuyUGuL6bylbMlRBwfOr8W24Fwcy5XqysYLMY4JxKyCt077SzLuDT
	Oid+5srQFeHXNxQglWXhSYduzG61Wy3bq57RFzLgut69C2uAAdhuvGX2roKDIdK2eLiJURYAbFG
	hxyjv2WZNrXtUHI67Fx1iGF0R61MZzKU/ynpT7W+H1fVp+XKGWaIRz2PjwoUD4E3jOXBYILpfsz
	HVB3w5WT5pChP8shrvsNTbUxGgZxLYfwT8SaUfTmk4P7BzRvPXfpY4P2RcNBd7z4TYlyq/XIB9S
	MXNjETvjtcROU0rRLNPyScvLHnuPfZZ1ugzT2RWM
X-Received: by 2002:a05:600c:4e8e:b0:43d:83a:417d with SMTP id 5b1f17b1804b1-43d083a43ebmr79929125e9.12.1741873934372;
        Thu, 13 Mar 2025 06:52:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgGbs+6tRrG5la6evXZMVQfIWrs/oMrajOJ39y1ezJw/eF0m6pNVRz476LEd8IvmDKYZqB8w==
X-Received: by 2002:a05:600c:4e8e:b0:43d:83a:417d with SMTP id 5b1f17b1804b1-43d083a43ebmr79928905e9.12.1741873933991;
        Thu, 13 Mar 2025 06:52:13 -0700 (PDT)
Received: from [192.168.88.253] (146-241-6-87.dyn.eolo.it. [146.241.6.87])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d19541339sm17962415e9.21.2025.03.13.06.52.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 06:52:13 -0700 (PDT)
Message-ID: <70a2fa44-c0cf-4dd4-8c17-8cc7abf1fbce@redhat.com>
Date: Thu, 13 Mar 2025 14:52:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] mlxsw: spectrum_acl_bloom_filter: Expand
 chunk_key_offsets[chunk_index]
To: Ido Schimmel <idosch@nvidia.com>, WangYuli <wangyuli@uniontech.com>
Cc: andrew+netdev@lunn.ch, chenlinxuan@uniontech.com, czj2441@163.com,
 davem@davemloft.net, edumazet@google.com, guanwentao@uniontech.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 niecheng1@uniontech.com, petrm@nvidia.com, zhanjun@uniontech.com
References: <484364B641C901CD+20250311141025.1624528-1-wangyuli@uniontech.com>
 <78951564F9FEA017+20250311141701.1626533-1-wangyuli@uniontech.com>
 <Z9GKE-mP3qbmK9cL@shredder>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <Z9GKE-mP3qbmK9cL@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/25 2:20 PM, Ido Schimmel wrote:
> On Tue, Mar 11, 2025 at 10:17:00PM +0800, WangYuli wrote:
>> This is a workaround to mitigate a compiler anomaly.
>>
>> During LLVM toolchain compilation of this driver on s390x architecture, an
>> unreasonable __write_overflow_field warning occurs.
>>
>> Contextually, chunk_index is restricted to 0, 1 or 2. By expanding these
>> possibilities, the compile warning is suppressed.
> 
> I'm not sure why the fix suppresses the warning when the warning is
> about the destination buffer and the fix is about the source. Can you
> check if the below helps? It removes the parameterization from
> __mlxsw_sp_acl_bf_key_encode() and instead splits it to two variants.
> 
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
> index a54eedb69a3f..3e1e4be72da2 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
> @@ -110,7 +110,6 @@ static const u16 mlxsw_sp2_acl_bf_crc16_tab[256] = {
>   * +-----------+----------+-----------------------------------+
>   */
>  
> -#define MLXSW_SP4_BLOOM_CHUNK_PAD_BYTES 0
>  #define MLXSW_SP4_BLOOM_CHUNK_KEY_BYTES 18
>  #define MLXSW_SP4_BLOOM_KEY_CHUNK_BYTES 20
>  
> @@ -229,10 +228,9 @@ static u16 mlxsw_sp2_acl_bf_crc(const u8 *buffer, size_t len)
>  }
>  
>  static void
> -__mlxsw_sp_acl_bf_key_encode(struct mlxsw_sp_acl_atcam_region *aregion,
> -			     struct mlxsw_sp_acl_atcam_entry *aentry,
> -			     char *output, u8 *len, u8 max_chunks, u8 pad_bytes,
> -			     u8 key_offset, u8 chunk_key_len, u8 chunk_len)
> +mlxsw_sp2_acl_bf_key_encode(struct mlxsw_sp_acl_atcam_region *aregion,
> +			    struct mlxsw_sp_acl_atcam_entry *aentry,
> +			    char *output, u8 *len)
>  {
>  	struct mlxsw_afk_key_info *key_info = aregion->region->key_info;
>  	u8 chunk_index, chunk_count, block_count;
> @@ -243,30 +241,17 @@ __mlxsw_sp_acl_bf_key_encode(struct mlxsw_sp_acl_atcam_region *aregion,
>  	chunk_count = 1 + ((block_count - 1) >> 2);
>  	erp_region_id = cpu_to_be16(aentry->ht_key.erp_id |
>  				   (aregion->region->id << 4));
> -	for (chunk_index = max_chunks - chunk_count; chunk_index < max_chunks;
> -	     chunk_index++) {
> -		memset(chunk, 0, pad_bytes);
> -		memcpy(chunk + pad_bytes, &erp_region_id,
> +	for (chunk_index = MLXSW_BLOOM_KEY_CHUNKS - chunk_count;
> +	     chunk_index < MLXSW_BLOOM_KEY_CHUNKS; chunk_index++) {

Possibly the compiler is inferring chunck count can be greater then
MLXSW_BLOOM_KEY_CHUNKS?

something alike:

	chunk_index = min_t(0, MLXSW_BLOOM_KEY_CHUNKS - chunk_count, u8);

Could possibly please it?

/P


