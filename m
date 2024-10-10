Return-Path: <linux-kernel+bounces-358241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D3A997BD9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 06:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68F1BB21A6E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 04:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9712C19D072;
	Thu, 10 Oct 2024 04:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="u5JtX7j3"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80196BE57
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 04:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728534855; cv=none; b=Y4ZyaY0EyXRKIMARZ5WhTLG2dxd3aa+mxzDhHQLbU6/174qFvjGNoMiVFZWgoHGX/O3RD6KkaxSKgB2w6CK2UrJCRVj4JvRyT1FmyyzMIS6pb/t2iLDmW+7aFK9UFHNHmqjHzc6LaCwu9Oh+/hTTifEn3e7pCf0+FSjgulEshIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728534855; c=relaxed/simple;
	bh=+D0Yu+AiuwdgK0KE//2cIiuGf0FGLy02zgoiSYotEO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8x+5Yrw26lfJJSsbcfEVwxAESJ602wKo+NnAxi8T4VhKCqWnyiVZsxQdJyyu8zfa2yFoKiXnOu8nM1tmNX/bXhsbUBNR0PNzA0PwcJ1E0WQ5Ym1PRWYXIk9SOQw5yez3rXamdlnRRtT0xxuhb7vGwG6VHO3cHXZ86r0FJtRYaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=u5JtX7j3; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20c8b557f91so899255ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 21:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728534853; x=1729139653; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ru0GqDNnHREuf1N1Hb8puLNX8+vvYQ2NpDSnpYqMBRI=;
        b=u5JtX7j3cvdOelIpEfciDEeyZFRK2Q4vWfoGhozwVlWTiVsZAlkpdVFzhkxdvQPOAr
         eNhjbecV4HnTbpj11b0Yop5n4BiXk1aea9F4AzQu6QEgXOhptpTi+VQZ51+UgAxKL1Tr
         To3eAY3fbYR6Qd1FQ2R64xiPzS3SxAggwHpXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728534853; x=1729139653;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ru0GqDNnHREuf1N1Hb8puLNX8+vvYQ2NpDSnpYqMBRI=;
        b=q3+88VPuUC+YpKYLFDlUPYa1xdbMkM0CJqFMmzZesAD8eN7nL1x0Rpe+KnpXy18H9S
         Oac1caKdUpvxrXOBI9dpP66h0C0S7ksmGF8xSNvNtj4AZJLik9hPU61/0AAppQqsI9ZK
         WT8FOyiGXRH2ClMOpSxtfA30BWaKhrl349EE3LUZjT5AK+yjwOmi/mNh1PvaKeyBlNpH
         7SQMtTUmgcOeQWw/USydgwa/m7oxTyj38BfhhgtYqg+rHvr8jlRijkfhw78izfotLqlW
         sMV9KUUeDEsKqRiYr9kEGnm1pBtkaD/5pmq2xaUNZvJF/80qoZ7Rqev06KZ8dPfouDrc
         RsNA==
X-Forwarded-Encrypted: i=1; AJvYcCVIVHh6nDp2SnIzZXWC7hlw8uaETFgHhX1ziQcnS/tVDjt5F2AI/9wvgh4Wsiw9VetyqjoEh0lRc6vO1wA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKCRIxiQtYGIPKlw24OzahVTcZakVUP4RDOOjsQz/5/lKoMbwL
	a2SDLvP1FPKqcMviNpDr7yK/hNOHiIXVSuDOFkCXi6D5hmUmme1CeKFnVfOM2cU=
X-Google-Smtp-Source: AGHT+IHY/9GujKBHhEJYM2QlZjSxZWmrCpOl6E9PzdTkBiyc7izTt2r+1s55OGSKxvsCLBtwjsCsnA==
X-Received: by 2002:a17:902:ec85:b0:20b:fbcf:f941 with SMTP id d9443c01a7336-20c63782a4amr68195735ad.47.1728534852851;
        Wed, 09 Oct 2024 21:34:12 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bc1355csm2105315ad.67.2024.10.09.21.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 21:34:12 -0700 (PDT)
Date: Wed, 9 Oct 2024 21:34:09 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, skhawaja@google.com,
	sdf@fomichev.me, bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [net-next v5 4/9] netdev-genl: Dump gro_flush_timeout
Message-ID: <ZwdZQa3nujo7TZ1c@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, skhawaja@google.com, sdf@fomichev.me,
	bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20241009005525.13651-1-jdamato@fastly.com>
 <20241009005525.13651-5-jdamato@fastly.com>
 <20241009201440.418e21de@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009201440.418e21de@kernel.org>

On Wed, Oct 09, 2024 at 08:14:40PM -0700, Jakub Kicinski wrote:
> On Wed,  9 Oct 2024 00:54:58 +0000 Joe Damato wrote:
> > +        name: gro-flush-timeout
> > +        doc: The timeout, in nanoseconds, of when to trigger the NAPI
> > +             watchdog timer and schedule NAPI processing.
> 
> You gotta respin because we reformatted the cacheline info.

Yea, I figured I'd be racing with that change and would need a
respin.

I'm not sure how the queue works exactly, but it looks like I might
also be racing with another change [1], I think.

I think I'm just over 24hr and could respin and resend now, but
should I wait longer in case [1] is merged before you see my
respin?

Just trying to figure out how to get the fewest number of respins
possible ;)

> So while at it perhaps throw in a sentence here about the GRO effects?
> The initial use of GRO flush timeout was to hold incomplete GRO
> super-frames in the GRO engine across NAPI cycles.

From my reading of the code, if the timeout is non-zero, then
napi_gro_flush will flush only "old" super-frames in
napi_complete_done.

If that's accurate (and maybe I missed something?), then how about:

doc: The timeout, in nanoseconds, of when to trigger the NAPI
     watchdog timer which schedules NAPI processing. Additionally, a
     non-zero value will also prevent GRO from flushing recent
     super-frames at the end of a NAPI cycle. This may add receive
     latency in exchange for reducing the number of frames processed
     by the network stack.

LMK if that's accurate and sounds OK or if it's wrong / too verbose?

[1]: https://lore.kernel.org/netdev/20241009232728.107604-1-edumazet@google.com/T/#m3f11aae53b3244037ac641ef36985c5e85e2ed5e

