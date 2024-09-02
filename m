Return-Path: <linux-kernel+bounces-310598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4B1967EDB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8D411F225C5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 05:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B81414BF89;
	Mon,  2 Sep 2024 05:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="31RmTM0C"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039E564A8F
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 05:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725255418; cv=none; b=s6buMhUcoUBw8+Wpm39lmDWhqyXaj3tW3x2hCC6FG6BPYL660pk9DvGUlKnL6jeGNDsC2QX98QLwBKAzdkrJaFlsQb1+kkw0hfOeLrAMwdhiAxEgi5AKYs5tvcT0PTPT5eNNuzcE12a3idLibqnzdEL4YE2NJD5qknczwC/4HeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725255418; c=relaxed/simple;
	bh=vyexIiq0G3KdAGHxQw2FFAbj2lEAiY2GbjMYb6gvJLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EsAdMbBGj1oB9O5WF8qmRXvkc41P3WOPNpYCCbC8n7NmzKNsbrW5G8tg3HGz7VjZT4tjeOYfpKalCNJBaDLaqGYKa/3SWpipIcflTlVd6th4jC4F0gw5fHiRHCBI5L97/udjBQ3sWXqGhLMJdfvOkwoXFmDpy+t0ePtV7ha8ziM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=31RmTM0C; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-427fc9834deso54865e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2024 22:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725255415; x=1725860215; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MQ7nhItI8VmPcJbkkl0nLAZengIZ/zDRojcMk7WM8B8=;
        b=31RmTM0CbfKDJL5kZC6Kx4BxgQ4KzwypfOJu+0Xpr8I2twWE7LTVtHWIKyjJ+Uv3Xc
         +eHxyBPi0ENIvgnyqwIHCzVfvR3qtvCYzI2C4nYl7MYLj+ohlq5a2XgB90EkAO+6V2d9
         5v/SMA6zMz699v/cXHZ69Uh1m9fpPXyaA1JJ/gWJG/x6gvwA06mOmZhtuGbqxAZZcazK
         xC//DwbWtSmguJF+XQs/Q7PwbX4OrtQNJuCEv8sohOY9pQFmvMt0HtWpOzEnX+jbcjP6
         Z4JhpbEK6LhQxByoZ+2f0yyVU89Y7CO9wd7dne/6mckNUx9KjAvfbooP104BAGo0hIoZ
         QxkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725255415; x=1725860215;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQ7nhItI8VmPcJbkkl0nLAZengIZ/zDRojcMk7WM8B8=;
        b=q1b5RmqF+ZvCVxWQvAsGRNG3o9+1U9GVy87loQuBzV5sp3PDIMqEdBrvZHys7STlul
         PeY9qSPKVbCQPNwpYKbcwiT0qtx3DQGRZJML+Wn6KZweKOADkPZEwCIXP3W8SsoBQN+b
         Bn5M2joMuto1NMYp3tQYQKW+iCNdoKRF3u/O4etLm+5SJ182jr15akveE2D8EG8P0P0T
         DBrfTqvy9FluQHNBr0yoJOmOBQ7xKWkq63MStaO+5/k6rUgRuXJJwUt7taadSe9WQXiK
         Ip6nwGKsogrK3h7FVJ8ab4rffhQHDZCVyi+FllxA6Icdtol9Et3U9zl9jjjpoIFQHgwC
         WO3w==
X-Forwarded-Encrypted: i=1; AJvYcCUvP18HtllaFujWXBIfZDjViYY3bO89N23HqswEyASyVmucCHp5NIJDhvKylnOnnYIJVnC8dirLcdifDRU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp30JiZiELDhz0sJf6cS+0d5/ZTolX02Nvt2kfD1clVUHgTy7u
	gHQYp40eFQPXd5Wcr0J90UPOUAhnt5xpXpL6+KzHzLGZAgCA8ANY+KbuzXRC9g==
X-Google-Smtp-Source: AGHT+IGH0lniufb3F4A3bPXzpfW2OpZ/dm4ZIb2y+w4AUpvlVhKTQmc4hKWVFLY4JC77+3GFg8WYZA==
X-Received: by 2002:a05:600c:c15:b0:426:68ce:c97a with SMTP id 5b1f17b1804b1-42c787718b8mr1641265e9.7.1725255415043;
        Sun, 01 Sep 2024 22:36:55 -0700 (PDT)
Received: from google.com (44.232.78.34.bc.googleusercontent.com. [34.78.232.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42c846d2fdesm11837575e9.22.2024.09.01.22.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 22:36:54 -0700 (PDT)
Date: Mon, 2 Sep 2024 05:36:53 +0000
From: Sebastian Ene <sebastianene@google.com>
To: Marc Zyngier <maz@kernel.org>
Cc: akpm@linux-foundation.org, alexghiti@rivosinc.com, ankita@nvidia.com,
	ardb@kernel.org, catalin.marinas@arm.com,
	christophe.leroy@csgroup.eu, james.morse@arm.com,
	vdonnefort@google.com, mark.rutland@arm.com, oliver.upton@linux.dev,
	rananta@google.com, ryan.roberts@arm.com, shahuang@redhat.com,
	suzuki.poulose@arm.com, will@kernel.org, yuzenghui@huawei.com,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v9 2/5] arm64: ptdump: Expose the attribute parsing
 functionality
Message-ID: <ZtVO9VDe-26jQFUK@google.com>
References: <20240827084549.45731-1-sebastianene@google.com>
 <20240827084549.45731-3-sebastianene@google.com>
 <868qwew5xn.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <868qwew5xn.wl-maz@kernel.org>

On Fri, Aug 30, 2024 at 01:28:36PM +0100, Marc Zyngier wrote:
> On Tue, 27 Aug 2024 09:45:45 +0100,
> Sebastian Ene <sebastianene@google.com> wrote:
> > 
> > Reuse the descriptor parsing functionality to keep the same output format
> > as the original ptdump code.

Hello Mark,

> 
> This sentence seems either out of place or missing something, because
> this change it not reusing anything...
> 
> > In order for this to happen, move the state
> > tracking objects into a common header.
> 
> ... but instead doing this ^^^.
> 
> I propose to rewrite the commit message as:
> 
> "Adding a new page-table dumper for stage-2 requires parsing the page
> tables, and reusing the descriptor parsing functionality would help
> keeping the same output format as the original ptdump code.
> 
> In order for this to happen, move the state tracking object
> definitions into a common header."

Thanks for the feedback, I think the re-wording works much better and
I'll make use of it.

> 
> Shout if you object to it!
> 
> Thanks,
> 
> 	M.
>

Seb

> -- 
> Without deviation from the norm, progress is not possible.

