Return-Path: <linux-kernel+bounces-433276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB139E55DE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 132EF188266C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415241773A;
	Thu,  5 Dec 2024 12:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="V8tgxnuV"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E176218AAD
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 12:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733403238; cv=none; b=Y/ZnimAyO9RMZBLWoRg8syRK/qLeusg0Yk6439p/sM55l+t5hTOb9Yh5JhQLQ6QZZaU3wklrO3yHrJ9YLXTjRRmqutEndFJsgbB/Rn/XEwjjyDUI0oDIWbXCpKkydaCG/3NBl/bhHG3RGtlTeJK2Cy4/PU2hxPDXKXGTq3hu9Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733403238; c=relaxed/simple;
	bh=JZWxDg6kLZ0bFvcAVD+a3fOTrGu99x0LQws4omTlL0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPZffSZ6nmVffb+exqeghlYXsUAPTDh9eqF6mDY0MdqCHCPrMHX0z1Inc06bv7pQW5D+fCNkGkouMyOEKNkHfIJi0mTW0dXdG7WGINm+NYppzy5ao1lG4EBLIUsr2VcExYUm36hq3RR5BTANqYlWIMjzCWjzRJskct9casD/eH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=V8tgxnuV; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D0F0A3F22B
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 12:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733403232;
	bh=FUPqE51TLvEDtsqOtCI9i9XXbeFVSmPyWNWK1a6nR9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=V8tgxnuVMGhqBI7cS51lH9AOTzm58sThQ4pWSkjdvgwxDz7LKMI7auV4NFxhDqnAH
	 OnaOXDcqkqQbf7WOpihH/XIe8wAf6FcArXpRgbC99RsMnXg9kJxr1vbd3drfto4Q3y
	 JZMse6qpdowiLZn5zPMJuezZY5JeAOcUsKp48RE5xqOcnWERlyeQEA4dAdDxGfj+Ub
	 Kc8xaVgSMi0hKYVGzKiV+ByhHOA/5dYZjKkJ85n4QM7dKevV0p6+/XlbU1ePLisn1E
	 ND5h3rCSe0wxiBB3gBaKa8vMZPKcBOuAagVABlEQ3E8S5LvHlqsYbybTqbqKKUOKwT
	 I3Ania1gGZOhA==
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-7fcff306a20so1660152a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 04:53:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733403231; x=1734008031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUPqE51TLvEDtsqOtCI9i9XXbeFVSmPyWNWK1a6nR9k=;
        b=Lhl4gksabDSYLn/TFnNgxM4nQD/v3MPnomapo2ap0cKNq+tKbj1sa0wNtUPt0QdOvh
         Y9iR3nyh1WDFLwUscxSzkta/S0cnKNBBVlMj0LFMWB/lnAGKbzxPeQfmWws4TYDiwyHH
         AkSq9H0nOUVEZ1nPMEoh+LGLGvgU6x+SYRR7ULQwICEhoh65OVUfh5sbfDOn96NvI26R
         D9XRDaD0WH8fERoIl+Dd/vedXZE4TriPBtx7swT87z+FknoZkO4OViEUU8EP90yXWT/7
         AKTCcFvfZjIg2sEOcL7lNL2k/yDj+OmZK+mMzyTIat2yH+byi1s64pPOdSvEkWaE1RXN
         XXng==
X-Forwarded-Encrypted: i=1; AJvYcCV6dbgQeIAeMnq3ABtWaVKyNag0rK5fCcYLDyY6coG9gUE+QNfqZpsTGWrCJ9XUYofntDXAuogvPeI2n5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPuUk2xBnlApnbcwWOidz3m2w+5+1fz5q3DpuIrunJ+Ak+hJ42
	EdolQ3R7cuH5KBv8OqSuCiCjf7AFcOxS/l3bEKPQS2xWqIwCTak+Dn8C7xJTZBcgPhq4tc1T+do
	mgBA97R3ceMm3WxY7/c6FUrgucHAgrz5XWVFzb4wUkTF52Sxs2qsNGdceylYFVFWksVIGQua0Tc
	AtY8sNU4B3Bg==
X-Gm-Gg: ASbGncvxyx1rZdkQXcySq9h7XtEA/bVl8J2sFwU64QWQjmDt6mg1jqlKGDwFaxed9pn
	Ldxfiy4MFFuRcWgY4eRLJ6YUgFN+w7N7VfPpOs4SkWMvvQadBqEY0PfQL14nQj6R/VGr9EM0VP4
	xxxYBNdsuQ8N+UNUvRHeRVLmsmyfNFzM4Axtd9K6l9KSX+R80w6xllXaU4Mn1Q/2Hvfo6+G84At
	5qrFIXeH1+DS7c+tp6tMS6LO+X7+hUqu/4QvhCwwaVI5zcLWpo=
X-Received: by 2002:a05:6a20:9186:b0:1d9:ec2:c87b with SMTP id adf61e73a8af0-1e17d3841f3mr4662271637.9.1733403231229;
        Thu, 05 Dec 2024 04:53:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmNoiRxBOlLsxc22EXT6uQ0ZpleA21ZKP6ZYanOZreHBwMPSzZzR3LFylnFh324PSe+sabHw==
X-Received: by 2002:a05:6a20:9186:b0:1d9:ec2:c87b with SMTP id adf61e73a8af0-1e17d3841f3mr4662236637.9.1733403230902;
        Thu, 05 Dec 2024 04:53:50 -0800 (PST)
Received: from localhost ([240f:74:7be:1:d88b:a41e:6f7b:abf])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd156b7964sm1080721a12.18.2024.12.05.04.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 04:53:50 -0800 (PST)
Date: Thu, 5 Dec 2024 21:53:49 +0900
From: Koichiro Den <koichiro.den@canonical.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/7] virtio_net: introduce
 virtnet_sq_free_unused_buf_done()
Message-ID: <42s4swjiewp7fv2st6i6vzs5dlcah5r5rupl57s75hiqeds7hl@fu4oqhjm7cxc>
References: <20241204050724.307544-1-koichiro.den@canonical.com>
 <20241204050724.307544-4-koichiro.den@canonical.com>
 <20241205054009-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205054009-mutt-send-email-mst@kernel.org>

On Thu, Dec 05, 2024 at 05:40:33AM -0500, Michael S. Tsirkin wrote:
> On Wed, Dec 04, 2024 at 02:07:20PM +0900, Koichiro Den wrote:
> > This will be used in the following commits, to ensure DQL reset occurs
> > iff. all unused buffers are actually recycled.
> > 
> > Cc: <stable@vger.kernel.org> # v6.11+
> > Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> 
> to avoid adding an unused function, squash with a patch that uses it.

I originally seperated this out because some were supposed to land stable
tree while others not, and this was the common prerequisite. However, this
can be squahsed with [5/7] regardless of that, and should be done so as you
pointed out.

I'll do so and send v4 later, thanks for the review.

> 
> 
> > ---
> >  drivers/net/virtio_net.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 1b7a85e75e14..b3cbbd8052e4 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -503,6 +503,7 @@ struct virtio_net_common_hdr {
> >  static struct virtio_net_common_hdr xsk_hdr;
> >  
> >  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
> > +static void virtnet_sq_free_unused_buf_done(struct virtqueue *vq);
> >  static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
> >  			       struct net_device *dev,
> >  			       unsigned int *xdp_xmit,
> > @@ -6233,6 +6234,14 @@ static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
> >  	}
> >  }
> >  
> > +static void virtnet_sq_free_unused_buf_done(struct virtqueue *vq)
> > +{
> > +	struct virtnet_info *vi = vq->vdev->priv;
> > +	int i = vq2txq(vq);
> > +
> > +	netdev_tx_reset_queue(netdev_get_tx_queue(vi->dev, i));
> > +}
> > +
> >  static void free_unused_bufs(struct virtnet_info *vi)
> >  {
> >  	void *buf;
> > -- 
> > 2.43.0
> 

