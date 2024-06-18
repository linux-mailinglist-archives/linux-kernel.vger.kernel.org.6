Return-Path: <linux-kernel+bounces-218779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 657AB90C5F6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E70071F22772
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 10:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D939113B2B3;
	Tue, 18 Jun 2024 07:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L4TbWmpW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D78C15ECF6
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 07:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718696007; cv=none; b=rDwbBQX/dew4f/zXHfcxN+pFOV1uUvxryFdAgDqenHPOzcR1mLbenHrCTO3Ag4yg6/aC9A1NPt5inJhG5iGLFrwIH8R9Eoiup8B1BUT397dgv0DkDNBWCjxfqxiCMVp104Oefe1VwK/HxaUmQYCj20y1daqh4sF/K9liaWnEn+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718696007; c=relaxed/simple;
	bh=H//8BSv4ggrLxowhkNrbObSOlWxgFWRkdd0cHb8UjRI=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pnQaTkgiQZaE75fk0GcfX7PvRS/M8+Zbm12caGFXoH+6pcHwSyjTBN2AorE8yPI3L7LkMYtiBHSaEviKFQZ1eTw2AC+0B3z8j7/eFtVzAXgwwgKhM804YkroEFg2SaB637+8RAZrgJ64Oo845Efsuy75kFWVl7Kj8J6ojrdv+Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L4TbWmpW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718696004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u+gJX5mOOklJgcIWDcgc8reyiNZqlCJU5tp8bTTf1IU=;
	b=L4TbWmpW5dcQKJRVupMpqf65LK+rqyZ9QxqCkLYXaFR266Qx3WnRwyqnB1AKUZCZqzBvGO
	kMBHPumpGcCgXfXlJ8KJ7LnrYEvXF1Z3kjT82pCpVHyniQYyGsw4jv/SBC0JjOZxNhqU2/
	5v3cpVEbqYDervvmIl1ElUAkBWaYxY0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-uF7tv_jNPI6glfMtsLyaKQ-1; Tue, 18 Jun 2024 03:33:20 -0400
X-MC-Unique: uF7tv_jNPI6glfMtsLyaKQ-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6b061e82960so68390486d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 00:33:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718696000; x=1719300800;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u+gJX5mOOklJgcIWDcgc8reyiNZqlCJU5tp8bTTf1IU=;
        b=pOP66OokeXW5OpndLTpHLDtI1aT0Xshl/My7ynSDFkIlJ5qd/A2pFpbIexkSZocrr0
         0NXU5bX1+cUTRl2vBuYkjIdPIC+HVU13xiHhFsMOdoFvfAxyWq336P7CJp2poAppDEi3
         rcG5F88hux96Jb7r/JS7UgXvtH75x9HOl582aDQ08nCCuYVnKUJyIQ/+AFFZW9LI4sKl
         GV7mfQrOWQBxkM0daKAOLIeHGc43dL7IXSS5609e3rwcGX2HjeTwhlNT+JJUqARuCDMt
         eq7jTsBW02jtgPAyQDk6IxvqK8S6TMN/Vd4tDQ5GdWqubjbjqOVYPxC5rL4Wl5XP+Wq9
         k2FQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxkTmIoxP8dDk7yi2iOXj35IGIY5pmth43VZCgN/N2r4rO2YPrxuCbKlyT/xzxpXIpfYOKnyrA8bdcd90wysrxOJi6/EFjEYc1uzp8
X-Gm-Message-State: AOJu0Yy6ntPWATwSmwu+vY4UJeJc++ReA5GlxU38MY+wpN7ShkPCfomz
	LTauPday0O2+bnGU2eXCgxBR1qKA+Aauh2ZeEaHT3aZxxmdgbfP0KYorfK5K4qVuGk455PmfsHF
	sw0aNo/88Culoa71bx79J3JfTanEInjGgFPszGAOniHt1AJ+CnmKzyOZ/rjTDeykNqJzlGC049/
	IPt+Xtfw4fXqEohIV03+CmTuUAt8cncL8wuD60
X-Received: by 2002:a05:6214:883:b0:6b0:792b:5997 with SMTP id 6a1803df08f44-6b2afd5c564mr128586656d6.46.1718695999693;
        Tue, 18 Jun 2024 00:33:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhtkzgllN3nCGGFNDyNoeim9DaJnmDiJYMCNKEvV9xtmuJmUsUaB8suc0/XQUadK6Lfelu/Z0r9f6z8XQfblg=
X-Received: by 2002:a05:6214:883:b0:6b0:792b:5997 with SMTP id
 6a1803df08f44-6b2afd5c564mr128586576d6.46.1718695999334; Tue, 18 Jun 2024
 00:33:19 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 18 Jun 2024 07:33:18 +0000
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240603185647.2310748-1-amorenoz@redhat.com> <20240603185647.2310748-6-amorenoz@redhat.com>
 <4f89a9b9-999c-4d1f-8831-48045e6a74f6@ovn.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4f89a9b9-999c-4d1f-8831-48045e6a74f6@ovn.org>
Date: Tue, 18 Jun 2024 07:33:16 +0000
Message-ID: <CAG=2xmPHcyLbuMCVR6ysKigboWg1E_xCHFMxEKUceerioO-OFg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 5/9] net: openvswitch: add emit_sample action
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com, 
	horms@kernel.org, dev@openvswitch.org, 
	Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Pravin B Shelar <pshelar@ovn.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Jun 17, 2024 at 12:44:45PM GMT, Ilya Maximets wrote:
> On 6/3/24 20:56, Adrian Moreno wrote:
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
> >  Documentation/netlink/specs/ovs_flow.yaml | 17 ++++++++
> >  include/uapi/linux/openvswitch.h          | 25 ++++++++++++
> >  net/openvswitch/actions.c                 | 50 +++++++++++++++++++++++
> >  net/openvswitch/flow_netlink.c            | 33 ++++++++++++++-
> >  4 files changed, 124 insertions(+), 1 deletion(-)
>
> Some nits below, beside ones already mentioned.
>

Thanks, Ilya.

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
>
> s/16/OVS_EMIT_SAMPLE_COOKIE_MAX_SIZE/
>
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
>
> Since the action is strictly validated, can use use nla_for_each_attr()
> or nla_for_each_nested() ?
>

Probably, yes.

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
>
> We may need to check that we actually found the local port.
>

Sure. What can cause the local port not to exist?

> > +
> > +	md.in_ifindex = input_vport->dev->ifindex;
> > +	md.trunc_size = skb->len - OVS_CB(skb)->cutlen;
> > +
> > +	psample_sample_packet(&psample_group, skb, 0, &md);
> > +#endif
> > +
> > +	return 0;
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
>
> Maybe add a trailing comma here as well, since it's not a one-line definition.
> Just in case.
>

Sure.

> > +		},
> > +	};
> > +	struct nlattr *a[OVS_EMIT_SAMPLE_ATTR_MAX  + 1];
>
> One too many spaces                              ^^
>

Thanks.

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


