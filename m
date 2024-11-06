Return-Path: <linux-kernel+bounces-397844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4019BE158
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25230282D4C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 08:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B680C1D5CE0;
	Wed,  6 Nov 2024 08:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ORWrp1OH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C07F1922EF
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 08:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730883277; cv=none; b=BX95bMRi1qYw0rtCiBAlUQx3Xeg8LiFJH3sLTJcGRUQO72xR6lu7E482qlURdMHs7vVmZ0jhCVqQXcaz/8ckAAVrTM7kXCHazYzwnY8qxVK9g/2hsmW1xS1HEQ7qxagxMhkJ0cCX7h+o5DijkQNa7lYImrafzIlzlHntY0qjJAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730883277; c=relaxed/simple;
	bh=UNYKLzF4r5hBnINqn9birE+zQ/11rAm97XqSomm41EU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4V51H0Qryh0sMAM0bM/mAooAYYYKTPRBsnCuXAqotefqzbjiSAp+l6ilEoXmfvLrQzr6akXuA+WaZPUAyQg+HL34GKxDnJemqFFubh/KT92FBYti8NWOx+UBHHgjpeaRO5G3lhYZ3dFt7453yQDUWEsBu7QwI0JPx5ejSudsmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ORWrp1OH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730883274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fmyYpFxsyQqqojb1lv2cOtlXLCoNWTfRHptpZLl1D5g=;
	b=ORWrp1OHJYhZOo7sjM8zSdMy1raWVfKbohf7xbeAyT2RtqO2Lwn4fTclXcaAYxSfj8SgJY
	adAgsFl0F3NmO+YlE3z08tiGr1MBFLctVN//jSM4rGum9bfi7G1rlnfzmDwTuTlhwpjm1v
	1THOfUGFk/5/V7Z73AoOaYWgw+f7UrY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-GdNbLTgtMH2TUZm7S17Hsg-1; Wed, 06 Nov 2024 03:54:33 -0500
X-MC-Unique: GdNbLTgtMH2TUZm7S17Hsg-1
X-Mimecast-MFC-AGG-ID: GdNbLTgtMH2TUZm7S17Hsg
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37d3e8dccc9so3619551f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 00:54:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730883272; x=1731488072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fmyYpFxsyQqqojb1lv2cOtlXLCoNWTfRHptpZLl1D5g=;
        b=caTR5GJ0Tv5Rbus4uo99hS2o5rOuTHgmNQ6hLrjBTVo3enmxuApaMkobTPiOHVMHdw
         y1ckfGyFjawr5T6iQf0RIcI0qjXyOhLrSHfQghZG72+hhS9jryZOyubIHKoO+EwIN8nR
         whTZef6tg+l5/jgM847kGpaTy88kCQQKSriAdPMO0jLOSPsjR8FKJ/OAQ+v+IDS07C3L
         FHFCjm1tL5kDoApe8j4tzn/XVV7vwwz37vEdSII0OW9omttvtUr8SnMqBdYfYltLs8Vm
         sExut1/m/nsrHMsFyhbLyX2f9cmMObf1cRZv7xbJ24UhUj7OH16rHu+SJkcat77q04aj
         Q1Mw==
X-Forwarded-Encrypted: i=1; AJvYcCWpp9o0ck+oXlqfguumNKv6ycsNIMIzZSXD3k5riEPEr2lPGzXm4QEHtsfPu61DG1nr2WgBlyqTF1BW6Vg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEG6CwoeYdh2n1hEWdWjnZT0XjfKSQMfHPceKx6xmiqZLPbrCT
	JHVQO40inA80tiyyeC3NSdV1bC5X7opRGKgOOc143LUyUMu7NUXF39Eq12DD1w2KxAap6+kumQ8
	y1ruhXfH0zLteEKbVIdt3JZ8sqNS69loQKZuk3BNOsLF8YNvnVJEFlimJJAilFw==
X-Received: by 2002:a05:6000:4601:b0:381:e702:af15 with SMTP id ffacd0b85a97d-381e702b189mr2660253f8f.37.1730883271948;
        Wed, 06 Nov 2024 00:54:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEs4dAlZ/Ixnt7FpOJvTxE+WzTktExbu7DVSB0TSOaCg2HjETlp7pqbWm4LVa4ZdPMRcAZxg==
X-Received: by 2002:a05:6000:4601:b0:381:e702:af15 with SMTP id ffacd0b85a97d-381e702b189mr2660237f8f.37.1730883271620;
        Wed, 06 Nov 2024 00:54:31 -0800 (PST)
Received: from redhat.com ([2a02:14f:178:e74:5fcf:8a69:659d:f2b2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c1168afcsm18469576f8f.91.2024.11.06.00.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 00:54:30 -0800 (PST)
Date: Wed, 6 Nov 2024 03:54:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost/net: Set num_buffers for virtio 1.0
Message-ID: <20241106035029-mutt-send-email-mst@kernel.org>
References: <20240915-v1-v1-1-f10d2cb5e759@daynix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240915-v1-v1-1-f10d2cb5e759@daynix.com>

On Sun, Sep 15, 2024 at 10:35:53AM +0900, Akihiko Odaki wrote:
> The specification says the device MUST set num_buffers to 1 if
> VIRTIO_NET_F_MRG_RXBUF has not been negotiated.
> 
> Fixes: 41e3e42108bc ("vhost/net: enable virtio 1.0")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

True, this is out of spec. But, qemu is also out of spec :(

Given how many years this was out there, I wonder whether
we should just fix the spec, instead of changing now.

Jason, what's your take?


> ---
>  drivers/vhost/net.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index f16279351db5..d4d97fa9cc8f 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -1107,6 +1107,7 @@ static void handle_rx(struct vhost_net *net)
>  	size_t vhost_hlen, sock_hlen;
>  	size_t vhost_len, sock_len;
>  	bool busyloop_intr = false;
> +	bool set_num_buffers;
>  	struct socket *sock;
>  	struct iov_iter fixup;
>  	__virtio16 num_buffers;
> @@ -1129,6 +1130,8 @@ static void handle_rx(struct vhost_net *net)
>  	vq_log = unlikely(vhost_has_feature(vq, VHOST_F_LOG_ALL)) ?
>  		vq->log : NULL;
>  	mergeable = vhost_has_feature(vq, VIRTIO_NET_F_MRG_RXBUF);
> +	set_num_buffers = mergeable ||
> +			  vhost_has_feature(vq, VIRTIO_F_VERSION_1);
>  
>  	do {
>  		sock_len = vhost_net_rx_peek_head_len(net, sock->sk,
> @@ -1205,7 +1208,7 @@ static void handle_rx(struct vhost_net *net)
>  		/* TODO: Should check and handle checksum. */
>  
>  		num_buffers = cpu_to_vhost16(vq, headcount);
> -		if (likely(mergeable) &&
> +		if (likely(set_num_buffers) &&
>  		    copy_to_iter(&num_buffers, sizeof num_buffers,
>  				 &fixup) != sizeof num_buffers) {
>  			vq_err(vq, "Failed num_buffers write");
> 
> ---
> base-commit: 46a0057a5853cbdb58211c19e89ba7777dc6fd50
> change-id: 20240908-v1-90fc83ff8b09
> 
> Best regards,
> -- 
> Akihiko Odaki <akihiko.odaki@daynix.com>


