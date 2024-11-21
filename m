Return-Path: <linux-kernel+bounces-416763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 228249D49DA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 10:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A96601F217FC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 09:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DED1CB333;
	Thu, 21 Nov 2024 09:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bLQEQ28Q"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4259314A62A
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 09:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732180962; cv=none; b=hul+mNrVzD4c8EwifyE6h6mn3OiQkK37w//QYwqhLwlnAvDQQJbiMLb+VbQM+sT+EuAR0Gw4Yf8TErUHsr4iLfK4d8mSu42jUNxCDvYlPQopLp+52sbWt4RJgxZIj9hqMVTzBG68UopdKF0PlW+SOr35sDnPTqsukNftm/5ogvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732180962; c=relaxed/simple;
	bh=QUILc50Xdy1CTE1OVoUVFGHKtj2Tn318wiiJgHe1TsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IPZROpeQYq/aBrPAHN6ead/Zo/8+e7LnhsJfBpbHanBa4n3FAMfbUPNkpDp3q5ojtQzr6gx0R30uGxOsNTBdWavouRjYbb4D1I+FGSVD216uN59MFnJ6wHD4imRBldmEvx+QuNZDUMzTBMu6rRIcsFKvgFVrSMtWGUvK4aShn+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bLQEQ28Q; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ea527ae14aso565510a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 01:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1732180959; x=1732785759; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=anCiwarguAnNIpfIhufEwHUzRdLPbg004JR1jBpxyR0=;
        b=bLQEQ28Q06VZ/8r8bYX+WVNeszJY7Si3pbcRpSRJuipA3qRFzkevl+L2SG85LTo0Rb
         qdPtp+Zhji020iOoypLoapggCGpTmYRcaPPScR1F7BPmdKe5YWqPCDywnqwIHhaSSq3R
         HlaFAMFMHoX79hxkd7+8vKK4Ky6DKWRvwd1I68X2qJjXq9PiawAqAoDGuQZyOTzUtvAR
         SIPz/Elr9+jls53Qslov72kqgbLkOXKkMn9p/ElX0hJwXUfZjjuktJpjJ8e2yNVPD/PL
         wNdThC2qYPU6A9Ez1DaSvplTZuNEsd09ZZH6eTk+Ilmfh9CULxbu30IOx2NKLHg7n0rl
         8zIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732180959; x=1732785759;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=anCiwarguAnNIpfIhufEwHUzRdLPbg004JR1jBpxyR0=;
        b=da101yn2Al9k6viwyG+sYIVjOFwb1CJ6giGsXFHmSbtfF/EhLl+u2p1fpJupR0+pS3
         gFZ+S/SyM1Y6v3mENvufWdUnnsc3JPNiAdGbLUJSoOIr8Y9a+7enAJo3RZUrqNe9NYqg
         uX2wTDhfB8W2K2JME5fFh0VDy/eO7SjJNeZR5yzwV6BFJlYJ/LCx/1ZDXjaW6nK4P5m3
         /yhC99oABXnQQkPwRDcvii6VjnO75P7iExGTagwsq+BWxALhebsDNHowXTqiD+byxzWH
         02ww1YUPydRsSiazlAo+BYUrTQVcKPGDEmaVK3WlRNMtUju/MKVQf+hOHI8GNwtk/hYN
         Zr0w==
X-Forwarded-Encrypted: i=1; AJvYcCVK4ZKGBg+XElA0QVnwyuMRHrxxVNnbAWcNo4826XVpqmf7Uc69ha3qAmo/4RqYuYquHmuD09XXtPVtp5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbjjeuDbUeQIefj3qDqidU+sNiNZ2KER/jlgCHZfs+qHYDhJEZ
	gmSxbaR/IY7E+AitstrDIFioK4nbnGF2ezCd1Fvmfm/KoG4hpjS50YeVj1XThuo=
X-Gm-Gg: ASbGnct2gNyVxMH0loKC5HxF+1BYWd7JMQ+OxqaQprkM4nOJ/g4nN2WYFzGtJL+OYLE
	1G/SCs2CwnU81/FiUiGMbFw2xAqkxpLQNIcf9e0fxMXCOyhzBVRbOgn7eRDja421b7/83qBOetD
	adIYUmmno1yn+anJHd0B7htLc9dw0i4GFTZ4PaYctJ7lfHyn6sq6U2xSvGXokIRl/eSEyESjfRW
	SN2XI8N3PQJj+soB8acOPWtBYGUJ8yspTpGBxun7Xe2dKZzBvqHVmSdx6x+pS6lNOVxzg==
X-Google-Smtp-Source: AGHT+IEEgyub4D8pczAfSXSyb/ES+28tnM7y4Fab6MwH/eRQtc4XQ4qLQSQ4lnr8f56exnSAmz12ZA==
X-Received: by 2002:a17:90b:4ad2:b0:2ea:5c01:c1a4 with SMTP id 98e67ed59e1d1-2eaca744872mr7191755a91.20.1732180959540;
        Thu, 21 Nov 2024 01:22:39 -0800 (PST)
Received: from [10.67.174.193] ([61.213.176.12])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ead0392f0asm2717995a91.43.2024.11.21.01.22.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 01:22:39 -0800 (PST)
Message-ID: <b044faad-1e3f-4c65-b2e6-fc418aebd22e@bytedance.com>
Date: Thu, 21 Nov 2024 17:22:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] RDMA/core: Fix IPv6 loopback dst MAC address lookup logic
To: jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241110123532.37831-1-yuezelong@bytedance.com>
From: Zelong Yue <yuezelong@bytedance.com>
In-Reply-To: <20241110123532.37831-1-yuezelong@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Gently ping. Do I need to provide more detailed information on how to 
reproduce the issue?

On 11/10/24 8:35 PM, yuezelong wrote:
> Imagine we have two RNICs on a single machine, named eth1 and eth2, with
>
> - IPv4 addresses: 192.168.1.2, 192.168.1.3
> - IPv6 addresses (scope global): fdbd::beef:2, fdbd::beef:3
> - MAC addresses: 11:11:11:11:11:02, 11:11:11:11:11:03,
>
> they all connnected to a gateway with MAC address 22:22:22:22:22:02.
>
> If we want to setup connections between these two RNICs, with RC QP, we
> would go through `rdma_resolve_ip` for looking up dst MAC addresses. The
> procedure it's the same as using command
>
> `ip route get dst_addr from src_addr oif src_dev`
>
> In IPv4 scenario, you would likely get
>
> ```
> $ ip route get 192.168.1.2 from 192.168.1.3 oif eth2
>
> 192.168.1.2 from 192.168.1.3 via 192.168.1.1 dev eth2 ...
> ```
>
> Looks reasonable as it would go through the gateway.
>
> But in IPv6 scenario, you would likely get
>
> ```
> $ ip route get fdbd::beef:2 from fdbd::beef:3 oif eth2
>
> local fdbd::beef:2 from fdbd::beed:3 dev lo table local proto kernel src fdbd::beef:2 metric 0 pref medium
> ```
>
> This would lead to the RDMA route lookup procedure filling the dst MAC
> address with src net device's MAC address (11:11:11:11:11:03),  but
> filling the dst IP address with dst net device's IPv6 address
> (fdbd::beef:2), src net device would drop this packet, and we would fail
> to setup the connection.
>
> To make setting up loopback connections like this possible, we need to
> send packets to the gateway and let the gateway send it back (actually,
> the IPv4 lookup result would lead to this, so there is no problem in IPv4
> scenario), so we need to adjust current lookup procedure, if we find out
> the src device and dst device is on the same machine (same namespace),
> we need to send the packets to the gateway instead of the src device
> itself.
>
> Signed-off-by: yuezelong <yuezelong@bytedance.com>
> ---
>   drivers/infiniband/core/addr.c | 95 +++++++++++++++++++++++++++++++++-
>   drivers/infiniband/core/cma.c  |  7 ++-
>   2 files changed, 99 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
> index c4cf26f1d149..d194e6b7f2b9 100644
> --- a/drivers/infiniband/core/addr.c
> +++ b/drivers/infiniband/core/addr.c
> @@ -545,6 +545,29 @@ static void rdma_addr_set_net_defaults(struct rdma_dev_addr *addr)
>   	addr->bound_dev_if = 0;
>   }
>   
> +static struct dst_entry *get_default_ipv6_route(struct in6_addr *src_addr, struct net_device *dev)
> +{
> +	struct flowi6 fl6;
> +	struct dst_entry *dst = NULL;
> +
> +	memset(&fl6, 0, sizeof(fl6));
> +	fl6.flowi6_iif = dev_net(dev)->loopback_dev->ifindex;
> +	fl6.flowi6_oif = dev->ifindex;
> +	fl6.saddr = *src_addr;
> +	fl6.daddr = in6addr_any;
> +
> +	dst = ipv6_stub->ipv6_dst_lookup_flow(dev_net(dev), NULL, &fl6, NULL);
> +	if (IS_ERR(dst))
> +		return NULL;
> +
> +	if (dst && dst->error) {
> +		dst_release(dst);
> +		return NULL;
> +	}
> +
> +	return dst;
> +}
> +
>   static int addr_resolve(struct sockaddr *src_in,
>   			const struct sockaddr *dst_in,
>   			struct rdma_dev_addr *addr,
> @@ -597,9 +620,77 @@ static int addr_resolve(struct sockaddr *src_in,
>   	 * Resolve neighbor destination address if requested and
>   	 * only if src addr translation didn't fail.
>   	 */
> -	if (!ret && resolve_neigh)
> -		ret = addr_resolve_neigh(dst, dst_in, addr, ndev_flags, seq);
> +	if (!ret && resolve_neigh) {
> +		if ((src_in->sa_family == AF_INET6) && (ndev_flags & IFF_LOOPBACK)) {
> +			rcu_read_lock();
> +			/*
> +			 * When src net device and dst net device is different device,
> +			 * traditional TCP/IP loopback won't work for RDMA. We need to find
> +			 * gateway for src net device and send packets to the gateway, then
> +			 * let the gateway send it back to the dst device. This is likely
> +			 * be problematic in IPv6 scenario, the route logic would likely fill
> +			 * the dst MAC address with src net device's MAC, but with dst IP
> +			 * belongs to the dst net device, leading to packet drop.
> +			 *
> +			 * Thus, we need to figure out gateway's MAC address in IPv6 loopback
> +			 * scenario.
> +			 */
> +			struct net_device *ndev = READ_ONCE(dst->dev);
> +			struct net_device *src_ndev = rdma_find_ndev_for_src_ip_rcu(dev_net(ndev),
> +										    src_in);
> +			struct net_device *dst_ndev = rdma_find_ndev_for_src_ip_rcu(dev_net(ndev),
> +										    dst_in);
> +
> +			if (IS_ERR(src_ndev) || IS_ERR(dst_ndev)) {
> +				ret = -ENODEV;
> +				rcu_read_unlock();
> +				goto exit;
> +			}
> +
> +			if (src_ndev != dst_ndev) {
> +				dst_release(dst);
> +				dst = get_default_ipv6_route((struct in6_addr *)src_in->sa_data,
> +							     src_ndev);
> +				ndev_flags = src_ndev->flags;
> +			} else {
> +				rcu_read_unlock();
> +				/*
> +				 * For real loopback (src and dst is the same device), we can
> +				 * just use the original code path.
> +				 */
> +				ret = addr_resolve_neigh(dst, dst_in, addr, ndev_flags, seq);
> +				goto exit;
> +			}
> +			rcu_read_unlock();
> +
> +			if (dst == NULL) {
> +				ret = -EINVAL;
> +				goto done;
> +			}
> +
> +			/*
> +			 * Though we fill `in6addr_any` as dst addr here, `xfrm_neigh_lookup`
> +			 * would still find nexthop for us, which provides gateway MAC address.
> +			 */
> +			struct sockaddr_in6 addr_in = {
> +				.sin6_family = AF_INET6,
> +				.sin6_addr = in6addr_any,
> +			};
> +			const void *daddr = (const void *)&addr_in.sin6_addr;
> +
> +			might_sleep();
> +
> +			/*
> +			 * Use `addr_resolve_neigh` here would go into `ib_nl_fetch_ha` branch,
> +			 * which would fail because of `rdma_nl_chk_listeners` returns error.
> +			 */
> +			ret = dst_fetch_ha(dst, addr, daddr);
> +		} else {
> +			ret = addr_resolve_neigh(dst, dst_in, addr, ndev_flags, seq);
> +		}
> +	}
>   
> +exit:
>   	if (src_in->sa_family == AF_INET)
>   		ip_rt_put(rt);
>   	else
> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> index 64ace0b968f0..744f396568cd 100644
> --- a/drivers/infiniband/core/cma.c
> +++ b/drivers/infiniband/core/cma.c
> @@ -1612,7 +1612,12 @@ static bool validate_ipv6_net_dev(struct net_device *net_dev,
>   	if (!rt)
>   		return false;
>   
> -	ret = rt->rt6i_idev->dev == net_dev;
> +	if (rt->rt6i_flags & (RTF_LOCAL | RTF_NONEXTHOP)) {
> +		// TODO: how to validate netdev when the device is loopback?
> +		ret = true;
> +	} else {
> +		ret = rt->rt6i_idev->dev == net_dev;
> +	}
>   	ip6_rt_put(rt);
>   
>   	return ret;

