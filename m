Return-Path: <linux-kernel+bounces-430937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A870D9E3784
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AB89B2E75D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C014019E982;
	Wed,  4 Dec 2024 10:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cTu10DPk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F5A1AA1DF
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 10:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733308028; cv=none; b=nK01HnEDoBoyq2LoA5k5XgSbxhkaaW8iakGUBbjRj6jtYzypLBpayzFKp921dgDGaAh+hn3alf+eJUTrB7uN48xgzIMUNj4Ay+Vh7lT5qg58Qudv9P9B2S1RjJyk+Kcgkn5Dd1WnLdQhyTikV4M0Ht5lfEk6iXAuR4KNvAyJ0yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733308028; c=relaxed/simple;
	bh=TcvLj2S2OjDxK6FFIIsAz8V5/hiEAxoKPJXKYM4G2K4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DxmykLjtzrXC4FfZB3dugcAwDwo67zrXPNF+NqwkXaSOvXHJAKApIHTXebmJ87s/MA7gCX4+Nig1MbdKIqd0faTlKE8B5EQf2zh7Sw7d4KZJutOmjX1spGcnYkIPzQhNssy2UbHGNtEIOuU+KZRGm+ks5123GAxV0Im5/iwQJdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cTu10DPk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733308025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TcvLj2S2OjDxK6FFIIsAz8V5/hiEAxoKPJXKYM4G2K4=;
	b=cTu10DPkaZMuj859idm4LCfo+z+ZGb+FgCEYwILtpsq69mnr5taWzgw5qMooCIF9Blt6Kh
	XgPgkIYF3sebDr11jSseDEvxxku2jydcEhVumlyjo46caDjLrG8eTLVwYFComa3NAl7V2H
	xL9SI3JIhAZoaywsAQUjgaq4wXrQ90E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-kxQli7LOMtmzkwIX-LkJbw-1; Wed, 04 Dec 2024 05:27:04 -0500
X-MC-Unique: kxQli7LOMtmzkwIX-LkJbw-1
X-Mimecast-MFC-AGG-ID: kxQli7LOMtmzkwIX-LkJbw
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-434a90febb8so37608485e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 02:27:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733308023; x=1733912823;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TcvLj2S2OjDxK6FFIIsAz8V5/hiEAxoKPJXKYM4G2K4=;
        b=e+NWzeUHF4Nj3Or4lBrBFCeRYFyfN7G+zSckEXSIdQP2Bu8a6KHNTpNHy5pxtm28hq
         Zq2QOCsHA5LKGWTbN5ryE2x+aaFYrg1mO021eTtaW1rNF2m8CNa6uVk8emPdnVXxJMss
         CX8QDZJ0LX9SgQW6gh9zcRGUEhGsG5YdbV5oP3FvhG3sUx33UKFmj/lHgKoP8os6qD6M
         qw8+3uwyptwKMute9brph3oP5e6VEDhQu+xV4AyGXbrMjZJryVdr/SvkgXrvkCO9SzqO
         6XWR1++uyb2d54b5zhrm/dT0lzBp5hJ/E1t5oymQDKIrj0mdQQTPTMExDmvl4/zAL++3
         Bbyg==
X-Forwarded-Encrypted: i=1; AJvYcCXI6EMha4Uf+PD02XxyAxHOUrKN1SRV+MBuCdTQ8eEDZUcRnv3/FzBcgSdsQ99j55KxJg37u5JTLWmf5co=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgbNhCHmElJPv92rDPQEYOVe5hjPwFX7bmU131uqLlKwGxzGgC
	E7Lfg+Cs0guIDgA+8iInP6b/LDnU0a73W5TXi9vJV52BThQLDBNNyEU8fJzaj6pgZu0xy9UKd6r
	w/wQR0HhScxxGr1lXkVXXrbjK0ggR/TAt3cM2BURhvqryXlRzPj+EHYTDfrn9ZQ==
X-Gm-Gg: ASbGnctHwxnMS66EQ3XvsQzYTzuOneooCEwaqtLpgmNmFsg9Km466s9OJcOjVvcV+ir
	RrXvZRtdvDQsCjrHI5oLaUijFNhHCTpXUbnzCymzLXpuI1QLFoqKXYBuzGtrtYs49oHk20Fi21+
	dXdQSPTm2wj1tSRmgg0GAMbsID99IMs3ADA9QkuIbHdfXXPNwoo/eGSZniQkQ0YiAXhNvOcBU/p
	uZJ1l1xHTThLIiXSUl4K9+3cGUMS5uDIitk9EpLyti9Jco=
X-Received: by 2002:a7b:cb53:0:b0:434:a0fd:f9d1 with SMTP id 5b1f17b1804b1-434d3fcc5a1mr27614225e9.20.1733308022857;
        Wed, 04 Dec 2024 02:27:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrwtYSrQPLjelyylTwa5mbuvmc0j1pKxbIGN9w4X2omiDFt+X87GdnSjiNK+8A1PwN0nLaeg==
X-Received: by 2002:a7b:cb53:0:b0:434:a0fd:f9d1 with SMTP id 5b1f17b1804b1-434d3fcc5a1mr27613995e9.20.1733308022549;
        Wed, 04 Dec 2024 02:27:02 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d527e8besm19322735e9.13.2024.12.04.02.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 02:27:01 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 0AA1416BD104; Wed, 04 Dec 2024 11:27:01 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 01/10] xsk: align &xdp_buff_xsk harder
In-Reply-To: <20241203173733.3181246-2-aleksander.lobakin@intel.com>
References: <20241203173733.3181246-1-aleksander.lobakin@intel.com>
 <20241203173733.3181246-2-aleksander.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 04 Dec 2024 11:27:01 +0100
Message-ID: <87wmgfaglm.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> After the series "XSk buff on a diet" by Maciej, the greatest pow-2
> which &xdp_buff_xsk can be divided got reduced from 16 to 8 on x86_64.
> Also, sizeof(xdp_buff_xsk) now is 120 bytes, which, taking the previous
> sentence into account, leads to that it leaves 8 bytes at the end of
> cacheline, which means an array of buffs will have its elements
> messed between the cachelines chaotically.
> Use __aligned_largest for this struct. This alignment is usually 16
> bytes, which makes it fill two full cachelines and align an array
> nicely. ___cacheline_aligned may be excessive here, especially on
> arches with 128-256 byte CLs, as well as 32-bit arches (76 -> 96
> bytes on MIPS32R2), while not doing better than _largest.
>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Ohh, didn't know about that attribute - neat!

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


