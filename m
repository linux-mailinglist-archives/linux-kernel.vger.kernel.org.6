Return-Path: <linux-kernel+bounces-241736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB6F927EE8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 00:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD2B52857BE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 22:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BE2143C72;
	Thu,  4 Jul 2024 22:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="DVwxZxWd"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA5449651
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 22:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720130817; cv=none; b=nNpzajq9bHCtIh1UF+JhvnIRUObBjURCA6h97C5LUjNDWjPT7g8i/Eje+QOzsZ4/ZQhAuY3e+o7zNcm/x+Ta8kn4INMCygiYJqdHg3U+qWceaUAuSwLPdx6Sbhf18JRpiF3LvrhXc5PNCS8C37wUvOtDQg7aITfMcelRPkqgMxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720130817; c=relaxed/simple;
	bh=mZWYBHWu0K1vkg+3iBgLKc9nAwYn0+EgBHt5aroVdT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IyGnYt8Uaq/Ae3tXo4i+Xz86InnvwPJ+UW1OLcYFGNPyWwl6IpbIenVm+Y4B6JpGFrbyFrN3Uqkaog7wiQFs37SRWhY4bWxGJeyvs1KwdaJfnpCZww5oPJJ5RE7+LqJP2N7vEIIDe+lcXFn0MmrtnS0PtfIg1MQyvq2mx1ROUlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=DVwxZxWd; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7515437ff16so660219a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 15:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1720130815; x=1720735615; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dFaYOWLt8is5D9As9aNtsr+qR/ekBHXt5qOy8aEh680=;
        b=DVwxZxWdkRmvk5lNv4/blNvEJNSj0PPptPDtvEqTiB2yr4Xh2lyDcreo7X2z7E5vZS
         R3+dzHfdFb8/1XrmXxdx+iLqK4K8pE0QdhUK1BEFAXBi2H9jiSVgxhUfrkMzKU9XaY/d
         OboHG6fL2cPaHzPF+Hta5NZDhY8xHlcraXreiAfFBc0h4rgxbJyCPcHpwuxxg76A5RWj
         BMqUQfRsa/zOFIrfnmTefZyqV+ez9xdK/P9g0KSREjVS/A8Zph2It6XtFghthbiOW1lt
         lvkrhdhBIAnXjjhzgc5SJm+m8jaT68kjeKwkIYTaj2G/Sq+GoHsDlJr8TUV++JrZDRi6
         cnlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720130815; x=1720735615;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFaYOWLt8is5D9As9aNtsr+qR/ekBHXt5qOy8aEh680=;
        b=XPsJwaDA6zSomV875HXw4Ldd7w527tUFeaWgezr6qC6Pmm8bpb4G3PdnfoQbYi5eR7
         AbXIwKrfbeEkVTYb3Y/RwUPvWEecAwofVwC9tVoZHTUZSzIeOaZRuE+a8eBwL82e1iXz
         w8KyTGy9E763hamm1zsyWFtbDQIGzIsa++YXL/lMPts5yGcqOwvY7lt0j/VkmEAYd6Ui
         bj4tLJwbNLo1Yb2ynIZs/QhpIyALZpb9dDPn88tN5XDw8JgEc4fiNRtn+YadWMO6ySwV
         NrKKpY9XHFrbyoNCo5VCY27fNLfTcRsYBSe7Q0ikz3nI7g3i96F9Z1l3gGxJJkBVq5g6
         OcqA==
X-Forwarded-Encrypted: i=1; AJvYcCXsAH6BvR0wOe/Pinzt40bNtHGHzIUvu7+HvnSo1BhNkGcs9J0Hgo9ui+jJaL08QiDuBklt+Ni33tLYgT0U2fsGU2XCYhlzAittN1CS
X-Gm-Message-State: AOJu0YyotMlGUIpm59mzDR+lYC820ckK9q1drFJvnnVT1k2QQbmqeJIy
	9vlYgkW6Qvpw+5Ulqp3vubbkqyAg1JXPsiTWzzxxoxML3IgUMH2tuhmwKjIKZQ4=
X-Google-Smtp-Source: AGHT+IEOXSukNyvdE753A9kN0wqOEG5BGZAWJFOPOuA3R3Nb5xT1OF4tfyv4M/ulUNm/JE9XRrkSIA==
X-Received: by 2002:a05:6a20:842a:b0:1bd:feed:c031 with SMTP id adf61e73a8af0-1c0cc88ee9fmr3464693637.28.1720130814939;
        Thu, 04 Jul 2024 15:06:54 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6c9e1634sm10211352a12.58.2024.07.04.15.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 15:06:54 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sPUbL-004J02-0V;
	Fri, 05 Jul 2024 08:06:51 +1000
Date: Fri, 5 Jul 2024 08:06:51 +1000
From: Dave Chinner <david@fromorbit.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	chandan.babu@oracle.com, djwong@kernel.org, brauner@kernel.org,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	yang@os.amperecomputing.com, linux-mm@kvack.org,
	john.g.garry@oracle.com, linux-fsdevel@vger.kernel.org,
	hare@suse.de, p.raghav@samsung.com, mcgrof@kernel.org,
	gost.dev@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, hch@lst.de, Zi Yan <zi.yan@sent.com>
Subject: Re: [PATCH v8 01/10] fs: Allow fine-grained control of folio sizes
Message-ID: <Zocc+6nIQzfUTPpd@dread.disaster.area>
References: <20240625114420.719014-1-kernel@pankajraghav.com>
 <20240625114420.719014-2-kernel@pankajraghav.com>
 <cb644a36-67a7-4692-b002-413e70ac864a@arm.com>
 <Zoa9rQbEUam467-q@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zoa9rQbEUam467-q@casper.infradead.org>

On Thu, Jul 04, 2024 at 04:20:13PM +0100, Matthew Wilcox wrote:
> On Thu, Jul 04, 2024 at 01:23:20PM +0100, Ryan Roberts wrote:
> > > -	AS_LARGE_FOLIO_SUPPORT = 6,
> > 
> > nit: this removed enum is still referenced in a comment further down the file.
> 
> Thanks.  Pankaj, let me know if you want me to send you a patch or if
> you'll do it directly.
> 
> > > +	/* Bits 16-25 are used for FOLIO_ORDER */
> > > +	AS_FOLIO_ORDER_BITS = 5,
> > > +	AS_FOLIO_ORDER_MIN = 16,
> > > +	AS_FOLIO_ORDER_MAX = AS_FOLIO_ORDER_MIN + AS_FOLIO_ORDER_BITS,
> > 
> > nit: These 3 new enums seem a bit odd.
> 
> Yes, this is "too many helpful suggestions" syndrome.  It made a lot
> more sense originally.
> 
> https://lore.kernel.org/linux-fsdevel/ZlUQcEaP3FDXpCge@dread.disaster.area/
> 
> > > +static inline void mapping_set_folio_order_range(struct address_space *mapping,
> > > +						 unsigned int min,
> > > +						 unsigned int max)
> > > +{
> > > +	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
> > > +		return;
> > > +
> > > +	if (min > MAX_PAGECACHE_ORDER)
> > > +		min = MAX_PAGECACHE_ORDER;
> > > +	if (max > MAX_PAGECACHE_ORDER)
> > > +		max = MAX_PAGECACHE_ORDER;
> > > +	if (max < min)
> > > +		max = min;
> > 
> > It seems strange to silently clamp these? Presumably for the bs>ps usecase,
> > whatever values are passed in are a hard requirement? So wouldn't want them to
> > be silently reduced. (Especially given the recent change to reduce the size of
> > MAX_PAGECACHE_ORDER to less then PMD size in some cases).
> 
> Hm, yes.  We should probably make this return an errno.  Including
> returning an errno for !IS_ENABLED() and min > 0.

What are callers supposed to do with an error? In the case of
setting up a newly allocated inode in XFS, the error would be
returned in the middle of a transaction and so this failure would
result in a filesystem shutdown.

Regardless, the filesystem should never be passing min >
MAX_PAGECACHE_ORDER any time soon for bs > ps configurations. block
sizes go up to 64kB, which is a lot smaller than
MAX_PAGECACHE_ORDER.  IOWs, seeing min > MAX_PAGECACHE_ORDER is
indicative of a severe bug, should be considered a fatal developer
mistake and the kernel terminated immediately. Such mistakes should
-never, ever- happen on productions systems. IOWs, this is a
situation where we should assert or bug and kill the kernel
immediately, or at minimum warn-on-once() and truncate the value and
hope things don't get immediately worse.

If we kill the kernel because min is out of range, the system will
fail on the first inode instantiation on that filesystem.
Filesystem developers should notice that sort of failure pretty
quickly and realise they've done something that isn't currently
supported...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

