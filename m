Return-Path: <linux-kernel+bounces-363291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 152F399C014
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3A54282A63
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 06:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74B8144D01;
	Mon, 14 Oct 2024 06:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="oZjV7se+"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8124C13B5B4
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 06:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728887732; cv=none; b=X1fRuc+98VmUZ14iy02CzravvKfM2lZza4HS4GEB1Dybpc6/wU20ir7nNSgckV1oMg461CGZd7Spkb6h/e+6ihkhTlb2eAvG665igdUMH+exnAok60mW7u3aAUt2QkT0mtkDZk6Dynt0Ng8Z2/ejsCxmZArQ4DmslfrtTXqYPGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728887732; c=relaxed/simple;
	bh=ZGBoVdbwgat/NxUEjyYnv4uZ19nNnybh9UIeSIN7bUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NkM5z7jgF7WN0CfElQd/DQom6J2fFSfpfVluNzh3nUICp2gDFNvvfuvqBoANlz3tvGxStBphfxDE08A32tLySwWGQVXhohJRYSbLduWhDIxNeNaF3XmxckVnwJ8Uxe+AOxXNAranoYxHj9Ba0IJqK8okAbR1Y4qJ0s6Q+LShFdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=oZjV7se+; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9a0c40849cso95173966b.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 23:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1728887729; x=1729492529; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EzkqcrvTVaKqpqDByKdgad826mxzpVo//v8QIefMOL8=;
        b=oZjV7se+MygIvrpcqkj1fVVSQjt60aQ7CiM+JUr6kHJeTXlb/iAjysm2vlfAnsUODv
         lQx3ft0MZJOuumMJHSWgWYgu2qKemVeXb5PBoKx0/mrvAWh/8/RHSElFGesjriNh70u/
         JEhMNQUvWLseauVOt4/zVYhrr8/l+H82CwFK7hWjGh2d3L13a1/3gp8071MNALWj1kib
         o0o8dju8wb1zHeYuJttJ72tNQ7a/yimpjjnr+hFaOzy3XSaYFp+/QrURpE4J/wCW/N3S
         1zqTdxSuejztMbyv+DBcHhvpkqhnrWPyVa686DZxtBfW4ylStj5sDD+uRDRM2iGsvn4W
         CLSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728887729; x=1729492529;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EzkqcrvTVaKqpqDByKdgad826mxzpVo//v8QIefMOL8=;
        b=aALm5IKEVX+0vhXMB76NPdZ5iqyONsy+scEHhdNcfpdy8HJ39Y2b9e9eGzBIbXZf95
         A4k8bnxV/lTTJJ+tlOXMZ8ytjsHF+HBEC9cksyRiPmGcDDFUrRZy50OVxV+V0ZLNlWZr
         tf7cj6GoJvmV8Xpdw2tgPhHkesbrcad74VmQL3MDUPrg7+BHzovRFPozPJlABJb4QAxL
         Mx2EUL9Y/1ODCnRDo3lH/DP4wD/USyWp1DKg6WFWsfcqMHEybNEI3dcqxCCTUhFatOHL
         NpM+GPehdcAxExyLCs0sWtC+bvaX+eF3KekYF6byGISPNiDCd7m26Efs/tuAzzBe8cxZ
         bY6A==
X-Forwarded-Encrypted: i=1; AJvYcCUrDXbDi57Idxxp2uSYsB37571LEtD0ey00HNGqaR/FfYZMH6nsAbbpZZegLh1n7URpLimD9wHIodBR3HY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVLVoFH6FVrwBDK+HT+iQ3mT9V8IwX5DHUMG7ihHwGvVrvhGlv
	QcnCO2FH5viQ4uI/OyTUmGKHnJ8e4ElOorK41bTlo9rGNfdnD/yesGLor09XeEw=
X-Google-Smtp-Source: AGHT+IHtsfhY77d2hmhJ/UeBZXQQAahrdwUCAyfXzQzRvrPqdSAngDAVOM6fkmoaHNagJzIo6u/AkQ==
X-Received: by 2002:a17:907:d01:b0:a99:403e:2578 with SMTP id a640c23a62f3a-a99b9313475mr1017156666b.5.1728887728814;
        Sun, 13 Oct 2024 23:35:28 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99ee8da1besm278784766b.216.2024.10.13.23.35.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Oct 2024 23:35:28 -0700 (PDT)
Message-ID: <9f9f3cf0-7a78-40f1-b8d5-f06a2d428210@blackwall.org>
Date: Mon, 14 Oct 2024 09:35:26 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v1 net-next 00/12] bridge-fastpath and related
 improvements
To: Eric Woudstra <ericwouds@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, Roopa Prabhu <roopa@nvidia.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Frank Wunderlich <frank-w@public-files.de>,
 Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 bridge@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20241013185509.4430-1-ericwouds@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241013185509.4430-1-ericwouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/10/2024 21:54, Eric Woudstra wrote:
> This patchset makes it possible to set up a (hardware offloaded) fastpath
> for bridged interfaces.
> 

The subject and this sentence are misleading, you're talking about netfilter bridge
fastpath offload, please mention it in both places. When you just say bridge fast
path, I think of the software fast path.

> To set up the fastpath with offloading, add this extra flowtable:
> 
> table bridge filter {
>         flowtable fb {
>                 hook ingress priority filter
>                 devices = { lan0, lan1, lan2, lan3, lan4, wlan0, wlan1 }
>                 flags offload
>         }
>         chain forward {
>                 type filter hook forward priority filter; policy accept;
> 		ct state established flow add @fb
>         }
> }
> 
> Creating a separate fastpath for bridges.
> 
>          forward fastpath bypass
>  .----------------------------------------.
> /                                          \
> |                        IP - forwarding    |
> |                       /                \  v
> |                      /                  wan ...
> |                     /
> |                     |
> |                     |
> |                   brlan.1
> |                     |
> |    +-------------------------------+
> |    |           vlan 1              |
> |    |                               |
> |    |     brlan (vlan-filtering)    |
> |    +---------------+               |
> |    |  DSA-SWITCH   |               |
> |    |               |    vlan 1     |
> |    |               |      to       |
> |    |   vlan 1      |   untagged    |
> |    +---------------+---------------+
> .         /                   \
>  ------>lan0                 wlan1
>         .  ^                 ^
>         .  |                 |
>         .  \_________________/
>         .  bridge fastpath bypass
>         .
>         ^
>      vlan 1 tagged packets
> 
> To have the ability to handle xmit direct with outgoing encaps in the
> bridge fastpass bypass, we need to be able to handle them without going
> through vlan/pppoe devices. So I've applied, amended and squashed wenxu's
> patchset. This patch also makes it possible to egress from vlan-filtering
> brlan to lan0 with vlan tagged packets, if the bridge master port is doing
> the vlan tagging, instead of the vlan-device. Without this patch, this is
> not possible in the bridge-fastpath and also not in the forward-fastpath,
> as seen in the figure above.
> 
> There are also some more fixes for filling in the forward path. These
> fixes also apply to for the forward-fastpath. They include handling
> DEV_PATH_MTK_WDMA in nft_dev_path_info() and avoiding
> DEV_PATH_BR_VLAN_UNTAG_HW for bridges with ports that use dsa.
> 
> Conntrack bridge only tracks untagged and 802.1q. To make the bridge
> fastpath experience more similar to the forward fastpath experience,
> I've added double vlan, pppoe and pppoe-in-q tagged packets to bridge
> conntrack and to bridge filter chain.
> 
> Eric Woudstra (12):
>   netfilter: nf_flow_table_offload: Add nf_flow_encap_push() for xmit
>     direct
>   netfilter: bridge: Add conntrack double vlan and pppoe
>   netfilter: nft_chain_filter: Add bridge double vlan and pppoe
>   bridge: br_vlan_fill_forward_path_pvid: Add port to port
>   bridge: br_fill_forward_path add port to port
>   net: core: dev: Add dev_fill_bridge_path()
>   netfilter :nf_flow_table_offload: Add nf_flow_rule_bridge()
>   netfilter: nf_flow_table_inet: Add nf_flowtable_type flowtable_bridge
>   netfilter: nft_flow_offload: Add NFPROTO_BRIDGE to validate
>   netfilter: nft_flow_offload: Add DEV_PATH_MTK_WDMA to
>     nft_dev_path_info()
>   bridge: br_vlan_fill_forward_path_mode no _UNTAG_HW for dsa
>   netfilter: nft_flow_offload: Add bridgeflow to nft_flow_offload_eval()
> 
>  include/linux/netdevice.h                  |   2 +
>  include/net/netfilter/nf_flow_table.h      |   3 +
>  net/bridge/br_device.c                     |  20 ++-
>  net/bridge/br_private.h                    |   2 +
>  net/bridge/br_vlan.c                       |  24 +++-
>  net/bridge/netfilter/nf_conntrack_bridge.c |  86 ++++++++++--
>  net/core/dev.c                             |  77 +++++++++--
>  net/netfilter/nf_flow_table_inet.c         |  13 ++
>  net/netfilter/nf_flow_table_ip.c           |  96 ++++++++++++-
>  net/netfilter/nf_flow_table_offload.c      |  13 ++
>  net/netfilter/nft_chain_filter.c           |  20 ++-
>  net/netfilter/nft_flow_offload.c           | 154 +++++++++++++++++++--
>  12 files changed, 463 insertions(+), 47 deletions(-)
> 


