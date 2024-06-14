Return-Path: <linux-kernel+bounces-215297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BF59090CE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 18:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA777281B0F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A9315EFAA;
	Fri, 14 Jun 2024 16:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cwKNM2G5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A512F3E
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 16:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718384172; cv=none; b=eLheDsWf6QLwPnrZPxPAUG+dEeeDBRwBuKuzGYkiYzJXUYcQH6wDw7/Y5x6yjmZgUxyh62qzurqdKLZkLWw3UimsB1PO0CYQleEfS697hBNR2duo3cINR2WPeiJhXu5sh5w20x7Xt+YKyLGPZSqpom6ShyrKnqH8erkukUHHShM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718384172; c=relaxed/simple;
	bh=Vj4TQ0WEd/iYuaqi9sLaN+gfs3U3EO6MpUWKfbmYVhM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uPKqq2mkDj4MZ9yI8a8o0DaxHAHw9EfjZtvrexQswQ3fgcTpsccbFpEI3aonrd70EJuNHxvYIM5HVYykZr/G/PQW1XR+rx4LAFCnu1Ufj/uho0sue9HMUDu8nZSHN4D5AUxZ7o+FYxb+tn661+hFtM8h5qd12YtGvEaIGrNL22w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cwKNM2G5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718384168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=08KlAF1dPNFg+6U2RamZg0E1oBoZjXixTNWJIdnj7fs=;
	b=cwKNM2G5Uvc1Ijp7RWDptGmLf4A8JKSfGn7HTyTx2ZGbsTB02CZCQ8XEdvzQDu06Iu5MNg
	dlkmSZi/fYlICft3b3xpSrETcicT3OZzy02h1QWcx50xdQfM5gMf/JoFweUDxl5awlI16s
	nrsDpomNnyPckwrWtRksJcuIsQxarjo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-186-bVN8g-_NOjC5Qbx5xltqBQ-1; Fri,
 14 Jun 2024 12:56:06 -0400
X-MC-Unique: bVN8g-_NOjC5Qbx5xltqBQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 81CF7195609E;
	Fri, 14 Jun 2024 16:56:04 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.16.41])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4533F19560AA;
	Fri, 14 Jun 2024 16:56:01 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org,  echaudro@redhat.com,  horms@kernel.org,
  i.maximets@ovn.org,  dev@openvswitch.org,  Pravin B Shelar
 <pshelar@ovn.org>,  "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 6/9] net: openvswitch: store sampling
 probability in cb.
In-Reply-To: <20240603185647.2310748-7-amorenoz@redhat.com> (Adrian Moreno's
	message of "Mon, 3 Jun 2024 20:56:40 +0200")
References: <20240603185647.2310748-1-amorenoz@redhat.com>
	<20240603185647.2310748-7-amorenoz@redhat.com>
Date: Fri, 14 Jun 2024 12:55:59 -0400
Message-ID: <f7t4j9vo44g.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Adrian Moreno <amorenoz@redhat.com> writes:

> The behavior of actions might not be the exact same if they are being
> executed inside a nested sample action. Store the probability of the
> parent sample action in the skb's cb area.

What does that mean?

> Use the probability in emit_sample to pass it down to psample.
>
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> ---
>  include/uapi/linux/openvswitch.h |  3 ++-
>  net/openvswitch/actions.c        | 25 ++++++++++++++++++++++---
>  net/openvswitch/datapath.h       |  3 +++
>  net/openvswitch/vport.c          |  1 +
>  4 files changed, 28 insertions(+), 4 deletions(-)
>
> diff --git a/include/uapi/linux/openvswitch.h b/include/uapi/linux/openvswitch.h
> index a0e9dde0584a..9d675725fa2b 100644
> --- a/include/uapi/linux/openvswitch.h
> +++ b/include/uapi/linux/openvswitch.h
> @@ -649,7 +649,8 @@ enum ovs_flow_attr {
>   * Actions are passed as nested attributes.
>   *
>   * Executes the specified actions with the given probability on a per-packet
> - * basis.
> + * basis. Nested actions will be able to access the probability value of the
> + * parent @OVS_ACTION_ATTR_SAMPLE.
>   */
>  enum ovs_sample_attr {
>  	OVS_SAMPLE_ATTR_UNSPEC,
> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
> index 3b4dba0ded59..33f6d93ba5e4 100644
> --- a/net/openvswitch/actions.c
> +++ b/net/openvswitch/actions.c
> @@ -1048,12 +1048,15 @@ static int sample(struct datapath *dp, struct sk_buff *skb,
>  	struct nlattr *sample_arg;
>  	int rem = nla_len(attr);
>  	const struct sample_arg *arg;
> +	u32 init_probability;
>  	bool clone_flow_key;
> +	int err;
>  
>  	/* The first action is always 'OVS_SAMPLE_ATTR_ARG'. */
>  	sample_arg = nla_data(attr);
>  	arg = nla_data(sample_arg);
>  	actions = nla_next(sample_arg, &rem);
> +	init_probability = OVS_CB(skb)->probability;
>  
>  	if ((arg->probability != U32_MAX) &&
>  	    (!arg->probability || get_random_u32() > arg->probability)) {
> @@ -1062,9 +1065,21 @@ static int sample(struct datapath *dp, struct sk_buff *skb,
>  		return 0;
>  	}
>  
> +	if (init_probability) {
> +		OVS_CB(skb)->probability = ((u64)OVS_CB(skb)->probability *
> +					    arg->probability / U32_MAX);
> +	} else {
> +		OVS_CB(skb)->probability = arg->probability;
> +	}
> +

I'm confused by this.  Eventually, integer arithmetic will practically
guarantee that nested sample() calls will go to 0.  So eventually, the
test above will be impossible to meet mathematically.

OTOH, you could argue that a 1% of 50% is low anyway, but it still would
have a positive probability count, and still be possible for
get_random_u32() call to match.

I'm not sure about this particular change.  Why do we need it?

>  	clone_flow_key = !arg->exec;
> -	return clone_execute(dp, skb, key, 0, actions, rem, last,
> -			     clone_flow_key);
> +	err = clone_execute(dp, skb, key, 0, actions, rem, last,
> +			    clone_flow_key);
> +
> +	if (!last)

Is this right?  Don't we only want to set the probability on the last
action?  Should the test be 'if (last)'?

> +		OVS_CB(skb)->probability = init_probability;
> +
> +	return err;
>  }
>  
>  /* When 'last' is true, clone() should always consume the 'skb'.
> @@ -1313,6 +1328,7 @@ static int execute_emit_sample(struct datapath *dp, struct sk_buff *skb,
>  	struct psample_metadata md = {};
>  	struct vport *input_vport;
>  	const struct nlattr *a;
> +	u32 rate;
>  	int rem;
>  
>  	for (a = nla_data(attr), rem = nla_len(attr); rem > 0;
> @@ -1337,8 +1353,11 @@ static int execute_emit_sample(struct datapath *dp, struct sk_buff *skb,
>  
>  	md.in_ifindex = input_vport->dev->ifindex;
>  	md.trunc_size = skb->len - OVS_CB(skb)->cutlen;
> +	md.rate_as_probability = 1;
> +
> +	rate = OVS_CB(skb)->probability ? OVS_CB(skb)->probability : U32_MAX;
>  
> -	psample_sample_packet(&psample_group, skb, 0, &md);
> +	psample_sample_packet(&psample_group, skb, rate, &md);
>  #endif
>  
>  	return 0;
> diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath.h
> index 0cd29971a907..9ca6231ea647 100644
> --- a/net/openvswitch/datapath.h
> +++ b/net/openvswitch/datapath.h
> @@ -115,12 +115,15 @@ struct datapath {
>   * fragmented.
>   * @acts_origlen: The netlink size of the flow actions applied to this skb.
>   * @cutlen: The number of bytes from the packet end to be removed.
> + * @probability: The sampling probability that was applied to this skb; 0 means
> + * no sampling has occurred; U32_MAX means 100% probability.
>   */
>  struct ovs_skb_cb {
>  	struct vport		*input_vport;
>  	u16			mru;
>  	u16			acts_origlen;
>  	u32			cutlen;
> +	u32			probability;
>  };
>  #define OVS_CB(skb) ((struct ovs_skb_cb *)(skb)->cb)
>  
> diff --git a/net/openvswitch/vport.c b/net/openvswitch/vport.c
> index 972ae01a70f7..8732f6e51ae5 100644
> --- a/net/openvswitch/vport.c
> +++ b/net/openvswitch/vport.c
> @@ -500,6 +500,7 @@ int ovs_vport_receive(struct vport *vport, struct sk_buff *skb,
>  	OVS_CB(skb)->input_vport = vport;
>  	OVS_CB(skb)->mru = 0;
>  	OVS_CB(skb)->cutlen = 0;
> +	OVS_CB(skb)->probability = 0;
>  	if (unlikely(dev_net(skb->dev) != ovs_dp_get_net(vport->dp))) {
>  		u32 mark;


