Return-Path: <linux-kernel+bounces-274043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0379471D8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 01:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06920B20A9A
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 23:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D5C13C820;
	Sun,  4 Aug 2024 23:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3fhYJD3"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0850A18046;
	Sun,  4 Aug 2024 23:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722815913; cv=none; b=U7Y+fzxek/HEhRmG95A8kBc+tb67MJ8SSEqmTAqCTN/lUwRyyrkJwOAp+tVyUaQmaHVyCroT39H4S4+Rp5bdA+gBmaiEWBaRQemSoNbe/HkMWVJ/10VLTtGL68dLyp2GwbTjEf594QRpcvk/9ybnx0z82Jj4NHqsYrYahd2RdmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722815913; c=relaxed/simple;
	bh=sUu8a+4knCda7M2ZhgR+RVXJn/EslxOawTlHsnogx0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rn4YfI8xAPdRVlP2OWw+ObGC0BGSYBpm5KV4LRAkiOoz+hHGXT0rJp/gqFVNShkXgT9uZiRoCQlkY6CfYXNcA+o1JpRTkaK/9JmPHyHf8eJIkWok2ZfxbCEeZkqJkVMtfYxGcAIbSGiBW/QHcj+8JqgX3LnJpkcQaoBlyqKStkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3fhYJD3; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a1e1f6a924so652006985a.1;
        Sun, 04 Aug 2024 16:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722815911; x=1723420711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpM5H1TDUfySJ43uH4f1cuN6lW8oKfIMeXGJAKsYgdc=;
        b=h3fhYJD3OdA/YgXXXgIGoK2L4U3yGuIN3BVu+c5F1R4UIz98MUKpPxd0i4gte4/UPE
         ziJH38Cckc5Li2FiZ+y4nBf4OJOEsjGXbn4hBmDZaUZubogCzkJqSFV+3yb9UDQDSNIY
         e/EZ9JwqMHpRaOVwq9ZP45coE8mzDd7jPokSpBKBxiaMtJKmf1ykGdejGbYPLdtcpRzL
         QAlDCr0LSaEMcZXYjgRTBS7luXXuAj8IX+2GeS/VwlANHonNngZ9cc/AzTjCFHSEXulJ
         LTLzO5AYQadqxKDoZ9pPeLBbJlNobivV2d7FhU/FRYYJHSP6U4zz64xqh1cUd+x88b+C
         tlXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722815911; x=1723420711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fpM5H1TDUfySJ43uH4f1cuN6lW8oKfIMeXGJAKsYgdc=;
        b=JIoORkqac4QS5ZhHq8GcZklLYR7iyLaB6Sk8oj+a70HcawPGQZeOLlluS9Hd6S/toN
         fj9k5MAAUXzn22yzo1F0uDoCtp7wcNZ1th1vQY7NIPwPFgl20cfxlOK3s19ODqeJ5lNW
         sf+JVS6HxMEJc67uZh+pmaYXplDs5dYUZrYAXTOkGNNNOGJLvn2y3pQ5EWNfLoOmqNh9
         wRLQ24kNSoHaVllRKSCW5cQRIAnaZJ6+GCOs0d3SWWIhkPurkrPvKFFKBTqsklTO1vxS
         030CXlcJUPjJVXBh0KU45dtr6xlsVxuj99GWZECENEmuuaJeuSbcvHoAkOIlai/gZYYm
         r5tw==
X-Forwarded-Encrypted: i=1; AJvYcCXGdDugCs1j9Rzqw3eGRhgvqMLjKbnIK7DZcFzTHAGjN3ahWfacR23fu+lZj75x0DtuMseiCZVxke93HFpIyNAnApmNVvPFeFOx2xpofpWlpo+TQIUtYVS+S/Fh5+7Yr2FRmdkEvz9mF03NCwI=
X-Gm-Message-State: AOJu0Ywt9j3nCugJelnd7UnpphG8r78UMM3TQZFP9aIIYyN7hyiLx0j9
	hhWHIrlhMRAoBPFNbdeQZBuj2sgVj1GvlFEfreAhTYJtBcgHNmUh
X-Google-Smtp-Source: AGHT+IFVFzc4iKp4sWX998N/3yecTCH60QR1i8lzXUqfFFymFKfKL3Qh7JUiJTAwb2IxCiCdjziOqA==
X-Received: by 2002:a05:620a:b9a:b0:7a3:5fa3:328 with SMTP id af79cd13be357-7a35fa307bcmr495790385a.54.1722815910668;
        Sun, 04 Aug 2024 16:58:30 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a34f6e9172sm298494385a.43.2024.08.04.16.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 16:58:30 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 64AAC120006A;
	Sun,  4 Aug 2024 19:58:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 04 Aug 2024 19:58:29 -0400
X-ME-Sender: <xms:pRWwZmAhnYp5r3NrxJZB0FFyrjXnj5kaIzi1LY4lIdXz388IpKfk4Q>
    <xme:pRWwZgiSWX2hX1U9bLMTxts4d2aGxtiiZ41yHpg5msf7IB8yUg9qfsmA_prw0wl8h
    vFNGQIff7LwJsHr8Q>
X-ME-Received: <xmr:pRWwZpm1Fl9Sm4H4QgyVn04mJCwxEuAV_eIVGgWOciPx2vuVAvRQydmeKAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeehgddvlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudff
    iedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:pRWwZkw0wj8baA0YqJtGH36FmfrT9EwiI6tFadwx-Oqq7X2r_GvAwA>
    <xmx:pRWwZrRQAPu06-hWXdl9m-OgfrABeGlfasxxarM2GVaJe4-8FzYGkQ>
    <xmx:pRWwZvaweiadTZXDb2668LgaogaxE1m9zN8xpwiKnbTPwoImsMWkHA>
    <xmx:pRWwZkTun4bEoFyfLDYmrA5OUTPNiwEGam_bIp53tUVvGypLS-350g>
    <xmx:pRWwZtBXiqm4e6Gyc3wZl-pGeQ_NPPf5D8B8DxCmE4cjVXODHYOzLugU>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Aug 2024 19:58:28 -0400 (EDT)
Date: Sun, 4 Aug 2024 16:57:30 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com,
	akpm@linux-foundation.org, daniel.almeida@collabora.com,
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com,
	lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com,
	acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com,
	airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v3 06/25] rust: alloc: implement `Vmalloc` allocator
Message-ID: <ZrAVagw5Wy5p0sXj@boqun-archlinux>
References: <20240801000641.1882-1-dakr@kernel.org>
 <20240801000641.1882-7-dakr@kernel.org>
 <Zq8jamaDSKWmj_-4@boqun-archlinux>
 <Zq927hO2fcV5LJME@pollux>
 <Zq-bWJFwtWG23O-L@pollux>
 <Zq-86Ma1nMybty-f@cassiopeiae>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zq-86Ma1nMybty-f@cassiopeiae>

On Sun, Aug 04, 2024 at 07:39:52PM +0200, Danilo Krummrich wrote:
[...]
> > > > > +unsafe impl Allocator for Vmalloc {
> > > > > +    unsafe fn realloc(
> > > > > +        ptr: Option<NonNull<u8>>,
> > > > > +        layout: Layout,
> > > > > +        flags: Flags,
> > > > > +    ) -> Result<NonNull<[u8]>, AllocError> {
> > > > > +        let realloc = ReallocFunc::vrealloc();
> > > > > +
> > > > 
> > > > IIUC, vrealloc() calls __vmalloc_noprof() in allocation case, that is
> > > > calling __vmalloc_node_noprof() with align=1. In such a case, how would
> > > > vmalloc() guarantee the allocated memory is aligned to layout.align()?
> > > 
> > > True, good catch. I thought of this a while ago and then forgot to fix it.
> > 
> > Just for clarification, we're always PAGE_SIZE aligned (guaranteed by
> > __alloc_vmap_area()), which probably would always be sufficient. That's why I
> > didn't gave it too much attention in the first place and then forgot about it.
> > 
> > However, we indeed do not honor layout.align() if it's larger than PAGE_SIZE.
> 
> Another note on that:
> 
> My plan for this series was to just fail allocation for alignment requests
> larger than PAGE_SIZE. And, if required, address larger alignments in a later

Yeah, this sounds reasonable.

> series, since this one is probably big enough already.
> 
> However, for `Vmalloc` we could support it right away, since it's trivial. For
> `KVmalloc` though it requires a bit more effort.
> 

Could you elaborate why it requires a bit more effort? Because
kvrealloc() and kvmalloc() in C don't have a way to specify alignment
requirement? If so, I think a solution to that would be just providing
the K-or-V switch in Rust code, i.e. just `Vmalloc` and `Kmalloc` to
implement `KVmalloc`, which I don't think is a bad idea.

Regards,
Boqun

> For consistancy it would probably be better to support alignments larger than
> PAGE_SIZE either for `Vmalloc` and `KVmalloc` or neither of those though.
> 
> My personal tendency goes a bit more into the direction of picking consistancy.
> 
> Any other opinions?
> 
[...]

