Return-Path: <linux-kernel+bounces-340102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7D9986E8E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 983181C21D81
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB0918E37F;
	Thu, 26 Sep 2024 08:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="TQao0zjC"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC7713D638
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 08:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727338280; cv=none; b=F5cSYiivlK9Aso9plQ++YW+/Qx9RAGdiqujFpLS6I93wgJwMb6j07TeZ+eX9yhKo9daCZV1qTp0R0TqrDTGlWJtV0Lhyhw8Y2Bi4tJytNvgsOFbGugJgZse6wCyLFvAhqEiqix9ktgBSVmOV+tHw19zHc9Kx5+RhTCLh/nBbRTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727338280; c=relaxed/simple;
	bh=hNRjodGMIo2ULKwCm2+RFayT6FJ3ydzrCNNeJ64bsiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogOUtJX5n3V7K/GIflSUgAEMIM1dDcZDqZVTwWCIsDYUgNyVkTnlMMp2BVqPp2Q9lFk7bCnRVfPXVs4Hs+ubaGfSqKr94+3Kc1stBi5KDGNeG3GoyQFcIp1bVjfani5ciGZMnILicGjUKI5qjhuzPFo2NeCpq6XF9gLbDkD6HuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=TQao0zjC; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7109440E0198;
	Thu, 26 Sep 2024 08:11:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id iyVoZPgFk6TZ; Thu, 26 Sep 2024 08:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1727338260; bh=rIg5EiDJ26tXF5BW97EQrQV+8wmtqcCoguANj3MCivs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TQao0zjCnfAN4doie3IhTqh5jBojdWKXf/edL9RIqoljMqx3Of2BMi/Ww4xe6F5a/
	 dUm5iFWjeIkg3rRQaT+/yOKQccc+KqIuXddqCF7IqQfj1KMwRVVH2oItsFJvvhNcm9
	 yvWP5pnOaORv9ohdfDRy3Rd/MIspU97RE4mIxJwSaPSZxDEdESp8vxmuA02PO/XDA4
	 mstR0hFe9KnD2WOu1LnkvzVQ7BsO/qrLjaLFEsm6zBkOJGP4uUa8kCfCuqSl+KT3s5
	 rRlLD2+CHAlxFaKNQ1WaI3963VkJO4Qg+8BQtHeWnXqQonEeYvZFOO+I9WMbTt4DFD
	 rCmr8npVwrJmoqR7AiDgc+FO8xKD+acy2KcJUTpqKzzx7nKoxvhyYxo3TQiG5FgXpl
	 qjWcKD1pOGz7NZkjnYhiSuh3keIXE2M/Zj600xwdnArpAGcoBAU2/tsQcerDnSpkIj
	 4vVWqptLJG6zeZBYrxkFNcG39IP8EDUTwEaJwRCSIt7OPra1XeBn2JDawCtM0iy6PW
	 GAR0IUYnF9iatS4rBujlIoQ0523Sd+eFFcDBjXtbhoHFZ3JbDhkcSEe3n5ryWSlcIK
	 u22YcPZFpnxVCtsZOzjobHAy096aPTEt1memf5X5XpVz6xT3S0bjtR4qtZgKKTSPgf
	 wk8Yqoiwi7KaAez/mo/JjlbQ=
Received: from nazgul.tnic (dynamic-176-003-045-131.176.3.pool.telefonica.de [176.3.45.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 10A4140E0191;
	Thu, 26 Sep 2024 08:10:52 +0000 (UTC)
Date: Thu, 26 Sep 2024 10:10:44 +0200
From: Borislav Petkov <bp@alien8.de>
To: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH] x86,cpu: add X86_FEATURE_INVLPGB flag
Message-ID: <20240926081044.GAZvUXBEUlSZt6dD-I@fat_crate.local>
References: <20240924180013.388c1699@imladris.surriel.com>
 <24A7815F-E21F-45D3-9784-109B5932B41C@alien8.de>
 <628c91f76feaf6e29522c8fef5d9351ba6104183.camel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <628c91f76feaf6e29522c8fef5d9351ba6104183.camel@surriel.com>

On Wed, Sep 25, 2024 at 12:46:39PM -0400, Rik van Riel wrote:
> I would like to avoid TLB flush IPIs for the top N (maybe 8 or 16?)
> TLB flushing processes in the system.  We can figure out what these
> processes are by keeping a score of TLB flushes * number of CPUs over
> some time period.

Documentation/arch/x86/cpuinfo.rst

What does that have to do with showing the flag in /proc/cpuinfo?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

