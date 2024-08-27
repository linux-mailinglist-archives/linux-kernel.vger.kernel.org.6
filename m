Return-Path: <linux-kernel+bounces-303146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9392A960807
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DE882840A1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC6F19F48B;
	Tue, 27 Aug 2024 10:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YFR1xoZc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615AA19EEA1
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 10:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724756266; cv=none; b=P+c8QZKUi5houJJx3XPwOynJwzKam97QDWPV1iQbK91rJHpvCXjiRffjbDnDD+xvua7Xg1sxIIJKfrz1J3TpLx0hQ/xvWarmnPYspqGtFkwG0R5jeKjvU+z0s/OXSb5ZCd5NExgnhn9bDYMbU30JakiFo+ZQ5sUglyidzfuuHjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724756266; c=relaxed/simple;
	bh=g8uJNZkbVx6Q9xZvvulJh+re7FcoazoLPLMRv5cLVVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XAbGPGNV1aabsFo0SgzD6XhLoTjueGg06vTMMsBBTFw2AFwjXUWdj+GHbOSCwGxDjkPZF29FHnc3yDLQjU6Q4MLj9MT9sxvxmmzGqpe3pAdtdK3a12mSFUtfrRAT+nPde4icAsVy9UTVGc7MIJ00wgZa7aq62JWuVHNgL3QPb7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YFR1xoZc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724756262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tcn+r1A3GLYAWgYgC+CIr8PBP/11f1+9CHxGWAbtMj4=;
	b=YFR1xoZcxqeAiMDFQn4MmmkA9txuLZuGGBq9YbvDpxB2ucgZVt97OT1HPhjg8BfKi6ozSt
	TKbj/wS+u60WKfq0PoQL2W+H1mg6zYZkLrB+1Om8dUamFCECJ3Oe+gvK26kh7uUgSCn5UD
	e5E6MBUWEs9ypB0Pzk0HyW/JLTE8mKk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-ICr2FGQCPvWSnucPFAoJHA-1; Tue, 27 Aug 2024 06:57:39 -0400
X-MC-Unique: ICr2FGQCPvWSnucPFAoJHA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37193ed09b2so3331114f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 03:57:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724756258; x=1725361058;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tcn+r1A3GLYAWgYgC+CIr8PBP/11f1+9CHxGWAbtMj4=;
        b=ffvZX5T7l6UoEM4SdL9I3Un64Cj9Lkn9g7+eW1GahloqMoV2jknGlBAh4hmdiGqUIj
         jGq3HBP/ZImgDHxjPrEGJQpZQ/zp7EgPf0By+GllIzbCHj/HjnzsN7t4uYgSzEN8wKvO
         Z73CzQeqFLLSrokAPmTd9yYW8lb+fb5h5dOuPfrXv+FNUYvn9HclZP5Bkj3mItAWiyAA
         a6ERZ8iNR9fEe1ioRKXPfhCVOIlUxNPwIdKGM0XLFmCu4HjmPpbB0WbnIjGwqeQiwwfy
         cOb0eu9DtgFGnlmw1mXd9YS5Zfv6gq5IO2id0p3fINA0q5V6vivn40eGQ0XcUfy7vHn8
         L1Xw==
X-Forwarded-Encrypted: i=1; AJvYcCV8bdmYhXSm0wN0MarILtyg6oxskmDdSmM+sMQEYPMz4iySBdEirmFIjYlD2rmZL04K8cNP7uQiR4iT9DY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP8KQ04P2r3mpT6pnckJ++HlsabNmiZQxfZKxYTbOObUXGQh8h
	a0GoTZwauE9MLQY8SqPnkGDV0bu/SNdqbI2ukW1AoUjPqmS0Y2LCMU/zl7a/jGb4/z+cJm7Wj9S
	dB/dGeCC4RDoN/Je9vRgzox20tjG9PTRbTFlQpNI1QX7eZPDbh8UssEdggbsQyg==
X-Received: by 2002:a5d:46c7:0:b0:35f:314a:229c with SMTP id ffacd0b85a97d-3748c837cb5mr1280942f8f.28.1724756258112;
        Tue, 27 Aug 2024 03:57:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAiqVFcY6Bm/bsOoRWCanu83DXAYMA4v6iZJL0diXG52qHx0v78y3EqZJgnOulYrvwMF+qGQ==
X-Received: by 2002:a5d:46c7:0:b0:35f:314a:229c with SMTP id ffacd0b85a97d-3748c837cb5mr1280922f8f.28.1724756257577;
        Tue, 27 Aug 2024 03:57:37 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b67:7410::f71? ([2a0d:3344:1b67:7410::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730817a548sm12775718f8f.63.2024.08.27.03.57.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 03:57:37 -0700 (PDT)
Message-ID: <2564cd0a-c236-427a-abd7-e9933adff5cc@redhat.com>
Date: Tue, 27 Aug 2024 12:57:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: dsa: vsc73xx: implement FDB operations
To: Pawel Dembicki <paweldembicki@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org
References: <20240822142344.354114-1-paweldembicki@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240822142344.354114-1-paweldembicki@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/22/24 16:23, Pawel Dembicki wrote:
> This commit introduces implementations of three functions:
> .port_fdb_dump
> .port_fdb_add
> .port_fdb_del
> 
> The FDB database organization is the same as in other old Vitesse chips:
> It has 2048 rows and 4 columns (buckets). The row index is calculated by
> the hash function 'vsc73xx_calc_hash' and the FDB entry must be placed
> exactly into row[hash]. The chip selects the bucket number by itself.
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

The patch LGTM, but I think you can deduplicate the code a bit, creating 
a few additional helpers.

> +static int vsc73xx_port_read_mac_table_row(struct vsc73xx *vsc, u16 index,
> +					   struct vsc73xx_fdb *fdb)
> +{
> +	int ret, i;
> +	u32 val;
> +
> +	if (!fdb)
> +		return -EINVAL;
> +	if (index >= VSC73XX_NUM_FDB_ROWS)
> +		return -EINVAL;
> +
> +	for (i = 0; i < VSC73XX_NUM_BUCKETS; i++) {
> +		ret = vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0,
> +				    VSC73XX_MACTINDX,
> +				    (i ? 0 : VSC73XX_MACTINDX_SHADOW) |
> +				    FIELD_PREP(VSC73XX_MACTINDX_BUCKET_MSK, i) |
> +				    index);
> +		if (ret)
> +			return ret;
> +
> +		ret = vsc73xx_port_wait_for_mac_table_cmd(vsc);
> +		if (ret)
> +			return ret;

the sequence:
	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, ...)
	vsc73xx_port_wait_for_mac_table_cmd()

could have its own helper

> +		ret = vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
> +					  VSC73XX_MACACCESS,
> +					  VSC73XX_MACACCESS_CMD_MASK,
> +					  VSC73XX_MACACCESS_CMD_READ_ENTRY);
> +		if (ret)
> +			return ret;
> +
> +		ret = vsc73xx_port_wait_for_mac_table_cmd(vsc);
> +		if (ret)
> +			return ret;

and even:

	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0, ...)
	vsc73xx_port_wait_for_mac_table_cmd()

[...]
> +static int vsc73xx_fdb_del_entry(struct vsc73xx *vsc, int port,
> +				 const unsigned char *addr, u16 vid)
> +{
> +	struct vsc73xx_fdb fdb[VSC73XX_NUM_BUCKETS];
> +	u16 hash = vsc73xx_calc_hash(addr, vid);
> +	int bucket, ret;
> +
> +	mutex_lock(&vsc->fdb_lock);
> +
> +	ret = vsc73xx_port_read_mac_table_row(vsc, hash, fdb);
> +	if (ret)
> +		goto err;
> +
> +	for (bucket = 0; bucket < VSC73XX_NUM_BUCKETS; bucket++) {
> +		if (fdb[bucket].valid && fdb[bucket].port == port &&
> +		    ether_addr_equal(addr, fdb[bucket].mac))
> +			break;
> +	}
> +
> +	if (bucket == VSC73XX_NUM_BUCKETS) {
> +		/* Can't find MAC in MAC table */
> +		ret = -ENODATA;
> +		goto err;
> +	}
> +
> +	ret = vsc73xx_fdb_insert_mac(vsc, addr, vid);
> +	if (ret)
> +		goto err;
> +
> +	ret = vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_MACTINDX,
> +			    hash);
> +	if (ret)
> +		goto err;
> +
> +	ret = vsc73xx_port_wait_for_mac_table_cmd(vsc);
> +	if (ret)
> +		goto err;
> +
> +	ret = vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
> +				  VSC73XX_MACACCESS,
> +				  VSC73XX_MACACCESS_CMD_MASK,
> +				  VSC73XX_MACACCESS_CMD_FORGET);
> +	if (ret)
> +		goto err;
> +
> +	ret =  vsc73xx_port_wait_for_mac_table_cmd(vsc);

AFAICS both fdb_add and fdb_del use the same sequence:

	vsc73xx_fdb_insert_mac()
	vsc73xx_write(... VSC73XX_MACTINDX, hash);
	vsc73xx_port_wait_for_mac_table_cmd
	vsc73xx_update_bits(... <variable part>)
	vsc73xx_port_wait_for_mac_table_cmd()

perhaps it would be worthy to factor it out - also using the above 
mentioned helpers.
	
Thanks,

Paolo


