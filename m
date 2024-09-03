Return-Path: <linux-kernel+bounces-313348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C3B96A446
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 18:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D27028689C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 16:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F54B18BC00;
	Tue,  3 Sep 2024 16:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GPb9eX8V"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9BA18B499
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 16:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725380957; cv=none; b=T01RI2wYHy9VJyA2sgmQXuls4F539r0mf0KS/Hxm0Xr1uDHGl6kX+0UmGcEa3HmdVHUAsyWjGJcL1ck/leLWrSEPVlfYy/we0cdm9Eic5FK5YvsRUB/5U3rLLqzrutKSL4QtGzZhuD/J9eWTeXu/mR7FEoYF0jCgjhs12Z43/C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725380957; c=relaxed/simple;
	bh=zYtlk+5sfQncdxRHQdTsxikt0082PiHmmUZg7TTvIvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=uQeWHG0etk+RK5rlGPLy34c7BWoOj/gnZ9NovjcQZHHbjnHPpK4vb4c4FH8ZLJK94EExIFgkSYuA7IaKELxf90OCf3RzkdpImdMpjPirMjGOxbnyfselRYe0PVcLMkNotXzG8Uy2Z1mzE5T75tSZeYChpvwPERskFVzL0Rf6/2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GPb9eX8V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725380954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zrnaqsww4jvYqG6LWOK9qSkVY3XeoG7b3xEfRlLXIuA=;
	b=GPb9eX8V6KrTUWWkgg3GcbJuSzN+gC2Lm1KKFJ4SM1x2bRBVlkEAc4zT0wuwSQmw1aYh7o
	Q/0mDQseefE06bLPYLZ0GZQQEqDvn2l0L2fCjZblkiAiLoWotd41duJIsipd6gozPxwtaL
	dtzE+3j4WGoebGfuRUYy53EuZcZj2fk=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-165BlBo0OMi78FHNxV9h4g-1; Tue, 03 Sep 2024 12:29:13 -0400
X-MC-Unique: 165BlBo0OMi78FHNxV9h4g-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7141f62ac14so5344437b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 09:29:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725380952; x=1725985752;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zrnaqsww4jvYqG6LWOK9qSkVY3XeoG7b3xEfRlLXIuA=;
        b=AYvhRS35zpPub2GlDWXd88vkYrEzflJlhoNQaqueU3nC4M3r5I4b6P0y87njeTLrAD
         rdHTK2BMHKHTYN+z8HSHEWR2L7YMWPFX6CjWtsZ91bn+Mx+w+rQJtbhoz1gB0fSkhlcj
         sRBs46+vN55c0gvty93f9ayvEAwkP3z9gmv27e540TNdYNcqIN0oiFPJ1UNIGbhGcgap
         3RfSfPyJfqWEe0U2tWpW0YmWgUPXAeADFdN6RrdTQG0FNrCzLcX4gs+aZfs4fZZGSQ0g
         6OzOIRwNjoottmA3m1psGtc1q4i7k/Ppgyk7TODWRzEWkJCMWEfFq40kzdx31L4VK8Ey
         btKg==
X-Forwarded-Encrypted: i=1; AJvYcCUog0jaUcqLO5oY/ANIvDx5KgIG1+C0NwwjR9BnLaMuzhPYzizZC4oJQvevzCaGUM0z+tgyXaB6FyD2jBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcOdYdc4a+wLoxu3pH/ixr6cAcdBVbhh2Pm3NfWzihSkwK+pWm
	+3/PuzEYXn7zlBcXEsyskI2bn9eSBStQO8WOz3n2GEWFSCvIOAKA0o6NFoKFNjrvMRGFO9Cx174
	+j0yI7twaMkAX4iTNTiYx0pONYc8l18kUONTd1ksDOFC3WPAAPdhJKIDuYIXxy90aJ8G0PAUA
X-Received: by 2002:a17:902:cecc:b0:205:7b03:ec3f with SMTP id d9443c01a7336-2057b03ee0amr99540735ad.19.1725380951883;
        Tue, 03 Sep 2024 09:29:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFB7YsrYOLHMUBhndqah1OUkE6FYlc2YhqiVhS0lNKY7Sh/DddLuJw4Mh3nlZdjBuyYPz4vg==
X-Received: by 2002:a17:902:cecc:b0:205:7b03:ec3f with SMTP id d9443c01a7336-2057b03ee0amr99540215ad.19.1725380951200;
        Tue, 03 Sep 2024 09:29:11 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a800:179b:467b:fbc5:3354:8591])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae9525d6sm550515ad.111.2024.09.03.09.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 09:29:10 -0700 (PDT)
From: Leonardo Bras <leobras@redhat.com>
To: Breno Leitao <leitao@debian.org>
Cc: Leonardo Bras <leobras@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	rbc@meta.com,
	horms@kernel.org,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] virtio_net: Fix napi_skb_cache_put warning
Date: Tue,  3 Sep 2024 13:28:50 -0300
Message-ID: <Ztc5QllkqaKZsaoN@LeoBras>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <ZpUHEszCj16rNoGy@gmail.com>
References: <20240712115325.54175-1-leitao@debian.org> <20240714033803-mutt-send-email-mst@kernel.org> <ZpUHEszCj16rNoGy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Jul 15, 2024 at 04:25:06AM -0700, Breno Leitao wrote:
> Hello Michael,
> 
> On Sun, Jul 14, 2024 at 03:38:42AM -0400, Michael S. Tsirkin wrote:
> > On Fri, Jul 12, 2024 at 04:53:25AM -0700, Breno Leitao wrote:
> > > After the commit bdacf3e34945 ("net: Use nested-BH locking for
> > > napi_alloc_cache.") was merged, the following warning began to appear:
> > > 
> > > 	 WARNING: CPU: 5 PID: 1 at net/core/skbuff.c:1451 napi_skb_cache_put+0x82/0x4b0
> > > 
> > > 	  __warn+0x12f/0x340
> > > 	  napi_skb_cache_put+0x82/0x4b0
> > > 	  napi_skb_cache_put+0x82/0x4b0
> > > 	  report_bug+0x165/0x370
> > > 	  handle_bug+0x3d/0x80
> > > 	  exc_invalid_op+0x1a/0x50
> > > 	  asm_exc_invalid_op+0x1a/0x20
> > > 	  __free_old_xmit+0x1c8/0x510
> > > 	  napi_skb_cache_put+0x82/0x4b0
> > > 	  __free_old_xmit+0x1c8/0x510
> > > 	  __free_old_xmit+0x1c8/0x510
> > > 	  __pfx___free_old_xmit+0x10/0x10
> > > 
> > > The issue arises because virtio is assuming it's running in NAPI context
> > > even when it's not, such as in the netpoll case.
> > > 
> > > To resolve this, modify virtnet_poll_tx() to only set NAPI when budget
> > > is available. Same for virtnet_poll_cleantx(), which always assumed that
> > > it was in a NAPI context.
> > > 
> > > Fixes: df133f3f9625 ("virtio_net: bulk free tx skbs")
> > > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > 
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > though I'm not sure I understand the connection with bdacf3e34945.
> 
> The warning above appeared after bdacf3e34945 landed.

Hi Breno,
Thanks for fixing this!

I think the confusion is around the fact that the commit on Fixes 
(df133f3f9625) tag is different from the commit in the commit message
(bdacf3e34945).

Please help me check if the following is correct:
###
Any tree which includes df133f3f9625 ("virtio_net: bulk free tx skbs") 
should also include your patch, since it fixes stuff in there.

The fact that the warning was only made visible in 
bdacf3e34945 ("net: Use nested-BH locking for napi_alloc_cache.")
does not change the fact that it was already present before.

Also, having bdacf3e34945 is not necessary for the backport, since
it only made the bug visible.
###

Are above statements right?

It's important to make it clear since this helps the backporting process.

Thanks!
Leo


