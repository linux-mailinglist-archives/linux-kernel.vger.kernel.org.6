Return-Path: <linux-kernel+bounces-240319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A98926C00
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 00:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A2171F22B92
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 22:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520DF1946AA;
	Wed,  3 Jul 2024 22:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cuEcSdoP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865C91822FB
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 22:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720047090; cv=none; b=E22o4GwZ86Ow+TNGgvVu8hv50XTASbGfgsmHwZOwLk2zwdoQ5S3ZP5X9aGsE0aai3NkXOHaIc0NSc8UHth4z73etbS14FhU30/mUiYwYQ/wZ2AU5Q59oUFXwI8UwVTlZfIb1uCSzt8QYmKVGmLlnHAqVTcCjC3tOucqDEYILM94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720047090; c=relaxed/simple;
	bh=JcYC3cr6vUgfJZu/Iylq/Hgfp2XgmBJ2e5k3/8B7J4w=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mKhMAG8SLZsZ4NtET0mTNCG/1nRNi1XLGbVl8LWqHd2Uyd/eCUu5AK5sfjp+iL/I9CODHOkaa7AcQv4CsbIezDJBZ9HthoTuml3mm1DdVAOVIerqSpV4H/9ivX/2EYacRuOXZIbO9KkRX9OLEUJhselGuKEsD5YHPxaATtbexjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cuEcSdoP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDFC8C2BD10;
	Wed,  3 Jul 2024 22:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1720047090;
	bh=JcYC3cr6vUgfJZu/Iylq/Hgfp2XgmBJ2e5k3/8B7J4w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cuEcSdoPTEDGYSNoinlAWp6KzmwVHbbS6AiMSpN9iVzAGNXwGHoYTFBhLSBEDsu53
	 UWTxnXGz8aA19+f8C15w53VzVxIrPbRYVNC7b24rayeqfE+agetTdAkpbOIv/IwZFm
	 0QcKH5MFX7AwK1TDhzebDBd0ZpCJj3QBP6L9NMr4=
Date: Wed, 3 Jul 2024 15:51:29 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, kent.overstreet@linux.dev,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/1] sched.h: always_inline alloc_tag_{save|restore} to
 fix modpost warnings
Message-Id: <20240703155129.cbd023c14dee61e5727bb750@linux-foundation.org>
In-Reply-To: <20240703221520.4108464-1-surenb@google.com>
References: <20240703221520.4108464-1-surenb@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  3 Jul 2024 15:15:20 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> Mark alloc_tag_{save|restore} as always_inline to fix the following
> modpost warnings:
> 
> WARNING: modpost: vmlinux: section mismatch in reference: alloc_tag_save+0x1c (section: .text.unlikely) -> initcall_level_names (section: .init.data)
> WARNING: modpost: vmlinux: section mismatch in reference: alloc_tag_restore+0x3c (section: .text.unlikely) -> initcall_level_names (section: .init.data)

Well, is it only about fixing warnings?  If the warning is correct then
this might be fixing kernel crashes.

Do you know where these references are coming from?

I'm curious about the .text.unlikely.  Makes me wonder if we should
also have .init.unlikely for unlikely() calls which happen from __init
code.  Maybe we already handle that.

> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202407032306.gi9nZsBi-lkp@intel.com/
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Cc: Kent Overstreet <kent.overstreet@linux.dev>

Fixes: 22d407b164ff ("lib: add allocation tagging support for memory allocation profiling")
Cc: stable

yes?



