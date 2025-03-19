Return-Path: <linux-kernel+bounces-568068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A09ACA68DD7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 14:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00E591896037
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881FA256C6E;
	Wed, 19 Mar 2025 13:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idYyf8mX"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE012561D7
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 13:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742390700; cv=none; b=NxHvOOPcSn7AbpSuvQYiUJtv26Em0SFCoorZOFq8TM4NCJUfJpemf9j6eOet1QPf4NJbz0WV7rs2aKRvsKUxe7AbvDfhtHSbcGLUhKmYJ0WsXPc+op+/FDCNNlOoV2EtrtY6xkpGyF1VZj+34F56ILh9pvjGHMIrmg6nOrVpYF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742390700; c=relaxed/simple;
	bh=wWvutZGfP+Hgb1/73esH+q6U3lnlnl3+k/G9eB2IAcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QCB6koA5Uk7wlH9uDbiCsIkeTrbYc55xEZDobPFmTT1FQD98/77lx22tI7Eo517fvhdSWGhI3TZeYqxq2fy9FuWJ/lJwWfDNiZM6u3c7F8cWfA16C9nPfyCe8agps5rZwJGIYmXRJmQN3UoZ/3uQriYpjqZmiF9ePOjidvGdQSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=idYyf8mX; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22359001f1aso21307705ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 06:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742390699; x=1742995499; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xZFRLY0XAdp76L6s++8PUE6jOftbFDqTl8mKmLB0uG4=;
        b=idYyf8mXGpwJhii/JX7AXZ5W4uS8hKwTs0AQFq5bRPrSgW7ZHt2KioFozVvW+BUgAs
         P/pWOLUnU8PbQwn+1I11ah6tY9gWdAoY/oqHEEfeEysj7V/m04IqSvchfXvXOV/nZMzV
         s0anqgJ9CfFMXgA0YwBtvK0ypaF8AQXDC/AEHsqVC2/zmHd8zh83n7stOpbc4CakWBQM
         I7zkCx3iePi0TGXRwJjphTbNdDMT5xjcIXkWZGJJuLZLm7Tbf8CEH8zSBeC0+4+tNGMt
         Dso1UJi5eW0P5wgdxFvfW8jTTpkW6lhc0+gcGLxxICvIDHBDkaVxCegk3XndggpKXGWo
         ATZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742390699; x=1742995499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZFRLY0XAdp76L6s++8PUE6jOftbFDqTl8mKmLB0uG4=;
        b=WFME8gJYqdunvzIz28lAPaxjRFcBaGjDejQ7fOTYl1G2jh9Oa7RY7GUUjD3r1t6qk8
         K+q+Jkw0tWBxrm6se5ubIMiPzlX/bJ1ITShjCC6ngvlCQKyRzLXsb774KO/5pDqPee6Q
         uPc+93DgLqF/5k56ecGVltdiPROIfPz23Z6qYbqWLGwE1HxvD3P/hB2mzdkmxC51zQ3N
         lPm0YjT8oB8AJ53h5Jfd/CUBYn2anu5Lmf6SwzYM+mrvgJm+0IUnDKvCiDQVpEijR1pm
         gcgndKfK6frY0ZjMrZZ+8AeLDOgFUFMVpbS+JrSlziJ/5AZ7dIsgOjXLkX4gUj/DB7VR
         FRdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbO8qXYEYEQlrQq9NZguRFpDGict4Kele01GVFXy4Ei1LwbDFTFSlNyCdS3TFA9xlH5e4upvudcF2Z4XI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNrrTYHxKeK+VDtJQfZIxxEltMcwkVtZBZ87EJW9qNfR2mAVGv
	XLs7RBw0aGx1ZtlasdCB+77hd9HEpeMTBT8R90xsN+aoE3DKvDiQ
X-Gm-Gg: ASbGnct5Mc3EeW5tBGQhQ/FYMgG12sQOPjcUhrio6ICmmasQ3q8Bzknhy9H3vdbfCZb
	sey7hZcp7po0Sk0JAQ7zA8BtJXuIOKvu12waEf0KHIgxnULNuPT3YY1M1yuhX6fUyWgNkDNppcV
	KrbzgP0qNkq5MieerIuRbu5H9qZLCKaFicVkvrb1/7GVjngIJt2SUeNZ80BsxGafPYp5UJf1trb
	E6uhb+FaX8QhulAVOvE+RJA06VQ78VlgCkBxYCpTGV2qoRL+ahr42G3/7R3r5wnJF7zx7RqGUy+
	KS10pBEtrMGaWW933idFDbDwqgCbf1zzNP+GJ+SCdvvQI0yHQHM16lPdWzUHeSZkK5Up
X-Google-Smtp-Source: AGHT+IGIFYmDi/KkGln7MKeowoPAzVmI+wsa7nArP8Kx5Xywx6QFPsEGFX/fF3zen40trjIEXgl4DQ==
X-Received: by 2002:a17:902:f548:b0:21f:b483:2ad5 with SMTP id d9443c01a7336-2264993273bmr33537815ad.20.1742390698627;
        Wed, 19 Mar 2025 06:24:58 -0700 (PDT)
Received: from localhost (maglev-oncall.nvidia.com. [216.228.125.128])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737115292cbsm11533634b3a.1.2025.03.19.06.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 06:24:57 -0700 (PDT)
Date: Wed, 19 Mar 2025 09:24:56 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Andi Shyti <andi.shyti@linux.intel.com>,
	David Laight <David.Laight@aculab.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v6 2/7] bits: introduce fixed-type genmasks
Message-ID: <Z9rFqBIWgF1FuM98@thinkpad>
References: <20250308-fixed-type-genmasks-v6-0-f59315e73c29@wanadoo.fr>
 <20250308-fixed-type-genmasks-v6-2-f59315e73c29@wanadoo.fr>
 <Z9mjJ3gJoqLwjIFX@thinkpad>
 <443027f0-08c9-449a-8ee0-db9b234483f4@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <443027f0-08c9-449a-8ee0-db9b234483f4@wanadoo.fr>

On Wed, Mar 19, 2025 at 02:39:03PM +0900, Vincent Mailhol wrote:
> On 19/03/2025 at 01:45, Yury Norov wrote:
> > On Sat, Mar 08, 2025 at 01:48:49AM +0900, Vincent Mailhol via B4 Relay wrote:
> >> From: Yury Norov <yury.norov@gmail.com>
> 
> (...)
> 
> >> +#define GENMASK(h, l)		GENMASK_TYPE(unsigned long,  h, l)
> >> +#define GENMASK_ULL(h, l)	GENMASK_TYPE(unsigned long long, h, l)
> > 
> > I like everything except this part. We switch GENMASK() from a well
> > tested implementation, including an asm code, and we split uapi and
> > non-uapi users, with no functionality changes.
> > 
> > Unification is a solid point, however.
> > 
> > Let's make it a 2-step procedure? Adding fixed-width GENMASKs is a
> > non-questionable improvement. Switching an existing API from one
> > implementation to another should be a separate patch, and probably
> > even a separate series. And we should be very clear that __GENMASK()
> > is uapi-only thing from now.
> > 
> > If we decide to switch GENMASK() in a separate series, we'll have some
> > extra time to think about unification...
> 
> Ack. I started drafting the split. The two series would look like:
> 
> [Series #1] bits: Fixed-type GENMASK_U*() and BIT_U*()
>     - bits: introduce fixed-type GENMASK_U*()
>     - bits: introduce fixed-type BIT_U*()
>     - drm/i915: Convert REG_GENMASK*() to fixed-width GENMASK_U*()
>     - test_bits: add tests for GENMASK_U*()
>     - test_bits: add tests for BIT_U*()
> 
> [Series #2] bits: Split asm and non-asm GENMASK*() and unify definitions
>     - bits: split the definition of the asm and non-asm GENMASK*()
>     - bits: unify the non-asm GENMASK*()
>     - test_bits: add tests for __GENMASK() and __GENMASK_ULL()
> 
> 
> Series #1 will leave GENMASK(), GENMASK_ULL() and GENMASK_128()
> untouched. The final result after the Series #2 will be the exact same
> code as of now.
> 
> I am thinking of sending the two series at the same time, and then, you
> can decide what is the good timing to merge these (and eventually, start
> a separate discussion on the second series).
> 
> Does this work for you?

Yes.

> On a side note, it did a lot of modifications to your original patch
> which introduced the GENMASK_U*(). It is OK to tag myself as author and
> you as co-author or do you still prefer to stay as the main author? Let
> me know!

Yes, I'm OK.

