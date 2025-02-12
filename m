Return-Path: <linux-kernel+bounces-510371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D57F7A31BD9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 03:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 786E73A7AC4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 02:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F7135955;
	Wed, 12 Feb 2025 02:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oElwa8av"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992AE2AE69
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 02:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739326779; cv=none; b=ntKyatQ3LfDV8w5yYzkU9uyv0iVi2nFm7Z0yeSYDwxcA3UW1iy90aetnNXj+D72zb6h64YjcejENpJ5SaMZ0p26AaHVa4SZLPbg8CwpMa/g9RK57asXw94kyJEiJAxyfH5iR7MZN4SVc0CkyFH31YyS4G0dYu2BVhFcSgKzcqDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739326779; c=relaxed/simple;
	bh=G3DyCsWA6hOD7ERSraNbl8ymdQssGhj7+YKacyKvS34=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NDL73RZOB0GX0m6IfMGm131smgQg+1WLZW8A1cbPGKV0wballc/SkTFnxlzGpT+4zBZmCMuFk73B2EQyqE7A/Ds7qaJJnBzh6MmJQbYMy6ED4DEiVaGL3fgaEAGLtoQ5/pgbBm+pqOOf1OMBsDfxLnWPqfKQ5734pIiTnjFr1eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oElwa8av; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C3C1C4CEDD;
	Wed, 12 Feb 2025 02:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739326779;
	bh=G3DyCsWA6hOD7ERSraNbl8ymdQssGhj7+YKacyKvS34=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=oElwa8av0mZa6n0uOiIzT/A2Yhe5awzpcaeI9UjrWgNfoNVBGzs0PRDsXQZgmcE/q
	 jTH64t9uWY29GGPmEj6ZdLGFBOiFMWihL4EU8ahKNGZP/sWkHRcEP4bKrnAXQE/jJ4
	 hU14ddTaHL2/fuCG9vapBoLnLwqn2/EPxEf2lIvj2VSLC34R8vLMlrLqGgu07PZLOx
	 mU4V5xM2Jk/oUJZTgiMy+nBWYl/P7q1j2/zf5DMx/m0JCFSdGIGlT5JyzB73I9+0mc
	 IBBP8IOxbxgS+Tyad5iQnJcZ5VqVqEIfH4rBIWwFihllova1DXax44fNt3X0sFxEiI
	 yLeZfBGqBrxuA==
Message-ID: <31caadac-f56f-469b-bb5d-f58b3ab5e309@kernel.org>
Date: Wed, 12 Feb 2025 10:19:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: add ioctl to get IO priority hint
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20250205214014.3270585-1-jaegeuk@kernel.org>
 <Z6u6qN2ATQKlfmRQ@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <Z6u6qN2ATQKlfmRQ@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/12/25 05:01, Jaegeuk Kim via Linux-f2fs-devel wrote:
> This patch adds an ioctl to give a per-file priority hint to attach
> REQ_PRIO.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

