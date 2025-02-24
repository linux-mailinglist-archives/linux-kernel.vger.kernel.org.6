Return-Path: <linux-kernel+bounces-529047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA096A41F30
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB6C5188A9DB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFB9221F2B;
	Mon, 24 Feb 2025 12:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kqbO8JF8"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404AF163
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 12:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740400533; cv=none; b=JrK7/LA5r1U9jKcH0hPNoG8lpcmLinETwBDmM+8kQvODgdDF6NnBY8UbPqZpU3jchfTX2ssFG4A3DJgIKiasvQRxC3gpSAtO+9USCsvJQT9WEcul1Dk+78FXzICogzxD05P+eFWiU3V98Xu0P0UVua5rMzLQMwOtVwaDxdI4xWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740400533; c=relaxed/simple;
	bh=KwGppkIqqXz0kYgGn0M1BZMOQImlHLrnIXG0Z+KbG2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lMDmMa6mUlJCDKpuaTU5T+HOzFvcQRj6EiW6qatQsPvnnQ66kSCIMbhPvvpDqCKedLct0Vc7krr4BBshVfXzKfziDxKK4RJ3WBZNdPzxbWu1k5qTQW0uW9digkfeNu2g9BbbBoOBzTwENHdF48tlgHIM48APd79ON4kxOoeLueI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kqbO8JF8; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-471f1dd5b80so356791cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 04:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740400531; x=1741005331; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KwGppkIqqXz0kYgGn0M1BZMOQImlHLrnIXG0Z+KbG2M=;
        b=kqbO8JF8OhqUknikNpCjoHMnOqp71z20rcW5SX8ja4YmhtaY6PmLGsb4DBpoeUossa
         7Lpos7Vmr8D0VsjaraGOzL98kso5L1OBNxWLzod1iheySvNf3zUJHFNG7l+b7AriSegx
         k8r0lORXs7wc5TMQM57va2Wj4aCseLI6JzaV+yVH5Bi20cmt8hk0+ykBAgDzqf0ixh9h
         D2qEAincAaa9flrg0Z7NeM0+lZjPy7UJOM0LL49W2zEIiKhnV+OnsFkOqLbbki8HOM2o
         eZvMbW3LK2oM0PkQ74e+8rxvpDzQF14sS5oqOLCandDACfsO/WVfDf/x/wqd9GYKp8EJ
         fjFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740400531; x=1741005331;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KwGppkIqqXz0kYgGn0M1BZMOQImlHLrnIXG0Z+KbG2M=;
        b=aGXLincQ8gAXmaRxuCYvMH7Y+JWKYE/LG5N0+VQ3Y4YYXo7JPT619V8PvxRkHxRYup
         T+xGlRn38SR/7x1EJNVIbxAIXdYYd396qeY4IUTij2g5l/kWyhmpWQIRFkv1Jch7pA72
         h2jL7ZlO3BxMcvJNEuvhUh6gOPts4A9C3PjQ5kBWAqxmi1HRvOEnoM/32QSdL3byc02n
         YGET+NyGf8Lb+L05t9j0KrX5YepW2DstgLCE3UeHsMH3T87gwbJmcGhJByvufu7lQyde
         31OFG6YNxdSkhjJ1sMQAzFAIYZwPrTUoGTtV/oC9pIj0MeO4hrEg0MtJ82XxoTcZItHg
         lovQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyfGiFt1XnXgzZR71LsIMdN/MCcjrmDn+nRCmcGQqaRYM3O8cQuF0oNLYf8bmnuPLznifJVVKN3FeAlrw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj+dQ0YC9Gqx5KtEu4chxy6bJcB2VQXQjf4PVhsGw4D2IXC4CA
	Gs7FKXImntGTpY4CXWgCAr5xToeiplssH9PyOXoOiXZKXjqchG4PRR7QmSzccHHBvbrDKb3D5D/
	T1Udb2JBf06MCf+dAjFQhjSKku75nBuZNfG0z
X-Gm-Gg: ASbGnctvF7djqh3msiqt/9T1IDxvWl+GsNzOSwd7aKrKsKp/VTEf11WmplJkMnTnT5s
	2k6MPnP74h++OPn8kwKnsG0Nctt4ZUTqTbSWL1xVDAEpZas/OT4UQnmqs+e7tzIwBClo3V/V+uJ
	33kNC68XjWdOAuDBhzUp6YO5eWwYcuF0UuKTNqSg==
X-Google-Smtp-Source: AGHT+IEBq+/2+cGisSl+LUqC0WCB2F575B4VRnIur1yE5rC/jkLryxhsyIY0MWbIIqCpavGQ2dpiQ63RFqJZuzk8vjs=
X-Received: by 2002:a05:622a:5cf:b0:472:7e8:a788 with SMTP id
 d75a77b69052e-472334cf3f3mr6561771cf.12.1740400530926; Mon, 24 Feb 2025
 04:35:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214-clarify-steal-v1-1-79dc5adf1b79@google.com>
 <20250214212647.GB233399@cmpxchg.org> <CA+i-1C3e_JUBBhMDYwrehvLZzLtb9pfgEy8=wQa=9uTBr1-b5g@mail.gmail.com>
 <764394d9-592c-4d68-8910-67362dd8810a@suse.cz>
In-Reply-To: <764394d9-592c-4d68-8910-67362dd8810a@suse.cz>
From: Brendan Jackman <jackmanb@google.com>
Date: Mon, 24 Feb 2025 13:35:17 +0100
X-Gm-Features: AWEUYZky2EJOd2B_fvbdC3A3HytUwtYJGPvQnMfxZFosmU0qGiqwHe1gWibELZg
Message-ID: <CA+i-1C3vX=79jCdJOWnR4KJB0zbanjU1p34RxJy8D62g0HZMAw@mail.gmail.com>
Subject: Re: [PATCH] mm/page_alloc: Clarify some migratetype fallback code
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Mel Gorman <mgorman@techsingularity.net>, Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Feb 2025 at 11:20, Vlastimil Babka <vbabka@suse.cz> wrote:
> Would it make sense to have only "bool *whole_block" parameter of
> find_suitable_fallback? The value the caller initializes it, it means the
> current need_whole_block, the value it has upon return it instructs the
> caller what to do. It would mean __compact_finished() would no longer pass
> an unused parameter.

I thought I liked this idea but once I tried it out I changed my mind
- the unused parameter is a bit of noise, but doing the above makes
the function interface and implementation harder to understand.

I also thought of allowing the caller to specify NULL which would have
the current meaning of only_steal=true, but again I don't think it's
worth it.

So I'll skip this for v2 but we can always extend it later. I think
it's likely that I'll end up proposing some other change to this
interface for ASI anyway, let's see.

