Return-Path: <linux-kernel+bounces-407453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 830BE9C6DDB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96875B22C0E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAB4201276;
	Wed, 13 Nov 2024 11:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OGkfWs8n"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A27820101A
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 11:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731496431; cv=none; b=bBIeIZvaXSidyTDyM/Ne8ZaWnEt1ED3Zrhn7a0Xfxt1VtNrl2gRrYGXPZa9P+EwaBK3pPvDM1ehS9ZsgcdgFNJHJ2AqiRBaLYJHWrqCsjpgpqom2Wv98qqb0uf9qRJqXCUtwLh8ml1KCHvZ4HKxpJwmYECV+qO8Wan6TqkffzBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731496431; c=relaxed/simple;
	bh=K6heUnefBx/XysT0GjVkCXMhMdWh5uOzZ6wBvj9D3h4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GrVF4QewTX0szu5g6h+RXtpIGbUiu0cDmVVcVJYCGS/OyQW7cb8J7rS25VciooBCZ4ZLIT8SNGupnLMBACGvff5r/G/2jUO5OvvBz27CFrhfHVecuy2+8naWYkobCvrgLEUfcY5dAz0Gnu/Sy9q09zlU8/QJh8KWFg90V5G/F6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OGkfWs8n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731496428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K6heUnefBx/XysT0GjVkCXMhMdWh5uOzZ6wBvj9D3h4=;
	b=OGkfWs8nDk3f93k/Pz63mt8iGsQPkSpSxmlh+nINKN2uu647zTSG7Zg8Bld8TQ+g9h6Jav
	rf+PhyGbxHg5ZVt/bafkdxiOBJNYPCE0gurN81loHSZL6FHDBVClpP/AIaq//GI/eeG+E/
	TNhQWrAdHGvJRlvM+TEg2sPTa2VRR44=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-oYuecEeOORGQhrbRHuuO7Q-1; Wed, 13 Nov 2024 06:13:47 -0500
X-MC-Unique: oYuecEeOORGQhrbRHuuO7Q-1
X-Mimecast-MFC-AGG-ID: oYuecEeOORGQhrbRHuuO7Q
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a99fff1ad9cso543224166b.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 03:13:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731496426; x=1732101226;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K6heUnefBx/XysT0GjVkCXMhMdWh5uOzZ6wBvj9D3h4=;
        b=urEL2TOkRqrOIaETcpOKGHcurRmwgDQGrHuSVixmVmQPeeZC2P1cZ6A2UxSbVUmGAP
         tFzO/+SxBRTSWAWjMmd8NwpoJnBR96/LLYc5ViQplOY0iv9vHuRJlBqw4RO28wUsPCKG
         ceCeIkfjBI2S0n91JG/JPqstZVmYS79p4itXTFlMZmpTPgNXd84F+PV7JyHFQGZ03kl/
         0GgUJgVVW/ufT8m3Q1Qwk4FeOVNycg8+MoHvKcxnAmoPuPxl5QPLOuevHM5l0cDPdbbM
         7F8JBPr2aqOWxt+Gnd2HGItmFl41xS5TO/fqsG0Czax7pm0xOJoYjUTrWzqRQhV/NwS6
         ITDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWN6Um4hJXQ86v1sNoHuPFYwZ9TeiGHdomiF3RMif84kZmLS1GFM1Pw70fjjj4Z7wgbyN7kJ6Avx6EeITs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8QBfTbS77JCJmziqJnS7PkfBXl1iqRzT1kaSjUYYrx0P/3Sz7
	jT53JnssQbktt2l/wKAovpqAcISHay7WcZZ6Rqt8/XVGXpyU/YZdV4Q4u1FIXFjUmbbJ/6XH/vu
	LNBweml//Y0la5V5Vg1mLlrRX/BYoRgcQrA0RmPO54W8fvRKSmAfd+GDHnntGEQ==
X-Received: by 2002:a17:907:3d8f:b0:a9a:c769:5a5 with SMTP id a640c23a62f3a-aa1c57ef3a8mr647384866b.50.1731496426128;
        Wed, 13 Nov 2024 03:13:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqADmkP2C4rClEcqwx1wtnRk3ZcRtmjUzRFnnm4W6YT+sh8g87gsJHxjBz3mkMGvBqlF78hQ==
X-Received: by 2002:a17:907:3d8f:b0:a9a:c769:5a5 with SMTP id a640c23a62f3a-aa1c57ef3a8mr647382366b.50.1731496425619;
        Wed, 13 Nov 2024 03:13:45 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a176e1sm854010866b.31.2024.11.13.03.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 03:13:45 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4D08E164CF1F; Wed, 13 Nov 2024 12:13:44 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Maciej
 Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Magnus Karlsson <magnus.karlsson@intel.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 12/19] xdp: add generic
 xdp_build_skb_from_buff()
In-Reply-To: <20241107161026.2903044-13-aleksander.lobakin@intel.com>
References: <20241107161026.2903044-1-aleksander.lobakin@intel.com>
 <20241107161026.2903044-13-aleksander.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 13 Nov 2024 12:13:44 +0100
Message-ID: <87wmh7wfmf.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> The code which builds an skb from an &xdp_buff keeps multiplying itself
> around the drivers with almost no changes. Let's try to stop that by
> adding a generic function.
> Unlike __xdp_build_skb_from_frame(), always allocate an skbuff head
> using napi_build_skb() and make use of the available xdp_rxq pointer to
> assign the Rx queue index. In case of PP-backed buffer, mark the skb to
> be recycled, as every PP user's been switched to recycle skbs.
>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


