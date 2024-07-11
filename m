Return-Path: <linux-kernel+bounces-249312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B5292E9CE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05DEBB24BC9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A87D1607A8;
	Thu, 11 Jul 2024 13:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="UoTjJt4C"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A1415ECED
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 13:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720705417; cv=none; b=dSwU1lrXiOjJp30ZTxjmVHHqy53Kc2AQD73JXbAHtAJjnubtQdVntKoJflouPgsuUWSpNcOho6S+Q0tTdE5wODDvAA9yskIo2/kp9bzBn1tOJC8iQSmRzk4A2+SQaxNZzZo7omlyD/PyRn/+8IUg4oYtiaH3susmlDyU3UPfJvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720705417; c=relaxed/simple;
	bh=o+5i6mIUvBPggu9iNkNKAi/8MWHTFoDc6KXMfC+8lJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lm0IVMmuKLuzkVzSDjAiHmbqDB2edpfR+xt71dqU9JlJh/rvogYU84F7pqVX4Vn43yaRRPApInexavOc2MS9MKW+hS8DFmRygot/nD6254u24eTzYPmIjwFhgt4kWWlyHgDhsg0QoS2bErxiR6xv1QVkV3nwpEp1OGpcPne25wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=UoTjJt4C; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52ea79e689eso1286079e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 06:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1720705413; x=1721310213; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HCWEdgZVnaQia4hZ7qxBHy95vphFcyt4VAOelkNx1OI=;
        b=UoTjJt4CWfY9SLQGyxGf4e/9T0l7KdoIyc7uwWp/OroSkMry2v2IftHY4hfNF9szoX
         DwVD6Nvlk6Iapy8IjuaA3MTPq0GM5oW+Q4oYNq1oUMEv1OHcy0A601uiCGRGxRLHGd47
         O0xfjUTEsNSoUxTLML+tGhpRtNzEm4YhoYSu2x6Ii2YEY1eoSEmo9uhSp29ZJ2cGCKKX
         BpSU+bRSjUnQTrBzun8aWo2asEBFr7F6AJhnuQymyNph2+PDQ5otThe5QHIXMZqrN+20
         SvBWY393c0tTYidr7owuaWJloP3t7j8EifzeyujlskhM/R3ZUR538wY4QETSQ0JV27y1
         Ia6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720705413; x=1721310213;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HCWEdgZVnaQia4hZ7qxBHy95vphFcyt4VAOelkNx1OI=;
        b=oJ9P1K11GOPqU/cF5ou+Ug3D8BxvUiQxE3cEKTeFpXpNEO+O72i0/BL4H/O8EX5Chc
         khq/B7SbcRQx9BuEz0rCXy4n+r9cR4L6ht33pDsEVLPuBMOHvZB+ZTLoC75xcRmFtPeD
         dDmrBQWCMRWkUgwXsafmIk0tgD8bDiUq7EvYzHCtENE1ClVqkM42WV0TelJLvf3fvsXi
         bGoIPmMM39o4EOYZSr94jis0ShYfjEX0fWDgPdT11yJ+ElAXB0Oye3vOwm0zYCdl7SQ9
         2Qf6HkJjAmXkjQttuveumRkBfu/GxAm4ZQZldCtbudPOd9qg8GWgJ//NCOeuEJpjVc4A
         k57Q==
X-Forwarded-Encrypted: i=1; AJvYcCW/owzMmOkozWb48IfmurXYqDiQSUz688deBO/UFqksUf2rF63M+fMkZwRcCHnseED7gflFEaNs1T7sz5kg7r7S+vtYdh1uHPeBG/82
X-Gm-Message-State: AOJu0Yx6NqW7Hxhnd+En3L1lveU80ikUZDPKYzqt77UzRocwentj8MNc
	GivaEUuREVEgoBdmWkmzLJx33GBxFXYMiZc0cc7iZkqUBIe2vf2GtXWuCMKtVM0=
X-Google-Smtp-Source: AGHT+IGfnQgKlm4o3yV4UYgOt7VmCFn3e45AwDwu2f73YOZ7FLTEGLaYTVtXWW7/jc+di92fNHXDpg==
X-Received: by 2002:a05:6512:3d21:b0:52c:d76f:4604 with SMTP id 2adb3069b0e04-52eb99d27ccmr8224974e87.46.1720705412985;
        Thu, 11 Jul 2024 06:43:32 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a8542dfsm254772366b.150.2024.07.11.06.43.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 06:43:32 -0700 (PDT)
Message-ID: <9aff7e76-0799-4439-afff-a5ca4880bc72@blackwall.org>
Date: Thu, 11 Jul 2024 16:43:30 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: bridge: mst: Check vlan state for egress
 decision
To: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>, davem@davemloft.net
Cc: Roopa Prabhu <roopa@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Tobias Waldekranz <tobias@waldekranz.com>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240711045926.756958-1-elliot.ayrey@alliedtelesis.co.nz>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240711045926.756958-1-elliot.ayrey@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/07/2024 07:59, Elliot Ayrey wrote:
> If a port is blocking in the common instance but forwarding in an MST
> instance, traffic egressing the bridge will be dropped because the
> state of the common instance is overriding that of the MST instance.
> 
> Fix this by skipping the port state check in MST mode to allow
> checking the vlan state via br_allowed_egress(). This is similar to
> what happens in br_handle_frame_finish() when checking ingress
> traffic, which was introduced in the change below.
> 
> Fixes: ec7328b59176 ("net: bridge: mst: Multiple Spanning Tree (MST) mode")
> Signed-off-by: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>
> ---
> 
> v2:
>   - Restructure the MST mode check to make it read better
> v1: https://lore.kernel.org/all/20240705030041.1248472-1-elliot.ayrey@alliedtelesis.co.nz/
> 
>  net/bridge/br_forward.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
> index d97064d460dc..e63d6f6308f8 100644
> --- a/net/bridge/br_forward.c
> +++ b/net/bridge/br_forward.c
> @@ -25,8 +25,8 @@ static inline int should_deliver(const struct net_bridge_port *p,
>  
>  	vg = nbp_vlan_group_rcu(p);
>  	return ((p->flags & BR_HAIRPIN_MODE) || skb->dev != p->dev) &&
> -		p->state == BR_STATE_FORWARDING && br_allowed_egress(vg, skb) &&
> -		nbp_switchdev_allowed_egress(p, skb) &&
> +		(br_mst_is_enabled(p->br) || state == BR_STATE_FORWARDING) &&

Does this compile at all? How exactly did you test this change?
There is no "state" variable in that context.

