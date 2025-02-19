Return-Path: <linux-kernel+bounces-522612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B906EA3CC59
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFE75189A834
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40B42580D3;
	Wed, 19 Feb 2025 22:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VLDXloDk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F94917CA12
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 22:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740004314; cv=none; b=FUrKyVF4ZD9wwoU8pP+a6i/IuqJo1tGSL3sW+B40FnQfWifdcoYJosYQ/VhG6WId5j/4oCC1ei7AE969UPH+dw9kmHZL5RN1KqPWCwO/NinXy8gHqTaPxXa//J/5Kb3OEsuBw1qxnfl5D5b265CJXl1YDrheSmb+20fvJycHetc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740004314; c=relaxed/simple;
	bh=BfXhadmmn5BoTgNdI8ix0+l4RUWut+XawK7kBFNdzVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f27TukNhAHBYqVKeOR6guDzfGzwICtM2ohOFYxl5J118xZQ24ezRFeOFywKQJYDey69IMAFSoyoD//7cxo90+xPXzeYy1YDYe94jkuVmT39eIh7LlQXtrlU6hE5VpAJxzFvEeRRIyr503UG05QPxrBhRBQvUpC0l8xUSaGlHAY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VLDXloDk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740004311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nwVRr1A3F8af1I0I1pL7CZB8ciVv71prpzpBnOe/YHU=;
	b=VLDXloDkTkGSRFP1kwDAEBDJDxYWwAh7+hmxJGzo9dO03oZnv3GEljan7IjfBjtp2DLhkZ
	zv0zmd5tfLlMjakPNb9Y0oIqfO4x3Zu//IS3aKjVhYDsXcKHhy0bsHOJqAIQhejE038myE
	y68+hLRImorYKHMFfs6xdC7YVvATmNY=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-jYfDdWmwP0mTDqSg3x61gQ-1; Wed, 19 Feb 2025 17:31:49 -0500
X-MC-Unique: jYfDdWmwP0mTDqSg3x61gQ-1
X-Mimecast-MFC-AGG-ID: jYfDdWmwP0mTDqSg3x61gQ_1740004309
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3f3a3c8eb5cso98644b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 14:31:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740004309; x=1740609109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwVRr1A3F8af1I0I1pL7CZB8ciVv71prpzpBnOe/YHU=;
        b=nqXcgHQSfqIr2cshrENzv/5gVQeQN5MM7YcSZZ3ke4oqwjjGl6++cWsoSzu08U6351
         o7Clqmbx/e7iblbnVnYO3UMMZcmX8NnyOKA8Awh8j2nSmXvRusdghiWKD76zazSwYy9O
         EnkvvnBl4pfV3nfhmQ3Cib8lVvqK4SrM+iAZKzUSQESCCAFhzhJ5LhbnMUOitUd8awOK
         ZNMdOuTPHmH5lB/i621zRbRXx7gmIEYYFmLnqReB0lDnA3DmJDQoyufxjnp6n7mEVrH4
         E2nT5QxQ9Z/E+qvcevMqmWRZGWGX6dJ3YK8BS2bIpcDvk68aWnmOoSfSshhz5JecmAnR
         yIXg==
X-Forwarded-Encrypted: i=1; AJvYcCXRZYDB8n4tp12O9AHmoKXC6ANIYudk/TuT6sLdqIgMuEMfapZmYhJhHVbzdUBwnxOxvECMCyzvvJGQIts=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsuQYEaokNzJpWjMVevxUVfPERq8p4vkyv3lsam5k2dmFE6s3/
	U6QmvaZCEamyFDgC/FSQ4lpiFRuFN7/oF7wU765M6ymO2Xca3RqhWinGk51/EF8ndBnynOYldNz
	7wUEgCqGhkLl+KZ9k0tB6N5Ae3f1jLERkOWIWQVLpG5OcggFqakNxYAp+fqN2sA==
X-Gm-Gg: ASbGncuCIFz9G0T/imI0jeDUdiflMxpWhFesUHIZrjUkGG3S1ahpOBriP0drKougfzO
	f1HtrFL1EJEKyzV0RkZj2fPYq96iVOlIuXbMTvSW+4c2PuWHoxdqJgPYUNUIiNuYcAGO6dp6cJW
	1Gfrw+CHWUc+LFLDQgOuQ3dGsDW8ipYgBaS8xnaLM4VP8b89qOm2IrgXOB224q9T225Fv46LnVE
	TDjFFWJTLmR1OTnie61GJSzm/pIIhke9z8AfHa3J4XutDtrwIL36cZ8q0A=
X-Received: by 2002:a05:6808:1898:b0:3f4:eee:1d34 with SMTP id 5614622812f47-3f40eee2300mr4932016b6e.31.1740004309203;
        Wed, 19 Feb 2025 14:31:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHM2PFa4HNvuvw4ma9z+4Qp4NktXSsfaVezIT+bwiaMvhEnH644AQ6aAcn9dRdBsyRDf81xfg==
X-Received: by 2002:a05:6808:1898:b0:3f4:eee:1d34 with SMTP id 5614622812f47-3f40eee2300mr4931990b6e.31.1740004308847;
        Wed, 19 Feb 2025 14:31:48 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f3ffd5a695sm1832129b6e.3.2025.02.19.14.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 14:31:48 -0800 (PST)
Date: Wed, 19 Feb 2025 17:31:43 -0500
From: Peter Xu <peterx@redhat.com>
To: Barry Song <21cnbao@gmail.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, zhengtangquan@oppo.com,
	Barry Song <v-songbaohua@oppo.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Brian Geffon <bgeffon@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Lokesh Gidra <lokeshgidra@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
	Nicolas Geoffray <ngeoffray@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Shuah Khan <shuah@kernel.org>,
	ZhangPeng <zhangpeng362@huawei.com>
Subject: Re: [PATCH RFC] mm: Fix kernel BUG when userfaultfd_move encounters
 swapcache
Message-ID: <Z7Zbz7_39JZgdLYa@x1.local>
References: <20250219112519.92853-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250219112519.92853-1-21cnbao@gmail.com>

On Thu, Feb 20, 2025 at 12:25:19AM +1300, Barry Song wrote:
> @@ -1079,9 +1080,19 @@ static int move_swap_pte(struct mm_struct *mm,
>  			 pmd_t *dst_pmd, pmd_t dst_pmdval,
>  			 spinlock_t *dst_ptl, spinlock_t *src_ptl)
>  {
> +	struct folio *folio;
> +	swp_entry_t entry;
> +
>  	if (!pte_swp_exclusive(orig_src_pte))
>  		return -EBUSY;
>  
> +	entry = pte_to_swp_entry(orig_src_pte);
> +	folio = filemap_get_folio(swap_address_space(entry), swap_cache_index(entry));

[Besides what's being discussed elsewhere..]

swap_cache_get_folio() says:

 * Caller must lock the swap device or hold a reference to keep it valid.

Do we need get_swap_device() too here to avoid swapoff race?

> +	if (!IS_ERR(folio)) {
> +		folio_put(folio);
> +		return -EBUSY;
> +	}
> +
>  	double_pt_lock(dst_ptl, src_ptl);
>  
>  	if (!is_pte_pages_stable(dst_pte, src_pte, orig_dst_pte, orig_src_pte,
> -- 
> 2.39.3 (Apple Git-146)
> 

-- 
Peter Xu


