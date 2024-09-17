Return-Path: <linux-kernel+bounces-331899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE93597B2A0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 18:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 450C21F230F9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 16:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4844217C9E9;
	Tue, 17 Sep 2024 16:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Btj9KYxV"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6F616087B
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 16:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726589182; cv=none; b=cp/bT5IOj4nXecNFkjdXlitomp+NzJA0WdQN9VDCfS1d/zRExPpbvKBHEKJdRAUBGa62SBbEc5Zq2HT/PWZrc6GkpKQcRk8ZdIdhaTCeJb64ncNv5MqzVT1x13zEcR9s5UjQyIqRb71EEJSnX1IkufAGjDmsWazqqX53ePMcqZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726589182; c=relaxed/simple;
	bh=32AEDX9cCv9RsZHT9wdTvhGXqMlN0xLTW5QkFMjL/4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qn+5JLEuHyKech4mRzsnMrWaMuacHtClNwPGUzDXaUtgAylkssnHXl1HZRxevGZIX15SIqAaI9JrvKMOulsFMxJI6tw/ucpZ/ST+9uVHF2ILYw6ODuEIjqczlRKVBrUx49i1zgd7HcLtXYD+CvxCo8eeta1aROKwXlZOPApkA0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Btj9KYxV; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-374c7e64b60so3482719f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 09:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1726589178; x=1727193978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C3wWVmY11x7twX+QLzZLt+655E3mj9zAVsD71Ldt/Ac=;
        b=Btj9KYxVw2j9NpKleB/T4folXDUm1hDLKUOF5p0UP0rZmRW2zo9kKiUcb4zFCbI0HH
         6DSW1IUTCDDH6VWtfXz0WH3NhmVcbyV/iVYT0lXpFgiysn5nRfnPokS8WJZJ1bpuldDJ
         usBcdZhn6U3VR6hG//rwzv6qNn1mlhSUP1mMZmGEECdbnLyPQvbY+Zg2oQ4o2RZKI2pj
         mLOXrXarn9A8BBN95HQTDi/FNFBlTSHIXTg5vXCW36ggChLGOrR0cDzqkQYrimAVoBwK
         TWbSSy8B5M46b/bGT6pj3puG6ytURDoRQ2hNtmFxWgUzNOVW22NSRdS/dG4l6Xo295gp
         pykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726589178; x=1727193978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3wWVmY11x7twX+QLzZLt+655E3mj9zAVsD71Ldt/Ac=;
        b=OzTuYOkARPywqtYFLWgDf/lim1qxOFO2IL69Wq/wSWaq8A5fwxXIWElXTOvheBJMrv
         6AnU9I7VnrqxNdYZZT24L18xrR46JHydkq4RmOyaEkpleQBslLhiN86jZAGLQ8yA13Aa
         mQIyl4Jn6EP1IxSBQ/hQ5o9A50N6ttV7SrhrAK9zHobCRfpJIyaVA3cXQdgEFGyTrECu
         QifVdjjeFzlqTWDbnyv/lMF5VUEJX5ADvJ3Pee22nVDlFWDituapD80b5OPlI0/SvLIl
         z9GPVOWiVpOfecVzZy4AcNTK2iH9bv0RPv7fPi+2ks2k32wPsDQp6SBBPHFEyRgFE3K0
         7Wfg==
X-Forwarded-Encrypted: i=1; AJvYcCUJdU42Zcfz8DVdgcQkv+KXm8aBeO/LrY+LlpmacrVXY80kgDJPG3AArfp0EUChpG9uCkepG/6K622cO94=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlyNNezdfpFS/0MrSwhtha5m9oyOVxfTRhluNLFjwy3VnTxGWw
	cYCI+pPy8N5j0NDLKkA+64GOLnqzfqVXuQjtNy/Kojzjt+ZXi6qrYKQhVi/EKFo=
X-Google-Smtp-Source: AGHT+IFBa6LORWITRw1wV+KPnnRiX0GK6peQ486VSUGuguJIiXw3h4Apf2WbrzFK92EDTfdpTnDLRA==
X-Received: by 2002:adf:a45d:0:b0:374:c847:848 with SMTP id ffacd0b85a97d-378c2d5a70dmr9566997f8f.36.1726589177899;
        Tue, 17 Sep 2024 09:06:17 -0700 (PDT)
Received: from GHGHG14 ([2a09:bac5:50ca:432::6b:83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e7800138sm9857539f8f.68.2024.09.17.09.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 09:06:17 -0700 (PDT)
Date: Tue, 17 Sep 2024 17:06:14 +0100
From: Tiago Lam <tiagolam@cloudflare.com>
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Jakub Sitnicki <jakub@cloudflare.com>, kernel-team@cloudflare.com
Subject: Re: [RFC PATCH 2/3] ipv6: Run a reverse sk_lookup on sendmsg.
Message-ID: <Zumo9rNztx4PJgRP@GHGHG14>
References: <20240913-reverse-sk-lookup-v1-0-e721ea003d4c@cloudflare.com>
 <20240913-reverse-sk-lookup-v1-2-e721ea003d4c@cloudflare.com>
 <20240914085950.GC12935@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240914085950.GC12935@kernel.org>

On Sat, Sep 14, 2024 at 09:59:50AM +0100, Simon Horman wrote:
> On Fri, Sep 13, 2024 at 10:39:20AM +0100, Tiago Lam wrote:
> > This follows the same rationale provided for the ipv4 counterpart, where
> > it now runs a reverse socket lookup when source addresses and/or ports
> > are changed, on sendmsg, to check whether egress traffic should be
> > allowed to go through or not.
> > 
> > As with ipv4, the ipv6 sendmsg path is also extended here to support the
> > IPV6_ORIGDSTADDR ancilliary message to be able to specify a source
> 
> Hi Tiago Lam,
> 
> Some minor nits from my side.
> 
> ancilliary -> ancillary
> 
> Likewise in patch 3/3.
> Flagged by checkpatch.pl --codespell
> 
> > address/port.
> > 
> > Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
> > Signed-off-by: Tiago Lam <tiagolam@cloudflare.com>
> > ---
> >  net/ipv6/datagram.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  net/ipv6/udp.c      |  8 ++++--
> >  2 files changed, 82 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
> > index fff78496803d..4214dda1c320 100644
> > --- a/net/ipv6/datagram.c
> > +++ b/net/ipv6/datagram.c
> > @@ -756,6 +756,27 @@ void ip6_datagram_recv_ctl(struct sock *sk, struct msghdr *msg,
> >  }
> >  EXPORT_SYMBOL_GPL(ip6_datagram_recv_ctl);
> >  
> > +static inline bool reverse_sk_lookup(struct flowi6 *fl6, struct sock *sk,
> > +				     struct in6_addr *saddr, __be16 sport)
> > +{
> > +	if (static_branch_unlikely(&bpf_sk_lookup_enabled) &&
> > +	    (saddr && sport) &&
> > +	    (ipv6_addr_cmp(&sk->sk_v6_rcv_saddr, saddr) || inet_sk(sk)->inet_sport != sport)) {
> 
> Please consider, where it can trivially be achieved, limiting Networking
> code to 80 columns wide.
> 
> Checkpatch can be run with a flag to check for this.
> 

Thanks for the hints here, I've addressed these and will include the
changes into the next revision. I use b4 which takes care of some of
this checks, but I'll make sure I change my settings to use
`--max-line-length=80` as well.

Tiago.

