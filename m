Return-Path: <linux-kernel+bounces-541306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44955A4BB25
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 10:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43FCF3A9BB0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 09:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0861F151E;
	Mon,  3 Mar 2025 09:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RgiLBA6V"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5185C1F1313
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 09:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740995279; cv=none; b=Ge1ygggGcfbPWm2gShglo/aOvJFwEgKMcGPRQNT9VoFefpyXMgymHfLSdcD9eNwqlWYPdR70axBKp9c59ALwKxZrhwK7zLX+u/yNjXm/Un3QtVjwQpyabHPzCMzmkkq6JhNg/js4KtZUmeUgLZGneQT+XMu235TBTvQc4Ca+InM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740995279; c=relaxed/simple;
	bh=oGUOj05rbDaMdTXzu4kbEqsK4Jpmf3wR1xuqACOFY5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+BBmpnzRL7KHqojzz2RAwNwUyTsYMg6bOoB3nX8jfEu3qEAOQDGkohfC8UmYQM3ZiEDWivxgV3CBHLJv0nJd8E1M9zOW/lnO2M/b9bOlC/1sQ0POiOdAVJAgJNjyzvI0OxOEUyeD8SVAnI0uMy/otj0D94N51+87VLM1Hqu58o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RgiLBA6V; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43a9e6cd0b4so67735e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 01:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740995275; x=1741600075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oGUOj05rbDaMdTXzu4kbEqsK4Jpmf3wR1xuqACOFY5A=;
        b=RgiLBA6VqA1r/rTZL53gs0kfR6RUEaqQDh9RaY1qKZjeOunf26kirb6BD0I2qGWOFU
         yaxxzXs5YwFnooGBfWq3+wbFk/wCAG4el8F39wUkIcIj7DhW5WmYrAo8mop/6TZVYrc2
         LXjF1vCgECoOPUJdR4TrNL73Ky2id1q1c7ysIkbfCuzPz89nJhES7XjqWjmd3zvh8o6H
         HnoVQGzesXYQAfqbv5NHe7zIZf/fJD/8pJp8yZ4nobqxdE5xw4q8Ew+mEDouXGwzuBQH
         mYhLOJo35AfRH5y28lGBrtIxjk4rKRsFchMwl7eF8CD9EYUQ0OCoC94E3OWEroYFOvhc
         IzAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740995275; x=1741600075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGUOj05rbDaMdTXzu4kbEqsK4Jpmf3wR1xuqACOFY5A=;
        b=tO6pv2ih/8Kbv6dlPbxQo2uL6AoXYFOLKeWQZwJQK5HkhdN9tKI9U0ZRsVeyIc2Zus
         cL3qUT3AqnirlX7eWlS9mkLIkla/YdgDlSEtmTILgqCgDFpvNbWVPbGYhOR7TFYqiv/w
         kgH5aLi+2WGKI4JxScPMaJ5K8ckpkZbK+z+QedJlrDK4UcXt4FBY7XbIWgyfITVZWn5x
         wDtXh4I0a25fONRie6o+LVx26nR8+ERQ4Y5N4yPhy+M7Nj2MCl6HyCEJUzeduiIJrbXx
         3KpZRHgAqO2I7mOaJje/EWzAj4pzbXebLmqa/8Ls/Ph/cGwIRFvk+ly+XWiWC7GZvglJ
         uZFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvVwAvofMpga4azWuQxtBaUFNSb3MD19IDbwNghlqaLMCKvQCGNii3I+vv+4fX4XApXAS8tbqtJguzP9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVb6igssb8dEnu1QUKeE0ZkpM0VhCCE3T8Sol+vmYP5oMM/AGm
	4rmqz+XWqK0w0t2dq3CtTId3JUHlFHSk+EKX1Y6IqjB2NFFTtuyVlO3cXPy64A==
X-Gm-Gg: ASbGncuEXhcNxqvL1hjpzZTy8el19djN8RB3gF/YnLBtaKSBQUholZLah09X28QZnoq
	mFCpVsrk2h5F2x0x3QThRr2thyVAkq2M4YFLZQElJCy3wSZko4T+3YneN8ZP64tffbmRnFzN0ES
	D+QxO7EqSYrhEqNTXutFwodIDd5HflJbmUQsW8gm1YdcaWHZeWrWXCXt/6yqzXoUEcMZvgQVue5
	Pf9PBtomXY5MrF9Yal8PBT+RRShH+fYRaPw2ebn/lNHhCr4vsOzgVU1D9da3wCFoyCOznekAbqc
	733zxvEuObRIbWINWet+lxIsevwPJtF2b7sFhCHOKW8AJ4c3S0BVKSTw2kDnbPkHhoEX2ugS6UO
	Ju5Lq
X-Google-Smtp-Source: AGHT+IGuRRTpZx51thwL2b5hSvmhDVaJN8ebU23ciUC+XksIIzRnxpwUI7JqUrlrpyq52tUWkeY7xg==
X-Received: by 2002:a05:600c:3c90:b0:439:9434:1b66 with SMTP id 5b1f17b1804b1-43baff09304mr2232035e9.1.1740995275531;
        Mon, 03 Mar 2025 01:47:55 -0800 (PST)
Received: from google.com (44.232.78.34.bc.googleusercontent.com. [34.78.232.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4844a16sm13935378f8f.79.2025.03.03.01.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 01:47:54 -0800 (PST)
Date: Mon, 3 Mar 2025 09:47:49 +0000
From: Brendan Jackman <jackmanb@google.com>
To: Dev Jain <dev.jain@arm.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/10] selftests/mm/uffd: Rename nr_cpus -> nr_threads
Message-ID: <Z8V6xYvqqkPxULgN@google.com>
References: <20250228-mm-selftests-v3-0-958e3b6f0203@google.com>
 <20250228-mm-selftests-v3-4-958e3b6f0203@google.com>
 <b5b1e43d-0298-4772-ba0d-acec63a05149@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5b1e43d-0298-4772-ba0d-acec63a05149@arm.com>

On Fri, Feb 28, 2025 at 11:06:35PM +0530, Dev Jain wrote:
> Taking a cursory look at the test, it creates three threads for each cpu.
> The bounding of the variable is fine but that being the reason to rename the
> variable is not making sense to me.

Hmm yeah the name needs to be more abstract. Do you think nr_workers
would be confusing? Or even just "parallelism" or nr_parallel? Or any
other ideas?

FWIW I briefly looked at just cleaning this up to remove the global
variable but that's a bigger time investment than I can afford here I
think. (The local variable in stress() would still need a better name
anyway).

Thanks for the review BTW!

