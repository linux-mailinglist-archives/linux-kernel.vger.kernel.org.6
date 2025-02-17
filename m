Return-Path: <linux-kernel+bounces-517798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B46A385A9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DBDF1885099
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B511B21D3DB;
	Mon, 17 Feb 2025 14:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CoFuUB7V"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D17C21CC59
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 14:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801662; cv=none; b=m/Sv0A9Din2FWTFW7ET4kNaYMjRFUPv7So7iTGNBYD7swnNHPU6GFctzJ/XuiNiD5YtuIWYbz4sXdWJci7xoOgnyvhAO1bsL1lorcvJIWrntuqUDDXFABYEBhL5hFOFEVc60/2kQLeyQA1gcfqQxGgUtBxiaomHRtU+Z0YUl/qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801662; c=relaxed/simple;
	bh=DmRKIA81ischDwAmOUMnE56ItcSr1yGOCW5aJOAlBi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMV5al01JSKRDW/vWtjoU9lMCIkpfI1DohP3J4uSEQw+pBrEIv6NAjlWQTAd6KQEoJMeIa7ZRZek4SBFIgcHu/7Wiq+PQzHym1BPU7Q6bhgh3BEovyQa+omG/u7ltVAnPeLY+kGnoKWctBsCa4X9GvLORNcq0PoBpLa9gZPzTAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CoFuUB7V; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-abb97e15bcbso193046666b.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 06:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739801659; x=1740406459; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NekdZXTafvfqhoDySEOcOucxcXKvkkXorz4QTbjm09c=;
        b=CoFuUB7Va2KM2WkUvr8rHHtuXRuF5vEmV4WS4i77FzWP7MPIkbCUhNusf3nGuWTISB
         YRJIYEppJQaxKFsE2ZrEovaorkE7MKt4YBJSbYKEvlYcD1431KQwn/G64vEPD7AGOg+A
         Rsa17W56HAHwpyc1aLEMA5hDmpAPWMyibFCG5ZSkve98ngBrUxRhBqjbUpLmb2tVY79a
         SFw+HgZLGii4eFm3XKDQlHfdpwdeRhSwh8jciN856MB/KfnNezsQGDFjw6LeOdNpFkft
         TNgs8ksMnP/OWMh9ZZ/uX4XXl5xalaB5fiAnjtDpbktPAPAFYHODnTzasLXLRWBIUs1Q
         y/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739801659; x=1740406459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NekdZXTafvfqhoDySEOcOucxcXKvkkXorz4QTbjm09c=;
        b=QeqCFflbvZ9AFS52Nnw2DvEjYVeX7VgLskkKIUfOQGoiLLHpe88JYGgAgJyGjQyDOF
         hrOhkKY5TUbreUYVHQ1b8VahiJ1fn3upXHL03yn8pzYVzAnf5Mgn+usqA4fyfB73lV58
         V4L1HzZqxPWdi7EuA6BcdI6e8LIaTkuzz1JJ0CvC9v6KhmzWqhXxV4Efrpubk+ijSAPg
         ugm3J8VB/2pPHZzoM/8Vtd4/KXuAyL8scVmT5Modq24j9kVmY+1w5yB/5mSPl691yW9D
         aIqsKPw+4RtOk7nlultbsDjX/As9/rlUbNlzTTMnrAIm6KwXpKBY70OxPOr05jnE3BHi
         XHXA==
X-Forwarded-Encrypted: i=1; AJvYcCXRKV1kJqduTuA9n6W6iuARmIzPAm/kTtBA49zGbivWJnD+JOxZsE4cBPeGPIaY/Ler9KORzai2umETS94=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhsFTbhwfkjvypE+E1iYEXvV7LfvNTqUCLaPOETE1gdb6YKlpa
	gzGF/nsgqs6wB73DBQ+ShCi+rgxY76E7kLh+0Jd9pwV+EiDGgrn4VgvblF+6vyE=
X-Gm-Gg: ASbGncv5jPGug5njCKQJPGFTrdCU8VV1wKIxaOcnuOyEvTrlpNAHO6a/3cpu9aM4wIu
	BwU18G1Bd4FoB3UCpvM51aPhNd70cjgj68C7P/R2nB2X6NdhYePg/sNMe0ed0qXYKVzC+TUAYyh
	fFcmxpBhCDSUmWgqBgtH33/j1N1+gKMBBDUd0YKTxR+7LViDYP08h7tUjnUYhDIFqY0Q4RZC0Ag
	vu6GM8ZvWeN3QzaecILmg/b0iUqGSHDUqxJQndMnGJP0mThp3UASZF2sg+vFVKzyPAH7KI0zhzW
	4xaj/hrJW/KyXgIJduyC
X-Google-Smtp-Source: AGHT+IFIBR3Zp7n4KLa1AEo72USiTDt41XIvlExhYbBs/eXLCwhTItsYSqPIAHweOwZVqQQcbYAUmw==
X-Received: by 2002:a17:907:780f:b0:ab7:440e:7d08 with SMTP id a640c23a62f3a-abb70bff32emr769230766b.4.1739801658666;
        Mon, 17 Feb 2025 06:14:18 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abb8fef1332sm308806366b.69.2025.02.17.06.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 06:14:18 -0800 (PST)
Date: Mon, 17 Feb 2025 17:14:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Simon Horman <horms@kernel.org>
Cc: Purva Yeshi <purvayeshi550@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	skhan@linuxfoundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>,
	linux-sparse@vger.kernel.org
Subject: Re: [PATCH net-next v2] af_unix: Fix undefined 'other' error
Message-ID: <bbf51850-814a-4a30-8165-625d88f221a5@stanley.mountain>
References: <20250210075006.9126-1-purvayeshi550@gmail.com>
 <20250215172440.GS1615191@kernel.org>
 <4fbba9c0-1802-43ec-99c4-e456b38b6ffd@stanley.mountain>
 <20250217111515.GI1615191@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217111515.GI1615191@kernel.org>

On Mon, Feb 17, 2025 at 11:15:15AM +0000, Simon Horman wrote:
> So, hypothetically, Smatch could be enhanced and there wouldn't be any
> locking warnings with this patch applied?

Heh.  No.  What I meant to say was that none of this has anything to do
with Smatch.  This is all Sparse stuff.  But also I see now that my email
was wrong...

What happened is that we changed unix_sk() and that meant Sparse couldn't
parse the annotations and prints "error: undefined identifier 'other'".
The error disables Sparse checking for the file.

When we fix the error then the checking is enabled again.  The v1 patch
which changes the annotation is better than the v2 patch because then
it's 9 warnings vs 11 warnings.

The warnings are all false positives.  All old warnings are false
positives.  And again, these are all Sparse warnings, not Smatch.  Smatch
doesn't care about annotations.  Smatch has different bugs completely.
;)

regards,
dan carpenter


