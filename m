Return-Path: <linux-kernel+bounces-324123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C52E974822
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 04:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFC97287ACA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 02:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91422CCB4;
	Wed, 11 Sep 2024 02:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drH/MAEe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367FF2AF11
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 02:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726020802; cv=none; b=PYmSdhTqAS3poa/GKdnNUVve7WGbM9DbgeaIJyzN5SfSaIHs/cJb7R89hWFZa8b4T23qEgqspBfypDGQea3LJw9ltOFknaZjR7wAGf/wGoHcH88jJhAt0O/72DtXYrQ8Zppb6NZlJx177GpHKb+2LPsvhK4j2WxAPERp4PMgwlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726020802; c=relaxed/simple;
	bh=7C330WHM1h3otPTiJzP6prlQsfXkoroqppbhylWrFKQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uJgEinHPRTVBsN4JPJSrtRlfUmOjpYaWmdpY/lr8KVefSQBlpDagwgvhnZ+KwgajHsDzkZqKNL+8a13gVx6mpRFx1JO3wgH0HumXsIGGkV8JmHFAZhZEtBmoq4cKpKa9Gaf6V2R9w4PbFwQYTikdj6I2QTZXnl/dI9tNbFH2WJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drH/MAEe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D355BC4CEC3;
	Wed, 11 Sep 2024 02:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726020801;
	bh=7C330WHM1h3otPTiJzP6prlQsfXkoroqppbhylWrFKQ=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=drH/MAEeUkyvj67TxLA0XKDvm3rj/9gLNAfOHw2fhY3l1gBmnIFh5mufh3QWqXz9W
	 AXivJMfvGheKuS3fn+yEWsUdwr5sDwrohm55nJy7h0SrR5j9+FrcrZ4YRnU57s5Uhq
	 Qed+nxSxEb1JFeZcSuon/nq3tDCpl24zhZ1OEDjc+1UbwEg33PuX3CDSeq1gP4zCRo
	 RTnBncXxz81H+K91qL4cTEj2R0uIzTyP4jD8tLjaAKI5jmm1kr1wK54I28CVA8gXhy
	 67WNXYIcSiPAgAgZTlf9lXkQZY+4IUChSGGH3tpW7Hn/BmgXbKBeUrm4gihvaNx9QM
	 4tv2VJbMsqvvQ==
Message-ID: <981bde27-ffa8-4021-9766-e4db877aae38@kernel.org>
Date: Wed, 11 Sep 2024 10:13:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH v2 7/7] f2fs: add valid block ratio not to do
 excessive GC for one time GC
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20240909221946.2004046-1-daeho43@gmail.com>
 <20240909221946.2004046-7-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240909221946.2004046-7-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/9/10 6:19, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> We need to introduce a valid block ratio threshold not to trigger
> excessive GC for zoned deivces. The initial value of it is 95%. So, F2FS
> will stop the thread from intiating GC for sections having valid blocks
> exceeding the ratio.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

