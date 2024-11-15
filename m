Return-Path: <linux-kernel+bounces-411221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9E49CF4DA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 20:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8B1928A387
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 19:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBE61E104E;
	Fri, 15 Nov 2024 19:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lIhIc/KC"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C151D5CD4
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 19:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731699000; cv=none; b=RlihSn1JZvLaGfcyeLmi9GaiTxhD5HBfFIQWDTXzWB+kjLy/mi/Arj6nNLky6cSBU7bTl7Q+pu2MkE6f6P6iLIb8WiRZC+fDAqdJevpNu2ErE7C/l+1IYFZLp9KEjgzHGUQRxpRDLZnrC4dgsNTB8JaoA0kqMQAFSV6pCDe5TPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731699000; c=relaxed/simple;
	bh=1XEUtNvHfg77z1g9UMh9UlUWx/tdrIc8gqmOJJbuZng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iIK5poE0WBS3jROLNFNSZpAO/+78PZWBSGP7ePSGm4jDKVKGDH5eaU3P9wESmcmT6JpJTLX5o1jIImXX5TstEcFUriFxzMNnf5GOMQupcdVKx7CxZxrTvuWu1XHISbsg0eR1OeMdY7NpH4pejyMavDsIZQnqG3fZRrsX5HXw56U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lIhIc/KC; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4315c1c7392so39815e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 11:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731698996; x=1732303796; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GhfIN+LkULB+WZf5fU16xjb/0U+SgdFkvvrswJbNuZE=;
        b=lIhIc/KCL41sC8FSnei7bZKiCkrY1UWV58TjqjwDbD2gKUmy+cW1zHOyJBVG3xT0q9
         Icfo5E7THYogf3bNGlztqqYNDC1VIvO4REopB4ROLktgzHoxigmc4YoikVkCk6FmX9ac
         mkb5WEBp8mW+JYxjdIJKw8TI26YcadCrAZwsNAYSGL/Y8S0Llp86PEVcy03+xv7vsHcR
         IS7XwK3HJQOsAffpUbnRXVCY1Imvm9lveBnej6IINMJ6mD7rsf/OJq24+kRTxGYzEBUe
         Mv0fLB0ECwwNvLXwSiRhLvpv0BQiP21YAzH9SogWnf8gPZSpaZNl/ki7KeBWEUnRiouL
         u6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731698996; x=1732303796;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GhfIN+LkULB+WZf5fU16xjb/0U+SgdFkvvrswJbNuZE=;
        b=YGDb4CgCEbOmgHtqPD8UaT/Wq1fQBhuRXjO5mkPZqbdGcHuUqg0mTWXe9naI2gfIoJ
         l7ZNPT8lHySi6NaGEnfJo40ZDY+9UO70XQ6Wj8+S18uS0B7Mxn+Al9zIy9TpkO7FUO+v
         fFXpeodivxgNTiFozBETHFJFmt+HtfIXBb/PgyWopKG+dBahlNbSBm3oiFXvVn9L3gn6
         yxrGw+LoqtfjGquPfenwSolSf20aSkejpLdXHnkhw0hxc0zEwtgjNsxkwcAU1zg8I872
         n+Bj/xYn5oOZ1vgV8mAcRRj+VWvSk87f+tDCPGrAFxMG2L1Xq25riXcpNLylzBqR/UBR
         HXpA==
X-Forwarded-Encrypted: i=1; AJvYcCVyNviQNL/hWaEbRVoT6CdBQfj4FuyZvv0/1oG7wJN87SpTf+uFO+qfOcbMC3uPZNvMsRf8ZK7Y5XU3faY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSxxvJrRfYMl23xVv7+Mw5PypVkYgwxjEsTzqz9CqsOrG/x06l
	3+gaEH6pJhFAtbwoRwswPy+mniZoCBbv7K7csrapJwV3jYqtTzPw9F752h9DOtg=
X-Google-Smtp-Source: AGHT+IFgDEsfELXvXpNZVepQwwAa4PnvGopmuOtuOA/DhVT4j0RCdFmy14xA8QRUdvZzCjPcHhp82Q==
X-Received: by 2002:a5d:584f:0:b0:381:e771:dc98 with SMTP id ffacd0b85a97d-38225a10a03mr2749825f8f.33.1731698996088;
        Fri, 15 Nov 2024 11:29:56 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ae3128bsm5050408f8f.102.2024.11.15.11.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 11:29:55 -0800 (PST)
Date: Fri, 15 Nov 2024 22:29:52 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andrei Vagin <avagin@google.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Oscar Salvador <osalvador@suse.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>, Peter Xu <peterx@redhat.com>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] fs/proc/task_mmu: prevent integer overflow in
 pagemap_scan_get_args()
Message-ID: <1b18cec7-3d58-4cdc-b653-fb5790d04879@stanley.mountain>
References: <39d41335-dd4d-48ed-8a7f-402c57d8ea84@stanley.mountain>
 <CAEWA0a5vMq4vGRj4FVQXUR2unN-xAmsFt5ymi4SL+H0yfNpdfw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEWA0a5vMq4vGRj4FVQXUR2unN-xAmsFt5ymi4SL+H0yfNpdfw@mail.gmail.com>

On Fri, Nov 15, 2024 at 10:49:44AM -0800, Andrei Vagin wrote:
> On Thu, Nov 14, 2024 at 12:59 AM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >
> > The "arg->vec_len" variable is a u64 that comes from the user at the
> > start of the function.  The "arg->vec_len * sizeof(struct page_region))"
> > multiplication can lead to integer wrapping.  Use size_mul() to avoid
> > that.
> >
> > Also the size_add/mul() functions work on unsigned long so for 32bit
> > systems we need to ensure that "arg->vec_len" fits in an unsigned long.
> >
> > Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> Acked-by: Andrei Vagin <avagin@google.com>
> 
> > ---
> >  fs/proc/task_mmu.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index f57ea9b308bb..38a5a3e9cba2 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -2665,8 +2665,10 @@ static int pagemap_scan_get_args(struct pm_scan_arg *arg,
> >                 return -EFAULT;
> >         if (!arg->vec && arg->vec_len)
> >                 return -EINVAL;
> > +       if (UINT_MAX == SIZE_MAX && arg->vec_len > SIZE_MAX)
> 
> nit: arg->vec_len > SIZE_MAX / sizeof(struct page_region)

I don't like open coding integer overflow checks now that we have size_add().
Historically, we've done a poor job writing them correctly.

Probably the right thing is to add the > SIZE_MAX check to size_add/mul().

#define size_add(a, b) ({							\
	typeof(a) __a = (a);							\
	typeof(b) __b = (b);							\
	unsigned long __res;							\
	if (__a >= SIZE_MAX || __b >= SIZE_MAX)					\
		__res = ULONG_MAX;						\
	else									\
		__res = __size_add(__a, __b);					\
	__res;									\
})

But I think you'd trigger compiler warnings if a or b were a u32 so probably
we'd need to use a _Generic() or something.

regards,
dan carpenter


