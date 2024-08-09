Return-Path: <linux-kernel+bounces-280885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A24494D076
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 14:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE1EF28289A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 12:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5858195FF1;
	Fri,  9 Aug 2024 12:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B43jrcsz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380CD193090
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 12:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723207542; cv=none; b=ZZ+Su1iSx1+bRQ2ZcEzXQ73LMjG9fG6hL1gd9AM+z3rqGRkGLkvvcEZt+7/1K0RIop0c+NTdWt1QpWDPc4HtOK6DUs2lrmzBSvVpI4bga6uUeRUW19wFm0FUIbP/E+LLLzLTDNRjZ0McoZTtPLkgCaeNavTxzx/tRcqqz52prhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723207542; c=relaxed/simple;
	bh=OHsMxJbHlfzLzzFLnyU1QGANT9Y8RpTv5K2L8dxIoSE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SFIMbHA/cgGA4/GXLrq4kPIfBPVroDm2H1DHnrs0HfW/gbU5AUoZ2pf+zYtVwWBt6/BxhVer9dB84qQLIi32mcfxR7sQr9cisd3iixUeYNe/wMjrgELWAx6B9lf0kalk8KKFXC8pgLh3DEXkEyRPEuJQdFCmkI2xF0GXuommFak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B43jrcsz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723207540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bDR1PreyBYXGgczYYRhC/utTNT8xvL5WwhzEE5DaLg4=;
	b=B43jrcszpK6BbHxOWX7rcgHl+4uMh4DJMbSJfevfjq+sUwriDX59nPEqjOyPnvNF7drNnR
	cVDXGH4stz6mClkiKBROmTVT3ZQvK4tZBfsXdODAf9jN4VF3o4IbiyLslOraoazGtkIjOf
	o6i3HwWEQIyGefJduELBu0+MOLEQ8ok=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-zdCCivmsNiCVqwdf8W-mog-1; Fri, 09 Aug 2024 08:45:39 -0400
X-MC-Unique: zdCCivmsNiCVqwdf8W-mog-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4280c0b3017so15470975e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 05:45:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723207538; x=1723812338;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bDR1PreyBYXGgczYYRhC/utTNT8xvL5WwhzEE5DaLg4=;
        b=X2bYtxA9zUgvkQtIrPjpoN/SUoz3aQDfmfbxF0X8LCSy42EA7AsUOs8aszqxc17GFy
         g2Gac1MYAYYqJkk71+8lzKOkE5wDRnpGrr4N6hjmCQFXCHnyr6zlXd4TpRSJ+WwlqxqQ
         DWmh6hNiSnbZlH20x/5Fx/AJ9F4nefm6D32wAcdy8dfe1jwWuq/xxDIv/rRxpdxWvUFr
         q5i5fOxrF5T9nG8WyR+VUXNajejbfIA8tArsmJOmX461h9ZkeTgJAFnLz3YPhosnmuwW
         AK8RUYtwTPJiFn0z5E+Pyc70iZDa2RgHYe/4D8OIdsiUafpWHsBKTJyjKjuakhtsAepV
         YyPg==
X-Forwarded-Encrypted: i=1; AJvYcCWWebIxPbbY7AaP/hE5FA9umiDQ6YfCnsKtPDOnS8dQzRzNCpc3fjBtfZxWKlDn3UHY+VMNjAki9GqHnGHEn7tiFOVUQkLyQskp54St
X-Gm-Message-State: AOJu0YxYmEQaKle0Su4ftTejhbKa6QUIcr2i8RQfEBIrD1lkNGQF2TSX
	ZD1NAEK6jGeALT+Hc0OUPD2khCknp0hUgfHNGfH6fuGb4EYxNrRaSERpTRyvyhugDDNngUL3rnI
	l5t3+g/oMiJZREXtLgS5XcxnNTj3BRHpd4Es7unZ2zMdKKauTDLXnknVWI1fhvQ==
X-Received: by 2002:a05:600c:4e91:b0:428:1799:35e3 with SMTP id 5b1f17b1804b1-429c3a28d5dmr10716095e9.21.1723207537737;
        Fri, 09 Aug 2024 05:45:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiZUexO1DxZTYudFFvKsUA1By+NJF96m1YQZNLJ7cfOIryu3poJzd7dWE4i1OcJvheN6NR3g==
X-Received: by 2002:a05:600c:4e91:b0:428:1799:35e3 with SMTP id 5b1f17b1804b1-429c3a28d5dmr10715775e9.21.1723207537234;
        Fri, 09 Aug 2024 05:45:37 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429059cd2b3sm126267855e9.44.2024.08.09.05.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 05:45:36 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 240EF14ADA65; Fri, 09 Aug 2024 14:45:33 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Daniel Xu <dxu@dxuuu.xyz>
Cc: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, Alexander Lobakin
 <alexandr.lobakin@intel.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Larysa Zaremba <larysa.zaremba@intel.com>, Michal Swiatkowski
 <michal.swiatkowski@linux.intel.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Magnus Karlsson
 <magnus.karlsson@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, John Fastabend <john.fastabend@gmail.com>,
 Yajun Deng <yajun.deng@linux.dev>, Willem de Bruijn <willemb@google.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, xdp-hints@xdp-project.net
Subject: Re: [xdp-hints] Re: [PATCH RFC bpf-next 32/52] bpf, cpumap: switch
 to GRO from netif_receive_skb_list()
In-Reply-To: <99662019-7e9b-410d-99fe-a85d04af215c@intel.com>
References: <20220628194812.1453059-1-alexandr.lobakin@intel.com>
 <20220628194812.1453059-33-alexandr.lobakin@intel.com>
 <cadda351-6e93-4568-ba26-21a760bf9a57@app.fastmail.com>
 <ZrRPbtKk7RMXHfhH@lore-rh-laptop>
 <54aab7ec-80e9-44fd-8249-fe0cabda0393@intel.com>
 <308fd4f1-83a9-4b74-a482-216c8211a028@app.fastmail.com>
 <99662019-7e9b-410d-99fe-a85d04af215c@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 09 Aug 2024 14:45:33 +0200
Message-ID: <875xs9q2z6.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> From: Daniel Xu <dxu@dxuuu.xyz>
> Date: Thu, 08 Aug 2024 16:52:51 -0400
>
>> Hi,
>> 
>> On Thu, Aug 8, 2024, at 7:57 AM, Alexander Lobakin wrote:
>>> From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
>>> Date: Thu, 8 Aug 2024 06:54:06 +0200
>>>
>>>>> Hi Alexander,
>>>>>
>>>>> On Tue, Jun 28, 2022, at 12:47 PM, Alexander Lobakin wrote:
>>>>>> cpumap has its own BH context based on kthread. It has a sane batch
>>>>>> size of 8 frames per one cycle.
>>>>>> GRO can be used on its own, adjust cpumap calls to the
>>>>>> upper stack to use GRO API instead of netif_receive_skb_list() which
>>>>>> processes skbs by batches, but doesn't involve GRO layer at all.
>>>>>> It is most beneficial when a NIC which frame come from is XDP
>>>>>> generic metadata-enabled, but in plenty of tests GRO performs better
>>>>>> than listed receiving even given that it has to calculate full frame
>>>>>> checksums on CPU.
>>>>>> As GRO passes the skbs to the upper stack in the batches of
>>>>>> @gro_normal_batch, i.e. 8 by default, and @skb->dev point to the
>>>>>> device where the frame comes from, it is enough to disable GRO
>>>>>> netdev feature on it to completely restore the original behaviour:
>>>>>> untouched frames will be being bulked and passed to the upper stack
>>>>>> by 8, as it was with netif_receive_skb_list().
>>>>>>
>>>>>> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
>>>>>> ---
>>>>>>  kernel/bpf/cpumap.c | 43 ++++++++++++++++++++++++++++++++++++++-----
>>>>>>  1 file changed, 38 insertions(+), 5 deletions(-)
>>>>>>
>>>>>
>>>>> AFAICT the cpumap + GRO is a good standalone improvement. I think
>>>>> cpumap is still missing this.
>>>
>>> The only concern for having GRO in cpumap without metadata from the NIC
>>> descriptor was that when the checksum status is missing, GRO calculates
>>> the checksum on CPU, which is not really fast.
>>> But I remember sometimes GRO was faster despite that.
>> 
>> Good to know, thanks. IIUC some kind of XDP hint support landed already?
>> 
>> My use case could also use HW RSS hash to avoid a rehash in XDP prog.
>
> Unfortunately, for now it's impossible to get HW metadata such as RSS
> hash and checksum status in cpumap. They're implemented via kfuncs
> specific to a particular netdevice and this info is available only when
> running XDP prog.
>
> But I think one solution could be:
>
> 1. We create some generic structure for cpumap, like
>
> struct cpumap_meta {
> 	u32 magic;
> 	u32 hash;
> }
>
> 2. We add such check in the cpumap code
>
> 	if (xdpf->metalen == sizeof(struct cpumap_meta) &&
> 	    <here we check magic>)
> 		skb->hash = meta->hash;
>
> 3. In XDP prog, you call Rx hints kfuncs when they're available, obtain
> RSS hash and then put it in the struct cpumap_meta as XDP frame metadata.

Yes, except don't make this cpumap-specific, make it generic for kernel
consumption of the metadata. That way it doesn't even have to be stored
in the xdp metadata area, it can be anywhere we want (and hence not
subject to ABI issues), and we can use it for skb creation after
redirect in other places than cpumap as well (say, on veth devices).

So it'll be:

struct kernel_meta {
	u32 hash;
	u32 timestamp;
        ...etc
}

and a kfunc:

void store_xdp_kernel_meta(struct kernel meta *meta);

which the XDP program can call to populate the metadata area.

-Toke


