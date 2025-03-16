Return-Path: <linux-kernel+bounces-562807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C029A63335
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 02:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41C88188F92C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 01:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4420A125D6;
	Sun, 16 Mar 2025 01:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATMpC5U4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A214E33DF
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 01:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742089168; cv=none; b=GgUHrz5o2vMNEod8+/FQSpnfjKEu8AjqmYukxlMZe/nbhmp6qj0a3EFKupEhmbCIxuaf3Ch++hTQB+TzOKBuGv0ONt6XbXI/Dm2YrKCPwX2Tb2YoVCans7k+X3cus5zaxsJd4BhkyCtI7CNOpz0sw5b3faFtnSqE4i6hHmafXpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742089168; c=relaxed/simple;
	bh=tHdAxXD2Buvw5a8n+0GqZroHLjBlPAlQ/L5CGsmDE5U=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RtjT/YNS/ncF3aKv21n4xT+1UakBvEeXPAOMVaBr4KPiGbl1Bbr/OPyhH1UaajrbEi5DeiklST8FnrPy6qyppSJcwT8glUnJ0ZtJ0yTIGfzNFzArUkuAKwQsTYtXn0tOJgC6kk9WM+rvN+Ra69M7GXdt0F1319HtYw50BoPYDzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATMpC5U4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D60AC4CEE5;
	Sun, 16 Mar 2025 01:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742089168;
	bh=tHdAxXD2Buvw5a8n+0GqZroHLjBlPAlQ/L5CGsmDE5U=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=ATMpC5U48eo7jJ4/LTTVicXCcSZ/X4mQJBU06wcHhkLip8t4gdFJt71OWQJXd93rA
	 Ru2X9gbotuEGu42s6mv7KViod7ys7Vafvxz3e2FDKi6ZJva+W2vhrGYfvPwtJDsYoB
	 DLCdmt+bZyWi38p3pQ5ue67EeYOkOc7ROa4V59VEg8/Cw9b/2fpAcoo4gLpmXBXYn+
	 ukN8guuUxm6V32xUE1KWbEV75/IR5XTVHeNg6hRt++kL+qOTrXtwi5mCwOiVWVNMe0
	 6Qm7HyPRVcZLunm5D/d58qoDGUmI05OSr00MVMInpLOxRcB7WTq72JVhavCUqJL6qQ
	 JgIGY+i5qOZ9g==
Message-ID: <7d2c029d-13f4-4318-8cd0-37512d0bc258@kernel.org>
Date: Sun, 16 Mar 2025 09:39:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] erofs: simplify tail inline pcluster handling
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <26db55bd-31a1-4fb8-8ac1-add64c971841@linux.alibaba.com>
 <20250225114038.3259726-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250225114038.3259726-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/2/25 19:40, Gao Xiang wrote:
> Use `z_idata_size != 0` to indicate that ztailpacking is enabled.
> `Z_EROFS_ADVISE_INLINE_PCLUSTER` cannot be ignored, as `h_idata_size`
> could be non-zero prior to erofs-utils 1.6 [1].
> 
> Additionally, merge `z_idataoff` and `z_fragmentoff` since these two
> features are mutually exclusive for a given inode.
> 
> [1] https://git.kernel.org/xiang/erofs-utils/c/547bea3cb71a
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

