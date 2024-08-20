Return-Path: <linux-kernel+bounces-293256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6F9957C96
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 07:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C70B9284E2C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 05:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACAE5C8EF;
	Tue, 20 Aug 2024 05:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PMIn2RWX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1523142A9D;
	Tue, 20 Aug 2024 05:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724130350; cv=none; b=Bzru+b5GKMjbkGH2tumgA7yYZZOnozsbukhBDyagx0GYLwtHhj87qnqOduduKxjShqfZL9G/ZhIUnOLpHiyKhthfDmpGilaTyQRRzH1dZVF7pYAvEDJn1gzrK6Xy6bkshOxOQMUiHQde/vU4wsUZ2ugOB5tC3hsqGvNFXL9SKpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724130350; c=relaxed/simple;
	bh=Qk4x8r7jRJD6hkIYmtG/mztRf8YMFcS8K5ZNtoCas2c=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=klQVOnc1unbF2Dd5tf9KbX3jTH1Vy41mZCchrdezW7w2wcovR4TysXKjUZnNCsHN8oyLaIO8gfZg4V/6kgbe/CadYUPS8FlyAq7ZbmoldeSTJRPQ+Z1tp0326NzCw/fDFlqnEgySLqIlOgb/RT7NG6eIwWYxyPGiSyKgNGy7tqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PMIn2RWX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17699C4AF0B;
	Tue, 20 Aug 2024 05:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1724130349;
	bh=Qk4x8r7jRJD6hkIYmtG/mztRf8YMFcS8K5ZNtoCas2c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PMIn2RWXlS1k3tsabpC+vfCMInsVGJyUNEOITWfgeANg2b7JoeXNBin+vZ7/T9rCM
	 j6GyRIQqo1/LOxEGVvwKs8CamVyaFDb2UZScOYpHZEkCzl5hqRZV96GmtZ6a+hXdO+
	 CiZwvFdf7iyfBbbaauyGUnjjQjF17cZ/5ed3/QCU=
Date: Mon, 19 Aug 2024 22:05:48 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kairui Song <ryncsn@gmail.com>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, Chris Li
 <chrisl@kernel.org>, linux-mm <linux-mm@kvack.org>, open list
 <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, Linux
 Regressions <regressions@lists.linux.dev>, Barry Song <21cnbao@gmail.com>,
 "Huang, Ying" <ying.huang@intel.com>, Hugh Dickins <hughd@google.com>,
 Kalesh Singh <kaleshsingh@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: Re: gcc-8: mm/swapfile.c:863:40: error: array subscript 1 is above
 array bounds of 'struct list_head[1]' [-Werror=array-bounds]
Message-Id: <20240819220548.d8f1ea5cf504cfd8feb5780e@linux-foundation.org>
In-Reply-To: <CAMgjq7Bz0DY+rY0XgCoH7-Q=uHLdo3omi8kUr4ePDweNyofsbQ@mail.gmail.com>
References: <CA+G9fYuFDon59=Nw6WCdgp0FanZ1oE3dCkoq71EK0Bxe6Jhe_g@mail.gmail.com>
	<CA+G9fYtd1Hw9YLpceUAwwC+UytVQVXOET4gmGT9jiCgHa+WexQ@mail.gmail.com>
	<CAMgjq7Bz0DY+rY0XgCoH7-Q=uHLdo3omi8kUr4ePDweNyofsbQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Aug 2024 19:44:25 +0800 Kairui Song <ryncsn@gmail.com> wrote:

> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -836,7 +836,7 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int o
>  		goto done;
>  
>  	/* Order 0 stealing from higher order */
> -	for (int o = 1; o < PMD_ORDER; o++) {
> +	for (int o = 1; o < SWAP_NR_ORDERS; o++) {
>  		/*
>  		 * Clusters here have at least one usable slots and can't fail order 0
>  		 * allocation, but reclaim may drop si->lock and race with another user.

OK, I got that landed in the right place, but...

The definition of `o' within the for statement isn't typical kernel
style - I'm surprised we didn't get a warning for this - maybe things
have changed when I wasn't looking.

Also, this code makes no attempt to honor our "The preferred limit on
the length of a single line is 80 columns" objective.  There's just no
reason for comment blocks to violate this.

So Chris, please attend to such things when preparing v6, which I
assume is in the works.


