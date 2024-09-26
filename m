Return-Path: <linux-kernel+bounces-340676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C97987683
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E1DA28358E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 15:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B31214BF8B;
	Thu, 26 Sep 2024 15:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7QjOKYt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFA4487A5
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 15:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727364596; cv=none; b=Te/RFC9DuH/twIrdKAqhQKlKO51KmkFEJ7G6uyIMnzB9HfHy3+yS4fyH/pvh0vCQuaKMo0kxMeRu2EDuWirAyqzK2xsFC/dxWuOHaBiAlKciWKBd8ML/P1gi5cUJM4i2TOp3HCfwoNapL6y+sMolzISbH/jV7zyzblEvjbr4jgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727364596; c=relaxed/simple;
	bh=XN4kTQnjeTr7JkGq/4E9+X423Rw9UCB/k0Kg7etf+Q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSsyIPjrS7bgWV0fZ10Iv+ZAMHGj8n3JEhpskOFGBX6/Ne89q/Dqw6ez1+L8OOdh6M62rc6NaXdnfICUZrK4EdRaA08R2wiQXJbL8qmzRfJupBi/W4tagDddvyJxZCHvlBxB2ISRRnHGCYgSXNzRUg23zBM0hKxHjmF1rBjZZcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7QjOKYt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8CBCC4CEC5;
	Thu, 26 Sep 2024 15:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727364596;
	bh=XN4kTQnjeTr7JkGq/4E9+X423Rw9UCB/k0Kg7etf+Q8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F7QjOKYtE9MlPOR1SFJo72gnJPZ/uzeHmYlF64U7GivAg0QxphTFaxdPM3h9egxpu
	 EYm3ai8O2iuZtQIKtam0loIE7XTbDp/PCSvdD0JYStTni6fjyevEil+HHqFD0PI8Rp
	 2x4gG9w9MycZywWtLNh3zU/vK7Fw2T1x4YUuNkSqMy9Xcf5tL2QNnImoFRJ9yXqTsf
	 iqWySMX0uL0AL6Gejw4h9S2yOgNjgutYckDvI/pyQ4VrAotycc2wx8Jy5wZah2n50G
	 hs3qXO3zdxhwLUvSkao6L4T5rWnSRP9szERW20wTTGtLGy+XApzNZ7b57r375A0NaK
	 fGy2mDvnVP4DA==
Date: Thu, 26 Sep 2024 17:29:53 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v4 3/4] sched/isolation: Consolidate housekeeping
 cpumasks that are always identical
Message-ID: <ZvV98RseDnagMpnh@localhost.localdomain>
References: <20240921190720.106195-1-longman@redhat.com>
 <20240921190720.106195-4-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240921190720.106195-4-longman@redhat.com>

Le Sat, Sep 21, 2024 at 03:07:19PM -0400, Waiman Long a écrit :
> The housekeeping cpumasks are only set by two boot commandline
> parameters: "nohz_full" and "isolcpus". When there is more than one of
> "nohz_full" or "isolcpus", the extra ones must have the same CPU list
> or the setup will fail partially.
> 
> The HK_TYPE_DOMAIN and HK_TYPE_MANAGED_IRQ types are settable by
> "isolcpus" only and their settings can be independent of the other
> types. The other housekeeping types are all set by "nohz_full" or
> "isolcpus=nohz" without a way to set them individually. So they all
> have identical cpumasks.
> 
> There is actually no point in having different cpumasks for these
> "nohz_full" only housekeeping types. Consolidate these types to use the
> same cpumask by aliasing them to the same value. If there is a need to
> set any of them independently in the future, we can break them out to
> their own cpumasks again.
> 
> With this change, the number of cpumasks in the housekeeping structure
> drops from 9 to 3. Other than that, there should be no other functional
> change.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Acked-by: Frederic Weisbecker <frederic@kernel.org>

