Return-Path: <linux-kernel+bounces-510904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B810A32370
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02B7118886D2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5464A208961;
	Wed, 12 Feb 2025 10:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="peCuS+mf"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BA4207A2C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 10:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739355851; cv=none; b=sE3XT7gZ7xdi5HA1IMBkamJGk5x/QG8k4+jWVGkCg832Y6Z8LemXB6O+8opS8NvRFucQWXTtpTCn47vI2PZEHBrdAuQ8bFM569v53rndDs99fBrA9rd3PNxiokZdKCh7ORsjifKFa51OfS4o5cfb62iWIORgk1V0GfGZBvJ3v1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739355851; c=relaxed/simple;
	bh=SThYqToUWHvjP/Afnug+GBnDOxJEOEgjBxs0eBtI6vY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0deMydMVHGjs8ZcqX2Sh+fEtK+hEgXU90hLP2U7+OsWkSCqiTFiJcEM1X3BjnhU7nWD0vNhKBB3gu2p2JwjcNvEBfRlFsWX0HwOaS9ASmAd2QI/DrqtleUrgXjePw0jsDzrE923QHQgz4oHMBKBucCG4oT1hygwTzlZr/9krpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=peCuS+mf; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SThYqToUWHvjP/Afnug+GBnDOxJEOEgjBxs0eBtI6vY=; b=peCuS+mfN7xYAK8/eV4Sm7/z7t
	mQ49gru7hxsPo0I5/TYXP9c4+SCVaHpu5LFDv+qYG/w+D46l/6XUwX7VL3GoxdlPX7jxZO6CIIwFE
	o1KJ2s8ZLYLR6/NN0NIMMYTMTIyrwAmgpHoXU3wEdtDyPB08iyoGHmaLpPb7woEbgUeWiLoTPWa/R
	ghrWZxC2+6vxUGvztC6+s/Y8mfbV28GunjjsBwc6SufPXAeWcNs+JOPz081NNTzuFzaA07ZfjwPpk
	JkETWK4u2iDYgtjcXTI26YOMRMQdIuwuxc1pUNhwvBTsdrbnWIE9miAI0g8bYYdUlI7VrEcRqqLiW
	7OCYrXKw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1ti9uJ-00000000nPr-0TM8;
	Wed, 12 Feb 2025 10:23:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A61DF300318; Wed, 12 Feb 2025 11:23:49 +0100 (CET)
Date: Wed, 12 Feb 2025 11:23:49 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Rik van Riel <riel@surriel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, bp@alien8.de,
	dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, jackmanb@google.com,
	jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com
Subject: Re: [PATCH v10 00/12] AMD broadcast TLB invalidation
Message-ID: <20250212102349.GE19118@noisy.programming.kicks-ass.net>
References: <20250211210823.242681-1-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211210823.242681-1-riel@surriel.com>

On Tue, Feb 11, 2025 at 04:07:55PM -0500, Rik van Riel wrote:
> Add support for broadcast TLB invalidation using AMD's INVLPGB instruction.

What tree are these patches against? I can't seem to cleanly apply them
to anything much :/

