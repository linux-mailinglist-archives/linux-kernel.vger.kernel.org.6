Return-Path: <linux-kernel+bounces-352186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF81991B72
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 01:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A51E2834A5
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 23:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A829D16F839;
	Sat,  5 Oct 2024 23:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JL/uaEmk"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27891F61C
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 23:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728172084; cv=none; b=FdeG2vZNdylFCrT3MoblIODrjGUqotr6dks32vJ2AT5OsJVvS1SeRSOz7kJJOgyuhGgH0xXt1rXJWiBre3+T32Jmscr0dKnBP1m66+aZOSELariF6ynehnjJsQtC2Sk9zOVIYIgJIuqlHx3x/5SekvxI5EfRzGnt88dX//9wk9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728172084; c=relaxed/simple;
	bh=CU43C7lMcoFOEc9idglBpjRwCPRbGUE7aTXz/bbYE20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ml8sD2ORHfmrA1OI0XaxSrNM2tM9tUSmZHKdfFD2oMjBh3YWaUaEEMnZsios2x1Kbe3OmBMfk0zmNjXTa6JCcYct4gG1NK005arQqmG1NGl+et37SuWUEQm4F6aOzjLSTgS0TWK4Gg5VZMbSvfmFuAgu7T+X0zz7l2AmtuyXKqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JL/uaEmk; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 5 Oct 2024 19:47:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728172076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CU43C7lMcoFOEc9idglBpjRwCPRbGUE7aTXz/bbYE20=;
	b=JL/uaEmkLLFEaQoRuYJZcgRl7MstL//5asZ0o3XjLR2iX+8YUd9rU19KSwmZqNf8ovAs9m
	hQ9OpUmyBL5C6MZYdwAEAwdpN+gbZiPsPO22TERH+hH1RVqYQGAFFoL3l51kY17Cn3ZSbn
	EzQL8D6MnMqN6FHOPcBzSUafbMi6wPQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.12-rc2
Message-ID: <flykuujdisx6t2pmqykm6h4bpchgpcggbqsqviulvsiutlyh36@exltovne4jy4>
References: <cphtxla2se4gavql3re5xju7mqxld4rp6q4wbqephb6by5ibfa@5myddcaxerpb>
 <CAHk-=wjit-1ETRxCBrQAw49AUcE5scEM5O++M=793bDWnQktmw@mail.gmail.com>
 <x7w7lr3yniqrgcuy7vzor5busql2cglirhput67pjk6gtxtbfc@ghb46xdnjvgw>
 <CAHk-=wi-nKcOEnvX3RX+ovpsC4GvsHz1f6iZ5ZeD-34wiWvPgA@mail.gmail.com>
 <e3qmolajxidrxkuizuheumydigvzi7qwplggpd2mm2cxwxxzvr@5nkt3ylphmtl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3qmolajxidrxkuizuheumydigvzi7qwplggpd2mm2cxwxxzvr@5nkt3ylphmtl>
X-Migadu-Flow: FLOW_OUT

On Sat, Oct 05, 2024 at 07:41:03PM GMT, Kent Overstreet wrote:
> Face _what_ exactly? Because at this point, I can't even tell what it is
> you want, what you're reacting to keeps shifting.

And more than that, I'm done with trying to cater, and I'm done with
these long winded rants. Look, I quite enjoy the direct approach, but
I'm done with having to apologize for you in order to calm people down
every time this happens.

If you're so convinced you know best, I invite you to start writing your
own filesystem. Go for it.

