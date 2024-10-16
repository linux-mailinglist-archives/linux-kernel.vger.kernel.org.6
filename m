Return-Path: <linux-kernel+bounces-367632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DCA9A04B0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6C90B247BD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CC4203711;
	Wed, 16 Oct 2024 08:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="POqdPRWO"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942D6204F74
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 08:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729068673; cv=none; b=DeXz2sEyT42CbcpiG48iuNgrFTilhcrYY3cz9QMNoR4btD6bk/14Hl9YOHJ/BpCW5Hu5sDnOEWDsRmES0tFon2BHMnlTgkX0GQcoWizQ1/ri1OmixPvoy+TOVhS/yF7NFIBrTmZn23HupkYjgG7/fixp6Rarbjz3N1fo0kCdakI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729068673; c=relaxed/simple;
	bh=I+QVUG2Bv7XZFEvnFFhbRnwpFhRrXqASNOyR5QbqfD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YDTupbyPJz7DPbm+yygGa9/UoMWro8bR5o6NZxnTNaJyO9yTeHfIH9i4xf37DiS2EvjjI/q7XZLrrVew3fy1pMiI7IJOmZ2TIWO1gEDaMah6q48EqmSeqeKFr9u3sJn5+CDfsejlcU7o35UAYGvaAUGP1UwLrhpHPpvF4arFkFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=POqdPRWO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yzrBMk6ot53bLQz060u90maSa6RVtY5pzHKYu0yEUZU=; b=POqdPRWOIC3iJJWMVGhG3/qE7L
	15C1SyQFtMc9pCyoyryjjFttQJFlufULoVrY6W8NFbr+Tdqa3/GtbgdUjG1taIBk3WJKh3oPy7tA/
	NND4HTdjFA6g3im3eK0jWp9UNizXjt8EABimzfuCtRtc0iD2fd6l1f/0HqzlIS/Z9MLa4igP4mO8m
	Ill5AD3aD4ctGW/0392YGdG7Z8osySjH3XHnWkoD3mKU8kFDk7Pg0ccsHH0gFot9cDbrvOTEL8tWQ
	Lwjro/yf0Y1G4WrO5Kv7C8n0iYeT9/hDJQINynt/M8QUHd/s6hwRqb1JABqP5lkrANb/hulKOyFYw
	QexTAIJQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t0zkE-00000007QVP-11h5;
	Wed, 16 Oct 2024 08:51:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 13D6D300777; Wed, 16 Oct 2024 10:51:02 +0200 (CEST)
Date: Wed, 16 Oct 2024 10:51:02 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
	Ian Rogers <irogers@google.com>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: Re: [PATCH 1/5] perf: Add dummy pmu module
Message-ID: <20241016085102.GW17263@noisy.programming.kicks-ass.net>
References: <20241008183501.1354695-1-lucas.demarchi@intel.com>
 <20241008183501.1354695-2-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008183501.1354695-2-lucas.demarchi@intel.com>

On Tue, Oct 08, 2024 at 01:34:57PM -0500, Lucas De Marchi wrote:
> +static int parse_device(const char __user *ubuf, size_t size, u32 *instance)
> +{
> +	char buf[16];
> +	ssize_t len;
> +
> +	if (size > sizeof(buf) - 1)
> +		return -E2BIG;
> +
> +	len = strncpy_from_user(buf, ubuf, sizeof(buf));
> +	if (len < 0 || len >= sizeof(buf) - 1)
> +		return -E2BIG;
> +
> +	if (kstrtou32(buf, 0, instance))
> +		return -EINVAL;
> +
> +	return size;
> +}

I had to change this to:

+static int parse_device(const char __user *ubuf, size_t size, u32 *instance)
+{
+       int ret = kstrtouint_from_user(ubuf, size, 0, instance);
+       if (ret) {
+               printk("suckage: %d\n", ret);
+               return ret;
+       }
+       return size;
+}

because otherwise it didn't want to work for me; I kept getting garbage
at the end and things failing. Specifically, it looked like the string
presented by userspace was not '\0' terminated, ubuf was pointing to
"1...garbage..." and size was 1.

