Return-Path: <linux-kernel+bounces-219089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F27390C9C9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 359AC1C23451
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087D015573F;
	Tue, 18 Jun 2024 10:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FInN7Rae"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4015815532F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 10:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718707812; cv=none; b=s8AY2+vKs79sE9SSK5eJ+HP2makSJf/RFMlFCc/A8hGGjeM58HkW4Jwqlq50ZKp1qLs6/vh6XtlqjYCu93kQWAMjiK4jKYek15gmCWo5u2NG7VZ0focn+V8hKtPtd6/vyDA/VC337D0sU4F2+Pz5vX8QIvU8zDCWS1eoMxjYWl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718707812; c=relaxed/simple;
	bh=zuIaHaRc2wHSelfPBTrftpxGVNzZzHi84yYkdxXtb/w=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D4QUiF6iLAu/MeN2B2gWY8H2v1EMWhAzxuokPQyf5803PBpd3brEEdzVb8oOS3GaZyleWswwvdto9VRf48Pv6SQmeA9fEftgZ04aPKjcDDE/hJpdKDBPbDnyy3E9HFzmtNXHJpJ7ZSuHthGAvIa7/693odEp4yVoy06/IfAHbX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FInN7Rae; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718707809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l/ChfiVgZBMW+Q5CvBZD4jxxA/Fmx+01TB6ag5A/b44=;
	b=FInN7RaeP35/Mn1vLllt+UF6g5vrgdgJKYIo6W1NfLZpYevCZDtPQ6OrjUExgQBzks71lA
	AdBr5A5QS2M54ZVT7qTEMtNGQyT/qppj7MaMUCrd1CKXM4Pe86MD3cF6nm8J29PrZe1qzM
	CfRJl997ZoofSwcT1bs/MtJEmaCHJrk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-BEjOfVXDNKauTWZf91gqQw-1; Tue, 18 Jun 2024 06:50:07 -0400
X-MC-Unique: BEjOfVXDNKauTWZf91gqQw-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6b062c433cfso61109566d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 03:50:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718707807; x=1719312607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l/ChfiVgZBMW+Q5CvBZD4jxxA/Fmx+01TB6ag5A/b44=;
        b=MGfNIpbYCfjIdPfR1YUukh00A8ys1TJm6STjdZjipd5PVL5wJkKt/LybVMVPomZJxh
         /hB3QoEjvfsnu5JkNtZTrAi9ud65h0hjAMXXWBGfK9Se35xxFwgvrW/wiavfHSxhpsVJ
         zvz6IBMlbNvaRLGgps/utf2ofk5jUkGYUQgYkcskY72E6AMODe8FQf+4nuka7HMYerbD
         28DJFcPJR/JAHGKXn71jPcmZgJsefWV7UqQdVE1UKx7qFLd2b9B4ImlqV0BSjCeNid47
         JLOUKeSBXT86jnOqjhjILZaS8fYZsJAOGA2k2YXcjmROgjTfdgtZ+5RSOuyUceu+fA68
         Krrg==
X-Forwarded-Encrypted: i=1; AJvYcCXGhMGTEEqOlTeHWq/NRyugvWnQzlIZOLa9rNzMXlv6q4svHUHq5q/vmuDvu433bdsgRwla+R1OXt0sz/FGjXvrOAXDLRmXr70JeMVk
X-Gm-Message-State: AOJu0YxeT7U98FRul8Klq6SCkkB0ihSYUtnwiRPPJaXjNwoSdzAMNKm9
	GtVHnJODxo1vScDfxKQ0OWLMflpLsC/BeAsgAYzjFK6501Vulqc+VptMw5SMRtFYDnpO851Vr6Q
	q9NSDx0rpmAUcP20Jo4GvPnchnLMS6Q5459MqKInrHaJM0g6U82TPD1PrASo6gBzidwW2e3+BjX
	nzaSjhXw+her5zci8pBM0MOMkyPk/zPAbnOLBq
X-Received: by 2002:ad4:5150:0:b0:6b0:77a8:f416 with SMTP id 6a1803df08f44-6b2b00bfea5mr127020746d6.47.1718707807307;
        Tue, 18 Jun 2024 03:50:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZcXk+B1DGjBzWsshT0SLNobf3SFzVN5baTdv30Ptg1ZIe+fv5v4OlrJ687YcCxXqWrUXq11SvL/itCPlicUg=
X-Received: by 2002:ad4:5150:0:b0:6b0:77a8:f416 with SMTP id
 6a1803df08f44-6b2b00bfea5mr127020526d6.47.1718707806942; Tue, 18 Jun 2024
 03:50:06 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 18 Jun 2024 10:50:05 +0000
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240603185647.2310748-1-amorenoz@redhat.com> <20240603185647.2310748-8-amorenoz@redhat.com>
 <8624ccf8-e9e2-4a95-a25c-7d3166bb3256@ovn.org> <f8050877-1728-4723-acb8-8a8ab7674470@ovn.org>
 <CAG=2xmPAwvCR4ky0cu7Yai29v3H592-ATXtNkhsNJ-vTwR4BVw@mail.gmail.com> <5f293bac-4117-4f93-8d3f-636d6ce236a4@ovn.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5f293bac-4117-4f93-8d3f-636d6ce236a4@ovn.org>
Date: Tue, 18 Jun 2024 10:50:05 +0000
Message-ID: <CAG=2xmPbpvYGy1rAkcLsK6PFxCx3bmZyXKX5RTag8XZBTxMZdg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 7/9] net: openvswitch: do not notify drops
 inside sample
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com, 
	horms@kernel.org, dev@openvswitch.org, Pravin B Shelar <pshelar@ovn.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 12:22:23PM GMT, Ilya Maximets wrote:
> On 6/18/24 09:00, Adri=C3=A1n Moreno wrote:
> > On Mon, Jun 17, 2024 at 02:10:37PM GMT, Ilya Maximets wrote:
> >> On 6/17/24 13:55, Ilya Maximets wrote:
> >>> On 6/3/24 20:56, Adrian Moreno wrote:
> >>>> The OVS_ACTION_ATTR_SAMPLE action is, in essence,
> >>>> observability-oriented.
> >>>>
> >>>> Apart from some corner case in which it's used a replacement of clon=
e()
> >>>> for old kernels, it's really only used for sFlow, IPFIX and now,
> >>>> local emit_sample.
> >>>>
> >>>> With this in mind, it doesn't make much sense to report
> >>>> OVS_DROP_LAST_ACTION inside sample actions.
> >>>>
> >>>> For instance, if the flow:
> >>>>
> >>>>   actions:sample(..,emit_sample(..)),2
> >>>>
> >>>> triggers a OVS_DROP_LAST_ACTION skb drop event, it would be extremel=
y
> >>>> confusing for users since the packet did reach its destination.
> >>>>
> >>>> This patch makes internal action execution silently consume the skb
> >>>> instead of notifying a drop for this case.
> >>>>
> >>>> Unfortunately, this patch does not remove all potential sources of
> >>>> confusion since, if the sample action itself is the last action, e.g=
:
> >>>>
> >>>>     actions:sample(..,emit_sample(..))
> >>>>
> >>>> we actually _should_ generate a OVS_DROP_LAST_ACTION event, but we a=
ren't.
> >>>>
> >>>> Sadly, this case is difficult to solve without breaking the
> >>>> optimization by which the skb is not cloned on last sample actions.
> >>>> But, given explicit drop actions are now supported, OVS can just add=
 one
> >>>> after the last sample() and rewrite the flow as:
> >>>>
> >>>>     actions:sample(..,emit_sample(..)),drop
> >>>>
> >>>> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> >>>> ---
> >>>>  net/openvswitch/actions.c | 13 +++++++++++--
> >>>>  1 file changed, 11 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
> >>>> index 33f6d93ba5e4..54fc1abcff95 100644
> >>>> --- a/net/openvswitch/actions.c
> >>>> +++ b/net/openvswitch/actions.c
> >>>> @@ -82,6 +82,15 @@ static struct action_fifo __percpu *action_fifos;
> >>>>  static struct action_flow_keys __percpu *flow_keys;
> >>>>  static DEFINE_PER_CPU(int, exec_actions_level);
> >>>>
> >>>> +static inline void ovs_drop_skb_last_action(struct sk_buff *skb)
> >>>> +{
> >>>> +	/* Do not emit packet drops inside sample(). */
> >>>> +	if (OVS_CB(skb)->probability)
> >>>> +		consume_skb(skb);
> >>>> +	else
> >>>> +		ovs_kfree_skb_reason(skb, OVS_DROP_LAST_ACTION);
> >>>> +}
> >>>> +
> >>>>  /* Make a clone of the 'key', using the pre-allocated percpu 'flow_=
keys'
> >>>>   * space. Return NULL if out of key spaces.
> >>>>   */
> >>>> @@ -1061,7 +1070,7 @@ static int sample(struct datapath *dp, struct =
sk_buff *skb,
> >>>>  	if ((arg->probability !=3D U32_MAX) &&
> >>>>  	    (!arg->probability || get_random_u32() > arg->probability)) {
> >>>>  		if (last)
> >>>> -			ovs_kfree_skb_reason(skb, OVS_DROP_LAST_ACTION);
> >>>> +			ovs_drop_skb_last_action(skb);
> >>
> >> Always consuming the skb at this point makes sense, since having smapl=
e()
> >> as a last action is a reasonable thing to have.  But this looks more l=
ike
> >> a fix for the original drop reason patch set.
> >>
> >
> > I don't think consuming the skb at this point makes sense. It was very
> > intentionally changed to a drop since a very common use-case for
> > sampling is drop-sampling, i.e: replacing an empty action list (that
> > triggers OVS_DROP_LAST_ACTION) with a sample(emit_sample()). Ideally,
> > that replacement should not have any effect on the number of
> > OVS_DROP_LAST_ACTION being reported as the packets are being treated in
> > the same way (only observed in one case).
> >
> >
> >>>>  		return 0;
> >>>>  	}
> >>>>
> >>>> @@ -1579,7 +1588,7 @@ static int do_execute_actions(struct datapath =
*dp, struct sk_buff *skb,
> >>>>  		}
> >>>>  	}
> >>>>
> >>>> -	ovs_kfree_skb_reason(skb, OVS_DROP_LAST_ACTION);
> >>>> +	ovs_drop_skb_last_action(skb);
> >>>
> >>> I don't think I agree with this one.  If we have a sample() action wi=
th
> >>> a lot of different actions inside and we reached the end while the la=
st
> >>> action didn't consume the skb, then we should report that.  E.g.
> >>> "sample(emit_sample(),push_vlan(),set(eth())),2"  should report that =
the
> >>> cloned skb was dropped.  "sample(push_vlan(),emit_sample())" should n=
ot.
> >>>
> >
> > What is the use case for such action list? Having an action branch
> > executed randomly doesn't make sense to me if it's not some
> > observability thing (which IMHO should not trigger drops).
>
> It is exactly my point.  A list of actions that doesn't end is some sort
> of a terminal action (output, drop, etc) does not make a lot of sense and
> hence should be signaled as an unexpected drop, so users can re-check the
> pipeline in case they missed the terminal action somehow.
>
> >
> >>> The only actions that are actually consuming the skb are "output",
> >>> "userspace", "recirc" and now "emit_sample".  "output" and "recirc" a=
re
> >>> consuming the skb "naturally" by stealing it when it is the last acti=
on.
> >>> "userspace" has an explicit check to consume the skb if it is the las=
t
> >>> action.  "emit_sample" should have the similar check.  It should like=
ly
> >>> be added at the point of action introduction instead of having a sepa=
rate
> >>> patch.
> >>>
> >
> > Unlinke "output", "recirc", "userspace", etc. with emit_sample the
> > packet does not continue it's way through the datapath.
>
> After "output" the packet leaves the datapath too, i.e. does not continue
> it's way through OVS datapath.
>

I meant a broader concept of "datapath". The packet continues. For the
userspace action this is true only for the CONTROLLER ofp action but
since the datapath does not know which action it's implementing, we
cannot do better.

> >
> > It would be very confusing if OVS starts monitoring drops and adds a bu=
nch
> > of flows such as "actions:emit_sample()" and suddently it stops reporti=
ng such
> > drops via standard kfree_skb_reason. Packets _are_ being dropped here,
> > we are just observing them.
>
> This might make sense from the higher logic in user space application, bu=
t
> it doesn't from the datapath perspective.  And also, if the user adds the
> 'emit_sample' action for drop monitring, they already know where to find
> packet samples, they don't need to use tools like dropwatch anymore.
> This packet is not dropped from the datapath perspective, it is sampled.
>
> >
> > And if we change emit_sample to trigger a drop if it's the last action,
> > then "sample(50%, emit_sample()),2" will trigger a drop half of the tim=
es
> > which is also terribly confusing.
>
> If emit_sample is the last action, then skb should be consumed silently.
> The same as for "output" and "userspace".
>
> >
> > I think we should try to be clear and informative with what we
> > _actually_ drop and not require the user that is just running
> > "dropwatch" to understand the internals of the OVS module.
>
> If someone is already using sampling to watch their packet drops, why wou=
ld
> they use dropwatch?
>
> >
> > So if you don't want to accept the "observational" nature of sample(),
> > the only other solution that does not bring even more confusion to OVS
> > drops would be to have userspace add explicit drop actions. WDYT?
> >
>
> These are not drops from the datapath perspective.  Users can add explici=
t
> drop actions if they want to, but I'm really not sure why they would do t=
hat
> if they are already capturing all these packets in psample, sFlow or IPFI=
X.

Because there is not a single "user". Tools and systems can be built on
top of tracepoints and samples and they might not be coordinated between
them. Some observability application can be always enabled and doing
constant network monitoring or statistics while other lower level tools
can be run at certain moments to troubleshoot issues.

In order to run dropwatch in a node you don't need to have rights to
access the OpenFlow controller and ask it to change the OpenFlow rules
or else dropwatch simply will not show actual packet drops.

To me it seems obvious that drop sampling (via emit_sample) "includes"
drop reporting via emit_sample. In both cases you get the packet
headers, but in one case you also get OFP controller metadata. Now even
if there is a system that uses both, does it make sense to push to them
the responsibility of dealing with them being mutually exclusive?

I think this makes debugging OVS datapath unnecessarily obscure when we
know the packet is actually being dropped intentionally by OVS.

What's the problem with having OVS write the following?
    "sample(50%, emit_sample()),drop(0)"

Thanks,
Adri=C3=A1n


