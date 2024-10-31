Return-Path: <linux-kernel+bounces-389965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5460B9B73C9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 05:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19A07285996
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 04:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CCD12C526;
	Thu, 31 Oct 2024 04:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RU1Ta9i4"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7672F1B95B
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 04:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730348336; cv=none; b=R1jw9tyzm5TT6huFVilx4QeOBwl5hWZBIYZDOmHSPQcYnZRvnLACiBx8z3bH8kUciKCfuywlrQYfY4XP2TXZZ7BZxamh/HnXL6HgQCCcU0yboGonTvZcxnkbdCATIprW7yH2Ye+dRU+2uM3niMp5be5P5lOZJYZvSG63a0rZ46A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730348336; c=relaxed/simple;
	bh=p7/qBQ8pktHx0yeOjh32JpOwhlVU8aXRGj6y737FKuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GPjRqCHtFfqLeiScPWPzacYSrtaeBYwBuqQxxozYcX6fQX+MtH+Rm4wdhifLk+Ivcu4vOa0/VChl79GhIflRUhbdmsGve2fNZWUCaxWO7dZo02EUU1uAK22VQKjix6pgPmcw6GkcMqT1Ujoo6dSXgNgQHaJWBfJSu5yZVkd+Uac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RU1Ta9i4; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20ca388d242so5410345ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 21:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730348334; x=1730953134; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UkVs1Y+CuMo3+Eh4nNB4M87+SHBReCgyWbkGailay5A=;
        b=RU1Ta9i4grLmLICnOzT3h+p3j/wTUwd8giImxyC8H4h8ZpzOzFhGRDGc6uzH892g1p
         rcxySdHkMz3yTTQxu8TVCu6h8ZFJgnJfIgX/7XtBF762ozeJgfyMNvaa3XUaU0PQN4iY
         XDe2KbFQErLkq2j5yF0VFSwDBPTi3HVo/QTbqCjWnI2eEiEk76L5q6WMGTpMrUnOrH7f
         7hE5RC8Et8iYCrtZ7nQiLPyv+ieQ3c6/u/g1TY9t4Eke49SaelMLjxG+RkgsV3vw4v3t
         oEtJj8dh8uCLKKznDysZWctmFu7vDRwitntUTBnomiJESnRbMGaQU/6UDv+lYJVeSoPe
         nCcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730348334; x=1730953134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UkVs1Y+CuMo3+Eh4nNB4M87+SHBReCgyWbkGailay5A=;
        b=HSadcWU5PtDX8zOa2MxADMq/PFwG176vDXdMvvxmFKAcX/XaqyBqb0hsLtAJa6Zu0P
         Bh8eyEfNTrVY8qWrRITDT2Noyb8iZnJKsaY7dQLrErfn8RzqkordB8nnvEdjbjtMUauQ
         wQAu1paGgz59x8GOlRJT8lU3qjTjqDGrUBsHgDIdqfvx3CJJ+QmkUPraEI6xpRz2YF5S
         P12fukTprKPyuOISHOscUwoLdz7aOfD2ScUEIrcQ7Mn2kaFa0uMG44ugOQtW5i66tQ6Q
         MrEAMOtakszbQ1ijq3bQDqi6USNfRgVLHhHiVdQR6LoFJP2bC/ov9H0GQI859RAjmEtL
         yyiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQHjqyGD9EiN9cuoSppGOJa+iGBC71hnB6iF6Iw8jqUwhkliNiirpfAxzvxVR2+UvrzB5kkI1UVQSuLS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIJ1L4hWDDqAXCuk8BPc5VtxKRLscSU36QqB7ryjBuIAjFiZf5
	BwlwDLOSt3Vut/9AiOTV7/PtiNXMYNsbv6n2tmxt96S+eyh8XVDJ
X-Google-Smtp-Source: AGHT+IHFWV367wh2uPQdt2rqVSEtCofg8Ekol1GCNvYosDA5Ysjy9NbyROKs/diI534vGfb87lE+9A==
X-Received: by 2002:a17:902:f705:b0:205:2a59:a28c with SMTP id d9443c01a7336-210c687c61fmr217240305ad.1.1730348333529;
        Wed, 30 Oct 2024 21:18:53 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2110571b5ebsm3212525ad.117.2024.10.30.21.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 21:18:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 30 Oct 2024 21:18:51 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm/damon/core: avoid overflow in
 damon_feed_loop_next_input()
Message-ID: <4dd8ba2c-e994-417d-baa9-47e40b50c1b4@roeck-us.net>
References: <20240905172405.46995-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905172405.46995-1-sj@kernel.org>

On Thu, Sep 05, 2024 at 10:24:05AM -0700, SeongJae Park wrote:
> damon_feed_loop_next_input() is fragile to overflows.  Rewrite code to
> avoid overflows.  This is not yet well tested on 32bit archs.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Closes: https://lore.kernel.org/944f3d5b-9177-48e7-8ec9-7f1331a3fea3@roeck-us.net
> Fixes: 9294a037c015 ("mm/damon/core: implement goal-oriented feedback-driven quota auto-tuning")
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
> As mentioned on the commit message, this is not yet sufficiently tested
> on 32bit machines.  That's why this is RFC.

Is that patch going anywhere ? I have been testing it on a lot of 32-bit architectures,
and I do not see any failures.

Guenter

