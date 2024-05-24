Return-Path: <linux-kernel+bounces-188397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A2D8CE181
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 09:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 365B8B212CF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 07:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6918E82C7D;
	Fri, 24 May 2024 07:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="MFCDufiR"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8DE3307B
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 07:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716535881; cv=none; b=V6GNul8UHd0nqDoY0E/8mPaJCVer1s2gbqfpOvqOGocIDPEaRw2IsvAhb/8Dg12bqoIJQjvGl6RBuODP2VS2R10d4+DhlvSFgCMTJJqQxhLhIJCX5SqdILd8AEK8eA2ZIDkcOMuQg0zRSyElxKDONedlxsuw7BfEHOkKOj77nQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716535881; c=relaxed/simple;
	bh=9aZfG+NzEiFZAsHD0h4w2IWim6Z6lzrXt347upX65NQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AEi1U3wWfzkeJ5FDwR7WuNazQZc8slmy+Fki2UCzfFM9Ejr7/4zxxH8HiMcg8/q0V508iRMmlnXKW2oZGET7/y0cDg1HocXQVacJujvtUXvxmzQ3fm+9DBMNbXiADfIjJ5Kwa91IsfWzUSDpbeEEApWD4sJ975SG4kAcIEJxig8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=MFCDufiR; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1716535874;
	bh=9aZfG+NzEiFZAsHD0h4w2IWim6Z6lzrXt347upX65NQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=MFCDufiRQVNPhjxqSk1BjmddKX1HfxsLZ5ZUFULQ9FM80/EwH+kEo33Rgh7H14zav
	 Rksh2PPvGO23CTdN5CexXlCadOet6yLf/EC4FxB4oqpqQywAFmXdCwKhY1NfPi1tHV
	 PH3jmzFqdZ/sgt/DgNfxVYaQK0wpNe9Mfl0mUa+x7hUFhtdwMjUI3hbkKUo6W2fbbP
	 fUia07Lun7uUscPJVq3lPwqA/WtJKF3AgLfGSZ0XNcEEhq064oyNR9JtXVqiYXBt8u
	 ZJ66m6kPGSLgE25WyWJUoV8WzPENmpiOBYOa3cIQh9jQbp5fZvNpClQ8k6VDLQIscL
	 sh0w5cnoXAxDA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VlxYG2367z4wcg;
	Fri, 24 May 2024 17:31:14 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Andrew Morton
 <akpm@linux-foundation.org>, Jason Gunthorpe <jgg@nvidia.com>, Peter Xu
 <peterx@redhat.com>, Oscar Salvador <osalvador@suse.de>, Nicholas Piggin
 <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v2 12/20] powerpc/64e: Remove unneeded #ifdef
 CONFIG_PPC_E500
In-Reply-To: <f70e5249b9e6a9a06e6575aa0efbaf8ba93c3659.1715971869.git.christophe.leroy@csgroup.eu>
References: <cover.1715971869.git.christophe.leroy@csgroup.eu>
 <f70e5249b9e6a9a06e6575aa0efbaf8ba93c3659.1715971869.git.christophe.leroy@csgroup.eu>
Date: Fri, 24 May 2024 17:31:13 +1000
Message-ID: <87a5kf4qf2.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> When it is a nohash/64 it can't be anything else than
> CONFIG_PPC_E500 so remove the #ifdef as they are always true.

I have a series doing some similar cleanups, I'll post it. We can decide
whether to merge it before your series or combine them or whatever.

cheers

