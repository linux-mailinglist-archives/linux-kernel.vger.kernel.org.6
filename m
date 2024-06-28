Return-Path: <linux-kernel+bounces-234437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AA491C6A7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5426283EFB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 19:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE3C7605E;
	Fri, 28 Jun 2024 19:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y1CdCjS/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1856F2EA
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 19:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719603223; cv=none; b=bGO4dSTOylQcwukquX/eAULFV2jCNibc70mdqKHNp5ET3J4gIBPSUTAkxVgydd8+aUJE8ZSvuEfxIthDGI7hAq5D728uOAlZPNRimp6UCik5WvjJfFXRRd2YtwciG75ZIC0GvqRz3Mi8HJIH1AfTpK1oKJ1kQtJzyJ2Ph7jBgnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719603223; c=relaxed/simple;
	bh=qK9h3cJfKNVlGVyx51CGtvItS0lyTX775GcG56xAGf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h6+0Eu4IBagTkLuUJjc7YWpF03yJaPVWGUUzAslmKMfZf/Mn8Hwn132nTt3U523JOHtFRTMZxxtR9UnzD/aA+ywkHVSCaYprRHACNczrlWCLLCPFNTpTRyhapdIvs85wS29r638h1MD33Df2bWTBTb8tUJg28jjZhVA/O9JLsXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y1CdCjS/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719603220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Jw+4/MGPEMBHjRaPGO+Qwu+I6PYVcysMbY2NNFoAjg=;
	b=Y1CdCjS/byT7NjrurCorHaXCrNnTEi5LjPqXtRyZ3yUG2xGL7Jn9vlqxzC3apwDQrP3nx2
	MYCWhKvYwjYqb5qFqVcp3NXJJ6UsOKRlS6BMp6DVf1M74C9OLbwAb5DwYAhXYNoTsp3fP1
	d6mkt3IvjK1XhGriOtriTzltBQcMtx8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-jiiNkMiBPruF9a3De78H1g-1; Fri,
 28 Jun 2024 15:33:36 -0400
X-MC-Unique: jiiNkMiBPruF9a3De78H1g-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7A0591956058;
	Fri, 28 Jun 2024 19:33:35 +0000 (UTC)
Received: from [10.22.33.36] (unknown [10.22.33.36])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1A4A019773D8;
	Fri, 28 Jun 2024 19:33:33 +0000 (UTC)
Message-ID: <c9d2c56c-097d-43f8-ac87-54b1dffbc863@redhat.com>
Date: Fri, 28 Jun 2024 15:33:33 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] locking/ww_mutex/test: Use swap() macro
To: Thorsten Blum <thorsten.blum@toblux.com>, peterz@infradead.org,
 mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
Cc: linux-kernel@vger.kernel.org
References: <20240628192900.542196-2-thorsten.blum@toblux.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240628192900.542196-2-thorsten.blum@toblux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 6/28/24 15:29, Thorsten Blum wrote:
> Fixes the following Coccinelle/coccicheck warning reported by
> swap.cocci:
>
>    WARNING opportunity for swap()
>
> Compile-tested only.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
>   kernel/locking/test-ww_mutex.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
> index 78719e1ef1b1..252bef786aef 100644
> --- a/kernel/locking/test-ww_mutex.c
> +++ b/kernel/locking/test-ww_mutex.c
> @@ -402,7 +402,7 @@ static inline u32 prandom_u32_below(u32 ceil)
>   static int *get_random_order(int count)
>   {
>   	int *order;
> -	int n, r, tmp;
> +	int n, r;
>   
>   	order = kmalloc_array(count, sizeof(*order), GFP_KERNEL);
>   	if (!order)
> @@ -413,11 +413,8 @@ static int *get_random_order(int count)
>   
>   	for (n = count - 1; n > 1; n--) {
>   		r = prandom_u32_below(n + 1);
> -		if (r != n) {
> -			tmp = order[n];
> -			order[n] = order[r];
> -			order[r] = tmp;
> -		}
> +		if (r != n)
> +			swap(order[n], order[r]);
>   	}
>   
>   	return order;
Acked-by: Waiman Long <longman@redhat.com>


