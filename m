Return-Path: <linux-kernel+bounces-252694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 412DD9316EE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 16:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B6BB2829E6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 14:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8646C18EFE8;
	Mon, 15 Jul 2024 14:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P7XgPkFM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA7118EA9D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 14:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721054307; cv=none; b=jRQjRS+9Bf8aeZZ//ha+MaEyGRGdNGw5WU2oGc9UY/WF4+/w22ymtnARSPLlxgJkQPMEaByKQQZt5GA3xKvpb830XIjvQmV7c+gPqNDAfoq6nNEoezTtgmOU8K7d9BYa9qKrh49U+NsktYhC/JaDgUjHSSdHylqbKlVMEZ7G2ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721054307; c=relaxed/simple;
	bh=2tudeH4asXQXZSaak3ZzzRDXUzzwEGH9p0h3Dri/+Zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ICeSNGqQS7EkDHtH4BTp31N3I4d2n3tGEjon1NY2qFz1xR4H3mgYoyIWBJVg9SEQTNPPvvEtCD2rIZ07lvQvlgRjiXNix1AXrPOa4B4TXNCElN2F4KKmqxMNTb+xWhj5tzMQJ4LOYGLEHl6PD57o1dGk6ZLoyE56ieBqpxbkQn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P7XgPkFM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721054304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JqnhsUJX2tl6nAh5V2Gectwmc33hA1nj9475HkyrKUs=;
	b=P7XgPkFMFq+H6F8SsORFMFMbWDtyQqCVzysv9yvZtrm8KZec6hlFE8mURlMInAzJsTLX+m
	UY4Da+6VzoLxojzf3qNaA/G0ISnstBW50Ac2Em3jnIKT9lpSBsfk/ZHaLUhMHSWaaSVD63
	tQc3OqEtKJqa8tjMzk4TwvTQFwp+874=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-r_vG9KTxPRCoPUzRRlkOmg-1; Mon, 15 Jul 2024 10:38:23 -0400
X-MC-Unique: r_vG9KTxPRCoPUzRRlkOmg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3678ff75122so3123789f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 07:38:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721054302; x=1721659102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JqnhsUJX2tl6nAh5V2Gectwmc33hA1nj9475HkyrKUs=;
        b=u+qKc3qGHA2wY8jrPPssaE9sY5YYhbQqUEgs6/8IOUjbpqgBIKK0W7LlXAG8OzdXaJ
         p/Y58zA+26btdaoYYBCfLu4dEeotFJi2VXZXXqVU2SU4kvhX9tiSauNYdnHqg64nZbc6
         TtdUshbYoVDuDqNdnBmKeV4eCFdMrBnmXTfCZVCnBNQYL9fsnLiVLPTbLkzU0EtqoEbB
         XpM4aEfQfqd/cLfFazHbR81Ly10T7hDMRkzpb4GNljehpfSHdxiqBW5UJ1jJoNeGv9AL
         rsXuNRkH9lXoBDaVXzhTH+81P3RUlLvYxrb0BUQL6KY1FdBiUITsmitkHmqmr+DoGNy1
         5lhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWWnjC4u9sB86B7+H0H4r5XZmikg8xxKkJhkqEYepAEDHK2gq8uy136mZimgJTfTU/PteD/1vZ7EwmnJNTtljkMfS9IaJE+1h39Ali
X-Gm-Message-State: AOJu0YxJIsfFuJSIaDajJPXGJ6CZ81/jQOcCwPfAd1nw5jZg9D0pQtJY
	Tw0nTp48n5E7esexPCYTW9mN6eq6XZPFTuZ9dii39SZAbny7Re9sD8HUEsUO91tQWKdjTTlkLq7
	9Me7+Rt7Z8E/ficdotVJww/geaIzouZjIK5zTzAgIJcRNOo5krBMPMjAV8qy6TfHDy9kC3w==
X-Received: by 2002:adf:8bd6:0:b0:364:8e3f:89f8 with SMTP id ffacd0b85a97d-367ceadb06amr12929788f8f.67.1721054302154;
        Mon, 15 Jul 2024 07:38:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEkTfPqTxDGRze09YdNkKZnLzIuew1RR5dRU6IAqmRqu1plKwM3L5a7zPdQxNzmrWp4dCkqg==
X-Received: by 2002:adf:8bd6:0:b0:364:8e3f:89f8 with SMTP id ffacd0b85a97d-367ceadb06amr12929759f8f.67.1721054301584;
        Mon, 15 Jul 2024 07:38:21 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:243:da88:7ff9:68fc:2f43:bcdf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680daccacdsm6593721f8f.62.2024.07.15.07.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 07:38:20 -0700 (PDT)
Date: Mon, 15 Jul 2024 10:38:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	Si-Wei Liu <si-wei.liu@oracle.com>,
	Eugenio Perez Martin <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH V2 3/7] vhost-vdpa: VHOST_NEW_OWNER
Message-ID: <20240715103021-mutt-send-email-mst@kernel.org>
References: <1720790333-456232-1-git-send-email-steven.sistare@oracle.com>
 <1720790333-456232-4-git-send-email-steven.sistare@oracle.com>
 <20240715050637-mutt-send-email-mst@kernel.org>
 <d414f28e-8887-418f-963a-bb986dbdcaea@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d414f28e-8887-418f-963a-bb986dbdcaea@oracle.com>

On Mon, Jul 15, 2024 at 10:29:26AM -0400, Steven Sistare wrote:
> On 7/15/2024 5:07 AM, Michael S. Tsirkin wrote:
> > On Fri, Jul 12, 2024 at 06:18:49AM -0700, Steve Sistare wrote:
> > > Add an ioctl to transfer file descriptor ownership and pinned memory
> > > accounting from one process to another.
> > > 
> > > This is more efficient than VHOST_RESET_OWNER followed by VHOST_SET_OWNER,
> > > as that would unpin all physical pages, requiring them to be repinned in
> > > the new process.  That would cost multiple seconds for large memories, and
> > > be incurred during a virtual machine's pause time during live update.
> > > 
> > > Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> > 
> > Please, we just need to switch to use iommufd for pinning.
> > Piling up all these hacks gets us nowhere.
> 
> I am working on iommufd kernel interfaces and QEMU changes.  But who is working
> on iommufd support for vdpa? If no one, or not for years, then adding these
> small interfaces to vdpa plugs a signficant gap in live update coverage.
> 
> FWIW, the iommufd interfaces for live update will look much the same: change owner
> and pinned memory accounting, and update virtual addresses.  So adding that to vdpa
> will not make it look like an odd duck.
> 
> - Steve

I think that no one is working on it - Cindy posted some rfcs in January
("vhost-vdpa: add support for iommufd").  Feel free to pick that up.
What you described is just more of a reason not to duplicate this code.
And it's always the same: a small extension here, a small extension there.
If you can make do with existing kernel interfaces, fine,
one can argue that userspace code is useful to support existing kernels.

-- 
MST


