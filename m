Return-Path: <linux-kernel+bounces-368876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 231999A15F2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 00:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 422041C21DED
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 22:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834D01D4607;
	Wed, 16 Oct 2024 22:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NBJo9iqO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26C418732A
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 22:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729119517; cv=none; b=ZV8DnSiHCoIq40A6lKR8t60m+DFlGbWxip2wWWDYfQ/dVM9S3fjE0EbNJKLWw5lWQiDPInCNziAMZNJv8FNwI8AUsDQCqlgMC9HNCtV3jhNsS87g90OJe3+4TvHm63Z/niBNWUfWTXOMllDPAKnzdmM62VXPEfz6mtZNOsEABF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729119517; c=relaxed/simple;
	bh=WxpeomFz0HUJdVJvDFuCdztLPHBer1ykf2mdrBwFIeU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FgXEvf81DCMD3Dh+8qvNaea/HOIZdREiQ8TVFTHQdtYrkSO20J61iTPyI6dnTqBqwD9r1c8rHvnUFOrxTUSVnkcwI0tSlT84Q4ZIoFCen6CXiiCIZfi4x1FJDAnmXM6fiYDMhQFuPRfomLkp0LJPEHqgdOvOmBh6StVMnxL06S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NBJo9iqO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA37BC4CEC5;
	Wed, 16 Oct 2024 22:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1729119516;
	bh=WxpeomFz0HUJdVJvDFuCdztLPHBer1ykf2mdrBwFIeU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NBJo9iqOm7aQsGBBAOtEr5l3mvTDeahUHmmwWYpr73lnCVUvta/2VnrT4NsYmAdFw
	 SlBk9RiZHdNTx69vdT+rgt/3U333DfFkuUzdzrSaMEYo9CVyeo0cktoZwKX091is/8
	 acAemgIGFUkXGbF4XOjPAtoMBPzxtRZStnb3NVvs=
Date: Wed, 16 Oct 2024 15:58:35 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Barry Song <21cnbao@gmail.com>
Cc: linux-mm@kvack.org, david@redhat.com, fengbaopeng@honor.com,
 gaoxu2@honor.com, hailong.liu@oppo.com, kaleshsingh@google.com,
 linux-kernel@vger.kernel.org, lokeshgidra@google.com, mhocko@suse.com,
 minchan@kernel.org, ngeoffray@google.com, shli@fb.com, surenb@google.com,
 v-songbaohua@oppo.com, yipengxiang@honor.com, yuzhao@google.com, Gao Xu
 <gaoxu2@hihonor.com>
Subject: Re: [PATCH v2] mm: mglru: provide a separate list for lazyfree anon
 folios
Message-Id: <20241016155835.8fadc58d913d9df14099514b@linux-foundation.org>
In-Reply-To: <20241016033030.36990-1-21cnbao@gmail.com>
References: <20241016033030.36990-1-21cnbao@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Oct 2024 16:30:30 +1300 Barry Song <21cnbao@gmail.com> wrote:

> To address this, this patch proposes maintaining a separate list
> for lazyfree anon folios while keeping them classified under the
> "file" LRU type to minimize code changes.

Thanks.  I'll await input from other MGLRU developers before adding
this for testing.

