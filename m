Return-Path: <linux-kernel+bounces-381107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B51B9AFA6F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20CD31F21F63
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 06:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F511B2193;
	Fri, 25 Oct 2024 06:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HGW+acVf"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D246A1AF0BA
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 06:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729839380; cv=none; b=sRVuOApWsmeR/K4jkUhIkqi1W9ja8FCw0JpsW6xA3KwFuSX7f9CxINFmx0uRqWZNwSNfgcO/BrFmOdi1OFUulmzuC5oVUNLGKuGS/rqcftLtvnPQYX3UWTN1r4cf9DeahmurhVxNZVaYm98RUvVK7bt5Vf328ACDGbUQXg3+OQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729839380; c=relaxed/simple;
	bh=25Jvv1dRU/CqZfXqsQG04QoTrrK/hfjJxNA716kXjgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s8QBqDXYGI4Fc32W14dGRwuWIkCJrCBR5gTSHh1QORP+jrRGAf97l3j10gkhBVZdrJsKusT6zyMfeOza/LvKB/mFRYTQvt6vxxfJFw49gVlZACggv15gYDC1u7BBgX+hAY5V+OATjr6TUWPlILiaAo0jACVmPJsbTAsurHiqizc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HGW+acVf; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37d41894a32so1269779f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 23:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729839375; x=1730444175; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sTe9mW5h/PuKAECzVf3PYOF2hJitcmVtXP47DBZfOlw=;
        b=HGW+acVf4NFa0+p9uMryqVu/sVPuqdMP3+S1xRJCEue1OyVIJY37J5szSk11SOQ/Ul
         Grpk6Ls27CjqmDMpPG2tKSDyiiwVbNUOOBXfd+WpoduFhVID0Qer6YYxtbxbOKBDlCvR
         PyCLXQpM+pZW74QDDA41Gc7UBdrRx+q34MLqKJnCpPkC6OLbVIF9CwSgjAXRK+EDRE0Z
         nJ/pne1d+18H+EfnWFqKqbK5Hr2kbtwNywyGG7q6oNEKRJdh73mFz2wEZqq0Tc19sMdL
         qzzfmnd0tDo1/u1P+QNs5gXqlNweYZ5m/NM8uoBdrqXNvymO4CCpL7z2CVN84PCW18Yn
         ZTxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729839375; x=1730444175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTe9mW5h/PuKAECzVf3PYOF2hJitcmVtXP47DBZfOlw=;
        b=vFGjh0eG78N3DLZkvNAXU64vvqivT+dDgd0zR7DChK9/16sIf9eny0riE0vkMp8K10
         Yfv34FBkGf734cbINO7edCY+5StgCc3WzhlkoFa1njv0LOY2x8g7KLrCS/mnERDvrNwV
         PNRcGiUUT558zlT8RWkNv8qgDyBPkOzAXUaHDRufOMqoXoPVlDZCOqfbr+ubmzq6GHRG
         mJzdmnFB8BWdBRvRlfgomoXnxJ25Ql9jL5hfzSUIC8Cv9vNctC0XnvdIjMjTTaUB+Uzt
         J7LwmqJJqqyGpC+Vd8gzl7hkJGn/TVgPrO5JM810bhuVmuZI3AUrKe3L7atlEhLetD3C
         CnhA==
X-Forwarded-Encrypted: i=1; AJvYcCW/l79Diyj9XrpUztT07wJq++8Hu6LNGNsJQn1FmJ00YW0j4ChjFsjoEoOXhc88ysCRGg7sKa43O1EstNo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTrdhTRZ7DVpWdArMvZuMJQkxkfY+/3xvDeBTCE0PM4nlFckZA
	wOnbKUKPa/JIP0gjJoLhEZKdQ5HqBS+KSsQYFvJ5qQx5qidRbL+aQTnrIYJQT8c=
X-Google-Smtp-Source: AGHT+IE0m4dKzQ0gdgNM1YMMDkWjtRcILPbXQDIuhEVhrT0m4N3QefoLH4rvCAehNcVFfiNMs0Kh8Q==
X-Received: by 2002:adf:ec42:0:b0:37c:ffdd:6d5a with SMTP id ffacd0b85a97d-3803ab6710amr3757362f8f.6.1729839375159;
        Thu, 24 Oct 2024 23:56:15 -0700 (PDT)
Received: from localhost (109-81-81-105.rct.o2.cz. [109.81.81.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b70e0fsm745692f8f.73.2024.10.24.23.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 23:56:14 -0700 (PDT)
Date: Fri, 25 Oct 2024 08:56:14 +0200
From: Michal Hocko <mhocko@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH v1 3/6] memcg-v1: no need for memcg locking for dirty
 tracking
Message-ID: <ZxtBDglHg0C8aRTT@tiehlicka>
References: <20241025012304.2473312-1-shakeel.butt@linux.dev>
 <20241025012304.2473312-4-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025012304.2473312-4-shakeel.butt@linux.dev>

On Thu 24-10-24 18:23:00, Shakeel Butt wrote:
> During the era of memcg charge migration, the kernel has to be make sure
> that the dirty stat updates do not race with the charge migration.
> Otherwise it might update the dirty stats of the wrong memcg. Now with
> the memcg charge migration deprecated, there is no more race for dirty

s@deprecated@gone@

> stat updates and the previous locking can be removed.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

LGTM otherwise
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  fs/buffer.c         |  5 -----
>  mm/page-writeback.c | 16 +++-------------
>  2 files changed, 3 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 1fc9a50def0b..88e765b0699f 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -736,15 +736,12 @@ bool block_dirty_folio(struct address_space *mapping, struct folio *folio)
>  	 * Lock out page's memcg migration to keep PageDirty
>  	 * synchronized with per-memcg dirty page counters.
>  	 */
> -	folio_memcg_lock(folio);
>  	newly_dirty = !folio_test_set_dirty(folio);
>  	spin_unlock(&mapping->i_private_lock);
>  
>  	if (newly_dirty)
>  		__folio_mark_dirty(folio, mapping, 1);
>  
> -	folio_memcg_unlock(folio);
> -
>  	if (newly_dirty)
>  		__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
>  
> @@ -1194,13 +1191,11 @@ void mark_buffer_dirty(struct buffer_head *bh)
>  		struct folio *folio = bh->b_folio;
>  		struct address_space *mapping = NULL;
>  
> -		folio_memcg_lock(folio);
>  		if (!folio_test_set_dirty(folio)) {
>  			mapping = folio->mapping;
>  			if (mapping)
>  				__folio_mark_dirty(folio, mapping, 0);
>  		}
> -		folio_memcg_unlock(folio);
>  		if (mapping)
>  			__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
>  	}
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 1d7179aba8e3..a76a73529fd9 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2743,8 +2743,6 @@ EXPORT_SYMBOL(noop_dirty_folio);
>  /*
>   * Helper function for set_page_dirty family.
>   *
> - * Caller must hold folio_memcg_lock().
> - *
>   * NOTE: This relies on being atomic wrt interrupts.
>   */
>  static void folio_account_dirtied(struct folio *folio,
> @@ -2777,7 +2775,6 @@ static void folio_account_dirtied(struct folio *folio,
>  /*
>   * Helper function for deaccounting dirty page without writeback.
>   *
> - * Caller must hold folio_memcg_lock().
>   */
>  void folio_account_cleaned(struct folio *folio, struct bdi_writeback *wb)
>  {
> @@ -2795,9 +2792,8 @@ void folio_account_cleaned(struct folio *folio, struct bdi_writeback *wb)
>   * If warn is true, then emit a warning if the folio is not uptodate and has
>   * not been truncated.
>   *
> - * The caller must hold folio_memcg_lock().  It is the caller's
> - * responsibility to prevent the folio from being truncated while
> - * this function is in progress, although it may have been truncated
> + * It is the caller's responsibility to prevent the folio from being truncated
> + * while this function is in progress, although it may have been truncated
>   * before this function is called.  Most callers have the folio locked.
>   * A few have the folio blocked from truncation through other means (e.g.
>   * zap_vma_pages() has it mapped and is holding the page table lock).
> @@ -2841,14 +2837,10 @@ void __folio_mark_dirty(struct folio *folio, struct address_space *mapping,
>   */
>  bool filemap_dirty_folio(struct address_space *mapping, struct folio *folio)
>  {
> -	folio_memcg_lock(folio);
> -	if (folio_test_set_dirty(folio)) {
> -		folio_memcg_unlock(folio);
> +	if (folio_test_set_dirty(folio))
>  		return false;
> -	}
>  
>  	__folio_mark_dirty(folio, mapping, !folio_test_private(folio));
> -	folio_memcg_unlock(folio);
>  
>  	if (mapping->host) {
>  		/* !PageAnon && !swapper_space */
> @@ -2975,14 +2967,12 @@ void __folio_cancel_dirty(struct folio *folio)
>  		struct bdi_writeback *wb;
>  		struct wb_lock_cookie cookie = {};
>  
> -		folio_memcg_lock(folio);
>  		wb = unlocked_inode_to_wb_begin(inode, &cookie);
>  
>  		if (folio_test_clear_dirty(folio))
>  			folio_account_cleaned(folio, wb);
>  
>  		unlocked_inode_to_wb_end(inode, &cookie);
> -		folio_memcg_unlock(folio);
>  	} else {
>  		folio_clear_dirty(folio);
>  	}
> -- 
> 2.43.5

-- 
Michal Hocko
SUSE Labs

