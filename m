Return-Path: <linux-kernel+bounces-406836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C3C9C65D4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 01:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06AA2B2F20E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 23:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FDD21B427;
	Tue, 12 Nov 2024 23:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QDGnReqE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1FC219C8A
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 23:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731452833; cv=none; b=tvruDqyZ/78yzTY2XEM4JrLiTi9LR5VEPdHCxDtEvrAL4aCCp3YBwyTWUtAW6Do+IKHrBsyBVZfxHJs1WMc6RqUtY9oc1EbNYwvCJbC/Z0Xmb6eDsxkM70L9A+2IxL4C78q0G7Z44L75BMdpVI5gdXAtoNR9j7Wnau9rrTsFJWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731452833; c=relaxed/simple;
	bh=TFy3fU/4I2GpEadKr7IhLMNlWmHyK3B0PI16A0z0L/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+N3tmu7Csz6WXtqIIVqFkLyq7HEI9a6qsfqimpgr6+72dyExL+113SNMoj8hhwNqhB5nldVfIg0zO61HqrdWF/pviipBr4+rQktBPkGepeVVRVyK5cIRfpt8PNVE5UxeXXVkw64bH5onRT2DrYF8tZlAu3H+n/mGv2Qc+eqHzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QDGnReqE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731452830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LE/PCh+Wa1FzY66oOB8AxWyuC5tcu2XLg9eirKv3WLg=;
	b=QDGnReqEQ3XAqkLIEmkoC2Ty1uKkIfB7QF4uKfBy4wmQY5YK2tnCE07xQG1q8OoyVpay05
	xjGRi7TZx0UJcKqcDcGaFR0Gi/+WpEp7VTcLdxNIs2Wldor0Fmcd/IDlYBD/VSIfNPlUbL
	Uds79oNzSPUka+X4EGzBr7cHeNGv5jc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-MnFH-b77PzSngY9wFOdGog-1; Tue, 12 Nov 2024 18:07:08 -0500
X-MC-Unique: MnFH-b77PzSngY9wFOdGog-1
X-Mimecast-MFC-AGG-ID: MnFH-b77PzSngY9wFOdGog
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43151a9ea95so587815e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 15:07:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731452827; x=1732057627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LE/PCh+Wa1FzY66oOB8AxWyuC5tcu2XLg9eirKv3WLg=;
        b=Ef/Gw7sduDqBJDscyqsUFDOskEP1U0vVNAgqGmA6RryND38jLsQoTrUrlSJP8xtnPl
         Hn+snMugdESFsYTIBrxC+fZXLLlxYD7Eu1l/kALVHglZGTtJstPmRrye8o1j72sSMklp
         1apHeL6gQM2iGRXvaiGVECa2zz5Qi1AlxcMBl7Hs24nuhGQ71EbK0fVKg4cpWS/vABaL
         JorRYp2u8AJIiyvcU8Q1wnEUBYQsYdhbX+Oyx/sumDiMZeG09jyN85umBx0TnlPqaLvU
         I173h3+GCdmXsL76msZkcgOetPQGMQkHB248PJ8li2QLiRMTHU8qXsER0TD2VM7tonHh
         cBuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOS1S8Rhka1bj5ImdTDUefthEqYQKFSN4uMkn15zAbhr/PiWF8IJaEaOLK38TjLRu/2BVsAnUYuOnHn4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyULWVpkaupupEwtzZFueMUbyhXKkiE8IXn3XqxhMj1ZFOYxFAU
	FzYMwEOMb0mYs7syB0ftn+AwtU4T5jYmcypAWnpG/Vs44q6Sfn6PPBbOh05VKa9XwZeqAY5L9pD
	wzlp6xzNPtxaCDtP/NIlgcWgvRaE/HBp3rNsFLmfIOU6EwYuE1BzAk6dXtAt4XQ==
X-Received: by 2002:a05:600c:444a:b0:42c:b603:422 with SMTP id 5b1f17b1804b1-432b748015bmr146675395e9.8.1731452827518;
        Tue, 12 Nov 2024 15:07:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFG91DAj9dtbmBJmaPVjIVaDJVRfiBwwHIq3NwnUafHc3Lid0KCyDysuuqaOuhfXgM1r68lOQ==
X-Received: by 2002:a05:600c:444a:b0:42c:b603:422 with SMTP id 5b1f17b1804b1-432b748015bmr146675275e9.8.1731452827184;
        Tue, 12 Nov 2024 15:07:07 -0800 (PST)
Received: from redhat.com ([2a02:14f:17b:c70e:bfc8:d369:451b:c405])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d54e8015sm2478145e9.7.2024.11.12.15.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 15:07:05 -0800 (PST)
Date: Tue, 12 Nov 2024 18:07:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gediminas Repecka <gediminas.repecka@gmail.com>
Cc: jasowang@redhat.com, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vdpa: vdpa_sim: vdpa_sim_net: fixed cofing style issues
Message-ID: <20241112180522-mutt-send-email-mst@kernel.org>
References: <20241107191941.37300-1-gediminas.repecka@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107191941.37300-1-gediminas.repecka@gmail.com>


On Thu, Nov 07, 2024 at 09:19:41PM +0200, Gediminas Repecka wrote:
> Fixed coding style issues reported by checkpatch script
> ---

A lot is wrong with this submission, given it's supposed to fix
checkpatch:

- no signature
- typo in subject
- not using direct voice (Fix, not Fixed)


pls fix and resubmit

>  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> index 6caf09a1907b..0705aff74cf3 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> @@ -53,7 +53,7 @@ struct vdpasim_cq_stats {
>  	u64 errors;
>  };
> 
> -struct vdpasim_net{
> +struct vdpasim_net {
>  	struct vdpasim vdpasim;
>  	struct vdpasim_dataq_stats tx_stats;
>  	struct vdpasim_dataq_stats rx_stats;
> @@ -293,7 +293,7 @@ static int vdpasim_net_get_stats(struct vdpasim *vdpasim, u16 idx,
>  	unsigned int start;
>  	int err = -EMSGSIZE;
> 
> -	switch(idx) {
> +	switch (idx) {
>  	case 0:
>  		do {
>  			start = u64_stats_fetch_begin(&net->rx_stats.syncp);
> @@ -543,7 +543,7 @@ static struct vdpa_mgmt_dev mgmt_dev = {
>  	.ops = &vdpasim_net_mgmtdev_ops,
>  	.config_attr_mask = (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR |
>  			     1 << VDPA_ATTR_DEV_NET_CFG_MTU |
> -		             1 << VDPA_ATTR_DEV_FEATURES),
> +			     1 << VDPA_ATTR_DEV_FEATURES),
>  	.max_supported_vqs = VDPASIM_NET_VQ_NUM,
>  	.supported_features = VDPASIM_NET_FEATURES,
>  };
> 
> 2.34.1


