Return-Path: <linux-kernel+bounces-531795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5AFA4450F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23C3219C5979
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0474D188736;
	Tue, 25 Feb 2025 15:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F0Xb9Imb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8AE1624D4
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 15:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740498878; cv=none; b=qDw+dbjIgdb6BFchxsHQqK2/6vkuPWlXq3HeeQsv/axiizeXRhGSTFTdkVKYbFqNAxEc3SRZem4qTx+z0yG7RReOpPStMzgI4pzltCOEl9bVcKprtbHiALNTCHLlTJBtaPoW1Z8c7tnXs4Vf4xr5elYzn2//PB3PcycJcrmn8I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740498878; c=relaxed/simple;
	bh=B6guPeoLoNZZxbWYmAHZ5bN7rRVPk1E7b3Qht1EElwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QIJe9vyO85w5lg8xT+1a1/KoZUhWoKxez9WWKTyKcoli/DsGh6qlN91yHCJP1d7JyNr45Bq2L0AYhdXgUn+BEuKiniDARp/WDL4d8LM7GoSBaMle2ny/wdZe+vNPOXchjfpLGAMSaTQB5ViwdbcxolcrjaILnRQgrjOE/jCzSCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F0Xb9Imb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740498875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RM+x+J7eeR+zYm9ULF/axeMhLxPe1qiv9A3ZyXjbFuI=;
	b=F0Xb9ImbEyM3uuj158DXXlV+aPH7jG74ZaApdmrb3ftWomUJ+5uAl7nbF/pbJ6305Ad6JU
	N9JQmm0MrDvDbQfLrlWdx2P6zR0XT+gHWoAW8cGVH08Xsj7QC8OyTGQTL1c1ud7z+7xo7j
	4EDPwrW0E5g8O6qoRuNX5ml6sAma+Vk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-mpCti8JjM0-1nlJiPHG2lw-1; Tue, 25 Feb 2025 10:54:33 -0500
X-MC-Unique: mpCti8JjM0-1nlJiPHG2lw-1
X-Mimecast-MFC-AGG-ID: mpCti8JjM0-1nlJiPHG2lw_1740498872
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38f3eb82fceso2258139f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 07:54:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740498872; x=1741103672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RM+x+J7eeR+zYm9ULF/axeMhLxPe1qiv9A3ZyXjbFuI=;
        b=m/pefNflXn3vn+s+34+TmxVBDUhWdi6PLjbhmGSfS5LfXyq/AizRQzByvUUqYuBdG+
         kokCHipvOmDysCwn5DgSKxQHReuEd/mC/FFaIkbgd+hOgCA1Nwsp3+z8AdjhHlavPYsG
         z2lhTSAFN6zENAAaVFGOiwGcKDfLLi3mzC5Cn1Zwm9WyWuzsDEJXKUUGGTpvaLsPfXec
         6VYJoeUZaM4l85Iu2Uvxsx3y6eOhnlS6Xvrya7JS2/YsdIUHP2jz2ScnnMdvlLtNJmDA
         XqEoZn6ccM+ogpid1zzX2thEezvwLtjZPLj6Do+TFjSf3axVdKH6oEsLuZTlu/BPr98n
         71Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUHTQIEbwIOmxYFnRjM1q65WHGkZIC7AJDH+Z/1xxDmhOiWfogahB7WSgIMejbVYlrz2hmOHTMc+heJI0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw92ygbFffto1RGFglxedR+0tQcSV0bv1QChwGhM3S26S0ieBZx
	QRug66rV0WZzSpFcF76ICWTXFL0XWjvpltEh5K0GTIz5sQZkyHeQjRusgVNW6MsibBsTsc0sFmT
	/PJdVnSx1tBPXGfDmGzUmrHzMYep+H7VZudCwE3O8iMaU7dWFO7OgpnFIBFzBGA==
X-Gm-Gg: ASbGnctUoqob6WMpMucz1C2ZiF0by9qk2kyvVSmBzw91qnF+d71iQwMIcYXQ9QnOEmT
	7xZe+9IxrIka/78498vGHeidcwkfVJf+dMXu65Uc+NR6o4grnTvPMiEBF+9xOyn3V2eB4xyZLuh
	EP3iPObwMys+/orIsoGCchtPMyPKaePcMrccD+Q5/BXAjnWJ/eiVJ/hJazVWVKn8p9/JuwMnx0e
	I7nP2j9Mq9kwWNZjgpCmvA/0cDZYKQukJ+ZaAG42GoWkxReOvIHQis7f72vA4nszrUjZj+SnpF+
X-Received: by 2002:a05:6000:4008:b0:38f:4e30:6bba with SMTP id ffacd0b85a97d-390cc609228mr3580801f8f.23.1740498872436;
        Tue, 25 Feb 2025 07:54:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHN4AARjN7wYgWWN9IZdCNUwZ68WPfkZ8QQrVfbimeKsOa/InqaQkeFml1FEQVyd0AsQFCcmw==
X-Received: by 2002:a05:6000:4008:b0:38f:4e30:6bba with SMTP id ffacd0b85a97d-390cc609228mr3580751f8f.23.1740498871961;
        Tue, 25 Feb 2025 07:54:31 -0800 (PST)
Received: from redhat.com ([2.52.7.97])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab1532d9dsm32083345e9.6.2025.02.25.07.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 07:54:31 -0800 (PST)
Date: Tue, 25 Feb 2025 10:54:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca,
	gerhard@engleder-embedded.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, kuba@kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	open list <linux-kernel@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>
Subject: Re: [PATCH net-next v4 0/4] virtio-net: Link queues to NAPIs
Message-ID: <20250225105420-mutt-send-email-mst@kernel.org>
References: <20250225020455.212895-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225020455.212895-1-jdamato@fastly.com>

On Tue, Feb 25, 2025 at 02:04:47AM +0000, Joe Damato wrote:
> Greetings:
> 
> Welcome to v4.
> 
> Jakub recently commented [1] that I should not hold this series on
> virtio-net linking queues to NAPIs behind other important work that is
> on-going and suggested I re-spin, so here we are :)
> 
> This is a significant refactor from the rfcv3 and as such I've dropped
> almost all of the tags from reviewers except for patch 4 (sorry Gerhard
> and Jason; the changes are significant so I think patches 1-3 need to be
> re-reviewed).
> 
> As per the discussion on the v3 [2], now both RX and TX NAPIs use the
> API to link queues to NAPIs. Since TX-only NAPIs don't have a NAPI ID,
> commit 6597e8d35851 ("netdev-genl: Elide napi_id when not present") now
> correctly elides the TX-only NAPIs (instead of printing zero) when the
> queues and NAPIs are linked.
> 
> See the commit message of patch 3 for an example of how to get the NAPI
> to queue mapping information.
> 
> See the commit message of patch 4 for an example of how NAPI IDs are
> persistent despite queue count changes.
> 
> Thanks,
> Joe


Acked-by: Michael S. Tsirkin <mst@redhat.com>

> v4:
>   - Dropped Jakub's patch (previously patch 1).
>   - Significant refactor from v3 affecting patches 1-3.
>   - Patch 4 added tags from Jason and Gerhard.
> 
> rfcv3: https://lore.kernel.org/netdev/20250121191047.269844-1-jdamato@fastly.com/
>   - patch 3:
>     - Removed the xdp checks completely, as Gerhard Engleder pointed
>       out, they are likely not necessary.
> 
>   - patch 4:
>     - Added Xuan Zhuo's Reviewed-by.
> 
> v2: https://lore.kernel.org/netdev/20250116055302.14308-1-jdamato@fastly.com/
>   - patch 1:
>     - New in the v2 from Jakub.
> 
>   - patch 2:
>     - Previously patch 1, unchanged from v1.
>     - Added Gerhard Engleder's Reviewed-by.
>     - Added Lei Yang's Tested-by.
> 
>   - patch 3:
>     - Introduced virtnet_napi_disable to eliminate duplicated code
>       in virtnet_xdp_set, virtnet_rx_pause, virtnet_disable_queue_pair,
>       refill_work as suggested by Jason Wang.
>     - As a result of the above refactor, dropped Reviewed-by and
>       Tested-by from patch 3.
> 
>   - patch 4:
>     - New in v2. Adds persistent NAPI configuration. See commit message
>       for more details.
> 
> v1: https://lore.kernel.org/netdev/20250110202605.429475-1-jdamato@fastly.com/
> 
> [1]: https://lore.kernel.org/netdev/20250221142650.3c74dcac@kernel.org/
> [2]: https://lore.kernel.org/netdev/20250127142400.24eca319@kernel.org/
> 
> Joe Damato (4):
>   virtio-net: Refactor napi_enable paths
>   virtio-net: Refactor napi_disable paths
>   virtio-net: Map NAPIs to queues
>   virtio_net: Use persistent NAPI config
> 
>  drivers/net/virtio_net.c | 100 ++++++++++++++++++++++++++++-----------
>  1 file changed, 73 insertions(+), 27 deletions(-)
> 
> 
> base-commit: 7183877d6853801258b7a8d3b51b415982e5097e
> -- 
> 2.45.2


