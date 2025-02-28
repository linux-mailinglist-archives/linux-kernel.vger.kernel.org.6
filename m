Return-Path: <linux-kernel+bounces-539399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3CCA4A3BB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BCF0883112
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD1827D78E;
	Fri, 28 Feb 2025 20:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Iee3yVRM"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59FB270EC9
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 20:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740773319; cv=none; b=jhoy5gLSGXmveAACutI12jirYhTDrxSaaNApBhTRiWe8wiGNGfzDo1rJix0kGF4eQjRD8KX8WG+MzIWTIRCa9jn2nnaZ8FRFWfODBMLQcePabOqyZg2/sKdH03Vb3XjDbqJDdE1i3cJ4p6tuKBRVELgoUE0OsTDEZJQxncNG0ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740773319; c=relaxed/simple;
	bh=dN5erVEOdVNv3oiWJXPSnonCC/q7xzUNqwNCyBAEI3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WA5PZu3LSv/YvWqlSkUhmQhRUWfYAH89DDYDRNMheuyUjQaf/Nk9pah9V7p1QR29uLDqiWdQeaAnGr2hpXEmAZ3vyqi9XMLnYLsUI48Imy54K0csYLPlOyRP21JFKHquto6v5Y16hwHg4uFnyLN6o7nJCqozYJE9MaGj1C5w+TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Iee3yVRM; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5ef054b4-3340-4b0e-9ba6-7b7409f9eb71@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740773305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AUG1i0ZL+wix5b2+TFEt5FV9JDKNxVcCuHH6kCyEvFM=;
	b=Iee3yVRM9G4Kqlw+8+wbdMX2GaTOnlnea8Slk0svUu1qmw1YouBr6SZsANz4314sMTIoTp
	9dEbz6DBjunvK69It02uhBvXu3ni7oBeseTGcz6qj6mZTYEAuUTXeSEPQZuFI0ypRhHFC6
	ksjX9h/XWWy6RwsiOVhMoZ10MPzgJYQ=
Date: Fri, 28 Feb 2025 12:08:18 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 0/2] Introduced to support the ULP to get or
 set sockets
To: zhangmingyi <zhangmingyi5@huawei.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, song@kernel.org,
 yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, yanan@huawei.com, wuchangye@huawei.com,
 xiesongyang@huawei.com, liuxin350@huawei.com, liwei883@huawei.com,
 tianmuyang@huawei.com, Network Development <netdev@vger.kernel.org>
References: <20250228085340.3219391-1-zhangmingyi5@huawei.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250228085340.3219391-1-zhangmingyi5@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/28/25 12:53 AM, zhangmingyi wrote:
> From: Mingyi Zhang <zhangmingyi5@huawei.com>
> 
> We want call bpf_setsockopt to replace the kernel module in the TCP_ULP
> case. The purpose is to customize the behavior in connect and sendmsg
> after the user-defined ko file is loaded. We have an open source
> community project kmesh (kmesh.net). Based on this, we refer to some
> processes of tcp fastopen to implement delayed connet and perform HTTP
> DNAT when sendmsg.In this case, we need to parse HTTP packets in the
> bpf program and set TCP_ULP for the specified socket.
> 
> Note that tcp_getsockopt and tcp_setsockopt support TCP_ULP, while
> bpf_getsockopt and bpf_setsockopt do not support TCP_ULP.
> I'm not sure why there is such a difference, but I noticed that
> tcp_setsockopt is called in bpf_setsockopt.I think we can add the
> handling of this case.

Please stop sending multiple new versions while the earlier raised questions
still have not been replied [1]. Also, netdev is still not cc-ed.

[1]: https://lore.kernel.org/all/44668201-cf8b-49c1-9dd0-90e0e5a95457@linux.dev/

pw-bot: cr

