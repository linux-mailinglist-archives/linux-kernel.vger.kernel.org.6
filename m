Return-Path: <linux-kernel+bounces-238182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DC392468C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 19:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 657862857C1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 17:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055301C0056;
	Tue,  2 Jul 2024 17:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="k3oZhDx0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C5B1BE876
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 17:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719941789; cv=none; b=sMoewxbiqRqkSMMiRRVG/a0wzwevs7pAmakMl2o4nTvE3FORPFw+RJvKzPTNB/GEVAYkGPFD38KTcF7iaVVQ98yXl+6qqJmmFfcGmFCm6XPd+R7yxD2Q04uPOVqEuAraGVQnnB2CEPBdhcc+fwuwFyW/5e8bTpmWpyBM0Cw/xq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719941789; c=relaxed/simple;
	bh=65o+r9rQ6vTVCIzE0lvjV6bS9U8lgvQYQqtZ4G1YjFc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Q5y8LGEPQaOZBiTkq6Dg+KtJyt7dDP5gct9AH+LVCiuAWjbl3cEogR77lCsO0TQS+IyMP/B2kr/D5aaDu1lms38ZN+w+vhc4ReBlT5/1p6kZBZP8oNJlSWWeCTKeOdxzkclZp9mYnGRCQPTFP7lImxh4qbnyPZ3/eFQkyRIEYCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=k3oZhDx0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B2C5C4AF07;
	Tue,  2 Jul 2024 17:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1719941788;
	bh=65o+r9rQ6vTVCIzE0lvjV6bS9U8lgvQYQqtZ4G1YjFc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k3oZhDx0pnSiJK+UGXpf9eaXUQACBeaTkmorP8aGEpdT2dxDQ0ow+LA5xyQ2dfMzm
	 nP6J8KwYvhs699+SoC7gJlOhCwAj+7dS0XHBKZa0aiKwtLNNth6kuGB5vUKp9/P5HQ
	 BLtDzT6//k/wJ54lJej84TfKwUEFh4+cdBgFYOlk=
Date: Tue, 2 Jul 2024 10:36:28 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Andy
 Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v3 0/3] x86/mm: LAM fixups and cleanups
Message-Id: <20240702103628.61879ef17b9b01305515c634@linux-foundation.org>
In-Reply-To: <20240702132139.3332013-1-yosryahmed@google.com>
References: <20240702132139.3332013-1-yosryahmed@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  2 Jul 2024 13:21:36 +0000 Yosry Ahmed <yosryahmed@google.com> wrote:

> This series has fixups and cleanups for LAM. Most importantly, patch 1
> fixes a sycnhronization issue that may cause crashes of userspace
> applications. This is a resend of v3, rebased on top of v6.10-rc6.

"Crashes of userspace applications" is bad.  Yet the patchset has been
floating about for four months.

It's unclear (to me) how serious this is.  Can you please explain how
common this is, what the userspace application needs to do to trigger
this, etc?


