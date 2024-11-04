Return-Path: <linux-kernel+bounces-395206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F669BBA45
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 17:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF70A1F216D9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 16:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7F61C4622;
	Mon,  4 Nov 2024 16:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BLgy17U9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F211C07EF
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 16:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730737348; cv=none; b=gh/8y8TvZA3UQVFRVekvxgRIbweE9UfWJVak+PtDHjxTFx3TTWEmOEBXMca9vZwiYw8ovWaBmeFc9c5b/OzQcywU73sj222FBNNf3bz7OF938VaWtSUtAWR33sJq2cFWrMI/U86OigjTGy0m0scItNTm/HgwYst4vy4ttgFUkjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730737348; c=relaxed/simple;
	bh=IQeGnFrlKcJMyxCdPHDpA8uwABSsBIQVxA+KFfNERGI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EwCE7Z701i4+zCKKRk5Cgyep7hCY8ZfQp8rHUau4FsCpE2TA0nWch1gW9BeLHOZEhofCAf7S6NfNyUhS2xU7mdwIuQsGHI9RAxrkHFrrecCYh1cBTKHy8cmZ1eWE4/GFK1wd/CY/baF2DG7xuA6hGBFMXHQOqkTpBZmwMkjMvsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BLgy17U9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730737345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DDAuBted5dLeURKBGQFzMNRty5vbrd8/225x2WxUwFs=;
	b=BLgy17U9Mz5TrlC8rzJN3pxrQZYLuOVkN3GJ4eYRqNSB8uXPJpeENeuUDll61JJFigKKfe
	DdiQeElsdDU95mjM6HpCuZWyfBti1vkTSH1Znq/OSfz02a5aTNb7ac3284afmwI2k8uC+o
	lrjOSjv6PQqgZpWZJmwwVwWA9IVnKkQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-nmpvpLDROYeODdbhUJvr9Q-1; Mon, 04 Nov 2024 11:22:24 -0500
X-MC-Unique: nmpvpLDROYeODdbhUJvr9Q-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a9a1e429a8fso363947166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 08:22:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730737343; x=1731342143;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DDAuBted5dLeURKBGQFzMNRty5vbrd8/225x2WxUwFs=;
        b=BKbGHAPm9ioaf4coLV0Zga2qPXjbqeajEOIyRzDItC+of288/zdIH3O7U3Q1tO9sRD
         UYbXIo7r0m4wwnb8LtpaBZxBiYZ2g1QPs+lD19Q26SnpBD84MYNlDBPa7NY+yr/P3ovt
         CPh5pt34vHSxa0aq/zCN7Y5v0ugqw4qh/9rE20u3WbAYOoNj+m/UtGE+fKvkAWIrbyqK
         aywCYy5s75neMCKauF7uY4ddTNDS97fZ8PIXthIUfErnDxghhL3DyjiTGVEa/1Q2BvUD
         ZcmksMhDZeZ3oSM8Z/rSnhDLv2qu1gP5ZvZ89kNBI9b/H1cGAJgCDw9is52QpCHBDaAe
         Z/aA==
X-Forwarded-Encrypted: i=1; AJvYcCURj/U565+FVoUl2YYbm4NrenFF3xdRRU+nds7MZOW3tw1HU+eo3lIg68qIPRQFkYPD/BCler9EURqVWcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIAG67YvDid8QIuoe6NHeuLaPzuxYp9kKzLr6xmTVrAu0Upvch
	/4aokSC7DpTSWP6bewVIbli9AWmpf0ionajZuxl4TqZKXr/p+4qM83XMNS8BGn4uHbHeD2w2c4N
	LWpor3nJU8ozy3K2BRR5P7dZh1Ri3+AmxWSNw5i2HaD6gHNVyJJX6g+WfrurjrA==
X-Received: by 2002:a17:907:1c85:b0:a9a:1f38:e736 with SMTP id a640c23a62f3a-a9e654fb423mr1309267266b.31.1730737343245;
        Mon, 04 Nov 2024 08:22:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHOiR6QMYgQdW4+mshnrfOWBlpQZoTzVQuyXvd/zEM+yk9iclHiooZDENzVV+mOV9mrs3qrAQ==
X-Received: by 2002:a17:907:1c85:b0:a9a:1f38:e736 with SMTP id a640c23a62f3a-a9e654fb423mr1309263966b.31.1730737342768;
        Mon, 04 Nov 2024 08:22:22 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb16d9ef8sm1803866b.70.2024.11.04.08.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 08:22:22 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4EE44164C05D; Mon, 04 Nov 2024 17:22:21 +0100 (CET)
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
Subject: Re: [PATCH net-next v3 09/18] page_pool: allow mixing PPs within
 one bulk
In-Reply-To: <1c32ebcd-ae94-42fb-9b18-726da532161f@intel.com>
References: <20241030165201.442301-1-aleksander.lobakin@intel.com>
 <20241030165201.442301-10-aleksander.lobakin@intel.com>
 <87ldy39k2g.fsf@toke.dk> <1c32ebcd-ae94-42fb-9b18-726da532161f@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 04 Nov 2024 17:22:21 +0100
Message-ID: <87y11z7yv6.fsf@toke.dk>
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
> Date: Fri, 01 Nov 2024 14:09:59 +0100
>
>> Alexander Lobakin <aleksander.lobakin@intel.com> writes:
>>=20
>>> The main reason for this change was to allow mixing pages from different
>>> &page_pools within one &xdp_buff/&xdp_frame. Why not?
>>> Adjust xdp_return_frame_bulk() and page_pool_put_page_bulk(), so that
>>> they won't be tied to a particular pool. Let the latter create a
>>> separate bulk of pages which's PP is different and flush it recursively.
>>> This greatly optimizes xdp_return_frame_bulk(): no more hashtable
>>> lookups. Also make xdp_flush_frame_bulk() inline, as it's just one if +
>>> function call + one u32 read, not worth extending the call ladder.
>>>
>>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>>=20
>> Neat idea, but one comment, see below:
>
> [...]
>
>>> +	if (sub.count)
>>> +		page_pool_put_page_bulk(sub.q, sub.count, true);
>>> +
>>=20
>> In the worst case here, this function can recursively call itself
>> XDP_BULK_QUEUE_SIZE (=3D16) times. Which will blow ~2.5k of stack size,
>> and lots of function call overhead. I'm not saying this level of
>> recursion is likely to happen today, but who knows about future uses? So
>> why not make it iterative instead of recursive (same basic idea, but
>> some kind of 'goto begin', or loop, instead of the recursive call)?
>
> Oh, great idea!
> I was also unsure about the recursion here. Initially, I wanted header
> split frames, which usually have linear/header part from one PP and
> frag/payload part from second PP, to be efficiently recycled in bulks.
> Currently, it's not possible, as a bulk will look like [1, 2, 1, 2, ...]
> IOW will be flush every frame.
> But I realize the recursion is not really optimal here, just the first
> that came to my mind. I'll give you Suggested-by here (or
> Co-developed-by?), really liked your approach :>

Sure, co-developed-by SGTM :)

-Toke


