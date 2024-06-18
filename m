Return-Path: <linux-kernel+bounces-218782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA5890C5FE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0780283813
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 10:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DBB129E9C;
	Tue, 18 Jun 2024 07:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X7IwqNdc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F733D3BD
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 07:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718696184; cv=none; b=ez4Drf2YOvn/QwyJljpMY0FOy+0XxjnXZTeKIosrT1zrUEZkwjtZtrxZLytiDuQzEejqkIRanu0VYt31uBVDmHXk+1+Vag3CXRbp6qPt4QIzdsI+pmGbKqbqb+vt7luYKXCvdnKZsuAwb5QCslDyBe/EU5lzBGZ4BIqie+lr94U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718696184; c=relaxed/simple;
	bh=AZuPulsbGYz1lhg39+puBp/0aGMlNvSpnDXzftmuwa4=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rccJcgnsT1TKXyvWNIEnnpsBxFL0i3/RlgrWzlMSHvg/pwt3Z4jL8mc4+dwb2qruBolcf6cjubh52wDtYbtT+lsSUBCCFngXhDpYoGaCi6/Uf6bfKNyJQveJt02NfGEeULQtuQ093utl887sRuT6QYKdoaC/BolmVkK3mVGfvp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X7IwqNdc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718696181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lWRCz/BFzWuY+lFeGSDLK1KajI75M9HEaTEmdTPms7c=;
	b=X7IwqNdcSOaeZNNEkhPViXSdFGpKQSZbxWozGM7GgRtcDfsA+TNxeMBbDG3iDmfwIJnwgf
	ZC8GuaFwM4etiA07fjM3OakGJU9hSdxH/bgCuRTCRhNGKlo5FxO6Y+hLO+LyA0EAsDDmfy
	hb+lMlBKEbxeY5u/bigTncWOFzrkd3A=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-qFRYvY69Mj-0_2jKFlA3vg-1; Tue, 18 Jun 2024 03:36:20 -0400
X-MC-Unique: qFRYvY69Mj-0_2jKFlA3vg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6b07983a8adso120991606d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 00:36:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718696179; x=1719300979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lWRCz/BFzWuY+lFeGSDLK1KajI75M9HEaTEmdTPms7c=;
        b=CaAV0GHJiwMxpPzKvSxEIFPGGcXfmbkHMpzI6L7ONPGG4UvbfH0MndETIhW3H+KHEl
         i1JY43DKIMMHROLUS2X3fIgHQ/rKb8G5x7blbgUmGWbKN3n+QptkihORWNc126gVn77I
         89ZFSVWTs8ACJlDG5emP2rfNeyXiGA8JVrOpgQ/Y8Nr85nM4MdnpqsFyQAzn2fQ/GfzY
         WBtcnlyHFskeZjQ26KTwUaBJu7yq44SKyzxvMRDonHOH8kXrDjk4+Lb4/PFzXO4Sqs4e
         dAOMVeIkAMdumhBuwdgVIXF6Y90vxvZZnuCsBjW9I1GwvwgA1pFQFCvDTicBjq/K6bnN
         dtvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlGubagngNd0tD847wthUCfBOC2ykhmPAkPInPoMVtEoZJdBcC4Lz7RbFozONqzyGQgesiqIGj420GQrm6pLyvOgUexakLEP1xWtyL
X-Gm-Message-State: AOJu0YxsE7E+SHHyxNELuMVIq+7530Z+7e0fG3VtRR8K/jg8sJBUvOqL
	EKm2sVq+Txvt6rTn2ir3LlF6yg9rp6NJa81gQ+XvxIwLzQ5C+42FrDtIJM2crBvngnlIx+Ib42V
	BTN7lLEmD8y9VYr33Gkltgd8IpngxPNJfOVz5Eh2+qjVNzXzdH7jLGnz4yiQG0uQS8ev6x39ex3
	1qxBVJbFQYQPQZqo85h6N8qBqfrJGUeM1AnyvvtCyrcGp5wjw=
X-Received: by 2002:a0c:ec05:0:b0:6b4:fbb0:af1d with SMTP id 6a1803df08f44-6b4fbb0b13bmr6728376d6.0.1718696178995;
        Tue, 18 Jun 2024 00:36:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5iKPxyz7rcOrrMg3JtwcPR6v0i2bfn2vbdgDyIckT5e873df9PCzUk/3jf5gNLyOX0V9tzqBOg1LDRjMd0d0=
X-Received: by 2002:a0c:ec05:0:b0:6b4:fbb0:af1d with SMTP id
 6a1803df08f44-6b4fbb0b13bmr6728246d6.0.1718696178618; Tue, 18 Jun 2024
 00:36:18 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 18 Jun 2024 07:36:18 +0000
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240603185647.2310748-1-amorenoz@redhat.com> <20240603185647.2310748-7-amorenoz@redhat.com>
 <f7t4j9vo44g.fsf@redhat.com> <CAG=2xmPW=1HzojWhHaE3z_x5u_Dv1zPVmMn4cSmV6DF4fzq5KA@mail.gmail.com>
 <c96f6b5e-f72d-4aa2-af67-41a5026e7053@ovn.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <c96f6b5e-f72d-4aa2-af67-41a5026e7053@ovn.org>
Date: Tue, 18 Jun 2024 07:36:17 +0000
Message-ID: <CAG=2xmMrkNfADw=mwrmj_5yMBFKY3DTeCj12V0g7YybkOFMoEw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 6/9] net: openvswitch: store sampling
 probability in cb.
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Aaron Conole <aconole@redhat.com>, netdev@vger.kernel.org, echaudro@redhat.com, 
	horms@kernel.org, dev@openvswitch.org, Pravin B Shelar <pshelar@ovn.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 01:26:39PM GMT, Ilya Maximets wrote:
> On 6/17/24 09:08, Adri=C3=A1n Moreno wrote:
> > On Fri, Jun 14, 2024 at 12:55:59PM GMT, Aaron Conole wrote:
> >> Adrian Moreno <amorenoz@redhat.com> writes:
> >>
> >>> The behavior of actions might not be the exact same if they are being
> >>> executed inside a nested sample action. Store the probability of the
> >>> parent sample action in the skb's cb area.
> >>
> >> What does that mean?
> >>
> >
> > Emit action, for instance, needs the probability so that psample
> > consumers know what was the sampling rate applied. Also, the way we
> > should inform about packet drops (via kfree_skb_reason) changes (see
> > patch 7/9).
> >
> >>> Use the probability in emit_sample to pass it down to psample.
> >>>
> >>> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> >>> ---
> >>>  include/uapi/linux/openvswitch.h |  3 ++-
> >>>  net/openvswitch/actions.c        | 25 ++++++++++++++++++++++---
> >>>  net/openvswitch/datapath.h       |  3 +++
> >>>  net/openvswitch/vport.c          |  1 +
> >>>  4 files changed, 28 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/include/uapi/linux/openvswitch.h b/include/uapi/linux/op=
envswitch.h
> >>> index a0e9dde0584a..9d675725fa2b 100644
> >>> --- a/include/uapi/linux/openvswitch.h
> >>> +++ b/include/uapi/linux/openvswitch.h
> >>> @@ -649,7 +649,8 @@ enum ovs_flow_attr {
> >>>   * Actions are passed as nested attributes.
> >>>   *
> >>>   * Executes the specified actions with the given probability on a pe=
r-packet
> >>> - * basis.
> >>> + * basis. Nested actions will be able to access the probability valu=
e of the
> >>> + * parent @OVS_ACTION_ATTR_SAMPLE.
> >>>   */
> >>>  enum ovs_sample_attr {
> >>>  	OVS_SAMPLE_ATTR_UNSPEC,
> >>> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
> >>> index 3b4dba0ded59..33f6d93ba5e4 100644
> >>> --- a/net/openvswitch/actions.c
> >>> +++ b/net/openvswitch/actions.c
> >>> @@ -1048,12 +1048,15 @@ static int sample(struct datapath *dp, struct=
 sk_buff *skb,
> >>>  	struct nlattr *sample_arg;
> >>>  	int rem =3D nla_len(attr);
> >>>  	const struct sample_arg *arg;
> >>> +	u32 init_probability;
> >>>  	bool clone_flow_key;
> >>> +	int err;
> >>>
> >>>  	/* The first action is always 'OVS_SAMPLE_ATTR_ARG'. */
> >>>  	sample_arg =3D nla_data(attr);
> >>>  	arg =3D nla_data(sample_arg);
> >>>  	actions =3D nla_next(sample_arg, &rem);
> >>> +	init_probability =3D OVS_CB(skb)->probability;
> >>>
> >>>  	if ((arg->probability !=3D U32_MAX) &&
> >>>  	    (!arg->probability || get_random_u32() > arg->probability)) {
> >>> @@ -1062,9 +1065,21 @@ static int sample(struct datapath *dp, struct =
sk_buff *skb,
> >>>  		return 0;
> >>>  	}
> >>>
> >>> +	if (init_probability) {
> >>> +		OVS_CB(skb)->probability =3D ((u64)OVS_CB(skb)->probability *
> >>> +					    arg->probability / U32_MAX);
> >>> +	} else {
> >>> +		OVS_CB(skb)->probability =3D arg->probability;
> >>> +	}
> >>> +
> >>
> >> I'm confused by this.  Eventually, integer arithmetic will practically
> >> guarantee that nested sample() calls will go to 0.  So eventually, the
> >> test above will be impossible to meet mathematically.
> >>
> >> OTOH, you could argue that a 1% of 50% is low anyway, but it still wou=
ld
> >> have a positive probability count, and still be possible for
> >> get_random_u32() call to match.
> >>
> >
> > Using OVS's probability semantics, we can express probabilities as low
> > as (100/U32_MAX)% which is pretty low indeed. However, just because the
> > probability of executing the action is low I don't think we should not
> > report it.
> >
> > Rethinking the integer arithmetics, it's true that we should avoid
> > hitting zero on the division, eg: nesting 6x 1% sampling rates will mak=
e
> > the result be zero which will make probability restoration fail on the
> > way back. Threrefore, the new probability should be at least 1.
> >
> >
> >> I'm not sure about this particular change.  Why do we need it?
> >>
> >
> > Why do we need to propagate the probability down to nested "sample"
> > actions? or why do we need to store the probability in the cb area in
> > the first place?
> >
> > The former: Just for correctness as only storing the last one would be
> > incorrect. Although I don't know of any use for nested "sample" actions=
.
>
> I think, we can drop this for now.  All the user interfaces specify
> the probability per action.  So, it should be fine to report the
> probability of the action that emitted the sample without taking into
> account the whole timeline of that packet.  Besides, packet can leave
> OVS and go back loosing the metadata, so it will not actually be a
> full solution anyway.  Single-action metadata is easier to define.
>

Sure, I guess we can drop it, I don't think there is a use case for nested
samples anyway.

> > The latter: To pass it down to psample so that sample receivers know ho=
w
> > the sampling rate applied (and, e.g: do throughput estimations like OVS
> > does with IPFIX).
> >
> >
> >>>  	clone_flow_key =3D !arg->exec;
> >>> -	return clone_execute(dp, skb, key, 0, actions, rem, last,
> >>> -			     clone_flow_key);
> >>> +	err =3D clone_execute(dp, skb, key, 0, actions, rem, last,
> >>> +			    clone_flow_key);
> >>> +
> >>> +	if (!last)
> >>
> >> Is this right?  Don't we only want to set the probability on the last
> >> action?  Should the test be 'if (last)'?
> >>
> >
> > This is restoring the parent's probability after the actions in the
> > current sample action have been executed.
> >
> > If it was the last action there is no need to restore the probability
> > back to the parent's (or zero if it's there's only one level) since no
> > further action will require it. And more importantly, if it's the last
> > action, the packet gets free'ed inside that "branch" so we must not
> > access its memory.
> >
> >
> >>> +		OVS_CB(skb)->probability =3D init_probability;
> >>> +
> >>> +	return err;
> >>>  }
> >>>
> >>>  /* When 'last' is true, clone() should always consume the 'skb'.
> >>> @@ -1313,6 +1328,7 @@ static int execute_emit_sample(struct datapath =
*dp, struct sk_buff *skb,
> >>>  	struct psample_metadata md =3D {};
> >>>  	struct vport *input_vport;
> >>>  	const struct nlattr *a;
> >>> +	u32 rate;
> >>>  	int rem;
> >>>
> >>>  	for (a =3D nla_data(attr), rem =3D nla_len(attr); rem > 0;
> >>> @@ -1337,8 +1353,11 @@ static int execute_emit_sample(struct datapath=
 *dp, struct sk_buff *skb,
> >>>
> >>>  	md.in_ifindex =3D input_vport->dev->ifindex;
> >>>  	md.trunc_size =3D skb->len - OVS_CB(skb)->cutlen;
> >>> +	md.rate_as_probability =3D 1;
> >>> +
> >>> +	rate =3D OVS_CB(skb)->probability ? OVS_CB(skb)->probability : U32_=
MAX;
> >>>
> >>> -	psample_sample_packet(&psample_group, skb, 0, &md);
> >>> +	psample_sample_packet(&psample_group, skb, rate, &md);
> >>>  #endif
> >>>
> >>>  	return 0;
> >>> diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath.h
> >>> index 0cd29971a907..9ca6231ea647 100644
> >>> --- a/net/openvswitch/datapath.h
> >>> +++ b/net/openvswitch/datapath.h
> >>> @@ -115,12 +115,15 @@ struct datapath {
> >>>   * fragmented.
> >>>   * @acts_origlen: The netlink size of the flow actions applied to th=
is skb.
> >>>   * @cutlen: The number of bytes from the packet end to be removed.
> >>> + * @probability: The sampling probability that was applied to this s=
kb; 0 means
> >>> + * no sampling has occurred; U32_MAX means 100% probability.
> >>>   */
> >>>  struct ovs_skb_cb {
> >>>  	struct vport		*input_vport;
> >>>  	u16			mru;
> >>>  	u16			acts_origlen;
> >>>  	u32			cutlen;
> >>> +	u32			probability;
> >>>  };
> >>>  #define OVS_CB(skb) ((struct ovs_skb_cb *)(skb)->cb)
> >>>
> >>> diff --git a/net/openvswitch/vport.c b/net/openvswitch/vport.c
> >>> index 972ae01a70f7..8732f6e51ae5 100644
> >>> --- a/net/openvswitch/vport.c
> >>> +++ b/net/openvswitch/vport.c
> >>> @@ -500,6 +500,7 @@ int ovs_vport_receive(struct vport *vport, struct=
 sk_buff *skb,
> >>>  	OVS_CB(skb)->input_vport =3D vport;
> >>>  	OVS_CB(skb)->mru =3D 0;
> >>>  	OVS_CB(skb)->cutlen =3D 0;
> >>> +	OVS_CB(skb)->probability =3D 0;
> >>>  	if (unlikely(dev_net(skb->dev) !=3D ovs_dp_get_net(vport->dp))) {
> >>>  		u32 mark;
> >>
> >
>


