Return-Path: <linux-kernel+bounces-224399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA159121DC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 12:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D54C1C2352E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 10:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73B0175564;
	Fri, 21 Jun 2024 10:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YUJf3q/r"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811E7172BBF
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 10:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718964708; cv=none; b=HjBkOsE3hYtTVtD6adc3tZUDFse5IHHyWDXn79mulSOaOXs/Xj64cC0jSyMzRzdEbx8zbKViOQ77S00WvKX9mlnKMdvtP5nevwJKjwDMR1vPz5QyCIyQW7K1vux8lruaml4r68/BM39SORauOnrkyEkuh/ASponJw1mXec6vW94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718964708; c=relaxed/simple;
	bh=ds+n2Z/vTLu6ylFJUoh8rET4QMBEzAe0PVAxicLEPKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+OlOrRDGToS72/YxS+U0kMQzx9RjGGhN0AChbsady/FiTtKXORjdR+0qyT18BWtCc9jZL1ZwumFuT8uKZTbc+6I+8mProfPc5sa7yZw+qocF45+92iDPc65uaBIe6fP1WpPBDbykaLyS3guR4p8BhtRb9A4DEgBtfQhp8c/lgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YUJf3q/r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718964705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eJBYOdOKQ4Gn1xLmpzv4Yqfj+G7XSh7zQ28K1xrcg3U=;
	b=YUJf3q/r6NtVIVNMiAgIQpQFaVnfPU0c7AvtR7yP5Cn6iuHnCxAa0wpUBmpmezFlQ2k0g6
	eeLj+WgMSxvC66QW2u7MbWO1/w0kIDr70NsVBscqpsTh4sMSwAgxjcN0/+kday2Lp1KlNN
	UuWE7KAR/HdkyPO98AbsqBWv9QhP8/Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-B3Vaknb4Mt-fXxussQVolA-1; Fri, 21 Jun 2024 06:11:44 -0400
X-MC-Unique: B3Vaknb4Mt-fXxussQVolA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-36536118656so792827f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 03:11:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718964703; x=1719569503;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eJBYOdOKQ4Gn1xLmpzv4Yqfj+G7XSh7zQ28K1xrcg3U=;
        b=Dkh8YlaB0DmJFtT39YxTdvbfUzi1zuf5fWzpiLoqM/rVzkssrccPjI/cQCMFO1fR6N
         0L4XjoTHgIowBcWLLkJyMf5QWNYKo34HEPAyULxhk4CV307oqmfBXGHql1Fub9wAAM4q
         pLu+hFiuTCVdcjyvdv/AtdN4tcx1B+69Rcza9xEe3V8dfLgEb35qWnR/7ofmoC+JFPZz
         ejtWzsDi+t2X8bYITvM81a2PMesF/rPAo/Wfmlh8o7jE9QT7Ma2XngsU7qbARSRwZgeA
         e3HOYbUbmAP2FpOfgAnJK6bNPz82FmGC4CeBEScFC/PhNZp2AClBuqrETniNnD7YJ7w1
         34kA==
X-Forwarded-Encrypted: i=1; AJvYcCUx5sZ9Bg4rkEY3UvWsgZ8mYulDTVSNxyoWu1aLFdaet1+0/MHmAeH0zjQTJOK2LpPPw2ygd2EIk6MmZtWKWgNCXfW35CKsb+452T4n
X-Gm-Message-State: AOJu0YwDC0GGoeXyM9V+y3RVz9bIu1VjkOoRvh6s8aVIWb7lgDyagBnv
	tVldjq557tQx341lXFjdIp93RWlEoIdF22iAoTsMbjBND9wA9W8vKedh5nC0yVPrZ7aDcpAzhYi
	mgK2dwbcdlW1MTIxbjh62i6kf4H6nlFeoiQMvtoqwwGTnDGWhgqKJOEeSjYw8VQ==
X-Received: by 2002:adf:9789:0:b0:361:d3ec:1031 with SMTP id ffacd0b85a97d-36317b7d4e1mr5447614f8f.31.1718964702923;
        Fri, 21 Jun 2024 03:11:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPWCjAxrrMaIGHIIhSa52v8fFT1APP2qrYVpvKzDzGgYOJQWUZ0ImF+bd9M5CAG4wk9RK8Yw==
X-Received: by 2002:adf:9789:0:b0:361:d3ec:1031 with SMTP id ffacd0b85a97d-36317b7d4e1mr5447579f8f.31.1718964701948;
        Fri, 21 Jun 2024 03:11:41 -0700 (PDT)
Received: from localhost ([2a01:e11:1007:ea0:8374:5c74:dd98:a7b2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366383f6722sm1291316f8f.24.2024.06.21.03.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 03:11:41 -0700 (PDT)
Date: Fri, 21 Jun 2024 12:11:40 +0200
From: Davide Caratti <dcaratti@redhat.com>
To: =?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>
Cc: Ilya Maximets <i.maximets@ovn.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next 2/9] net/sched: cls_flower: prepare
 fl_{set,dump}_key_flags() for ENC_FLAGS
Message-ID: <ZnVR3LsBSvfRyTDD@dcaratti.users.ipa.redhat.com>
References: <20240611235355.177667-1-ast@fiberby.net>
 <20240611235355.177667-3-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240611235355.177667-3-ast@fiberby.net>

hello Asbjørn,

some update on this work: I tested your patch after adapting iproute2
bits (e.g. using TCA_FLOWER_KEY_FLAGS_TUNNEL_<CSUM|DONT_FRAGMENT|OAM|CRIT>

from

https://lore.kernel.org/netdev/20240611235355.177667-2-ast@fiberby.net/

Now: functional tests on TCA_FLOWER_KEY_ENC_FLAGS systematically fail. I must
admit that I didn't complete 100% of the analysis, but IMO there is at least an
endianness problem here. See below:

On Tue, Jun 11, 2024 at 11:53:35PM +0000, Asbjørn Sloth Tønnesen wrote:
> Prepare fl_set_key_flags/fl_dump_key_flags() for use with
> TCA_FLOWER_KEY_ENC_FLAGS{,_MASK}.
> 
> This patch adds an encap argument, similar to fl_set_key_ip/
> fl_dump_key_ip(), and determine the flower keys based on the
> encap argument, and use them in the rest of the two functions.
> 
> Since these functions are so far, only called with encap set false,
> then there is no functional change.
> 
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
> ---
>  net/sched/cls_flower.c | 40 ++++++++++++++++++++++++++++++----------
>  1 file changed, 30 insertions(+), 10 deletions(-)
> 
> diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
> index eef570c577ac7..6a5cecfd95619 100644
> --- a/net/sched/cls_flower.c
> +++ b/net/sched/cls_flower.c
> @@ -1166,19 +1166,28 @@ static void fl_set_key_flag(u32 flower_key, u32 flower_mask,
>  	}
>  }
>  
> -static int fl_set_key_flags(struct nlattr **tb, u32 *flags_key,
> +static int fl_set_key_flags(struct nlattr **tb, bool encap, u32 *flags_key,
>  			    u32 *flags_mask, struct netlink_ext_ack *extack)
>  {
> +	int fl_key, fl_mask;
>  	u32 key, mask;
>  
> +	if (encap) {
> +		fl_key = TCA_FLOWER_KEY_ENC_FLAGS;
> +		fl_mask = TCA_FLOWER_KEY_ENC_FLAGS_MASK;
> +	} else {
> +		fl_key = TCA_FLOWER_KEY_FLAGS;
> +		fl_mask = TCA_FLOWER_KEY_FLAGS_MASK;
> +	}
> +
>  	/* mask is mandatory for flags */
> -	if (!tb[TCA_FLOWER_KEY_FLAGS_MASK]) {
> +	if (NL_REQ_ATTR_CHECK(extack, NULL, tb, fl_mask)) {
>  		NL_SET_ERR_MSG(extack, "Missing flags mask");
>  		return -EINVAL;
>  	}
>  
> -	key = be32_to_cpu(nla_get_be32(tb[TCA_FLOWER_KEY_FLAGS]));
> -	mask = be32_to_cpu(nla_get_be32(tb[TCA_FLOWER_KEY_FLAGS_MASK]));
> +	key = be32_to_cpu(nla_get_be32(tb[fl_key]));
> +	mask = be32_to_cpu(nla_get_be32(tb[fl_mask]));


I think that (at least) the above hunk is wrong - or at least, it is a
functional discontinuity that causes failure in my test. While the
previous bitmask storing tunnel control flags was in host byte ordering,
the information on IP fragmentation are stored in network byte ordering.

So, if we want to use this enum

--- a/include/uapi/linux/pkt_cls.h
+++ b/include/uapi/linux/pkt_cls.h
@@ -677,6 +677,11 @@ enum {
 enum {
 	TCA_FLOWER_KEY_FLAGS_IS_FRAGMENT = (1 << 0),
 	TCA_FLOWER_KEY_FLAGS_FRAG_IS_FIRST = (1 << 1),
+	/* FLOW_DIS_ENCAPSULATION (1 << 2) is not exposed to userspace */
+	TCA_FLOWER_KEY_FLAGS_TUNNEL_CSUM = (1 << 3),
+	TCA_FLOWER_KEY_FLAGS_TUNNEL_DONT_FRAGMENT = (1 << 4),
+	TCA_FLOWER_KEY_FLAGS_TUNNEL_OAM = (1 << 5),
+	TCA_FLOWER_KEY_FLAGS_TUNNEL_CRIT_OPT = (1 << 6),
 };
 
consistently, we should keep using network byte ordering for
TCA_FLOWER_KEY_FLAGS_TUNNEL_* flags (for a reason that I don't understand,
because metadata are not transmitted on wire. But maybe I'm missing something).

Shall I convert iproute2 to flip those bits like it happens for
TCA_FLOWER_KEY_FLAGS ? thanks!

-- 
davide


