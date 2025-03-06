Return-Path: <linux-kernel+bounces-548109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A181BA54017
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 02:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A95E97A25C8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 01:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBD518BC06;
	Thu,  6 Mar 2025 01:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="UiBIAF1V"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF54EEA9
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 01:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741225361; cv=none; b=lxvlhLHjkaQFQnvOu55GADIWzrJ4XG4JBCLcUSp7ieZCYzULLyNTy/lI8x/kzy04Tc2gWy6xisoww1JE3n+Tp2mS9CqjVkIO2N4tSKQ+6EN6GgEtixtUqNKWaFT1U7ZN2I0Oz5G16dz0nPUTLWpxyEZN3ratF/zttZoYvxwOCEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741225361; c=relaxed/simple;
	bh=XHvW3ycQBFWggaOSJ8vyOSVd00mPwcXwlVmZWzFWPGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QUbv93ZdfPBfD7VS3tOCy8tfs82aMy4faYb+YFvWYJiZGhlmYIb57yDLI3kqSEGukzCWz+YAPp71HS7G9L0L8hvUgh+/+I2npIH4/uhDtqUa4LhdyjJ37hQe2GFay4wDQiJcgj5px+Qreo58cwIO+NBvmPO1Nu9hOgwUBhQhmo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=UiBIAF1V; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2241053582dso1289295ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 17:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1741225359; x=1741830159; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IJKWxmub+lotgzSWC/amTp/chHjkeAB/SDtxMJaHbJI=;
        b=UiBIAF1VOycAdowQ15wxoKNfts54yukj/Rco7rWMVhUcdfkFao8Paxw0U6ZTWimYVZ
         b7O3F15unqgrwhkIGVwkchIsOKxxaItfMs3FE7srnPEUOFAfna9cH20IDFsWiojhNqwe
         dqqEjsG2fMzyZ44a0YfBHDwvU8tASLGU8ZOrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741225359; x=1741830159;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IJKWxmub+lotgzSWC/amTp/chHjkeAB/SDtxMJaHbJI=;
        b=VfpA2jhouWoK00DgiWdxlYRtkAHN2kQUKrYRglwsr9K2ScF+jRxToiWuI9bZX1lEje
         NBcJr+dARSxhzunpU7FCNQfEjwxuLRyPK8ssQL1U0AxfnrbMN5+z5z0/aYoHeRXKdp15
         WV5NAPEXtGnsBATu/ntM8Ib5zhQtRhugh9aeLuWF5D9cQLIJPClKRSju4DwNZxmMJVlO
         xuTBy1y6YRABoTAfIvOjQK7HZn5nw1mCLSF/VMKYTShWc5SShDz1RJAL1Rao+lSH+u1I
         r1ykK2ZyY5tsqraDJn33hcjB1HOoMA5yrQCbiXkPcA/PC+BzFEg5Rf1rreJ7gRaOK2Ql
         B/Ew==
X-Forwarded-Encrypted: i=1; AJvYcCWoi+AqQhqwzCy3OcyIolEtMw9xxhgT2RokisAl7L650FCC+AExElZjog9/R8bNIFjL8Uh1PfW9voIvx9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsRz4vW/2hEceDvzkpV9Ckx0Wqj+Pro1roJlBhP/+JlUwf8MBN
	PkRsIp2/difzqQErgJzSaDfCNZcpcNRHVAP+3eeFQ04nBziwcW7Ivc99Pa8Anq0=
X-Gm-Gg: ASbGncuHrDF4RxTR+wa3jh70vuD3xrBDsWX7tN9RFnl06Rdg/ovn9nRzC/fE7CTicqt
	V1P1QH8kpf97ZIadtWGkLeLFnk5KS97U17x0phUx3PxMWFZD64l36i/Fu1m9HT8VS/P376I0NTz
	+kRdHrMWdR12GKqiYhBqE9Q2k/IvAPGlZc8RgShFWc9mqhQCPUy0pPHpbEg2IaKEIzba+Y717SR
	gRujKj7FJi2bbqr+Nooc0he2pAKObd/swde7q1pOahxUp3tqGB8+/89m3km//gP3IN5EQ47Omgj
	aSBnirV/ZIQ2rPfEEerCKkvyKHMCkrRg6oppe2Kv1JqkwSB57XS3D9xXY2b7hQ/ivvI3ZfLP1hw
	e4Ett6ip66Wk=
X-Google-Smtp-Source: AGHT+IHimzEWYok/7eEF2qEOfWup3jke8xbE2s20bz5FMsbXG9wqEzxeTrKe9ompiWcW/VmgcjtyoQ==
X-Received: by 2002:a05:6a00:2e17:b0:736:3ed1:e83a with SMTP id d2e1a72fcca58-73682be572bmr8332195b3a.12.1741225359121;
        Wed, 05 Mar 2025 17:42:39 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73698514eb7sm110830b3a.122.2025.03.05.17.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 17:42:38 -0800 (PST)
Date: Wed, 5 Mar 2025 17:42:35 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca,
	gerhard@engleder-embedded.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, mst@redhat.com, leiyang@redhat.com,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v5 3/4] virtio-net: Map NAPIs to queues
Message-ID: <Z8j9i-bW3P-GOpbw@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, gerhard@engleder-embedded.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, mst@redhat.com,
	leiyang@redhat.com,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
References: <20250227185017.206785-1-jdamato@fastly.com>
 <20250227185017.206785-4-jdamato@fastly.com>
 <20250228182759.74de5bec@kernel.org>
 <Z8Xc0muOV8jtHBkX@LQ3V64L9R2>
 <Z8XgGrToAD7Bak-I@LQ3V64L9R2>
 <Z8X15hxz8t-vXpPU@LQ3V64L9R2>
 <20250303160355.5f8d82d8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303160355.5f8d82d8@kernel.org>

On Mon, Mar 03, 2025 at 04:03:55PM -0800, Jakub Kicinski wrote:
> On Mon, 3 Mar 2025 13:33:10 -0500 Joe Damato wrote:
> > 
> > How about we don't use the API at all from refill_work?
> > 
> > Patch 4 adds consistent NAPI config state and refill_work isn't a
> > queue resize maybe we don't need to call the netif_queue_set_napi at
> > all since the NAPI IDs are persisted in the NAPI config state and
> > refill_work shouldn't change that?
> > 
> > In which case, we could go back to what refill_work was doing
> > before and avoid the problem entirely.
> > 
> > What do you think ?
> 
> Should work, I think. Tho, I suspect someone will want to add queue API
> support to virtio sooner or later, and they will run into the same
> problem with the netdev instance lock, as all of ndo_close() will then
> be covered with netdev->lock.
> 
> More thorough and idiomatic way to solve the problem would be to cancel
> the work non-sync in ndo_close, add cancel with _sync after netdev is
> unregistered (in virtnet_remove()) when the lock is no longer held, then
> wrap the entire work with a relevant lock and check if netif_running()
> to return early in case of a race.
> 
> Middle ground would be to do what you suggested above and just leave 
> a well worded comment somewhere that will show up in diffs adding queue
> API support?

Seems like Jason agrees that leaving refill_work unmodified will
work [1].

I think leaving a comment is a good idea and am happy to do so. Not
sure where would be a good spot for it.

Two spots that come to mind are:
 - in virtnet_probe where all the other netdev ops are plumbed
   through, or
 - above virtnet_disable_queue_pair which I assume a future queue
   API implementor would need to call for ndo_queue_stop

I get the feeling you have a much better suggestion in mind though
:)

[1]: https://lore.kernel.org/netdev/CACGkMEvWuRjBbc3PvOUpDFkjcby5QNLw5hA_FpNSPyWjkEXD_Q@mail.gmail.com/

