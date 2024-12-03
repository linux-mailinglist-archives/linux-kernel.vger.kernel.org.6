Return-Path: <linux-kernel+bounces-429803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 211B69E28D8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 18:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C206BA24CA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE511F76D1;
	Tue,  3 Dec 2024 15:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rvYg7v4/"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DA91DE8A5;
	Tue,  3 Dec 2024 15:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733241523; cv=none; b=nVT8XBtz7DH+LqwZthOy6rJAA4I91fgrxK42CJvjcpsXdcvvA0HJ2ZIesm5P8gulIiO1sck4/2mNnK4/P4FFK8uxaNHGhFNVJok3tk8dYcKCLyKa8gGqykp6Znfpx8SpwdawLaQGUdJv0BCRGKUcTdh5+rJB60jOg6LXhv9k6d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733241523; c=relaxed/simple;
	bh=NM8TA0/pb67xBzCofCt+hOtL7skTGdFReHuV+5zTAW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qYeoE+N2++SWZ6kJvrZsZ6de0I0z3mHTTuOOh9lgMu3MKByVYuhPLYoSicAiI5AJxTtwlBRlAyWEAQv/AGVsDKwdue/AACSgwEXciik7L5z1874fbSFTxYAvpjlc0E99fsVdIdvfnAZmJrz0WNKlmUZ387ljLtRpe7wN8EjLhec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rvYg7v4/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IjTAi+b2E3tsHEA0DYxeQRPX8JxIkk3HtLsAP3IxeP0=; b=rvYg7v4/R57gJMqn01dtxQiv2V
	sMfUnXu0vItdI1zjzKwHMPIJ6kWGj3hV1qAW2uYnUsL/Ino2UEtvyZySjHHiMDIjsrmPoqdnYBU6n
	InWTKI6Gy6KqM/S4NkJfN2ZneAgwPiv3+PKf7yb5omBTrNOyj+tJXxA4UrQjxrI6lgYs4UsQMb5Ul
	WYfJN7oCEjS8/qjEGlu5MNWHEJbxB/J2jsaHLLMoSYX+xFlFFGHPUL5bUEiYpVdCdFDKHwzr6ee4w
	4YICcToAqMxsoCyBUejeJF7TD/53NkASEu5JWGRj3vg3PV4nsTJbJSGyZ6z4j2jPQAT8KlEhQDJMv
	zd+qUiQA==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tIVIK-00000009pS3-39EK;
	Tue, 03 Dec 2024 15:58:38 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 568D530031E; Tue,  3 Dec 2024 16:58:37 +0100 (CET)
Date: Tue, 3 Dec 2024 16:58:37 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/10] objtool: Handle unsorted table offset of rodata
Message-ID: <20241203155837.GD21636@noisy.programming.kicks-ass.net>
References: <20241122045005.14617-1-yangtiezhu@loongson.cn>
 <20241122045005.14617-7-yangtiezhu@loongson.cn>
 <8cb35ab7-56d0-8e8d-5e18-1bc2b94aeeeb@loongson.cn>
 <20241127012042.by4g34m4twlfmove@jpoimboe>
 <53677c5f-2ea5-a227-66f7-b27c27665f6b@loongson.cn>
 <20241128001011.sjedpn2zhrhy6y6i@jpoimboe>
 <20241128001627.5czdlst5rd76qwsd@jpoimboe>
 <20241128010034.u3b7gkh4wqgb7d2s@jpoimboe>
 <19af5a40-9bf7-bab6-2a69-02fba652a7df@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19af5a40-9bf7-bab6-2a69-02fba652a7df@loongson.cn>

On Thu, Nov 28, 2024 at 10:28:01AM +0800, Tiezhu Yang wrote:
> On 11/28/2024 09:00 AM, Josh Poimboeuf wrote:

> > Still talking to myself here, I think we'll only merge the above patch,
> > since we don't know what the generic annotations are going to look like
> > yet.
> 
> OK, my next version will be based on tip/objtool/core after
> the merge window, by that time, hope the tree include Ard's
> and Peter's patches to avoid conflicts.

Should now all be pushed out and visible in tip/objtool/core.

Thanks!

