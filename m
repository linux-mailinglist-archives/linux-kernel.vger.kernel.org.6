Return-Path: <linux-kernel+bounces-170032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D39D88BD0E2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 16:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E98611C2134D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 14:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754C6153583;
	Mon,  6 May 2024 14:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CiBJPl+u"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2A31534E5
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715007554; cv=none; b=JmC4rfrCK/chvkT73KcLikPlY5wMyygH1ZlMAmuKhQUxSocIZBLQSvhmnAcfXq+pkWgn56UkmtUkdIK1T6ppB0UqFaN5trEhDB6Jen6FtKuB87kMfBO8sPCuogeQ2cwrLPODqtcW3GnxyxYvXONtllZt9frLuEbN+rnVK5B4srY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715007554; c=relaxed/simple;
	bh=1erwTJnls/2PKUoCQh7VD31qDN99YRlnp3qvueSRMe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tPLHJB52HgvdyPKLK0K3OTNrRVgVDXBTk4ZCpravzxZCHmE6FZ09eHplWzYwwjzs/84OR+maFhVlWVfGttlU1hjHylFCLcHPi5a9gTW9xeeUNTb5RRakwnCHMiWyOnze+LDakGJspKYbzEwahcf9VwK4f8MO0l8F3fFUpKAseKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CiBJPl+u; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5f80aa2d4a3so1406325a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 07:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715007552; x=1715612352; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IunX6IRuqcgUzJVC/f5W6bbijjjJpOpS2R20SUSIYXo=;
        b=CiBJPl+uCAZ7oLEFlX/z4LfvbLCWgiLzaJpuP+hAjSW2mXSmNkmaNvNruLjkC7JKav
         YJ80sAin+TLOvl7yUf6D9z7nckvA5vzvaUzTPrcLLsYn2YRYktIj+JFNb8s0Gty9HNKN
         Y+LRtEv57taqdTxzTGYh/gLMRi5Rzthv2Vlbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715007552; x=1715612352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IunX6IRuqcgUzJVC/f5W6bbijjjJpOpS2R20SUSIYXo=;
        b=GaZiFUfTKM7eZMnaUm9o1qlvDmYO5Reoalw7Wjb6Sr72pElex61QMUjnx56qAV5ELU
         DR/lkM8bXybZd7n9f0I4fMAo4hNr1RhccGK1V+juOlEenuu48aqzyBTD057WL+0WCIx2
         Gw2A57bkjqBdM4mUr7DJLwQTON2bEaKFWbJZjjM9hk4VrQpqZ4NNKrd/c2LlzkQUuvD3
         jzpk7G/5K8z6F1xupd5hG2BIGHanw4gS+GZnj5OA88Hw1OXQKz280ixSUdIUuwerad+P
         d1irCj3WXJetCZneHEGO0EPRQbyvaibmsmH3joyrlagXHZdmTDk3Rp9p2ztBm4Bb9QIC
         5roA==
X-Forwarded-Encrypted: i=1; AJvYcCU7yOZB/HbUskiU+QWgREBM2wKvT8Kf9/JrPpdlrtjUb6GHBcrc+E6x2d865AzsLNekkR1ffDb1vldcy/QWFCsy/2xKeXdf0Mcc6xuH
X-Gm-Message-State: AOJu0YwG7cbt95CJuqVwKSl3rBp4NIQtj35Mqzjmc41/cpyjh07YBRJs
	EaEEVGzP2f8GMZmEZXU9U7F8ZMqQFzgH0XoZiL7/+3kjBbRuBofyTSu3eA5alQ==
X-Google-Smtp-Source: AGHT+IGTrUq92ztvkp/luk79tG6ey2G6nGljGdwae1LfiYZHjJkJWBHTJ0ECyHaD/8YNa+BlzfdREg==
X-Received: by 2002:a05:6a21:3943:b0:1af:a451:52ab with SMTP id ac3-20020a056a21394300b001afa45152abmr4783770pzc.48.1715007552476;
        Mon, 06 May 2024 07:59:12 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id le8-20020a056a004fc800b006f475027095sm2584859pfb.167.2024.05.06.07.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 07:59:12 -0700 (PDT)
Date: Mon, 6 May 2024 07:59:11 -0700
From: Kees Cook <keescook@chromium.org>
To: Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>, Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	syzbot+41bbfdb8d41003d12c0f@syzkaller.appspotmail.com
Subject: Re: [PATCH v4 2/4] mm,page_owner: Fix refcount imbalance
Message-ID: <202405060754.4405F8402F@keescook>
References: <20240404070702.2744-1-osalvador@suse.de>
 <20240404070702.2744-3-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404070702.2744-3-osalvador@suse.de>

On Thu, Apr 04, 2024 at 09:07:00AM +0200, Oscar Salvador wrote:
> Current code does not contemplate scenarios were an allocation and
> free operation on the same pages do not handle it in the same amount
> at once.
> To give an example, page_alloc_exact(), where we will allocate a page
> of enough order to stafisfy the size request, but we will free the
> remainings right away.
> 
> In the above example, we will increment the stack_record refcount
> only once, but we will decrease it the same number of times as number
> of unused pages we have to free.
> This will lead to a warning because of refcount imbalance.
> 
> Fix this by recording the number of base pages in the refcount field.
> 
> Reported-by: syzbot+41bbfdb8d41003d12c0f@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/linux-mm/00000000000090e8ff0613eda0e5@google.com
> Fixes: 217b2119b9e2 ("mm,page_owner: implement the tracking of the stacks count")

Does this also fix this?
https://lore.kernel.org/all/202405061514.23fedba1-oliver.sang@intel.com/

This is a report of the backtrace changing, but the warning was
pre-existing.

> [...]
> -static void dec_stack_record_count(depot_stack_handle_t handle)
> +static void dec_stack_record_count(depot_stack_handle_t handle,
> +				   int nr_base_pages)
>  {
>  	struct stack_record *stack_record = __stack_depot_get_stack_record(handle);
>  
> -	if (stack_record)
> -		refcount_dec(&stack_record->count);
> +	if (!stack_record)
> +		return;
> +
> +	if (refcount_sub_and_test(nr_base_pages, &stack_record->count))
> +		pr_warn("%s: refcount went to 0 for %u handle\n", __func__,
> +			handle);

This pr_warn() isn't needed: refcount will very loudly say the same
thing. :)

-- 
Kees Cook

