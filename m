Return-Path: <linux-kernel+bounces-447927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A699F38BF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5808916A378
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5A72063C5;
	Mon, 16 Dec 2024 18:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pzbf2BZg"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226A520626B
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 18:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734373145; cv=none; b=cky2DPUpdWQqIhaZ1DX4O09gkhPet0BT7IjPw3Dlull1S/I5iAbct5jVE8qB98R3ic0Nkw3pny5TXGDnVYOhqVWsyR8vj/DBCEgKATfdobtnl9wvbwuC7KoV0pWcc5vXkUiYC+QU0SX4azYJpmDuEqUOpkYrz2aPx3Xl0aO96bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734373145; c=relaxed/simple;
	bh=XeADyxpmxvEtydFIGRMY2qnAnOg/81ED90oQ6Jejlz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pcxkEreJ1hRNZoUObr1niwgSEYjTaTSWa7QjwZKxGS/SsEEqdZErBvI/3geZjM2JtacicYWFxBd79atPw8MStlcEXVQPpamnpRK3FkwmA7mhBILJbjLuwWw/XgN31/rWV1XaJyQFuqVkZT2yPL76pwB4ffDJlnSasrLF/g0+mIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pzbf2BZg; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4ed0fa29-dd37-4a7e-8ba6-c84af9d735d6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734373140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hx9bZkqjNfX4MWYa0iqLCx36co82y3p1t4Gc07zmj2k=;
	b=pzbf2BZg2GMFupJ4xWvqp0O6robV7hOTxw+PkeddgVQtAmxaX7aphfY0Epcktr5oIEm/Ta
	/99rQ1hfQTfwnGGLp6yOz12wDh9CYk8vdY2HtKnGUFDtLxcOhkZqR9a07EZRKC0Am1OxSo
	nlJZc7OIhUKYMGeC9dnNg3ovO4r6gOw=
Date: Mon, 16 Dec 2024 10:18:45 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 2/5] bpf: tcp: Mark bpf_load_hdr_opt() arg2 as
 read-write
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: pabeni@redhat.com, kuba@kernel.org, andrii@kernel.org, ast@kernel.org,
 edumazet@google.com, memxor@gmail.com, davem@davemloft.net,
 daniel@iogearbox.net, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, horms@kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1734045451.git.dxu@dxuuu.xyz>
 <3de5c7e513e3161e040ee0ad6eb8cc4b7d71aa4c.1734045451.git.dxu@dxuuu.xyz>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <3de5c7e513e3161e040ee0ad6eb8cc4b7d71aa4c.1734045451.git.dxu@dxuuu.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/12/24 3:22 PM, Daniel Xu wrote:
> MEM_WRITE attribute is defined as: "Non-presence of MEM_WRITE means that
> MEM is only being read". bpf_load_hdr_opt() both reads and writes from
> its arg2 - void *search_res.
> 
> This matters a lot for the next commit where we more precisely track
> stack accesses. Without this annotation, the verifier will make false
> assumptions about the contents of memory written to by helpers and
> possibly prune valid branches.

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>


