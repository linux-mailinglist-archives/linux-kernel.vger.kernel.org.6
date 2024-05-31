Return-Path: <linux-kernel+bounces-197173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 845438D670C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 18:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D25E128572D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED09915CD7F;
	Fri, 31 May 2024 16:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y97pdccO"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4985158D85
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 16:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717173674; cv=none; b=Qx9DyEfS0nGjYATvlgVySiv4BoY5sod0D7NRhz+2gT20914KLTmO8G8OyGayp0pJuw9fwIsxzkgkvoUfYM3Aoi/jTvTwqm0frngjHauySVPO4r7vYtJv+cllCHYsiklPtI9mFvI1st1BsFeY0QCAc3FZGY2CAZP3Uv+zMsjAToo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717173674; c=relaxed/simple;
	bh=WCOU3bIhKKOr/9Qs32/kbBI6MqjQcjT5WPrt7i4IMpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DIXSuhO2Iz7UmFW+FKrYiXoT7aJQLqHMoG1ZNQlvsACJ3HnE6Dm9/VJ5lt6GtrEqWgAnQtihb2pNhBgkp8nKFilipsheUrIQgo/r/5CDzQI7F8sadEriccLhljrR52tq25y6kW8iHGeCkZAkeMUUK+n8OXzxgGi8VIKS9EUl4MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y97pdccO; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-420107286ecso1445e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 09:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717173671; x=1717778471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e2efDuBVtNDU8NAmJPSWRWEdN1N2THlA7nrXNrZvQKo=;
        b=Y97pdccOEtFJlg+YUHpHkE6AccUHry+sPIDWRX+5inxqT3BdFnKarjWHZJvA8Smjb7
         abxoKjN0xauGpj9zO9QuE8F3KAgJtcJQvD1yhuENKhV+47GrHWzbqkOmsazkMKJV8KkW
         b+Gs9g4Pqr7sc6URnLbpD/jD4vO/2V8KsIC1n7Wrc4BF8zuM3laxcFnwlMyxvM4wipJl
         DkDIuDgErHQUuVr8Ya86Q8m/BaE8eGqYI+80Gqaagy/Mg3UA/5xbD3iXYyQRS/1jlz/h
         CDSQuhNe3m25QP1jRlsACAkpsavF05X5xTYmk+OIRxwp3HaO3rOAOIwx5x+m+cT+EpUt
         bfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717173671; x=1717778471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2efDuBVtNDU8NAmJPSWRWEdN1N2THlA7nrXNrZvQKo=;
        b=D4Kg7vAKhOOcrAjkvzMrARa89Vfe1aCB4KT8+PxBix/K4y6ixlNzQlxQJPvTNK+jlL
         7Td/WQODJ3lcgtG66tzfrN+beBbNofvH7xCb3nVJPdycynj8xEcTcK2tvRztmJqpg/2A
         omAzLXCdMbKZTXmWO1QKNj9axs3Mo94QjTTtRTJ7/bNC5Fp+yTgyt1hZba5TCmAUQU/K
         cjDoQ5N32Ea17RZVDr0XDMchKR1oOuX/HqSngbO9Lz1Fyix86bA7kmkb3iOgaQU5ng+B
         Rv0yywWaeKZ0DA7vFPNmDuKOCvGVvsN/UsUqVq+8ozXMzGIv+lrZcNMkONNL0ZEH724d
         9upQ==
X-Forwarded-Encrypted: i=1; AJvYcCULy7GBfJtu22tGiXXQUoT3I2c2LdnycjJ5R4CjFDaYACMA3WCStV5WWNPpdGTMmRD6cw8QLqox3WE0O3+fOwUOuJHAhh2Rr2uIxBQH
X-Gm-Message-State: AOJu0YxCOc33WD+VYYsMbH8SuOnjf9GynePRYVMRkDdZNGfDiBJsncl5
	LUcjh0oym7b+UXPl4ptNh99T44M+CnfAXkFmOBp2vWPIBnyR7pi3uMInzB+vMg==
X-Google-Smtp-Source: AGHT+IF2tsjEm8bM2Jv/wTFbvme09zwHXm4Cy33GZLdDUzxg9rUFULHvvuIj1NzQXw8Rm93bevW/CQ==
X-Received: by 2002:a05:600c:6546:b0:41f:9dd0:7168 with SMTP id 5b1f17b1804b1-4212c091f55mr2188665e9.2.1717173670653;
        Fri, 31 May 2024 09:41:10 -0700 (PDT)
Received: from google.com (247.165.79.34.bc.googleusercontent.com. [34.79.165.247])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd064b5e9sm2203000f8f.96.2024.05.31.09.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 09:41:10 -0700 (PDT)
Date: Fri, 31 May 2024 16:41:05 +0000
From: Brendan Jackman <jackmanb@google.com>
To: David Hildenbrand <david@redhat.com>
Cc: Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm,memory_hotplug: {READ,WRITE}_ONCE unsynchronized
 zone data
Message-ID: <Zln9oS0njmNAP8lU@google.com>
References: <20240521-mm-hotplug-sync-v1-0-6d53706c1ba8@google.com>
 <20240521-mm-hotplug-sync-v1-2-6d53706c1ba8@google.com>
 <9c23d824-f2c7-4f9a-ade2-e8dd3a0d30af@redhat.com>
 <Zk39BD7NPbP7WJOz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zk39BD7NPbP7WJOz@google.com>

On Wed, May 22, 2024 at 02:11:16PM +0000, Brendan Jackman wrote:
> On Wed, May 22, 2024 at 04:05:12PM +0200, David Hildenbrand wrote:
> > On 21.05.24 14:57, Brendan Jackman wrote:
> > > +	return zone->zone_start_pfn + READ_ONCE(zone->spanned_pages);
> > 
> > It's weird to apply that logic only to spanned_pages, whereby zone_start_pfn
> > can (and will) similarly change when onlining/offlining memory.
> > 
> Oh, yep. For some reason I had decided that zone_start_pfn was fixed
> but that is (actually very obviously) not true!
> 
> Will take a closer look and extend v2 to cover that too, unless
> someone finds a reason this whole patch is nonsense.
> 
> Thanks for the review.

Hmm so while poking around during spare moments this week I learned
that compaction.c also stores a bunch of data in struct zone that is
unsynchronized.

It seems pretty unlikely that you can corrupt any memory there (unless
there's some race possible with pfn_to_online_page, which is an
orthogonal question), but it does seem like if the compiler gets smart
with us we could maybe have a compaction run that takes quasi-forever
or something weird like that.

It seems easy enough to just spam READ_ONCE/WRITE_ONCE everywhere
there too, this would remove that risk, make KCSAN happy and serve as
a kinda "this is unsynchronized, take care" comment. (There's also at
least one place where we could put data_race()).

On the other hand it's a bit verbose & visually ugly. Personally I
think it's a pretty minor downside, but anyone feel differently?

