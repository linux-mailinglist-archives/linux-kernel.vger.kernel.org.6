Return-Path: <linux-kernel+bounces-209495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CF49036CD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 10:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9F4F1C232E6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 08:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38835176ACC;
	Tue, 11 Jun 2024 08:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ESCahXUd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F69176ACD
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 08:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718095160; cv=none; b=J3dF50UUOUJGLrCaIGOWNOOun0vSi6Q5+RvNZBeKmbghF0jW4jZ20qfbVXxPUYjS/gC+jOc8zDsg6b1TryApkNzT7OHs0LntyNS+QR4/2rZp3PfLJfBsu3ObzwIPY81IVm/DnoTb69zoSgPubjGo1U62sN/siDjwuUKINhHGZBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718095160; c=relaxed/simple;
	bh=MHTOAsN37xqLncBGCUmqsVn4jEvRnk3b6bXGzaAVRK8=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sy+ISK5STJ7dpAnSTxNVNi6tkzQaGcMK2PjQjLAkY2O1CGqwPTCMNbRTVEU+PuahkNlrA8BBzZlb5DQCvwrTUv1o9OWBZB+mZFDBQ580rw4FNiHG6MIUgRUNhOnB7DZZ1USmK+5pXYoagYeJEQFlvaK03yoAfPOraRZetEGob58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ESCahXUd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718095157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uCtC641JFfNQfpF4RLqFd780CF41WCD/8stofS+Eqf0=;
	b=ESCahXUd1cMtIOxL3yVqEo7VP0OoS9PtneGPT5wv4PxySMwr+TDbThZgGXeieJUO9OzFJ+
	hJgELhUOmiYKpvIPwX/DdlKiwqWlwU+P6rFLpD4QcIqAlxdhNZaMCMXIesYKT2RZi9VfhY
	hsOD7kYoa6WH2Y1cITYW+53TB6qF6/Q=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18--HpOV63XOPCIpyiPDwWGsw-1; Tue, 11 Jun 2024 04:39:12 -0400
X-MC-Unique: -HpOV63XOPCIpyiPDwWGsw-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6b066f99442so9285426d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 01:39:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718095152; x=1718699952;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uCtC641JFfNQfpF4RLqFd780CF41WCD/8stofS+Eqf0=;
        b=SuYdSu6jLP7RmuD54xMSuZ7Anye+1l206rP4Lw8YHuslmdbWpedPDoQFlMegGlBQEA
         m58JlSzMzSj6YduCQfAvkrFRemkv7Ztv5QNIHeIusaiwXG0R8AtwZascUmdqyusjqQHY
         1BDp2Go2Bv9Eb8BfgFzRxsXrxTA1EM28wFIQ1Rw/GWHcp5QcqV9WsL9xU4XlSEp6kHJO
         7LT7LWEdBK9vRnlubaxdv7L++64CXeTLCEBmLQ2lBoRyE499w14GTaTGZ/gm24p/HOFd
         u161fd1hmoS8cM6wF0EOXtsOE1WNv/2d0BaHJuQ+FZy+vpiq7F3nxMLIWVAYUOX9Y6bT
         0jmA==
X-Forwarded-Encrypted: i=1; AJvYcCWZIgkW/TJKrA01cJnnW8rTfDHGRH8peJWWBah6wQcTWC4/9cd35yVwYKxNk/oNwyLvVgmeg4tdcQ02yAaCHD72q1ZZmWwy7TmQZIu/
X-Gm-Message-State: AOJu0YzEOYnaVlXYzM3zpdfUeG8BAUbfR5+ZruQoE98yEpc2BCitJmw8
	9nglfbqVL7x9c1xy6m4m3hHwSNqJJ9ax+m8Pz4CioZ8fdPGQCGqytmhymlD8j0kTjvo04jZJtyh
	m8cvm8V0Geh3Uk6RDy+0I+GyvKte7GWa6rjJ9+n0EcfQMYCJcpDXRbsIbsmy8NliRmMnh6v7N2u
	CGfXerUn0WJjdrPhduzwOWtcFnaXLBdREFFziX
X-Received: by 2002:a05:6214:4a90:b0:6b0:74c6:4942 with SMTP id 6a1803df08f44-6b074c64a41mr96929166d6.5.1718095151712;
        Tue, 11 Jun 2024 01:39:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsbPtghgmB/Z5OVFvAqyDqkPGY0wtDkE3BulnRMElw3Q+oIAt1XspeQjA6956x8mAEcnz4Ne7s1U69K0nxPWc=
X-Received: by 2002:a05:6214:4a90:b0:6b0:74c6:4942 with SMTP id
 6a1803df08f44-6b074c64a41mr96928846d6.5.1718095151015; Tue, 11 Jun 2024
 01:39:11 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 11 Jun 2024 08:39:10 +0000
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240603185647.2310748-1-amorenoz@redhat.com> <20240603185647.2310748-6-amorenoz@redhat.com>
 <f7ted94rebd.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f7ted94rebd.fsf@redhat.com>
Date: Tue, 11 Jun 2024 08:39:10 +0000
Message-ID: <CAG=2xmPqTLLWMq3GtG95Td=T6hjoV6TOcKdH6fyY0KGGAUMK9g@mail.gmail.com>
Subject: Re: [ovs-dev] [PATCH net-next v2 5/9] net: openvswitch: add
 emit_sample action
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, dev@openvswitch.org, 
	Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
	linux-kernel@vger.kernel.org, i.maximets@ovn.org, 
	Eric Dumazet <edumazet@google.com>, horms@kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"

On Mon, Jun 10, 2024 at 11:46:14AM GMT, Aaron Conole wrote:
> Adrian Moreno <amorenoz@redhat.com> writes:
>
> > Add support for a new action: emit_sample.
> >
> > This action accepts a u32 group id and a variable-length cookie and uses
> > the psample multicast group to make the packet available for
> > observability.
> >
> > The maximum length of the user-defined cookie is set to 16, same as
> > tc_cookie, to discourage using cookies that will not be offloadable.
> >
> > Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> > ---
>
> I saw some of the nits Simon raised - I'll add one more below.
>
> I haven't gone through the series thoroughly enough to make a detailed
> review.
>
> >  Documentation/netlink/specs/ovs_flow.yaml | 17 ++++++++
> >  include/uapi/linux/openvswitch.h          | 25 ++++++++++++
> >  net/openvswitch/actions.c                 | 50 +++++++++++++++++++++++
> >  net/openvswitch/flow_netlink.c            | 33 ++++++++++++++-
> >  4 files changed, 124 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/netlink/specs/ovs_flow.yaml b/Documentation/netlink/specs/ovs_flow.yaml
> > index 4fdfc6b5cae9..a7ab5593a24f 100644
> > --- a/Documentation/netlink/specs/ovs_flow.yaml
> > +++ b/Documentation/netlink/specs/ovs_flow.yaml
> > @@ -727,6 +727,12 @@ attribute-sets:
> >          name: dec-ttl
> >          type: nest
> >          nested-attributes: dec-ttl-attrs
> > +      -
> > +        name: emit-sample
> > +        type: nest
> > +        nested-attributes: emit-sample-attrs
> > +        doc: |
> > +          Sends a packet sample to psample for external observation.
> >    -
> >      name: tunnel-key-attrs
> >      enum-name: ovs-tunnel-key-attr
> > @@ -938,6 +944,17 @@ attribute-sets:
> >        -
> >          name: gbp
> >          type: u32
> > +  -
> > +    name: emit-sample-attrs
> > +    enum-name: ovs-emit-sample-attr
> > +    name-prefix: ovs-emit-sample-attr-
> > +    attributes:
> > +      -
> > +        name: group
> > +        type: u32
> > +      -
> > +        name: cookie
> > +        type: binary
> >
> >  operations:
> >    name-prefix: ovs-flow-cmd-
> > diff --git a/include/uapi/linux/openvswitch.h b/include/uapi/linux/openvswitch.h
> > index efc82c318fa2..a0e9dde0584a 100644
> > --- a/include/uapi/linux/openvswitch.h
> > +++ b/include/uapi/linux/openvswitch.h
> > @@ -914,6 +914,30 @@ struct check_pkt_len_arg {
> >  };
> >  #endif
> >
> > +#define OVS_EMIT_SAMPLE_COOKIE_MAX_SIZE 16
> > +/**
> > + * enum ovs_emit_sample_attr - Attributes for %OVS_ACTION_ATTR_EMIT_SAMPLE
> > + * action.
> > + *
> > + * @OVS_EMIT_SAMPLE_ATTR_GROUP: 32-bit number to identify the source of the
> > + * sample.
> > + * @OVS_EMIT_SAMPLE_ATTR_COOKIE: A variable-length binary cookie that contains
> > + * user-defined metadata. The maximum length is 16 bytes.
> > + *
> > + * Sends the packet to the psample multicast group with the specified group and
> > + * cookie. It is possible to combine this action with the
> > + * %OVS_ACTION_ATTR_TRUNC action to limit the size of the packet being emitted.
> > + */
> > +enum ovs_emit_sample_attr {
> > +	OVS_EMIT_SAMPLE_ATTR_UNPSEC,
> > +	OVS_EMIT_SAMPLE_ATTR_GROUP,	/* u32 number. */
> > +	OVS_EMIT_SAMPLE_ATTR_COOKIE,	/* Optional, user specified cookie. */
> > +	__OVS_EMIT_SAMPLE_ATTR_MAX
> > +};
> > +
> > +#define OVS_EMIT_SAMPLE_ATTR_MAX (__OVS_EMIT_SAMPLE_ATTR_MAX - 1)
> > +
> > +
> >  /**
> >   * enum ovs_action_attr - Action types.
> >   *
> > @@ -1004,6 +1028,7 @@ enum ovs_action_attr {
> >  	OVS_ACTION_ATTR_ADD_MPLS,     /* struct ovs_action_add_mpls. */
> >  	OVS_ACTION_ATTR_DEC_TTL,      /* Nested OVS_DEC_TTL_ATTR_*. */
> >  	OVS_ACTION_ATTR_DROP,         /* u32 error code. */
> > +	OVS_ACTION_ATTR_EMIT_SAMPLE,  /* Nested OVS_EMIT_SAMPLE_ATTR_*. */
> >
> >  	__OVS_ACTION_ATTR_MAX,	      /* Nothing past this will be accepted
> >  				       * from userspace. */
> > diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
> > index 964225580824..3b4dba0ded59 100644
> > --- a/net/openvswitch/actions.c
> > +++ b/net/openvswitch/actions.c
> > @@ -24,6 +24,11 @@
> >  #include <net/checksum.h>
> >  #include <net/dsfield.h>
> >  #include <net/mpls.h>
> > +
> > +#if IS_ENABLED(CONFIG_PSAMPLE)
> > +#include <net/psample.h>
> > +#endif
> > +
> >  #include <net/sctp/checksum.h>
> >
> >  #include "datapath.h"
> > @@ -1299,6 +1304,46 @@ static int execute_dec_ttl(struct sk_buff *skb, struct sw_flow_key *key)
> >  	return 0;
> >  }
> >
> > +static int execute_emit_sample(struct datapath *dp, struct sk_buff *skb,
> > +			       const struct sw_flow_key *key,
> > +			       const struct nlattr *attr)
> > +{
> > +#if IS_ENABLED(CONFIG_PSAMPLE)
> > +	struct psample_group psample_group = {};
> > +	struct psample_metadata md = {};
> > +	struct vport *input_vport;
> > +	const struct nlattr *a;
> > +	int rem;
> > +
> > +	for (a = nla_data(attr), rem = nla_len(attr); rem > 0;
> > +	     a = nla_next(a, &rem)) {
> > +		switch (nla_type(a)) {
> > +		case OVS_EMIT_SAMPLE_ATTR_GROUP:
> > +			psample_group.group_num = nla_get_u32(a);
> > +			break;
> > +
> > +		case OVS_EMIT_SAMPLE_ATTR_COOKIE:
> > +			md.user_cookie = nla_data(a);
> > +			md.user_cookie_len = nla_len(a);
> > +			break;
> > +		}
> > +	}
> > +
> > +	psample_group.net = ovs_dp_get_net(dp);
> > +
> > +	input_vport = ovs_vport_rcu(dp, key->phy.in_port);
> > +	if (!input_vport)
> > +		input_vport = ovs_vport_rcu(dp, OVSP_LOCAL);
> > +
> > +	md.in_ifindex = input_vport->dev->ifindex;
> > +	md.trunc_size = skb->len - OVS_CB(skb)->cutlen;
> > +
> > +	psample_sample_packet(&psample_group, skb, 0, &md);
> > +#endif
> > +
> > +	return 0;
>
> Why this return here?  Doesn't seem used anywhere else.
>

It is being used in "do_execute_actions", right?
All non-skb-consuming actions set the value of "err" and break from the
switch-case so that the the packet is dropped with OVS_DROP_ACTION_ERROR reason.

Am i missing something?

> > +}
> > +
> >  /* Execute a list of actions against 'skb'. */
> >  static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
> >  			      struct sw_flow_key *key,
> > @@ -1502,6 +1547,11 @@ static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
> >  			ovs_kfree_skb_reason(skb, reason);
> >  			return 0;
> >  		}
> > +
> > +		case OVS_ACTION_ATTR_EMIT_SAMPLE:
> > +			err = execute_emit_sample(dp, skb, key, a);
> > +			OVS_CB(skb)->cutlen = 0;
> > +			break;
> >  		}
> >
> >  		if (unlikely(err)) {
> > diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlink.c
> > index f224d9bcea5e..eb59ff9c8154 100644
> > --- a/net/openvswitch/flow_netlink.c
> > +++ b/net/openvswitch/flow_netlink.c
> > @@ -64,6 +64,7 @@ static bool actions_may_change_flow(const struct nlattr *actions)
> >  		case OVS_ACTION_ATTR_TRUNC:
> >  		case OVS_ACTION_ATTR_USERSPACE:
> >  		case OVS_ACTION_ATTR_DROP:
> > +		case OVS_ACTION_ATTR_EMIT_SAMPLE:
> >  			break;
> >
> >  		case OVS_ACTION_ATTR_CT:
> > @@ -2409,7 +2410,7 @@ static void ovs_nla_free_nested_actions(const struct nlattr *actions, int len)
> >  	/* Whenever new actions are added, the need to update this
> >  	 * function should be considered.
> >  	 */
> > -	BUILD_BUG_ON(OVS_ACTION_ATTR_MAX != 24);
> > +	BUILD_BUG_ON(OVS_ACTION_ATTR_MAX != 25);
> >
> >  	if (!actions)
> >  		return;
> > @@ -3157,6 +3158,29 @@ static int validate_and_copy_check_pkt_len(struct net *net,
> >  	return 0;
> >  }
> >
> > +static int validate_emit_sample(const struct nlattr *attr)
> > +{
> > +	static const struct nla_policy policy[OVS_EMIT_SAMPLE_ATTR_MAX + 1] = {
> > +		[OVS_EMIT_SAMPLE_ATTR_GROUP] = { .type = NLA_U32 },
> > +		[OVS_EMIT_SAMPLE_ATTR_COOKIE] = {
> > +			.type = NLA_BINARY,
> > +			.len = OVS_EMIT_SAMPLE_COOKIE_MAX_SIZE
> > +		},
> > +	};
> > +	struct nlattr *a[OVS_EMIT_SAMPLE_ATTR_MAX  + 1];
> > +	int err;
> > +
> > +	if (!IS_ENABLED(CONFIG_PSAMPLE))
> > +		return -EOPNOTSUPP;
> > +
> > +	err = nla_parse_nested(a, OVS_EMIT_SAMPLE_ATTR_MAX, attr, policy,
> > +			       NULL);
> > +	if (err)
> > +		return err;
> > +
> > +	return a[OVS_EMIT_SAMPLE_ATTR_GROUP] ? 0 : -EINVAL;
> > +}
> > +
> >  static int copy_action(const struct nlattr *from,
> >  		       struct sw_flow_actions **sfa, bool log)
> >  {
> > @@ -3212,6 +3236,7 @@ static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
> >  			[OVS_ACTION_ATTR_ADD_MPLS] = sizeof(struct ovs_action_add_mpls),
> >  			[OVS_ACTION_ATTR_DEC_TTL] = (u32)-1,
> >  			[OVS_ACTION_ATTR_DROP] = sizeof(u32),
> > +			[OVS_ACTION_ATTR_EMIT_SAMPLE] = (u32)-1,
> >  		};
> >  		const struct ovs_action_push_vlan *vlan;
> >  		int type = nla_type(a);
> > @@ -3490,6 +3515,12 @@ static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
> >  				return -EINVAL;
> >  			break;
> >
> > +		case OVS_ACTION_ATTR_EMIT_SAMPLE:
> > +			err = validate_emit_sample(a);
> > +			if (err)
> > +				return err;
> > +			break;
> > +
> >  		default:
> >  			OVS_NLERR(log, "Unknown Action type %d", type);
> >  			return -EINVAL;
>


