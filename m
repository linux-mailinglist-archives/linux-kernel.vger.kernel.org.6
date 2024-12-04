Return-Path: <linux-kernel+bounces-431277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3E09E3B6F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CCA5285BEE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 13:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC871DEFF3;
	Wed,  4 Dec 2024 13:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GdKnidh0"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C29E1B87CE
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 13:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733319582; cv=none; b=PdT7hxYU0V1zElNNXdUVKLHQWrfvfBkUt70yqoM2K/xtAGzt57d9VF5XbpaO2+cWPjf4+hJJ5mUsaTrKs7/ExtS0TOuUssGmEy3d1/hzaEWK433XmYNZayk9cYHwrUK35r+rV7sH9CzE48J9MsO5tFqjN3kCx7RPyzPNYP9dOwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733319582; c=relaxed/simple;
	bh=7WjEyDAG90e/vJCzJ9T8CrFecen5Z937gsdDejW/c7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LnAdX6aXPXbV7SRWy4P3KXsPGFxzwy/6W+7SDz5VWQvcOQmCQAcwL5mgVVY6T70fAD1kTFMGVEmarELOaFpl0BQ6oVSYjuZ3XARPJszb0A4pAHxfqXkSNcFum/JAUgJ8UkTJY7QTa3vHaF0h42e5S8scvJL3EaWaL+YYsOHWgb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GdKnidh0; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-215740b7fb8so115325ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 05:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733319581; x=1733924381; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aTiKz+swbArTBTc2TtQ/8EsE3LUCyapvxAkumVctM4g=;
        b=GdKnidh0dcst74Upja8+vFtWQa5JXKQxGf6a7kWFH3zE1Zp98Nc0DAlinfwJ0STIjr
         Ob2aQYDSwDfRwD5lqj7HWyNUZ0s2sOiipe/V7OgnZHE6Z3zdXWpSSgo1CUJ2rsGWiaAo
         obbJMfV39jPQWIgi8MXqFqjgMWO0QzkdQ7PTTwBEsKWJ63FNxOHekKcSOcJRAEvNn3U7
         qOK9/vNMXK3B1/k5Of45Hzd3v3AOCh73E4VsAxsOTPx8c/NvdAm0Bh7pNp8zrV3YFYGW
         84Ffv96JXxQXKi4QmoEBj8/gmQFnf0PIi7tjiQwUu5N5LC0UiiafxvT6njLNM6c7kLVq
         45Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733319581; x=1733924381;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aTiKz+swbArTBTc2TtQ/8EsE3LUCyapvxAkumVctM4g=;
        b=Sgh/e5HuM9TRNOxZzPFIxiyWI1XtIcidAWKhXk0BaB+N3N6EwB65PbdMzieKBqJcRn
         BIqgtuhj9JdAVsPuBRC57wOLGJ44MXzZpGIqf878Wzxqr2LCsGgG8pz0r5w6rECCUzWd
         MfpVabZzzZFXTiRwurf/Z18lzrb1gX2GODQBeSghtwVoHBxm/+4FON5ypwDBEnijA5yf
         iYYGr5mC2kum8mTWKbiVI8HjTpSO1py0K3F1f9h93wD0n3bB/LvG0ScUvrz9glfFuHoo
         8RQFALQHutLdI4vepTaNMIdG5nQhH6x+ifPEkgs6J9k5fVpxwNceXsmoZZf+ml+pvzu+
         Ty7g==
X-Forwarded-Encrypted: i=1; AJvYcCU9/Y+mkiZzovRMnyEiGusl8MvRE/q19fFifvYiUdwWWAzwFB1sRcJNLtpkMy23XzkHwnxzeHixmqVxeuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyczVepxq9M9cxbZEppsqw6nrLu0a6s8R30MzqA1qyLejdWayYN
	tBV9fkCk30kMesDOeW1sZqS8msojVQZVIFIkN0PnX4dk2u1obXqcdxczwkw2s9uZ0E2lgYh07cl
	VmQ==
X-Gm-Gg: ASbGncvmgGnXBQCxKuNbcEjzZOg2GpllAh4K+jO40dV+LSzqKrjzjC7hD3a9hiuAIA7
	Lh8UENaeO0MtkDgCwq6ew9uCQ1FrGzdNwEtN6WOSB33eq9lY0vJr1qd8l8owfhgO4cPwpZ0sv7O
	S9O8kqQviDHmWtm1wUw6KI+zuF+Xwr4mQksAzczX6mmJgFnqboXFqXkxIpKTnExF60KEcP9eQlR
	DKrTxa8pP4B6yOqp1uYAxOY/y/TFpcO9lKdhDHSKQpK26PVvaeErSoe0a2fS3WIbFp/81HxtC4c
	M1eZxj/uNEwa
X-Google-Smtp-Source: AGHT+IE8y3Oeqx7+pWQt/D6GLh1EYfEfWk9FHccWT2vIo90Klr9SrmZo7MkknMLsgkYZKIvMMOAjrw==
X-Received: by 2002:a17:903:2a83:b0:20c:e262:2570 with SMTP id d9443c01a7336-215d6c3ec59mr2506385ad.8.1733319580530;
        Wed, 04 Dec 2024 05:39:40 -0800 (PST)
Received: from google.com (226.75.127.34.bc.googleusercontent.com. [34.127.75.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7254176148csm12346608b3a.19.2024.12.04.05.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 05:39:39 -0800 (PST)
Date: Wed, 4 Dec 2024 13:39:33 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	David Hildenbrand <david@redhat.com>,
	Barry Song <v-songbaohua@oppo.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [PATCH v6 2/9] binder: concurrent page installation
Message-ID: <Z1BblcGDBvcdRTsO@google.com>
References: <20241203215452.2820071-1-cmllamas@google.com>
 <20241203215452.2820071-3-cmllamas@google.com>
 <CAH5fLgjMZw+58Wh58QVX2hD14=r-XkbtduTSchUPO14cJAJAww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgjMZw+58Wh58QVX2hD14=r-XkbtduTSchUPO14cJAJAww@mail.gmail.com>

On Wed, Dec 04, 2024 at 10:59:19AM +0100, Alice Ryhl wrote:
> On Tue, Dec 3, 2024 at 10:55 PM Carlos Llamas <cmllamas@google.com> wrote:
> >
> > Allow multiple callers to install pages simultaneously by switching the
> > mmap_sem from write-mode to read-mode. Races to the same PTE are handled
> > using get_user_pages_remote() to retrieve the already installed page.
> > This method significantly reduces contention in the mmap semaphore.
> >
> > To ensure safety, vma_lookup() is used (instead of alloc->vma) to avoid
> > operating on an isolated VMA. In addition, zap_page_range_single() is
> > called under the alloc->mutex to avoid racing with the shrinker.
> 
> How do you avoid racing with the shrinker? You don't hold the mutex
> when binder_install_single_page is called.
> 
> E.g. consider this execution:
> 
> 1. binder_alloc_new_buf finishes allocating the struct binder_buffer
> and unlocks the mutex.

By the time the mutex is released in binder_alloc_new_buf() all the
pages that will be used have been removed from the freelist and the
shrinker will have no access to them.

> 2. Shrinker starts running, locks the mutex, sets the page pointer to
> NULL and unlocks the lru spinlock. The mutex is still held.
> 3. binder_install_buffer_pages is called and since the page pointer is
> NULL, binder_install_single_page is called.
> 4. binder_install_single_page allocates a page and tries to
> vm_insert_page it. It gets an EBUSY error because the shrinker has not
> yet called zap_page_range_single.
> 5. binder_install_single_page looks up the page with
> get_user_pages_remote. The page is written back to the pages array.
> 6. The shrinker calls zap_page_range_single followed by
> binder_free_page(page_to_free).
> 7. The page has now been freed and zapped, but it's in the page array. UAF.
> 
> Is there something I'm missing?

I think that would be the call to binder_lru_freelist_del().


