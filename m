Return-Path: <linux-kernel+bounces-374751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE0C9A6F64
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 18:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 188F41C22DBB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 16:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228BB1E47AB;
	Mon, 21 Oct 2024 16:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CUN4VJRj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E69137750
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 16:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729528074; cv=none; b=rvmq5LE4w741lQaqkU8rUYinrvKt2gh7Snh4hoEJ0XRLR+vlufo0IxQqfURwyQh/zbAK6OZ37FD8Krn4lG7GYKfM43JMqB/XkhrNNoGs7CzyqSVS2jAfKXcUJzhf4oJyghRJU/es02zeB3eh5KVWb3sb2nm325MQqKAT0Uq9uvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729528074; c=relaxed/simple;
	bh=ng4Fd/1eXm21KjZGx0nNu+fVA/U+EZvgbDIonKK4TTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kx98CNEKT2nPZSA3GnYZxBRG/Kv3uCbZ3o9tDlzkPH14JcaMysVx52kvTcP4/6V3EUkJrGqKK7NJb5oJTKEjI2hnrcnEyN34Dsx4dmob4wOGkBTejGs2WX3s0QHSqQTyaeDy1tcir2xMx3rnA9qPOhAyN4WuvPCM2sSHiJI5n04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CUN4VJRj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729528071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mTDxXEF8TjHAORp7n3Sf58mbRFCPldS14PaLA/YlNHg=;
	b=CUN4VJRjftptZ2AcxxbovaltrTyPfFVPHpHG4abVMCaOWnw7H01it/UZRCZ+joHmfrAtHS
	Q+kuijYIx5BiByCI5l01YPr+cDjvqZDcIoJpqWZITZ/GNHF7LmiAf5p9gfVLWEB79nXlhj
	2QMqbMvOsWTspxYP5wxMgUbCHM4MtMk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-8juTuxugPLS3ighW1uAFZA-1; Mon, 21 Oct 2024 12:27:48 -0400
X-MC-Unique: 8juTuxugPLS3ighW1uAFZA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4316655b2f1so20234665e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 09:27:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729528067; x=1730132867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mTDxXEF8TjHAORp7n3Sf58mbRFCPldS14PaLA/YlNHg=;
        b=IpZzLrv8htp/IjEJXek+8w+aztwlv5J0BFdjJNAh6smhQEskFabzUcoIfxtHlLbH+t
         /PPGhTHnGnkBeji4GhFhd0sIrKbTc0w2RrxqxSprYh4geUn1P2t4wnoD7gtPp8nXqLyp
         AtACmf1dnTm0LHpl/mxG6FtCG2JXyrkejEUKvLlgpQciaJngHX0NRU0j7Ka/3w3Y1HLz
         Wn79WJ4HK9g1kQieSJnySIcpfKBE1af5dpAl4bEbHWUiePLtX8Is/Tt8afZOuu9Q5xFc
         ygc+lYyyGekgmFhlSq9ZIG0rNAflleujkuTTyh3U+lSn3Dww6hnqlcBWgmCLQJHyxRpi
         EXWA==
X-Forwarded-Encrypted: i=1; AJvYcCX6FgX51k8WkrEVZi6p5iHAo0ri+pd2HjsNk8T36Cu/efW2UvvxAf3mWkZAgXz6L9YHKfr4tApibM+nFmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMipwPsf7oStHH3KPQHE3kc4kyj5uSJkKlFak0SY8hD/mvPqd8
	3jjGcY1x48kbQmiBtr9HBjeRN0KX4t8byTqwM++M1ZYlFb9Sgv8cSCfgYtBFqACILVuNbnwGOJC
	Nc9vIUueQ58kVuY/2YC3Wm/IpifXvEJ4jB2c5A8lUK0vDwOcPa3jhIAN5H69ebg==
X-Received: by 2002:a05:600c:3110:b0:431:60ec:7a96 with SMTP id 5b1f17b1804b1-4316169ac06mr96399965e9.25.1729528067186;
        Mon, 21 Oct 2024 09:27:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSI/56QMnJyhwqWOYstEnbLNMAgepug8Hr4wC/KvF/uwvrNQxqtSy1YQTxoGG0Smjo/CMklA==
X-Received: by 2002:a05:600c:3110:b0:431:60ec:7a96 with SMTP id 5b1f17b1804b1-4316169ac06mr96399795e9.25.1729528066798;
        Mon, 21 Oct 2024 09:27:46 -0700 (PDT)
Received: from debian (2a01cb058918ce00b54b8c7a11d7112d.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:b54b:8c7a:11d7:112d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f570f89sm62079325e9.7.2024.10.21.09.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 09:27:46 -0700 (PDT)
Date: Mon, 21 Oct 2024 18:27:43 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@idosch.org>
Cc: Yajun Deng <yajun.deng@linux.dev>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 net-next] net: vlan: Use vlan_prio instead of vlan_qos
 in mapping
Message-ID: <ZxaA/6zaqgbrcHX/@debian>
References: <20241018141233.2568-1-yajun.deng@linux.dev>
 <ZxT3oVQ27erIoTVz@shredder.mtl.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxT3oVQ27erIoTVz@shredder.mtl.com>

On Sun, Oct 20, 2024 at 03:29:21PM +0300, Ido Schimmel wrote:
> On Fri, Oct 18, 2024 at 10:12:33PM +0800, Yajun Deng wrote:
> > The vlan_qos member is used to save the vlan qos, but we only save the
> > priority. Also, we will get the priority in vlan netlink and proc.
> > We can just save the vlan priority using vlan_prio, so we can use vlan_prio
> > to get the priority directly.
> > 
> > For flexibility, we introduced vlan_dev_get_egress_priority() helper
> > function. After this patch, we will call vlan_dev_get_egress_priority()
> > instead of vlan_dev_get_egress_qos_mask() in irdma.ko and rdma_cm.ko.
> > Because we don't need the shift and mask operations anymore.
> > 
> > There is no functional changes.
> 
> Not sure I understand the motivation.
> 
> IIUC, currently, struct vlan_priority_tci_mapping::vlan_qos is shifted
> and masked in the control path (vlan_dev_set_egress_priority) so that
> these calculations would not need to be performed in the data path where
> the VLAN header is constructed (vlan_dev_hard_header /
> vlan_dev_hard_start_xmit).
> 
> This patch seems to move these calculations to the data path so that
> they would not need to be performed in the control path when dumping the
> priority mapping via netlink / proc.
> 
> Why is it a good trade-off?

I agree with Ido. The commit description doesn't explain why these
changes are made and I also can't see how this patch can improve
performances.

If it's about code readability, why not just add a helper that gets a
struct vlan_priority_tci_mapping pointer as input and returns a __u8
corresponding to the priority? This way, the /proc and netlink handlers
(and other potential users) wouldn't have to do the bit shifting and
masking manually.


