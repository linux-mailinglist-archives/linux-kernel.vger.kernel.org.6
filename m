Return-Path: <linux-kernel+bounces-416597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5DC9D4760
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 06:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5944281879
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 05:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9699218660C;
	Thu, 21 Nov 2024 05:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oDhhG2Xo"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5482309B6
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 05:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732168596; cv=none; b=Ugb8BcZ23yC6g95n0yw1laQHwZthxeDpOYrhfYgHO0ERaPGnoVB1ZsF/fHEPnORYfOkEPPBoGdIHiTwP0yLy0mG5nEfXneYnpLVEAMbFbgDB1ifS0giorTHI3hCAN1eAEH582AhfcWw4V3DHl5Uv7ZR679a+TRFI3edgl8XhRUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732168596; c=relaxed/simple;
	bh=fEvs0wqUq1pGbQSeBlX5t1hYGIuFpTFgHf+seh3VEiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YpRDPEZuMfSIxOFL6T0toLaCa39NxyMgu3Kh9oWTKWuJ4eA/9dK9OrFy32oKx67mNeb8k4l1hwkk9424HjGKa27gTmhxGydJRp4xViedEazFEBV3orI7X3rYIPHuWbazwUyaTBRAD69JS243Mq9S81RrzJMpNfyn3cbYG/URJ9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oDhhG2Xo; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-211f1a46f7fso83885ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 21:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732168594; x=1732773394; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VVSAnP4TflTJCgrgG1ZLQmMziU3kj+YA8z74aipilNw=;
        b=oDhhG2XoaEXeeMMO8J2t91UdXUGng0rHsbziPD3lzRRJpPJUI6rSYB7DOOpYYbhE4p
         sOWdTSwIN8l1I2U093jk3ZvUrcA/KqSh2G1f7c4P4wc8Jjzvf3SHSozG2oj/c5GhLs6X
         pU1ZQQz7yTIYr4A0ndB+cQvfeNM6zgj6OYPkQjxTHgd9d0Bd3iR2vaCt01e9ND43fLMM
         DkWmaoMGbsNlLUD4H9wYFiBX9N6pFpEkYTH888PAAIxjWDnkstdWa8M1lMSOQFn4+boh
         Subh58jd6myxGHWcsBwKQBIm1OFMf+izR3lIE1xx7EXkA061DbTmkTonpISdXZCeEKTa
         ioTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732168594; x=1732773394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVSAnP4TflTJCgrgG1ZLQmMziU3kj+YA8z74aipilNw=;
        b=KBOPVg7OxvwsfTqG8AYQaFVC8/Smwzz9TBIBxbGgRkymDqxpdcBpN5E2s1gXWMvwPI
         3C7h47wRO4iCkf2RrLl7H3Mw+HlJiuMbRJcOE51rG0kLHhoqYhI/18jsVhRM5Vy6EYNF
         LI4IEbuatoPadBimrysH2OI8x8Hdx+XSW/sYdZ8h6FB+70/yoHObvrhFf/K/ZHZfn3tT
         DT/XGAHigfoLaH2QGkHQKe8jq945tMK799BD8Lfeqo4VHw9dOakrZ+4mxbW0AuMVg8Bt
         p9CcwKP6XaNzRprX5AcizIrLI5AmPgXntq+NfECJ2VhZNr/kkq9uYmkmU0XLV9K1uZJx
         8a6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUyy4IhzhpGNrS+CGfhGNWSPc240rqv9l8VEcF2/FXBSYWzP1oh4ygjQYujUdxQRxw+ucLTIEVnszLvL3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZE2W5lp+sSutjhIVisvngTrQLn8mClVKMDFrM/sPmDiRul91+
	fFVVTGAcWMwNjNNls/RrSFvP5ZF6DyPQpwD9AuBWQf4bpA3v7+Uj3t8eVl7bPQ==
X-Gm-Gg: ASbGncsb/o1aml5DPCCCYg82DR9Oub9rj9qqIqL6xq+h5uMl5UvGPbZT5SIiE/fV73H
	EptycjGQCvfSMoRv6gxyhvIFnGHzIZzwRrte/1bOr/alqvCuZpEgJ266Fa09oTyZEp1rKliprqP
	beSdv+a0hqa+azzkeYI9/lVkRTaVMZZ2Hc1G75Rvb68R0FDA9ZfnHC6A3B1VOfohDhbfDMdffiS
	S+R2Zx13K7R9oB7y9WIdQemKHUq3jUJ0Mlnd30DbOYnx/qAyfJmbIN1zUSF8y1TZ2UDAOJxHUmo
	7JKUNKCRQm/xq0o=
X-Google-Smtp-Source: AGHT+IFnFcPpFQtszrbdLqXc+P17UK2s8KSCW1MBx3pcbWddPg5oRxpERqlDEVt8spm1Kk6IVTsNlg==
X-Received: by 2002:a17:903:2d2:b0:20b:bc5e:d736 with SMTP id d9443c01a7336-21287a03277mr1161545ad.11.1732168593644;
        Wed, 20 Nov 2024 21:56:33 -0800 (PST)
Received: from google.com (180.145.227.35.bc.googleusercontent.com. [35.227.145.180])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ead0383132sm2377066a91.36.2024.11.20.21.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 21:56:32 -0800 (PST)
Date: Thu, 21 Nov 2024 05:56:29 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [PATCH v4 4/9] binder: remove struct binder_lru_page
Message-ID: <Zz7LjZcjg0wdJVc3@google.com>
References: <20241119183250.3497547-1-cmllamas@google.com>
 <20241119183250.3497547-5-cmllamas@google.com>
 <ZzziucEm3np6e7a0@casper.infradead.org>
 <ZzzyBwWIDy6Z2W4k@google.com>
 <Zz1NQXgk96vqHHFr@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zz1NQXgk96vqHHFr@casper.infradead.org>

On Wed, Nov 20, 2024 at 02:45:21AM +0000, Matthew Wilcox wrote:
> On Tue, Nov 19, 2024 at 08:16:07PM +0000, Carlos Llamas wrote:
> > If you are planning to keep page->private, I think we can just hang our
> > binder items in there. Something like...
> > 
> > 	struct binder_page_items *bp;
> > 	struct page *p;
> > 
> > 	bp = kzalloc(sizeof(*bp), GFP_KERNEL);
> > 	bp->alloc = alloc;
> > 	INIT_LIST_HEAD(&bp->lru);
> > 	bp->index = index;
> > 
> > 	p = alloc_page(...);
> > 	p->private = (unsigned long)bp;
> > 
> > This would be absolutely fine in binder. Is this what you had in mind
> > for current users of page->lru?
> 
> Something like that, yes.  Although you wouldn't even need to use
> page->private for it; you'd be able to use page->memdesc directly,
> and then not be in the way of shrinking to 8 bytes.

We can manually manage in binder the page bits you need to offload. No
problems there. It seems this would require an extra pointer to tie the
two pieces together but this should be compensated with other pages in
the system (I guess).

From my end, it doesn't really matter if page->lru and others are within
struct page or offloaded, as long as I can avoid duplication. The total
amount of wasted memory here is significant for us.

But like I said, I'll be happy to switch binder to any replacement that
is provided in the future. I won't be in the way!

Thanks
--
Carlos Llamas

