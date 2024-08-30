Return-Path: <linux-kernel+bounces-308394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE656965C62
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E2861F22C5B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E5216FF26;
	Fri, 30 Aug 2024 09:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="xvM5LSon"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E1916DEA5
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 09:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725009056; cv=none; b=rPgYy2kOBRR/teQ8zajFm3QfPBvu48s21FTApr5Yqs+Gm0FfuLom2HR5Er9dMU5lEKMCQi225pWcUnc5kKni0hAxbA5PkHA7np3HoesDuXXxTQXwCyUca4gpwqMrPP1ix0Y+lqwKKFXxK9yH68QY38kxu0ybKYOAay3RHJ0/TE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725009056; c=relaxed/simple;
	bh=ouc5SelbcUEeLbIKAy1PL590gU8h/Y+tRHBWjIietME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WygPurwsDNeUNP95qxDWJLQYcxQCaU0aCFG8LohLY8qeZWdyH3u2YjR/PTu5JB1hf4H3AsdW76gwgDEs1+BCOsc/p3bJLelhWaeu87e0ph6PXe1wh7uNMIkCW3owX2slmqC7xayG+K5NFqvowFtQOt6C2k8UdkC7278SP32tOZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=xvM5LSon; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53349d3071eso2066053e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 02:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1725009051; x=1725613851; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XpZRKEehtMhARC5Q09BJz9/avERmrSGkNeheOITXWCQ=;
        b=xvM5LSonxCYVMK5rUxun7VXFypvdikdKke6ZwN3xNrmirsczKBYmD62EbDM5RCGKjr
         Jk6QIbf3WzORS1FFTF+g/czGyxq88YqkWIEdHMzBSrOVlVCS02RSAbQVboCkSezPZ5U2
         WAnWOqZ9nnSc3BZkBELonSF5sIySwFqFNbnSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725009051; x=1725613851;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XpZRKEehtMhARC5Q09BJz9/avERmrSGkNeheOITXWCQ=;
        b=A4u1SZuKvct9vbDA8+r045WWUYZpkfXfh3kutXLqmoi1/U0p2ls50abflEBcX3O8Rr
         zklbJcYFG5YcOxOIjhY4WKqP0Im5YlHjtMLuE/QD23MrCp2wHXQZO3+kSnzyzp20n5nA
         P//He5CaK2cqnVSnwG3FP6Nkij6+KC6KQJo0ACQkYntU3qTPyoO2vWyIUjTv3OiJSm8t
         Or2K1NaoopdvvFx+0k63kBHcSjPq01AQ1gd0gmLmP3CGaNVtek6ytjd0BFJBREkY4uWY
         MhhWpG0mjlrKuaE3udQsDjsBwREgLqOE1zzwmXEoEEkMj29ZNTWGVewzR4tHQue9A6za
         uC+w==
X-Forwarded-Encrypted: i=1; AJvYcCUNoFYfNObwSb6OGmYLBLCSQkbEfQ4Qvo6V0J5n1sIG/s7OG+St+uxwZkehHQlM/foZlojP7+JExXggdwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM1RdnKz620cC+kLkqgpP/bGgsRvrCt8SbEgw/Sy6dBbbdsYf8
	T3zZkhtaqHzQa+XDjP/ZWUF56x/nJmCjXgevuvTeqkhpM9PlDukX74cbOh7CAho=
X-Google-Smtp-Source: AGHT+IHjx0n3ARgxvAGgVuhpJmG9U2yKFPOhS4yVWarD+kYyVKUHx6B4J1AUDn4FnyffqaCoJI+RPQ==
X-Received: by 2002:a05:6512:398c:b0:530:9d86:6322 with SMTP id 2adb3069b0e04-53546b8d897mr1051285e87.41.1725009050302;
        Fri, 30 Aug 2024 02:10:50 -0700 (PDT)
Received: from LQ3V64L9R2 ([80.208.222.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891db563sm190359366b.185.2024.08.30.02.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 02:10:50 -0700 (PDT)
Date: Fri, 30 Aug 2024 10:10:47 +0100
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, sdf@fomichev.me, bjorn@rivosinc.com,
	hch@infradead.org, willy@infradead.org,
	willemdebruijn.kernel@gmail.com, skhawaja@google.com,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 2/5] netdev-genl: Dump napi_defer_hard_irqs
Message-ID: <ZtGMl25LaopZk1So@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, sdf@fomichev.me, bjorn@rivosinc.com,
	hch@infradead.org, willy@infradead.org,
	willemdebruijn.kernel@gmail.com, skhawaja@google.com,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20240829131214.169977-1-jdamato@fastly.com>
 <20240829131214.169977-3-jdamato@fastly.com>
 <20240829150828.2ec79b73@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240829150828.2ec79b73@kernel.org>

On Thu, Aug 29, 2024 at 03:08:28PM -0700, Jakub Kicinski wrote:
> On Thu, 29 Aug 2024 13:11:58 +0000 Joe Damato wrote:
> > diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> > index 959755be4d7f..ee4f99fd4574 100644
> > --- a/Documentation/netlink/specs/netdev.yaml
> > +++ b/Documentation/netlink/specs/netdev.yaml
> > @@ -244,6 +244,11 @@ attribute-sets:
> >               threaded mode. If NAPI is not in threaded mode (i.e. uses normal
> >               softirq context), the attribute will be absent.
> >          type: u32
> > +      -
> > +        name: defer-hard-irqs
> > +        doc: The number of consecutive empty polls before IRQ deferral ends
> > +             and hardware IRQs are re-enabled.
> > +        type: s32
> 
> Why is this a signed value? 🤔️

In commit 6f8b12d661d0 ("net: napi: add hard irqs deferral
feature"), napi_defer_hard_irqs was added to struct net_device as an
int. I was trying to match that and thus made the field a signed int
in the napi struct, as well.

It looks like there was a possibility of overflow introduced in that
commit in change_napi_defer_hard_irqs maybe ?

If you'd prefer I could:
  - submit a Fixes to change the net_device field to a u32 and then
    change the netlink code to also be u32
  - add an overflow check (val > U32_MAX) in
    change_napi_defer_hard_irqs

Which would mean for the v2 of this series:
  - drop the overflow check I added in Patch 1
  - Change netlink to use u32 in this patch 

What do you think?

> You can use:
> 
> 	check:
> 		max: s32-max
> 
> to have netlink validate the overflow if you switch to u32.
> 
> >    -
> >      name: queue
> >      attributes:
> 
> > @@ -188,6 +189,10 @@ netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
> >  			goto nla_put_failure;
> >  	}
> >  
> > +	napi_defer_hard_irqs = napi_get_defer_hard_irqs(napi);
> 
> Here, for example the READ_ONCE() wouldn't have been necessary, right?
> Cause we are holding rtnl_lock(), just a random thought, not really
> actionable.

That's right, yes.

I think it depends on where we land with the wrapper functions? I'll
reply with my thoughts about that in that thread.

