Return-Path: <linux-kernel+bounces-326338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F5D9766BE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 12:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A5C91C23101
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 10:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43E419F42D;
	Thu, 12 Sep 2024 10:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="W8R2gx12"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3CB19E96F
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 10:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726137524; cv=none; b=Y3hSbp8yPyP7CB/D6FPBFeOuOVgxLrXFaCv8d6zQ5NIZyLTnAGohdnwCGlMUqJTkYdidEMNgcSnu5ODTjU2nSpuE+LjxjpqbOLKbltzrCSSD0prbox7OSZh/tjrOa4QYtSQBnzNZOW6NlRFYLYgxJsjmxXjJdjWJ9H8Ipr91gy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726137524; c=relaxed/simple;
	bh=hyIJKDKyBGQJ8sBYqdzAAXREso4kqHXOHUWOOvf4Bco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejfSvc9EuAO0lGWNadrwIfgIBY+i4QQsv+4zfWuNlZD5aM2DgByxbFeBN2AxfLmvdeL7xblMC5gutnB3hwMZr8rcJJTh8nbtZA4BP5j2/kj6AD0atdYv3Ij6m88gXALhQvAEr4+eJT6WP2b/MCOs3BAju1F1BdWqn6FfdKdAICI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=W8R2gx12; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5bef295a429so973668a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 03:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1726137521; x=1726742321; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=moGGULLUEV1Y3cbTy14suA2JI+5i9gExySNmdaD1asM=;
        b=W8R2gx12w11JLo95zguNhh+EG3zcN5GNMkP6gC3ms4qif4mW5qxcUu9MAvTF5+4ojI
         0pGJRnnPSD3PT/rNA0CdwaiVZgCcSqw90H6DuU1E6Cu3tiseDPXm226rLq169cU6+EpD
         1DDuN9SGFFeTVCL6Q9/67Qd7VtgW0Vl+1CA7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726137521; x=1726742321;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=moGGULLUEV1Y3cbTy14suA2JI+5i9gExySNmdaD1asM=;
        b=tjv0ENH7g/wEy4XRXG6WRbqUrDaot23aEIKMOcR0L/TaoC2VCEcec0uqw06OjRKFNZ
         pK/ceohVWyQhQGjZaZQOev+r1SHgOWCW6rPQYAnRmWUNiz7C/qnmU3sSPD0Qc3efOuk9
         Oq8dEEAd5MwxghplzuxFZ9olNoJANbPHwfsjATK+XDx1B7Aux71sJJlzwo3o+qINd8hO
         On1fneTRQ+S9i0a1nygh8+bAe2uy5bwgwVFVCXBUAry35bZUcgkRKWVpYeN9+J2+L+cI
         wA7/6f24i2OrVykb+MwYsVISTBTB4ggqY3/TP0wFSoV8xJQPQmHFckjHDoAoLpaKTQ+7
         Bg6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXnNy+mGNKzRzYFfi8oRMnpQ8z/hx54ESC1/AgrKrSZfDAySoq/4QWdicGH6TGx8K+LpJgeg+DVBqXBKiw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3iickROImmyA8kPaNnn1zpw5mQpxd3KvKO+7gcgp/+S7f2Tqv
	nSmHXQeQ61Etu5BeQGlnFJXI2JL7IfIqs0LZgXkuDSt10AN2nMRdowzsrQtWh6hKa/XXA21+UGH
	BIhSg8g==
X-Google-Smtp-Source: AGHT+IFL1gOJsvSHttMZpKvuRPTGnIa2GRXgNK6xpjEjpN3OaswAhWjMaZZsXSr2f6Esrt8faKfOfg==
X-Received: by 2002:a17:906:bc22:b0:a8a:9054:8399 with SMTP id a640c23a62f3a-a902949aca6mr232677766b.27.1726137520104;
        Thu, 12 Sep 2024 03:38:40 -0700 (PDT)
Received: from LQ3V64L9R2.homenet.telecomitalia.it (host-79-23-194-51.retail.telecomitalia.it. [79.23.194.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25c6126esm724495566b.120.2024.09.12.03.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 03:38:39 -0700 (PDT)
Date: Thu, 12 Sep 2024 12:38:37 +0200
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca, kuba@kernel.org, skhawaja@google.com,
	sdf@fomichev.me, bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next v3 6/9] netdev-genl: Support setting per-NAPI
 config values
Message-ID: <ZuLErUy3j6KpswM-@LQ3V64L9R2.homenet.telecomitalia.it>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, kuba@kernel.org, skhawaja@google.com,
	sdf@fomichev.me, bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20240912100738.16567-1-jdamato@fastly.com>
 <20240912100738.16567-7-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912100738.16567-7-jdamato@fastly.com>

On Thu, Sep 12, 2024 at 10:07:14AM +0000, Joe Damato wrote:
> Add support to set per-NAPI defer_hard_irqs and gro_flush_timeout.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>  Documentation/netlink/specs/netdev.yaml | 11 ++++++
>  include/uapi/linux/netdev.h             |  1 +
>  net/core/netdev-genl-gen.c              | 14 ++++++++
>  net/core/netdev-genl-gen.h              |  1 +
>  net/core/netdev-genl.c                  | 45 +++++++++++++++++++++++++
>  tools/include/uapi/linux/netdev.h       |  1 +
>  6 files changed, 73 insertions(+)

My apologies; there's a few merge conflicts with this patch against
the latest net-next/main. I pulled recently, but it looks like
Mina's work got merged (which is excellent news) after I pulled and
so my patch won't apply cleanly.

I can wait the 48 hours to resend or simply reply with an updated
patch 6 in the body of my message, as this is only an RFC.

Let me know what works easiest for anyone who wants to actually test
this (vs just review it).

Sorry about that; should have pulled this morning before sending :)

- Joe

