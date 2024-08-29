Return-Path: <linux-kernel+bounces-307207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8882964A11
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 17:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75B11B22EE4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BED41B372D;
	Thu, 29 Aug 2024 15:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DiV3mZTE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4113D4643B
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 15:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724945444; cv=none; b=uHeNVfvSqfFDRTK3Y/r3BhY2B6PxGeAYYmdeoTrAk3CoSvx5z2wi7YicsXq5I52qwJ2arCW9oaLhYhf7wog/wn7akrLwcFSa9rRHsOdMvTKrjXIPIsJe1GUDwq9VVfu9Vh58oUzexeNOJD7F+ElAMpt4cOiYp/RUpJ6knUnE5C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724945444; c=relaxed/simple;
	bh=sRPYaGqjD+NniOsExyvUbWivuOEhM5UIZt34K8SrAJU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WynJoSEDeLiilL9dASCedj66l6/+ROpNne0jZbb7awd0K39G80KIkmjg1Sh95/CrwH5v6JwPQoxYVyWx12cDfd8P6rGs3aBjRpXW/3Q3POH2fGvnlA7PUQKMsm9w88IkoC7TqRkEp84Seup56wQLXIlwleBys4Hos6zK78N24ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DiV3mZTE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724945441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+0CA3YGpKJV/aWm75zN6DdjSYV9tIWnRxiAa+X/V8hg=;
	b=DiV3mZTEd+FFmYDZ/PbTCy3xWkJpl51PstcKD+fUDxyO24rHeBp6k13aTSdaxDSTnNHJd3
	8zQrQLu8fLwozVmQKmmarHzqdg8vzTLSMN2GeNcqYskqBjMHur21tQSYN+CLmROHjc3eOr
	iAfdBmEDalh4pf8rPkgwVO87Bfiv3e8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-451-ww_Q4s1JMi6XcZ6lSkF01Q-1; Thu,
 29 Aug 2024 11:30:37 -0400
X-MC-Unique: ww_Q4s1JMi6XcZ6lSkF01Q-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 596371954B12;
	Thu, 29 Aug 2024 15:30:32 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.8.86])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0520B19560AE;
	Thu, 29 Aug 2024 15:30:29 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Yan Zhen <yanzhen@vivo.com>
Cc: Eelco Chaudron <echaudro@redhat.com>, dev@openvswitch.org,
 opensource.kernel@vivo.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net
Subject: Re: [ovs-dev] [PATCH v1 net-next] net: openvswitch: Use ERR_CAST()
 to return
In-Reply-To: <20240829095509.3151987-1-yanzhen@vivo.com>
References: <20240829095509.3151987-1-yanzhen@vivo.com>
Date: Thu, 29 Aug 2024 11:30:27 -0400
Message-ID: <f7tzfov1h4c.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12


Yan Zhen <yanzhen@vivo.com> writes:

> Using ERR_CAST() is more reasonable and safer, When it is necessary
> to convert the type of an error pointer and return it.
>
> Signed-off-by: Yan Zhen <yanzhen@vivo.com>
> ---

LGTM, and seems like the only remaining place where we are open coding
the error return conversion in the OVS module (at least, where we do a
check with IS_ERR).  At least, I tried to visit them all while looking
at this.

Reviewed-by: Aaron Conole <aconole@redhat.com>

>  net/openvswitch/flow_netlink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlink.c
> index c92bdc4dfe19..729ef582a3a8 100644
> --- a/net/openvswitch/flow_netlink.c
> +++ b/net/openvswitch/flow_netlink.c
> @@ -2491,7 +2491,7 @@ static struct nlattr *reserve_sfa_size(struct sw_flow_actions **sfa,
>
>  	acts = nla_alloc_flow_actions(new_acts_size);
>  	if (IS_ERR(acts))
> -		return (void *)acts;
> +		return ERR_CAST(acts);
>
>  	memcpy(acts->actions, (*sfa)->actions, (*sfa)->actions_len);
>  	acts->actions_len = (*sfa)->actions_len;
> -- 
> 2.34.1


