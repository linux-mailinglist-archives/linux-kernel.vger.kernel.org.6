Return-Path: <linux-kernel+bounces-377163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4512F9ABAA6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 02:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0593A28478F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 00:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126061AAC4;
	Wed, 23 Oct 2024 00:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="stXvqY30"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00B73A8F7
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 00:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729644471; cv=none; b=FUVT9yuQ68ax3KM/0TbP0Ai4VGbrINjbGW4QNDWGG1zHp/Vilhl6aQi+MaoiCYYdKnxyz1qr2C6uSuIG0RKFKBNAC0B07vLyTSWXE337a9eB5M35L1d9FX0rqXeHistrEUbVUm6eA08aIr3p0jjH/xKdbNugyoXcyULO7ZAWdGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729644471; c=relaxed/simple;
	bh=JTijmUUpqtnx7GnCjifgf9sVB4yRXHlwK2giRkk0fEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h67xIXx8q7UtRMdxQV4wnVOjhicJHgPsvPj6KMIxSrGv27qEiuUo2lRNxDeL9Ayr+UQXZU2w7o34Q0rqI5PT3e7ygKalz2SNnlkhm8Ptq3Lt11erF4haa+YpUhlpkEfKJLSZv9SJpLCnGDevTD4d6a457gMPVGGG8R5SSP9kscM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=stXvqY30; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c9552d02e6so7909386a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 17:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729644468; x=1730249268; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OQTL1Ixvyu9GBgkBHMSSAH8WTvSZvQTSYgwd9mQ+ijY=;
        b=stXvqY30K5m2ro53JSRY+WrtX+Se5a20657DPyUDiHG4BRqVRWXl0sgp4vUd7mX2t5
         zX/XW0o5A6VhzwXmZ47t5LJL/6i2BvQii4KcjXbRVxXK0DaKZqFxED6h5n7EUiQHNmu6
         bqP547UPD1wuNbbCX0bPcBNyAVwsIV2Zj36CSzKBBSYH9JtlVy5qlX64Ed7qDkHMbiI7
         T/J5xqBR8p4UR6jcxpw1X8FRQikHMfRbHYlKB0k1tYsR+iW55o2UV/ncL3IUbXrubFLK
         s9uoS7u0KdK7E+0gTeBBfljfkJYnqUcdpt4uWDez00I1iiK5fevDNeiX4zsk2mzitwkT
         0qeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729644468; x=1730249268;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OQTL1Ixvyu9GBgkBHMSSAH8WTvSZvQTSYgwd9mQ+ijY=;
        b=KM0S/waE/wDDDhXh5evjvwPO/SE1MgOxAKRYSTgs/nOtgubm7j4GuoeUla5N9A0ffS
         Fy9xHrJvZEHp6k8+3QzTT5DUKkIqb5nfEsI98KwYa7N7d/FLBLXpKhWHRFB/hOKTuPi4
         W/Blpdv0u+7vSbrpIHTSDYhjCj4WXbOpLBPOpnDDhpmKXqqOQLhs+Ok3mXq2Rvf8qXo8
         9ioERhMGKoEpKpAgltktrDnb+XxX3oaLe/uKbtPiheMHplQYc/P0c/t7IQFi8ks5hJXT
         rFMaHp0p2QHWtwPlHwc53+DqqowlsxYssbUxJ/WJ9Dc+zQQ8X9KEP7PibmxbxWjszHRj
         ihEA==
X-Forwarded-Encrypted: i=1; AJvYcCX7kqbANU/9lVpG6N1WyfLwpMUpovbSCgVbnQdzobFHNHdwMUEObIQ8/0W+TmHmFtftvpE7sx23CIZ8OgE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmb/j7mnQhtd6TcDHp1LpfZcCKlsaVyaMUWmVLiBioSPLqaZqu
	Zd1NB3v4RyscGEF39Mj0FeOcEJr3+Nh6F4/wca+MknMBATC3tq7voB+ttSfack5JACPjWxoUDLF
	AJWRFRMMY7ZNaTLS0GOl2EHhLFGiWAj1J+5AN
X-Google-Smtp-Source: AGHT+IEVqx7O7ORCeR4U/6OdY9r9M+LO12vrLNYYbjZyOxjQVHwbdL54vYjiJg2le7Vro5+Yh+SRJ4tNhaNBsWtRRTQ=
X-Received: by 2002:a17:907:9811:b0:a99:eb94:3e37 with SMTP id
 a640c23a62f3a-a9abf964492mr54242566b.58.1729644467828; Tue, 22 Oct 2024
 17:47:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018105026.2521366-1-usamaarif642@gmail.com>
 <20241018105026.2521366-2-usamaarif642@gmail.com> <CAJD7tkYOGA2oQ=BSP3oXeV0Fh2=QRZZ=_5t2Wg6qrYZixCkZAg@mail.gmail.com>
 <032b5d28-68bb-4fea-91f7-e4a8bc4c4bb6@gmail.com>
In-Reply-To: <032b5d28-68bb-4fea-91f7-e4a8bc4c4bb6@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 22 Oct 2024 17:47:12 -0700
Message-ID: <CAJD7tkYJg08EzZNv39ufJOmc4ekv+9gqrZMrbrqB9VMxYOd9_w@mail.gmail.com>
Subject: Re: [RFC 1/4] mm/zswap: skip swapcache for swapping in zswap pages
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	david@redhat.com, willy@infradead.org, kanchana.p.sridhar@intel.com, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, ryan.roberts@arm.com, 
	ying.huang@intel.com, 21cnbao@gmail.com, riel@surriel.com, 
	shakeel.butt@linux.dev, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

[..]
> >> diff --git a/mm/zswap.c b/mm/zswap.c
> >> index 7f00cc918e7c..f4b03071b2fb 100644
> >> --- a/mm/zswap.c
> >> +++ b/mm/zswap.c
> >> @@ -1576,6 +1576,52 @@ bool zswap_store(struct folio *folio)
> >>         return ret;
> >>  }
> >>
> >> +static bool swp_offset_in_zswap(unsigned int type, pgoff_t offset)
> >> +{
> >> +       return (offset >> SWAP_ADDRESS_SPACE_SHIFT) <  nr_zswap_trees[type];
> >> +}
> >> +
> >> +/* Returns true if the entire folio is in zswap */
> >> +bool zswap_present_test(swp_entry_t swp, int nr_pages)
> >
> > Also, did you check how the performance changes if we bring back the
> > bitmap of present entries (i.e. what used to be frontswap's bitmap)
> > instead of the tree lookups here?
> >
>
> I think the cost of tree lookup is not much and compared to zswap_decompress
> can probably be ignored. zswap_present_test is essentially just xa_load for
> the first entry, and then xas_next_entry for subsequent entries which is even
> cheaper than xa_load.

Maybe it's worth measuring if it's not too much work. IIUC there is a
regression that we don't fully understand with this series, and the
extra lookup may be contributing to that. I think it could be just
fine, but I can't tell without numbers :)

