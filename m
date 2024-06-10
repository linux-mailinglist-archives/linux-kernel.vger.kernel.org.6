Return-Path: <linux-kernel+bounces-208841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 237E99029CE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 334E51C23259
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089BF3E47E;
	Mon, 10 Jun 2024 20:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="DDL16ZNN"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195D618C36
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 20:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718050532; cv=none; b=acrqpnrdISyJNdnRxwHaCAicSWwdIoB+sVova7sYcao0IhHosBKI4uGanS89e+fLRIcezEe5HB0xn9Brr+HEwYLDolhq/uCXd81rH+1YbdcpAsyMdV4MEK2F4qT+97SvvobcqcmmvSr4bxjQFg3BfQqfeumVMaQEPtFW5nzbw4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718050532; c=relaxed/simple;
	bh=QDYrkpfeNlyOq46PG3yc/lo72JX0InleOziDpaF787A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jz1ffOeYT8eqUYzb4pOxJmxFgfs0+mtUpAif3j54g5Sumonq4bNlBO7lJrIhXsuryu5i23DaHgEsS5w2a7AeqJYxhEqhoBiousQGdK+5OXzYybV+UzFE4CQVtq6JfQfGgKDNGy6IPBeQqnA0Hj1FcEZpXw5+8dD3+Ah4o9LAqls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=DDL16ZNN; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7955841fddaso166836185a.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 13:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1718050528; x=1718655328; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f846KB3AW4c2nFZH9X4EH/MCA/jm3hltyAr3O7+b0XI=;
        b=DDL16ZNN5Iaa91f7Ve3pautIdPFsXC5qQbninvjsUrozF+noEERSYPAL2AgnBFpuZR
         x1w/yqnEeybjEqJu41Ve8uxeC4WVyvKeToDLMT2B0S5pFAzGCJ8ZGsSKHf3+o5nkyuPp
         ASe+JBTP2Cw/oXhh8k6M1U8H9ltRJwzu3K64HT4XKOOLVEhyR6IY9X0Kz/ZE2VGbbT28
         opNH4OG6gFWw+1X+AizVAtBEX3xMz9vi4PUJeDye3P8TIpOwrx7T9yT2va07WYTbW3Ne
         7wUEyXCapGH7pqP67rjXjnuCi4eQoJrIB0BsfrPcKGpxQ6l61CzPsjj+85Q8TMJ2/Icq
         D88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718050528; x=1718655328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f846KB3AW4c2nFZH9X4EH/MCA/jm3hltyAr3O7+b0XI=;
        b=MOjYgvL26K5Ssjh+v7IHm2WuYLw0tLlgBAx82YL+8aCSUd8FgU2EhRTFXm/FmtziCy
         BXuvT3wIFWdq33M6Qui+EJgdX/XsHY1GFCkgcD/smrzQQ7PiNJeee5h3ZkBYyEqllG1D
         dpmX5QhM07pzdtvvy0C4aFiDA42Pc9pC9FuTVUZ0oxt9xJoT67ME/+2IzwCOGFJp3U1b
         koRbuRvZeTKzzo0jesIRhr4shI7w79J60lizWD2DkPt7n43gn2oIE2NW6ry0MpIIoqSd
         cRX3KP6BYn5FpKUgF8/UX7fa8yK7R7fucvbLajpWjwFLc9waUlfmnrFaG5jkRCvjeZXv
         bI7A==
X-Forwarded-Encrypted: i=1; AJvYcCUWyMwvIytXoyIk4awEkPjKe8FCpO9xUX+VfEYCjl8K9ksgGlCZxI+nkPhWcLfWnKSxt9fDhRm2islEwmiDAHyoH/xb7WLiKM/1bX5T
X-Gm-Message-State: AOJu0YywZZBuAwOS6cvpLREXnIEAykCKG1hrgGjqPOPFJVLCsNfffGu1
	KWO9qVkxJ5y+2DnVzOU2Ixz5Kav7k1TdSW6xJqPkX1rNLxu1NWM4Q4APtpdrzHardLvit6VoFk8
	2
X-Google-Smtp-Source: AGHT+IEAxxhl9X6MeL09eAr6w5axAZ6/2hC70TjPpot+ne0b5eqMoN833OwVY4njvMPTbqSJ6S8YyQ==
X-Received: by 2002:a05:620a:294a:b0:795:498b:5fda with SMTP id af79cd13be357-797c2da0038mr127591585a.22.1718050527911;
        Mon, 10 Jun 2024 13:15:27 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79689c09e28sm111635985a.121.2024.06.10.13.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 13:15:27 -0700 (PDT)
Date: Mon, 10 Jun 2024 16:15:26 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, yosryahmed@google.com,
	nphamcs@gmail.com, chengming.zhou@linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] mm: Do not start/end writeback for pages stored in zswap
Message-ID: <20240610201526.GA2407021@cmpxchg.org>
References: <20240610143037.812955-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610143037.812955-1-usamaarif642@gmail.com>

On Mon, Jun 10, 2024 at 03:30:37PM +0100, Usama Arif wrote:
> start/end writeback combination incorrectly increments NR_WRITTEN
> counter, eventhough the pages aren't written to disk. Pages successfully
> stored in zswap should just unlock folio and return from writepage.
> 
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>

I also don't see anything in those start and end calls that wouldn't
be pointless churn for these pages.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

