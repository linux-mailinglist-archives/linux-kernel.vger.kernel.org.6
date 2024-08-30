Return-Path: <linux-kernel+bounces-309242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AF09667FE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 19:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE2551F23CA3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AD91BA895;
	Fri, 30 Aug 2024 17:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="faAXWKYY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE7B1B29B1
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 17:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725039081; cv=none; b=D1/os+yeiua0LhIvePu8Is5GXgasnqWYQDB99OKTp+XU4HBUF67jyb3Ecqoj/3oFJwirLCUzA4cQcRrhTbdZTJsC5zvNgVAYkc1XFO1L+nz2nlTKwdYqAX4foewiCDccvXt1TEZo3t6N5G88mMTt7XaCxG3a/gnn2ykv9OFEX5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725039081; c=relaxed/simple;
	bh=4wMHNwCtaPFft49lEGMOQE4AbYYOyvnWD8+57PFng3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IzW9hswCBFtLg+7Y2mp/bEsXTza6EP8H5FUqKrIoM+zB2qYsKz8vyso8K1EYn1p+LQ9wpUsMgjOboKowujXiKteVRuQmq7MsXkoomXzIUg0Nfv+WnEJ97r42kGvRdNiDnalQvm6at24HG3BUkQiNcsY4siAzall2lK555iuZtXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=faAXWKYY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F6DC4CEC2;
	Fri, 30 Aug 2024 17:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725039081;
	bh=4wMHNwCtaPFft49lEGMOQE4AbYYOyvnWD8+57PFng3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=faAXWKYYoqWysidx+oTAJjWIF1p2Zou3IQgE6hq+PCVbnqOY1Wg5+Qkqd5nzGuIkr
	 ZZmOWEexnC1JZoYdUisOrk+Im3tzl3GVgyxOenyoTm1TiTNee4Rr/x8C/Ozif4+Vi3
	 CMtcxSjTqNKJ6VZEf05RnnUVleXH6APnIInCKIykiToQPeEnH+F8+bd0J7u9yQ6fPR
	 HIhFUv4ixHt9AwFvsLzIJKsX8oXjzcTluicnnDno4LlIDnHmdGIJdjzAPVeTUQiFz9
	 pOo+b3dw5qNeiSskIvavzdfncJUxJ6fTQb2/6RsSYOoWkVqHxrj6qWBif1wjyLepD/
	 JWLpThPA4NZcg==
Date: Fri, 30 Aug 2024 07:31:20 -1000
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: kernel-team@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-6.12] sched_ext: Implement
 scx_bpf_dispatch[_vtime]_from_dsq()
Message-ID: <ZtIB6ChJYXaL6OLI@slm.duckdns.org>
References: <20240830110415.116090-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830110415.116090-1-tj@kernel.org>

On Fri, Aug 30, 2024 at 01:03:44AM -1000, Tejun Heo wrote:
> This patchset is on top of:
> 
>    sched_ext/for-6.12 bf934bed5e2f ("sched_ext: Add missing cfi stub for ops.tick")
>  + two fix patches (http://lkml.kernel.org/r/ZtGkPKgoE5BeI7fN@slm.duckdns.org)

Oops, it also needs

  + bpf/for-next 6af48162ac09 ("Merge branch 'bpf-next/net' into bpf-next/for-next")

to allows passing in BPF iterator into kfuncs.

Thanks.

-- 
tejun

