Return-Path: <linux-kernel+bounces-317924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5738596E595
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 00:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1372C284EA3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 22:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317C91A4E6F;
	Thu,  5 Sep 2024 22:05:39 +0000 (UTC)
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEED8F54
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 22:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725573938; cv=none; b=ZF6+Vz2puf8fF+YRw5x9iQtXsMOcs2kF8M8s4EaqSpiSQu5L6+TjwC2H61OR3J4TN8Qjj9u3YaCvypFa4EZqPtY7NLqX8oA++nhLZtI+ngpleJ5Ym7OFU4YapPtnruAXEn+Qk//kujusC4XNJevEIqODO196WRdlT1aAq1E5a/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725573938; c=relaxed/simple;
	bh=tZIszrxdMpyxYV8DYgA6xtvpR7JoghxuV8nZeM0115s=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3pC0Zr0RV18JVVVFJbSN4YffZh91+yvGbqsOX0U41rUQKEYV+dGOkwL+UeKocPbHqz4gNXyE+oa1T5mcm1+pdHmOujKoL98vryNUr7RHzFr+8BqGN+EyIEu8bI+IFPGpufiuXD/qfibTGAJlrJVoBjyJTm+4WjretsvyWub44o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id f4f752b3-6bd2-11ef-8e98-005056bd6ce9;
	Fri, 06 Sep 2024 01:05:27 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 6 Sep 2024 01:05:26 +0300
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v1 1/1] mm/page_alloc: Mark has_unaccepted_memory() with
 __maybe_unused
Message-ID: <ZtorJmTrerLhO5Xv@surfacebook.localdomain>
References: <20240905171553.275054-1-andriy.shevchenko@linux.intel.com>
 <20240905142220.49d93337a0abce5690e515d9@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905142220.49d93337a0abce5690e515d9@linux-foundation.org>

Thu, Sep 05, 2024 at 02:22:20PM -0700, Andrew Morton kirjoitti:
> On Thu,  5 Sep 2024 20:15:53 +0300 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > When has_unaccepted_memory() is unused, it prevents kernel builds
> > with clang, `make W=1` and CONFIG_WERROR=y:
> > 
> > mm/page_alloc.c:7036:20: error: unused function 'has_unaccepted_memory' [-Werror,-Wunused-function]
> >  7036 | static inline bool has_unaccepted_memory(void)
> >       |                    ^~~~~~~~~~~~~~~~~~~~~
> > 
> > Fix this by marking it with __maybe_unused (all cases for the sake of
> > symmetry).
> > 
> > See also commit 6863f5643dd7 ("kbuild: allow Clang to find unused static
> > inline functions for W=1 build").
> 
> has_unaccepted_memory() has no callers if CONFIG_UNACCEPTED_MEMORY=n. 
> Can't we do this better thing?

Sure! Please, use your patch, I'm fine with that
Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



