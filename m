Return-Path: <linux-kernel+bounces-197485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E198D6B42
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 23:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1160F1C257FB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 21:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E1178C75;
	Fri, 31 May 2024 21:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSTxV43/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C5A78276
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 21:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717189684; cv=none; b=mWTi3Tq4kDiZDVvdk0URCTOJfXtmCOBFAYpQiliW4o3H+ORJc5bSMv9jXPRruxZm6R/GtURj5g2wQ28iCnGjTSutPwZ+Bp3RZMII54sC+ZzGoAOLiSspB13kjXL9LMnvcFHuSeBZ/Bhyow/fo/Z7J3IEQM+nuRV8MAb8VFijzJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717189684; c=relaxed/simple;
	bh=jySXDNeokm7iuVZtdpS/Y3fW/yp7AlExakgw7S88qFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pf7fX/JGK4ikHlUcMkHX/JoqNQ1gNcHETwdCEg69boZEoHnKzgXwhx7KwNOG3tjwM9UjvD5jsM2yEEC9e+u3gbzhOkjV+FADA5gcwtOVR0d9Be6G6COKiQnT4ZM2TcHCGz7dL5QaykVk9kFWnfLHAt57B16fyij+WW3A8MMeyaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSTxV43/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A842C116B1;
	Fri, 31 May 2024 21:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717189684;
	bh=jySXDNeokm7iuVZtdpS/Y3fW/yp7AlExakgw7S88qFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dSTxV43/YOLNlF2y0mUfKZEvaZR/2abCx4X/cQkXJj9XD0EBWcRe5qKvs8ppPLEMM
	 uP9ON6V4912/GEjROWHr7zx9Uy/O2axyvfKUWIDG8Zda/Nu8OeebL1XEZ2LMhsnVIf
	 FB3Tuyafus+oV6vh0wH2C4s4X3GWgCZV4Uz6O7hftIh9uKRZa8TjKFtROzOP2n1zxr
	 hMsHRGHWdn/j4mY/ajzcaZqabMo2ciyoStD6ela21qbbt2t+3YnnMTAK/Bx9DS5Dkf
	 JPcow4TYE2ykHBbl1HoRwRu3hshds+CMcKZ0MAmE0XIK33QeyaHLQjCQ2jshIKevP0
	 ej6oAZ2t6PW4g==
Date: Fri, 31 May 2024 14:08:03 -0700
From: Kees Cook <kees@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev,
	pasha.tatashin@soleen.com, vbabka@suse.cz, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] mm: fix xyz_noprof functions calling profiled
 functions
Message-ID: <202405311407.E21104C0@keescook>
References: <20240531205350.3973009-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531205350.3973009-1-surenb@google.com>

On Fri, May 31, 2024 at 01:53:50PM -0700, Suren Baghdasaryan wrote:
> Grepping /proc/allocinfo for "noprof" reveals several xyz_noprof functions,
> which means internally they are calling profiled functions. This should
> never happen as such calls move allocation charge from a higher level
> location where it should be accounted for into these lower level helpers.
> Fix this by replacing profiled function calls with noprof ones.
> 
> Fixes: b951aaff5035 ("mm: enable page allocation tagging")
> Fixes: e26d8769da6d ("mempool: hook up to memory allocation profiling")
> Fixes: 88ae5fb755b0 ("mm: vmalloc: enable memory allocation profiling")
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

