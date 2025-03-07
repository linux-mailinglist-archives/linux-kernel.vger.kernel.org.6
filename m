Return-Path: <linux-kernel+bounces-550640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EBCA56256
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3487618975EF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 08:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710C31B042E;
	Fri,  7 Mar 2025 08:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jBYQKk87"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8D328E8
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 08:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741335212; cv=none; b=Fhw3Fy/pjIsaIEzt2b1WweOMIi+XFk7AjiSgJQqsvMYGzF9pIa1GnyK2P77NxRXZnSzx2CPivSoV3b37O1va9zEO4sSm0uqykkg60KXCfwoozQGjaHqTUHWYtABkPhXgUwFXzzZWKLpJJLMqHOTIKjQ0gQStceHBai9r5PflBW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741335212; c=relaxed/simple;
	bh=ECs6qqv5g+PaozPsZTL0Bl8Y4neLxLgQXeHYIwD24p0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gpnwh8EOfAIwzE5chDQYLF9iEeob02Yp3v6/m8qNt8iTMKqOIHjDKarcFY2/xAhDlIAl005oCHn34l8BVKHKYXI8hyOB2I9SpNNJJbJmOgdzEdh0fWjNrOqO33gQql2vSC1vnsNPN32fHrDgbFm9BfOm8pFqtq+PIry/livdxcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jBYQKk87; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741335209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QO4aHW/EIqvVozmspxL85e+uicH6KLzd8n0qPmV6aaE=;
	b=jBYQKk8746Gor/ygTadJMH6m/wYsvnQbIWwzhjT07g/oWrsQw8mplIq2JAiORmQz+wQjVL
	z640vA287G8Jhk4ft6hWrlS96VqxzkasdH28BAOrZuRzX3C1AdL8jMs1JnU12VWEtW52DV
	sQmIksNmOmApXRZickW8vAGrATDCrTw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-CWtUr09LPLutPBDl0XPPkA-1; Fri, 07 Mar 2025 03:13:28 -0500
X-MC-Unique: CWtUr09LPLutPBDl0XPPkA-1
X-Mimecast-MFC-AGG-ID: CWtUr09LPLutPBDl0XPPkA_1741335207
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4388eee7073so13266445e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 00:13:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741335207; x=1741940007;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QO4aHW/EIqvVozmspxL85e+uicH6KLzd8n0qPmV6aaE=;
        b=tn6NhAnzOAkF9xpY1xAQfClhmqddp1ca2EotbebjdsMpde2iEzJv2WKzZC4rHipSZg
         qgGzalzVCGjo61HD4w1ZVnRi3uZD28d39SuJj9jt+7SX2KJfnAa4p3EUIv3n4vTWJdBU
         VXZ+U2NKijIi1uMiZb2shI/9tCnoS3cbLvLy+t/iu3EVXrUM81rfR7miszzD8RJKFcj8
         p6zkB6gsUVqdixEDvyOjRJwgR8CSKOXLI5of0kzYbuZ1n7Z2SQfNJyQ3HAx1L6GKEz1G
         SOXwM6Xfd841lUVgmNHg8w+HmJ2HzfZJmNuwIEeboaXD8yA3bXazeAZfvgY+wfVQKrWn
         eWPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBuqm27GDQGsLbP+ffuLzerSOwJq+CTTmAQtVaWk/mmNOLT9+921Fx+2IVKswmZTXeLOjUd2R8kEKoyxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLvCOJj+jeVsnoFI25Krs2YUIi77JUeTOnn1HdLhDdzJ17Mei1
	q3DeFL0vw9cJdo6uEROkk/8daPofMYtiUDJ/QdFcRI4dmzGoX0SJEb0qQbFNn9C1Jr15JojXfxk
	nOaSCHZThiMSQHh21kDEGMhyb+gat5ZbFm8N6Pu1QCkfA8PhfL7F9lqIWzbaPrw==
X-Gm-Gg: ASbGnctwoBXsCUGSVoE9RKKlU2VlHEm6fkfzgvLc+Aw8TIk6aN7ulE/e77NNiEVz7oF
	EFkvQRXXYOPtEwM0Rsz20++6+hOlYu4X67UvMzV0uqvU59bpUnNyZ+lrIMK2zJM0C1iWOJftuH/
	EhrD6Bvt2zExhE1T75O27q/7NOjLln5/gWPFkA7eWqT9mZJfpBUWPCfo9q7TaqGNjNZcdltLuOG
	6IsqCHQKGaMP7GwDEqweUaKeMb47Zng0w5tVQkuujNLufEjFbT1IyBbJBiJimBM05Hu+WQIP78g
	OOFBq1YJ1+NHjsSSXTfl4/UD6mbKGVMfS967wCKJGDYCTPFgjNvWgwppiBDIq3psTd7wIfxc4kL
	nTHbgwV/Af9Op2cxOq4nSF6AVphRPOq3S5lM0Vw==
X-Received: by 2002:a05:6000:144b:b0:38d:d166:d44 with SMTP id ffacd0b85a97d-3912985366amr5097585f8f.23.1741335207036;
        Fri, 07 Mar 2025 00:13:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbLoB9vEQuEUrUCb7OUKaNWOamOIwJBx/fzl0cgU09bEmozCG1yHUEdYjg+atR68mZx7vIeA==
X-Received: by 2002:a05:6000:144b:b0:38d:d166:d44 with SMTP id ffacd0b85a97d-3912985366amr5097570f8f.23.1741335206665;
        Fri, 07 Mar 2025 00:13:26 -0800 (PST)
Received: from ?IPV6:2003:cb:c721:7400:ab0b:9ceb:d2:6a17? (p200300cbc7217400ab0b9ceb00d26a17.dip0.t-ipconnect.de. [2003:cb:c721:7400:ab0b:9ceb:d2:6a17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd94913fsm42822315e9.37.2025.03.07.00.13.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 00:13:26 -0800 (PST)
Message-ID: <90c8183e-d5bb-4460-8c93-ab9bbe977d66@redhat.com>
Date: Fri, 7 Mar 2025 09:13:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] mm: page_owner: use new iteration API
To: Luiz Capitulino <luizcap@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, yuzhao@google.com, pasha.tatashin@soleen.com
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, muchun.song@linux.dev
References: <cover.1741301089.git.luizcap@redhat.com>
 <93c80b040960fa2ebab4a9729073f77a30649862.1741301089.git.luizcap@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <93c80b040960fa2ebab4a9729073f77a30649862.1741301089.git.luizcap@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.03.25 23:44, Luiz Capitulino wrote:
> The page_ext_next() function assumes that page extension objects for a
> page order allocation always reside in the same memory section, which
> may not be true and could lead to crashes. Use the new page_ext
> iteration API instead.
> 
> Fixes: cf54f310d0d3 ("mm/hugetlb: use __GFP_COMP for gigantic folios")
> Signed-off-by: Luiz Capitulino <luizcap@redhat.com>
> ---
>   mm/page_owner.c | 84 +++++++++++++++++++++++--------------------------
>   1 file changed, 39 insertions(+), 45 deletions(-)
> 
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index 2d6360eaccbb6..65adc66582d82 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -229,17 +229,19 @@ static void dec_stack_record_count(depot_stack_handle_t handle,
>   			handle);
>   }
>   
> -static inline void __update_page_owner_handle(struct page_ext *page_ext,
> +static inline void __update_page_owner_handle(struct page *page,
>   					      depot_stack_handle_t handle,
>   					      unsigned short order,
>   					      gfp_t gfp_mask,
>   					      short last_migrate_reason, u64 ts_nsec,
>   					      pid_t pid, pid_t tgid, char *comm)
>   {
> -	int i;
> +	struct page_ext_iter iter;
> +	struct page_ext *page_ext;
>   	struct page_owner *page_owner;
>   
> -	for (i = 0; i < (1 << order); i++) {
> +	rcu_read_lock();
> +	for_each_page_ext(page, 1 << order, page_ext, iter) {

I realize that we could get rid of all the temporary
page_ext variables and simply operate on iter.page_ext.

If that makes sense, it could be done as a cleanup on top later. Thanks 
Luiz!

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


