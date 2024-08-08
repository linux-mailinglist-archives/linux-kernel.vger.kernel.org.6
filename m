Return-Path: <linux-kernel+bounces-280212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC4994C73A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 01:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85A061F278AA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 23:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B1A15F3EF;
	Thu,  8 Aug 2024 23:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gWQ6+4U1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D2615F316
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 23:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723158747; cv=none; b=nTqde9s3nHT7lTy88kKYQbNjC9WQilYj2+53gGZ5jouAJG4OntRN122E2z1eO5yZkfVPnxpKn7i2PefYb43kX6FOIQ6ssjYvHMLDan6rbqGc46ugLz5hzZdLZ7iPMjfQIT6MlQ3NyHgZY8NPbFyFnTxP4pRm1Yayds6RW1KCGk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723158747; c=relaxed/simple;
	bh=it6abTQw50lOHn49RYhNzNC/cnpBiq5slSInLJ9wpLA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=AV/cwALksIQvCbWGq+EqIUzFQ73qZBrRyl+cM+pKlRuYYRxsyRMfbhyyuZoJ/NAnWqdClYfyzgbbot/Ls9xWIR52sK/jw8jMYavQPiZ8AUlqr7N+FJW3spn3lFXcDr5VlFpV1BtRoMfbginL1au8v7W8eSKkWT/27zQEf3zY3CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gWQ6+4U1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C021C32782;
	Thu,  8 Aug 2024 23:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1723158747;
	bh=it6abTQw50lOHn49RYhNzNC/cnpBiq5slSInLJ9wpLA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gWQ6+4U1Z6FUlqgkyb/R1ur8C3tIkQs4277z8fxEvx0mra4yF99QXc+GMfeePiGwz
	 VPSUmIh/HyuCECBwNwUJYuxlQHgLk68MR3pYBu/kx5e14ZrP4I6Oxl/yUMzR6Snd6e
	 PxEpiq5qk1nkXI7kXygpduM+NDCNIfOYFWVZbFwM=
Date: Thu, 8 Aug 2024 16:12:26 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, oliver.sang@intel.com,
 torvalds@linux-foundation.org, jeffxu@google.com, Michael Ellerman
 <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 0/6] mm: Optimize mseal checks
Message-Id: <20240808161226.b853642c0ecf530b5cef2ecc@linux-foundation.org>
In-Reply-To: <20240807211309.2729719-1-pedro.falcato@gmail.com>
References: <20240807211309.2729719-1-pedro.falcato@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Aug 2024 22:13:03 +0100 Pedro Falcato <pedro.falcato@gmail.com> wrote:

> This series also depends on (and will eventually very slightly conflict with)
> the powerpc series that removes arch_unmap[2].

That's awkward.  Please describe the dependency?

