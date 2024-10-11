Return-Path: <linux-kernel+bounces-361633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAE999AAAE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B91521F22675
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55E81C244B;
	Fri, 11 Oct 2024 17:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="F+dy1ya7"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979817F9
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 17:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728669065; cv=none; b=sE4XdTlj2KUeXyid4gCcpSbkzwEv71C2L1DWmRmOGXqXokSEbiKstMJ0der+WdpkR+YXrEabIaGdhMEkfir+jJgrJeUA3bmjoBhDr2tmDghf8uJK4+BOi3SkP0APBomdjlHkqjr+d3xnAFilWl0y0momMDSxQyYBs5k/ylOxLyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728669065; c=relaxed/simple;
	bh=TWG5/vrvpxkuVk5XXDU2QrOHtYfyNAN1kOAsWJQ6I4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2WAg/TTvvReGUVrGUnW9aBjM2++nmp8P+cid6cpLvaEEOEswl8Or8G9a8qiBuHqRpIK2nhYAH3QIKN9fr/cJmyKftWGDW0ZtcR8TchMSVOf8QKhZp73swg77ZNint2JRb7ExDdWqpdOlBMvgcn++YutkfBeCPgfg0t1ELpzxZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=F+dy1ya7; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-207115e3056so18873415ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 10:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728669063; x=1729273863; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RvnmNjfgy1//lZbNTPPlkwEdk3MRe3SYgZ2nM+Y5pJg=;
        b=F+dy1ya7fyydZ79FOT4Ifq+3ak48vGhJqLIQqYl7zyn3bYqxlf41bgBvLSztJzIONg
         PJpcOK9/kiv6GVHvgAFOJlN6nQpn22gPFG4Kq7RaRKEz151PWxZ50oWXUTsgH6yKAsB5
         ZtjCv8CGosowoBb7Py2wyMfmjnYvnxkqQY9kM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728669063; x=1729273863;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RvnmNjfgy1//lZbNTPPlkwEdk3MRe3SYgZ2nM+Y5pJg=;
        b=iDm1vqtdIVylNF+Q6wY9yavrCpWVsxCvBtWPfLmOhZznIyHkISIX7fRIKakxT4JTuU
         a8kk8QUBbldY7EwuMrRofvDNWqeyoX0x5Exz0Ye2KTMuADCdejoUO2X7Otq6+GfIbGA1
         ZAmSUvN/44OA9iaH8g4JQaCAer4DITZtyk2lSH+ZbIz8DKMrbSh6Xtx6K4XZIAQ30mul
         bQxGb/2D9LgJS11EKiN5Czm4r9P4QtqM6ZfPBOvWfnj+mseJ9WnCWHUlasLbMP4+wxpe
         7OOK+QcCFmSsmwhxTsKKigUivYsX1Qv0qN/30vK2oJLyJE91asf6LvMXx6oLLw7977iZ
         eCvA==
X-Forwarded-Encrypted: i=1; AJvYcCVEtMI9YU7BzRBhA3IQX0zH0jpY7QhK0c3mLgXeB085xEpO3+dJCCvwuHgKXtFYlZKIGgxIpo1yhsfIXgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfbSdRBKtHlU3R6f+bUEEXte9Rd116gJjBHKEvHheJLHGNXUMV
	1K8wxS2PRk8SGVQmRdCEgCfuYJ6zDzi4cbHE4tECjL1nbl1pWOnBolt9IgxzbIY=
X-Google-Smtp-Source: AGHT+IGMpfzhw02DP7gsHgb6/cY4RebhSS+seJXmW/NKZ/XA4TbwouBQqOnbenkVe4gPEIt/GFEkOA==
X-Received: by 2002:a17:902:d501:b0:20b:c1e4:2d5d with SMTP id d9443c01a7336-20ca1677e53mr50290365ad.34.1728669062932;
        Fri, 11 Oct 2024 10:51:02 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bc00dcesm25742415ad.64.2024.10.11.10.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 10:51:02 -0700 (PDT)
Date: Fri, 11 Oct 2024 10:50:59 -0700
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
Message-ID: <ZwllgzfOrK86q15M@LQ3V64L9R2>
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
 <ZwgDh3O0_95uGAgd@LQ3V64L9R2>
 <CANn89iL65LPmJbiHVt10JvKXSVMhk-SsTN5xdaZ7MjgXXT4f9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iL65LPmJbiHVt10JvKXSVMhk-SsTN5xdaZ7MjgXXT4f9w@mail.gmail.com>

On Fri, Oct 11, 2024 at 07:19:47PM +0200, Eric Dumazet wrote:
> On Thu, Oct 10, 2024 at 6:40 PM Joe Damato <jdamato@fastly.com> wrote:
> >
> > On Thu, Oct 10, 2024 at 05:30:26PM +0200, Eric Dumazet wrote:
> > > On Thu, Oct 10, 2024 at 5:19 PM Jakub Kicinski <kuba@kernel.org> wrote:
> > > >
> > > > On Thu, 10 Oct 2024 06:24:54 +0200 Eric Dumazet wrote:
> > > > > > +static const struct netlink_range_validation netdev_a_napi_defer_hard_irqs_range = {
> > > > > > +       .max    = 2147483647ULL,
> > > > >
> > > > > Would (u64)INT_MAX  work ?
> > > >
> > > > I sent a codegen change for this. The codegen is a bit of a mess.
> > > >
> > > > > > +int netdev_nl_napi_set_doit(struct sk_buff *skb, struct genl_info *info)
> > > > > > +{
> > > > > > +       struct napi_struct *napi;
> > > > > > +       unsigned int napi_id;
> > > > > > +       int err;
> > > > > > +
> > > > > > +       if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_NAPI_ID))
> > > > > > +               return -EINVAL;
> > > > > > +
> > > > > > +       napi_id = nla_get_u32(info->attrs[NETDEV_A_NAPI_ID]);
> > > > > > +
> > > > > > +       rtnl_lock();
> > > > >
> > > > > Hmm.... please see my patch there :
> > > > >
> > > > >  https://patchwork.kernel.org/project/netdevbpf/patch/20241009232728.107604-2-edumazet@google.com/
> > > > >
> > > > > Lets not add another rtnl_lock() :/
> > > >
> > > > It's not as easy since NAPIs can come and go at driver's whim.
> > > > I'm quietly hoping we can convert all netdev-nl NAPI accesses
> > > > to use the netdev->lock protection I strong-armed Paolo into
> > > > adding in his shaper series. But perhaps we can do that after
> > > > this series? NAPI GET already takes RTNL lock.
> > >
> > >
> > > napi_by_id() is protected by rcu and its own spinlock ( napi_hash_lock )
> > > I do not see why rtnl is needed.
> > > This will also be a big issue with per netns-RTNL anyway.
> >
> > I deeply appreciate and respect both of your thoughts on this; I
> > will hold off on sending a v6 until a decision is made on this
> > particular issue.
> >
> 
> I do not want to block your series.
> 
> Whatever is needed later, I can handle.

Thank you, Eric.

I am happy to help with the future changes if needed. Feel free to
reach out if you'd like me to assist in any way as I know you have a
tremendous amount of work on your plate.

I will submit the v6 shortly, after I've rebased and retested.

