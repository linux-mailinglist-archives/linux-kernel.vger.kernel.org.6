Return-Path: <linux-kernel+bounces-230292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51356917AE4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 10:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CFAE285F62
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 08:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B371B1662F8;
	Wed, 26 Jun 2024 08:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFlo4sTf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088B316133E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 08:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719390391; cv=none; b=J5JCkZ/PvkBgjSpK/JE1/WiSljZmlbBG6RgrVlWJEydtkIjt9jCCMtg5ZJj7RzQGAxGLe5ExeKrGaSa7s8MdV1drtkxSct6eSOh2MEdi8aG1lDRtE71bp05MCVK7Fu2+y0bkQHAT7SbQMHu66mv8njOErsrF3YbTLGGaxij3O3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719390391; c=relaxed/simple;
	bh=XbiR1/BgJHYty7bevHcBo3nrwQe/zawJwGacx+h0PaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Azj0typBI3D4hQHhHI2JOn/hUHfERPBANMyPyS6JHZ92s7BQYJdOLyLfTYB+ey8yjCaXTr+13XT9cxWUJ9tNiE0/J9CqoKu+whI7FfdJLOQWMBE4ry6Q3xsyWtu0FYp6uGTUeq496WY28FS3AjovH/07p2QcKmH6NY7+4DVKNgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFlo4sTf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53FDFC4AF07;
	Wed, 26 Jun 2024 08:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719390390;
	bh=XbiR1/BgJHYty7bevHcBo3nrwQe/zawJwGacx+h0PaM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tFlo4sTfsiO0U16eIxo0+7V/+LMf9TCi02eBP5tYY5HnnlJKFnDSCco5d0/bHF4S9
	 6CqbrA9Yix5cpgkhHZEkFCdecHIRQhL+bgTx8JvI6pox6TJTQUYrinn2Wt8vNuJ74/
	 St7iJB3SD4rBeB2Y224hPncDWeM6//3hF29ousX8mKMFnJnMO48Yj2UTbzjEz5hMze
	 Tm3zd2j8fHPFsn+0CrWjppsG9Pgwk/dcinzYr6Uiy+M98Vqcght35VmXc02wuZGbJd
	 q9q4pvBRgSefoA+Ra4jDnydt021FlMUCEh+2PeQc8F0HrYbgMWSbeHnsVdMCH7j/gE
	 F2kv0pakv4mkA==
Message-ID: <aecc0724-027e-4405-887c-1a0701517e81@kernel.org>
Date: Wed, 26 Jun 2024 16:26:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] erofs: fix possible memory leak in z_erofs_gbuf_exit()
To: Sandeep Dhavale <dhavale@google.com>, linux-erofs@lists.ozlabs.org,
 Gao Xiang <xiang@kernel.org>, Yue Hu <huyue2@coolpad.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Chunhai Guo <guochunhai@vivo.com>
Cc: hsiangkao@linux.alibaba.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org
References: <20240624220206.3373197-1-dhavale@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240624220206.3373197-1-dhavale@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/6/25 6:02, Sandeep Dhavale wrote:
> Because we incorrectly reused of variable `i` in `z_erofs_gbuf_exit()`
> for inner loop, we may exit early from outer loop resulting in memory
> leak. Fix this by using separate variable for iterating through inner loop.
> 
> Fixes: f36f3010f676 ("erofs: rename per-CPU buffers to global buffer pool and make it configurable")
> 
> Signed-off-by: Sandeep Dhavale <dhavale@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

