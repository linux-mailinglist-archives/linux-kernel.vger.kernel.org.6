Return-Path: <linux-kernel+bounces-236794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8395F91E731
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 20:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4418B2836F7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6A516EC11;
	Mon,  1 Jul 2024 18:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FeseSx12"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012AB16EBEA
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 18:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719857449; cv=none; b=f+9BphB+7rhIkb4zxOFGfbeB4Cijr8IsT97Ge+lbtT+/Pkh1vHl/OvQq07PDwmKyqvkGxTyVUirdraa8dGQbKxaVjFPqAkk/tiqI8KdpADAbp3h9nWoaaJd5JLLR+fFtbAR4W4vavhTmCd/vRXEFAKNkKpgvBckW5NJlO2Wwzd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719857449; c=relaxed/simple;
	bh=ub7wy9wbVGLRWhSD/YbjKzEHraTvzBQPoST6f7ZZa6k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RzXvkQawWHHvR96s2ZqgJThP9j8fL3UR6BG3uj6uvPBquvnzdbYNWoZ8qtRH8FJM8S/6AvS6f9LDGaJrD+/pytj5/spS7hgJw52O5i8p22fdCSwX36wmhhxQ8gQtywccFKAVz2aSEvLdoTzKf3jKx1MjwYHidjZQ88RxngEXSGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FeseSx12; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719857446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JM1W3lT8X94kstTVgU0L4T7iVYaF/txP6qsNDPjlfkI=;
	b=FeseSx122NVz1+eEm1ZYV9ofyXQKAGazdLxD0a+vDT8hksFJWWPhd5utuEDElxtMjqqUbq
	8/1Pbd6RgQq7fhXrB7KGPxzqPrH4T1qYGXLeApwbkOrDO1HRBEkTuv+cIJ1n0YE8+3AFBp
	G5I/EQMvBy/nEZyZMgarp7yAsWFU/BU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-382-HmKSMqD2MvqWr_YFd2CCXg-1; Mon,
 01 Jul 2024 14:10:42 -0400
X-MC-Unique: HmKSMqD2MvqWr_YFd2CCXg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E74CC1955DCD;
	Mon,  1 Jul 2024 18:10:39 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.8.184])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9332A19560AE;
	Mon,  1 Jul 2024 18:10:36 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org,  echaudro@redhat.com,  horms@kernel.org,
  i.maximets@ovn.org,  dev@openvswitch.org,  Ido Schimmel
 <idosch@nvidia.com>,  Yotam Gigi <yotam.gi@gmail.com>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 04/10] net: psample: allow using rate as
 probability
In-Reply-To: <20240630195740.1469727-5-amorenoz@redhat.com> (Adrian Moreno's
	message of "Sun, 30 Jun 2024 21:57:25 +0200")
References: <20240630195740.1469727-1-amorenoz@redhat.com>
	<20240630195740.1469727-5-amorenoz@redhat.com>
Date: Mon, 01 Jul 2024 14:10:34 -0400
Message-ID: <f7tplrxvv8l.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Adrian Moreno <amorenoz@redhat.com> writes:

> Although not explicitly documented in the psample module itself, the
> definition of PSAMPLE_ATTR_SAMPLE_RATE seems inherited from act_sample.
>
> Quoting tc-sample(8):
> "RATE of 100 will lead to an average of one sampled packet out of every
> 100 observed."
>
> With this semantics, the rates that we can express with an unsigned
> 32-bits number are very unevenly distributed and concentrated towards
> "sampling few packets".
> For example, we can express a probability of 2.32E-8% but we
> cannot express anything between 100% and 50%.
>
> For sampling applications that are capable of sampling a decent
> amount of packets, this sampling rate semantics is not very useful.
>
> Add a new flag to the uAPI that indicates that the sampling rate is
> expressed in scaled probability, this is:
> - 0 is 0% probability, no packets get sampled.
> - U32_MAX is 100% probability, all packets get sampled.
>
> Acked-by: Eelco Chaudron <echaudro@redhat.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> ---

Reviewed-by: Aaron Conole <aconole@redhat.com>

>  include/net/psample.h        |  3 ++-
>  include/uapi/linux/psample.h | 10 +++++++++-
>  net/psample/psample.c        |  3 +++
>  3 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/include/net/psample.h b/include/net/psample.h
> index 2ac71260a546..c52e9ebd88dd 100644
> --- a/include/net/psample.h
> +++ b/include/net/psample.h
> @@ -24,7 +24,8 @@ struct psample_metadata {
>  	u8 out_tc_valid:1,
>  	   out_tc_occ_valid:1,
>  	   latency_valid:1,
> -	   unused:5;
> +	   rate_as_probability:1,
> +	   unused:4;
>  	const u8 *user_cookie;
>  	u32 user_cookie_len;
>  };
> diff --git a/include/uapi/linux/psample.h b/include/uapi/linux/psample.h
> index e80637e1d97b..b765f0e81f20 100644
> --- a/include/uapi/linux/psample.h
> +++ b/include/uapi/linux/psample.h
> @@ -8,7 +8,11 @@ enum {
>  	PSAMPLE_ATTR_ORIGSIZE,
>  	PSAMPLE_ATTR_SAMPLE_GROUP,
>  	PSAMPLE_ATTR_GROUP_SEQ,
> -	PSAMPLE_ATTR_SAMPLE_RATE,
> +	PSAMPLE_ATTR_SAMPLE_RATE,	/* u32, ratio between observed and
> +					 * sampled packets or scaled probability
> +					 * if PSAMPLE_ATTR_SAMPLE_PROBABILITY
> +					 * is set.
> +					 */
>  	PSAMPLE_ATTR_DATA,
>  	PSAMPLE_ATTR_GROUP_REFCOUNT,
>  	PSAMPLE_ATTR_TUNNEL,
> @@ -20,6 +24,10 @@ enum {
>  	PSAMPLE_ATTR_TIMESTAMP,		/* u64, nanoseconds */
>  	PSAMPLE_ATTR_PROTO,		/* u16 */
>  	PSAMPLE_ATTR_USER_COOKIE,	/* binary, user provided data */
> +	PSAMPLE_ATTR_SAMPLE_PROBABILITY,/* no argument, interpret rate in
> +					 * PSAMPLE_ATTR_SAMPLE_RATE as a
> +					 * probability scaled 0 - U32_MAX.
> +					 */
>  
>  	__PSAMPLE_ATTR_MAX
>  };
> diff --git a/net/psample/psample.c b/net/psample/psample.c
> index 1c76f3e48dcd..f48b5b9cd409 100644
> --- a/net/psample/psample.c
> +++ b/net/psample/psample.c
> @@ -497,6 +497,9 @@ void psample_sample_packet(struct psample_group *group, struct sk_buff *skb,
>  		    md->user_cookie))
>  		goto error;
>  
> +	if (md->rate_as_probability)
> +		nla_put_flag(skb, PSAMPLE_ATTR_SAMPLE_PROBABILITY);
> +
>  	genlmsg_end(nl_skb, data);
>  	genlmsg_multicast_netns(&psample_nl_family, group->net, nl_skb, 0,
>  				PSAMPLE_NL_MCGRP_SAMPLE, GFP_ATOMIC);


