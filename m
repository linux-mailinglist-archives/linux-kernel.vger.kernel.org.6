Return-Path: <linux-kernel+bounces-354372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DEF993CBD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 04:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 050972833BA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 02:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783EA1E517;
	Tue,  8 Oct 2024 02:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VnHp71OO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D976D469D
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 02:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728353735; cv=none; b=J3cRQCbc1EGi4LRfE9yNuzZqbABRj6e0UGbtlZR61ID9lSKoTwdpRXkZ+zu948cm+1xAAOqEgR122iT8h/zfXXvXWYrf11R3evuxgSP/KENASsDHbIPzo/QE1hNwJYI2KUN9RobyjxRuonj1Ea1ycJjQNHS+uGpSTHoU6qpPMhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728353735; c=relaxed/simple;
	bh=1b0owmMzQyEWGF+y2BFQQnNQoCtj0MIH/rdTpjh7gOs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=AgtPiFCGRbTcCw1ocAZ6FiG0+PWQesDnxXB18hsY3BWjimUiEzVVHzU6kTKkRwt+Z1395L8oAw30rqFPY8Pr+a6iDu09CmXgshoX9VY2xtog4giEDjIaDCfuhzXE6KA+UkKa7tg7KxuUikreC7pZVlgzCSTY9JMwZ54DrgjT9OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VnHp71OO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC93C4CEC6;
	Tue,  8 Oct 2024 02:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1728353735;
	bh=1b0owmMzQyEWGF+y2BFQQnNQoCtj0MIH/rdTpjh7gOs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VnHp71OOB067JG7d/fmPHYeUJRis3eMVKaLYVmMEjYo7GD625bLIh4uCnV98wUeeq
	 dqaksTcQ9OWhYNH8B3QLdR3mVyw6rU1RSoI/LOp1dLixanVlNn/bniuVSf18q2YM7q
	 UW91pAtLy7VfGwZI9Y3iNmrQwYvcgE7rIa/mgZYs=
Date: Mon, 7 Oct 2024 19:15:34 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jingxiang Zeng <jingxiangzeng.cas@gmail.com>
Cc: linux-mm@kvack.org, kasong@tencent.com, linuszeng@tencent.com,
 linux-kernel@vger.kernel.org, tjmercier@google.com, weixugc@google.com,
 yuzhao@google.com, chrisl@kernel.org
Subject: Re: [RESEND][PATCH v4] mm/vmscan: wake up flushers conditionally to
 avoid cgroup  OOM
Message-Id: <20241007191534.ceb663de5ac7ee3695a162a2@linux-foundation.org>
In-Reply-To: <20241008015635.2782751-1-jingxiangzeng.cas@gmail.com>
References: <Jingxiang Zeng <linuszeng@tencent.com>
	<20241008015635.2782751-1-jingxiangzeng.cas@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  8 Oct 2024 09:56:35 +0800 Jingxiang Zeng <jingxiangzeng.cas@gmail.com> wrote:

> From: Jingxiang Zeng <linuszeng@tencent.com>
> 
> Commit 14aa8b2d5c2e ("mm/mglru: don't sync disk for each aging cycle")
> removed the opportunity to wake up flushers during the MGLRU page
> reclamation process can lead to an increased likelihood of triggering OOM
> when encountering many dirty pages during reclamation on MGLRU.
> 
> This leads to premature OOM if there are too many dirty pages in cgroup:
> 
> ...
> 
> The flusher wake up was removed to decrease SSD wearing, but if we are
> seeing all dirty folios at the tail of an LRU, not waking up the flusher
> could lead to thrashing easily.  So wake it up when a mem cgroups is about
> to OOM due to dirty caches.
> 

Thanks for persisting.

This patch has a somewhat difficult past and not a lot of review. 
I'll await feedback from other MGLRU developers before proceeding.


