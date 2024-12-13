Return-Path: <linux-kernel+bounces-444280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4459F03F9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 06:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBA2A169A78
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 05:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79D254765;
	Fri, 13 Dec 2024 05:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="upRbw9s/"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E58D1632FA
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 05:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734066260; cv=none; b=lTPSjDKMN+9P9EVvnFfOdaD5xyFcNa4Z2adBWkNSYTbA5ZLjwuvpzs24/rnLRn10TONT2hRU8bfddXajXwWdnxLsPIL2fMNqn1nutGQ+gM8hGgkFexSTilXsdjnEhpE808hMuCnlgZ5sx7LkLhH4VIJ8G+ryTRqMaK6P0czST1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734066260; c=relaxed/simple;
	bh=keKwcXQ609r5yU7HxQAQbla/cIYqHTecTZw3tMNlJPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9IcK5ZX8sSPPEoJDXOx+qX6UXGwmoEGkuOkSARV6XUX4UWeEkD9+4W61VAAihpzCCMkD3UnHeXiJsDgW5mF8+czqzAf0b2+PiygoMmt6HvesU+IoYpK8lIyhBiDTXQlKvcOZGT+kBnG6poG0jx/S3GD2lAUyLHwJ36xC7vaP2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=upRbw9s/; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6d882619044so10485246d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 21:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1734066256; x=1734671056; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a0qe4hp5s0sjQeJSoTAs4QQFFqdoJWYDhTzc4eU1LwY=;
        b=upRbw9s/+dGbBfkhSeLc5BK1OtKDB+lZwS/hItFd/M+eSVm9w05BhpZCynJEwnagaA
         O0DdQSUQtpBD3AeuxYPgQ0qG0MV8ZItd1GtBm5dKSkvEEkZr0OGkFKVfDQ7gq5D7qyt9
         jX8DlkL4D2xedd5tG79ijwFeheRYigRy5Kjc4kdBxX9voDs2UWfG3N2a9Dx6oEthRZRb
         Y6EJTTJI0tFFT8Q6wLlsuM5fs4zeas+Aip/yzDWs+IR4Y3BujvZZZaYzBMmVqSV9E1nF
         EziLpGOJ8GXpz8nrriSt+2kEVntQraNYMiwlGAyvuYgsxi9Dm3fjL581ks5LxkdPYP89
         Mu7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734066256; x=1734671056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0qe4hp5s0sjQeJSoTAs4QQFFqdoJWYDhTzc4eU1LwY=;
        b=cEaIydC1/MhKuM7ktrvMD87ivw78zwI+nXF6Lk6HvwerChFk8ghDOLOdSvrN4HBolv
         CQdXVcCOSZiLmU0IQIrL6G3u52PrIPjWfgrrDRporp8BdY3RATUgXEByGubQCHKBrUdb
         UxlM5VhTl0ztgkF0H+XUBkbj5aFVIKCKJH4xHT492CdqXG/HkZ/rZeRo9EkhLI90oFSP
         OFkTR9hTkTqVKw6RV9fvmmqMws0wrwMWfr1848WILXWHgJgVecHskTjgiwfrE9NYH/wc
         cTrZp4jHbKW2r4VmCvv26oRz5ql+Q4oUcOEIDbS14lGhm4pKrmxkDAwXUMYHqdnqcQiC
         lO1A==
X-Forwarded-Encrypted: i=1; AJvYcCX8kx8WSn9TX5G6R/nMR6D0zeOIcLPPCrr/fAG4AJtIYaJF1twsblsEkskjjpwuP6/IObC5gYJbchts31U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoUNOQrj3fXZe8mW/dnCacqk9xXw8dqQiYrrZIYS8cyCHumDJ+
	Lp8vjCZDnQdSg1xWcV1l9DtOEZwHprWexU1vYBXl0Z2Yd6TMShYq7g+kCrK53Qc=
X-Gm-Gg: ASbGncuAamHT4dOMQkycx7QFbupeAfI3AnKpk9aOwti27DCbrhBfsTblQkMin4JRflI
	4qFonw6JUKGtNwP1gVfhcrKYmBNQK6HGolpKQd+J4atWRqN294s8yc7fkZmPmwoO65h/AXUB3Sf
	DOqHlwTh5IecFL7Rwtyc/cildSVCwfEBFIWY/xqeWWveARiQW4mNizCi9x2x0iNmPkzHMV+tx3a
	VyVLDWZ2NSoNWfFsjHft/VikEpSjqyUwC3uIw1u/VQS3YGhTYrBdOw=
X-Google-Smtp-Source: AGHT+IGW14bBpzm4Bv9Ow6MIsKOJXYUYsWnczFJ4gjzR44zqa57+4f4UGRIMI7sswCzh2/2i5gxQRw==
X-Received: by 2002:a05:6214:21a9:b0:6d8:9002:bde2 with SMTP id 6a1803df08f44-6dc8ca93c47mr18376546d6.28.1734066256199;
        Thu, 12 Dec 2024 21:04:16 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8da6b651asm88925736d6.69.2024.12.12.21.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 21:04:15 -0800 (PST)
Date: Fri, 13 Dec 2024 00:04:10 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	"Christoph Lameter (Ampere)" <cl@gentwo.org>,
	Christoph Hellwig <hch@infradead.org>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, clm@meta.com,
	linux-kernel@vger.kernel.org, kirill@shutemov.name,
	bfoster@redhat.com
Subject: Re: [PATCHSET v6 0/12] Uncached buffered IO
Message-ID: <20241213050410.GA7054@cmpxchg.org>
References: <e31a698c-09f0-c551-3dfe-646816905e65@gentwo.org>
 <668f271f-dc44-49e1-b8dc-08e65e1fec23@kernel.dk>
 <36599cce-42ba-ddfb-656f-162548fdb300@gentwo.org>
 <f70b7fa7-f88e-4692-ad07-c1da4aba9300@kernel.dk>
 <20241204055241.GA7820@frogsfrogsfrogs>
 <Z1gh0lCqkCoUKHtC@infradead.org>
 <04e11417-cf68-4014-a7f7-e51392352e9d@kernel.dk>
 <2f79ff03-48ee-54bf-b928-e9519b3edfc7@gentwo.org>
 <383d3adc-e939-44b2-9110-4db9b4477401@kernel.dk>
 <Z1s7AGxZKhK1V4qv@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1s7AGxZKhK1V4qv@casper.infradead.org>

On Thu, Dec 12, 2024 at 07:35:28PM +0000, Matthew Wilcox wrote:
> On Thu, Dec 12, 2024 at 12:14:23PM -0700, Jens Axboe wrote:
> > Like I mentioned earlier, the fact that it's cached for the duration of
> > the operation is more of an implementation detail that developers need
> > not worry about. What's important is that it's not cached AFTER. I still
> > feel UNCACHED is the best description, but I'll change it to DONTCACHE
> > for the next version just to avoid the overlap with other in-kernel
> > uses.
> 
> Regardless of the user API name, I like PG_streaming for the folio
> flag name.

If we're throwing names in the ring, I'm partial to PG_dropbehind.

It's a term I think has been used to describe this type of behavior
before; it juxtaposes nicely with readahead; it plainly names the
action of what will happen to the page after the current IO operation
against it has completed (i.e. pairs up with PG_reclaim).

