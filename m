Return-Path: <linux-kernel+bounces-516726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 127FEA37646
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 18:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FC483A674C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 17:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F1C19CCFC;
	Sun, 16 Feb 2025 17:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="uJa+qLc3"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80562D299;
	Sun, 16 Feb 2025 17:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739726802; cv=none; b=IBW5EcFYP1AMXtzgtIVXAeQlHudG9kdSY05ipTBUZebFXvZNjB6B/+B9ce3NGlAa0+45INHiH6s4vVrVy0aWEUzUWZDe2+7QgvVOyuOpcRWUdaXJ8DVzn1BZtEe5AR4APB8yTKF3uwxmw6AOrMoYu7mNXVY/eMkluIMOyLQMhx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739726802; c=relaxed/simple;
	bh=uEt464/h2m3GqGiapkNB2JJvR+MVEX5A4+rFNpOFjck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/ZfEbzjeVzuOSXXXpVuFmCEOEA3DY5q+kBWL+RvEs3Sd5CXsy/Q8+qzipoHsrF+9eYMrMtHezy0T4kYbSZ25yxmG/F6z4vg1HjfuftAzuZ6lXWShhKY0TsMmjIkfMPkyEYnGe9s3tx6t+rw3LyEIyKDJW9Rqo9Dp6+M/hRtqYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=uJa+qLc3; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jmWOQZCXMxbv82cQngQGVJfiQD14sQuWaCtfDjrw/2o=; b=uJa+qLc35duMilGvoz3lM8gxlz
	g58gA8YPlRXZeeTTYAsTYrpRA9AM/0SvrUkuG+CougKPe/CA0Xq992zlq6BtHUrddDQmrD1p/cpbD
	eqEkW2Ur1utltygrmi7C6C92IhkuCaLJiQP68tr+3ht1JDNQYZ4+iOrKe0i0yYYZpZHNnaxh+PuNB
	/66GluGIJvXetwCix84Yxjr/y1HumtQVM25ys6cTq+AmutSifVfNuA3QfffD8i6JXv6yq3iCP5eQU
	GOiJ7sYCNQ7e5ICthYnDBDCqzq9MCojerhG0lymQCZbeEgk5My/HRxfiDFlHuNF45j6s2TZEosyFR
	lORUZ+mw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tjiPd-0000000G1Vi-23bL;
	Sun, 16 Feb 2025 17:26:37 +0000
Date: Sun, 16 Feb 2025 17:26:37 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Magnus Lindholm <linmag7@gmail.com>
Cc: richard.henderson@linaro.org, mattst88@gmail.com,
	glaubitz@physik.fu-berlin.de, ink@unseen.parts, kees@kernel.org,
	arnd@arndb.de, linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org
Subject: Re: [PATCH 1/1] alpha: Fix pte_swp_exclusive on alpha
Message-ID: <20250216172637.GI1977892@ZenIV>
References: <20250216170748.2258-1-linmag7@gmail.com>
 <20250216170748.2258-2-linmag7@gmail.com>
 <20250216171741.GG1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250216171741.GG1977892@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Feb 16, 2025 at 05:17:41PM +0000, Al Viro wrote:
> On Sun, Feb 16, 2025 at 06:04:53PM +0100, Magnus Lindholm wrote:
> > Function pte_swp_exclusive() checks if _PAGE_SWP_EXCLUSIVE bit is set in
> > PTE but returns lower 32-bits only. Shift bits right by 32 to return upper
> > 32-bits of PTE which contain the _PAGE_SWP_EXCLUSIVE bit. On alpha this is
> > bit 39 but on most other architectures this bit already resides somewhere
> > in the first 32-bits and hence a shift is not necessary on those archs.
> 
> Just make it return bool and be done with that - all users are either
> if (pte_swp_exclusive(...)) or if (!pte_swp_exclusive(...)) or assignments
> to bool variable.
> 
> No need to shift anything - compiler probably will figure out that
> 	if ((int)((x & (1UL<<39)>>32)))

Sorry,

	if ((int)(((x & (1UL<<39))>>32))

> is equivalent to
> 	if (x & (1UL<<39))
> but why bother with such convolutions in the first place?
> 
> Seriously, just make it
> 
> bool pte_swp_exclusive(pte_t pte)
> {
> 	return pte_val(pte) & _PAGE_SWP_EXCLUSIVE;
> }
> 
> and that's it - conversion from arithmetical types to bool will do the right thing.
> 

