Return-Path: <linux-kernel+bounces-293448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26662957F90
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C51DC1F228F6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 07:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884DB17B4ED;
	Tue, 20 Aug 2024 07:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PuDFIVps"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD16516BE33
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 07:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724138892; cv=none; b=jF4pvBEE2U/CMz+c51+Sq/Q6P2uJZgD8sX+lpbIt83Bd89pkeqyqTShrmnG5F0LyA8OYPELPDS1bGYRCrW0pmoLpB86DFpKAV/zh2qdBXkkRYtx67B8bwhefYLJLFs70kce3PvL3eMe8fh906a4DejtAjz1SbQ+fgKoCsHhnTKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724138892; c=relaxed/simple;
	bh=jkWDW68RAx3HyWh3El60l1g4aMTlaslQ7spXe9iCdNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mX8+8mdHGZ7QYEecCjomZJMB64pqoKYBF1x2f1T93Y/e+lZZKB9hlHdM5TLtKDClifWZzGPhmvI1pgGOGwCMioov50byjMYfo3WpuoGwviFT2JCY830LZkfZ6hTmIcnyZlSJO0GjmuICitUBxqLTgzTZqOHzLCEKEtVKodL3se8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PuDFIVps; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-428e1915e18so39136185e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 00:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724138889; x=1724743689; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Zf9Rl0UN+cGUF4HBWln7vCOPwms/pNqv52XDeRl6+w=;
        b=PuDFIVpsqevjVZnV3exnD0P7M0MCqtjCN0AW2pOMSlN9DIEbG1/VApzXJw1Of/GIzj
         6m5ETP8AXW2HmtJIMHg2pgVnStKScw7qow72Ho8OdxPcn8M24W2CZhA4188f3UdgEMvv
         7w184EcLn0eHV6syaN2/rMNH4GB0yP+XrlvP8f5TSGeuv5lFnXi6XysOpoQxDk5fJjsM
         P3E5Ny9eA/MIuuHP1L/hMWXFT8PUahAMEfayu9zoQCyfc+Ynxy3gz9A8TOn01z8FCt2J
         rdgBK+jENZGFXzhizs14RbF80lZYcRuAPuuPJE5dGMfyNKMU4NB48oCL2jPKX8D+ev0q
         1fyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724138889; x=1724743689;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Zf9Rl0UN+cGUF4HBWln7vCOPwms/pNqv52XDeRl6+w=;
        b=gQhaZrCcQVVYu1CLh+6JACwb8cW/9RwvkVD9juDMcDiv62/utLvyX8kfZYgoWM5zP2
         z9neYr9UPo/ikfQeD9Or7wGUIa+t5PWpZLNOwh3uWbgEnE/aNtXs0ENfeKvdznp9b0Cf
         93QCY+faUaqe5e10QFYdU/gz0WSFCCb6PAPiV14HaifzcT+7CHUIgg9Ex0K9O3V1R6Xj
         TyDNz/0+55PbBUHPH59+YQunVDxQHrrWbxJmEHDaJpgApc0jrHYfidDol/npeWBJAHtm
         8I313uz3+9mAt+xFQxuZBo8Ia5bt1RcYnu3ULetdFkM2SVDVT6IjRg+USKpA9DruC0bB
         Em6g==
X-Forwarded-Encrypted: i=1; AJvYcCXZtwMdxjjBMWNkxZX9TE4n01i3xawWc3mLlfJWDklLMv3EmA8RX0VikX7GHPcI8kpXgk1caxjuojWEI7I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1jy4KMrQGUcKUutP7/7UQ+FRm5HDL5EVc/AEelfX6s6VJv3qO
	84wLEK6bQ9Eof//LM7ZcNi+AvTrguIzTb8LhRDJ4z/bDj99pGw7oEBJk3ntvE+k=
X-Google-Smtp-Source: AGHT+IFl1gl5Q3rqnnuhng4dzdFoLHznEATNGgJfs+9boyU9Xon3WFsGG0SpAMYmm8DhzLPdkBA83w==
X-Received: by 2002:a5d:5e05:0:b0:371:c578:3130 with SMTP id ffacd0b85a97d-371c578330bmr855827f8f.8.1724138888646;
        Tue, 20 Aug 2024 00:28:08 -0700 (PDT)
Received: from [10.202.0.23] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f03a35d0sm72569085ad.258.2024.08.20.00.28.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 00:28:08 -0700 (PDT)
Message-ID: <dd5dab9e-112d-4fca-ba12-b6e2dc4856cd@suse.com>
Date: Tue, 20 Aug 2024 15:28:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/2] ocfs2: remove unreasonable unlock
Content-Language: en-US
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
 linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev,
 syzbot+ab134185af9ef88dfed5@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <2e662cb6-47d9-4bbd-855d-1f6d5edb8633@suse.com>
 <20240820065511.996453-1-lizhi.xu@windriver.com>
From: Heming Zhao <heming.zhao@suse.com>
In-Reply-To: <20240820065511.996453-1-lizhi.xu@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/20/24 14:55, Lizhi Xu wrote:
> There was a lock release before exiting, so remove the unreasonable unlock.
> 
> Reported-and-tested-by: syzbot+ab134185af9ef88dfed5@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=ab134185af9ef88dfed5
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> ---
>   fs/ocfs2/buffer_head_io.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/fs/ocfs2/buffer_head_io.c b/fs/ocfs2/buffer_head_io.c
> index cdb9b9bdea1f..e62c7e1de4eb 100644
> --- a/fs/ocfs2/buffer_head_io.c
> +++ b/fs/ocfs2/buffer_head_io.c
> @@ -235,7 +235,6 @@ int ocfs2_read_blocks(struct ocfs2_caching_info *ci, u64 block, int nr,
>   		if (bhs[i] == NULL) {
>   			bhs[i] = sb_getblk(sb, block++);
>   			if (bhs[i] == NULL) {
> -				ocfs2_metadata_cache_io_unlock(ci);
>   				status = -ENOMEM;
>   				mlog_errno(status);
>   				/* Don't forget to put previous bh! */

Looks good to me.

Reviewed-by: Heming Zhao <heming.zhao@suse.com>

