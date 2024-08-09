Return-Path: <linux-kernel+bounces-280967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F5094D179
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2752C1C213BA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 13:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D70195B18;
	Fri,  9 Aug 2024 13:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BpMEGpXY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8432718C93F
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 13:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723210954; cv=none; b=di4GGwvCire0yNvdIoqgHcY5xe1IasaoEOJY4s+PA2qBubCj0jt69cJ9CnIuYOc3EKDjXnjJVlLDbInHluKm8KKWWJ/Xr6Y5tJhVsE2nIUZHYL7Rgxe0GDVWJ/vowGOKIKqQXhT2nTbIZiO/kHD82vzmUXZy1pYShdzBUJ/Rqdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723210954; c=relaxed/simple;
	bh=0YEZdr5TYVd3+J2WqQWsKdbxMKMxdHRfVnltBUl3pkA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MfHPqR4wQ3OpE3qcWW1xkSq6bBJj+QAnewmnr3M0Ivu129E9YNhggGJB07IUmwSamrJYHL/6CIcAr71koNkz6mWHH/J74JC1j9TA6eLKZ32xKMXIjyIIDLhGvqTSMJldAJ6lkmv2xKFARgLVMIytsdlgL3px+EvNyWUg4KhIYq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BpMEGpXY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723210950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SFTX0rNY2w9YzALBTFQ96yAO6UFLzBsPoLvkFbQRskg=;
	b=BpMEGpXYfo5SNaUWcbBzgD61QhTOeqtBQ8eJGoUaDUz7VVnwZ3ruqX/FwHfqZGC6gKjx2A
	alnTLoxzGhtDhRcyYI9IvPtO2CgOMgeIJIPKrt9nWl8lhdV9VOknI7g3lCdH867Gm8XdZY
	K/u9P1RBOT6IN6U7/WUZHT3xBTd1ZIU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-W1I1U-cJMsqTZKFg5jVZFw-1; Fri, 09 Aug 2024 09:42:29 -0400
X-MC-Unique: W1I1U-cJMsqTZKFg5jVZFw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4281f8994adso16188675e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 06:42:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723210948; x=1723815748;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SFTX0rNY2w9YzALBTFQ96yAO6UFLzBsPoLvkFbQRskg=;
        b=cSMEroUdvUax7DtTcG1PgZRxyOdK4IlSBpb9vVJj8/mnNfrA0svRg/ifKun2WfQZ+H
         FzfzScniF2zUwvGt46Hjx1It+Eg+zqHJfsLFjfA8wDUBxgUBMsl8qJJ8Hih5OaXWUapW
         HYuKMJOBI1JRjG588a4Xjds0OVQeq4obkbyud7fiFYyiKkYOjKPR7FZBznfrYhwSP2tM
         PceSkYSBXIcb/4QmcFiMY6+hLcvLXqkREGL8ut7Adf038L8Gl/0i/3dR2IlOEMSCWfay
         1/1JwXEkpnQr/QLjJJAVKqOxAreoweVTxOYZnFfM9eYGhx05e0kKeLY0gRQjiplPWv7G
         TJRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpMKd5f+R6sC5lf7pv5YVDKaON4vlsK7BQlqkF+rqG9pw+11FDbQCo7VVk+70cBYhw3y38UFya+Ku2HoE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg6XovpaXNZvjRLg4laFP3vtTYXWoyRehIIl8wYPXgFCug4PYD
	iO3YXKXAOGq9dex91c9r6hvFTEbSVGm8BD14F2N9rQH3rrmJrz4C/lXbIVqbYwZzlejXBdQhznI
	YnVEHw8oyIb0og6XxckH2AXXwj5wClUftDDL0tPXDax1IigVPQkpDDM1Tsg9WbQ==
X-Received: by 2002:a05:600c:1f92:b0:426:5dde:627a with SMTP id 5b1f17b1804b1-429c3a51f1bmr12422345e9.23.1723210948072;
        Fri, 09 Aug 2024 06:42:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEzP4aj812dBDfvhkc/LyZREDiM+x0netpXceUh6uLBcU9iT7ibZNosbz1NSwnLRG2NXzu3w==
X-Received: by 2002:a05:600c:1f92:b0:426:5dde:627a with SMTP id 5b1f17b1804b1-429c3a51f1bmr12421935e9.23.1723210947521;
        Fri, 09 Aug 2024 06:42:27 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d271569d1sm5345430f8f.18.2024.08.09.06.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 06:42:27 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 9034314ADA76; Fri, 09 Aug 2024 15:42:26 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Daniel Xu <dxu@dxuuu.xyz>, Lorenzo Bianconi
 <lorenzo.bianconi@redhat.com>, Alexander Lobakin
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
 Paolo Abeni <pabeni@redhat.com>, John Fastabend
 <john.fastabend@gmail.com>, Yajun Deng <yajun.deng@linux.dev>, Willem de
 Bruijn <willemb@google.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 xdp-hints@xdp-project.net
Subject: Re: [xdp-hints] Re: [PATCH RFC bpf-next 32/52] bpf, cpumap: switch
 to GRO from netif_receive_skb_list()
In-Reply-To: <22333deb-21f8-43a9-b32f-bc3e60892661@intel.com>
References: <20220628194812.1453059-1-alexandr.lobakin@intel.com>
 <20220628194812.1453059-33-alexandr.lobakin@intel.com>
 <cadda351-6e93-4568-ba26-21a760bf9a57@app.fastmail.com>
 <ZrRPbtKk7RMXHfhH@lore-rh-laptop>
 <54aab7ec-80e9-44fd-8249-fe0cabda0393@intel.com>
 <308fd4f1-83a9-4b74-a482-216c8211a028@app.fastmail.com>
 <99662019-7e9b-410d-99fe-a85d04af215c@intel.com> <875xs9q2z6.fsf@toke.dk>
 <22333deb-21f8-43a9-b32f-bc3e60892661@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 09 Aug 2024 15:42:26 +0200
Message-ID: <8734ndq0cd.fsf@toke.dk>
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
> Date: Fri, 09 Aug 2024 14:45:33 +0200
>
>> Alexander Lobakin <aleksander.lobakin@intel.com> writes:
>>=20
>>> From: Daniel Xu <dxu@dxuuu.xyz>
>>> Date: Thu, 08 Aug 2024 16:52:51 -0400
>>>
>>>> Hi,
>>>>
>>>> On Thu, Aug 8, 2024, at 7:57 AM, Alexander Lobakin wrote:
>>>>> From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
>>>>> Date: Thu, 8 Aug 2024 06:54:06 +0200
>>>>>
>>>>>>> Hi Alexander,
>>>>>>>
>>>>>>> On Tue, Jun 28, 2022, at 12:47 PM, Alexander Lobakin wrote:
>>>>>>>> cpumap has its own BH context based on kthread. It has a sane batch
>>>>>>>> size of 8 frames per one cycle.
>>>>>>>> GRO can be used on its own, adjust cpumap calls to the
>>>>>>>> upper stack to use GRO API instead of netif_receive_skb_list() whi=
ch
>>>>>>>> processes skbs by batches, but doesn't involve GRO layer at all.
>>>>>>>> It is most beneficial when a NIC which frame come from is XDP
>>>>>>>> generic metadata-enabled, but in plenty of tests GRO performs bett=
er
>>>>>>>> than listed receiving even given that it has to calculate full fra=
me
>>>>>>>> checksums on CPU.
>>>>>>>> As GRO passes the skbs to the upper stack in the batches of
>>>>>>>> @gro_normal_batch, i.e. 8 by default, and @skb->dev point to the
>>>>>>>> device where the frame comes from, it is enough to disable GRO
>>>>>>>> netdev feature on it to completely restore the original behaviour:
>>>>>>>> untouched frames will be being bulked and passed to the upper stack
>>>>>>>> by 8, as it was with netif_receive_skb_list().
>>>>>>>>
>>>>>>>> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
>>>>>>>> ---
>>>>>>>>  kernel/bpf/cpumap.c | 43 ++++++++++++++++++++++++++++++++++++++--=
---
>>>>>>>>  1 file changed, 38 insertions(+), 5 deletions(-)
>>>>>>>>
>>>>>>>
>>>>>>> AFAICT the cpumap + GRO is a good standalone improvement. I think
>>>>>>> cpumap is still missing this.
>>>>>
>>>>> The only concern for having GRO in cpumap without metadata from the N=
IC
>>>>> descriptor was that when the checksum status is missing, GRO calculat=
es
>>>>> the checksum on CPU, which is not really fast.
>>>>> But I remember sometimes GRO was faster despite that.
>>>>
>>>> Good to know, thanks. IIUC some kind of XDP hint support landed alread=
y?
>>>>
>>>> My use case could also use HW RSS hash to avoid a rehash in XDP prog.
>>>
>>> Unfortunately, for now it's impossible to get HW metadata such as RSS
>>> hash and checksum status in cpumap. They're implemented via kfuncs
>>> specific to a particular netdevice and this info is available only when
>>> running XDP prog.
>>>
>>> But I think one solution could be:
>>>
>>> 1. We create some generic structure for cpumap, like
>>>
>>> struct cpumap_meta {
>>> 	u32 magic;
>>> 	u32 hash;
>>> }
>>>
>>> 2. We add such check in the cpumap code
>>>
>>> 	if (xdpf->metalen =3D=3D sizeof(struct cpumap_meta) &&
>>> 	    <here we check magic>)
>>> 		skb->hash =3D meta->hash;
>>>
>>> 3. In XDP prog, you call Rx hints kfuncs when they're available, obtain
>>> RSS hash and then put it in the struct cpumap_meta as XDP frame metadat=
a.
>>=20
>> Yes, except don't make this cpumap-specific, make it generic for kernel
>> consumption of the metadata. That way it doesn't even have to be stored
>> in the xdp metadata area, it can be anywhere we want (and hence not
>> subject to ABI issues), and we can use it for skb creation after
>> redirect in other places than cpumap as well (say, on veth devices).
>>=20
>> So it'll be:
>>=20
>> struct kernel_meta {
>> 	u32 hash;
>> 	u32 timestamp;
>>         ...etc
>> }
>>=20
>> and a kfunc:
>>=20
>> void store_xdp_kernel_meta(struct kernel meta *meta);
>>=20
>> which the XDP program can call to populate the metadata area.
>
> Hmm, nice!
>
> But where to store this info in case of cpumap if not in xdp->data_meta?
> When you convert XDP frames to skbs in the cpumap code, you only have
> &xdp_frame and that's it. XDP prog was already run earlier from the
> driver code at that point.

Well, we could put it in skb_shared_info? IIRC, some of the metadata
(timestamps?) end up there when building an skb anyway, so we won't even
have to copy it around...

-Toke


