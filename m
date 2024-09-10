Return-Path: <linux-kernel+bounces-323828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 682979743ED
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 22:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B1D4286F64
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 20:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E52D1A4F10;
	Tue, 10 Sep 2024 20:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="V3C7t2Qf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810B31386DF
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 20:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725999236; cv=none; b=qnI1Pggxkq4euLy2m+/6Q8AxSyGjmbNMky/KOGajTolqnFtLHMVg7JFMiDAJvPYHaMlO6nVjiRRvjZaUbCAPqNI3xhJnKxVMLBYHVZRKy/OgHQdFUj4r2uxZDpDztJFmfY51c8UTjlqu7+pgsTx7e7+hmhLu9W1jo55lckUYgtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725999236; c=relaxed/simple;
	bh=RVb1qy8SWy2cizWVjiqhWziVC2adHgDmVd9oAe/UJGQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gT6WCeGhwi8tHXo9pZ29w9cJYPl40UvfWu+VVtTdk94cqFyMHX9Zv4wVzsiLuNNyFTirwVohxqWWpJHZ3nIInAID7v+uaamXFLmpTHMA1rg3At+424kphoeoElEC7d6WAcdkMzU8roEZsr8TnT8QQo71nfmecRPRT3zMgYr6Xo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=V3C7t2Qf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34A9C4CEC3;
	Tue, 10 Sep 2024 20:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1725999236;
	bh=RVb1qy8SWy2cizWVjiqhWziVC2adHgDmVd9oAe/UJGQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V3C7t2QfbdI1X8VlP1ziBglWkGBwLOR8xKbC/iV21r+u2AWwXcm0cX/zrL+GjiI6U
	 lloGefrXqP8dr7B7cqJJV6iK4TZW/BZ1IG3Ip9wr3ogS5a5diOHjVRjSIiXLoBvhWb
	 tqy96oiQJL+hbtPSzLKvs42mcNZ+frS28sxjCrgk=
Date: Tue, 10 Sep 2024 13:13:55 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, David Hildenbrand <david@redhat.com>, Ryan Roberts
 <ryan.roberts@arm.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] mm: Drop unused set_pte_safe()
Message-Id: <20240910131355.8f56f86045c745cee7a97f85@linux-foundation.org>
In-Reply-To: <20240910101026.428808-1-anshuman.khandual@arm.com>
References: <20240910101026.428808-1-anshuman.khandual@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Sep 2024 15:40:26 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:

> All set_pte_safe() usage have been dropped after the commit eccd906484d1
> ("x86/mm: Do not use set_{pud, pmd}_safe() when splitting a large page")
> This just drops now unused helper set_pte_safe().
> 
> Besides this macro was buggy due to doing direct dereferencing of the pte,
> and if it were to be kept, it should have been updated to use a single call
> to ptep_get().
> 

arch/x86/mm/init_64.c: In function 'set_pte_init':
arch/x86/mm/init_64.c:83:17: error: implicit declaration of function 'set_pte_safe'; did you mean 'set_pmd_safe'? [-Werror=implicit-function-declaration]
   83 |                 set_##type1##_safe(arg1, arg2);                 \
      |                 ^~~~
arch/x86/mm/init_64.c:91:1: note: in expansion of macro 'DEFINE_ENTRY'
   91 | DEFINE_ENTRY(pte, pte, init)
      | ^~~~~~~~~~~~


