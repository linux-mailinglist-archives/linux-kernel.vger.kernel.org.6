Return-Path: <linux-kernel+bounces-532448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49224A44DE9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A82C5440249
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 20:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3821320F068;
	Tue, 25 Feb 2025 20:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="iv4idPuu"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFF420E717
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 20:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740515917; cv=none; b=cUx/IkwKnsb+zdXFKJnmFA6NijbOMc9A9UYdatrLRFu0xFsHrWkXUJsIyQ+yE6S6VBJZf8W9odog4U8iC4uyHtDR41F0/Iwi/kki+GcSOmmT/7sbcyZHLUrWY5jqLycFAkm3dsyLHV3q//T3jHhq6m6vOxK+HXYP5GzP3lum0kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740515917; c=relaxed/simple;
	bh=nSDIK464W7Yjh5t5WydffmzEb5GtCFdJ4Cv3sFjbqH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8yAoizs+6+YS7g6J8lVTdpLvZ8WKWkPT4TDh8UKfdOyWp70zS1Gqu2UeuYuZsBzQUZToNOK13jA9CwSqpAEeAhlkcY+hBhNx2QM6f+0d8WIFeaQepnQwVnxnFEAYiaa+fLkj5dgQMizfGmWasivfFsyevuklMkrjbEw6LBgoCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=iv4idPuu; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7969A40E01B2;
	Tue, 25 Feb 2025 20:38:31 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id cLjTFn-YZINJ; Tue, 25 Feb 2025 20:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740515906; bh=JE/28cJIPE3suQAhPeMgvXel2rBo3VtHBeMh/HrDwCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iv4idPuuw2BU17uXnLAHXFg3oBXtQHF3qLmx+xC8H3qs2WFX2O7BnWSNDKY97W5Bs
	 C+fVpuW9oohuZnvZMVmiEzgfMXcCBfGPgJmjNJ4YkZpRbZ7Z3lIdFH0j4NlAZVXtaO
	 tiVzUq/73aTLUsvWQOtOAZh9ZIoYwoZLZQ+6BZDbxYHjGlsjynV1Zv211eQGe+AV+6
	 H/VBUnxuYzI0mVeK2Ernnmppj8GvKZOwEAn4Uj9+ukIcxDFf/lNMQPXvo0BdFlFrdm
	 qTW8nzLVJmL/FYJ9ZCYGOUspkZPvTNTYLADBw+IrTS8NCVDhlotVNChV0HHE3ht+k0
	 7hauTOsmzdFh8UbR/Km/AHWbe2jhMmC6V+yKR9q5QV4u7Hp7UWBQIFhxiN6/QpAXNu
	 J5YLyJWyVoxtLxE/wMAMLxZoa9cL+PSIkjy9y8C7viDYzIVJjkbN6XuOYsfPj9h5LB
	 Rv36PZOY/Dqpsj9LUvFwAKjmI0Dijuzlag26aL7HdKcwzXvjVUZvLALC9w3B/MNq15
	 Pch4dMiwVg3l9fEF+eAnEvZ28I9uyQTDKBzOz5vOowczbJ6bK1zVbVfhrJ9xG5f4m3
	 1WdDsfTxXikpw97kA1DVJOazbZfdMFnf3y5SIxI99OQjKG9TL2CbL8AN7X/XAhLtmA
	 xqAJg7m4ofSL6eLQsE2IFsWg=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E01D840E01AE;
	Tue, 25 Feb 2025 20:38:08 +0000 (UTC)
Date: Tue, 25 Feb 2025 21:38:03 +0100
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
Message-ID: <20250225203803.GGZ74qK1oZWk8u69O4@fat_crate.local>
References: <20250223194943.3518952-1-riel@surriel.com>
 <20250223194943.3518952-7-riel@surriel.com>
 <20250224132711.GHZ7xzr0vdhva3-TvK@fat_crate.local>
 <7c2baf33265444089ab780848de29a1336a9a4cc.camel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7c2baf33265444089ab780848de29a1336a9a4cc.camel@surriel.com>

On Tue, Feb 25, 2025 at 02:17:20PM -0500, Rik van Riel wrote:
> Who do we need to ask to confirm that reading?

Lemme figure it out.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

