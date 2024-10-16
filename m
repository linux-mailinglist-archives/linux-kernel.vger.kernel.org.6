Return-Path: <linux-kernel+bounces-367558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CDB9A03D0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8556B22993
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA49B1CBA16;
	Wed, 16 Oct 2024 08:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Fyevhnyy"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986981AF0AE
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 08:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729066207; cv=none; b=Sn2B4J5VnCVMX0PJv61wD+p56sqw/Wbr6f/QW+M4Q2USCx0fMcvtj2PNoR/kK73xmdiVMhBLZ/2Ysi/sNkAAq86rR8uCsm1BYa9C/F89HWuctRQJgxkbqqFJ8N5zGUvz41ruGek1hphw6ZlfY4Thy1ItNvvz8NrsMrEd45uwRtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729066207; c=relaxed/simple;
	bh=oFA81IxRSSHNkq12A/pML4OVdCAZovFgCpu8BNi6XFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCLYNfMlG6Han6N75Xiet2d26Qh+yNgDe6LgOllFAAkyOK5NjwV/3e48UVGkPVauGrPYi8g4QOk9xfWnly5Ggf5Ee2XNi/EBUYHy6wRVo56zKDZFoEuyGJZGfAguvzAU5Vgg9SA4i8e8K36uyo8sHlAfLnlGU3Tv9SEja1b4ajo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Fyevhnyy; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mK4b4AlE950gM5FjMV716a/AzZMPsu/yGbdrW2xHaLE=; b=FyevhnyyC/sxxwDy3NqIRpJlPp
	ox3RUGP6It8MRZbjhXoqlpQLFueLUIfb2wzY6ZMYinCBExXABqgiHoD4Ad7fQxVoVqTzV0Cf4UWXR
	IWL6BYagtlRUMkODBHnkyrMYVCf8ZcghhhggVHkdLfpP8uAFVER9k4idINoyGv5/rQ8LIhsTTgHCS
	red+OEwOqm71ViLwW4v9ed/6eMWfT44oa4BxTnvv3toUDolgEJ80QLG2zV24gn399tJbMVDs8cUNy
	NJB0iJgK92gOajA1+GJFEXsTsh6vDV+uozgXd9P2z++FHOQ4Epqe0nZ5z0jBgSBsh0D9Ge1+f8E9a
	PPwNe6pQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t0z6S-00000006kxM-28N4;
	Wed, 16 Oct 2024 08:09:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A8EAD300777; Wed, 16 Oct 2024 10:09:55 +0200 (CEST)
Date: Wed, 16 Oct 2024 10:09:55 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: lizhe.67@bytedance.com
Cc: mingo@redhat.com, will@kernel.org, longman@redhat.com,
	boqun.feng@gmail.com, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC 0/2] rwsem: introduce upgrade_read interface
Message-ID: <20241016080955.GR16066@noisy.programming.kicks-ass.net>
References: <20241016043600.35139-1-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016043600.35139-1-lizhe.67@bytedance.com>

On Wed, Oct 16, 2024 at 12:35:58PM +0800, lizhe.67@bytedance.com wrote:
> From: Li Zhe <lizhe.67@bytedance.com>
> 
> In the current kernel rwsem implementation, there is an interface to
> downgrade write lock to read lock, but there is no interface to upgrade
> a read lock to write lock. This means that in order to acquire write
> lock while holding read lock, we have to release the read lock first and
> then acquire the write lock, which will introduce some troubles in
> concurrent programming. This patch set provides the 'upgrade_read' interface
> to solve this problem. This interface can change a read lock to a write
> lock.

upgrade-read is fundamentally prone to deadlocks. Imagine two concurrent
invocations, each waiting for all readers to go away before proceeding
to upgrade to a writer.

Any solution to fixing that will end up being semantically similar to
dropping the read lock and acquiring a write lock -- there will not be a
single continuous critical section.

As such, this interface makes no sense.

