Return-Path: <linux-kernel+bounces-185946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 596EF8CBD2B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 10:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC42CB21C93
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 08:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501897F7F7;
	Wed, 22 May 2024 08:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cV24FTG7"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038557FBA2
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 08:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716367344; cv=none; b=lAoU1ifj+GasD8UBQbw3CHG6PgyjrQHg7SMIgVgZnUkWisg6Wkc731AucFc2pYz6rX6U+GnEGxiD7LeMPZ+eviDfNBW3rVsU6rxjwdZYwg0cKihDPwh1BG5FmbiB/xb0mPlGTSG/DFkENBJQCc6MEZxN4MOyy2UbNV8LjaGxzbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716367344; c=relaxed/simple;
	bh=cFkzuV2nhdITvS5vigqguNhYr4sWvH5AJWxl0OgQKZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TWTBpfNR7E+RGEnyX5FivKuNEUHz6wcDsU3OJb5t66cFc2fZiiw7ELrRa2PF0YOl9vRrKqnjBvqa2JDPPRL8LTuNZVnv4HmC7Osx7YWoNbZzkqqhpNy3y0ULz6XrIIj2//8594S3roFWeLqcIc62helfStS7RjFCHHiqxiUzd/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cV24FTG7; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5246ecdb5b2so2393e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 01:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716367341; x=1716972141; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hQKnMOlxl1U85TXCOdkXJ6lbOT1vGIVpWb1iMwW2f6c=;
        b=cV24FTG7YJLqZvOmPI2CqEmM+Endzm4eff55Y7UqsgwZUVn6H8GEcb1kZ+kkbN6uw/
         EkWowgA6ZvMuQMyws0qJNQEqgb7Hb4FPWiRuIuVqyWHVWc0tFL6ZlgLhYDOu1UoO1BUk
         TVYrHtMhXk72IEOeCBNxZL5syfmYzdHB1qvQ2nbtf90RCu3s0GHKQGBEtM9XdD0xqEu7
         YvhdTXQzFn1OC8B/1qbddxaBSf4dqNeCRCRvjOS9kXVjaRm7CbXGXBozDaArWeVMwGGv
         bCRM96YlwgU9W2fixhiqvwgMZxUCaV0d0Y4RlI7zrHeBhxpUWAoj+kXROZEh/5tMnUR0
         n25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716367341; x=1716972141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQKnMOlxl1U85TXCOdkXJ6lbOT1vGIVpWb1iMwW2f6c=;
        b=TMlvYrnyg5nVE6p78XkElqLxmXZfGwsXOa4m9mOUKUk6xAPPGh9D+IhFmkMzKBGAys
         Yao6MMcFDjm0CXJhiXhnW+KhpFmPeAzxdXxNGOvJp2tQ5ONBmFbKVrLp3/Jq7Bld1Eix
         qi+YNEq29s6QqnNR9AXvgefrY/mzA+jEfTm+kC2/OPYWuHU6wrvfd/7gWwzj7d0vN22l
         JEVPGdNZ5EGk8swrjA4YTM2hHDnL3A6AWgIQIwwBh3xbzn0i/G/o/t4tPBxhTGGzS9kP
         pwCjct/JWFi1U0ckoiMQ3SEaEE8wzTzjO2DyEb5gELLwJMBDE6vZDNWgHVWtXVWhaVpA
         H18A==
X-Forwarded-Encrypted: i=1; AJvYcCXHeSZC8iBJorOwctQxADC7T811E9FRQ2HQxZvzkzhG8o95tJuiOTNzrIETSrS4GqWCeiCa8kYbiYrymVl2BzCy5Esk5T+t/qulWw4m
X-Gm-Message-State: AOJu0YzytHyubHNobyHF0ao75tt/YivEw2/mWgW/bPYbWGLu4qUPG/tS
	1fggmdJoqnKWooXwpoao3iPcO64TYwFX5t6Gc8fdjtlCtMV/YwW/hsjq/Otd1uP2UJG4Dvb+JKM
	+6g==
X-Google-Smtp-Source: AGHT+IF/LNQRnVQWxxSSjY+8dq19JFT8GCORQ35jVMu0UDIxZWiT9kZ6GiOOsvb2fTDm8QT3Qr7iJA==
X-Received: by 2002:ac2:4d0d:0:b0:51a:d690:48a4 with SMTP id 2adb3069b0e04-5267f271ea6mr98499e87.0.1716367341048;
        Wed, 22 May 2024 01:42:21 -0700 (PDT)
Received: from google.com (49.240.189.35.bc.googleusercontent.com. [35.189.240.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-354dd239e73sm942534f8f.12.2024.05.22.01.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 01:42:20 -0700 (PDT)
Date: Wed, 22 May 2024 08:42:16 +0000
From: Brendan Jackman <jackmanb@google.com>
To: David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm,memory_hotplug: {READ,WRITE}_ONCE unsynchronized
 zone data
Message-ID: <Zk2v6LJPC0HKtBsO@google.com>
References: <20240521-mm-hotplug-sync-v1-0-6d53706c1ba8@google.com>
 <20240521-mm-hotplug-sync-v1-2-6d53706c1ba8@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521-mm-hotplug-sync-v1-2-6d53706c1ba8@google.com>

On Tue, May 21, 2024 at 12:57:19PM +0000, Brendan Jackman wrote:
> These fields are written by memory hotplug under mem_hotplug_lock but
> read without any lock. It seems like reader code is robust against the
> value being stale or "from the future", but we also need to account
> for:
> 
> 1. Load/store tearing (according to Linus[1], this really happens,
>    even when everything is aligned as you would hope).
> 
> 2. Invented loads[2] - the compiler can spill and re-read these fields
>    ([2] calls this "invented loads") and assume that they have not
>    changed.
> 
> Note we don't need READ_ONCE in paths that have the mem_hotplug_lock
> for write, but we still need WRITE_ONCE to prevent store-tearing.
> 
> [1] https://lore.kernel.org/all/CAHk-=wj2t+GK+DGQ7Xy6U7zMf72e7Jkxn4_-kGyfH3WFEoH+YQ@mail.gmail.com/T/#u
>     As discovered via the original big-bad article[2]
> [2] https://lwn.net/Articles/793253/
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>

Oh, from a quick look it seems cma_pages would need this too.
present_early_pages seems fine.

I'll wait a few days in case anyone points out this whole thing is
garbage, then check more carefully and send a v2.

