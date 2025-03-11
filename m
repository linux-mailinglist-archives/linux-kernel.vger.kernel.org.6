Return-Path: <linux-kernel+bounces-556953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3ABA5D152
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 22:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59847189E23F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 21:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A33260A29;
	Tue, 11 Mar 2025 21:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VG9an/u6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E84F1386DA
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 21:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741727009; cv=none; b=V8MQEU4cK9z0RaLRamDs/NpYT2RVFpWooefHtiEpspgDIghOlASZuVPS+qHpmz9iTpujv9zL9/KgHXJYEUQ2wycv8BdpcMHkBeBwCDmfZQWSJmJZRezCgwpat8TBFa5lD/WBGoK/BJ1cyvj0lgm+auMr9JYin4HFhgzB6XHUTzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741727009; c=relaxed/simple;
	bh=s9tR6nZeVVojY6KvUwD1l+egtg49JohWo9DDH5W6I2E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aJUzOpxn16ARS7icq3dru1U4/K3ikSmIu+LMUU0+AwJumqYhRW5u+xi5uCKjhPNY7VURSLSVTGmkVVZqiTj7vTqoPXomoh19Klce6F9GQFG6rCL5c2aqa3W+sRVA9ZLHx1Ug1R5veIIMMeKh0LFxiy909hIMGJl/YD/givXjCXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VG9an/u6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC0CC4CEE9;
	Tue, 11 Mar 2025 21:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741727008;
	bh=s9tR6nZeVVojY6KvUwD1l+egtg49JohWo9DDH5W6I2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VG9an/u6VOWdNVuBbI8PXIYU60rcz47713Xas41H21yYPzyLBVmegAaQyN99aRFGv
	 tdDHR03l6gtg5xax/NYkSxu3/W3Ri8ZjeR9eXREpYBRurQ3GZ0zJcys7Yy6mG2cLSv
	 ma7amIPz4d8KuxbyTgl9Uq8W3uNxirHGq7ilqpD3AVM3sOyYJMLwpVL2jiO9yxhL1r
	 HqqVJsR4cFzhpjE/fAqVxn7VKHWBiUHABVOr2dLcDWvxfCqd80rCvf0ldranITSwHQ
	 qOA9Uu78CYQWJSaT36ssAwAdxBLvyU/k4AhG6gXigFncvASgy/QP42MJgL1WHL4VpZ
	 iiQsRTNzCtjyQ==
From: SeongJae Park <sj@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <howlett@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/9] mm/madvise: batch tlb flushes for MADV_DONTNEED and MADV_FREE
Date: Tue, 11 Mar 2025 14:03:26 -0700
Message-Id: <20250311210326.85632-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <0f90d56e-5960-4478-803e-1054696c0cde@lucifer.local>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 11 Mar 2025 12:49:38 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> The below commit message talks about tlb bits, but you spend a lot of this
> series refactoring mm/madvise.c.
> 
> Can we just separate out the two into separate series please?
> 
> I am doing the same kind of thing with mremap() at the moment, but sent the
> refactor _first_ before the work that builds upon it :)
> 
> Your refactoring is great, so I want to be able to take that (and Andrew's
> objections obviously don't apply there), and then we can address tlb stuff
> separately and in a more focused way.

Thank you for the nice suggestion and I agree.  I will separate those in the
next spin.


Thanks,
SJ

[...]

