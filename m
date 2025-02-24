Return-Path: <linux-kernel+bounces-529049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EADFA41F55
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E41C160420
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C652233710;
	Mon, 24 Feb 2025 12:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CiPkSzWk"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE7C23370F;
	Mon, 24 Feb 2025 12:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740400542; cv=none; b=gTkeNogojv0Qqpm2pKkfV6s2CSwIK1vUAqblLEKJrC9O+U0LNFgBCzaIzgK6Lz9gih1lYjNW3bRqspnKhrhEhxhvif52+0lHzICkHLejA9a5svxh3G/JstY0jwG229I76atoY8VHeJXvq+1RT743vv5tC5Y7YFfyr6U0O3iMTiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740400542; c=relaxed/simple;
	bh=s/KOZT8FuLlCPeUB5JVASVwIWTkII3PCu9vNrjIh9SI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YpIrCi2quXmoyl7Vua4Ndn5PkzLEsqxiceBeg54qn3AGprD9AxV398Gpne/F2RdIsxMhCgxk/u9D1W0lb3xCXXtSeK6v6Ig4FPPrY6F7HN9pd8qrmB7KDC03OjC/G1R4gIhXQewNzsuSNqtlWu9V00sE1hattEHGmQgGwHnNN7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CiPkSzWk; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KjNIYWV63wd2ETJVPJjYoHVaRj09KcDEXGN6j/BKYZs=; b=CiPkSzWklbhO7mPKl1Jriapzi/
	h9ZxgOOaJCqDCX7rY6o0B7nUEflSjApS0qhasUcWF4BOkhJEwhaYfuv99XToeUmJQw2+kR6W5WrhW
	OwHnhVNyz53GmSNgcjiXOMIlxaXMZ0jwdb4zAwnzMZ4zeug+JEniisIxMNgEmiqKuCkxUOCf72gjQ
	oTHbKpc43qi+xEsISsUdjmrcR0JdWeEOh3E9X9GVJYKXcwRew5f16ANwoYvi3KnMMjz5NxnyR5eZs
	Kaqfcp2voEqtm9ZcyMIA26TvS5hyeuZL36CiNSnC/JxZQm22QlYAxSDZQwcmduj7p2AXViJBxosAl
	/Ur+1niw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tmXgO-00000003Bsx-0elI;
	Mon, 24 Feb 2025 12:35:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B45A4300164; Mon, 24 Feb 2025 13:35:34 +0100 (CET)
Date: Mon, 24 Feb 2025 13:35:34 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Sathvika Vasireddy <sv@linux.ibm.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, christophe.leroy@csgroup.eu,
	npiggin@gmail.com, maddy@linux.ibm.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	llvm@lists.linux.dev
Subject: Re: [RFC PATCH] objtool: Skip unannotated intra-function call
 warning for bl+mflr pattern
Message-ID: <20250224123534.GB17456@noisy.programming.kicks-ass.net>
References: <20250219162014.10334-1-sv@linux.ibm.com>
 <20250220195940.ely2l2fpsozd2tuv@jpoimboe>
 <4bea75bc-d3f6-4972-b644-f9b5a4e8bb77@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bea75bc-d3f6-4972-b644-f9b5a4e8bb77@linux.ibm.com>

On Fri, Feb 21, 2025 at 02:20:41PM +0530, Sathvika Vasireddy wrote:

> Also, just out of curiosity, how does x86 do it? Does it not use a branch to
> next instruction approach?

x86_64 can use LEA like:

  #define _THIS_IP_ ({ unsigned long __here; asm ("lea 0(%%rip), %0" : "=r" (__here)); __here; })

32bit needs to call a function, read the stack value and return.

