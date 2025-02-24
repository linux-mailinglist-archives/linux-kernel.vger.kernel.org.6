Return-Path: <linux-kernel+bounces-529764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85485A42AAD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4966D189A7CD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279DB266B78;
	Mon, 24 Feb 2025 18:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lR5RGht4"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC63265CC7;
	Mon, 24 Feb 2025 18:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740420239; cv=none; b=eALzd1wTCXDCLNuWRVyfpUmt8SYhO+RcUCgecJ0PcTrSxlS3DA6TKlP6YhTLLgBb/OdW2WvhbCxk3xtdzNpMB/JWgd6VJrk63uSwhPARhRPTNlt3cjcO1YOb8NwDSUT0PcZJdI8/FgMJdLzXMjhC/6VpNank9Lp45ON8QFOQCPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740420239; c=relaxed/simple;
	bh=cgzLQwBCDfKRaWD7SiW5ribqbmcPwvUXFZODbdvUuAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+s+JTMlGbJu7qpYKYWcHLNzA3kREPM+6aeHallS84/IbQ+IopLcDJYrPrG0re9mhjLmVL8ZTBLp4X7nuJ5L/y6l1xZraCwEPmpr16zrc+sLH3hIO2Rz9GIPMOvetDfA3CIesHe33fZaMrIPli6sulga0MoIuxiPJyixA2Q3dyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=lR5RGht4; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from hm-sls2 (bras-base-toroon4332w-grc-32-142-114-216-132.dsl.bell.ca [142.114.216.132])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8A81320376D0;
	Mon, 24 Feb 2025 10:03:56 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8A81320376D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740420237;
	bh=uLG6vEMaW8gpv5F+S3c/S5AJWW46BKdcE4ru+h4q8a8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lR5RGht4yTR/C72u7mR8k3uoCiiKr621ctR90Ca6YYCsKRVVCcJlUFalhWTUtyDD6
	 a0UPD58sWaSYY3Xvk369VoUSQTWw2ehVjg3gRDhDqxZpmEBjVdrRJBhKHMCgHZgT2e
	 HVJpiwAPf3I+HsqoCk28rxLucJl4hi5Mo+QF8Pd8=
Date: Mon, 24 Feb 2025 13:03:48 -0500
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: Tejun Heo <tj@kernel.org>
Cc: rust-for-linux@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Wedson Almeida Filho <walmeida@microsoft.com>,
	Dirk Behme <dirk.behme@gmail.com>,
	Konstantin Andrikopoulos <kernel@mandragore.io>,
	Danilo Krummrich <dakr@kernel.org>,
	Roland Xu <mu001999@outlook.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rust: workqueue: define built-in bh queues
Message-ID: <Z7y0hMZ-wAKkMrvP@hm-sls2>
References: <20250224142326.38396-1-hamzamahfooz@linux.microsoft.com>
 <Z7ytBYLKNabbm1m4@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7ytBYLKNabbm1m4@slm.duckdns.org>

On Mon, Feb 24, 2025 at 07:31:49AM -1000, Tejun Heo wrote:
> On Mon, Feb 24, 2025 at 09:23:23AM -0500, Hamza Mahfooz wrote:
> > Provide safe getters to the system bh work queues. They will be used
> > to reimplement the Hyper-V VMBus in rust.
> > 
> > Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> 
> Ah, you already sent v2.
> 
>   Acked-by: Tejun Heo <tj@kernel.org>
> 
> Again, let me know how you want route it.

I would prefer it it went through the workqueue tree, thanks!

> 
> Thanks.
> 
> -- 
> tejun

