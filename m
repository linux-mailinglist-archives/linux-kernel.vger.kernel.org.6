Return-Path: <linux-kernel+bounces-256698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A5E93521E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 21:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A193283AC7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 19:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34128145A0A;
	Thu, 18 Jul 2024 19:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D+cSf4/D"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D161B13AA26
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 19:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721330893; cv=none; b=PInp/IJobkWLg2s+ZhttIhWAxmH/sh3s0GqV/XHJwoSAyz2E7rz228BBJIDgCgyG6Lm5mkn366hUcXWD6IE0YNkxSrBSaEHXWcKA0O3M7qn7tyE31ClVH+MC8Lb8vwKtSANgvuqoXPkXH0HQK688GSeepOo9DGyXkSF9aBeCNWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721330893; c=relaxed/simple;
	bh=hOXcRf1xMFrEzhzW/LnjACR6jGvf86F5VJttf9LLjy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/jpJsa5B8+s+QnMDa5tRCRjGwEtnTqASGyNYLCilKK3MDGCLasUKpp+fTztI475EWX9FIlr09JKey9rpU/wQ0cseKs/nIT+z3zOY5uxLIUTxGSQyy2ji5ASOfDIuAMo41jtDuXFG8MUb92G6JOOzJKoV3vO5x4HfBJiFr1+7zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D+cSf4/D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721330890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rDZ5M+z92pHpshwG1/cax9lDFRAQ589w+2UZ+nT4yxw=;
	b=D+cSf4/D20/tHWAYFyH4+imEKQ+FI3TMOGSlT0VaAeNZawk17iDVAS0lvciqxKjzE7P4MG
	YGP+yXXFDNswdMxZt2nwVTcWKPSebORbLxpvikYz4X3l3sDxgpITL7UnosPbaF5gWymY0v
	NXA5ZJARUKoHJFDdYYJ76oHc4yff2V0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-rzHBS8fDOfOBWVnDbieyDg-1; Thu, 18 Jul 2024 15:28:09 -0400
X-MC-Unique: rzHBS8fDOfOBWVnDbieyDg-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5a25bf1810bso148506a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 12:28:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721330888; x=1721935688;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rDZ5M+z92pHpshwG1/cax9lDFRAQ589w+2UZ+nT4yxw=;
        b=VcE0ajX49OtyUIcTnZ1qLuG1RWbXa4RytiONi4qe5gM3j6wTzElHtD9RS91SNX2zed
         G9tCKIauQdIsqCNBT68XoL6rV4MlBilXbmhviTyNQXHcoAlGyJL/YEM4wGKwXKcaoHUT
         K82XxmnhWgim9SASMpVicu6k8BNeUNTFEoHbpqpLPBdYPh83iTMCj3+BiNsaSfio/iE5
         /T4Wuz++/n1Z2shyioPw8HDd6Td31sn8sjYwjIPfCjHx5NyoHlWpAg3shUggM9CjDLGk
         7KqIVeuRPoP3hh7PAkYTb6DOThqk1/aM3C9nHdBcFimClY3+jOU1zuaei7vLx6kXIB+N
         W+og==
X-Forwarded-Encrypted: i=1; AJvYcCXH/cqQKAIwLikzGa9BYbUYkzrmJggNj2nXQv+3nVF18s7j5pPyPGykuE+OB8UH78S6tprzqls87xBFogZNBZp/UXU5K3ukqDEj5j6m
X-Gm-Message-State: AOJu0Yzj4owoyyE2E+bKno2b925DrJVS3c8h7ZBJlSHYSGuHUPXTI4QL
	sye69DdI5sMJZgiUbD3sWU5bHRmOd4sVnHtl6iv1Cu85N9mPG5gFBjFTvkdH+LUaUdWYxBt7UNW
	zLNg5cEG2IEeMyLOGooLJY649dGpmgw2PLuVwcznaGViGtBBgJnNu/i2TpCaKXQ==
X-Received: by 2002:a17:906:615:b0:a75:3c2d:cd8e with SMTP id a640c23a62f3a-a7a011e5879mr431239666b.27.1721330888277;
        Thu, 18 Jul 2024 12:28:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNBugtdGfi6vyNKd7H45kvEtMDZ7Q+4JtfeFiuLdziqbae7sxeS5yTAmkCgh9bauEMGzVKwg==
X-Received: by 2002:a17:906:615:b0:a75:3c2d:cd8e with SMTP id a640c23a62f3a-a7a011e5879mr431232966b.27.1721330887696;
        Thu, 18 Jul 2024 12:28:07 -0700 (PDT)
Received: from redhat.com (mob-5-90-112-15.net.vodafone.it. [5.90.112.15])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368727f29c6sm399103f8f.45.2024.07.18.12.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 12:28:06 -0700 (PDT)
Date: Thu, 18 Jul 2024 15:28:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, aha310510@gmail.com, arefev@swemel.ru,
	arseny.krasnov@kaspersky.com, davem@davemloft.net,
	dtatulea@nvidia.com, eperezma@redhat.com, glider@google.com,
	iii@linux.ibm.com, jiri@nvidia.com, jiri@resnulli.us,
	kuba@kernel.org, lingshan.zhu@intel.com, ndabilpuram@marvell.com,
	pgootzen@nvidia.com, pizhenwei@bytedance.com,
	quic_jjohnson@quicinc.com, schalla@marvell.com, stefanha@redhat.com,
	sthotton@marvell.com,
	syzbot+6c21aeb59d0e82eb2782@syzkaller.appspotmail.com,
	vattunuru@marvell.com, will@kernel.org, xuanzhuo@linux.alibaba.com,
	yskelg@gmail.com
Subject: Re: [GIT PULL] virtio: features, fixes, cleanups
Message-ID: <20240718152712-mutt-send-email-mst@kernel.org>
References: <20240717053034-mutt-send-email-mst@kernel.org>
 <CACGkMEura9v43QtBmWSd1+E_jpEUeXf+u5UmUzP1HT5vZOw3NA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEura9v43QtBmWSd1+E_jpEUeXf+u5UmUzP1HT5vZOw3NA@mail.gmail.com>

On Thu, Jul 18, 2024 at 08:52:28AM +0800, Jason Wang wrote:
> On Wed, Jul 17, 2024 at 5:30 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > This is relatively small.
> > I had to drop a buggy commit in the middle so some hashes
> > changed from what was in linux-next.
> > Deferred admin vq scalability fix to after rc2 as a minor issue was
> > found with it recently, but the infrastructure for it
> > is there now.
> >
> > The following changes since commit e9d22f7a6655941fc8b2b942ed354ec780936b3e:
> >
> >   Merge tag 'linux_kselftest-fixes-6.10-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest (2024-07-02 13:53:24 -0700)
> >
> > are available in the Git repository at:
> >
> >   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
> >
> > for you to fetch changes up to 6c85d6b653caeba2ef982925703cbb4f2b3b3163:
> >
> >   virtio: rename virtio_find_vqs_info() to virtio_find_vqs() (2024-07-17 05:20:58 -0400)
> >
> > ----------------------------------------------------------------
> > virtio: features, fixes, cleanups
> >
> > Several new features here:
> >
> > - Virtio find vqs API has been reworked
> >   (required to fix the scalability issue we have with
> >    adminq, which I hope to merge later in the cycle)
> >
> > - vDPA driver for Marvell OCTEON
> >
> > - virtio fs performance improvement
> >
> > - mlx5 migration speedups
> >
> > Fixes, cleanups all over the place.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> 
> It looks like this one is missing?
> 
> https://lore.kernel.org/kvm/20240701033159.18133-1-jasowang@redhat.com/T/
> 
> Thanks

It's not included in the full but it's a bugfix and it's subtel enough
that I decided it's best to merge later, in particular when I'm not on
vacation ;)

-- 
MST


