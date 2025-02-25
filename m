Return-Path: <linux-kernel+bounces-530842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC00A43932
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B8193A5C93
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4202C266F17;
	Tue, 25 Feb 2025 09:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTWVf5vI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17FB262D03
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740474731; cv=none; b=lEn274rwOM5W1+vvS4xCK+odAWBywjH6f4b9cqoaIvrNgkcxZzdxqx4g0K8wVNVDpp5QT5mRBt6MeuEOBBeis67m2xxSJyI9R6fX33gIBVnJCFxwo2tg78yuEMBfXjy6XMYfTOQg0WLlSYJHPMh0aJ4+lk9dYp7hoT1Z1/gXEGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740474731; c=relaxed/simple;
	bh=S5EX/5L//5qymarzJKFar1n+dLhhvHH+iEov2Smk9WA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yt2/S22dta0RUuvGDJrabMYEfkttsy5Lh2JAUwa3aTn3+Zf3m7QUI7Ia74uOrPrRFRLVeKV5mWhNg4NpZEzHeQWbhZH13fKk3s5U41sOWaevr8rwEMCmN3J+qbtQ4spLzRRjVZsWdlMMYKTR2EYfyoH4ySGXy36eUmHEiSbM2gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTWVf5vI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76397C4CEDD;
	Tue, 25 Feb 2025 09:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740474731;
	bh=S5EX/5L//5qymarzJKFar1n+dLhhvHH+iEov2Smk9WA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KTWVf5vIbEbfCfDXu6joOEyS6F4MZ2ETDqZFqHzMZq5Tql9rM1FB8YOOjd7RbjOCs
	 dSZ5rLa5oxJVKxZ2fshnm6w8/vUNBT7jVrMqE1w0FP2QcWjKJc2XhijMFht4We4m+j
	 ynhM2RLgMVL69oAycfkBdFdDST9VtIFqS/n74lpWqSUHHBS0kBJEKpH5bvP1WpKXLV
	 Co4Srtw962oT0vqW6Z+RaMewboUbhh6nj9MzkY0ZPqi6njUUMRvilPQPQVlosIPIkI
	 z4nlbHZF+i7N/WPzOZdq8RwHzJkTuB1W+RpivhhKxXuFbLc3zFMtlRwtrNEWRxTkjl
	 JDyVexJp0QUJg==
Date: Tue, 25 Feb 2025 10:12:01 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rseq: update kernel fields in lockstep with
 CONFIG_DEBUG_RSEQ
Message-ID: <Z72JYW0y7fUBSWll@gmail.com>
References: <20250221191401.464648-1-mjeanson@efficios.com>
 <Z7nQzOQT_-9-Rbr5@gmail.com>
 <974359d5-43f3-483a-89cf-79e9b4965785@efficios.com>
 <Z7nbYcdRKXspX8o2@gmail.com>
 <26dba55c-eb09-4e9e-8460-8adbf75e32cd@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26dba55c-eb09-4e9e-8460-8adbf75e32cd@efficios.com>


* Michael Jeanson <mjeanson@efficios.com> wrote:

> >> I always find it odd that the "source" argument comes first and 
> >> the "destination" argument comes second in all put_user() APIs, 
> >> compared to memcpy, WRITE_ONCE() and all assignments (e.g. 
> >> operator "=" LHS vs RHS). Choosing a different argument order 
> >> therefore made sense with a naming different from "*put_user", but 
> >> not so much if we use a derived naming.
> > 
> > Yeah, put_user()'s oddity is a random historic idiosyncrasy that we 
> > want to preserve in derived naming to reduce the potential for 
> > confusion.
> 
> Would that be ok?
> 
>   rseq_unsafe_put_user(t, value, field, error_label)

Yeah, I think so.

Thanks,

	Ingo

