Return-Path: <linux-kernel+bounces-238677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDFF924DB9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 04:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1B1CB25E54
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 02:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638FC1426C;
	Wed,  3 Jul 2024 02:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Yfj4eJYc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D2A1799F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 02:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719972824; cv=none; b=lSGdsOAIRbFHC5KfutMDhWvHsSJfkNZNFYtv3NTX8MnkZbbSbQGQfw6rCOMxcarBimzkqUBAPBIPIUEoN/v8/T4zFnj/hhMiMezXsgj9RTFvrF3uD679JNUSTOl9XlMsuDUL+J/QSO6hAqnmG20PxtzkRBKOFYeBVNr4g7w3tVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719972824; c=relaxed/simple;
	bh=0B0KJjCjfdjRJT2RpzY5cxrGHmC5KY/2taoV0OESIwo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=dBhoOs4oyOfzzya0J17v21YLVwz3lU78EHqHQPxSa2XPc8NRTxV81IpbEnTQ8b3a8fTKIN80Bo3iPW6MzfvuE1bsCCUyvrUIM9j9JVz5VafNoooEdetMRYSGzjAyVZBGZwNQDLq8k1xEiogLmdU5GLb3RNDQDU9cDnCbBwDbeps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Yfj4eJYc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D49F5C116B1;
	Wed,  3 Jul 2024 02:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1719972824;
	bh=0B0KJjCjfdjRJT2RpzY5cxrGHmC5KY/2taoV0OESIwo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Yfj4eJYcf3KuGPNGsqBNp1OHxXefeNQqns/2MujG3QWLJ40q/ROXkwA8vLBD3zHm/
	 r0BjjfmJpELcv+SeCgNDEYKhPpD2xvPPP/r03A8FUGuGCUGT5/PKWrTP2Uj7AarXuQ
	 C0Xjv0KUEgbq6zFdE2M1Yb8lYYqTP7J8/gCz/NBI=
Date: Tue, 2 Jul 2024 19:13:43 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Hugh Dickins <hughd@google.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, Nhat Pham
 <nphamcs@gmail.com>, Yang Shi <shy828301@gmail.com>, Zi Yan
 <ziy@nvidia.com>, Barry Song <baohua@kernel.org>, Kefeng Wang
 <wangkefeng.wang@huawei.com>, David Hildenbrand <david@redhat.com>, Matthew
 Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH hotfix] mm: fix crashes from deferred split racing folio
 migration
Message-Id: <20240702191343.c3f0c0a8725bed7047f4926d@linux-foundation.org>
In-Reply-To: <ec3a5d94-1985-f66d-1aa8-3783fe498f5a@google.com>
References: <29c83d1a-11ca-b6c9-f92e-6ccb322af510@google.com>
	<da6bad97-18b8-4cd0-9dcc-b60fb20b7a84@linux.alibaba.com>
	<ec3a5d94-1985-f66d-1aa8-3783fe498f5a@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Jul 2024 09:15:54 -0700 (PDT) Hugh Dickins <hughd@google.com> wrote:

> > 
> > Anyway, I think this patch can still fix some possible races. Feel free to
> > add:
> > Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> 
> Thanks, but I certainly don't want this to go into the tree if it's
> still flawed as you suggest.

I queued it for testing but I shall not send it unsrteam until we have
sorted these things out.

