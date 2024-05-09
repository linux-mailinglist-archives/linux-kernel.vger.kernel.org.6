Return-Path: <linux-kernel+bounces-174799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CC38C1527
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 21:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DD7DB220C2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 19:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5B77CF3E;
	Thu,  9 May 2024 19:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ao5qP9pj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F437E59A
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 19:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715281677; cv=none; b=H+4GsUAGQIlB6/gXeimx/1J1U+OW7UfBtVIYC57JGHgaofuiYnSIkrTZJOSQsrZYkg5MIkTADYAbvX2eQxh5e4i4RBua9pq81oLPfurImyKnkHOi7+2h81etjdHQ7LCqmSJLF4QLn5kWWYW61ZA+bZxG/htzbGooDE7ohI8AEiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715281677; c=relaxed/simple;
	bh=+pWEJzXwwXVhUGCYVhqQW0Gh9E0v93VUDpXB1cBKXbw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T3pRAaG8OIG2JTCuDP57vGlBY0Rarme2nJ9Ylb/d5gYAtU6vYtsTX7UKcq2EqCJHWjjnTWDr099iAy+yjEPdfbtHEzzP/ZcZJa4R7qpn5wdECPhoGHoQpw/fl8vgzCrKJ2iLXra8Sj0aHw5JWd51qfeiP2mQFburSpXq4MbnXk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ao5qP9pj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715281674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tww4Ddeatp59yRwNDk2ipeaPmVqICKWNDahWfPFhquU=;
	b=Ao5qP9pjJFfQAcLhZDDdEbOCwRL4bwrZ4tcUPxMIxdsnDFyiBTvZh2LnjEpNSAMzydJALk
	/cT/mIU7bK63jt35lnymo0m1Ih1IhgGmRpJ9PqcFToDLD12uHjuuXKT4zsq9fq7gT1Ogt2
	P6r5v6X+KyBebsfvOVVRAj2t2I2w37Y=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-224-5v9GxJXoMGGXEhR2EpBJow-1; Thu,
 09 May 2024 15:07:51 -0400
X-MC-Unique: 5v9GxJXoMGGXEhR2EpBJow-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AF4541C4C397;
	Thu,  9 May 2024 19:07:49 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.10.50])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 04776FA056;
	Thu,  9 May 2024 19:07:48 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org,  dev@openvswitch.org,  Antonin Bas
 <antonin.bas@broadcom.com>,  linux-kernel@vger.kernel.org,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  "David S. Miller" <davem@davemloft.net>
Subject: Re: [ovs-dev] [PATCH net] net: openvswitch: fix overwriting ct
 original tuple for ICMPv6
In-Reply-To: <20240509094228.1035477-1-i.maximets@ovn.org> (Ilya Maximets's
	message of "Thu, 9 May 2024 11:38:05 +0200")
References: <20240509094228.1035477-1-i.maximets@ovn.org>
Date: Thu, 09 May 2024 15:07:48 -0400
Message-ID: <f7tfruq952z.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Ilya Maximets <i.maximets@ovn.org> writes:

> OVS_PACKET_CMD_EXECUTE has 3 main attributes:
>  - OVS_PACKET_ATTR_KEY - Packet metadata in a netlink format.
>  - OVS_PACKET_ATTR_PACKET - Binary packet content.
>  - OVS_PACKET_ATTR_ACTIONS - Actions to execute on the packet.
>
> OVS_PACKET_ATTR_KEY is parsed first to populate sw_flow_key structure
> with the metadata like conntrack state, input port, recirculation id,
> etc.  Then the packet itself gets parsed to populate the rest of the
> keys from the packet headers.
>
> Whenever the packet parsing code starts parsing the ICMPv6 header, it
> first zeroes out fields in the key corresponding to Neighbor Discovery
> information even if it is not an ND packet.
>
> It is an 'ipv6.nd' field.  However, the 'ipv6' is a union that shares
> the space between 'nd' and 'ct_orig' that holds the original tuple
> conntrack metadata parsed from the OVS_PACKET_ATTR_KEY.
>
> ND packets should not normally have conntrack state, so it's fine to
> share the space, but normal ICMPv6 Echo packets or maybe other types of
> ICMPv6 can have the state attached and it should not be overwritten.
>
> The issue results in all but the last 4 bytes of the destination
> address being wiped from the original conntrack tuple leading to
> incorrect packet matching and potentially executing wrong actions
> in case this packet recirculates within the datapath or goes back
> to userspace.
>
> ND fields should not be accessed in non-ND packets, so not clearing
> them should be fine.  Executing memset() only for actual ND packets to
> avoid the issue.
>
> Initializing the whole thing before parsing is needed because ND packet
> may not contain all the options.
>
> The issue only affects the OVS_PACKET_CMD_EXECUTE path and doesn't
> affect packets entering OVS datapath from network interfaces, because
> in this case CT metadata is populated from skb after the packet is
> already parsed.
>
> Fixes: 9dd7f8907c37 ("openvswitch: Add original direction conntrack
> tuple to sw_flow_key.")
> Reported-by: Antonin Bas <antonin.bas@broadcom.com>
> Closes: https://github.com/openvswitch/ovs-issues/issues/327
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---

Acked-by: Aaron Conole <aconole@redhat.com>

> Note: I'm working on a selftest for this issue, but it requires some
> ground work first to add support for OVS_PACKET_CMD_EXECUTE into
> opnevswitch selftests as well as parsing of ct tuples.  So it is going
> to be a separate patch set.

I do have something already to do this for an issue in CMD_EXECUTE that
I'm debugging (may be the same?).  I can reply with my work off-list if
you think it would be useful to you.

>  net/openvswitch/flow.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/openvswitch/flow.c b/net/openvswitch/flow.c
> index 33b21a0c0548..8a848ce72e29 100644
> --- a/net/openvswitch/flow.c
> +++ b/net/openvswitch/flow.c
> @@ -561,7 +561,6 @@ static int parse_icmpv6(struct sk_buff *skb, struct sw_flow_key *key,
>  	 */
>  	key->tp.src = htons(icmp->icmp6_type);
>  	key->tp.dst = htons(icmp->icmp6_code);
> -	memset(&key->ipv6.nd, 0, sizeof(key->ipv6.nd));
>  
>  	if (icmp->icmp6_code == 0 &&
>  	    (icmp->icmp6_type == NDISC_NEIGHBOUR_SOLICITATION ||
> @@ -570,6 +569,8 @@ static int parse_icmpv6(struct sk_buff *skb, struct sw_flow_key *key,
>  		struct nd_msg *nd;
>  		int offset;
>  
> +		memset(&key->ipv6.nd, 0, sizeof(key->ipv6.nd));
> +
>  		/* In order to process neighbor discovery options, we need the
>  		 * entire packet.
>  		 */


