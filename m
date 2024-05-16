Return-Path: <linux-kernel+bounces-180599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B8B8C70A4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 05:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FB591C21ECD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 03:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1102125601;
	Thu, 16 May 2024 03:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LIQXWnrd"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570FB4A11
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 03:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715829896; cv=none; b=jAk8ZaV4HQQETFpa3ePFlL0+587NF3WR/WM5efFuGQq3ONzbSE6iEQd+8OCUSyUzdeLXiI7I32DlOToChRqfZSncEMTgM4gUmNPcXZA1nZQ2IYPz1vHbWStGpKPtICo5hc40nqq+3xYGU8CWAeW/z2H0s4r6IMcnGdc/ZgzBM5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715829896; c=relaxed/simple;
	bh=bMJn9NymWE1wcW9+pBYiAojx2hakxFodH0+3w3Nt+aM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eAmzXa0/HAr2jt+Rga8iBgn3b8pAyRAv5uu1VSdkXklDAFtd/3cLYdXngGP2pRwCcOnIo+I9WZ56yzv9gJEadcSiNSsqMbOpOL868EUgyZJoQ+M6CAXZ/97QmpAkYlCnnxqEIZWGziD7q22CAiEflWYSstB7z/Yr9PQx3G4AIZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LIQXWnrd; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6f44390e328so6996829b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 20:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715829893; x=1716434693; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GvhInJ4856b1IIVjw0V0q2o2QfuhRdBKnXnI7msgx4Q=;
        b=LIQXWnrdLSbyp6ugZTKgY4vrs9zaU8nTWaQwVAqclcQeHjZ2ZgD6BVq/NDcPhJDm1u
         b0z+k6OgSdOrfD5bQ3UVh/xQw5UOjZbl9FKEjuOwIHjVZmqM7RsiwOBjJW5pMraB8mJO
         jXtCx25TZBoTjpPKyoqp1VhSXaps1HGsFijxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715829893; x=1716434693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GvhInJ4856b1IIVjw0V0q2o2QfuhRdBKnXnI7msgx4Q=;
        b=erAsS897TNhOxcDmZdDAzCanu1M/Daf/9jegkDm3O3P4S/NNkCXqtJXMxD+WCBXaCd
         7oWcgya4EcOKURG8OExiNZRmQEACTNXwSjTOrfpeQavaoHTF5XbkSk6l13Pnjtiizt9B
         mgs7fis7DfkDUg65qgMY11IbSVH0RVOC7V672X6QW1JY/Ejt3nUIcYGJeDXV2Xz7IAuz
         zuW+VUOEJr5ozLfE0D0UOnQ9337DyciZsDQB0Ccxn8tpxGhACPvYpxu/E50A5e4e2waJ
         Xpg1xzHXJVVCrODAi0oCu3fqbibVedkN6DCAt7RlUDI3fcphYRLIvkEMrBWqH1ySmqPd
         C4Fg==
X-Gm-Message-State: AOJu0YxlazvjyB0KxVgZ6HrF5/MN7OPfE2iZUVZbQ5ObVKroWNd0h9Fo
	G/X5UA4MzT1QPKbzjc44mNcBgLcjbFsWYK9lQXo6mRBezlxvz1ZWfPkbdX2FTA==
X-Google-Smtp-Source: AGHT+IE0c2gaCVFed1poOXq7yqyITZhao0QJ81DW7vgQofPuvGffpJmw1ogDrhWksLnh6dydPd/suQ==
X-Received: by 2002:a05:6a00:4b4c:b0:6f3:c10a:7bdd with SMTP id d2e1a72fcca58-6f4e02d36a4mr26254518b3a.18.1715829893603;
        Wed, 15 May 2024 20:24:53 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2af2462sm12346867b3a.141.2024.05.15.20.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 20:24:53 -0700 (PDT)
Date: Wed, 15 May 2024 20:24:52 -0700
From: Kees Cook <keescook@chromium.org>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: linux-kernel@vger.kernel.org, nathan@kernel.org,
	luc.vanoostenryck@gmail.com
Subject: Re: thoughts wanted on dead code hunting?
Message-ID: <202405152023.67ED1BD7@keescook>
References: <Zjy82Ja6G2iIHl75@gallifrey>
 <202405141706.1D5D26C@keescook>
 <ZkVWCOZDb7iewLxL@gallifrey>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkVWCOZDb7iewLxL@gallifrey>

On Thu, May 16, 2024 at 12:40:40AM +0000, Dr. David Alan Gilbert wrote:
> * Kees Cook (keescook@chromium.org) wrote:
> > // Options: --recursive-includes
> > @find@
> > struct to_be_removed INSTANCE;
> > struct to_be_removed *POINTER;

Oops, I missed this line:

@@

> > 
> > (
> > *       INSTANCE
> > |
> > *       POINTER
> > )
> > 
> > 
> > (I bet this could be improved, but it should be a usable example.)
> 
> Hmm, now if I could use coccinelle it would be more tolerant of coding
> style and slight variations than my script.
> However, trying that tiny example, I get:
>   File "play.cocci", line 10, column 1, charpos = 141
>     around = '',
>     whole content = )
> 
> so it seems to be objecting to something at the end of the file?

Sorry, yes, missed the "@@" between the identifiers and the code pattern
to match.

-- 
Kees Cook

