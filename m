Return-Path: <linux-kernel+bounces-350773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7AA990977
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68BBC1C20AFA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 16:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009641CACE7;
	Fri,  4 Oct 2024 16:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Uc/qQ4so"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B182E1CACD8
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 16:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728059946; cv=none; b=kQdU6UGS3DqI4rpG5JSN6jcfJpkKCK0rTaR4Pk5tyhNh677OJo14OUMeVzR87rt7gN4F0SFPnugbM4SiXdvEMuv5dWKmqPpy7BIG43L9pBf/q/i0SwsJ+axU9ws1qq0tFfsGG6YRFlqp9fX4mBHTswKpEgHclG/uNwiiET/vjoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728059946; c=relaxed/simple;
	bh=KOGBxA9TKiNtFgwxer4DtODPh33GydDwoPWYw+E3pwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s80IMtde2t7soN/WWaE4W21N5GJ4PnlG7e2iRr49VJQVbvXKSqPpMyuP1tb7VYC6sF3vRDWPU2SRvGhaSeksH8Y44j+Q+fGIikAlS3Vk/6CSbacTEWTXZWQKQB+AfNBf8JH2R4qAeyG/P+ueUqrQWoYm6E38kzb/cID6Vs6aNEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Uc/qQ4so; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6e2d2447181so4859987b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 09:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728059943; x=1728664743; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/lLSHt0+nYj7tJq/wFq1Ibo1QSJAO1HOtLTRqFyV92E=;
        b=Uc/qQ4soO03Jdl9rK8E0ONr6Krjkwkxc0kqPs0yTuw4y18MAuEJGxaG53wnCYnR3l5
         QuZ+pn0geKJs+oJhvKwpUCg+u20UdfG3TTXhdTtbSto7Ujwdwgfw/x4kGXy62+LjAju3
         uVG5CTSdIq3kta3LCP4DExm49Od0cMpVeCE2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728059943; x=1728664743;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/lLSHt0+nYj7tJq/wFq1Ibo1QSJAO1HOtLTRqFyV92E=;
        b=BWSF5ghXI55rZxcKpkS76rYNZzGQScXYHRYD9Xs8AxxDuOeQeHXAy2n3vLsvzvO67J
         SOTQ1njM03qotvCfvrjpN1VQjmQD7TWt/sgT1FYCAXu/fYiHBPontMzehpVr4ipJpTte
         Px5rh9XMrtCabc25F0NSQvBCNF/NebRFkyF4tzTLFW6skE5dFmNUDQs0PVbeQazOqoVF
         s3/D01Zs4FwNuR3L+JxjZetQYiuphY43qvv2rm12yoksr0Y5SgomA1DaCklXOi2hGqEw
         1wSWKwyaraGraZl8u9tB/6jzQNbAeQQpikUMzKSnlD4n0G2GgSWfS2aPorp4/No62MLU
         JX4w==
X-Forwarded-Encrypted: i=1; AJvYcCVoXkvGtZQr1XnA/OWMneysfzzreSLVrMmwAVyHnNgbLhzs8JsJ41V+qg4MHkIfpPA4E4sw2F2I06gi23g=@vger.kernel.org
X-Gm-Message-State: AOJu0YybZQK6it/CnI2b4SXfzJP4e8rlSShlCy6rZsoYNXeu1pYZFlER
	/NsIfTQ5YYRd28jpFj0lDM2//2cOg9oX2b98KFOwedw9qow8Rsd5WDE/QPgj7lY=
X-Google-Smtp-Source: AGHT+IFUO9Qec+Fyg4mR5cnhdoa6mE6+lZPxlypX01sjMFc2kbSqtkciKXZVoHeDf3dvsRklzRArRA==
X-Received: by 2002:a05:690c:2e0d:b0:6db:db7b:891c with SMTP id 00721157ae682-6e2c6ff8368mr24030637b3.14.1728059943665;
        Fri, 04 Oct 2024 09:39:03 -0700 (PDT)
Received: from LQ3V64L9R2 ([50.222.228.166])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2bd1cf38asm6843927b3.140.2024.10.04.09.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 09:39:03 -0700 (PDT)
Date: Fri, 4 Oct 2024 12:39:01 -0400
From: Joe Damato <jdamato@fastly.com>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: netdev@vger.kernel.org, Michael Chan <mchan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next v2 2/2] tg3: Link queues to NAPIs
Message-ID: <ZwAaJSKlofFuS1_8@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>, netdev@vger.kernel.org,
	Michael Chan <mchan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20240925162048.16208-1-jdamato@fastly.com>
 <20240925162048.16208-3-jdamato@fastly.com>
 <ZvXrbylj0Qt1ycio@LQ3V64L9R2>
 <CALs4sv1G1A8Ljfb2WAi7LkBN6oP62TzH6sgWyh5jaQsHw3vOFg@mail.gmail.com>
 <Zv3VhxJtPL-27p5U@LQ3V64L9R2>
 <CALs4sv0-FeMas=rSy8OHy_HLiQxQ+gZwAfZVAdzwhFbG+tTzCg@mail.gmail.com>
 <Zv700Aoyx_XG6QVd@LQ3V64L9R2>
 <CALs4sv1Ea1ke2CHOZ0U75JVY84uY=NNyaJrW8wVwcytON2ofog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALs4sv1Ea1ke2CHOZ0U75JVY84uY=NNyaJrW8wVwcytON2ofog@mail.gmail.com>

On Fri, Oct 04, 2024 at 09:03:58PM +0530, Pavan Chebbi wrote:

[...]

> > > Thinking out loud, a better way would be to save the tx/rx id inside
> > > their struct tg3_napi in the tg3_request_irq() function.
> >
> > I think that could work, yes. I wasn't sure if you'd be open to such
> > a change.
> >
> > It seems like in that case, though, we'd need to add some state
> > somewhere.
> >
> > It's not super clear to me where the appropriate place for the state
> > would be because tg3_request_irq is called in a couple places (like
> > tg3_test_interrupt).
> >
> > Another option would be to modify tg3_enable_msix and modify:
> >
> >   for (i = 0; i < tp->irq_max; i++)
> >           tp->napi[i].irq_vec = msix_ent[i].vector;
> Hi Joe, not in favor of this change.

OK

[...]

> > I think it's possible, it's just disruptive and it's not clear if
> > it's worth it? Some other code path might break and it might be fine
> > to just rely on the sequential indexing? Not sure.
> >
> I don't have strong opposition to your proposal of using local counters.
> Just that an alternate solution like what I suggested may look less
> arbitrary, imo.

I don't see where the state would be added for tracking the current
rxq_idx and txq_idx, though. And I don't necessarily agree that the
counters are arbitrary?

Unless tg3 is currently rx and tx index somewhere, then just
assuming they are linear seems fine ?

> So if you want to use the local counters you may go ahead unless
> Michael has any other suggestions.

I'll send another RFC and you can see what it looks like before
deciding.

