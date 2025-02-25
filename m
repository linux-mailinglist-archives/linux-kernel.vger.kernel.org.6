Return-Path: <linux-kernel+bounces-531495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E187A4413F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0C9B16250D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B257D26989E;
	Tue, 25 Feb 2025 13:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="beQW1Wi/"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8D410A1F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740491023; cv=none; b=SBLa21WtCBEA2B3mwdabjIKwJ1mRhG1fKnU2j9J6Oso7mc6CduRtQE0mIGeyVZRCuhuXnZQnFb44QgH4j+NGpx1sC4WH/MTRCjQ4+LdvZrRxIul0rEdIxC4WoUiBgqfADIkASBODWa2VYlj6u6QLPRd0T8YpoaYqokhR4d0bGdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740491023; c=relaxed/simple;
	bh=bYtbXkw85LertaVP5XNzlrVo8ThsxsVDkqzoSrhNlPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=erpWYThJHhnRejW89WuyYFQ/L0ghYYUxyhendF/OHKzR8OgoOcXsnRePDeaxMSBRb6hfvn4B3qWl59D3xxvK/Cws8oTDBEnx1emBXEDhwo7a88xyxdIWGd8aMWg8fsR60YJwtZHqfIhjB76ateU6VQiKz7Fvs14jEdUI/BJ3KEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=beQW1Wi/; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-438d9c391fcso54045e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 05:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740491020; x=1741095820; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1l80lBL/mNDkCkqlqaJQnJpXG/PzTpaEfBIS3srxd18=;
        b=beQW1Wi/D/x5RQa1o9y/Vs0b1WVvEsNwbYJkk/7eux0BELOgOwxDAyzsVAntDRS/TW
         EvykUgX2Yo3qCSIfW6BEM0HcDjFibnsR9nJIqKeqQ4HGm0xETG5jHOlsLR5ur3Wpt17b
         86tk6Jl9JUHyMqzVsZnnGWNl7SMGfyUSP9viXbY8SktUILfP3+Q8AAN6Y5/F/IqQA++g
         4ui7yxLrRXzTQZUTLvACDrdoc6WtWv5WTlfBI2IMENeWs16A4I9dtTFFkYuw3Mq2q7gD
         aKXvBQwU0jENiz32DQvgN6UzbB1XRgaPLqkSuS3zyGED0NQOrUXuKGFwcLeQC+tdzDl3
         L6RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740491020; x=1741095820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1l80lBL/mNDkCkqlqaJQnJpXG/PzTpaEfBIS3srxd18=;
        b=cVeam557zu0LOhLBtvUNRbp2NE1bNwXNUR9DD6pWHNAoI7qilSe4EkFXX87vSl6oNm
         5Bm+UGYW7n2PUJ974xV2Ea6KW9vsGkzqXP9STGrj3EyZDBJkNfY1G7dKlxyb6tz7NjAg
         uEKjCKXCqe6btGdG8dUs8SUbJT6b8h5Yj8kJC15qwKaI8A84/r28XclVPoyBBM2uNWiv
         vUU1NDDU/WW++zZa2fVvQMdBnGmS1A1z0U3XKLWYresc12kX7GtJG15Qk5Qe5xt0cJyA
         XvGKRcFPsez9LqkwmEqAGLrej2Uio+73PnKsLVNw+5XbtIovKsBvr4qQVhyfZXm98m57
         D12g==
X-Forwarded-Encrypted: i=1; AJvYcCVemN0emk7wGlA/OHaGZCCC8aRpqkGL6ahOJcW7X/mpAO6z7d3RK4P5LEbDmL4BE6WnkwJPGA7KyZclTV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZpGvggw+P9UefzWe//ygNTFvZryStEXSivXbl1XOS0YzsOtG4
	ga8w9h4s9yFu1fl1KJdKzxBweMHnlW8Y14BUANCswZikScJK83hIrvGsLidd2g==
X-Gm-Gg: ASbGncuiTHckRNrzCadXx9Ip15/vXVmcp7M84Iwu8TPK0UalAb07WoJWish9ffiJdqr
	Yne8t3u+koeh5HDAZEDm3h/COBhKdeafXq/Sym3BECk2KtHkkG3uYwpA8FtVrisXlr2HAxxFNeT
	dfuog5aDmeB+P46QBZiL15ev2hBOChqFAWs2+LBUKb0omJ0p2/+x4pJ2URm4eU7k7I6Rn6yV/EX
	1E9ebxgLgTGy18m3JHvwu1FugAwfFZOpVc+Fm9tRN9AEWfEiwtH5R4whp0b2ZTt6EqjjsiFNEYw
	x+I5V0VpYdxJoQbkWu/Stu/5AfJ51XP69mRyZu7fz+Po/rKbcpouaiyxyh2hs4Br
X-Google-Smtp-Source: AGHT+IGlGAuQNs/arkLdKoyEJpl7iz4HmnLufRbV2k9k7tDIljX2Mz+Zx4NMCtTl7Emiii9huUBMSg==
X-Received: by 2002:a05:600c:5850:b0:439:8c80:6b0c with SMTP id 5b1f17b1804b1-43ab0f29ac7mr1272785e9.0.1740491019656;
        Tue, 25 Feb 2025 05:43:39 -0800 (PST)
Received: from google.com (248.27.205.35.bc.googleusercontent.com. [35.205.27.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b036756csm140784665e9.31.2025.02.25.05.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 05:43:39 -0800 (PST)
Date: Tue, 25 Feb 2025 13:43:35 +0000
From: Brendan Jackman <jackmanb@google.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm: page_alloc: remove remnants of unlocked
 migratetype updates
Message-ID: <Z73JB40tGaWyVIJK@google.com>
References: <20250225001023.1494422-1-hannes@cmpxchg.org>
 <20250225001023.1494422-3-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225001023.1494422-3-hannes@cmpxchg.org>

On Mon, Feb 24, 2025 at 07:08:25PM -0500, Johannes Weiner wrote:
> The freelist hygiene patches made migratetype accesses fully protected
> under the zone->lock. Remove remnants of handling the race conditions
> that existed before from the MIGRATE_HIGHATOMIC code.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Aside from my WARN bikeshedding, which isn't really about this patch
anyway:

Reviewed-by: Brendan Jackman <jackmanb@google.com>

> -			if (is_migrate_highatomic(mt)) {
> -				unsigned long size;
> -				/*
> -				 * It should never happen but changes to
> -				 * locking could inadvertently allow a per-cpu
> -				 * drain to add pages to MIGRATE_HIGHATOMIC
> -				 * while unreserving so be safe and watch for
> -				 * underflows.
> -				 */
> -				size = max(pageblock_nr_pages, 1UL << order);
> -				size = min(size, zone->nr_reserved_highatomic);
> -				zone->nr_reserved_highatomic -= size;
> -			}
> +			size = max(pageblock_nr_pages, 1UL << order);
> +			size = min(size, zone->nr_reserved_highatomic);
> +			zone->nr_reserved_highatomic -= size;

Now that the locking is a bit cleaner, would it make sense to add a
[VM_]WARN_ON[_ONCE] for underflow?


