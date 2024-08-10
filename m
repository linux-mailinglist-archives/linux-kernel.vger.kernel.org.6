Return-Path: <linux-kernel+bounces-281786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2288A94DB4C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 10:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B331B21EC7
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 08:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8A414AD0D;
	Sat, 10 Aug 2024 08:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PffINWOV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D44495E5
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 08:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723276945; cv=none; b=Yq3RQBbNuc54FuI4qQronWSCi2+7afkgE9EE4L5QZ8NKxL+REKS2bZIN4Epxf0Qj5KMQUYsW9ADnGXIGpvouJR8dBsbk7oFKG2bzF4LTM3UrqDg4dE1EJZZrm8JClsocA8lefdg7i8vMg/0glrPxMo/aexEwcRpi7vFnrqtwaNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723276945; c=relaxed/simple;
	bh=ScafrKHLDmywyJAhuxq8zU3jN37C4ehxZ+0tG7NIiUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VsN526yzje/GfhYA5vCyzYYZo4gN1wiNa3qD4wTMek61sd2Vb7aFg7wyWIB6Fr+CSI3acL8gM+9elzKzsj76shEJP/Gr8rjV1wqyGm57ayGbqhOkTriAQ9VygRSvDDVvGEGoeAv/UMfP2h/9VIhy+FC64RcJkRNI+cNfISdX+yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PffINWOV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723276942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UPjljH6iA3oWOviZCmtQ15dhjMJkybfiIUkL/U+qP9w=;
	b=PffINWOVWheAFREfPa7qVTPe340dR3QzHAt2oBW7KvkN4SjLQ0cuIL7/QfsmE/EBIedp2z
	stEJ0eXk/Dw+yNqivr+0Xs3JPjcpZVHRatwcCBzcYhyW/xfXQiKKM1JJRzKN81PnDnYvYl
	MMo+gWXBlR9QO2AbywSG1vABoxi0Z/U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-x_lKJJOiO_28CBsYzkq48g-1; Sat, 10 Aug 2024 04:02:21 -0400
X-MC-Unique: x_lKJJOiO_28CBsYzkq48g-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-428fc34f41bso21126235e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 01:02:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723276933; x=1723881733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UPjljH6iA3oWOviZCmtQ15dhjMJkybfiIUkL/U+qP9w=;
        b=gl3HzinA0u4fmp6DZOu7Y94YbceT6xHGdnY23oElQVPNSP5a9/2jqKc/3RiILfBYSv
         m9K1CsYx9/BwyKHt/vXe+1YSoNy9+x9ePXXBKgI01fz25xvBBJcSrccAvqwbZHjYIctA
         j8EbJEeeOdcJswWUaEJkRVEmkrxVDxFoO2a+qAQtuOnM9o/kd5qpk3rVlKTy+rx11yu3
         WN5X8x6iDvwAtuI8A/eptyxjJv0lc9rJ6tS/fJtLLQf5vpQSH5hC0gpb6c9SW8NnawoZ
         9zc9uQyq3bulNShUfOBPc0aUldrLBW87Lrv6M9d0qhjcFMknbh21GxKPPzkgZ3Z4/yS3
         UQPA==
X-Forwarded-Encrypted: i=1; AJvYcCVcVcfwPDEyoAYZa0cmITYIJdHkkdBNlGp1ubL6Srkc9rxu3F2RBxMICNYfM1GeZXmHzA5Pq04Wh+MpzLOOuvM3Cj6DAFjJblAWe3R9
X-Gm-Message-State: AOJu0YwZAMdCdRETIhbKwGl0En/11LBLKUcxA2bLTMRkLCyc37K2Gf4D
	dcBE7eGSPMuyL/1MH+ReQGOj3F2W0XfKsihoq0v3j8AFx8pbE7fQDigjuphAZ3X5PDs9t2bKg49
	0FDmGKJGXo2KhpV17S/IEmVNzayar+Bo70ADSGnaVoiMlspJIgCi9ZJN2i+vPCg==
X-Received: by 2002:a05:600c:c1b:b0:426:6822:861 with SMTP id 5b1f17b1804b1-429c3a5a0eemr24962635e9.36.1723276933049;
        Sat, 10 Aug 2024 01:02:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEswwbJndKkTgRmb2GZMwgJGUmCsGI2khfChZ1jJnnBT6x87O9kGvzmqv4CHnpklOnjHkE8XA==
X-Received: by 2002:a05:600c:c1b:b0:426:6822:861 with SMTP id 5b1f17b1804b1-429c3a5a0eemr24962345e9.36.1723276932491;
        Sat, 10 Aug 2024 01:02:12 -0700 (PDT)
Received: from localhost (53.116.107.80.static.otenet.gr. [80.107.116.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c750f0absm19507625e9.17.2024.08.10.01.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Aug 2024 01:02:12 -0700 (PDT)
Date: Sat, 10 Aug 2024 10:02:09 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Daniel Xu <dxu@dxuuu.xyz>,
	Alexander Lobakin <alexandr.lobakin@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Yajun Deng <yajun.deng@linux.dev>,
	Willem de Bruijn <willemb@google.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, xdp-hints@xdp-project.net
Subject: Re: [xdp-hints] Re: [PATCH RFC bpf-next 32/52] bpf, cpumap: switch
 to GRO from netif_receive_skb_list()
Message-ID: <ZrcegfBkreaOmRgV@lore-rh-laptop>
References: <20220628194812.1453059-1-alexandr.lobakin@intel.com>
 <20220628194812.1453059-33-alexandr.lobakin@intel.com>
 <cadda351-6e93-4568-ba26-21a760bf9a57@app.fastmail.com>
 <ZrRPbtKk7RMXHfhH@lore-rh-laptop>
 <54aab7ec-80e9-44fd-8249-fe0cabda0393@intel.com>
 <308fd4f1-83a9-4b74-a482-216c8211a028@app.fastmail.com>
 <99662019-7e9b-410d-99fe-a85d04af215c@intel.com>
 <875xs9q2z6.fsf@toke.dk>
 <22333deb-21f8-43a9-b32f-bc3e60892661@intel.com>
 <8734ndq0cd.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4vCVb17oaXeHlWt+"
Content-Disposition: inline
In-Reply-To: <8734ndq0cd.fsf@toke.dk>


--4vCVb17oaXeHlWt+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Aug 09, Toke wrote:
> Alexander Lobakin <aleksander.lobakin@intel.com> writes:
>=20
> > From: Toke H=F8iland-J=F8rgensen <toke@redhat.com>
> > Date: Fri, 09 Aug 2024 14:45:33 +0200
> >
> >> Alexander Lobakin <aleksander.lobakin@intel.com> writes:
> >>=20
> >>> From: Daniel Xu <dxu@dxuuu.xyz>
> >>> Date: Thu, 08 Aug 2024 16:52:51 -0400
> >>>
> >>>> Hi,
> >>>>
> >>>> On Thu, Aug 8, 2024, at 7:57 AM, Alexander Lobakin wrote:
> >>>>> From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
> >>>>> Date: Thu, 8 Aug 2024 06:54:06 +0200
> >>>>>
> >>>>>>> Hi Alexander,
> >>>>>>>
> >>>>>>> On Tue, Jun 28, 2022, at 12:47 PM, Alexander Lobakin wrote:
> >>>>>>>> cpumap has its own BH context based on kthread. It has a sane ba=
tch
> >>>>>>>> size of 8 frames per one cycle.
> >>>>>>>> GRO can be used on its own, adjust cpumap calls to the
> >>>>>>>> upper stack to use GRO API instead of netif_receive_skb_list() w=
hich
> >>>>>>>> processes skbs by batches, but doesn't involve GRO layer at all.
> >>>>>>>> It is most beneficial when a NIC which frame come from is XDP
> >>>>>>>> generic metadata-enabled, but in plenty of tests GRO performs be=
tter
> >>>>>>>> than listed receiving even given that it has to calculate full f=
rame
> >>>>>>>> checksums on CPU.
> >>>>>>>> As GRO passes the skbs to the upper stack in the batches of
> >>>>>>>> @gro_normal_batch, i.e. 8 by default, and @skb->dev point to the
> >>>>>>>> device where the frame comes from, it is enough to disable GRO
> >>>>>>>> netdev feature on it to completely restore the original behaviou=
r:
> >>>>>>>> untouched frames will be being bulked and passed to the upper st=
ack
> >>>>>>>> by 8, as it was with netif_receive_skb_list().
> >>>>>>>>
> >>>>>>>> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> >>>>>>>> ---
> >>>>>>>>  kernel/bpf/cpumap.c | 43 ++++++++++++++++++++++++++++++++++++++=
-----
> >>>>>>>>  1 file changed, 38 insertions(+), 5 deletions(-)
> >>>>>>>>
> >>>>>>>
> >>>>>>> AFAICT the cpumap + GRO is a good standalone improvement. I think
> >>>>>>> cpumap is still missing this.
> >>>>>
> >>>>> The only concern for having GRO in cpumap without metadata from the=
 NIC
> >>>>> descriptor was that when the checksum status is missing, GRO calcul=
ates
> >>>>> the checksum on CPU, which is not really fast.
> >>>>> But I remember sometimes GRO was faster despite that.
> >>>>
> >>>> Good to know, thanks. IIUC some kind of XDP hint support landed alre=
ady?
> >>>>
> >>>> My use case could also use HW RSS hash to avoid a rehash in XDP prog.
> >>>
> >>> Unfortunately, for now it's impossible to get HW metadata such as RSS
> >>> hash and checksum status in cpumap. They're implemented via kfuncs
> >>> specific to a particular netdevice and this info is available only wh=
en
> >>> running XDP prog.
> >>>
> >>> But I think one solution could be:
> >>>
> >>> 1. We create some generic structure for cpumap, like
> >>>
> >>> struct cpumap_meta {
> >>> 	u32 magic;
> >>> 	u32 hash;
> >>> }
> >>>
> >>> 2. We add such check in the cpumap code
> >>>
> >>> 	if (xdpf->metalen =3D=3D sizeof(struct cpumap_meta) &&
> >>> 	    <here we check magic>)
> >>> 		skb->hash =3D meta->hash;
> >>>
> >>> 3. In XDP prog, you call Rx hints kfuncs when they're available, obta=
in
> >>> RSS hash and then put it in the struct cpumap_meta as XDP frame metad=
ata.
> >>=20
> >> Yes, except don't make this cpumap-specific, make it generic for kernel
> >> consumption of the metadata. That way it doesn't even have to be stored
> >> in the xdp metadata area, it can be anywhere we want (and hence not
> >> subject to ABI issues), and we can use it for skb creation after
> >> redirect in other places than cpumap as well (say, on veth devices).
> >>=20
> >> So it'll be:
> >>=20
> >> struct kernel_meta {
> >> 	u32 hash;
> >> 	u32 timestamp;
> >>         ...etc
> >> }
> >>=20
> >> and a kfunc:
> >>=20
> >> void store_xdp_kernel_meta(struct kernel meta *meta);
> >>=20
> >> which the XDP program can call to populate the metadata area.
> >
> > Hmm, nice!
> >
> > But where to store this info in case of cpumap if not in xdp->data_meta?
> > When you convert XDP frames to skbs in the cpumap code, you only have
> > &xdp_frame and that's it. XDP prog was already run earlier from the
> > driver code at that point.
>=20
> Well, we could put it in skb_shared_info? IIRC, some of the metadata
> (timestamps?) end up there when building an skb anyway, so we won't even
> have to copy it around...

Before vacation I started looking into it a bit, I will resume this work in=
 one
week or so.

Regards,
Lorenzo

>=20
> -Toke
>=20

--4vCVb17oaXeHlWt+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZrcefgAKCRA6cBh0uS2t
rAWhAQCetdkAp+Z/1Ns5m03sBessZJS+q8gRJodpZZdXxU1EuAEAvK0zIPcM7BiO
hwuk4Jk43IjVvL7JR6J8TLYC7G85KA4=
=qu8K
-----END PGP SIGNATURE-----

--4vCVb17oaXeHlWt+--


