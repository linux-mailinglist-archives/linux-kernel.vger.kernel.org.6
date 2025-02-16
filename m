Return-Path: <linux-kernel+bounces-516721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31089A3763C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 18:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB80A188A8B8
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 17:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEB719ABCE;
	Sun, 16 Feb 2025 17:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="p6JYsi/6"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70488D299;
	Sun, 16 Feb 2025 17:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739726269; cv=none; b=dZaZHHIi2IGz0PMqMtx5fHU2yGUO1kC2fCKFpI+jR42W4UxDRu7KaT3MDQkhuhlHKyEmjTaNnfo6F8m/BMgGFQxs2S/c0HKCWm8rnCTmlKIXpuoMfzW+2TWn5S2rCq+xE2MHmn0jTwsEqFz3725elZFhdLQo9LP4wcsD/FSQ97Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739726269; c=relaxed/simple;
	bh=BkW/Xv1C+7usLgfP0fhuP0m5sbeddh8VuMdNQwbr6DE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YXerVEPORKO+lE0NvzcgcVN6qdSctuTb7Ke/2jIioJ23cZiaAtjGA2k4UtdfhOWIq8cPttVA7++vbRhcUGkKGAXO9DGSDzQYRtFRsojv+G/L+vqdynJP1bhYW3jvHGNRuPOBk8yjVSQlkJwjRHmjd5092zdF+vd6vBPc1sg+Tao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=p6JYsi/6; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wXH/8QjywIZdmabdwuKmdc66Lo6uBpDaxFgaJu5AQj0=; b=p6JYsi/6Y6WiQz1HIWrQtimQx3
	HLxFk875DZpIxqiNScHeoFjdjwL5sRRWSkh5PRrfeonLu2LzA2W7UalWWyUy4gCmMqQSQLR8pB+zG
	Dbn28xB9tS/FSIfJoPbc9x/GD07lsMQt/nysRP0tUvkE5FoMQvQ4hKJ1zwsd+D5/OyCq6VeL6VYfu
	WCIH1C+U62j+7YPBKC7Ij7+8J0Y6Yl8rnaI9RGZhDRqeQr8WYwYYUARloP0U8TauxieayTckB/TP0
	86mYQG9mdmAYk4nqYRGHgBIzc4IU7wqaAw5Iic6yrjeffEVgxbb1ZXxNjoez7obiLN3iTOJ1w2cNY
	PfzpLKGQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tjiGz-0000000G1Aa-3zQk;
	Sun, 16 Feb 2025 17:17:42 +0000
Date: Sun, 16 Feb 2025 17:17:41 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Magnus Lindholm <linmag7@gmail.com>
Cc: richard.henderson@linaro.org, mattst88@gmail.com,
	glaubitz@physik.fu-berlin.de, ink@unseen.parts, kees@kernel.org,
	arnd@arndb.de, linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org
Subject: Re: [PATCH 1/1] alpha: Fix pte_swp_exclusive on alpha
Message-ID: <20250216171741.GG1977892@ZenIV>
References: <20250216170748.2258-1-linmag7@gmail.com>
 <20250216170748.2258-2-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250216170748.2258-2-linmag7@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Feb 16, 2025 at 06:04:53PM +0100, Magnus Lindholm wrote:
> Function pte_swp_exclusive() checks if _PAGE_SWP_EXCLUSIVE bit is set in
> PTE but returns lower 32-bits only. Shift bits right by 32 to return upper
> 32-bits of PTE which contain the _PAGE_SWP_EXCLUSIVE bit. On alpha this is
> bit 39 but on most other architectures this bit already resides somewhere
> in the first 32-bits and hence a shift is not necessary on those archs.

Just make it return bool and be done with that - all users are either
if (pte_swp_exclusive(...)) or if (!pte_swp_exclusive(...)) or assignments
to bool variable.

No need to shift anything - compiler probably will figure out that
	if ((int)((x & (1UL<<39)>>32)))
is equivalent to
	if (x & (1UL<<39))
but why bother with such convolutions in the first place?

Seriously, just make it

bool pte_swp_exclusive(pte_t pte)
{
	return pte_val(pte) & _PAGE_SWP_EXCLUSIVE;
}

and that's it - conversion from arithmetical types to bool will do the right thing.

