Return-Path: <linux-kernel+bounces-187895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B22408CDA3E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 20:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 661231F21E45
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 18:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C53380624;
	Thu, 23 May 2024 18:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="J2Nraw2g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744C0171A5;
	Thu, 23 May 2024 18:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716490587; cv=none; b=RrEezAFNo0zO6hVKuNp0GTRbpb6vroDgFPaYsFunMLH4bK7VJdPQry1znkmLz0qe8CNYdct2XzfZ3M6KHay1gGja/2M3s03RB6qWz8hKJoGekWMK9Q8N8EWY+7SgSoszYaZs5wHAX1M7F2yLJ5QyHicQXWX9FuCRfr6S6hZWm+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716490587; c=relaxed/simple;
	bh=GMvp4ZUa5auyWW48u3nDaI5JWsfDmBZz1W/ehEXgqs8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=bcizJ6YmYfZ6Q1p5eqPDeF50Ns4ppP+tBP77Qk0CjlRH+VzbP5xe1ixwvHKUZkywtPDl5o0xp6weVtPwQo+llFkIPzYJKDYwGKcgxv9yqY19qURPWgaDtf9RSwdAo8AA9gzw1xGXxb04AZTMl64tnp42Gw2Q5c+jujBpCJge7A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=J2Nraw2g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD8BC2BD10;
	Thu, 23 May 2024 18:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1716490586;
	bh=GMvp4ZUa5auyWW48u3nDaI5JWsfDmBZz1W/ehEXgqs8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J2Nraw2gaH6n3MhgobyWRQcVgP6jAWECBzB95SjfoVBQJmBDmSNJZDtSOjFJ4JlAt
	 F4W6jfmG+4pH2rfoHIiPlrLeKyO9ulz746Hu/tTOEZGDO51VthSHB81abHQHqj2vKY
	 OI3ineFKsxEaxMgE/dRhUP0goHVQ7NaCG+OwWmGI=
Date: Thu, 23 May 2024 11:56:24 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Yuanyuan Zhong <yzhong@purestorage.com>
Cc: David Hildenbrand <david@redhat.com>, Matthew Wilcox
 <willy@infradead.org>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Mohamed Khalfella
 <mkhalfella@purestorage.com>
Subject: Re: [PATCH] mm: /proc/pid/smaps_rollup: avoid skipping vma after
 getting mmap_lock again
Message-Id: <20240523115624.d068dfb43afc067ed9307cfe@linux-foundation.org>
In-Reply-To: <20240523183531.2535436-1-yzhong@purestorage.com>
References: <20240523183531.2535436-1-yzhong@purestorage.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 May 2024 12:35:31 -0600 Yuanyuan Zhong <yzhong@purestorage.com> wrote:

> After switching smaps_rollup to use VMA iterator, searching for next
> entry is part of the condition expression of the do-while loop. So the
> current VMA needs to be addressed before the continue statement.

Please describe the userspace-visible runtime effects of this bug. 
This aids others in deciding which kernel version(s) need the patch.

Thanks.

