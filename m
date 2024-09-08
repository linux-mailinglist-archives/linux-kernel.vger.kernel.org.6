Return-Path: <linux-kernel+bounces-320405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1B99709BD
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 22:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA4D21C2141B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 20:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D96D179972;
	Sun,  8 Sep 2024 20:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="u+9j2KLk"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17A6175D4C
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 20:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725827775; cv=none; b=t3AutRPeVRhJmv/YUEkmzrKrj8jY4/9545Qt5XN3g64Vo0l/LAYfPFJQ/wFS1fdx+wiycfr0xHzQ/R3AS1nsoy2/VTZcFqWargwgaPXormtde3xXvqzSiVg9HL5aRO/4BfYPrC4Er8t7eYbU5N3k3vKnFmn1PZdrYTIUU4gDmPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725827775; c=relaxed/simple;
	bh=JBK/+8+xE6SKdG2I/38E82/V5dQx54e/WDpzVZy6Az8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4PBYd6sUNcdnoWrzt9h+WRZCAk9fyXd7s3YTY8OinKCPXhzpgeBQP7xUW0RLPKGJGIcSNm1REFfzS43LE1HdWG6DB2BCMVMKUrs2fhYsplJ8smq7R1P2uYVaeBK05MgwsEHVvKM69CcEdkhbBVs5ibK4UWNwUSE5BW6Lufwl4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=u+9j2KLk; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8a7596b7dfso598720266b.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 13:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1725827772; x=1726432572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MbBTL5pJFbc4WoL9/Ssz6+tLyOzVs5blYq3ErDDrhAE=;
        b=u+9j2KLk9l3Vgo4opW5FTNhqaqXAsHAo3YRo9nRy/dNJzJJfWCXGdL7e3fHhUD3bHI
         9kPF+rP4cdpfMynHeyZoji+7hy/QckxnHiHHxdCAkPxE3K2CU8WrnUVhesjtBigFL+yo
         C2qMFAuiNrSPcnqRopqSMSyp2w1SG6pTbc1RI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725827772; x=1726432572;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MbBTL5pJFbc4WoL9/Ssz6+tLyOzVs5blYq3ErDDrhAE=;
        b=nnePmAZyWdxZKtk3fucyFAYmVeQVNzIaHGO9/8GaJbQaKi662b11Jvhsh5GMQBRXEO
         oi7QcpGXB0LYqtSrCoHdOYAX51Z39fFn9mJfgNBLxcu/5r4nGUZkpM9l3BcrEnH0IZAr
         D1Fuxhy+wlQHuhEw1T9VLqEtXNTI8lXuR7J7rZ/ANEeTcp3FnD3AwnyRpUObcUea2oYa
         iod1lPMweoKOK2ZvO1wtP7xl4ITJODqRSmU5yGCVocBnvbJR+OKTeLgShI9b+oRgh7yr
         62qlluolZNaX03TcB/d8itrC8mlXuMqwWHZE63CVrFEJgTfQX1uapemSO4xtiwfY9mhv
         MKpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsrkMTmvACsU77DeTh6GKBQ+Xu2W78PX+mW6QUNFc/AkCTHje1vmpL01yBOzwBzhot8veOfToHgS+Zilk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL30PdQHn5rfVS3iaIkJ5B5kmU5zuZLxqtKZknuCrEsZQb8qkU
	yUYxLZgH7/jdy4YKb5o0p8KXLSkfmZPeLB3MgCxUfPJyOQdFLwirS/+NtkDOAqc=
X-Google-Smtp-Source: AGHT+IFOxhb2pMqFVg3cQTabJXtA0kstKltwdqMCbv+++XsxCaWtLu3qNwqExqs50+Jq6di85P9Wkg==
X-Received: by 2002:a17:907:c13:b0:a8d:35a5:c8e5 with SMTP id a640c23a62f3a-a8d35a5cd2dmr333281166b.6.1725827771622;
        Sun, 08 Sep 2024 13:36:11 -0700 (PDT)
Received: from LQ3V64L9R2.homenet.telecomitalia.it (host-79-23-194-51.retail.telecomitalia.it. [79.23.194.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25835b0bsm248837566b.12.2024.09.08.13.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 13:36:11 -0700 (PDT)
Date: Sun, 8 Sep 2024 22:36:09 +0200
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca, kuba@kernel.org, skhawaja@google.com,
	sdf@fomichev.me, bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next v2 4/9] netdev-genl: Dump napi_defer_hard_irqs
Message-ID: <Zt4KuV77wt1as5QW@LQ3V64L9R2.homenet.telecomitalia.it>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, kuba@kernel.org, skhawaja@google.com,
	sdf@fomichev.me, bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20240908160702.56618-1-jdamato@fastly.com>
 <20240908160702.56618-5-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240908160702.56618-5-jdamato@fastly.com>

On Sun, Sep 08, 2024 at 04:06:38PM +0000, Joe Damato wrote:
> Support dumping defer_hard_irqs for a NAPI ID.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>  Documentation/netlink/specs/netdev.yaml | 8 ++++++++
>  include/uapi/linux/netdev.h             | 1 +
>  net/core/netdev-genl.c                  | 5 +++++
>  tools/include/uapi/linux/netdev.h       | 1 +
>  4 files changed, 15 insertions(+)

[...]

> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index 9561841b9d2d..f1e505ad069f 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -160,6 +160,7 @@ static int
>  netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
>  			const struct genl_info *info)
>  {
> +	int napi_defer_hard_irqs;

I've already made this a u32 in my rfcv2 branch.

>  	void *hdr;
>  	pid_t pid;
>  
> @@ -191,6 +192,10 @@ netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
>  			goto nla_put_failure;
>  	}
>  
> +	napi_defer_hard_irqs = napi_get_defer_hard_irqs(napi);
> +	if (nla_put_s32(rsp, NETDEV_A_NAPI_DEFER_HARD_IRQS, napi_defer_hard_irqs))
> +		goto nla_put_failure;
> +
>  	genlmsg_end(rsp, hdr);
>  
>  	return 0;

