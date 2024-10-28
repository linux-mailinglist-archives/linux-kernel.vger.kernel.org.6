Return-Path: <linux-kernel+bounces-384547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4FA9B2B99
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01F31282230
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5B918E744;
	Mon, 28 Oct 2024 09:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGO4qx41"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD21817DFF2
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 09:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730108091; cv=none; b=sBdw3PA/hJoul2tI4Km++Q4ra0NJZxujyB8AIpBS859eoYHCYazEzSsWbWxMLLDm2T/P6M54hQIHx1dotDbH0ghUj1nxpwB3EzVhFeWGsvECgAdX/DxTxfA0o/nPc21VFu7gegHZBWAaQEQssxLvNn+lP48ZfC1oxihxN6msi1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730108091; c=relaxed/simple;
	bh=3APMf245gF3+vWvLLBC0eJH2GM4YL5zqTKHdLoYBOcM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tSWHrgGHwQSIow4o5jxDZat2Oj8PQOa8EwJai97z4Kp2vljc+YdgaHulPgGFidDxv0RkVz6L+AVknaA5TUnTdCPZyhHWJY/Dt80jt4/O8pS8o7jGssj1UQanOPRIC1qqBhP0KxtAvgrGartn/Dpk5hW7gMTxWVoVFxbO5+PWrQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGO4qx41; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A98C4CEE4;
	Mon, 28 Oct 2024 09:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730108091;
	bh=3APMf245gF3+vWvLLBC0eJH2GM4YL5zqTKHdLoYBOcM=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=HGO4qx41duW8BJyREsdjwlBSBxaGLf9b7Bped3xCqnpg9T37xHMinwesIhJRKX35Z
	 Sk0R8ewRczVppL3MMnj1amVwYMTOBhXELgxFNXiSJ+16rQHnhuFQ8eT0Bx2sspgVWc
	 696Dw6tJvPtsoITWvUJ+egzHWmnZen7xrqXvcQyRR2kDWtvfpmltbzIA97MD+YVAWn
	 tHbv9DGY1g6z9INxK9rE8hAP/957Iw3Gw+vTV4Moj/anC+uWxGvTF6voP/FAF2hebX
	 IE8u0jcbf5wgM0/yHstbAKyvReYCQWUeR6DpeIhBaQhoezq80Yq3zEgu0+VZnhFp8j
	 x/IBQ691ubSnw==
Message-ID: <b0760a9b-0973-453c-af18-3e384f85a9f5@kernel.org>
Date: Mon, 28 Oct 2024 17:34:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, niuzhiguo84@gmail.com,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] f2fs: modify f2fs_is_checkpoint_ready logic to allow
 more data to be written with the CP disable
To: Qi Han <hanqi@vivo.com>, jaegeuk@kernel.org
References: <20241025091823.2467074-1-hanqi@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20241025091823.2467074-1-hanqi@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/25 17:18, Qi Han wrote:
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
> also not enough.
> 
> Signed-off-by: Qi Han <hanqi@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

