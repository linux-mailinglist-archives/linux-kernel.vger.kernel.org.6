Return-Path: <linux-kernel+bounces-259288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB91939392
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 20:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C338AB208A6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 18:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE45916FF4B;
	Mon, 22 Jul 2024 18:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="K9k5PKf3"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D13716DC06
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 18:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721672803; cv=none; b=bijLleqdU0tU6CnTCY6+jkB7ZJZHge3F+BDnFfHmqnTMWLOSIZtNUTFtBBZQH0vcfVeiSJKYWXWiNNxXwFdoIPwZMRuWtgtgrSW9iKwFls9aeUzrD5QoWeebqq4Q7lm2rfwk8+xLX5qWYFjrDVQdABQZRr0AfKrCE3zwvoAWdjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721672803; c=relaxed/simple;
	bh=/Nh0wjJ767d1KK/OMmJpj7/YnfgAxBifscTRqTXRU30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sOLgJWRCdlad9LZKqd50En4/0KWR56/APHiOmsQ93DEnxd/GA+960fw8exOp2lXaTWZi6d1uXLPmiQ/9QotrGXeO3gIs+wSwuPXmdUJF20x7Gn/u+Fx7CIUwkOy20wGKvKCS577VbEmVNGtdyNIg30kYkVnJqSA5EYl7fp8jw0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=K9k5PKf3; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7a130ae7126so1255620a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 11:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1721672801; x=1722277601; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9biYfsdlWUFfa2uPahdEjhFynqs7UpMUrewmhcvPcXA=;
        b=K9k5PKf3A7dMWifgWJ5RA3iUC40pPyjmeM/z+makPkiL0wa4mOrQP0Gavl58z/UVHj
         htwrL9x90+Qmt8SZt57oTYfv3IVu5wJYJJWJLBomeZULk7387LQa8qpP02C+kkXDMXEC
         7rWkLgWbZB7GZwi36/F5r+tQxl79VK86g/ycI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721672801; x=1722277601;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9biYfsdlWUFfa2uPahdEjhFynqs7UpMUrewmhcvPcXA=;
        b=h9g8APPqD67qrcxuRzHqD1o4p3X/UulI3r/+pzF/dvLsp4Cy2KUbYSnPKzHO4xIpEn
         lzHdIaZ+NB4xhPZMzxkcxgFTEdTHAjtP4hG9kegSMYEAWCOC8ua1rE/hTKlziIocFpRQ
         oe0UlKG94afpYkg78Lyn96BT03teBC0HqOmp4HxHJHO1PvYIhBa42qdXzoZb4C0pDMh7
         cLLXUif381zQJx/FvifwSTr2n3GQyccaOoN5UzEZgmhHUx/keGPhZGTl3YcQkV7KDOAH
         uDN4tO8fxWiAuveT17k8zFV2BuSAPfM0GY7xdxLskOhVwzucovMsSTmpIojBC6R3K3JH
         L3Kw==
X-Forwarded-Encrypted: i=1; AJvYcCVasC2GJ4/n92HpaorqRNZv0Sl1eT6ClnhGi5LJ/fmvCyhz9jP0Wen7QR1SMTweYefmJLX+j9NyWff0mI1hkvU3U9C7cD3U9qVC9rrg
X-Gm-Message-State: AOJu0Yy497rJtZJA/4fkpgF/NaHtagQO4Kb/F+Qyuw96yAkoFfXUGFyD
	yQVrjcM+dXj8mjPnRh447S1FvqZdRX5nUEk7MPj21myaGvIGADsjRBHsqdbuEbs=
X-Google-Smtp-Source: AGHT+IHHHCDBMnxogaNQNY0v9bDW89ARG24TCy7ngJQcYGVhGfiHTIWN+aI+488Iott9h8yr0vfjFA==
X-Received: by 2002:a05:6a20:cfa7:b0:1c3:b239:83e2 with SMTP id adf61e73a8af0-1c4285b767bmr9863586637.12.1721672800827;
        Mon, 22 Jul 2024 11:26:40 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f48f3ffsm57826685ad.285.2024.07.22.11.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 11:26:40 -0700 (PDT)
Date: Mon, 22 Jul 2024 11:26:37 -0700
From: Joe Damato <jdamato@fastly.com>
To: Elad Yifee <eladwf@gmail.com>
Cc: daniel@makrotopia.org, Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next RFC] net: ethernet: mtk_eth_soc: use prefetch
 methods
Message-ID: <Zp6kXQkiOOI2IPT2@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Elad Yifee <eladwf@gmail.com>, daniel@makrotopia.org,
	Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, bpf@vger.kernel.org
References: <20240720164621.1983-1-eladwf@gmail.com>
 <Zp6GGzaJXhBcnGkC@LQ3V64L9R2>
 <CA+SN3soUH9dxAkKD8AB64Ay48T=Dj-QFftMoMLZfVGH+Q1mjzA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+SN3soUH9dxAkKD8AB64Ay48T=Dj-QFftMoMLZfVGH+Q1mjzA@mail.gmail.com>

On Mon, Jul 22, 2024 at 09:04:06PM +0300, Elad Yifee wrote:
> On Mon, Jul 22, 2024 at 7:17 PM Joe Damato <jdamato@fastly.com> wrote:
> >
> > On Sat, Jul 20, 2024 at 07:46:18PM +0300, Elad Yifee wrote:
> > > Utilize kernel prefetch methods for faster cache line access.
> > > This change boosts driver performance,
> > > allowing the CPU to handle about 5% more packets/sec.
> >
> > Nit: It'd be great to see before/after numbers and/or an explanation of
> > how you measured this in the commit message.
> Sure, I'll add iperf3 results in the next version.

Thanks, that'd be helpful!

[...]

> > > @@ -2039,7 +2040,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
> > >               idx = NEXT_DESP_IDX(ring->calc_idx, ring->dma_size);
> > >               rxd = ring->dma + idx * eth->soc->rx.desc_size;
> > >               data = ring->data[idx];
> > > -
> > > +             prefetch(rxd);
> >
> > Maybe net_prefetch instead, as mentioned above?
> This is the only case where I think prefetch should be used since it's
> only the descriptor.

I think you are implying that the optimization in the case of
L1_CACHE_BYTES < 128 is unnecessary because because the
mtk_rx_dma_v2 descriptors will be too far (i *
eth->soc->rx.desc_size) apart to get any benefit from prefetching
more data ?

If my understanding is correct, then yes: I agree.

> Thank you for your suggestions

No problem!

