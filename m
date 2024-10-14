Return-Path: <linux-kernel+bounces-364833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6A599D9FD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 01:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E45FCB21304
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 23:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CEA1D95B5;
	Mon, 14 Oct 2024 23:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="n7Akqvua"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C70148826;
	Mon, 14 Oct 2024 23:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728947444; cv=none; b=A2DZnNdlUNd1iee7Nl8jjY0pqOpvNsi9dyyUuLhbZGumcQo5nbIh7G1yl7CElogrWyh/+LSRwCyirW+P2GA/qF7IyX71WprLTTGIpqL5hahdOIvMQuqg9HMBAccziPBTOu2cS5FvmSe6PmkMOBGavWA0oM+il5VvRgOwaAT866k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728947444; c=relaxed/simple;
	bh=nELXq9LkxaH66PDsYsLIsBsb0UGCLgFAvWL+tEMs3sY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ISnxyLMvUgsr4BsLqAImamDDKHup5gnTw5rODktM4oqvLQ2k27emRQ9cYatEdM5nSeLSPHKhlvkF9n05eoteGhDKWw3GQ244DVSDBLS/DaEIFEH9d8XNLXkhoCu/mzWdHFHo22Aiprdq8yvsMZDIA78QeKk8Lm1IK3INviCBdv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=n7Akqvua; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 983B5C4CEC3;
	Mon, 14 Oct 2024 23:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1728947444;
	bh=nELXq9LkxaH66PDsYsLIsBsb0UGCLgFAvWL+tEMs3sY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n7AkqvuabY53nqNPOr5maoguhtDBmMR5+mSs4BBl5QJRBA7gr5jihmCgCXuE166nH
	 cJ8HXMhXweJEAsWeN4VLrZL6YflySvsdD394T4teVdpm2Ti1CTPLQO8gxg08KVwcuA
	 JWrZzI3VMohDk0YMnTg2uZdahfGM5ybsizdepTPY=
Date: Mon, 14 Oct 2024 16:10:42 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: andreyknvl@gmail.com, 2023002089@link.tyut.edu.cn, alexs@kernel.org,
 corbet@lwn.net, dvyukov@google.com, elver@google.com, glider@google.com,
 kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, ryabinin.a.a@gmail.com,
 siyanteng@loongson.cn, vincenzo.frascino@arm.com, workflows@vger.kernel.org
Subject: Re: [PATCH RESEND v3 2/3] kasan: migrate copy_user_test to kunit
Message-Id: <20241014161042.885cf17fca7850b5bbf2f8e5@linux-foundation.org>
In-Reply-To: <20241014025701.3096253-3-snovitoll@gmail.com>
References: <CA+fCnZcyrGf5TBdkaG4M+r9ViKDwdCHZg12HUeeoTV3UNZnwBg@mail.gmail.com>
	<20241014025701.3096253-1-snovitoll@gmail.com>
	<20241014025701.3096253-3-snovitoll@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Oct 2024 07:57:00 +0500 Sabyrzhan Tasbolatov <snovitoll@gmail.com> wrote:

> Migrate the copy_user_test to the KUnit framework to verify out-of-bound
> detection via KASAN reports in copy_from_user(), copy_to_user() and
> their static functions.
> 
> This is the last migrated test in kasan_test_module.c, therefore delete
> the file.
> 

x86_64 allmodconfig produces:

vmlinux.o: warning: objtool: strncpy_from_user+0x8a: call to __check_object_size() with UACCESS enabled


