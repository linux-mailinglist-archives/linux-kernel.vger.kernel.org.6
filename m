Return-Path: <linux-kernel+bounces-234361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE2691C5A8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 20:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FB5B1F24263
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A4F1CD5A4;
	Fri, 28 Jun 2024 18:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="By2l4T17"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC262DDC0
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 18:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719599222; cv=none; b=BVJxYbB+MuK0BPd0KlileUakPEg9MeNGZDeGBCkWHGc4Hsv2Bk3N+13RZQhy0JwaG3KbEnC8clXC5qGDu9NIKo9yU/v1NslEfvwKFT9sgLG81s+Qyx8LVmzS0CZWepWws1sOpNMNtwV/GNM+55inmT1rgW6pfE62B2A6zQYRmGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719599222; c=relaxed/simple;
	bh=9tninp6H435D2gYhObWndxNCzT5sDUwz4keq4P7yoE4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CZw7inarQHmz+9Xn5bGQo02uQgrio22Ve8r5/+J1tciIuebvMrKee6q0nb3BhnFUmUtzU+SKs/CXpqUCkqsOfNbmFYjo33mDUvlIb+TWwQ5b5Ycn4sLnn45pRtMpOMfE9bP5HqRTUK2VllgSjEX3bmMLJVvqoJjJY4isCfYGXmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=By2l4T17; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1719599220;
	bh=9tninp6H435D2gYhObWndxNCzT5sDUwz4keq4P7yoE4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=By2l4T173q8ozWqpo5UF9Oo/+OdAdvVk7p2WV2yywewSsA5hV9E227cdFX3T/dAoX
	 /m3LpjgVw5dXs64UcJBNkic3U8LIRGmyfg4qJ6H6/g4yqPPsog/fhCdMZZba8E6rbw
	 L5P6CEwXpRZyPzRtq3ZApfvfsBspGyS4r+5zuoxM=
Received: by gentwo.org (Postfix, from userid 1003)
	id 0095C4037C; Fri, 28 Jun 2024 11:26:59 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id F3A5C401D7;
	Fri, 28 Jun 2024 11:26:59 -0700 (PDT)
Date: Fri, 28 Jun 2024 11:26:59 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Catalin Marinas <catalin.marinas@arm.com>
cc: Yang Shi <yang@os.amperecomputing.com>, will@kernel.org, 
    anshuman.khandual@arm.com, david@redhat.com, scott@os.amperecomputing.com, 
    linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [v5 PATCH] arm64: mm: force write fault for atomic RMW
 instructions
In-Reply-To: <Zn7xs6OYZz4dyA8a@arm.com>
Message-ID: <e0779c4c-9a1a-3b10-0c25-6cd3e148b917@gentwo.org>
References: <20240626191830.3819324-1-yang@os.amperecomputing.com> <Zn7q3oL1AE8jdM-g@arm.com> <773c8be7-eb73-010c-acea-1c2fefd65b84@gentwo.org> <Zn7xs6OYZz4dyA8a@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 28 Jun 2024, Catalin Marinas wrote:

> Linux-specific (e.g. madvise()), I agree, but arm64-specific definitely
> not. I'd argue that expecting the atomic_add(0) to only trigger a single
> write fault is arch specific. You can't do this on arm32 or arm64
> pre-LSE (I haven't checked other architectures).

The single write fault is x86 behavior. I am not sure how other 
architectures handle that.

> IIUC, OpenJDK added this feature about two years ago but the arm64
> behaviour hasn't changed in the meantime. So it's not like we broke the
> ABI and forcing user space to update.

The focus of OpenJDK may not be arm64 and they never saw the issue? We 
only know this because we have an insider on staff. AFACIT we get pushback 
from them as well. There are certainly numerous other open 
source applications that behave in a similar way. We just dont know about 
it.

> This patch does feel a bit like working around a non-optimal user choice
> in kernel space. Who knows, madvise() may even be quicker if you do a
> single call for a larger VA vs touching each page.

Looks to me like unexpected surprising behavior on ARM64. madvise is 
rather particular to Linux and its semantics are ever evolving.

>> A lot of these are proprietary.
>
> Are you aware of other (proprietary) software relying on such pattern to
> fault pages in as writeable?

I would not be told about such things by companies I did not work for and 
if I have gotten knowledge about this in some way in the past then I would 
not be allowed to talk about it.


