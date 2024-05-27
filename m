Return-Path: <linux-kernel+bounces-191324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 994FF8D09EA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 20:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 556A628276E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 18:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2304415F41F;
	Mon, 27 May 2024 18:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c0zdIoJ2"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECBC2F2B
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 18:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716835040; cv=none; b=tbPSekp8OCPzoWPmBiUOCnMxDrl55icwbG8eJxq9Cjlpdh6NVHqOf/1Lf9JyEMA6weE+8+RzMhHf3LEk4yntOjh4kWP8XTTnh04Hz6MaZz6t6z4lvhOa8QyneyKVih4fLu2mo76hpU5IPX4Qz7Yx2KxBF7Ojk9j8SCwYgzzzVHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716835040; c=relaxed/simple;
	bh=ctCUsCS4mERWQN5uWM2DnIZrH/yMQp1hn0xvwTfGOV4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Tv1yfRu/HSa5YJy2Afn909vUzepLOsEaWLIzgP423ujYDnor+bHESclIRDsa1hy51iAlajb8+a6oULAxp8m/+I4QJ+cETJF3jVVofOcDKBjSXzTiUVo858tLleGBvsb6XtZ2sAo3KmYATrvIK56BCd9ol4PdqnNu0C+JhkJA6ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c0zdIoJ2; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f48e9871e2so188865ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 11:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716835038; x=1717439838; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NZREJP9vEhBnXbP7OCuzE5kdbwmu9xegRbDK6klfZJg=;
        b=c0zdIoJ24m7B/mKl/blcC15rnGdfIIwn1RuR+zMDfdAir4IG7WbvQRUFi6BnMDYYdZ
         JW5L7qFY3ublCRgXZ5qnBH9Khx9ayJuKgohbAdFx4nG9/NIg7FQlatikdT5kdQf843uT
         Eofz6n9umqC6/JlhKEh8CIE/G9grkBHeNBFW/CLliNRYCpNZ84OVlD8oDlfNpyJuLNtI
         K3r4BXYFQ1Hc2yp9Us9NWdUCiM1Fo/WVg8p2V6l4vMtZbKHV2vn39GLFGQQVSK895ZEq
         vZlaDGWkVz+9wD5Vgqpv3UyvBrpuTdjMnQhxWYJ8lYJ3GXFSqBeGtA7yCVBDzj459ODY
         WQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716835038; x=1717439838;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NZREJP9vEhBnXbP7OCuzE5kdbwmu9xegRbDK6klfZJg=;
        b=SJhhP4+9OKInNmdhj5cVGHk5jW2CXs+6t1aaYaGkoWc9MP22yNWwsvhELEzXnfhYKs
         hrCmx312oTkH3RMmfQ2+YSBts8Uh4DRRi9mCbXmD7xh2uB1SgYt/mbC1LwgaCFPLEIgO
         UQKsdjv8oHKR2IkOEwbjsZ4U0OVrh4KQ5DjeAWFWjGZghiyggYT34twMWxXzLsT6KdMN
         +OkaiAU0/rCagu1bPxAmS945UDRh9k6FtF91hnqMjp9CRP2x2HVhK+moSQVds5XnUtg7
         9smA24BpKKxUG6Q2165n928d28PtLsd/0qRlwsw28S+1UH5ty4b5xqCdOnB7GArpTc/c
         XLwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWoK9wwPZWHE7O9/8zFK888jE9SOgTHm8M+D4B36yJoJYufBc2+S/A7Js2hRazCdpKUiauZVEE00KFS5K5ijTdP4uAJ+FikG9Zf/VB
X-Gm-Message-State: AOJu0YxOYawMIipJ6vBwKewBffy3KtIXvdNkZ9n0nwh6Sb6ApJCJERpC
	MLAuvDJ4ot5PpyTZiWqWG+NNiFd2HWsV4RymC3YVh8CfBLyHGoRc0+jGdZQj4w==
X-Google-Smtp-Source: AGHT+IEAL9UflWJoo7lbOoL2iTxPWvC4MLeycXG2R6EPtLWseyz3TQ+/DhwL1Fdid2CUzoLzhdeWCw==
X-Received: by 2002:a17:902:c384:b0:1f3:61f1:e340 with SMTP id d9443c01a7336-1f4693d8fd3mr3532215ad.13.1716835038114;
        Mon, 27 May 2024 11:37:18 -0700 (PDT)
Received: from [2620:0:1008:15:2ed5:4637:e8cc:f09e] ([2620:0:1008:15:2ed5:4637:e8cc:f09e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c968386sm66391625ad.146.2024.05.27.11.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 11:37:17 -0700 (PDT)
Date: Mon, 27 May 2024 11:37:16 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Vlastimil Babka <vbabka@suse.cz>
cc: Christoph Lameter <cl@linux.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, Kent Overstreet <kent.overstreet@linux.dev>, 
    Suren Baghdasaryan <surenb@google.com>, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2] mm, slab: don't wrap internal functions with
 alloc_hooks()
In-Reply-To: <20240527090127.21979-2-vbabka@suse.cz>
Message-ID: <30544807-e9a4-f764-d113-d446242e9f35@google.com>
References: <20240527090127.21979-2-vbabka@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 27 May 2024, Vlastimil Babka wrote:

> The functions __kmalloc_noprof(), kmalloc_large_noprof(),
> kmalloc_trace_noprof() and their _node variants are all internal to the
> implementations of kmalloc_noprof() and kmalloc_node_noprof() and are
> only declared in the "public" slab.h and exported so that those
> implementations can be static inline and distinguish the build-time
> constant size variants. The only other users for some of the internal
> functions are slub_kunit and fortify_kunit tests which make very
> short-lived allocations.
> 
> Therefore we can stop wrapping them with the alloc_hooks() macro.
> Instead add a __ prefix to all of them and a comment documenting these
> as internal. Also rename __kmalloc_trace() to __kmalloc_cache() which is
> more descriptive - it is a variant of __kmalloc() where the exact
> kmalloc cache has been already determined.
> 
> The usage in fortify_kunit can be removed completely, as the internal
> functions should be tested already through kmalloc() tests in the
> test variant that passes non-constant allocation size.
> 
> Reported-by: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: David Rientjes <rientjes@google.com>

