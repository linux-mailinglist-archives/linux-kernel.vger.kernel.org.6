Return-Path: <linux-kernel+bounces-175616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C23188C22AB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 13:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F38721C20D8D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DDE16D320;
	Fri, 10 May 2024 11:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OnFXK3LN"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5801F16C844
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 11:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715338999; cv=none; b=gRmY4ZzOYXisFIAStya+FEjg98+/5B068DtU8XOpM4RdsGp8pDKG+o+2f1M3pJpUIqyc6QW08bdREPxgJK1qW0qGYU+azPW1+oLJlZuNcILXOTv/Y+DhDAHxUBXHbJ5qJg20XQdzE/DtorLpf54CcFdih6DjzYEuXAcIXBo0/xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715338999; c=relaxed/simple;
	bh=wbz6QLqwAzQ7aZSh96uDYPLlmW+YQ8YBErjkKgtAZf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKy+M29/44e8RSszPda/+GdXMN47M1PPMOkUGxmX86OHjBJ7u2b3jSFBHJw/lX4T11bEz04r3psL1BjyRuV/bL/obSAMNx/OrDtE3eBk6qNLy98TvGJVOIZp2Br9Ikt+LZOgpZN9rHS7y38yFPDr1u6eSdnXWU7z3YCg11CaSeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OnFXK3LN; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41f9ce16ed8so19345705e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 04:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715338996; x=1715943796; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rZVnCon/go9B9dTERYLh3cVfCiejO45V80tw8yzRpnU=;
        b=OnFXK3LNd3qIBd4IHPUDyCHe7YFH8K4f1wmX3wkfI5To+NukoQKy7J43XR2X4jTIA/
         R44N0+B6EN9iawhfyJXrxH0M5TfKQVQ0lR6ZCeDncrpz/93AbKf/DpcnDhDBCP6oozNp
         pVXXimf2ccp2aDFpByqRAkDMspqkFcVgBxby2q66VSg0NeNkAe+O0jMFeudn0QAsIpLA
         1QAOT/4McQGJQbYJk615cUv1OXdv26EiH/dSCp079NMLjWjVQEQjJaxxqmxihVhd+iLP
         lacVvEwSNjw/zEfn8ukiQXA7qJqZD5/1WuZ7GQhsd+w0kLooGdbhuW1Vkca7FyU9/rJT
         Djxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715338996; x=1715943796;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZVnCon/go9B9dTERYLh3cVfCiejO45V80tw8yzRpnU=;
        b=Zd3FIdQDHwk2SCTH27TYlUmV7Zr8/o7HOU+8EZ+fFadQkKbfyu+ixzI/6rrkr5Ta9N
         CqZRdE8v5e38StgjW+muHBXLxAaRlosMD/VNGALNotXWrXpwvGR6b+aNg9iABjt/e/kc
         fvjta90yJC+VOjSNzOtQl8Ba0009rc1hbDPkGPlsnQoJWDrs3nGf5MNZdG1bHcuj8CKQ
         dkCc1FtvNU4m2PxrkCPlk6fywlrxeZfYyVbii+LFXwrdrBW04UmTsdl27hm1MQnO7AGS
         DIi3iGEa/cK8sPL0P9iJ09amxIhxeZxJ3bN1N0l66heOvM3FeIf4YI6GSyrSa8PYJtOY
         5CqA==
X-Forwarded-Encrypted: i=1; AJvYcCUopJDNsdqW67E/NeTNYURhFy5y+LmVNUz+oJGnFHhKwKSoZaTBCFiPNvCKkOwariALCS8FXT5oawP+kp8XyqcxeH++yXGFMMlEZpMY
X-Gm-Message-State: AOJu0Ywm6YPJf+quH3iJwnOVUHSXWjUQhMBpKeciI+sJ0weKLmjbmiqp
	fI+V9haw7UVBfNw19kZ8ZwfwNII0Vs9gJjiPx5/auzeKHfzkDbgWa7tAf5SHIDsXIIaW9L0sCuP
	KdzuA
X-Google-Smtp-Source: AGHT+IGuWY6L0MSRVOn0uzCJoaOvNXNJY2lGiyGY+cCoQhHxynAUP/AA2bNpVJyYrxN7Tpo1w5Qlhg==
X-Received: by 2002:a1c:7910:0:b0:41b:bb90:4af with SMTP id 5b1f17b1804b1-41feaa44138mr22551875e9.20.1715338996268;
        Fri, 10 May 2024 04:03:16 -0700 (PDT)
Received: from google.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccbe8fc6sm59614295e9.4.2024.05.10.04.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 04:03:16 -0700 (PDT)
Date: Fri, 10 May 2024 12:03:12 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: David Hildenbrand <david@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, mhiramat@kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com, kernel-team@android.com,
	rdunlap@infradead.org, rppt@kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v22 2/5] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <Zj3-8GHR_EiWY7lB@google.com>
References: <20240430111354.637356-1-vdonnefort@google.com>
 <20240430111354.637356-3-vdonnefort@google.com>
 <20240507223402.206d6ddc@rorschach.local.home>
 <cc719813-ba73-461f-8b45-4728f926c151@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc719813-ba73-461f-8b45-4728f926c151@redhat.com>

[...]

> > > +
> > > +	while (s < nr_subbufs && p < nr_pages) {
> > > +		struct page *page = virt_to_page(cpu_buffer->subbuf_ids[s]);
> > > +		int off = 0;
> > > +
> > > +		for (; off < (1 << (subbuf_order)); off++, page++) {
> > > +			if (p >= nr_pages)
> > > +				break;
> > > +
> > > +			pages[p++] = page;
> > > +		}
> > > +		s++;
> > > +	}
> > 
> > The above can be made to:
> > 
> > 	while (p < nr_pages) {
> > 		struct page *page;
> > 		int off = 0;
> > 
> > 		if (WARN_ON_ONCE(s >= nr_subbufs))
> > 			break;
> 
> I'm not particularly happy about us calling vm_insert_pages with NULL
> pointers stored in pages.
> 
> Should we instead do
> 
> if (WARN_ON_ONCE(s >= nr_subbufs)) {
> 	err = -EINVAL;
> 	goto out;
> }
> 
> ?

I could also nr_pages = p in the event of s >= nr_subbufs... but that
really that shouldn't happen so let's return an error.

> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

