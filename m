Return-Path: <linux-kernel+bounces-355732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF38995627
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB5D81C24F91
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 18:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3A721263A;
	Tue,  8 Oct 2024 18:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fMHH7lhR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3C020ADC9
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 18:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728410746; cv=none; b=SPScexRgp+som6pqwmd8glA5Ez+Ii6a2SDjabIRXncBBoR3uRWFHiYM/pjNllPLrUsfxZCMXfB7ydrA69eRKzZQyQX9UAD+X1nGNf7cILpz9xgWGIHOoM8T6snwUbW9ZfonKCe6t8lWhpHLayvzPjl9HgVAbaizYFY3q6G3A5K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728410746; c=relaxed/simple;
	bh=0ZJ9Kfi2/3ZVmnGg5XdNIcP4NBU6ZMHiswIrHiHb2f8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2OOXur/LmUA2n+xOyhPw3yp8rYZSC1lj3X5wCPzoWt+F9brNWQbRuw0gP+ObvSmFg5LqyjyXZXxdHhuHUVORbgKgKYXmSr1lOvhW30ApLchpIB9mK6FiNi/6M99oHc9HVFwRXXkyalbXXS5UGRzyFagMAhMAkf8X0Votou+a4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fMHH7lhR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728410744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cf/DHV7oLxh4iefN5n7XoZ0U+zeNpvhDR5hTkGJTKcg=;
	b=fMHH7lhRlWtzDCr2zk4ZQoH/iKpUfE79Q4sAIOscBk+Z3qpvUkXIv0whXm+rEoKXJ2yLHt
	y60p2X0j0cljsnFQJlyqFZecxNirLr466SC2sO0Tyd+kCmnRf/PPcFp4O/DwaGezTYDVPG
	Em88fJKLuypteubAiqNYi2hUrcfP+xQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-lOmYp5gON1aJu2NRiLMchw-1; Tue, 08 Oct 2024 14:05:42 -0400
X-MC-Unique: lOmYp5gON1aJu2NRiLMchw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42cb479fab2so227985e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 11:05:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728410741; x=1729015541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cf/DHV7oLxh4iefN5n7XoZ0U+zeNpvhDR5hTkGJTKcg=;
        b=nir0hfAVV82nQ1XJB+P3ppyMB+nDPKZC6LP16DrVrKpNcCktJ5ZoUBkMD0b9PgzM6G
         9dyOTZs3sxaPnaRr+3u+BL0SZWpnEk7DFgvhrh908RDwJfLcMVEgsO1j5MgJbALZ45cN
         S59yfNjf6GBC5Xr6YlAMSBge2OvK++9VvNa2NtZOipUD2G9d6bUvy7U1b4SUfTSQCv5f
         LDjqrHHcN+uRnRTUkAGdl7REdtCqDkxNupvpVr1JZqHLCOApF698oyLQQeI2tnd454cx
         wlXxnK1RHxAo2ByVLGaqN4m0fbM6P8Syl+Hc0M60WiwWV3+/Xprw1vqkBLRoF9P693Ze
         pDPw==
X-Forwarded-Encrypted: i=1; AJvYcCXJPlMhNmx7QOjBj232/up8hrefFV2YwjYhf+WCS+GJ1lXQLUVx5ZxgluNxvZYStCJ/N94Chx2JzjVavFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzBXVM+0+bNJhd6z6QOCPP1Nohoa3+I+e5bkEs16WslbeDg/NE
	WXl92OxhZeSB/Kh1DSTCZhf1GmsJmDeeM2jQxH60vLXjWD5ZAOLB6OXNYrKSvBj+abLOH6entbc
	RIOklwSMVJWBP9mecSm7d+TeUz4ADNt4QLbtb5tt67VTdvMyVEW+CpbBOQPpN7g==
X-Received: by 2002:a05:600c:19cf:b0:42c:baf1:4c7 with SMTP id 5b1f17b1804b1-42f94bbbc66mr26152175e9.4.1728410741690;
        Tue, 08 Oct 2024 11:05:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGn/zGotqhdU0OvWYc4zxxmP0jbahwuVnwxX51uqAoJ+7xbY5+5crrA52HpfOrOXdsZrcx9jw==
X-Received: by 2002:a05:600c:19cf:b0:42c:baf1:4c7 with SMTP id 5b1f17b1804b1-42f94bbbc66mr26151925e9.4.1728410741344;
        Tue, 08 Oct 2024 11:05:41 -0700 (PDT)
Received: from debian (2a01cb058d23d6009ada0857e99733e4.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:9ada:857:e997:33e4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43056f0ed3csm15275165e9.2.2024.10.08.11.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 11:05:40 -0700 (PDT)
Date: Tue, 8 Oct 2024 20:05:38 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: idosch@nvidia.com, kuba@kernel.org, aleksander.lobakin@intel.com,
	horms@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, dsahern@kernel.org, dongml2@chinatelecom.cn,
	amcohen@nvidia.com, bpoirier@nvidia.com, b.galvani@gmail.com,
	razor@blackwall.org, petrm@nvidia.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v6 08/12] net: vxlan: use kfree_skb_reason() in
 vxlan_xmit()
Message-ID: <ZwV0cjdg2x67URMx@debian>
References: <20241008142300.236781-1-dongml2@chinatelecom.cn>
 <20241008142300.236781-9-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008142300.236781-9-dongml2@chinatelecom.cn>

On Tue, Oct 08, 2024 at 10:22:56PM +0800, Menglong Dong wrote:
> Replace kfree_skb() with kfree_skb_reason() in vxlan_xmit(). Following
> new skb drop reasons are introduced for vxlan:
> 
> /* no remote found for xmit */
> SKB_DROP_REASON_VXLAN_NO_REMOTE
> /* packet without necessary metadata reached a device which is in
>  * "eternal" mode

That should be "external" mode (with an "x").

> +	/**
> +	 * @SKB_DROP_REASON_TUNNEL_TXINFO: packet without necessary metadata
> +	 * reached a device which is in "eternal" mode.

Here too.

> +	 */
> +	SKB_DROP_REASON_TUNNEL_TXINFO,
>  	/**
>  	 * @SKB_DROP_REASON_LOCAL_MAC: the source MAC address is equal to
>  	 * the MAC address of the local netdev.
> -- 
> 2.39.5
> 


