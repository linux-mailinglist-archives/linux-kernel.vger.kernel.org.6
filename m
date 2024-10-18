Return-Path: <linux-kernel+bounces-372259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E42BA9A465B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 20:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A9301F22544
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 18:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9452040A2;
	Fri, 18 Oct 2024 18:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="G5cKe+nG"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA7420493C
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 18:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729277993; cv=none; b=YYAmNY4p5OeVXz/+sFrsktABPhEhG6beT/fiVBdL+pQR+mijumhIgbXOe8OtFMFnnh5md80donDRiLgzDCrSbiLAE1b6OWGJOZx6MVQMyH5kSFF9WmeR+j2ssxR/y2r3yPzekkczyXB6QDx0lHVW3TNP8ryn84rIHTaCaXIDjHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729277993; c=relaxed/simple;
	bh=plW8z8SKu3+QyyGyhrFvZv7XZ5G+Ih4r4jjqmCXpco0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8d+qZg0aTJnuhxnQxzC0R3KnuF5C4crYYpkyh6/zFnYnA2G06Cw0WXDErFmuz+fT1UreHmyilYDjzeej0ApH6M9TamJ89DYlUOvkD/B3wQ3AWkgO7NVH9mFdeY5+8KseQoUSoO/YYs9/f8M3W91ROwJ/cfiErzkbxR1UFlrfT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=G5cKe+nG; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-46040dadedfso20316871cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 11:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1729277990; x=1729882790; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pb1+1UfZwm+tC+7iZWCj8Ys0ERez50KYFYaInKA4kp0=;
        b=G5cKe+nGge5vuTdVedGq+b/V2d+SDPcj1pXZ6eXbPBOqD26VM4qU9z+wHT9eddBNz1
         z6D0Mwgij6fKODoqMCfP4VRPmcw1GNJWD8n74CG2XBGASILJNsEG7w2nGfsluDzwQN+x
         TmPqKXXKkD4hl/mSOLGcL/bCfN4xHBdnEBYdlV7pDYQ6JTtv6Zk2Si+wx2bHPgpS37vq
         tKfdaKPoD95cyQ6LvVKML+JotxNwtzrh7dfUAGnKFZsPRV/ozJnfH/hN3Jb9F+appQBC
         wdb0gNr2VRaZFRr39EMwUgSWTM1ernD2FcTdkprMh7mAW5WarglBzmD4y1bP3/JNxbfS
         WHXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729277990; x=1729882790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pb1+1UfZwm+tC+7iZWCj8Ys0ERez50KYFYaInKA4kp0=;
        b=EZzn+4Tyfp+Ru1zklsC2abfbFINMNfvmd54cyvg6JfIXmQwE6nJGuxKN0g2oRLdgmP
         tsjSJzBtwrhAgGwPtsHOBzaPJzTyqfFT4u/sanMba/aJi97eYE0//y+fXPwn7tIyL3XL
         b9AdLdrn1PZizIEymWremRo7njgTb3g+ysc83attGMXV+anG/i5rizK0W0k+snU2oUxb
         JINDUXdC16DTgW2BEdVajgjJak9eBNuJ0Qhq/PjEpI7TMb7l9sOMguno4hrkDGXkxTzt
         Bt/1mQ3cjkfODc6ctWBbabOgVdu0X9m35l5kCu11hA8QWlULz7RXbmqmdd9cUyFXTDrc
         cuDA==
X-Forwarded-Encrypted: i=1; AJvYcCW9ktD0VpUyGfgRSZ7uXqmJcyq8w/9NoeHHAvUmhUg3nLt7HSxyGYFrwyJnWbqyagvWR55EFj4H+SG6rXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmGJ4jim5OZWgqxKxpBhFBxaPnsQ0C5wETVfx3DI+549qj4qQj
	jKa8ps9iuxW0cFN8LCqyGUELHv/2JfywWEKQzzLN2nZafyaUN1Jmtq114mQg2ro=
X-Google-Smtp-Source: AGHT+IEgGQ9FGjMYv/5XiGKKg0XIae2u/68MFi7EKw6BVkBpV271IlDS10OAac+wRz4pHVit2dQMyg==
X-Received: by 2002:a05:622a:180f:b0:460:996b:2896 with SMTP id d75a77b69052e-460aeddee5amr43899261cf.45.1729277990099;
        Fri, 18 Oct 2024 11:59:50 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460ae999ea5sm9905211cf.54.2024.10.18.11.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 11:59:49 -0700 (PDT)
Date: Fri, 18 Oct 2024 14:59:47 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Luoxi Li <kaixa@kiloview.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: [PATCH] mm: Remove unused has_isolate_pageblock
Message-ID: <20241018185947.GB81612@cmpxchg.org>
References: <20241018092235.2764859-1-kaixa@kiloview.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018092235.2764859-1-kaixa@kiloview.com>

On Fri, Oct 18, 2024 at 05:22:35PM +0800, Luoxi Li wrote:
> has_isolate_pageblock() has been unused since commit 55612e80e722
> ("mm: page_alloc: close migratetype race between freeing and stealing")
> 
> Remove it.
> 
> Signed-off-by: Luoxi Li <kaixa@kiloview.com>

Thanks!

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

