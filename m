Return-Path: <linux-kernel+bounces-370413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 267B59A2C06
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 20:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C30771F2398F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C021D1DFDBA;
	Thu, 17 Oct 2024 18:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YiQttMWe"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D351DEFCB;
	Thu, 17 Oct 2024 18:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729189164; cv=none; b=WO25nc/7iqELHR+lmh/leis3KM9VBLbTbeQqtntWHaDV8UMbwcafstmOM5CpbSfFUfaurJH0J6WB6SzYAWLAusJ0NLxg6TKjHL3FdyC4wCXShqKlXLrVxxCDkLjYLkv4ofxv/9sadZMzr51rLH6K40DRkrampyFEStkch5SZGgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729189164; c=relaxed/simple;
	bh=jyUqzb/A0N9zdnI7o+n8FN8Dd4qhMHr+GFRQkf/6cL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8QnhymPhnIH3wvIiAaqRluQo66rHIXGrkbkqYiTFoyAS5ZDcQTG+48wDrbn+rDs3TCMRf2/RQMl1euAmdhnL3ODooaKTF0fB+iGYCFdtD8vy8R0mQdlFCiNfYahAiWt9ykJF+9FV1fuphThJ/+KpE0s4RUqHRwz6Xn/snKDPAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YiQttMWe; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xclDtdCQh4Pro8+1C8nyQBevu1jc9Opn3i3g6aw6TIQ=; b=YiQttMWesBvhjOmjze//gvjsSC
	K9dfxqy8ou8ljKxmx8vI/8un+ibX0xt6v8/RC9uhACdylw4q3/VYRifGbx5CHwHfvA6/B9bXOOH8c
	9+VV9B/+S1UCHv29aO0fcR7ebE2g5u3lQGeo1ckdweJVaPks3OaG2pO2tL8CeRYl9eRhUUjHEx8il
	oKiOeI4XmnbeYsD3eOem+t1QkYd+KOlxBDH0OJ05F/V7IT/b6Kce9y+fFyPud3sn9jAP4tFZzBZ4I
	Rs0hUiRlFVMbrVZ5yDjrxZ609tn/wOdGyAsTie05mDjQMSnplqpuQ5hK63NC3+nTalE31lyPJmljK
	5fgatYtA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t1V5P-0000000Bm6e-3UxJ;
	Thu, 17 Oct 2024 18:19:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A56AA3005AF; Thu, 17 Oct 2024 20:18:59 +0200 (CEST)
Date: Thu, 17 Oct 2024 20:18:59 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>, Uros Bizjak <ubizjak@gmail.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v1 1/1] x86/percpu: Cast -1 to argument type when
 comparing in percpu_add_op()
Message-ID: <20241017181859.GB17263@noisy.programming.kicks-ass.net>
References: <20240905170356.260300-1-andriy.shevchenko@linux.intel.com>
 <f02e0624-ad4f-473c-b172-6dadea37f600@intel.com>
 <20241016192011.GY17263@noisy.programming.kicks-ass.net>
 <de705cdf-ccce-460f-846e-dfc63c63af1a@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de705cdf-ccce-460f-846e-dfc63c63af1a@intel.com>

On Wed, Oct 16, 2024 at 12:44:18PM -0700, Dave Hansen wrote:

> Would anybody hate if we broke this up a bit, like:
> 
>         const typeof(var) _val = val;
>         const int paoconst = __builtin_constant_p(val);
>         const int paoinc   = paoconst && ((_val) == 1);
>         const int paodec   = paoconst && ((_val) == (typeof(var))-1);
> 
> and then did
> 
> 	if (paoinc)
> 		percpu_unary_op(size, qual, "inc", var);
> 	...

I think that is an overall improvement. Proceed! :-)

