Return-Path: <linux-kernel+bounces-567214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 199A8A68354
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 03:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB7FF3B645D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 02:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB1AAD2F;
	Wed, 19 Mar 2025 02:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FK+uq6dA"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB1C28F5
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 02:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742352590; cv=none; b=P8x7rGs0nTSkeCEzTn2Id1g2NEHyJp4B02Jt26LKtNW7GAe+R7aIOcw7L47pzxJNIw2oL7Oht0u/ccep3dhvKb+UBlp2/69s+SXoY0kk/TxbvO1yl4aEqrDUcBRMVjpxAq8xIQBd87FUMcxwz3/AKJ9zwKn1OlpVFIjl9/q50bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742352590; c=relaxed/simple;
	bh=pICdKZNcGC+5zvEc+vvoa3FV70H3JSDGWKbzRWJArNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VwIyo7NriHnDG5rebq0502b2/q6xa/+lE32DWjT0nV9nOMCQPwiRpSd9oNda2ydHMiD94fLami4I/49RNhxtEf2Mpz7t7s/fOBguSPHPzIPwNJGbPyHbufMv45uj9I/aovIiSjhP3EB8tF103PFnRDeJ8i4uwD1mU8euPnyaxpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FK+uq6dA; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-301918a4e1bso3882678a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 19:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742352588; x=1742957388; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zMjmwags9PxBLRAOXxKiTlqWWUculpX9nKgMI6vXHOk=;
        b=FK+uq6dATWLWpMDS4PvL7VUyFKJ0PHP6wlWGtdZntK4bgsvQtXPkh2z0ITAgETrV/e
         M8WAxqopvTHdAbVcVv3HoyF642ndJfhjxXNm8XmeEiRw3c+e5D1hLny7hMYZzhbmMLPs
         V0vp7tYAWyyGyZ2ONWrAy7vlOu1BlxqgdDTJbW3yn/f6XoZJCZ+U6UTyojhtRq7sDAd/
         X8CSqy/cYtdSLvwh8O3WSFt3GyNC23qYeYAni1qsgHJ6ASQtmq0b8uO0ruwxMbDn9vOH
         12p4JyJiy7qwoQ7SxSrNEUcPEAY7gXZsgYovp3m2y95PwnLXiWaqsu/rwn0p3rl6tvYe
         fLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742352588; x=1742957388;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMjmwags9PxBLRAOXxKiTlqWWUculpX9nKgMI6vXHOk=;
        b=vvga7Ypiivwsw8VtdrJq4xYW+6Cv1+1Q+YZGVitVc5wcyLQ4DCD26W+HJvb5ZlvQDT
         C6yggHILluP8W7QS9XgtxWkkzodABKpHKPH3HtLT7Kb1gzHdlfijZqk7+SkDNL7WeD+l
         5VZOpYgD2nMpBaPEuKfRa1nvwBmClqhxOQlH0ADk3yCQqtDdX3u2YiSrFWwZFn2nXsF0
         /zBWZLFWJJqc5NoCfe9Roq/9QsEj0zENIFSfcgSRYKZ3YZo1CwaBhsWDNhMlwNDEiWOf
         uhxe/2QfJV3/0fLPv/KXu+hOJoI5cxgaBAPcldAs2RwAhdqFQu21YjrLnA4fO96uJQsl
         Sdpg==
X-Forwarded-Encrypted: i=1; AJvYcCWZitdZcXE1yRo2IAI+nNFgfADlc5pbzy9HhRFDPQf5xIjs0lgGK+50SHQZjvivSkflcEAHGt4Fg43hDGo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs+W4pTp5WVDDR9E7AY002zpU7DVTqUG7ojba/I4facKPM2sos
	Pam3AYQhjux0FulbJKKBtPJy4OpnI3oqrXnP6dAi6WPTq1bbmylt
X-Gm-Gg: ASbGncvbFZ2g/DvT1BGiCAsHiDUFEDSYe2WKKvGa4F1rdpzdxdY66dXe1Zo5ltfJWKk
	8896kfmzQdQ3UaKCLbFwspfBgxshYO2e61XZDWa62KBqAO0+RkVFWppAr4XmjIKgbKa8JkbCvkN
	N1PMO3wfLArYpqozIhZNQxfmibj4ZZqbWLYQWyZRAC+7zu2fg67wePyvo/lmVmh57uNIEvrX/j4
	b9RJyS+lkR5AtyVevWuDa4deSDF1ru9qxhkWpCWztn1gyoYuP3qFSy8MRFdsR7vTnVy4IZs625u
	IknSyuBmLTKqKYlMPgeqgpUP7rkvmRWu8/kPZmGvDqYAvYlLY7EJmEgCRGu5Dw==
X-Google-Smtp-Source: AGHT+IHxy6SOL2dLmCXKbFrDeWrRe2l6UABse2nAedGfZHGSxvdnZ3srrmvkX9UhrTbS0a5suZsN4A==
X-Received: by 2002:a17:90b:4b88:b0:2fc:ec7c:d371 with SMTP id 98e67ed59e1d1-301bde5cab0mr1403489a91.3.1742352588007;
        Tue, 18 Mar 2025 19:49:48 -0700 (PDT)
Received: from vaxr-BM6660-BM6360 ([2001:288:7001:2703:2ccc:91ef:96dd:9ad9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf5cf193sm342429a91.42.2025.03.18.19.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 19:49:47 -0700 (PDT)
Date: Wed, 19 Mar 2025 10:49:43 +0800
From: I Hsin Cheng <richard120310@gmail.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: hirofumi@mail.parknet.co.jp, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
	jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH] fat: Refactor fat_tolower with branchless implementation
Message-ID: <Z9owx0FbCfc8LHUa@vaxr-BM6660-BM6360>
References: <20250318034309.920866-1-richard120310@gmail.com>
 <20250318040323.GW2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318040323.GW2023217@ZenIV>

On Tue, Mar 18, 2025 at 04:03:23AM +0000, Al Viro wrote:
> On Tue, Mar 18, 2025 at 11:43:09AM +0800, I Hsin Cheng wrote:
> > Elimate the need of if-else branch within fat_tolower, replace it with a
> > branchless bitwise operation. This can reduce the number of branch ~130
> > regarding to the test script[1].
> 
> ... and for values outside of 32..126 it would give wrong results.

Ahh, sorry I didn't take these into consideration, I guess branch is
necessary here then. Thanks for your review!

Best regards,
I Hsin Cheng

