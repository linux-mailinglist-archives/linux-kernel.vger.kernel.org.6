Return-Path: <linux-kernel+bounces-304184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9875F961B88
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 03:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DAB21F2464D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 01:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F834437A;
	Wed, 28 Aug 2024 01:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="iFZyJm+M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B090433AD
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 01:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724808867; cv=none; b=bbvJ6/kIKlTjDtLEEfMtboM0depBixp3Da7xuxUHfWrFbBa3k8Wxtg6kVagNaxJGyDPgY9kDefng7h/aHco4TqabdJr0t8u/5Ce+FJ+/K7Ebi8Hv4eWRVOzqEwZry5ryvPO5pEJvot/Ya+y2dAdAOV0L4K85PfHGveB8n0nr+cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724808867; c=relaxed/simple;
	bh=BDOchBEPwCm4nRJp+qzecBD7wbCgXJHWMiR2NU9J0sE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=JepEcm95k2Z7KuEiG6VBRyiahX9OeM6JGWJif4yMpiqrnWuyZqaRuIevz3p6TRO3cf6Sd+KtP7GFhHIHoMWVsNOqAEHr7D8lO5JmTWxoqCzbkMHMpEFbijtVQeuNIsgNg+oLwuBMctl1j2hCiJHJ9wEVfPXUtd+/1FvT8j0/RaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=iFZyJm+M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB6B5C32782;
	Wed, 28 Aug 2024 01:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1724808866;
	bh=BDOchBEPwCm4nRJp+qzecBD7wbCgXJHWMiR2NU9J0sE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iFZyJm+MGGnDAtBXXop/1gYzGwfBU092IN/xpT9HyQdftBlIgAYPN5JbODzpL/939
	 9mQ7aHRbQeIQX6mwpGLcDEO+Pva0vjvYw+yYuUMXCku4IWQzRlNeeqLjzMKEIB+wzC
	 I7bV1uZ7riPTeZT/EVG3O5KcUWb1gHlFynDQ+0Dc=
Date: Tue, 27 Aug 2024 18:34:26 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org,
 maple-tree@lists.infradead.org
Subject: Re: [PATCH 1/2] maple_tree: arange64 node is not a leaf node
Message-Id: <20240827183426.ac84f442e18b66a8ce6bfb90@linux-foundation.org>
In-Reply-To: <20240826012422.29935-1-richard.weiyang@gmail.com>
References: <20240826012422.29935-1-richard.weiyang@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Aug 2024 01:24:21 +0000 Wei Yang <richard.weiyang@gmail.com> wrote:

> mt_dump_arange64() only applies to an entry whose type is
> maple_arange_64, in which mte_is_leaf() must return false.
> 
> Since mte_is_leaf() here is always false, we can remove this condition
> check.
> 

These are pretty simple so I'll say lack-of-a-nack-is-an-ack ;)

Please do cc linux-mm on maple-tree changes.

