Return-Path: <linux-kernel+bounces-407445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D336F9C6D82
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 911AA2839A2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AAA1FF5F2;
	Wed, 13 Nov 2024 11:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IZrIaotl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250E41FEFDE
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 11:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731496414; cv=none; b=LfbCEG0WgAFd+5Qk/3lqlewkgdgyP5IQOU0aePk2fIabvKsr28XdwhJ6Lo3w+OGHPexgBtVoyyxM3TKvDzT0n46G9kKNBRAbD7wUSVmcTox7R/Sebv/AO7nL8NWJYMJvcTI8UZQKYb/bDse2NToCET58pP17pFuOo5SB0IFiy2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731496414; c=relaxed/simple;
	bh=22tXa6W66/9VsYnPQrGRCitE2eppvQQ0IMbf6+LEBjc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LxzkrY6Y/RUEGcJmF9KfEBmkdDxqmdUxN/ZeHc1wnfYYoRmxCVQqT2vRK0XeoIDaZVJxvSMfOLL2P8ZnhfiBOTwVlMgE94oDyNi/vqt4QCtN1c/OGGEYSYJRGtk74zqD5flHIVlAR5zM0p5Cj1uP7P+QKFRhYcxbcmz2Hz9IbjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IZrIaotl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731496412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7KH3jFAzHQ+vGvm3mHBwhCVY2i7N56HbwqH72OHd34o=;
	b=IZrIaotl/w6Gbj5ZnWhfjgOPptZuQQ89t20n4qwYkDZttFzVl2AnFeZ4fOXMT79iCd1Hql
	ClEam7/tFiqonUd7RaYZqCqVXydwYiehG3N3K1ooFaNLMWSEwBqd6Ij1/H8JTCIFgCNVJp
	isZbNjBrZF7xg+A9OiCuyPiuLtPdBAo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-kDRdQk3JOwWdkOt8Vm7H4A-1; Wed, 13 Nov 2024 06:13:31 -0500
X-MC-Unique: kDRdQk3JOwWdkOt8Vm7H4A-1
X-Mimecast-MFC-AGG-ID: kDRdQk3JOwWdkOt8Vm7H4A
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4316e2dde9eso62341255e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 03:13:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731496410; x=1732101210;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7KH3jFAzHQ+vGvm3mHBwhCVY2i7N56HbwqH72OHd34o=;
        b=P3Q2mtmMMxFgztS3aUOTcWwrtJ2mC3HsDUi8u0xQLbp1XeeHSw1CnvCC7q8dY1JFca
         MuOk2d4f9YWIukYzjrgJ3zjaekFV9GqDMJovPahBAER0DhsHeU902t6K0e8HdjbURJkp
         LoxgPyEA5KAFLS34yXOrYo/bCsSTQ8WeuMWILxuCJxXJU7iZofvReStx0+X0Bw+4WJgk
         mbpfEEH2oH+fBcoZrVVd0uI29HlpBEQ9LGT47/qJFbDXRUGA0eFalDtL3gpT24X3PlQ0
         YBTKIvCOzoYjLzz/PbKCVnAs6omLoznROS+F5ixuSIvdgJ5iAHNbu9p/6dT+a+PcuRoR
         2nyg==
X-Forwarded-Encrypted: i=1; AJvYcCXHDBqHjyd7YcuGYnKP3kwMaB+DjTJys5WYoJq1m0ZOuDHCOO4r96svLTDTNT775rR2gx55bZYiObkyIU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgbfMcOMpAu8jyjBcteFf14mquQ7LpTAYkbTtV7JXMmCJjE1/n
	RqMeOhMm9peVVQppEVDe553vlsmRPdnzgOHu2CPv8hnXRKsLfg3yyNUYc+Lqp4s3OJWb9A7t+ip
	e7SvH3Fxhxc+08ARBO6+u/21hbQdJE+MLVfVblr0sIqtaORtUtEkycIzMOzgpEg==
X-Received: by 2002:a05:600c:35c4:b0:431:5f8c:ccb9 with SMTP id 5b1f17b1804b1-432b750b51fmr240149595e9.17.1731496409754;
        Wed, 13 Nov 2024 03:13:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9RucFV9Ew08qPy5i1G8sCR+OaEbhk/PQOtNp5R4sHWFEKUlGZQkpKroCT+e+qPw1wj5q18g==
X-Received: by 2002:a05:600c:35c4:b0:431:5f8c:ccb9 with SMTP id 5b1f17b1804b1-432b750b51fmr240149255e9.17.1731496409386;
        Wed, 13 Nov 2024 03:13:29 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381eda05f89sm17970671f8f.98.2024.11.13.03.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 03:13:28 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id B9F7B164CF1D; Wed, 13 Nov 2024 12:13:27 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 12/19] xdp: add generic
 xdp_build_skb_from_buff()
In-Reply-To: <e35afda3-a64a-432e-a69d-80519eb0ff33@intel.com>
References: <20241107161026.2903044-1-aleksander.lobakin@intel.com>
 <20241107161026.2903044-13-aleksander.lobakin@intel.com>
 <875xot67xk.fsf@toke.dk> <e35afda3-a64a-432e-a69d-80519eb0ff33@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 13 Nov 2024 12:13:27 +0100
Message-ID: <87zfm3wfmw.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Date: Mon, 11 Nov 2024 17:39:51 +0100
>
>> Alexander Lobakin <aleksander.lobakin@intel.com> writes:
>>=20
>>> The code which builds an skb from an &xdp_buff keeps multiplying itself
>>> around the drivers with almost no changes. Let's try to stop that by
>>> adding a generic function.
>>> Unlike __xdp_build_skb_from_frame(), always allocate an skbuff head
>>> using napi_build_skb() and make use of the available xdp_rxq pointer to
>>> assign the Rx queue index. In case of PP-backed buffer, mark the skb to
>>> be recycled, as every PP user's been switched to recycle skbs.
>>>
>>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>>> ---
>>>  include/net/xdp.h |  1 +
>>>  net/core/xdp.c    | 55 +++++++++++++++++++++++++++++++++++++++++++++++
>>>  2 files changed, 56 insertions(+)
>>>
>>> diff --git a/include/net/xdp.h b/include/net/xdp.h
>>> index 4c19042adf80..b0a25b7060ff 100644
>>> --- a/include/net/xdp.h
>>> +++ b/include/net/xdp.h
>>> @@ -330,6 +330,7 @@ xdp_update_skb_shared_info(struct sk_buff *skb, u8 =
nr_frags,
>>>  void xdp_warn(const char *msg, const char *func, const int line);
>>>  #define XDP_WARN(msg) xdp_warn(msg, __func__, __LINE__)
>>>=20=20
>>> +struct sk_buff *xdp_build_skb_from_buff(const struct xdp_buff *xdp);
>>>  struct xdp_frame *xdp_convert_zc_to_xdp_frame(struct xdp_buff *xdp);
>>>  struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
>>>  					   struct sk_buff *skb,
>>> diff --git a/net/core/xdp.c b/net/core/xdp.c
>>> index b1b426a9b146..3a9a3c14b080 100644
>>> --- a/net/core/xdp.c
>>> +++ b/net/core/xdp.c
>>> @@ -624,6 +624,61 @@ int xdp_alloc_skb_bulk(void **skbs, int n_skb, gfp=
_t gfp)
>>>  }
>>>  EXPORT_SYMBOL_GPL(xdp_alloc_skb_bulk);
>>>=20=20
>>> +/**
>>> + * xdp_build_skb_from_buff - create an skb from an &xdp_buff
>>> + * @xdp: &xdp_buff to convert to an skb
>>> + *
>>> + * Perform common operations to create a new skb to pass up the stack =
from
>>> + * an &xdp_buff: allocate an skb head from the NAPI percpu cache, init=
ialize
>>> + * skb data pointers and offsets, set the recycle bit if the buff is P=
P-backed,
>>> + * Rx queue index, protocol and update frags info.
>>> + *
>>> + * Return: new &sk_buff on success, %NULL on error.
>>> + */
>>> +struct sk_buff *xdp_build_skb_from_buff(const struct xdp_buff *xdp)
>>> +{
>>> +	const struct xdp_rxq_info *rxq =3D xdp->rxq;
>>> +	const struct skb_shared_info *sinfo;
>>> +	struct sk_buff *skb;
>>> +	u32 nr_frags =3D 0;
>>> +	int metalen;
>>> +
>>> +	if (unlikely(xdp_buff_has_frags(xdp))) {
>>> +		sinfo =3D xdp_get_shared_info_from_buff(xdp);
>>> +		nr_frags =3D sinfo->nr_frags;
>>> +	}
>>=20
>> Why this separate branch at the start of the function? nr_frags is no
>> used until the other branch below, so why not just make that branch on
>> xdp_buff_has_frags() and keep everything frags-related together in one
>> block?
>
> Because napi_build_skb() will call build_skb_around() which will
> memset() a piece of shared info including nr_frags.
> xdp_build_skb_from_frame() has the same logic. I'd be happy to have only
> one block, but I can't =3D\

Ah, right. Annoying, but OK :)

-Toke


