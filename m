Return-Path: <linux-kernel+bounces-548933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BA8A54AFF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D3E71883CE1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0DD20C02A;
	Thu,  6 Mar 2025 12:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w0Xl756R"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF1220C48E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 12:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741264931; cv=none; b=IUs4N8EMXUBdRKywvV5kv7F1GpVO7RtzZ1qLP9P0gV/M00qu54BC8o8j7YdErCN2M9Cgk6GBz19m1yNu63eeU8hhFU/lPpSAeW7vPE6X3VyjU50QuBZe96rGzI0qcAqtdJBQjzr/6PEA3e92mpam6Wq1ZEedIEJwSdbTxeU9QOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741264931; c=relaxed/simple;
	bh=22gI3ylpHx/xFFYcb4YRhD6/V8m5GMoSsuIUika6lHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ioj5t8PSK4nyKFzjmEvpfxyX+hE9taxIY32h35hWwW8kJT6AlovjXaYmUkmj8KiDdWWXOWaWo5T+OBosoxy89oRObZ/bxTihHjMiF/EVwuWh4jEdiPjGArePe5GlZXllrEXZ884R4xQ52CcWD0glCJJNe3VwrI168XWjnh14cy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w0Xl756R; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-438d9c391fcso50225e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 04:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741264928; x=1741869728; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9MRAkaS5reseLkYqY2aSknQ7KzyTvAIpY7HWZEUr9kQ=;
        b=w0Xl756RUrCpaii7yQEnO8R8gkUYHE9p4TFbCqDZvKte+f2aP7Ma36YoC6V6sw/bcu
         8QZUmjDFwZHwitoiB8I3SNYllqP7vfYFtrP8eB9dVp2MjJ7Y1+oWENrJ2RpG6NzfE2D5
         ukgZkSQqX81BcbwEDkizCAbU/zhYHPRf87iow9mAu34gpaWXDDRSsC8q8XQMno7JHdR0
         c9mqz9Jr2hhHY7dU0YKJqtu39dkFUC2BCLgVq1fCiGsa7Xn9jtVrohAB7/bAC8d2/gtW
         IpBwn6yjcjTJxjo7e2Fhmm/DmgY0OR3DRJSz4QPo43f3S52DlcvlM9QYkh0Ar8mg06yz
         Ffgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741264928; x=1741869728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9MRAkaS5reseLkYqY2aSknQ7KzyTvAIpY7HWZEUr9kQ=;
        b=am6oJAo0PJsovCh3hF+lVat7N4MqyocwCJKNquwaR2HfHR1JRUrYWqeEMYmVLNOOCc
         zE8qjNfqsPUjQM5vX8P6wpNBWYHm5yVwZtb8pGOm6bCTHQJYHxI4SQyaF5lbu747xSAm
         mc83xFss6AQZpWuw6HUpCe3ROVYFNQcRo9o0qREShluAQNIThRtw/V7soRhXquZlDQ7A
         ku4tzXsg8b093f4a+rNon75hXJcQwyIrwGfaoyWnlY1zZiJx5CxTg+/2CUGjSfMwh07L
         NpG6wjN9dPAHgnuFixLuhLhOzFzyHRhzOCWb+sChFDGFybU94VdnjBAbxqEMtgj4f3g0
         +PEg==
X-Forwarded-Encrypted: i=1; AJvYcCW7E2A1mZ+E36V3fQx45SDKy2dSJfz1SsFHDwQ7J7oEE9Im72tUIgceX1x8PNjnrnuOZFwY2XjTN7xhCQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyOLSBqAaTJRJnXRQjYVRQ/w1Tkai2b25t4m6gkhfMRyufCiWI
	n1WGChkeabjnFHe69hZT0MnkxZfI3sumPuUoDPpAW7wKSTfSm8xH071wODKL5Q==
X-Gm-Gg: ASbGncsMjQb5WRBqxLZ+1J7AscYw5liwUHhJdAeAn6hDe9lcgrpHsqr3dLeBtBgOzxo
	AEtjKkncoS6jRxwUMWXfVP0FTv3lM/PPpfWdImyTBVwCuHzSyeth6EzoD5x4OKI3R6nfe8Ckr58
	JqF1sXgwJe6Wgo+4cS+snRlpvwcVoECj0Pj7fdJR9GxdG4dEeNKM1Ia4UbZe+08epZxxrvo2+qK
	eJQFrpx12yKrpD1wbcBaRf5xBux8g4VUi8r+X2lITQ5IW53ppxy11z+p88a6dkiIwUm4gxsfUlF
	8b7a4ZTX7XCVmFqltJIVWbYbKAn11dM9nTvbWHmlJZqw0X8mIw1/8AH2qtDT6rFQvplLEPjgkWK
	fE9vu
X-Google-Smtp-Source: AGHT+IGmNXAcbrIiTndMd8TKLO7wDtMCWMyWdNa1KQz3K3QIoj6wzvoQxrplVkDQaNapk/ITigBdow==
X-Received: by 2002:a05:600c:54c7:b0:43b:c396:7405 with SMTP id 5b1f17b1804b1-43bdce18c53mr947115e9.7.1741264928259;
        Thu, 06 Mar 2025 04:42:08 -0800 (PST)
Received: from google.com (44.232.78.34.bc.googleusercontent.com. [34.78.232.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfba888sm1984885f8f.16.2025.03.06.04.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 04:42:07 -0800 (PST)
Date: Thu, 6 Mar 2025 12:42:03 +0000
From: Brendan Jackman <jackmanb@google.com>
To: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Dev Jain <dev.jain@arm.com>,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 08/10] selftests/mm: Skip gup_longerm tests on weird
 filesystems
Message-ID: <Z8mYG8eQnMsOA4c1@google.com>
References: <20250228-mm-selftests-v3-0-958e3b6f0203@google.com>
 <20250228-mm-selftests-v3-8-958e3b6f0203@google.com>
 <08023d47-dcf4-4efb-bf13-5aef3c6dca14@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08023d47-dcf4-4efb-bf13-5aef3c6dca14@redhat.com>

On Thu, Mar 06, 2025 at 10:28:09AM +0100, David Hildenbrand wrote:
> On 28.02.25 17:54, Brendan Jackman wrote:
> > Some filesystems don't support funtract()ing unlinked files. They return
> > ENOENT. In that case, skip the test.
> > 
> 
> That's not documented in the man page, so is this a bug of these
> filesystems?

Um...

unlink(2) does say:

  If the name was the last link to a file but any processes still have
  the file open, the file will remain in existence until the last file
  descriptor referring to it is closed.

And POSIX says

  If one or more processes have the file open when the last link is
  removed, the link shall be removed before unlink() returns, but the
  removal of the file contents shall be postponed until all references
  to the file are closed

I didn't call it a bug in the commit message because my impression was
always that filesystem semantics are broadly determined by vibes. But
looking at the above I do feel more confident that the "unlink isn't
delete" thing is actually a pretty solid expectation.

> What are examples for these weird filesystems?

My experience of the issue is with 9pfs. broonie reported on #mm that
NFS can display similar issues but I haven't hit it myself.

> As we have the fstype available, we could instead simply reject more
> filesystems earlier. See fs_is_unknown().

Oh. I didn't know this was so easy, I thought that checking the
filesystem type would require some awful walk to find the mountpoint
and join it against the mount list. (Now I think about it, I should
have recorded this rationale in the commit message, so you could
easily see my bogus reasoning).

If there's a syscall to just say "what FS is this file on please?"
we should just do that and explicitly denylist the systems that are
known to have issues. I will just do 9pfs for now. Maybe we can log
warning if the error shows up on systems that aren't listed, then if
someone does run into it on NFS they should get a strong clue about
what the problem is.

Thanks!

