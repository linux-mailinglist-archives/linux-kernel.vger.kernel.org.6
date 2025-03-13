Return-Path: <linux-kernel+bounces-559640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F995A5F6F6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6558B420280
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B83267B7C;
	Thu, 13 Mar 2025 13:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LCxN7/Oa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3585B26773D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 13:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741874077; cv=none; b=qiA7gXoyGEIa7u4/96Pxjn710dnY6CjM8/zF/aNfuL/w6DVenoWVTAip+PAIis5gQyIOu7C0KifAAt7RgBNkmExDkMm6Sciy2Xr2aNuygyYJQ0SpfDvoYJ/MxL5apjcXFqx9Kk9njVodkmvGfDWBq/k+SbDoWB1um9CO4kRFpjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741874077; c=relaxed/simple;
	bh=zMKUxZC6bTVsqCQNlV/AgPp8GCxxH8381v7wfJEg1qY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GCEEpgeSLLwN+DugUzcwkr1zqxnnbGykHdQnoYQlHkLaQdnuxzfzyuS+XQnyxug3apXyXcPj9yzzwXPY3xRauBwMcQ8kkDFQeiouB2b4Pn2CdOIONgkpYUFv68OWLLW45OQocv1uNd1lkp+2aSD2NUZB0T12O6zN9yQPq0MNGng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LCxN7/Oa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741874075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gg8NZNRSl/3YhnFbxnRixmtDkO5yIkE0F0lZ+aIhm4c=;
	b=LCxN7/Oan6D+v9rdzhABVZORbZIRqoTotNXLU9jyq48VW0TqZmrVkoH/KXVHEjVxiTdy4H
	47EdolfSIVH0JwvD5z3hETUhTdwGuoRuWkuwUzGJmnPXOxA/nWckZlsFE7EKDQFJWFSDuF
	8yHngPKZj2SWbNe+L4zc69rMltKBOv4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-_UeQC88NPoC1aQZHTYtH4Q-1; Thu, 13 Mar 2025 09:54:33 -0400
X-MC-Unique: _UeQC88NPoC1aQZHTYtH4Q-1
X-Mimecast-MFC-AGG-ID: _UeQC88NPoC1aQZHTYtH4Q_1741874073
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3913f97d115so499292f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 06:54:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741874073; x=1742478873;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gg8NZNRSl/3YhnFbxnRixmtDkO5yIkE0F0lZ+aIhm4c=;
        b=ZCERVNemlsXT1YWUymREhw+SPzr/QVjgk4/Gd96MpKuTNu1bChETkM0bEfJ4A6x3ZK
         T/z4qMFnfVksFotHVy/EFv7tGbiC7BHp9+iK6GwKLo7pkfymcvtBq3u9T4IMVnS7fl4C
         HDAjl50VrKMDcUOHLdV/L4SUVoMDgBgC7ITK4pL3MFUioCK3M0jinRh4i7PEtoBt925G
         dyLWcrXHrjKx5ZoQGILfhbYimTtDltI+0CSmM2wiJhfxFo3z/xIabavLrAf43ifaVaRp
         H8FwOu0dCb6COwUy9es/bWhS+BD6zVGyUtCJQUhOaSSzBhmt3bfHqQ3ljJfP79XIPSME
         K3mg==
X-Forwarded-Encrypted: i=1; AJvYcCUnL2bouF+N4Q1KZqjyspnGGPnSxdaTO5cNCza736zvTqDCSwOUeLdLuzhphqSojyGTJspAbBzEQZOotIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP1VXCygZ5MhxH6nBGYjSo80CNbqc1PVvdsjP/H/+71BG/dgWa
	FiVog+TNAGwkqhvxQXwdSGiiu+8EsS2rd4CrlK5hIoImSsA+RTt7gtYVvneDeqnqhrnkMRqTzxF
	plX70ec+JK0ROksOc7GWvuisZhbzB4rMWYAyCdkzOrc9/7e+ZZcKp8VGN2AfxDg==
X-Gm-Gg: ASbGnct3iafd7VZwdf4fo8TqVv7HqkGwj1IJwW9MfrcPonyFEjM3fkl3NB42Di+e3NA
	SSKpXNpPom3e+ypebKhwhM+/ZnWbZwyvtcFAwT+gu9l+gljbGtMSYZkDzwNQN0Xvt/hfKYdABJs
	6eyMbonbFTlT62p2PdkNIwArd0BfwDbuAK7Snud7IsOAYmVu0DLzKVO/BaurTISCrVCMoeZzrpN
	WEdLqjvVQHZEqkUqtKfGyNx1++1lO9qZXfDVc2s1PXIM/RDWqCrxJvjVN5masolZl++QmW+wxyl
	OmjVkOZ76J/mNxTLIlKcYN5gz7GznVSszQKtKynu
X-Received: by 2002:a05:6000:156f:b0:390:f116:d220 with SMTP id ffacd0b85a97d-395b7e32790mr1935043f8f.17.1741874072694;
        Thu, 13 Mar 2025 06:54:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGz71DBQxMEe7D6nRevhedSHNAA/OWdoc71mvIIDbZkVq6C6OM9Nvkgz7IGRhkTyyXl+Kh6tA==
X-Received: by 2002:a05:6000:156f:b0:390:f116:d220 with SMTP id ffacd0b85a97d-395b7e32790mr1935022f8f.17.1741874072290;
        Thu, 13 Mar 2025 06:54:32 -0700 (PDT)
Received: from [192.168.88.253] (146-241-6-87.dyn.eolo.it. [146.241.6.87])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7eb9c0sm2218042f8f.97.2025.03.13.06.54.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 06:54:31 -0700 (PDT)
Message-ID: <ff90d3b5-d9c2-4439-ae0a-71edc9865ad2@redhat.com>
Date: Thu, 13 Mar 2025 14:54:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] mlxsw: spectrum_acl_bloom_filter: Expand
 chunk_key_offsets[chunk_index]
To: WangYuli <wangyuli@uniontech.com>
Cc: andrew+netdev@lunn.ch, chenlinxuan@uniontech.com, czj2441@163.com,
 davem@davemloft.net, edumazet@google.com, guanwentao@uniontech.com,
 idosch@nvidia.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, niecheng1@uniontech.com, petrm@nvidia.com,
 zhanjun@uniontech.com
References: <484364B641C901CD+20250311141025.1624528-1-wangyuli@uniontech.com>
 <78951564F9FEA017+20250311141701.1626533-1-wangyuli@uniontech.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <78951564F9FEA017+20250311141701.1626533-1-wangyuli@uniontech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/11/25 3:17 PM, WangYuli wrote:
>  .../mlxsw/spectrum_acl_bloom_filter.c         | 39 ++++++++++++-------
>  1 file changed, 25 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
> index a54eedb69a3f..96105bab680b 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
> @@ -203,17 +203,6 @@ static const u8 mlxsw_sp4_acl_bf_crc6_tab[256] = {
>  0x2f, 0x02, 0x18, 0x35, 0x2c, 0x01, 0x1b, 0x36,
>  };
>  
> -/* Each chunk contains 4 key blocks. Chunk 2 uses key blocks 11-8,
> - * and we need to populate it with 4 key blocks copied from the entry encoded
> - * key. The original keys layout is same for Spectrum-{2,3,4}.
> - * Since the encoded key contains a 2 bytes padding, key block 11 starts at
> - * offset 2. block 7 that is used in chunk 1 starts at offset 20 as 4 key blocks
> - * take 18 bytes. See 'MLXSW_SP2_AFK_BLOCK_LAYOUT' for more details.
> - * This array defines key offsets for easy access when copying key blocks from
> - * entry key to Bloom filter chunk.
> - */
> -static const u8 chunk_key_offsets[MLXSW_BLOOM_KEY_CHUNKS] = {2, 20, 38};
> -
>  static u16 mlxsw_sp2_acl_bf_crc16_byte(u16 crc, u8 c)
>  {
>  	return (crc << 8) ^ mlxsw_sp2_acl_bf_crc16_tab[(crc >> 8) ^ c];
> @@ -237,6 +226,7 @@ __mlxsw_sp_acl_bf_key_encode(struct mlxsw_sp_acl_atcam_region *aregion,
>  	struct mlxsw_afk_key_info *key_info = aregion->region->key_info;
>  	u8 chunk_index, chunk_count, block_count;
>  	char *chunk = output;
> +	char *enc_key_src_ptr;

Please respect the reverse christmas tree order (same in the next patch)

>  	__be16 erp_region_id;
>  
>  	block_count = mlxsw_afk_key_info_blocks_count_get(key_info);
> @@ -248,9 +238,30 @@ __mlxsw_sp_acl_bf_key_encode(struct mlxsw_sp_acl_atcam_region *aregion,
>  		memset(chunk, 0, pad_bytes);
>  		memcpy(chunk + pad_bytes, &erp_region_id,
>  		       sizeof(erp_region_id));
> -		memcpy(chunk + key_offset,
> -		       &aentry->ht_key.enc_key[chunk_key_offsets[chunk_index]],
> -		       chunk_key_len);

Please try instead explicitly cap-ing the loop to the expected
boundaries (0-3)

Thanks,

Paolo


