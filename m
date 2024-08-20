Return-Path: <linux-kernel+bounces-293223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83861957C34
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 06:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3670A1F23D54
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 04:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098604C3D0;
	Tue, 20 Aug 2024 04:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Rtx73i7f"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427E6132124
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 04:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724126691; cv=none; b=imkrG2EpqviyONGluHhV+0UHyQzAOTgLG7Ilsphu/UOTh1jHcA1tG/WAvuQ9WP7z6L0aycRHli08jtiEMJTl92s1vScrZu1cwNQtLUWYJGgqrk9ysKTC8oA68KO/wVZlg55mi7PUSoHpG4P2ZF/wQsvrRvwsmhgluTaR7sp3RdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724126691; c=relaxed/simple;
	bh=H23msXZo8TFfWGNB+BXXZdr7WwBND5joU7wNlrIf8gU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qh1chWaisrRsRMctvc9rLttRM2MoJ0ZoQmMIlMfga3zFU7oJJS3UYAmtN2N/oENl774LAaZRlOZPTcaAaSWuaFUnevzWr00rXNoMtu6O2eb7Yme2KqLIhDexk1Mv2zC9HEEezL8WKJ/m7YqLDx+trFWxsAnKp2jSpuIBQnD1woQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Rtx73i7f; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-371a9bea8d4so1468420f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 21:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724126687; x=1724731487; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B40v24EN9IZ3cBGvmjDIed+yCQZBs6o5/vWWPhgdADU=;
        b=Rtx73i7fGmA4wdSjSDJgcttSZfSMWG8EvrS8heEEXu+xx1LDJnPKe0ar8wp2SJQRTV
         FA6Fs41JcRpAHxCRZifvrQ72/OzCT1xuEoQhOE3YuqeEtrbfurgA/mtKzHUNTNPEP2P3
         akmsq6NnLNcsJ9ARoYWqXxPF9gvSZD0AZyXgaf23CfDQ8gviZXGweBvmJrkP4roXEHjQ
         ZxEdmfynEhv7NZGeyorIWpydU/YHDBfexbKdD5B7s8PlOvLvhwm+CvOS9AbsfM+i4mk6
         gg6Lvneuaq7vluQGJcoNX9j1Cfyv+K3BM/4Qrk9rBh6NfDSFqe5VI793OOvUJGl9T1LM
         1QzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724126687; x=1724731487;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B40v24EN9IZ3cBGvmjDIed+yCQZBs6o5/vWWPhgdADU=;
        b=MBRjfpmt2JUS8VRsiX5OfY73hleZLeuUseY6Jr7E2nNd6lqR/6GoZbRtMNAWK0DTL1
         hDxwS1kJVb97JIQMAKkTyw4h73RzNBCZnwywsS0/G8p0Bb2Dv3iTbKC0jXIYFxbKET59
         ah59zfjwOa+lWv8RuPvQL1nq9X9zZ7awgZawTEdT8you5e/nV0Iqss/HI4VWydvY8mWY
         9GtyQc5Y9MYzodJnnA8UVXZKJTExXyRNobIsTOvE9yXAJRnjhN3snqEFIwyQhWr31yG/
         Eyb5gRONtWNr68Fqk0OdNT1hPU8LqySf9JPYIYvwYbICgOlMqmldsBhVdDwQcZs8FcXV
         +bJg==
X-Forwarded-Encrypted: i=1; AJvYcCV/asrWSTIh9jZZcUAHHNTZSuVBuCFpQpAxNmQ6eSi62a1Q8qlosoOoXtYS8CuuoKQ4Lb1LZsTqmdDOAPI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz6vCKNU6tk9chD8zul4U8sixPT4chvHOfqn9Yhb2W/bzTQtgu
	+/HA2CPDqvruwtUeKKi5QVkaiJph8YQQvw1W3PwD24KwuwIVHRAC04YHd/d1KdY=
X-Google-Smtp-Source: AGHT+IH/CHvuB1V57d0Rh6z699rg/2J9/DbidbURKDXYfGHFDmatIeVh24mQLf0Gdjp61bK1MgorRg==
X-Received: by 2002:adf:a45a:0:b0:371:879f:5cc0 with SMTP id ffacd0b85a97d-371946a4289mr7661975f8f.42.1724126686926;
        Mon, 19 Aug 2024 21:04:46 -0700 (PDT)
Received: from ?IPV6:2408:8409:2423:4cad:2dff:7072:d755:c454? ([2408:8409:2423:4cad:2dff:7072:d755:c454])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d42bd74981sm4116429a91.42.2024.08.19.21.04.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 21:04:46 -0700 (PDT)
Message-ID: <2e662cb6-47d9-4bbd-855d-1f6d5edb8633@suse.com>
Date: Tue, 20 Aug 2024 12:04:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ocfs2: remove unreasonable unlock
To: Lizhi Xu <lizhi.xu@windriver.com>, joseph.qi@linux.alibaba.com,
 syzbot+ab134185af9ef88dfed5@syzkaller.appspotmail.com
Cc: jlbec@evilplan.org, linux-kernel@vger.kernel.org, mark@fasheh.com,
 ocfs2-devel@lists.linux.dev, syzkaller-bugs@googlegroups.com
References: <0000000000007541d9061ff83615@google.com>
 <20240819025112.2505463-1-lizhi.xu@windriver.com>
Content-Language: en-US
From: "heming.zhao@suse.com" <heming.zhao@suse.com>
In-Reply-To: <20240819025112.2505463-1-lizhi.xu@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/19/24 10:51, Lizhi Xu wrote:
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

The fix looks good to me. However, I found another issue in this function.

In the for-loop after the 'read_failure' label, the condition
'(bh == NULL) && flags includes OCFS2_BH_READAHEAD' is missing.
When this contidion is true, this for-loop will call ocfs2_set_buffer_uptodate(ci, bh),
which then triggers a NULL pointer access error.

If you agree with my analysis, please add the new fix and send a v2 patch.

Thanks,
Heming

