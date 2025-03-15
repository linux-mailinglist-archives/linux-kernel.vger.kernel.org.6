Return-Path: <linux-kernel+bounces-562519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8591AA62A4E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 10:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1789D7A5902
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 09:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40F81F5839;
	Sat, 15 Mar 2025 09:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I7WhZ8hX"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266141C84C9
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 09:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742031594; cv=none; b=Z/jA7Tjok69eCBIXOSlfjmSqXbNK42hUefw8sMEJ1RFJhbgKIiAltrRU6BArmFuARFfn2of0F9RWgBX9AjBPkzC7cCNAaJXLelhD9sRpZIP7NowFADzW415z1ZU+bptT1rteNze7C3Y0pgZJP0jRs54PY84GCw9glelLmsUBfkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742031594; c=relaxed/simple;
	bh=sq47Oh+DTt8mQvgg0HAPCaqwqq5A7Wu/avEExEqpCoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2U6Z+U7KciXbXGNxHGmQAehFFdVe2ByG6yACsbgmdBQT560ejEg4QluuXpXLPTzeLWGw0QLHGGM7dVJAdjXuYlcMSgPUCVI73tAYIOjpT69mJ+3+gegOaAYSKItG8rOVdIIuusZz5uE3pEibvczdYpQKdKEb10jnSo+Aj3djhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I7WhZ8hX; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3913b539aabso1796785f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 02:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742031590; x=1742636390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MpprGEUK/a4fpAj/8Aqk/exRNk0cc1umgsVYwo9fvxM=;
        b=I7WhZ8hXXiqD+MUPmqpTT4nqbja3m53jEhDWy/TUOr4nPcTaKpR6vb84Q21mRT8xot
         7WPm9MYvqmv+AE3a3UbLdRC9IQdG8UOkZR1uFqXCZR0jHSExIhQf1qbKQKPmWhrkh0CJ
         l9uN0gNRY3woedydz/t/MVNL5gztPNBTOfzPgmoI7dU32Mpitejv71t50DxQ+1sj7198
         lFfeDTg+Hu9ALLHmvXozpY1AtZQUlW3gYUJW42A1b/xcNQpCWYvM/CdKRKxPdGS22dbD
         7jx2LmYo0t13WaKoa8elQzyMDQ7uXB9zYzIWh+GGjFQG9Xsy6uHLwvRu6vUo9Y2YwfGZ
         zyJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742031590; x=1742636390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MpprGEUK/a4fpAj/8Aqk/exRNk0cc1umgsVYwo9fvxM=;
        b=E/4Ef4UcOBpDZLx8dW+dZ0PSliGQfSO7AUl+O1YkhfGNJEKJWAsPUwBBkWubrNg19A
         v3P3XrXTFoaZmXJcYpJm6MDFIS12qto+j07QAxmSK6oxI+p8Zn4HAEqshHAX+oSLNcCl
         F7AnwCppC8+UYH1gLMm+TEKMx2RaU5K+z/svbLEcIsV2Li6DLMy9Oauy6uEL40yR+nVW
         8fOxbHFTYQmIts38eO1WH0P8xkhK+0VhIfTgpSu6khSN1SW0gOXxM+io23/TRSZEIaZh
         xpAoIbu3qCVLyhdV5lj5LE8ywJXHsKw9Bfe91ZmB0uOFPr6ErbsA1MHYnh7SE9dY19QN
         oGgw==
X-Forwarded-Encrypted: i=1; AJvYcCUfinxfONY4BNOxwcO+Hrd37UX62c7cQ9ZFYj4468eHar6z6EAI7hMJuWEc/iqRcWcPnHs/WP7iXyQQZSo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9+6IxlfTJc1Oz1E3pBoa7AEc+KB48irE8KNsb9/myqKpp5m68
	3Y/aDHZGs8w63F7rgDK8QdZHNRa9ptO1t7Xu5FtDrTy7nVyAShOe3tg+iH4wSmocApsExlHYnTf
	t
X-Gm-Gg: ASbGncv8+lFtGaY1Oaqw1YLIs4uu7J+BN6iqT1hJpl1PezVWY/SSNsaFnBygbqajXrD
	6FGv770BAeIfm4p2jro9Kb1sVMJ8Fn4RO+YgFdGXdJPRxYIWhQn9pVQyfc+tMDyyxYMAj44N+XC
	cpCDAk3CgwuWzdpcbJGujFF8wD6J+ZAcsgyeCq1mPfs7vE8kTFkZoqsJIpeMUXnZJzsA1UMmvO+
	dWrCUogIl2+aSUSJ08c4C13FT6h9lVSdkDQZvIdfzWTPwPO9r2Mf9HpMWCdYtP0bLx57W15cHEr
	jeHquVLiN4EZOyRidpkuiP+RJvqihdvVcD14trA+vkb1OWPwiw==
X-Google-Smtp-Source: AGHT+IFWe+lGcd8hOfySiAmaHi5FuBTMwIsDk2czxA5eUnLjOHnRjuiXJKnQtaEEiRnhc7xs3djV9w==
X-Received: by 2002:adf:a2ca:0:b0:391:23e7:968d with SMTP id ffacd0b85a97d-39720d47d2fmr5370083f8f.47.1742031590443;
        Sat, 15 Mar 2025 02:39:50 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-395c7df3419sm8214531f8f.9.2025.03.15.02.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 02:39:50 -0700 (PDT)
Date: Sat, 15 Mar 2025 12:39:46 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Elizabeth Figura <zfigura@codeweavers.com>
Cc: Su Hui <suhui@nfschina.com>, shuah@kernel.org, wine-devel@winehq.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/4] selftests: ntsync: fix the wrong condition in
 wake_all
Message-ID: <f86c7af5-9e7f-41a0-a357-6a356fdeb0b9@stanley.mountain>
References: <00d17d6d-19c9-4431-a3ac-c0f767c533d4@nfschina.com>
 <2051560.PIDvDuAF1L@camazotz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2051560.PIDvDuAF1L@camazotz>

On Fri, Mar 14, 2025 at 05:13:50PM -0500, Elizabeth Figura wrote:
> On Friday, 14 March 2025 05:14:30 CDT Su Hui wrote:
> > On 2025/3/14 17:21, Dan Carpenter wrote:
> > > On Fri, Mar 14, 2025 at 03:14:51PM +0800, Su Hui wrote:
> > >> When  'manual=false' and  'signaled=true', then expected value when using
> > >> NTSYNC_IOC_CREATE_EVENT should be greater than zero. Fix this typo error.
> > >>
> > >> Signed-off-by: Su Hui<suhui@nfschina.com>
> > >> ---
> > >>   tools/testing/selftests/drivers/ntsync/ntsync.c | 2 +-
> > >>   1 file changed, 1 insertion(+), 1 deletion(-)
> > >>
> > >> diff --git a/tools/testing/selftests/drivers/ntsync/ntsync.c b/tools/testing/selftests/drivers/ntsync/ntsync.c
> > >> index 3aad311574c4..bfb6fad653d0 100644
> > >> --- a/tools/testing/selftests/drivers/ntsync/ntsync.c
> > >> +++ b/tools/testing/selftests/drivers/ntsync/ntsync.c
> > >> @@ -968,7 +968,7 @@ TEST(wake_all)
> > >>   	auto_event_args.manual = false;
> > >>   	auto_event_args.signaled = true;
> > >>   	objs[3] = ioctl(fd, NTSYNC_IOC_CREATE_EVENT, &auto_event_args);
> > >> -	EXPECT_EQ(0, objs[3]);
> > >> +	EXPECT_LE(0, objs[3]);
> > > It's kind of weird how these macros put the constant on the left.
> > > It returns an "fd" on success.  So this look reasonable.  It probably
> > > won't return the zero fd so we could probably check EXPECT_LT()?
> > Agreed, there are about 29 items that can be changed to EXPECT_LT().
> > I can send a v2 patchset with this change if there is no more other
> > suggestions.
> 
> I personally think it looks wrong to use EXPECT_LT(), but I'll certainly
> defer to a higher maintainer on this point.

I'm not sure I understand what you are saying.  Are you saying that we
should allow zero as an expected file descriptor here?  I don't have
strong feelings about that either way.

Putting variables on the right, Yoda speak is.  Unnatural is.

I did a git grep and the KUNIT_EXPECT_LT() just calls the parameters
left and right instead of "expected" and "seen".  Expected is wrong
for LT because we expect it to be != to the expected value.  It's
the opposite.  We're expecting the unexpected!  It would be better
to just call them left and right.

regards,
dan carpenter

