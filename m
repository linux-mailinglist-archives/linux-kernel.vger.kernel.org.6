Return-Path: <linux-kernel+bounces-284527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3968E9501EF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F9421C22115
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E86519AA56;
	Tue, 13 Aug 2024 10:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="E5wf1B8F"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D01419415D
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 10:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723543395; cv=none; b=Wqmc8FAOudg4BMQ49Z/TY5EIsDMxRZA+REzsjDdktbpSZZkA04KRiaV5I4UB+NHHBsW8Mw4WtjKWnYPisUFWNL+Kyh6fSkAMZHhACHAYb28CzhYwFtbsAWaKWvshArMKV9GgtXDsEGq5qZql6B+016mfXhO+VJ8YpOn+JVMs8OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723543395; c=relaxed/simple;
	bh=6hHxBTF20IAqMcrcWgWzdAZWnXVDz98qQ4rdoPVmnc4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4/k1RFLcIMlGaeN/xODOon64HOCBpsTV0vCJK03aUOJy7wil0blsONluAZ9CK+In+FZWihQZufdApVJ+nPFjqIXivg18epX8x9CV+ic3PqGsSEFSMEA7pAvmjFSR3yGQpOq6bpMfCAY7QJuux95A2Hps8xmnL8SdrFaTjaXaUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=E5wf1B8F; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-426526d30aaso36725975e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 03:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1723543392; x=1724148192; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T04SXkyqQZxIqmQoVlUZ/CBkiEUBgtICNJn27Tj+HX4=;
        b=E5wf1B8FAjtnaBuf7THonqU71JA7t9Nl73QoWTn7t0uDww52MjyP/tfdsZsXMwSjnY
         YDtgsa9JxAHTZhVTPAAYRu0C3EEn45pfPXGGYkTG4ra7PMR5oJupSq9EYCfiiANoqqBI
         DW4+1qnlC9rtF3f4Ip9nXItAaRvht3gvg2d9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723543392; x=1724148192;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T04SXkyqQZxIqmQoVlUZ/CBkiEUBgtICNJn27Tj+HX4=;
        b=XhyNyaJi/AzS8a7ateFxkP+RZLhVNIuaUHllUaXr89k+o6/zFMTED532qe/1sZV3Qi
         frpTJMYRHQN1yzHzAb6Q/3csz1yiElsifSgjD7hZT2t+x68OhsPRbm1GOfMiCdeUM/tv
         BsVzsA5mRwZ+9b4SJIJX7DuCwOeDCk+C9pD84s83fyuhuwQjcsC960fpR1wx3/izE+Rt
         l1cXj+fqvIfSVJflguuGkk2sPTG7MlFTEC8h9ABohS55BFy1+rl/9t8K0Gfg32Z9O4iq
         EfdZwAr4eZiTxijUzR3cOQQWbJ6dpJ8YMc36u47aBrdDJRG58+SRMPcfQr8D9m4JT/Jb
         tUdw==
X-Forwarded-Encrypted: i=1; AJvYcCXqDJREfX22CU4FF0T+dZxcmDHSkJJvWXsEAn+1X3URhPEXO/5uXB1lUPhaN94ZcEWWqNaobzmMjvYRgt6yt3OcThUfd1c/Uyyj7w+c
X-Gm-Message-State: AOJu0YyFssjTcZB1dnLvrG3cfWJIYw+kh/+H9u4QqG1Hcpi/gZCe/6d1
	asXcVODbS5lUNgOsUiGl+V1qEDiN3ujVtiVqEH72gpI9a7Aw41T1unjQS6BuQgo=
X-Google-Smtp-Source: AGHT+IEVxsJQrPna8BnBBYWvsnS69mNeRLqPL9TBeudC2bV7VmS8DrvjKf95gf3mTw2by5VUOuVCKA==
X-Received: by 2002:a05:600c:198b:b0:426:618f:1a31 with SMTP id 5b1f17b1804b1-429d48a5287mr22432755e9.34.1723543391613;
        Tue, 13 Aug 2024 03:03:11 -0700 (PDT)
Received: from LQ3V64L9R2.home ([80.208.222.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c739083sm211899095e9.18.2024.08.13.03.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 03:03:11 -0700 (PDT)
Date: Tue, 13 Aug 2024 11:03:09 +0100
From: Joe Damato <jdamato@fastly.com>
To: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next 1/6] netdevice: Add napi_affinity_no_change
Message-ID: <ZrsvXQ0FGAdtgUaQ@LQ3V64L9R2.home>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	open list <linux-kernel@vger.kernel.org>
References: <20240812145633.52911-1-jdamato@fastly.com>
 <20240812145633.52911-2-jdamato@fastly.com>
 <ZrpvP_QSYkJM9Mqw@mini-arch>
 <Zrp50DnNfbOJoKr7@LQ3V64L9R2.home>
 <ZrqOekK43_YyMHmR@mini-arch>
 <ZrsjLS8wRcYL3HxQ@LQ3V64L9R2.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrsjLS8wRcYL3HxQ@LQ3V64L9R2.home>

On Tue, Aug 13, 2024 at 10:11:09AM +0100, Joe Damato wrote:
> On Mon, Aug 12, 2024 at 03:36:42PM -0700, Stanislav Fomichev wrote:
> > On 08/12, Joe Damato wrote:
> > > On Mon, Aug 12, 2024 at 01:23:27PM -0700, Stanislav Fomichev wrote:
> > > > On 08/12, Joe Damato wrote:
> > > > > Several drivers have their own, very similar, implementations of
> > > > > determining if IRQ affinity has changed. Create napi_affinity_no_change
> > > > > to centralize this logic in the core.
> > > > > 
> > > > > This will be used in following commits for various drivers to eliminate
> > > > > duplicated code.
> > > > > 
> 
> [...]
> 
> > > > > +bool napi_affinity_no_change(unsigned int irq)
> > > > > +{
> > > > > +	int cpu_curr = smp_processor_id();
> > > > > +	const struct cpumask *aff_mask;
> > > > > +
> > > > 
> > > > [..]
> > > > 
> > > > > +	aff_mask = irq_get_effective_affinity_mask(irq);
> > > > 
> > > > Most drivers don't seem to call this on every napi_poll (and
> > > > cache the aff_mask somewhere instead). Should we try to keep this
> > > > out of the past path as well?
> > > 
> > > Hm, I see what you mean. It looks like only gve calls it on every
> > > poll, while the others use a cached value.
> > > 
> > > Maybe a better solution is to:
> > >   1. Have the helper take the cached affinity mask from the driver
> > >      and return true/false.
> > >   2. Update gve to cache the mask (like the other 4 are doing).
> > 
> > SG! GVE is definitely the outlier here.
> 
> OK, I'll hack on that for rfcv2 and see what it looks like. Thanks
> for the suggestion.

Yea, I just did this for rfcv2 and it looks a lot nicer/fewer
changes. Will hold off on sending an rfc v2 until the 48 hour timer
expires ;)

> Hopefully the maintainers (or other folks) will chime in on whether
> or not I should submit fixes for patches 4 - 6 for the type mismatch
> stuff first or just handle it all together.

