Return-Path: <linux-kernel+bounces-359592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FAE998DAD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA6DE283DD4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DF919C57D;
	Thu, 10 Oct 2024 16:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Jf4zudzU"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54AD19C56F
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 16:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728578445; cv=none; b=Xi9RMcYGJqCGnXP9aX7TbGtbGws9nlXgsmfJubk5PHFXal2VW9aNcJSdyDTReU3iOH9tBJ2N6qQyKT/+QaZKjaG38WPAylb8Do7FcbSDRTHI3xgFXqzij07xLUgqSTpzja040EsV+HWGRy7O910760a957bDGcgwga3K2Yy/z4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728578445; c=relaxed/simple;
	bh=1v4s7mTEnjH3CXjUOO8maI7isaTxaSFEhk9NStrXkfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fL6PkYd2fQSJxNZShBgJdV5ACBX+2gXfNMC19gNmof3weaQBy5VX1JI8oxNAHshNiY9GR1PbODcZy8eKexjeFM4ttodqmdlEiWVU2n6EfRkAfGDowFsKTy5F2pY8pmxNsz6CvRlLWoEzP2leLik8aCWA0uShwNqq0hq1iQ4MMe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Jf4zudzU; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71e0cd1f3b6so900596b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 09:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728578443; x=1729183243; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NiQxZ4aNJmS0qPABBP4LcVTamG/dKSm/ne+/UKqykEM=;
        b=Jf4zudzUc2Zvw3P1YBQG0UE+niQPyynqAZr6Rif/GaH0YZbo1HT8CvqMfuLAHaodE1
         7tl0fU+VppEWpuB31C+uYAwzDeh0kfspdt4rg5uw+WPkmEkoC4LJwmlNbRnlgnr9RhFW
         ZNnEkUM2cVqwu2w73elogcYIEvKE2dU1KYr+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728578443; x=1729183243;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NiQxZ4aNJmS0qPABBP4LcVTamG/dKSm/ne+/UKqykEM=;
        b=QUjtblCtafOhSMgsfwk4tjpfkuR/zuEj8TyR3zPgAYppqncHKQ61hiv3IlCz4UYabd
         90DC9q/cncmksgrPB0oC7LrjKFDvs6OTZn5t8lZhh3R8b9m3fbxMhb3qnYJX58odiiu1
         M9iBT9OWTrHkLFRI8K1xAHKFWJwosduGc1ZLMv8JwyApn8ioyezvMEMfy0Ft/Jgkj2ul
         97J1YCNO2kAVXmvae9GkJli4ebfSYT+C56EcXoU/yWESMcdGD87wHYM+11haKBVK4fAA
         CSnOdCc7F5/Ly7icIjTFnWIhcLepUyTCXp8DTdJSycnq7g+eN2WG145DQVuSjKyc3LPi
         +cKw==
X-Forwarded-Encrypted: i=1; AJvYcCWAdOxf9pF96qN8bdDy6xLJIMUoScCHs/rtIm5uCJBIFpCkgkNhUDdtaZxV26jO8p01sxd7q/4OmBEi5qQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1oOro7CAIbLzrp2StqaozXAfQiKOqHBVhVzyQi2zEJgbQxMkF
	ue120DFXyOTePhZWNhDOAnCb2kbj7r8VAqx6GePKcKfmQU5G1cvJ75wnLjXlx3o=
X-Google-Smtp-Source: AGHT+IEUhCypbSWyCbOVGeM1WG8LW+4NQl83CePuAwrOn3lsI6juJ8vumyaQebjeHVdDbQQf2BjKFg==
X-Received: by 2002:a05:6a00:3c84:b0:71e:989:e714 with SMTP id d2e1a72fcca58-71e1db74cf3mr10946520b3a.11.1728578443159;
        Thu, 10 Oct 2024 09:40:43 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2a9e98edsm1220396b3a.34.2024.10.10.09.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 09:40:42 -0700 (PDT)
Date: Thu, 10 Oct 2024 09:40:39 -0700
From: Joe Damato <jdamato@fastly.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, skhawaja@google.com, sdf@fomichev.me,
	bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com,
	Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [net-next v5 6/9] netdev-genl: Support setting per-NAPI config
 values
Message-ID: <ZwgDh3O0_95uGAgd@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, skhawaja@google.com, sdf@fomichev.me,
	bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com,
	Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20241009005525.13651-1-jdamato@fastly.com>
 <20241009005525.13651-7-jdamato@fastly.com>
 <CANn89iJ1=xA9WGhXAMcCAeacE3pYgqiWjcBdxiWjGPACP-5n_g@mail.gmail.com>
 <20241010081923.7714b268@kernel.org>
 <CANn89iK_iDY_nTCgqYUk7D_R8k_qu2qQrs2rUAxxAu_ufrzBnw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iK_iDY_nTCgqYUk7D_R8k_qu2qQrs2rUAxxAu_ufrzBnw@mail.gmail.com>

On Thu, Oct 10, 2024 at 05:30:26PM +0200, Eric Dumazet wrote:
> On Thu, Oct 10, 2024 at 5:19 PM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Thu, 10 Oct 2024 06:24:54 +0200 Eric Dumazet wrote:
> > > > +static const struct netlink_range_validation netdev_a_napi_defer_hard_irqs_range = {
> > > > +       .max    = 2147483647ULL,
> > >
> > > Would (u64)INT_MAX  work ?
> >
> > I sent a codegen change for this. The codegen is a bit of a mess.
> >
> > > > +int netdev_nl_napi_set_doit(struct sk_buff *skb, struct genl_info *info)
> > > > +{
> > > > +       struct napi_struct *napi;
> > > > +       unsigned int napi_id;
> > > > +       int err;
> > > > +
> > > > +       if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_NAPI_ID))
> > > > +               return -EINVAL;
> > > > +
> > > > +       napi_id = nla_get_u32(info->attrs[NETDEV_A_NAPI_ID]);
> > > > +
> > > > +       rtnl_lock();
> > >
> > > Hmm.... please see my patch there :
> > >
> > >  https://patchwork.kernel.org/project/netdevbpf/patch/20241009232728.107604-2-edumazet@google.com/
> > >
> > > Lets not add another rtnl_lock() :/
> >
> > It's not as easy since NAPIs can come and go at driver's whim.
> > I'm quietly hoping we can convert all netdev-nl NAPI accesses
> > to use the netdev->lock protection I strong-armed Paolo into
> > adding in his shaper series. But perhaps we can do that after
> > this series? NAPI GET already takes RTNL lock.
> 
> 
> napi_by_id() is protected by rcu and its own spinlock ( napi_hash_lock )
> I do not see why rtnl is needed.
> This will also be a big issue with per netns-RTNL anyway.

I deeply appreciate and respect both of your thoughts on this; I
will hold off on sending a v6 until a decision is made on this
particular issue.

Thank you both for your careful review and analysis.

