Return-Path: <linux-kernel+bounces-431311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FE09E3BCF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84A6B285CB2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 13:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4B51F6686;
	Wed,  4 Dec 2024 13:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PLbP6FLO"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5A31E0E18
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 13:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733320519; cv=none; b=X92Z6Z8wYvcqzgwjsjhfABQv9t2lDS/GYEkysMRvxAIqJXyyixSl769VjrAjIO7UprHH/RM0NH69OFavCvRZWOydSzkKYFE+xn8fO18VrHMvT2JO+9UBesOgaeBbbG+NTgdYMWJKreSaPdmvXkippPAFmGtB71PhUT+V3eG/y3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733320519; c=relaxed/simple;
	bh=zSlyAfMKjMlD5d4tkS5/g5brX19pSMk5FQkVq3WQHgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OUM5EZh4n876cw5EBiyIL0PoG3EzgvGYRQtlUpA1NpMDqVkDvVBBW/zjdhxKln+O4xjWSeD88BT4mujzGGqZA+kdHhtmpUNGGiNLGtfH/JEggV5hpgnvptrADN1ChKJkGubLtqwIvLf/hvSG1KGPJerj/wAbJZHKNkKI0BAIn1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PLbP6FLO; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2155c25e9a4so124455ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 05:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733320517; x=1733925317; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x638IQv73ev3kL+5x95GVwF3inC5lSOYKtCxOMkEmgY=;
        b=PLbP6FLO3lnu6g7cQ1taD6kDEeSVFztIbHIqy9/ujj3B8YaxPb+eZ5qy/SJXnOXBz8
         okC722VT0fNR3a6bhF0mUjKxsHv1ATqqbL8/BNRsVQitQwN99KTGawxYRVewJ+Ni/Olw
         ZcrONEJmujfW8nJLDCRiH0mbZcR7+YvhT9X8m+VIYKWu20QimsKXkhXEw18t4mxmxEG2
         LwOMRne0Of+RUnUtfBMdRS1hxcIWtMuX2Mb51WCK+/G493NawgkODzCOhNMk4hmUT6XM
         OC7WYl9uTImn36BVQS3hsTl9MFk2Yp3GSpNayAE6Onr9QkhkwwNDgJiTIsBHd47G6o0G
         ZEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733320517; x=1733925317;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x638IQv73ev3kL+5x95GVwF3inC5lSOYKtCxOMkEmgY=;
        b=GsNjAr1lh8wlkO0hXtdtHaymG+Jwtkh+DaiQxCZh3C43fddlM7kYHGdeaV4tnDxLvw
         ehysJ1LOCw743to+Ie17qJgs38jlrxqcaOyXEJvz6+iV0HpqXdH+1WSZzjFwfQw3uUVu
         pl31beyBDq50dNcSxp+Mf+1hBx9Fs6i/HdnG2atpo/+qQ55141ESpmko99YXyeAXJzA1
         vY5NDyVSpk/GiwNwd3FM0ayfJTB159C6SRalMP/sjL4Xupcjk8UAsBqhiR9kygBgdlgG
         nVpxd+9jSZ9QcqOMEBm73/3g8fQcIpLFI+ywTKYpsZ+Mn45kTL2wcao1XbSG61ZFuCCv
         5rag==
X-Forwarded-Encrypted: i=1; AJvYcCVJojrMSIOUJQv84isnfwT3FFo3VMWlycwYl5a62+0CzsZzey6gHdQ+3SjHF7EZgre984DJVnri1KcFvzw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0TD2ChKSV8fQLXKlx0n4D55aOYtK5Ts8J7nHm2KA8tcdqr8fX
	3EkZvteq9qLMV3vix1PwtrORy1Tgukm9m6atnlmC86WVBUQvT46esG3JO4Bo6w==
X-Gm-Gg: ASbGncsWo7S7J+nqlQkCyDucCBDLdweNI/HMNhzZ3tNU6pal3oH2kbllKEyZhp2+cMF
	mhpJ43/H1CiAFaOCMroSsB5ZSIrtbJBp0kWcI+8O0q666YmbrVI/k0MlyXZX/Cq+3n0bzlY22Oh
	4yLm8yd2FLUIRDbVwk+A8a8G8SqJuNXKVi2LOrRXHum09/Vss7Wv+QEbDCkdd5bslSjiTw0E26C
	KWEfQOdFT8ia/NDiIn434ntUFApTjeyDvVGgHDjQJ+evrSxr4g2oR81ogbuD8xfv7P5MCHkBpQ1
	lwcLhJTdl/Za
X-Google-Smtp-Source: AGHT+IEM3LT+EA003bGz4ycOOOax+XMH5GTTK/mIB2/u5KP6rMr/ViGcyyN7o/Y6fCR3ZJjJco8j9g==
X-Received: by 2002:a17:903:1381:b0:215:7ced:9d66 with SMTP id d9443c01a7336-215d6c3e407mr2485915ad.10.1733320516640;
        Wed, 04 Dec 2024 05:55:16 -0800 (PST)
Received: from google.com (226.75.127.34.bc.googleusercontent.com. [34.127.75.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72565b4868dsm7404337b3a.105.2024.12.04.05.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 05:55:16 -0800 (PST)
Date: Wed, 4 Dec 2024 13:55:12 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	Matthew Wilcox <willy@infradead.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [PATCH v6 4/9] binder: store shrinker metadata under
 page->private
Message-ID: <Z1BfQE6IMI9nqUIB@google.com>
References: <20241203215452.2820071-1-cmllamas@google.com>
 <20241203215452.2820071-5-cmllamas@google.com>
 <CAH5fLgiarbw82R34Ct=GP3-6ophJOuhuRoerr427gHsEPy+Rcg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgiarbw82R34Ct=GP3-6ophJOuhuRoerr427gHsEPy+Rcg@mail.gmail.com>

On Wed, Dec 04, 2024 at 10:39:58AM +0100, Alice Ryhl wrote:
> On Tue, Dec 3, 2024 at 10:56 PM Carlos Llamas <cmllamas@google.com> wrote:
> >
> > Instead of pre-allocating an entire array of struct binder_lru_page in
> > alloc->pages, install the shrinker metadata under page->private. This
> > ensures the memory is allocated and released as needed alongside pages.
> >
> > By converting the alloc->pages[] into an array of struct page pointers,
> > we can access these pages directly and only reference the shrinker
> > metadata where it's being used (e.g. inside the shrinker's callback).
> 
> Using many allocations instead of a single array will increase the
> number of allocations a lot. Is it worth it?

It's not a lot, is as needed. Yes, there will be some transactions that
need to allocate a page and the metadata here and there. However, the
vast majority will find an existing page.

Another way to think about this is how userspace defines the mmap size:
It makes sense to leave some slack beyond the expected usage. This patch
avoids preallocating all that memory for the "slack" which will end up
unused most of the time.

> 
> > Rename struct binder_lru_page to struct binder_shrinker_mdata to better
> > reflect its purpose. Add convenience functions that wrap the allocation
> > and freeing of pages along with their shrinker metadata.
> >
> > Note I've reworked this patch to avoid using page->lru and page->index
> > directly, as Matthew pointed out that these are being removed [1].
> >
> > Link: https://lore.kernel.org/all/ZzziucEm3np6e7a0@casper.infradead.org/ [1]
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> > Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> 
> [...]
> 
> > +static void binder_free_page(struct page *page)
> > +{
> > +       kfree((void *)page_private(page));
> > +       __free_page(page);
> 
> I would cast the page_private to a pointer of the right type here.
> There may be tools or future improvements to kfree that use the type
> information.

Ok, I'll change this. There is also us humans that might benefit from
using the explicit type for context.

--
Carlos Llamas

