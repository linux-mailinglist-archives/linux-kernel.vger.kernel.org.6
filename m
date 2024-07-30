Return-Path: <linux-kernel+bounces-268238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E22942211
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 23:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C03FA285B04
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 21:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F24F18C914;
	Tue, 30 Jul 2024 21:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IFclImUc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5036014B06A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 21:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722374128; cv=none; b=c+8HCIn0pVIbt04LQ0VrrAEBf3zd0iCZ+3C4Px7Tax7ECoeVLuWcmKO6uAsMXqtE31E8dl7LNX8N4+3UboZwn1sb0ixYkODUE5jc7UHQt2BqdjHVZD0jmvVwAR/OAknrtGLFrM7BilbHoEzQGxim/X1oqxNpksIPuhby2KZ5AXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722374128; c=relaxed/simple;
	bh=JF9WcIZIviOi8WrpLmtOh2Lzs2aF2Vl/O26GQ64Y/98=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=f62QJGBBoV+0uD7nriOLCjDfTj8L2ulis/t+wneCYcGPToIGWbwRWMZ1RUdYF4lzuW7sVnnSuut0qbN502sjXfZ2dqJLCW0XMO95cb9x25lb/wVZIldi1D3+STNSjMM8gpFk41vcmyh6aNUMg1/z9DglMabH+XqtgTdise+gKtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IFclImUc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B793C32782;
	Tue, 30 Jul 2024 21:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1722374127;
	bh=JF9WcIZIviOi8WrpLmtOh2Lzs2aF2Vl/O26GQ64Y/98=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IFclImUcY1ntyPlWx/JCWFOXcS1a9B1alIoc99VjJZJ0cItOpYMzfNtGOk6l3sWYo
	 2S3J1nRdiOd2+fSMaaUCHbyHronK66FPTueaR+3kcMvFMIR8roK8BFl9PiurMMLLIy
	 JacVDEwp0Ruo5TCOm8CAX19LjPmXBxYAI1Bn7Pk8=
Date: Tue, 30 Jul 2024 14:15:26 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: urezki@gmail.com, hch@infradead.org, vbabka@suse.cz, mhocko@suse.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/4] mm: vrealloc: consider spare memory for __GFP_ZERO
Message-Id: <20240730141526.ef8f665b3ccc65d3b41eed22@linux-foundation.org>
In-Reply-To: <20240730185049.6244-3-dakr@kernel.org>
References: <20240730185049.6244-1-dakr@kernel.org>
	<20240730185049.6244-3-dakr@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jul 2024 20:49:42 +0200 Danilo Krummrich <dakr@kernel.org> wrote:

> Zero spare memory when shrinking a buffer with __GFP_ZERO.

Again, why?

