Return-Path: <linux-kernel+bounces-294943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFF9959483
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 08:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6B3A1F247C1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 06:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D371D16D9AE;
	Wed, 21 Aug 2024 06:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aLbZqafE"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10D415FA92
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 06:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724221399; cv=none; b=eUtHkpL0DxTVkdg9gMYcbYsgM6dfHdmA6AzHYmX6x7WUbeWY3fw7JOEv/kqC1wD+JBRV21tShNfoSsXXtc0HVaUjKO0zRn3WOpi+UH0PuSdU9ndsdebko1+4jIZ+ygzVh3RgVUR6qqP9XGH8IuBBd+qrzNU/Q0GvgK8o+8TtI5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724221399; c=relaxed/simple;
	bh=xv0AJvJdUF0KnKGoGQ8i9Sum+9GGB9bH1fNVehw1E1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XyZZFywcxvowRKXNILCa9r0ArrYLi6jRcCV0y+7q46hh/9cjG7ozT3HeMEW6G0Olw12bJk+EBH44mfIYFVpOzDIbcHDQBUgNFnsuHYY2bwQea/WbvVI+W1yVOOaxlEkYMwHiWdQyTwdpgv7aptbTPNzKJT7LwF/rhxTFluayk6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aLbZqafE; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4281da2cdaeso807095e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 23:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724221395; x=1724826195; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0qG4SWY2Kohg76lS5TYD26kdocNak1OXtrtTBUr3UoU=;
        b=aLbZqafELPINrw/U9J/UvX75TEb0S87EgytO/qUOPV2OgqZK/0+hElqbNXa4IXPLsE
         KxW81NqaJOHeVQ6tpYKSFZCa67tm3ngzkDyEjhPPCZX91YoGOMPl2gSyzdfL1UXRIRNN
         +KePFrJaXY+tf/u8HrcVwIrX26uEQ29Mix196YFaFzts/V/MGph+4vqGgn4Qocs9xOpj
         xc/mDRzcTTctltvvDJTrgsHYhoWHmQLO7softTsNBGhT2ToXTPhtmMBWyKQ2fcf1EswW
         I9WVzvfC3bkGBnRrBDlCqef/UwiImUSgwRbjfAC+fHbQPK9CPmHc+FWbnPYCutnN+jJ/
         03DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724221395; x=1724826195;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0qG4SWY2Kohg76lS5TYD26kdocNak1OXtrtTBUr3UoU=;
        b=v2yyLMWqSxb/X1xnDQIwLr4A1SQhq8HnB6zhXXAVuq5u51f6qTUCFeH2fCclxHeNLd
         VLYpmKrIXY2bw94ehtag5LvfnKUwc1GYYVoN3GZ/72ZqaXMfZ1XJgpoWRuIOWvePdW62
         QjCJIpF5hZqOo188FDkY65ZmUGiSHgziguNlca3CKtjdKVigoRFBs8O3+6nhFndGf6vo
         B2DbyZvhon8qJJGt+8gF19NFk6g2VIMyNcVzkak4ngcHfbIgoe0H+lSg+r2ptTKd3nEG
         mBdEXt20Mfzazma2nEPC+fECH7g6PF8rR9W/efIAGGebglxAJ+qPZ8fH0NGAnEETV3H4
         u3Rg==
X-Forwarded-Encrypted: i=1; AJvYcCXHW0uBNPlvyyNHatvUOjD8znV8i3GTWuDBfUSy9SnkMVchfvYZHk4HOrthybQR2Oexy6ZSoxcjKspAxFk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8FgpjFjyKD/IHVk7k/vwAatbra4Y9qPRwGH6aSuD1gQG2Xcre
	txlfODy+tl8Ec67vPNnigBaC3GLr65XSLgZqdGl+cd7Zp5YXnzVVWpBcR7uxjKE=
X-Google-Smtp-Source: AGHT+IEerjdUpSf5oD4V1rld+yGYKxBwJIf7ozzrycC1U+AOqIYaXn8DI2ScMBFAZEqXXKgOQJdq/Q==
X-Received: by 2002:a5d:5f89:0:b0:371:733c:7882 with SMTP id ffacd0b85a97d-372fd929895mr414959f8f.10.1724221394582;
        Tue, 20 Aug 2024 23:23:14 -0700 (PDT)
Received: from [10.202.32.28] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5eba263f0sm811398a91.33.2024.08.20.23.23.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 23:23:14 -0700 (PDT)
Message-ID: <0dd1d1b4-5e83-449e-af48-3811abd2e6a4@suse.com>
Date: Wed, 21 Aug 2024 14:23:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 2/2] ocfs2: Fix possible null-ptr-deref in
 ocfs2_set_buffer_uptodate
Content-Language: en-US
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
 linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev,
 syzbot+ab134185af9ef88dfed5@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <20240821055546.3254888-1-lizhi.xu@windriver.com>
 <20240821061450.3478602-1-lizhi.xu@windriver.com>
From: "heming.zhao@suse.com" <heming.zhao@suse.com>
In-Reply-To: <20240821061450.3478602-1-lizhi.xu@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Where is my "Reviewed-by" tag, and where is [patch 1/2]?

On 8/21/24 14:14, Lizhi Xu wrote:
> When doing cleanup, if flags without OCFS2_BH_READAHEAD, it may trigger
> NULL pointer dereference in the following ocfs2_set_buffer_uptodate() if
> bh is NULL.
> 
> Reported-and-suggested-by: Heming Zhao <heming.zhao@suse.com>
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> ---
> V3 -> V4: Update comments and subject> 
>   fs/ocfs2/buffer_head_io.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/buffer_head_io.c b/fs/ocfs2/buffer_head_io.c
> index e62c7e1de4eb..8f714406528d 100644
> --- a/fs/ocfs2/buffer_head_io.c
> +++ b/fs/ocfs2/buffer_head_io.c
> @@ -388,7 +388,8 @@ int ocfs2_read_blocks(struct ocfs2_caching_info *ci, u64 block, int nr,
>   		/* Always set the buffer in the cache, even if it was
>   		 * a forced read, or read-ahead which hasn't yet
>   		 * completed. */
> -		ocfs2_set_buffer_uptodate(ci, bh);
> +		if (bh)
> +			ocfs2_set_buffer_uptodate(ci, bh);
>   	}
>   	ocfs2_metadata_cache_io_unlock(ci);
>   

