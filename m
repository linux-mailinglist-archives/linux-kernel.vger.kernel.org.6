Return-Path: <linux-kernel+bounces-539299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F41DA4A30E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F778188837B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4C9230BE2;
	Fri, 28 Feb 2025 19:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qKIFCgZm"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E57F1C1F20
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 19:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772230; cv=none; b=GXeZwTqyh+Xlas/DuLPND6z05sjpoDb9koP1Lkd4Z8eYbJemWwEoqYnduob1UE/CihuGrIotcTVkiOBadaIcVtRPQ+QpIRnBO0tS9tWYiwUNbd9ekZEz/9evmpJ4ZoaS5ZYD5xg5tKFOS3hyLUtjcueRJ5+q+FT4UEXh0r7JB8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772230; c=relaxed/simple;
	bh=H+/rFxlMCRXtsUIXaqplXnOl3vhpfrKqlr5qeT3CSQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P4eZOLktNlvCXkVyybOa/CjxnThA8HKQiWY+pg/IhvRoVoKOg89+NoseiGLpbCkkaO4E8D7yE+FfcKwnu0NDmaDtIu4BtEM65+P3mvWQ2wuaIIsaM+oOITV2nyHlAbwNEndxZggSMfOyf1rxrPi6EL44KcBuXiY4xQgVEavUIEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qKIFCgZm; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <090ede76-0c9f-4297-9d5a-7b75aa20ca27@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740772226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z8JhYOSrQ/mtuWZBihElqgcYA53A3WApd7koMNxDy5g=;
	b=qKIFCgZmtfTeuqOKGKfZhCOqVjRJ5xsU8AOpsmyyumpPJnjQqE0131CpgZ2Eyt1ICUppFL
	jH9T7RIap2aSjAMWb+Tm1X+GHIQRg6/GGN1JSsFTYYVgLsiHhrRPvArj3G/L9fYhDX8Ji+
	eyYifs2mRReSEU+lG94ExWpX6Dbom/s=
Date: Fri, 28 Feb 2025 11:49:03 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 2/6] net: tun: enable transfer of XDP metadata
 to skb
To: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, hawk@kernel.org, Willem de Bruijn <willemb@google.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20250227142330.1605996-1-marcus.wichelmann@hetzner-cloud.de>
 <20250227142330.1605996-3-marcus.wichelmann@hetzner-cloud.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250227142330.1605996-3-marcus.wichelmann@hetzner-cloud.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/27/25 6:23 AM, Marcus Wichelmann wrote:
> When the XDP metadata area was used, it is expected that the same
> metadata can also be accessed from TC, as can be read in the description
> of the bpf_xdp_adjust_meta helper function. In the tun driver, this was
> not yet implemented.
> 
> To make this work, the skb that is being built on XDP_PASS should know
> of the current size of the metadata area. This is ensured by adding
> calls to skb_metadata_set. For the tun_xdp_one code path, an additional
> check is necessary to handle the case where the externally initialized
> xdp_buff has no metadata support (xdp->data_meta == xdp->data + 1).
> 
> More information about this feature can be found in the commit message
> of commit de8f3a83b0a0 ("bpf: add meta pointer for direct access").
> > Signed-off-by: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> ---
>   drivers/net/tun.c | 25 ++++++++++++++++++++++---
>   1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 4ec8fbd93c8d..70208b3a2e93 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c

The changes have conflicts with the commit 2506251e81d1 ("tun: Decouple vnet handling").

It is better to rebase the works onto the bpf-next/net,
i.e. the "net" branch instead of the "master" branch.



