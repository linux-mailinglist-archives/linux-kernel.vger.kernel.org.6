Return-Path: <linux-kernel+bounces-230442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E16C917CE1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 619021C2289A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7385416D33A;
	Wed, 26 Jun 2024 09:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gBJeiEh8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC1716CD1F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 09:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719395368; cv=none; b=B7RjM9Wz45H04W/lAMAR47khWLrlboy0LBi4T+bNdebqnGt9NnsHp5AnR8JYM73+2ZvpFXmQVuRpHT6x8Vgz4HAZDoqtqwDlBvdAFZI0VL0HZg5IPbn0qeCAXNBpYmBjXVDHyDaQd0+NEJ/9Hdd13glGfSbcY783+3nw3nao7Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719395368; c=relaxed/simple;
	bh=DWIGWxbl+woKwQpaluXg5n45wCq4JDHrOc+cad4B7fY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQ4dRcxTZ0ErmYdZmBhBuI/kde+vq7kPdFXYUGtx0TbiQ2KNJfCi/Lz5EdgLG+uxyjBRZTye1UvVJm0rrNnxaRQ+dalwmAHAq7v5P+eBXoHU30l/iYfsPDEPHd6Rpn4gz7wMveANq3jFbvfLOvz+ufLm0dUKwUJCpyLaUoSKazc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gBJeiEh8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719395365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4djDjoucdiNC3v37pUz0oafRQ2jw1kRnVn3jy6AlRSM=;
	b=gBJeiEh8EVP1Ty6IJSFEGbZpDTodpYnrQNFtgVM8gD5AVjVld4WCMMGdTWmMvGpDNUAJlt
	XqjTi+VlXYAvJTpj0jh9JsbSCTw2Hp63iLqmPYj7Uwuu0Xj99jomrntDpEzDMMydTr1Txt
	rAJBa5YjU1TRs868bOR/9v+0BrFkjdU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-I2VkV8kYO8yljK_aml0XvQ-1; Wed, 26 Jun 2024 05:49:24 -0400
X-MC-Unique: I2VkV8kYO8yljK_aml0XvQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42490e94105so21468985e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 02:49:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719395363; x=1720000163;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4djDjoucdiNC3v37pUz0oafRQ2jw1kRnVn3jy6AlRSM=;
        b=XrdM+nE8PNEt1q83ZJ3GpIUF6GffDdVbLRvdjvlgUwbW4Eg07uCb1ObfdeIPRqxt5g
         dQpBXAGLi0gTnqfd01fJ7ZEUwJp+XtcQayD6jWkydhDPOaWCwwjv3z+R+8kUzLSFbtp6
         JTZWuUbrks9dsfaF6tqgybxt4Gp6CR64NJesOnSzt7XvbUd+5FV/1XKNiJ/KLPFpsZnG
         6qOtUsSWrJFSZIDLvzJXEXQWrKUbSVE1F/xTnbTjB5RHS1lMYS6hBhPddUHGzitL8ich
         lPfUUMyKnB5Tz8Ygecl1dJjVEJNsUyN1JmCOBLxxKtCsj84En1x1CzxP3aC/0LjLytUO
         GIEA==
X-Forwarded-Encrypted: i=1; AJvYcCV3bmqbBdeyiwxYE6JpKzczX6OOMA4xCh5x2AWhJnwbQ6/BN2XdoLWGkigY58PXHgIGAY65CloenmXd4LSO7izY3WbQHVqu8u1f32fF
X-Gm-Message-State: AOJu0YxaHxO9KIP5HMm1OY/PoYm6xWc5dRywCK/SSb6zVvD+zbXDw5uW
	1UIog9RmCFPKlAl5XQJPotchpA/aBJB5TFE+WvKFMHbdt6BhCe0q1om+load8MYYnksyAqU2g1K
	7wJDZUTx+TPtLVIEMU8KXeQGpPfac9reVxsZhTTNm2fYGA34Z8h4hq0a4e0YgKw==
X-Received: by 2002:a05:600c:4a21:b0:424:aa73:83db with SMTP id 5b1f17b1804b1-424aa7385d9mr16426425e9.3.1719395363234;
        Wed, 26 Jun 2024 02:49:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/3FLpYFj1lNUdvagVZ//NSmf/wAzF1F50kld50FSwNHiB4Iwf5oXPdzRER19Pywz3nR5htA==
X-Received: by 2002:a05:600c:4a21:b0:424:aa73:83db with SMTP id 5b1f17b1804b1-424aa7385d9mr16426215e9.3.1719395362335;
        Wed, 26 Jun 2024 02:49:22 -0700 (PDT)
Received: from localhost ([2a01:e11:1007:ea0:8374:5c74:dd98:a7b2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a2f696csm15283695f8f.82.2024.06.26.02.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 02:49:21 -0700 (PDT)
Date: Wed, 26 Jun 2024 11:49:20 +0200
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
Message-ID: <ZnvkIHCsqnDLlVa9@dcaratti.users.ipa.redhat.com>
References: <20240611235355.177667-1-ast@fiberby.net>
 <20240611235355.177667-3-ast@fiberby.net>
 <ZnVR3LsBSvfRyTDD@dcaratti.users.ipa.redhat.com>
 <0fa312be-be5d-44a1-a113-f899844f13be@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0fa312be-be5d-44a1-a113-f899844f13be@fiberby.net>

hello Asbjørn,

thanks for your patience!

On Fri, Jun 21, 2024 at 02:45:28PM +0000, Asbjørn Sloth Tønnesen wrote:
> 
> Could you please post your iproute2 code?

sure, will clean it up and share it today in ML.
 
> > from
> > 
> > https://lore.kernel.org/netdev/20240611235355.177667-2-ast@fiberby.net/
> > 
> > Now: functional tests on TCA_FLOWER_KEY_ENC_FLAGS systematically fail. I must
> > admit that I didn't complete 100% of the analysis, but IMO there is at least an
> > endianness problem here. See below:
> > 
> > On Tue, Jun 11, 2024 at 11:53:35PM +0000, Asbjørn Sloth Tønnesen wrote:

[...]
 
> It is always preferred to have a well-defined endianness for binary protocols, even
> if it might only be used locally for now.

given the implementation of fl_set_key_flags() in patch 2,

	key = be32_to_cpu(nla_get_be32(tb[fl_key]));
	mask = be32_to_cpu(nla_get_be32(tb[fl_mask]));

when fl_key and fl_mask are TCA_FLOWER_KEY_ENC_FLAGS and TCA_FLOWER_KEY_ENC_FLAGS_MASK,
I assume that we want to turn them to network ordering, like it's already being done for
TCA_FLOWER_KEY_FLAGS and TCA_FLOWER_KEY_FLAGS_MASK.

So, we must htonl() the policy mask in the second hunk in patch 7,something like:

@@ -746,9 +746,9 @@ static const struct nla_policy fl_policy[TCA_FLOWER_MAX + 1] = {
 	[TCA_FLOWER_L2_MISS]		= NLA_POLICY_MAX(NLA_U8, 1),
 	[TCA_FLOWER_KEY_CFM]		= { .type = NLA_NESTED },
 	[TCA_FLOWER_KEY_ENC_FLAGS]	= NLA_POLICY_MASK(NLA_U32,
-							  TUNNEL_FLAGS_PRESENT),
+							  htonl(TCA_FLOWER_KEY_ENC_FLAGS_POLICY_MASK)),
 	[TCA_FLOWER_KEY_ENC_FLAGS_MASK]	= NLA_POLICY_MASK(NLA_U32,
-							  TUNNEL_FLAGS_PRESENT),
+							  htonl(TCA_FLOWER_KEY_ENC_FLAGS_POLICY_MASK)),
 };

And for the same reason, the flower code in patch 3 needs to be changed as follows:

@@ -676,8 +680,10 @@ static const struct nla_policy fl_policy[TCA_FLOWER_MAX + 1] = {
 	[TCA_FLOWER_KEY_ENC_UDP_SRC_PORT_MASK]	= { .type = NLA_U16 },
 	[TCA_FLOWER_KEY_ENC_UDP_DST_PORT]	= { .type = NLA_U16 },
 	[TCA_FLOWER_KEY_ENC_UDP_DST_PORT_MASK]	= { .type = NLA_U16 },
-	[TCA_FLOWER_KEY_FLAGS]		= { .type = NLA_U32 },
-	[TCA_FLOWER_KEY_FLAGS_MASK]	= { .type = NLA_U32 },
+	[TCA_FLOWER_KEY_FLAGS]		= NLA_POLICY_MASK(NLA_U32,
+							  ntohl(TCA_FLOWER_KEY_FLAGS_POLICY_MASK)),
+	[TCA_FLOWER_KEY_FLAGS_MASK]	= NLA_POLICY_MASK(NLA_U32,
+							  ntohl(TCA_FLOWER_KEY_FLAGS_POLICY_MASK)),
 	[TCA_FLOWER_KEY_ICMPV4_TYPE]	= { .type = NLA_U8 },
 	[TCA_FLOWER_KEY_ICMPV4_TYPE_MASK] = { .type = NLA_U8 },
 	[TCA_FLOWER_KEY_ICMPV4_CODE]	= { .type = NLA_U8 },

Otherwise it will break the following use case (taken from tc_flower.sh kselftest):

# tc qdisc add dev lo clsact
# tc filter add dev lo ingress protocol ip pref 1 handle 101 flower ip_flags frag action continue
RTNETLINK answers: Invalid argument
We have an error talking to the kernel

because TCA_FLOWER_KEY_FLAGS_POLICY_MASK and TCA_FLOWER_KEY_ENC_FLAGS_POLICY_MASK
are in host byte order _ so netlink policy mask validation will fail unless we turn
the mask to network byte order.

(And I see we don't have a tdc selftest  for 'ip_flags', this might be a
good chance to add it :-) )

-- 
davide


