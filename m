Return-Path: <linux-kernel+bounces-567024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E584A68003
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 23:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1985D188BB6E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 22:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1027207E02;
	Tue, 18 Mar 2025 22:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qWAnBfxN"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36541EA7C5
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 22:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742338220; cv=none; b=L77zBhBRu9XkmejsnWM3MGrUZRPTOankpp1jWjDv8oimQWOgbodsXMf0l6aOlYmeCcx7QLuIn5tY5c0B2PoEQa+evgWRTt16P32vt8dexjmOp7EyjhAAQ4HWjG0cqDnyDBcZrMw8fVbSMWU6oPx0md3pdAlNZ527rWToDUyPUvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742338220; c=relaxed/simple;
	bh=t05P+UvnJFKt96CE9S6UNe7VOsGULdWQKn4hVSCkeqQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ewFD38X02t1eeD6igZakPXjOySa2mtb1RwGMwdrrlXSfLB5x0YxTnwGO+wmZ0PmNfqsUPQbLouGXNKd44s+tV3Mod6McWg+M9SF9i1bw543xjK/RXVIIaQ+K6J631coAUlrnzaBZ4aiH4Oi44GW9hlm5HDd/YJxHrUq23OwLsQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qWAnBfxN; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742338213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CkQ5JZfhoermBvvSORxd4/LcFNL2Jzgu0RHumIh68Ng=;
	b=qWAnBfxN8XpMPHDUuJUY8Spvi712B+ljqpHIT+WJgCt2J/C4Ed3J2/ygKnmQQi+3IHwKWE
	NUmTqPGaLOD6MziV42HzLMVtLe+dlerHUkNcOCp0cmat3X8seVvNKB0HediUB0JYPOh9+L
	0EVoimPQ2/XpICHB9r7ngLWG8FvAJsQ=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH] fork: Remove unnecessary size argument when calling
 strscpy()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <05250cea-4738-4bfa-a669-a81a64d3e82e@lucifer.local>
Date: Tue, 18 Mar 2025 23:50:03 +0100
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Christian Brauner <brauner@kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Wei Yang <richard.weiyang@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Miaohe Lin <linmiaohe@huawei.com>,
 Al Viro <viro@zeniv.linux.org.uk>,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <A0877360-6B98-48F3-9A6C-398AAD12F3B5@linux.dev>
References: <20250311110542.495630-1-thorsten.blum@linux.dev>
 <05250cea-4738-4bfa-a669-a81a64d3e82e@lucifer.local>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
X-Migadu-Flow: FLOW_OUT

On 11. Mar 2025, at 12:13, Lorenzo Stoakes wrote:
> On Tue, Mar 11, 2025 at 12:05:39PM +0100, Thorsten Blum wrote:
>> The size parameter is optional and strscpy() automatically determines
>> the length of the destination buffer using sizeof() if the argument is
>> omitted. This makes the explicit sizeof() unnecessary. Remove it to
>> simplify the code.
>> 
>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> 
> Hm not sure about this one, it's not really simplifying anything all too
> much and seems like somewhat useless churn?
> 
> It's pretty clear what's going on here already.

Yes, but explicitly specifying the default value for an optional
parameter is redundant, and omitting it simplifies the code.

Thanks,
Thorsten


