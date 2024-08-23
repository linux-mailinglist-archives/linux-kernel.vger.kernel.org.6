Return-Path: <linux-kernel+bounces-299539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3AC95D604
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 21:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BCD11C22278
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 19:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35F2192588;
	Fri, 23 Aug 2024 19:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c19U/iiO"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0F38F6B
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 19:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724440822; cv=none; b=ECNzSap1OGiVLPnVeBFtCIz39jh1beK3YJQA6/U4LRS2dDfWe01CkL8JPIXcQ/oHXajhfSMIURY8XNPJmE6cotXc8A9hKUJc5ePO5UdwOZD8UVfQ5RAwNVMVK4N91FGj0RJ6+0q4nKkNp/1n6M/XcZC3KgFfMvLHkj7gBphllGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724440822; c=relaxed/simple;
	bh=iDD9lSaT3Sp0xg/rTdH0q+pzugBKBUX9sq197L43Yik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbFRU6N72g/rYG/fCS10TkEq0vc1HzAtsE6tVsvDhzXHYhZc2mOQ6xClzA8MuJfGec0TamiCtN3e2TSaF4Sk83suxSxcK77BP6hUSkfAWlcL18OanKjdz+rfsF++BPE70VR2DlTqYpOnfwDIqS6VHk2XyKThN1WX6KGr+0v5Er4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c19U/iiO; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-201f2b7fe0dso22744015ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 12:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724440820; x=1725045620; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KHQMvvb6+dnevxicO8q1f4XJW8/KeupnupjXeQ3/3ms=;
        b=c19U/iiOklGiV1g0o2Wt/rGii86ZQ3DRpvjYDfvXcwNhqk0rO2eg37Atn8WmS/oXe9
         VSDYDxNMeRIlH+CU+6xRGGdniJV1yeNDC4Ri6bje2Czfi2c6u8haoaUU1zEQlmB4wYhB
         imONtcpWIPucVzsyQYf5z6NxPAFwdnYcq+xi8//UkS2TsQBTUhD1y8czrj/tyhyLzckA
         8DzkLTrLrBQPjCMiRuiYKOzlPyxneCZrgJilfQod3SHuLAmOp/Pu3C/2Ur9gf1Awa3+n
         PSEGSJdm6uUXLInH9n3B3FWEMGb/gNM9jdjzpBflGE23bCLjXV/jp6I6RcQ9adhiD5C7
         nAYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724440820; x=1725045620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KHQMvvb6+dnevxicO8q1f4XJW8/KeupnupjXeQ3/3ms=;
        b=H1DfDGtpyCqjSmx3/7jBSelodX5lR3RejHBt1uxoqPqfzcHacDx5ffdYyTeQLqOm0X
         RNq7rMoHOkELRdUPvOWfB5rO5Z05J3I/Qh3YApBkgy5x9g1ZswSBbszOWAlJ42eIcc8x
         4veGQOgSaUM5XnvAo9M5uZX8/QibQ4gfWaXjVzGd0AdDhl1gg4mq5hVEqkkOWF9MziKl
         s4Sai17jooWa6vqSX7H4d44YOuyiADGFX5CZzXMRa37HGjh+FlbyaTpzWcEDbibPDAPe
         fSptE6WKxutGtxY3oBPxHPWg1hnZJU6rtfydUbTfeI/JbzgHsBO9R1dud53law0sf1bC
         mMLw==
X-Forwarded-Encrypted: i=1; AJvYcCV8lDsloO8r+uA2Y3+tm7LwiXqW6nrzeXA4r+Hk/FYdORPx2GFkKf8jkF+T34B+X0uAcET1BfHFvGhkWNg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym0lj89xfwt+J+ZVr/ruZN49Dq8+teCCpw/ZkO+GIEqqBcOduO
	qID93jj4A1mZe0sKmK1lH4Bozi+evgW1q8YxuVd1zebccNw7JlCH
X-Google-Smtp-Source: AGHT+IGf9H6iSBiIl0snsQoF9GORan39gQhJJ+wnKZDo4HMcBbPaX041pwm7d/h24FLq1fAfZe8esQ==
X-Received: by 2002:a17:902:c407:b0:203:a0ea:5f93 with SMTP id d9443c01a7336-203a0ea614bmr33702805ad.0.1724440820106;
        Fri, 23 Aug 2024 12:20:20 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385fcff06sm31794305ad.308.2024.08.23.12.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 12:20:19 -0700 (PDT)
Date: Fri, 23 Aug 2024 12:20:17 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	linux-kernel@vger.kernel.org,
	Valentin Schneider <vschneid@redhat.com>,
	Mel Gorman <mgorman@suse.de>, Steven Rostedt <rostedt@goodmis.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [RFC PATCH v1 1/6] lib: Clarify comment on top of
 find_next_andnot_bit
Message-ID: <Zsjg8YiiwM16e_-6@yury-ThinkPad>
References: <20240823185946.418340-1-mathieu.desnoyers@efficios.com>
 <20240823185946.418340-2-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823185946.418340-2-mathieu.desnoyers@efficios.com>

On Fri, Aug 23, 2024 at 02:59:41PM -0400, Mathieu Desnoyers wrote:
> Make the comment on top of find_next_andnot_bit clearer by discussing in
> terms of "cleared bits" rather than "excluding bits".
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Yury Norov <yury.norov@gmail.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Acked-by: Yury Norov <yury.norov@gmail.com>

> ---
>  include/linux/find.h | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/find.h b/include/linux/find.h
> index 5dfca4225fef..8a170aa55634 100644
> --- a/include/linux/find.h
> +++ b/include/linux/find.h
> @@ -102,15 +102,14 @@ unsigned long find_next_and_bit(const unsigned long *addr1,
>  
>  #ifndef find_next_andnot_bit
>  /**
> - * find_next_andnot_bit - find the next set bit in *addr1 excluding all the bits
> - *                        in *addr2
> + * find_next_andnot_bit - find the next set bit in *addr1, cleared in *addr2
>   * @addr1: The first address to base the search on
>   * @addr2: The second address to base the search on
>   * @size: The bitmap size in bits
>   * @offset: The bitnumber to start searching at
>   *
> - * Returns the bit number for the next set bit
> - * If no bits are set, returns @size.
> + * Returns the bit number for the next bit set in *addr1, cleared in *addr2.
> + * If no such bits are found, returns @size.
>   */
>  static inline
>  unsigned long find_next_andnot_bit(const unsigned long *addr1,
> -- 
> 2.39.2

