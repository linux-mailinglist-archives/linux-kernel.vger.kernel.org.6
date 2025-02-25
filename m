Return-Path: <linux-kernel+bounces-532483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C7BA44E50
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22DF63A371F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577BA2135D7;
	Tue, 25 Feb 2025 21:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="JMgL7+5o"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0450F212B3B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 21:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740517411; cv=none; b=Ps8/V54ICRjkjQg3P6ZSjVYjs5oOJywBpk3GaEApE5nWzs5TWt0uiQmYct5Ry2PLtya0GqheNXchvZ80wGCx+HvTEIq32g9xZIrKxskwqVlbdTKUs8M+pH1I/dIjC/Ptmkq5x6yRkH+T938fkUurv5phdeXie4Mu7KQFBaQAkAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740517411; c=relaxed/simple;
	bh=u7u8qa3o0CRq8+28X/DVzlbTKCg681qHjy2TBF7RW20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plqeOTO8rQi1jefP0v3Uh0eMlT7/o0HtUSifho5uoxS88BjlSzMsrq6JIFO0jQBRl2OQ5Z01sRzrPwS7LMkYX1Oa3vL6w43ZEkAzsw9jtT5xcsCrOhIpYjctPHo74YkT4kf7wJU6BnuUC8MJ4jUa5czb9QjCiQs2nxRJqLH71oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=JMgL7+5o; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 61A9740E01AD;
	Tue, 25 Feb 2025 21:03:27 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id BufiWpZA3Kh9; Tue, 25 Feb 2025 21:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740517403; bh=RW7EXBWZRnw4HvjQHbP/KC89pF9FScloDAfWFmC/zP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JMgL7+5owRQsYhrS0LpvJMpyfC1ZGd7umIldHeF3ju5fAXdx+NiAuVKw26Y1nqU5k
	 sX6fjSfyVLfb2e4eFNn+ZylYorMx8obUuLowfA7Gv1iBhkEITwR/99+Dex3mg7P56N
	 h+dKN5FPzI8zEnRzwd3c+r+XaGnDCx8RWxBunj5MQ4Fv/xahUYhgwg+lTEzV30Za9+
	 j6pqPlVyNDR9Vi2EFrXKPMBeh6iHGdJmVxxBItvN/wDUfKUwanxn8sWchflr3fsS+4
	 rZUs9RIVWpwXeBkHqTjpnEiReaZCOU1KwWp65xAxxAadE8ruvxcOz/XHyUWm/r6Iix
	 QbXt/SyxIO7ljexJWKj5JNN9flHnr8Wz7sJ/OcM6rs6YG5g2h9IPRK1FXDSRQFYLQ1
	 sQAjHoPA31vnFiDcLERAyuTI3ptlcqkn6pljqIus6sdHVB5Dt3whzlhY7dTJJvQUra
	 ytSKxQ/UeifIyn+jP0F5lNDu/MYDr/H6if/g59mhjTvADLt79ik+eQtK6pzy4xijBV
	 pKBPaliQXxmMaaLCGkL6QXwJ0X7r79/J7zsaHiV0Uxx3lq/brm7jxQQWCYY2ntKmRN
	 +ffK6Plz+fAc7kCZvkYDq4FGLH/rhREEokk8jZyVasNqpLx4i+KTqn0ToBl9OxvaGp
	 hE7KLWzQcFdSPHlppk3ykVfo=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5E38840E01A0;
	Tue, 25 Feb 2025 21:03:06 +0000 (UTC)
Date: Tue, 25 Feb 2025 22:03:00 +0100
From: Borislav Petkov <bp@alien8.de>
To: Rik van Riel <riel@surriel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
	dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, jackmanb@google.com,
	jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com,
	Manali.Shukla@amd.com, mingo@kernel.org
Subject: Re: [PATCH v13 06/14] x86/mm: use broadcast TLB flushing for page
 reclaim TLB flushing
Message-ID: <20250225210300.GHZ74wBP2ogmM5P5lP@fat_crate.local>
References: <20250223194943.3518952-1-riel@surriel.com>
 <20250223194943.3518952-7-riel@surriel.com>
 <20250224132711.GHZ7xzr0vdhva3-TvK@fat_crate.local>
 <7c2baf33265444089ab780848de29a1336a9a4cc.camel@surriel.com>
 <20250225203803.GGZ74qK1oZWk8u69O4@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250225203803.GGZ74qK1oZWk8u69O4@fat_crate.local>

On Tue, Feb 25, 2025 at 09:38:03PM +0100, Borislav Petkov wrote:
> On Tue, Feb 25, 2025 at 02:17:20PM -0500, Rik van Riel wrote:
> > Who do we need to ask to confirm that reading?
> 
> Lemme figure it out.

Confirmed - that really is the case.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

