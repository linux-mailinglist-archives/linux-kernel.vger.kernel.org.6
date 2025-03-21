Return-Path: <linux-kernel+bounces-570897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 881A7A6B5FA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 09:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E722D189506D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 08:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF8F1EFF99;
	Fri, 21 Mar 2025 08:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="aLPVoWd3"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D7C1EDA35
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 08:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742545187; cv=none; b=FMSy2DuL0Aseg9AMaQZvM0hcvYwVRtKnc/JFI9moyxBq9ZSY4DFDkB/2dhYvvAfzRrhZsPpS5KZMQStZ6I7D3nrarHIDrYenxprQgotqY9k0iDpeaiNpqOW7IyXmpIFv1Jb1hck7XhM9hb/75GpqbPn1Zi4yfNUm+yN6wvSfHMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742545187; c=relaxed/simple;
	bh=nBV0rhKS0xwWV81nt7VVhHciBFvCdsWmzY+TP+fKKGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ISjId2zoefmtetlMjeBGZtWR5XrLiovQPUdRcCP3vfFtjiz8FFpnSzY0ibGIQ0TGxOoFRmiyW153wbBH6u3N3fr7ISRvKlBpjGq0LlDchD6FZCiu30v6NM/17yjGw/CbLmxUZYqsbi/+H+nV3RS6WhmUVP+ALnb8+VXuTbl99Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=aLPVoWd3; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-39149bccb69so1547491f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 01:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1742545184; x=1743149984; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S1AzRi6eHoS6ZWFDX/LO1TVYvjTJRBljJTiN5ZXvzYc=;
        b=aLPVoWd3U6p009QWrN5VlVRC40GWsvhuuXrXpFQYPompGgcukrKZHCL90ju7QPLyCe
         npjoDtE4tczYioJKPoNY2xqbNjnA3P4iGdreET956cU4VTDtiFelLCr4Pjbu7Pl8l/zL
         jc97tgo9KrniWcj6Ky7hXfabwJRrQ3MKv+ZyfBSJXPzlTLet2o6lxe2E2eYauKixTer4
         ELHmjqlXFWhfTW2Zu7zLbaJ1oW5JG5mdtwvmOlSw8x4+UxLfJD1nNgxSwvVadLE3c/8X
         bv/KtCq105pWKivkbWOd87lCYYnkdBBCs5GqO/tPmrJTIro4NT7iM4rPOp39vMuAsgGe
         +3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742545184; x=1743149984;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S1AzRi6eHoS6ZWFDX/LO1TVYvjTJRBljJTiN5ZXvzYc=;
        b=HB5tQ9BLA85N9Mw7mePavE7ERMcKVpa6C7B5zJW1owN4IyC8z0KY2GORtXfQR4IvxM
         Cgf66PVmot4xn0nrBikRM8s3Zv4xJMsF+ParnAauS4bdgGXAT9f6yOaIGh2otjf9ij9e
         baabEP1Z/Yr4KLP9cso5S2DId7zWS9VmfcVzxCT/hLkN+Br+YX0DeZPz4zP1aGCAdu2W
         7+/qLISnOSjkDYwwJAnUBi0fkQAUns4WC9oXWR3AbJpwclVI0sz1aMvnlJxZ6hVpDggz
         LgfUBygIiecexGHe2e0tIAqCElFVFsSVnl6OIrpbFL0sl0v7XzaODviuAAc2E7+BIqbC
         UVhA==
X-Forwarded-Encrypted: i=1; AJvYcCVxCK+BsMSFhfutuXml7/FtP7ng/5+RIGH+hXT7O3LKhceYJ9QhqDiFQe4CA8LvDvB1e+Bnv4KMOWYhlIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOCFWtJ8XEobpFGGUJggUedL1OIm1KyFlbUTNFAYo50udzZ+J5
	CavxSac0pFyg2RNLWPYgtu2j2r805PXUOjvUQiaCsbmRfgxqGP5Bwy7JoyAcTNQ=
X-Gm-Gg: ASbGncsTlHAlT1XmjGFw0eSqUmcc3HlJjRN7XdXasu8Wl7oBBunRJsjJZKCYuV2no4u
	7wGTex79/E87XbbAmwYUtvE+/hLEPCwyG26sfSNzUxEYBp5LJBvtnfb2DxMVE1/xEYAdNnMqt9B
	tqKEOLTOgbkzINRB6W6XkClKCWyvpuA9eF6mC4swrRjvfKY/r7GJ6qh/6Flk9P4XwcnGfYhVlEs
	b50bBWcw5xIW07RTFSDZJ7uYEk2OX52zzktmZ54+RCvLz0FJcBs7d1bOcdagAAf9n1FFk/jbw5D
	lSmSg2Hr96IPV/vmOuwu0iYiRlEd/Qbb96iUnIa14YkOD+/l9jVD6WEcDgRFWQQuklcy2e3oeKH
	+
X-Google-Smtp-Source: AGHT+IE0vn5XmRw18AJGFhtJXtjIWLR4HgtKdHsBoT+HKQO/7WMl2yfPtRbZKEhKlsvQrsE1URNu0A==
X-Received: by 2002:a05:6000:1a87:b0:391:23e6:f08c with SMTP id ffacd0b85a97d-3997f941973mr2350929f8f.47.1742545183874;
        Fri, 21 Mar 2025 01:19:43 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f43ed6sm70133835e9.13.2025.03.21.01.19.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 01:19:43 -0700 (PDT)
Message-ID: <c90151bc-a529-4f4e-a0b9-5831a6b803f7@blackwall.org>
Date: Fri, 21 Mar 2025 10:19:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net-next 1/3] net: bridge: mcast: Add offload failed mdb
 flag
To: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org
Cc: Joseph Huang <joseph.huang.2024@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Roopa Prabhu <roopa@nvidia.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev
References: <20250318224255.143683-1-Joseph.Huang@garmin.com>
 <20250318224255.143683-2-Joseph.Huang@garmin.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250318224255.143683-2-Joseph.Huang@garmin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/25 00:42, Joseph Huang wrote:
> Add MDB_FLAGS_OFFLOAD_FAILED and MDB_PG_FLAGS_OFFLOAD_FAILED to indicate
> that an attempt to offload the MDB entry to switchdev has failed.
> 
> Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
> ---
>  include/uapi/linux/if_bridge.h |  9 +++++----
>  net/bridge/br_mdb.c            |  2 ++
>  net/bridge/br_private.h        | 11 ++++++-----
>  net/bridge/br_switchdev.c      | 10 +++++-----
>  4 files changed, 18 insertions(+), 14 deletions(-)
> 
> diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
> index a5b743a2f775..f2a6de424f3f 100644
> --- a/include/uapi/linux/if_bridge.h
> +++ b/include/uapi/linux/if_bridge.h
> @@ -699,10 +699,11 @@ struct br_mdb_entry {
>  #define MDB_TEMPORARY 0
>  #define MDB_PERMANENT 1
>  	__u8 state;
> -#define MDB_FLAGS_OFFLOAD	(1 << 0)
> -#define MDB_FLAGS_FAST_LEAVE	(1 << 1)
> -#define MDB_FLAGS_STAR_EXCL	(1 << 2)
> -#define MDB_FLAGS_BLOCKED	(1 << 3)
> +#define MDB_FLAGS_OFFLOAD		(1 << 0)
> +#define MDB_FLAGS_FAST_LEAVE		(1 << 1)
> +#define MDB_FLAGS_STAR_EXCL		(1 << 2)
> +#define MDB_FLAGS_BLOCKED		(1 << 3)
> +#define MDB_FLAGS_OFFLOAD_FAILED	(1 << 4)
>  	__u8 flags;
>  	__u16 vid;
>  	struct {
> diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
> index 1a52a0bca086..0639691cd19b 100644
> --- a/net/bridge/br_mdb.c
> +++ b/net/bridge/br_mdb.c
> @@ -144,6 +144,8 @@ static void __mdb_entry_fill_flags(struct br_mdb_entry *e, unsigned char flags)
>  		e->flags |= MDB_FLAGS_STAR_EXCL;
>  	if (flags & MDB_PG_FLAGS_BLOCKED)
>  		e->flags |= MDB_FLAGS_BLOCKED;
> +	if (flags & MDB_PG_FLAGS_OFFLOAD_FAILED)
> +		e->flags |= MDB_FLAGS_OFFLOAD_FAILED;
>  }
>  
>  static void __mdb_entry_to_br_ip(struct br_mdb_entry *entry, struct br_ip *ip,
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 1054b8a88edc..cd6b4e91e7d6 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -306,11 +306,12 @@ struct net_bridge_fdb_flush_desc {
>  	u16				vlan_id;
>  };
>  
> -#define MDB_PG_FLAGS_PERMANENT	BIT(0)
> -#define MDB_PG_FLAGS_OFFLOAD	BIT(1)
> -#define MDB_PG_FLAGS_FAST_LEAVE	BIT(2)
> -#define MDB_PG_FLAGS_STAR_EXCL	BIT(3)
> -#define MDB_PG_FLAGS_BLOCKED	BIT(4)
> +#define MDB_PG_FLAGS_PERMANENT		BIT(0)
> +#define MDB_PG_FLAGS_OFFLOAD		BIT(1)
> +#define MDB_PG_FLAGS_FAST_LEAVE		BIT(2)
> +#define MDB_PG_FLAGS_STAR_EXCL		BIT(3)
> +#define MDB_PG_FLAGS_BLOCKED		BIT(4)
> +#define MDB_PG_FLAGS_OFFLOAD_FAILED	BIT(5)
>  
>  #define PG_SRC_ENT_LIMIT	32
>  
> diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
> index 7b41ee8740cb..68dccc2ff7b1 100644
> --- a/net/bridge/br_switchdev.c
> +++ b/net/bridge/br_switchdev.c
> @@ -505,9 +505,6 @@ static void br_switchdev_mdb_complete(struct net_device *dev, int err, void *pri
>  	struct net_bridge_port *port = data->port;
>  	struct net_bridge *br = port->br;
>  
> -	if (err)
> -		goto err;
> -
>  	spin_lock_bh(&br->multicast_lock);
>  	mp = br_mdb_ip_get(br, &data->ip);
>  	if (!mp)
> @@ -516,11 +513,14 @@ static void br_switchdev_mdb_complete(struct net_device *dev, int err, void *pri
>  	     pp = &p->next) {
>  		if (p->key.port != port)
>  			continue;
> -		p->flags |= MDB_PG_FLAGS_OFFLOAD;
> +
> +		if (err)
> +			p->flags |= MDB_PG_FLAGS_OFFLOAD_FAILED;
> +		else
> +			p->flags |= MDB_PG_FLAGS_OFFLOAD;

These two should be mutually exclusive, either it's offloaded or it failed an offload,
shouldn't be possible to have both set. I'd recommend adding some helper that takes
care of that.

>  	}
>  out:
>  	spin_unlock_bh(&br->multicast_lock);
> -err:
>  	kfree(priv);
>  }
>  


