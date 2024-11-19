Return-Path: <linux-kernel+bounces-414928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9089D2F5B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 21:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3432B22BCB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 20:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3621D0F5C;
	Tue, 19 Nov 2024 20:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1hO3L0Sn"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA18148FE8
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 20:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732047374; cv=none; b=rJLYzx7UnigFkZFtN/iBSDWFhqlMxZ/BFRyFbVZv6vPfGspFx5iIjBU9+FcJBAi48WJi1Eaf8lQuqDBCWUha0NrsM+HwsM6rrZxjGewI4bN9juUeKu4RYV6b4wX2IEIqGGzaDwdKlg/qImYpCq5wkq9LfMtUzMp/L/Ynf43xuYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732047374; c=relaxed/simple;
	bh=z1js60M/tXRP20741a83keNYzhFM54wAOZpasjbV6e0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KeT+RQV3JMYHnLKU5baOE3SNG96uy9MCraAOn/4lxDkkQ+EiJXBTRAw7iPOl/Km45rMf0znno/skawuEatXwoG9UvpGaPkga2Mq+mtptMlfpYeYCZbYL859S0/MEiIWXtwcrYRrtHVT9QPM3BbNLO3xNfs1+kQVHPFiRz1dkq80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1hO3L0Sn; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-211eb2be4a8so214355ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 12:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732047372; x=1732652172; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/v3bvLl05uGtrlxF0ubRHpBpcaU9D+qbfPqdaaSMjpA=;
        b=1hO3L0SnzDCjsnai6+4JGkLS86/nZSKh2LO/riDHG6wtzq7NuDB6IngvKx8KrkQRl8
         7lWDclPVHCo9C7LVei20XKHUmDvLngVjO72jYHHtAUE7r1ZM12QCA+wBOR6FIXTo0mzs
         LK9BJ44ssgziZW3Gf2xVJG5cvs/lnUtqEfB5N/5LaSkL3DDhg0szz191YkWIUTZuOJAv
         vdrYFFG4fr9DSvPbCSajG8ex5u/sQKxdPq4Sjjo3WMEOddBuLDWTJAzHVAMFr0k1A48L
         dty32IrBHGprQ/uoibo0+YgWiRuAPIm5aLVbJR5salw6qC6O6G4NujV2HpozKrchk7L/
         aGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732047372; x=1732652172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/v3bvLl05uGtrlxF0ubRHpBpcaU9D+qbfPqdaaSMjpA=;
        b=Znr9tBiBRxqpnKIKxLOsTQMuNneVt6yZVGZSJOfBusALw32YSrn/ifykw31hMJ6IMw
         GUIPUSko42E/nxMsMBJ7FSgt9U09vbWUBnbr21vVFRDGgYhV3cIHVS0NzzXwRzlwKTQb
         FtR/V0e/YlTTPe8tScfsecRCAo633r1W2jDddhQqLnyBjVWnRBgTjLU+8YFSehgPaBgR
         ML7DZnHUvVgIo4+3Xot4wYeS8EdbsgKw4C5nx9Z6Lfw4AbuJk8b+CXWP4kzqH4viEcH6
         gNyqNcW7gXn4TDNxgrutusbLqCSJw1/RLoewW6IK5AELmAn7v7Dy+O0CJvVmiW/69aYv
         Csug==
X-Forwarded-Encrypted: i=1; AJvYcCVqH46VXXfF7zt/cfq1RwAJiNpiHAI3xAR9sr8w7Rs+Xw64WTykGAEykCT69VR81rfPXWoSt7GbsDuBQbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlbbfSaXOlQr1Li0H/8JdaI03DdJy3nZYWNZAV+lDb7JsNGRBM
	urYAmhBn4cHYPNCUMivQzslT3lOpWjIjHQhbuGPE87GoS30BeWzvpC4TqJEhJw==
X-Gm-Gg: ASbGnctc7g0OCam3EVE4z1UgvxL+lAxNsnPdqAlNahlBHEfVi9DrznOpkAdmMth+JSr
	tfnpJymF9LQv7BPzfto+/ZPgdJXRUnMN63SipicMIXweShUhRVL5j/h6YUYLxH8P1Sclluu9W+g
	uMhyYLv1VAgpTQdPtL2J0yMvaeqOnsrBUYslJ4Aln1ybiiexITFOXgOg7U/+Z7gOM2D9Z/YcF+P
	I0BYoql441WzB8Js0ghrrM6feFaftrtDMmf2uiOtN8pBeUyQR+oEdQIr+i/vITzC1NP3xisIyhr
	CqOWQ1FiUXXylxA=
X-Google-Smtp-Source: AGHT+IHLpLXWeKbrU21tMpSCPR6ZfWsE3/czsA+JEpEAMpFk1i7viHXFx8k/lOYgOYmNwFW6jUcn5A==
X-Received: by 2002:a17:903:1305:b0:205:753e:b49d with SMTP id d9443c01a7336-2126a276237mr262485ad.0.1732047371651;
        Tue, 19 Nov 2024 12:16:11 -0800 (PST)
Received: from google.com (180.145.227.35.bc.googleusercontent.com. [35.227.145.180])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724befeaa4dsm69234b3a.200.2024.11.19.12.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 12:16:11 -0800 (PST)
Date: Tue, 19 Nov 2024 20:16:07 +0000
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
Message-ID: <ZzzyBwWIDy6Z2W4k@google.com>
References: <20241119183250.3497547-1-cmllamas@google.com>
 <20241119183250.3497547-5-cmllamas@google.com>
 <ZzziucEm3np6e7a0@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzziucEm3np6e7a0@casper.infradead.org>

On Tue, Nov 19, 2024 at 07:10:49PM +0000, Matthew Wilcox wrote:
> On Tue, Nov 19, 2024 at 06:32:37PM +0000, Carlos Llamas wrote:
> > Remove the redundant struct binder_lru_page concept. Instead, let's use
> > available struct page->lru and page->private members directly to achieve
> > the same functionality.
> 
> I'm not entirely happy to see this.  I expect to start a patch series in
> the next six months which will remove users of page->lru.  page->private
> is OK for now.  The goal is to shrink struct page to 8 bytes, but I
> accept that 16 bytes may be the best we can do.

I see. I don't think that would be a problem. I'm only going after the
wasted duplication in binder. However, if page->lru is getting removed
I'd be happy to move to whatever is suggested as a replacement.

If you are planning to keep page->private, I think we can just hang our
binder items in there. Something like...

	struct binder_page_items *bp;
	struct page *p;

	bp = kzalloc(sizeof(*bp), GFP_KERNEL);
	bp->alloc = alloc;
	INIT_LIST_HEAD(&bp->lru);
	bp->index = index;

	p = alloc_page(...);
	p->private = (unsigned long)bp;

This would be absolutely fine in binder. Is this what you had in mind
for current users of page->lru?

