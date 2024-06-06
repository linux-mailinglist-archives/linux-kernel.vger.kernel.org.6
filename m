Return-Path: <linux-kernel+bounces-203857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B3A8FE153
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E138F28CE9B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A99813D242;
	Thu,  6 Jun 2024 08:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HwkNmP3T"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3919B13C821
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 08:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717663329; cv=none; b=nAufIEdj0R2gZpc1cclj/Pow2pG2tBxHlIhtomtTFAWkwhM7AsqWbLsSwdH1iYmPOFoCmTd7M72aOunykJLz4TXEPBZMMo8DhUE8pBntHhPpRc4E4wgkY5t77+sRANW9aJ2LUDHhfard2boQloOMcw6KScXfzEiWao5y95NKM8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717663329; c=relaxed/simple;
	bh=mAb+0Iv6Exl25GZ+qLNucVvBGjl2AXfSSYAlWqDLImc=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JwuG9Q189Nw4XTqJe1NHBhvQS9ai24j75FaJ552r23HQ3rrp627R4E8ZvC2BR7nfADKPrZraLlTDZDbnktq1jcAzQjH9haPp28vvtBZM3WNyboxIRZsJN4MMGIW7Ix0uJJJaRlYNn0VMxd68jctQtJAZfeGurP4qM9ihRwwdWWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HwkNmP3T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717663327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3DTzxzZ6ElccSXzynyCH2s3XyyNG1vvqASU4bmMnRVo=;
	b=HwkNmP3TXBtVmSqnPJ12BFp1rEzPKq+kApjfDPm5X4CJJvNlM9KDJ/vpYwAizfwZAVpCG8
	2s4JTMQHOp5Jd+FWXCer2QIM+FhFd6HFs4rDLO99eTIDYV59B6AgEYeAZC55FY2czcwfS2
	OOLQMIttz/mto43/4Z46WdhHzzc2BLw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-55i_iJlCOrqhdEZ-3OGXGw-1; Thu, 06 Jun 2024 04:42:05 -0400
X-MC-Unique: 55i_iJlCOrqhdEZ-3OGXGw-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6ad706fab2aso9989966d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 01:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717663325; x=1718268125;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3DTzxzZ6ElccSXzynyCH2s3XyyNG1vvqASU4bmMnRVo=;
        b=Jvqzjsx42AmpdWCMrecvpqIE0NJTZdKbvAs1eJ5wawvk0d3z4SaVNdjhJJIvOljFwS
         1Eh1zXlBnim1m9hJbAMUOnoVuzmvPlStTKM1kEPrhJEyJHOjSQOnwsuXlkk1WoXd6MZ6
         3B3gqVUIuI+NkTyUBJL1AVWZxLYg0K7zg/7YatwmZyuVgRsFPqAKsn7woi4dA4BPy4ST
         D+EVTDrlJmVE5ydXHfeHm5xlyUev80MzhvzRbr+QbCoV9cNcRW/T3VGqWzfKxWun/8lk
         YHhC6Mv0Z4KGDXZM1ifeUXfrcslZD/tyyuefZhQGZ7ezJb7bxxbQO3AhJ7zmxjekb46z
         Yz7A==
X-Forwarded-Encrypted: i=1; AJvYcCWEmjOzSBhXRoWmxbTphMUFjinwsUsX+mTXxhg7Se2yLc1M4b3wXX4Dqdo6386NCZtaqfeU6Wmh/8j63QCzawPAPaihPorfn/sDHqkx
X-Gm-Message-State: AOJu0YzInoESQNbU/aEITeGVyWZ4f0OcXJqpX8E+ABIE5d6RIPWiLaGH
	y0fRRm3zlz7F+k8gI7Elxd/9eXngFzfcv1ywvuXEhLltIt/vT5Bt6lPJraHji5u1fV+DRg3jAhY
	uA/48U40dkLaVm9jbZMVy3EUD8mBuz0UlCrGgurrstAv34EWxkz0w6SNSoRBu54PMElITzKqvXS
	YGSBSPyTCokQy8L6fvO5YorE1Z2RubdGpTMgYz
X-Received: by 2002:a05:6214:5989:b0:6af:2342:e15b with SMTP id 6a1803df08f44-6b02bf15cf4mr65772226d6.14.1717663324855;
        Thu, 06 Jun 2024 01:42:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnOAjXFejTbHf91B2AwD+zLjnOZXa/PeDCbknCOrG22l3HyZQ2rnnA1enJhnGJLoAEXVr6f0JTK6qz9JRxYxg=
X-Received: by 2002:a05:6214:5989:b0:6af:2342:e15b with SMTP id
 6a1803df08f44-6b02bf15cf4mr65772016d6.14.1717663324427; Thu, 06 Jun 2024
 01:42:04 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 6 Jun 2024 08:42:03 +0000
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240603185647.2310748-1-amorenoz@redhat.com> <20240603185647.2310748-6-amorenoz@redhat.com>
 <20240605195117.GY791188@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240605195117.GY791188@kernel.org>
Date: Thu, 6 Jun 2024 08:42:03 +0000
Message-ID: <CAG=2xmML3MusD-ro6advb389ctYwaObZE+PBEh14TcXP5AbZJA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 5/9] net: openvswitch: add emit_sample action
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com, 
	i.maximets@ovn.org, dev@openvswitch.org, 
	Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Pravin B Shelar <pshelar@ovn.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, Jun 05, 2024 at 08:51:17PM GMT, Simon Horman wrote:
> On Mon, Jun 03, 2024 at 08:56:39PM +0200, Adrian Moreno wrote:
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
>
> Hi Adrian,
>
> Some minor nits from my side.
>
> ...
>
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
>
> nit: One blank line is enough.
>

Ack.

>      Flagged by checkpatch.pl
>
> >  /**
> >   * enum ovs_action_attr - Action types.
> >   *
> > @@ -1004,6 +1028,7 @@ enum ovs_action_attr {
> >  	OVS_ACTION_ATTR_ADD_MPLS,     /* struct ovs_action_add_mpls. */
> >  	OVS_ACTION_ATTR_DEC_TTL,      /* Nested OVS_DEC_TTL_ATTR_*. */
> >  	OVS_ACTION_ATTR_DROP,         /* u32 error code. */
> > +	OVS_ACTION_ATTR_EMIT_SAMPLE,  /* Nested OVS_EMIT_SAMPLE_ATTR_*. */
>
> nit: Please add OVS_ACTION_ATTR_EMIT_SAMPLE to the Kenrel doc
>      for this structure.
>

Thanks for spotting this. Will do.


> >
> >  	__OVS_ACTION_ATTR_MAX,	      /* Nothing past this will be accepted
> >  				       * from userspace. */
>
> ...
>


