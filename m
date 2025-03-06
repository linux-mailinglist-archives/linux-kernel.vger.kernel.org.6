Return-Path: <linux-kernel+bounces-550007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B93A559D3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 23:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EE76177CBA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F4D27C84F;
	Thu,  6 Mar 2025 22:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KmPZuyvF"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE8927C840
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 22:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741300391; cv=none; b=Y+k0vOGp0sDR1OpGdVTqgNF6c+f9zxSwvgJSEadIHix2q+8XSFyz0cARBaXeiy0rS8B3m7YNoZ+nuYRwDtxl3qhTfy1ppwGJgIglQ3cRybue5EgaYEsgsCuuBODoyxmaLj+e9+QNiMTf/65q1Q3dZOTRiKvWskrY/Y4s1tMDfzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741300391; c=relaxed/simple;
	bh=WoE/ExMYkaH0wgUaPI7gKK9MlzU15elpkPjgeHxPstw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I9Lt70PfMonauZX/ULGy4pYvyPxfh+JqzM236G6o5PgiSrZGvKHDza5o3LFOLaP/I9XcZ0i6o9H7jcyqHwMhwsWS3MkZ92fOmREXx7+tp96s5q/s7LD3iMfvRgpOqVipEAwZsy7BznXDTnic//92nv2EGG2ogyZfbyM6Ho6C/SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KmPZuyvF; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d961af60-8e7f-4d72-9f22-a0ee8d2fac7e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741300377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mgr2lm5EtMWj/o+U9w65HzFCQeYJpsoaGBIN19NfQbc=;
	b=KmPZuyvFD+skPb7R6UwBBnY2vGGyGWNui4pxzxPVj2bE/1pvtZAfye0pofYBi8uWTdB30z
	+65YmmVL6Js9dYnJCb+OpTEzAzvst9LNbmuIHhawdvfbVlYkrcQeIqd+VlxoQdiKmVu8ba
	NqYCweiKe00Om4CQuYinAJAUOPz0wBg=
Date: Thu, 6 Mar 2025 14:32:17 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] selftests/bpf: Move test_lwt_ip_encap to test_progs
To: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Alexis Lothore <alexis.lothore@bootlin.com>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250304-lwt_ip-v1-1-8fdeb9e79a56@bootlin.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250304-lwt_ip-v1-1-8fdeb9e79a56@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/4/25 1:24 AM, Bastien Curutchet (eBPF Foundation) wrote:
> +int remove_routes_to_gredev(const char *ns1, const char *ns2, const char *vrf)
> +{
> +	SYS(fail, "ip -n %s route del %s dev veth5 %s", ns1, IP4_ADDR_GRE, vrf);
> +	SYS(fail, "ip -n %s route del %s dev veth7 %s", ns2, IP4_ADDR_GRE, vrf);
> +	SYS(fail, "ip -n %s -6 route del %s/128 dev veth5 %s", ns1, IP6_ADDR_GRE, vrf);
> +	SYS(fail, "ip -n %s -6 route del %s/128 dev veth7 %s", ns2, IP6_ADDR_GRE, vrf);
> +
> +	return 0;
> +fail:
> +	return -1;
> +}
> +
> +int add_unreachable_routes_to_gredev(const char *ns1, const char *ns2, const char *vrf)
> +{
> +	SYS(fail, "ip -n %s route add unreachable %s/32 %s", ns1, IP4_ADDR_GRE, vrf);
> +	SYS(fail, "ip -n %s route add unreachable %s/32 %s", ns2, IP4_ADDR_GRE, vrf);
> +	SYS(fail, "ip -n %s -6 route add unreachable %s/128 %s", ns1, IP6_ADDR_GRE, vrf);
> +	SYS(fail, "ip -n %s -6 route add unreachable %s/128 %s", ns2, IP6_ADDR_GRE, vrf);
> +
> +	return 0;
> +fail:
> +	return -1;
> +}

Added static to these two functions and applied. Thanks.

