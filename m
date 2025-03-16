Return-Path: <linux-kernel+bounces-562810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC201A6333A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 02:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC9E33B12D0
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 01:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FC982899;
	Sun, 16 Mar 2025 01:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oifEFh0d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A347DA73
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 01:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742089824; cv=none; b=Ct/3NvAMN7s28VEUhTe1FpqWzzWldrLuz1M8w5m8jIRt/Xfvyh6nrdECT+nzfWsJ+KUPbteIncq3HKZpxKD3v12LYq1dDz6eUnEqsW47UiLm6iMqOcJdSs6K6QyJ/fCEvJ+l5Nso8xdoEkRjySW8ERKIReCjzG8zcm1fdokD5U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742089824; c=relaxed/simple;
	bh=FkM6WT3iJf9hal3Xv0VStWrbVOjhBOTnWWcC//OIGtY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Nx+UYpwCA3qZtImp2jvuLlniBvi9LtaodNQKNdz/hYJnnzdD14Td/3p2GUhdaEEVfxxLJXLQIj451sPvDEudVtQayQ5UZJnfuobv5Gb+nrFV3Fs1dqZ/iO96LU5hRyljPnpX+ANQ5uQZuVYGQIKuxNfbZQMcFFa7FmVCfWuYNOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oifEFh0d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F329FC4CEE5;
	Sun, 16 Mar 2025 01:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742089824;
	bh=FkM6WT3iJf9hal3Xv0VStWrbVOjhBOTnWWcC//OIGtY=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=oifEFh0d/XHcaN8tvZpwrwfNLOOFpkf56lx9YgYvXXJY9zs9iZg4Pzi+cAb28WUHV
	 KcqvSynqqTFMtdxYuWKsRcQelAQ1NZmMxRPCdF8gFBDRKaUQ9WjfxW2eIHjapNla2C
	 4wz/hb66FNuMqfWmw83BPa3Qr4eVilDLC1sxxK19uVQ5ewcuPSY04kgnj4wUJmBcaj
	 h5l3tGbrYQK48leaoWZe5rV64+ULePpRTvLSHNDyJO2X6b/5967SCvncG4lJYPso4K
	 yqeD1yt5S5OYz+hKSbPp8LagJXHpasoJwRL3hqO303ihF9xrqVakrLYHzxAiyMZhcF
	 4QwmoRHPhhmiQ==
Message-ID: <83afcdb6-61cb-483a-8b8a-97fa58e0ad20@kernel.org>
Date: Sun, 16 Mar 2025 09:50:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] erofs: clean up header parsing for ztailpacking
 and fragments
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20250224123747.1387122-1-hsiangkao@linux.alibaba.com>
 <20250224123747.1387122-2-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250224123747.1387122-2-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/2/24 20:37, Gao Xiang wrote:
> Simplify the logic in z_erofs_fill_inode_lazy() by combining the
> handling of ztailpacking and fragments, as they are mutually exclusive.
> 
> Note that `h->h_clusterbits >> Z_EROFS_FRAGMENT_INODE_BIT` is handled
> above, so no need to duplicate the check.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

