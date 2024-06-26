Return-Path: <linux-kernel+bounces-231278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0766918A1B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 19:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D948A1C22561
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 17:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACE118FDCF;
	Wed, 26 Jun 2024 17:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gDGcqQHu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD8F18FDC2
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 17:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719422980; cv=none; b=AptGClFL1csA/wzyDums5xMYEUx2jnqS70X4DO/iCBdDZ9JQRr7Z6bWJmfBCrt8r+7BnyfnNZZO2HrGmWmJurobM7hBhM0TspOPG+ZN0tb6+Ez+KDCZ39VhobKNOxsPmOgqT4iRzLTSHIreZsW2OqJsx4KWRe7vHHODlsTkSUdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719422980; c=relaxed/simple;
	bh=F8lJb+2w1Y21E5VOznQl3Rx2squALjSmsxn2Z/8lvx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rSOSdhZG5K0QXpnS7DAy++9zpB699l7fqZKzzDNMuYS3ASvhwhyoHnczL2CLGz/0PmCEd8KTysiVH0IxvWbt0WKd1pZ6iKEc0oxbid5NC6wyrkryafRxRKIJ724Vis0y/dkrf8hnM0mWZtbMgFCnUPQWp+Io4RKlRhw9xj1kq6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gDGcqQHu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719422977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7DcTLE3yWDjyk1xqGcYEiqY3CH5ei9AFFdK+76Cq7DU=;
	b=gDGcqQHu2nwc3tyAHzGP7n4yGW5rLHCGabJS6ROPd9YCmZqaTBeZnmSE/Tt4V6xvv1/VD4
	VJqnfYQuNvoVJoD09Dpp2F9f9jhRgMgbDChHLy8R7rpOmzxA0mFhCaXyO32HgLpXn87u6v
	gZedolUdwni0mHrizUfmY8JQ+Bpbtyc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-WcdWtPHdM2CntBk_D8xCWw-1; Wed, 26 Jun 2024 13:29:36 -0400
X-MC-Unique: WcdWtPHdM2CntBk_D8xCWw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4218447b900so5107025e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 10:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719422975; x=1720027775;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7DcTLE3yWDjyk1xqGcYEiqY3CH5ei9AFFdK+76Cq7DU=;
        b=n7UQXPlXF1i7p0IsRd4tRNrU4n0TF6nxF55BGM/ZuhFHFNlrtALlmTvvDfSvRbcX6x
         efo48XlHmBFPG3FX4OfP2O06CnFFlr8ZgfiwTub9gJZsqwtNJ5bDCEGxpvjyw7Ke8brD
         dM8QOYlihr2d/YnxKuEykpD8GsjBfl1Rfc2kerW/L1CNj6YD8hRQYxOOqCCvieXhTU5M
         97RdH8Hj9OZLHKBr4A+ElHqg8ZIKGGtaF5rd+Zi4f+mogOig9VC9LEgVFbBM26AltA2O
         UQJ+nVNye+Vg/yG5NnG3X2SHm3mA8hYAO5dziUW5loSWCg8n7dx231KgqyG9NapIIv37
         7LJA==
X-Forwarded-Encrypted: i=1; AJvYcCW8I+Diysf5Qb4o6dZALTS7DTaZxC98e9rj09IzsTY5fgtb3C2+Kw84m6pBInvw76jMQ3KHgYCeuMxIn5uW986gCqUTqb7Wvv+rFlbb
X-Gm-Message-State: AOJu0YyNxVUvUSvlBqwSOajnPEzLQP6qqWcrLeP55HuM7DenMAGJBbF1
	qKvjQKxZr1r5o70kftZMn53kNfuUa3xxtLdlcZADfKruLAyf8v14VXpXbDFdwR2oyYTSvLzXh6y
	v53r7Q+IcFsP/FudWh/N0+lARXm/ox9yWso8SPzWtVRAxUhsOLAVI7ReAgSd7nA==
X-Received: by 2002:a05:600c:4447:b0:424:84fb:9fd2 with SMTP id 5b1f17b1804b1-4256313f2c0mr3065335e9.19.1719422974825;
        Wed, 26 Jun 2024 10:29:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSJpDCQJurGIE7lyw9ReuWhLy1leQmGYFlkjt/vBoG7Sq3e5X5HASbNrYiOLVbuaVEjuZxeg==
X-Received: by 2002:a05:600c:4447:b0:424:84fb:9fd2 with SMTP id 5b1f17b1804b1-4256313f2c0mr3064875e9.19.1719422974045;
        Wed, 26 Jun 2024 10:29:34 -0700 (PDT)
Received: from localhost ([2a01:e11:1007:ea0:8374:5c74:dd98:a7b2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c84245f0sm33743165e9.33.2024.06.26.10.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 10:29:33 -0700 (PDT)
Date: Wed, 26 Jun 2024 19:29:32 +0200
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
Message-ID: <ZnxP_IHSJWg8FhfO@dcaratti.users.ipa.redhat.com>
References: <20240611235355.177667-1-ast@fiberby.net>
 <20240611235355.177667-3-ast@fiberby.net>
 <ZnVR3LsBSvfRyTDD@dcaratti.users.ipa.redhat.com>
 <0fa312be-be5d-44a1-a113-f899844f13be@fiberby.net>
 <ZnvkIHCsqnDLlVa9@dcaratti.users.ipa.redhat.com>
 <CAKa-r6uqO20RB-fEVRifAEE_hLA50Zch=wbKtX8vNt5m6kE5_Q@mail.gmail.com>
 <d2df2837-070b-4669-8a35-c3d1341849d2@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d2df2837-070b-4669-8a35-c3d1341849d2@fiberby.net>

hello Asbjørn,

On Wed, Jun 26, 2024 at 11:55:31AM +0000, Asbjørn Sloth Tønnesen wrote:
> Hi Davide,
> 
> On 6/26/24 10:01 AM, Davide Caratti wrote:
> > On Wed, Jun 26, 2024 at 11:49 AM Davide Caratti <dcaratti@redhat.com> wrote:
> > > 
> > > So, we must htonl() the policy mask in the second hunk in patch 7,something like:
> 
> Good catch.
> 
> > or maybe better (but still untested), use NLA_BE32, like netfilter does in [1]
> > 
> > [1] https://elixir.bootlin.com/linux/latest/A/ident/NF_NAT_RANGE_MASK
> 
> Yes, that is better. It should work, as it triggers a htonl() in nla_validate_mask().

NLA_BE32 proved to fix the byte ordering problem:

 - it allows to set TCA_FLOWER_KEY_ENC_FLAGS_MASK and read it back consistently
 - it sets correct FLOW_DIS_F_* bits in 'enc_control'

FTR, I used this hunk on top of your RFC series:

-- >8 --
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -679,9 +679,9 @@ static const struct nla_policy fl_policy[TCA_FLOWER_MAX + 1] = {
        [TCA_FLOWER_KEY_ENC_UDP_SRC_PORT_MASK]  = { .type = NLA_U16 },
        [TCA_FLOWER_KEY_ENC_UDP_DST_PORT]       = { .type = NLA_U16 },
        [TCA_FLOWER_KEY_ENC_UDP_DST_PORT_MASK]  = { .type = NLA_U16 },
-       [TCA_FLOWER_KEY_FLAGS]          = NLA_POLICY_MASK(NLA_U32,
+       [TCA_FLOWER_KEY_FLAGS]          = NLA_POLICY_MASK(NLA_BE32,
                                                          TCA_FLOWER_KEY_FLAGS_POLICY_MASK),
-       [TCA_FLOWER_KEY_FLAGS_MASK]     = NLA_POLICY_MASK(NLA_U32,
+       [TCA_FLOWER_KEY_FLAGS_MASK]     = NLA_POLICY_MASK(NLA_BE32,
                                                          TCA_FLOWER_KEY_FLAGS_POLICY_MASK),
        [TCA_FLOWER_KEY_ICMPV4_TYPE]    = { .type = NLA_U8 },
        [TCA_FLOWER_KEY_ICMPV4_TYPE_MASK] = { .type = NLA_U8 },
@@ -744,9 +744,9 @@ static const struct nla_policy fl_policy[TCA_FLOWER_MAX + 1] = {
        [TCA_FLOWER_KEY_SPI_MASK]       = { .type = NLA_U32 },
        [TCA_FLOWER_L2_MISS]            = NLA_POLICY_MAX(NLA_U8, 1),
        [TCA_FLOWER_KEY_CFM]            = { .type = NLA_NESTED },
-       [TCA_FLOWER_KEY_ENC_FLAGS]      = NLA_POLICY_MASK(NLA_U32,
+       [TCA_FLOWER_KEY_ENC_FLAGS]      = NLA_POLICY_MASK(NLA_BE32,
                                                          TCA_FLOWER_KEY_ENC_FLAGS_POLICY_MASK),
-       [TCA_FLOWER_KEY_ENC_FLAGS_MASK] = NLA_POLICY_MASK(NLA_U32,
+       [TCA_FLOWER_KEY_ENC_FLAGS_MASK] = NLA_POLICY_MASK(NLA_BE32,
                                                          TCA_FLOWER_KEY_ENC_FLAGS_POLICY_MASK),
 };

-- >8 --

but I think I found another small problem. You removed FLOW_DISSECTOR_KEY_ENC_FLAGS
from TC flower, re-using 'enc_control' instead; however, the FLOW_DISSECTOR_KEY_ENC_CONTROL
bit is set only if flower tries to match 'enc_ipv4' or 'enc_ipv6'. We don't notice
the problem with 'ip_flags' because AFAIS flow dissector copies those bits even with
no relevant FLOW_DISSECTOR_KEY* requested. When matching tunnel flags instead, we
will end up in skb_flow_dissect_tunne_info() with 


	/* A quick check to see if there might be something to do. */
	if (!dissector_uses_key(flow_dissector,
				FLOW_DISSECTOR_KEY_ENC_KEYID) &&
	    !dissector_uses_key(flow_dissector,
				FLOW_DISSECTOR_KEY_ENC_IPV4_ADDRS) &&
	    !dissector_uses_key(flow_dissector,
				FLOW_DISSECTOR_KEY_ENC_IPV6_ADDRS) &&
	    !dissector_uses_key(flow_dissector,
				FLOW_DISSECTOR_KEY_ENC_CONTROL) &&
	    !dissector_uses_key(flow_dissector,
				FLOW_DISSECTOR_KEY_ENC_PORTS) &&
	    !dissector_uses_key(flow_dissector,
				FLOW_DISSECTOR_KEY_ENC_IP) &&
	    !dissector_uses_key(flow_dissector,
				FLOW_DISSECTOR_KEY_ENC_OPTS))
		return;

 
^^ a kernel that returns without loading tunnel info, because "there is nothing
to do". So, the attempt to put a valid value in patch9 regardless of the address
family is not sufficient. IMO it can be fixed with the following hunk:

-- >8 --
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -2199,7 +2199,8 @@ static void fl_init_dissector(struct flow_dissector *dissector,
        FL_KEY_SET_IF_MASKED(mask, keys, cnt,
                             FLOW_DISSECTOR_KEY_ENC_IPV6_ADDRS, enc_ipv6);
        if (FL_KEY_IS_MASKED(mask, enc_ipv4) ||
-           FL_KEY_IS_MASKED(mask, enc_ipv6))
+           FL_KEY_IS_MASKED(mask, enc_ipv6) ||
+           FL_KEY_IS_MASKED(mask, enc_control))
                FL_KEY_SET(keys, cnt, FLOW_DISSECTOR_KEY_ENC_CONTROL,
                           enc_control);
        FL_KEY_SET_IF_MASKED(mask, keys, cnt,
-- >8 --

at least it passes my functional test (that I didn't send yet, together with
iproute bits :(  promise will do that now)

-- 
davide


