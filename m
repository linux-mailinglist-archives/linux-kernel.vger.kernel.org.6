Return-Path: <linux-kernel+bounces-377245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F2B9ABBEB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 04:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C5E31F243EB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 02:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8B96F305;
	Wed, 23 Oct 2024 02:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1r1C0/4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999501876
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 02:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729652143; cv=none; b=NJqXDbyOkzZDy/KAV8rLNgkjQvE4LEAi+M4VVO3kBUrzV9T98fVIl9yUvEbpn6xBNlWOyBnKQWSnsfd0zgZU7vFTnx5aCTx1bvUTOD0E9VRhvQbuhJRAamHuGXHYrPtJHLXPtzjqqEAe+XFJU7fZ8tkGx/JnV7/Z7mZRR591+VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729652143; c=relaxed/simple;
	bh=OStp0MHjUmm8aKULhhvMvWY25ziHmGwzr71AVGuIMPU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SeIFK53NlLBgwjasQCJOyNeWHY3IstSa/BLrKTeO70Ww7nplQ1t0Fr9H2JQf3LXM2fj0s7PrTTOaxZqePl2Ktb2MlxkU7VAXLP8DQsHKC/LUFNLxX4+c6IARNwWBIYqYv7mBDztw8qOvMDUlwYK9ll9VJdUY0uBwKLWmjmIJSA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1r1C0/4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F123C4CEC3;
	Wed, 23 Oct 2024 02:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729652143;
	bh=OStp0MHjUmm8aKULhhvMvWY25ziHmGwzr71AVGuIMPU=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Q1r1C0/48a6ZFL9RTepqs+vEQHY3/zDCXmRZ3J+H4bEZkJeLUIwfU7d/jEXAuuuPZ
	 XTXKeNWsT0DY2pGJyIXfPPGitE8nJYraoVnQ8b0liQnf5tKzu1jK1bfJ6zt1FdQRZy
	 2QJTTXb8QIbxMRA62QoOrqu54AkDZxPiBPcaa0IfYMJZHDSDvCPKxsl10R2TQr1AQi
	 OtfoAnXajK8aT8LKy/sP9JZ4++lPg8z4okz8uDRjlYSDykmTQOV813rDNEdCBgA6Io
	 32INsy3b+kz6s2BFO3u1q8Ar3LWjIXpiDhx+ocMK73F5Jgkzuhw3XnH1viTIdmRGCI
	 nm3zSMUtNkl0g==
Message-ID: <c6b08e67-0697-45ce-9302-0150f69725f7@kernel.org>
Date: Wed, 23 Oct 2024 10:55:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] f2fs: modify f2fs_is_checkpoint_ready logic to allow
 more data to be written with the CP disable
To: Qi Han <hanqi@vivo.com>, jaegeuk@kernel.org
References: <20241023025945.1817457-1-hanqi@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20241023025945.1817457-1-hanqi@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/23 10:59, Qi Han wrote:
> When the free segment is used up during CP disable, many write or
> ioctl operations will get ENOSPC error codes, even if there are
> still many blocks available. We can reproduce it in the following
> steps:
> 
> dd if=/dev/zero of=f2fs.img bs=1M count=65
> mkfs.f2fs -f f2fs.img
> mount f2fs.img f2fs_dir -o checkpoint=disable:10%
> cd f2fs_dir
> i=1 ; while [[ $i -lt 50 ]] ; do (file_name=./2M_file$i ; dd \
> if=/dev/random of=$file_name bs=1M count=2); i=$((i+1)); done
> sync
> i=1 ; while [[ $i -lt 50 ]] ; do (file_name=./2M_file$i ; truncate \
> -s 1K $file_name); i=$((i+1)); done
> sync
> dd if=/dev/zero of=./file bs=1M count=20
> 
> In f2fs_need_SSR() function, it is allowed to use SSR to allocate
> blocks when CP is disabled, so in f2fs_is_checkpoint_ready function,
> can we judge the number of invalid blocks when free segment is not
> enough, and return ENOSPC only if the number of invalid blocks is
> also not enough?
> 
> Signed-off-by: Qi Han <hanqi@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

