Return-Path: <linux-kernel+bounces-532622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C23A4500B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A1B53A3E25
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9CC42AA5;
	Tue, 25 Feb 2025 22:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="g0TQOcSj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A454A216397
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 22:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740522319; cv=none; b=UC7Vu0I4K/6UO1ze8TisP0K6Q30WD3rIQ/vFLxa3n/3KawjdP2cMn/siidAnrweS1iHHrvcAO15iPQFJWlHysm8f0bi1/31CrdELAyJddq49g25abD1oLtLS71nOCrWfpWhqd6zfuA3jNcF9R+916RMo9//DvVsqIYVUjf1kVDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740522319; c=relaxed/simple;
	bh=JRRIyL/a8aKLFOTghHkEIPXLTSsyoiuu3QpBGEuplCk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=a7HMbFEwdX06VyJW0p3DiEzRm9oML998/oPxNZ2pvz5/Ci4aJx8eh8ccT4VIVaIpFwDvSI03Ils9OomRGx5V1LHZ00nO2IzdyUafvLwWYl+s6G2YYfa/YON6xgoD3iIhbsbloVkzadRCgVUQgPQybMGjhiFV63WKLXdDideZ/zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=g0TQOcSj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D55BDC4CEDD;
	Tue, 25 Feb 2025 22:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1740522319;
	bh=JRRIyL/a8aKLFOTghHkEIPXLTSsyoiuu3QpBGEuplCk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g0TQOcSjhXD9ZJQukKEuy4NVggJB8op/0g0BwzfrobcLbBJRt9WoeX8ynSRBSZxDq
	 dNHrRuwlSWPcRQcQ9h8j6Iq+GMcfKCpQ3pu052kHh/RhgwqmYakMf5wj0clzfTrpAE
	 +kbZl08NIWQxoNjVOQFr4qKefcIMTjaWmQhayZ2k=
Date: Tue, 25 Feb 2025 14:25:18 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: hannes@cmpxchg.org, yosryahmed@google.com, chengming.zhou@linux.dev,
 linux-mm@kvack.org, kernel-team@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zswap: do not crash the kernel on decompression failure
Message-Id: <20250225142518.cec35a0ea77a0d86f3e860c3@linux-foundation.org>
In-Reply-To: <20250225213200.729056-1-nphamcs@gmail.com>
References: <20250225213200.729056-1-nphamcs@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Feb 2025 13:32:00 -0800 Nhat Pham <nphamcs@gmail.com> wrote:

> @@ -984,12 +987,19 @@ static void zswap_decompress(struct zswap_entry *entry, struct folio *folio)
>  	sg_init_table(&output, 1);
>  	sg_set_folio(&output, folio, PAGE_SIZE, 0);
>  	acomp_request_set_params(acomp_ctx->req, &input, &output, entry->length, PAGE_SIZE);
> -	BUG_ON(crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait));
> -	BUG_ON(acomp_ctx->req->dlen != PAGE_SIZE);
> +	if (crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait) ||
> +			acomp_ctx->req->dlen != PAGE_SIZE) {
> +		ret = false;
> +		zswap_reject_decompress_fail++;
> +		pr_alert_ratelimited(
> +			"decompression failed on zswap entry with offset %08lx\n",
> +			entry->swpentry.val);
> +	}
>  	mutex_unlock(&acomp_ctx->mutex);

This mutex_unlock() isn't present in current kernels.  I'd normally just fix
the reject but a change in the locking environment needs some careful
checking and retesting, please.

