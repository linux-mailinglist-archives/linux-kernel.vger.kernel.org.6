Return-Path: <linux-kernel+bounces-543795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC42AA4D9FE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 855653A4AF8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C4F1FCFDB;
	Tue,  4 Mar 2025 10:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YSo0wqlu"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4781FC0EE
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 10:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741083501; cv=none; b=VYXF4frlJgar2mdA05EPYLfb4aOR/OfpGKjj9M0EFG+aPZLKaiJ6CHPMrBJFa9U0OY+TDJny/CEUOZhOZC9E2A8wR2rXNiMMr3LEZ8gMozhKROAhrjXIArg1mXXy6plKZDSaKOQaMzOksH6/ezZIBpcDmr6ksiaxpc2GZQXb2DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741083501; c=relaxed/simple;
	bh=Bfnzv1Cy+QaLm5BRN0VgsvZutnU9et4W4XCIe4/LVvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HE/52gMYb/+PO9RqDXuT0Fu6nPwfUD3P34/Be1zXrWasxfx5uMhirlTTVco6X/Zrs1yop9fdAdHmronpy2UaJmxC4E6SOZ7sNxhEoFcbZj/M3Mvbdew4+lL5/c3AUYaw/HyA00umSZTAHUY3kPY3Pl5CcqB17Pol43ZUdbwexSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YSo0wqlu; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43bca0048c3so34595e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 02:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741083498; x=1741688298; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cHHGVIwYUugRFpPbUWW4QxwSvbgE0LZxVDWqc5K4qXA=;
        b=YSo0wqluMcdbd1XoD6jXU3cB0Zj5XIYi80FRqULvGZtYaOS+qhdIyJfFUSIgBcrsyD
         yyXFsbeZaCO1Ru4sD+bq0pOmU0+MgsgmrFeVqY2dgFMlm9Clypcn4UenjjIb+4CVj+34
         UvQIzuKzwqBmGpzrFDIDx3zwM73at2u8jBv8du3xNE4/EWO3qGERy6A/nYFQtg+4C5Q0
         rxlSdigihNi8L54ejJtoXbHwc1vRtQd90EaKpmWQ8mwJgiMRQIM3TTRwZ083/1GDPrA1
         5OaQdr9NSbUCmZDBjOe25Xn/QXLujxxCzdPZfxEuaEnfgoe9KtStfDdoH5yZwBYUAqka
         VQRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741083498; x=1741688298;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHHGVIwYUugRFpPbUWW4QxwSvbgE0LZxVDWqc5K4qXA=;
        b=C2u2dLAhuLZdg5EsNKmz+DDm91GLeaNkVYrsQ0e5mj418vfyNLB19ojxfjzFYXvR9i
         4zBXtI63qGUhZwmN3m4Pbbq6jBEnqUDHO2So8Z1TVuRLM/coQ6/FPNFOmFrVP05i9TVL
         GqtveWG5LRS/Rq8Qpax+6FyjEKG6Nm6Z4iYLXDDF6lVoKdM3+I/xDJd/ZGo7IJSYK05T
         2M+DIsPdRVQN8nbgx0uYBocAXs4Bj4142TVtctHUOzK5oh5SYNi+KenhcTl9rKya1HiL
         IcqNSNI97bvo6XOUFtOGcp0jILU9W5uSBAs3tNSJRLf0ZJA1xRWsfxUiVYHD3evRzvqv
         CqKg==
X-Forwarded-Encrypted: i=1; AJvYcCVM5JKZZMxVbQchE9vitE81Yzz4e5D1INEzS2DB8la6XwSJsAP1Xa2H6sQIpgD5JtPSzA0Oe0QmwW9RyRw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsy0qwNTV/gX+YNup//VNDFAOg+K9raV4Yq606nplk0bPmt6yf
	Sxsio7tSoFJnWrotd3+W6BXfuoWzAQKAVtJjCVd6dAX02OxdfmfP+DggFxLSlA==
X-Gm-Gg: ASbGncvWk3eVLZkdmHEmHc/jyYrz9Ze00Bw+r76DH59p9pepe9eaN64CWbStQBjQm1v
	XwW9zd3JbK6eYaco/LDuQMXzk7zbJs4KfLv0TcIziuRXtSawzsY4Nln+I+jYD+XG8+WtWi0XWSZ
	SBh/IZS/RaebWJZDfAGiWSQIU7Ctu1XSyWp0FA1FvmjgNX57FgSt/AP4yJRFxzKcb/MfBewbOV9
	MhZCLeL6XnaUeCDHWvV2jUCFE6dTktuwJpmwmC79JqtPzLbGOlmAa0eg/68Hoj5zp9wwgTUhZDJ
	H1KfOtJKh9tMSD9U8qUFo7fgLCgd+e4rIjw7JKcTwGzeA+r8az0kuB4KjAM9C77PmOD8gJhR3kh
	23lmD
X-Google-Smtp-Source: AGHT+IF1PXtKs5JYeKClxwK1lAzDe1Sy+Hic0+WUm5WKWP2ZPJezaTOmzVJ6ghefB6dnk3leGQIlaw==
X-Received: by 2002:a05:600c:43d4:b0:439:9434:1b66 with SMTP id 5b1f17b1804b1-43bcbe262d7mr789425e9.1.1741083497923;
        Tue, 04 Mar 2025 02:18:17 -0800 (PST)
Received: from google.com (44.232.78.34.bc.googleusercontent.com. [34.78.232.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7dcfsm17460567f8f.55.2025.03.04.02.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 02:18:17 -0800 (PST)
Date: Tue, 4 Mar 2025 10:18:13 +0000
From: Brendan Jackman <jackmanb@google.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	kernel test robot <lkp@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: Add lockdep assertion for pageblock type
 change
Message-ID: <Z8bTZVYd0fJLbgl7@google.com>
References: <20250227-pageblock-lockdep-v1-1-3701efb331bb@google.com>
 <202503010129.rJvGqZN1-lkp@intel.com>
 <20250228182804.GB120597@cmpxchg.org>
 <Z8WQEpv7BNtDDoH3@black.fi.intel.com>
 <20250304101357.66067dd3@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304101357.66067dd3@canb.auug.org.au>

On Tue, Mar 04, 2025 at 10:13:57AM +1100, Stephen Rothwell wrote:
> Hi Andy,
> 
> On Mon, 3 Mar 2025 13:18:42 +0200 Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> >
> > On Fri, Feb 28, 2025 at 01:28:04PM -0500, Johannes Weiner wrote:
> > > On Sat, Mar 01, 2025 at 01:31:30AM +0800, kernel test robot wrote:  
> > 
> > > The patch is missing a dummy in_mem_hotplug() in the
> > > !CONFIG_MEMORY_HOTPLUG section of <linux/memory_hotplug.h>.  
> > 
> > +1, I just stumbled over and this is not fixed in today's Linux Next. I'm
> > wondering how this was missed during merge into Linux Next. Stephen?
> 
> I just get what people put in their trees.  There are no conflicts
> around this and none of my builds failed, so I didn't see the problem.
> Has someone sent a fix patch to Andrew?  If so, if you forward it to
> me, I will add it to linux-next today.

Andrew has backed it out of mm-unstable now. There's a v2 [0] which
still has runtime issues but AFAIK it's not in any tree yet.

[0] https://lore.kernel.org/linux-mm/20250303-pageblock-lockdep-v2-1-3fc0c37e9532@google.com/

In case it helps calibrate expectations: I think this particular patch
had been reviewed but in general some patches get into mm-unstable
without any review being recorded at all. My understanding is that
Andrew squints at it and goes "that looks like it will probably
eventually get merged" and puts it in so that people get a view of
likely upcoming changes.

So if an issue like this reaching linux-next is a big problem then I
think the solution is not to merge mm-unstable. I'm not sure how
high the bar is supposed to be for feeding into linux-next.

