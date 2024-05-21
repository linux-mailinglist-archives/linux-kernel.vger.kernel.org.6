Return-Path: <linux-kernel+bounces-185496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E21F78CB590
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 23:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 984B61F21D52
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 21:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40E614A095;
	Tue, 21 May 2024 21:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KNC+K6U5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC4A149E1A
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 21:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716328765; cv=none; b=lWEc9or+VgGUwHdoDllZcoSo6wHBAG/HqLpBxuUNb5VxjYGoNpsrF4CmCosGFcWsrLDeBvwkN0DHdyPkBsweCJPl9khzCH4twI2VXjRqKAmmSgnMqkMFGar9WqW714Krngdb3FBpq1h15F4Bw46chb8ghR+Weuy+Gh/Z+rpAs2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716328765; c=relaxed/simple;
	bh=jYzKAwZ5nz/rB+46JPirqKoyoahcRiK4mcc+JHEhr5U=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=bih7eFull7LQ+p4Ma5lduWOtxle5xqPz86UAOXmXMrvKGqrvQnzsCqvbSfvm5tqd/0ZdQjdPwZgF/K0VCPEsnTH8TuTwkC/SkqMCbSrXjqJt/hyXhZdD+dGQjVqvv0dRHYITUUT6IQEIGMPzY9bPMvoqL2cD+E3P2uaK9/uTC7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KNC+K6U5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E537FC2BD11;
	Tue, 21 May 2024 21:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1716328764;
	bh=jYzKAwZ5nz/rB+46JPirqKoyoahcRiK4mcc+JHEhr5U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KNC+K6U5i80DJzFI9bEAXiZPclalC6Fc+ZRwnv124pN0o+Xc5D8UuAdQrekaeXKWn
	 dj0QGlmA20giL/Tv/SJTMklfwSgLUFKAKz7Irut/sH1c4pkcy6rcxAPDcDE8GYM2MK
	 bxVjwkYlCU4AYRfN79cHYYcLg82EEDDrg0DDQmmM=
Date: Tue, 21 May 2024 14:59:23 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Barry Song <21cnbao@gmail.com>
Cc: linux-mm@kvack.org, baolin.wang@linux.alibaba.com, chrisl@kernel.org,
 david@redhat.com, hanchuanhua@oppo.com, hannes@cmpxchg.org,
 hughd@google.com, kasong@tencent.com, linux-kernel@vger.kernel.org,
 ryan.roberts@arm.com, surenb@google.com, v-songbaohua@oppo.com,
 willy@infradead.org, xiang@kernel.org, ying.huang@intel.com,
 yosryahmed@google.com, yuzhao@google.com, ziy@nvidia.com
Subject: Re: [PATCH v4 0/6] large folios swap-in: handle refault cases first
Message-Id: <20240521145923.ae30d52cec3e9d9f00969cf7@linux-foundation.org>
In-Reply-To: <CAGsJ_4zX1r8aQRuAbnTc0O5sPxDs11yhScz2T2t9uJ84GEjOoA@mail.gmail.com>
References: <20240508224040.190469-1-21cnbao@gmail.com>
	<CAGsJ_4zX1r8aQRuAbnTc0O5sPxDs11yhScz2T2t9uJ84GEjOoA@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 May 2024 09:21:38 +1200 Barry Song <21cnbao@gmail.com> wrote:

> This patchset missed the merge window, but I've tried and found that it still
> applies cleanly to today's mm-unstable. Would you like me to resend it or just
> proceed with using this v4 version?

It's in my post merge window backlog pile.  I'll let you know when I
get to it ;)

