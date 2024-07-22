Return-Path: <linux-kernel+bounces-258379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D690293873C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 03:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 776461F21391
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 01:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1E0610D;
	Mon, 22 Jul 2024 01:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KiyNexAX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6D846B5
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 01:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721611730; cv=none; b=EGv/FsGvIUwTYBh5uL4t1OGWd/miVu4F4OkB1tWopoF5pCSdNpZfWhIK9WEdeKdQysdZUVbuB4V1FY2Ftullnrp8+o8gaPJMpe0KGezKjLCmkpmA/nrHqmnZ0t9SnDSWreGM7shJ7xKmDMkhdqFbUGcLMbwrmWdX/Q19hpk0JxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721611730; c=relaxed/simple;
	bh=g2tSq9APFMR0Bl17C+GbBQhxN8oIR1MC2bDyCs6g6OE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eUAH6+U1aXYJkYkJTIRZeXJxk4LzS+BnCPFM9398F9C/MRecjbTghCSFVPK0zFsOgLaedgWM/C3LuzcdQiJFbSNbmHnoZk4L+zhFz4J2plhtQHWepLFEgObAAyeVBuKkJiL0hEDixwoaZPUQELpJqeBJGp5COytk0B1g3xcne+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KiyNexAX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6084C116B1;
	Mon, 22 Jul 2024 01:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721611729;
	bh=g2tSq9APFMR0Bl17C+GbBQhxN8oIR1MC2bDyCs6g6OE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KiyNexAXxxhWCzfOnl7t3ckfxAPOlNjcBSm3MJGrAZt1BJCpunm6IgWUOFyFyY027
	 zun53EGWDkaCXAZ+sy4xJ/arOxe3rt5WbF4a4EWGMMcWIfthpr3jE3s6zLhAPc3RlN
	 vXp+JkVI9dGAVrn8B7eC2j5501HP4r0fe+I3kB8iNOxVyO+i/wrtS5/plDxhr3BhJ3
	 I2E/T41ff9Uy9aDhf6slsBT3QmuvmPSbFVE0DiUQU8Ly4uiprZ44AS6EUgUhum0LXm
	 FWPAWRkiOLiK5teiaFkddVqyHus2RW4qwK+OzSjliDB9fy2RYG6ORy19Ly62Tb231n
	 h93VfvPXCA+Dg==
Message-ID: <c81af94d-3b56-4169-b2eb-5d82623ab0af@kernel.org>
Date: Mon, 22 Jul 2024 09:28:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: free victim_secmap when pinned_secmap allocation
 fails
To: Yongpeng Yang <yangyongpeng1@oppo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20240720103349.3347764-1-yangyongpeng1@oppo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240720103349.3347764-1-yangyongpeng1@oppo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/7/20 18:33, Yongpeng Yang wrote:
> In the init_victim_secmap function, if the allocation of
> dirty_i->pinned_secmap fails, dirty_i->victim_secmap is not
> freed, which can cause a memory leak.
> 
> Signed-off-by: Yongpeng Yang <yangyongpeng1@oppo.com>
> ---
>   fs/f2fs/segment.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 78c3198a6308..1e784ea3dbb4 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -4971,8 +4971,10 @@ static int init_victim_secmap(struct f2fs_sb_info *sbi)
>   		return -ENOMEM;
>   
>   	dirty_i->pinned_secmap = f2fs_kvzalloc(sbi, bitmap_size, GFP_KERNEL);
> -	if (!dirty_i->pinned_secmap)
> +	if (!dirty_i->pinned_secmap) {
> +		kvfree(dirty_i->victim_secmap);

Yongpeng,

In below path, it will release pinned_secmap/victim_secmap?

- f2fs_destroy_segment_manager
  - destroy_victim_secmap
   : kvfree(dirty_i->pinned_secmap);
   : kvfree(dirty_i->victim_secmap);

Thanks,

>   		return -ENOMEM;
> +	}
>   
>   	dirty_i->pinned_secmap_cnt = 0;
>   	dirty_i->enable_pin_section = true;

