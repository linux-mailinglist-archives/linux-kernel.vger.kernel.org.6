Return-Path: <linux-kernel+bounces-187654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 123138CD5ED
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 16:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDD261F2234E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 14:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE9C14B075;
	Thu, 23 May 2024 14:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2Yf1EJs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5611C12B16E
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 14:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716475002; cv=none; b=K0FD8BdqfDlBlpZX3nGbaxvSgp9SGueOWBTsogILGOKr1QCUGQ+5Hiz7OruCvwJSWFwL/3SzJdfOIQDSx4pF37JK2QLeZjbNbFm0hoZo/byDFZh3YEjbzBRRm1pkckQRj2KlawiHcw1X5aae2arKg++gjXy0w6/xV/uMGU5eays=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716475002; c=relaxed/simple;
	bh=D7ccP66lbly9TPuHTgEPpEZGApPtncrxRWXRsKA8lMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kmc03K6RmU05pIqotVNMWDQUEt/cxvCTCV++3doOv95d7+WzmUYyt4fnGCfU31oGSRceXZYr0ke1Qqrsl7vxYXjAm/oT0dOVBMO+HOofnp8fllG+dyO6FLDnQ78LlQymSZGbPPeWHo4aj8HOXYtjWLyOGHsZP4QXkY2IPOtCq0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2Yf1EJs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84952C4AF0A;
	Thu, 23 May 2024 14:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716475001;
	bh=D7ccP66lbly9TPuHTgEPpEZGApPtncrxRWXRsKA8lMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V2Yf1EJsH2yyQVH3Q9SWtWkogyrRYBQ5rjxoO5OMmKaWQgNYdjxOgON6K/qm/jnxX
	 PsuVkcSv546+oFSMlSCeAfxdMC/vDp66cXvGagmBxUmwjL64wADEnkHWNwJIMbwv/m
	 +wv7wNcztLxSeOKTEH5R2KV/JD8Pwy8hp65TGd99tMW2AWdLdtigxDWdL+SW2+Tp2S
	 FG5LVL3+2fb2DOhJaChxyAAjnbZicPn7VrAZQT2toxg1D5LZRSmVaD5FFZgt3WFoMJ
	 XbgX4CpqBgzjEDZhwlIbsSfGSq7I7TeciS4bZ3eaA7ZAahW1bPXCSHb5oB6IGEK0J2
	 YszQBYY3Ydb/w==
Date: Thu, 23 May 2024 17:34:50 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jaewon Kim <jaewon31.kim@samsung.com>
Cc: "vbabka@suse.cz" <vbabka@suse.cz>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>,
	"tkjos@google.com" <tkjos@google.com>
Subject: Re: (2) [RESEND PATCH 00/10] memblock: introduce memsize showing
 reserved memory
Message-ID: <Zk9UCsZdizqC1_36@kernel.org>
References: <ZkxN0yQ7Fb0X26hT@kernel.org>
 <20240521023957.2587005-1-jaewon31.kim@samsung.com>
 <20240521025329epcms1p6ce11064c0f0608a0156d82fda7ef285c@epcms1p6>
 <CGME20240521024009epcas1p10ed9f9b929203183a29f79508e79bb76@epcms1p5>
 <20240521101753epcms1p50443f6b88adea211dd9bbb417dd57cb1@epcms1p5>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240521101753epcms1p50443f6b88adea211dd9bbb417dd57cb1@epcms1p5>

On Tue, May 21, 2024 at 07:17:53PM +0900, Jaewon Kim wrote:
> >On Tue, May 21, 2024 at 11:53:29AM +0900, Jaewon Kim wrote:
> >> >--------- Original Message ---------
> >> >Sender : 김재원 <jaewon31.kim@samsung.com>System Performance Lab.(MX)/삼성전자
> >> >Date   : 2024-05-21 11:40 (GMT+9)
> >> >Title  : [RESEND PATCH 00/10] memblock: introduce memsize showing reserved memory
> >> >?
> >> >Some of memory regions can be reserved for a specific purpose. They are
> >> >usually defined through reserved-memory in device tree. If only size
> >> >without address is specified in device tree, the address of the region
> >> >will be determined at boot time.
> >> >
> >> >We may find the address of the memory regions through booting log, but
> >> >it does not show all. And it could be hard to catch the very beginning
> >> >log. The memblock_dump_all shows all memblock status but it does not
> >> >show region name and its information is difficult to summarize.
> >> >
> >> >This patch introduce a debugfs node, memblock/memsize, to see reserved
> >> >memory easily.
> >> 
> >> This is actually RESEND as it was introduced 2 years ago.
> >> Please refer to https://lore.kernel.org/linux-mm/YkQB6Ah603yPR3qf@kernel.org/#t
> >> 
> >> > But you never provided details about *why* you want this information exposed.
> >> 
> >> For your question, I'd like to say ;
> >> We can see the same format and exact information between different version of kernel status.
> >> 
> >> 1) Internally we can check if the reserved memory changes.
> >> 2) Externally we can communicate between chipset vendors and OEM, with a same format.
> >
> >Why the existing debugfs interface is not sufficient?
> 
> debugfs/memblock/memory & debugfs/memblock/reserved have changed its
> format but still does not show name, reusable, kernel size.  If memory is
> reserved from memblock, and did not freed back to memblock. Memblock does
> not know even after the memory is freed to system.  I think a simple
> debug interface is needed to easily communicate with others or compare
> different SW releases.

I still don't understand what problem are you trying to solve with these
patches. 
 
-- 
Sincerely yours,
Mike.

