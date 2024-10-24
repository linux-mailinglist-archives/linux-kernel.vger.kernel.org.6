Return-Path: <linux-kernel+bounces-379083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2293D9AD97F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 03:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 523521C20EAD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 01:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B837213665B;
	Thu, 24 Oct 2024 01:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tBVpuqjJ"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4573D2C9A
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 01:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729735082; cv=none; b=r8oQWz8BKxW7qTV/wU46Hg7deir/7GaFHDX5osLEz0hdC36ASEs83vjgxzjqt8Mme3p8Ny4SrzXHozh4dwhYxGuzuWctPB+M52HOHzwLmy1gBsxLrjh1eYCyx5QLnTXtcB4X6IzNKxyV9Lfup7bJoubnzAGvZbPqtV59NBxNzbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729735082; c=relaxed/simple;
	bh=qLPeCI08odMIXP7vd58+agr+Z3mKVGJHg3Nf1bF/jqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLxcV19TgbMjNdtuwHLB42rfuLTDXbtLWTQhHXYv+2KEMsmT/oXBoBI8HNqTaNd3XuQESl5FGuElvm7w01ef9Nsf/3skseQzWbZQ05m6wtvF2Y8eQsBZNu4/oEyLqVf2hlYaw8y9f+brHFbio/O909rFr1mUFlMZcUHLAx+uc9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tBVpuqjJ; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 23 Oct 2024 21:57:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729735076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CFjpqWrnqoG6+a4l76NLnie6w+aL1dRHD1BYLLkzmtw=;
	b=tBVpuqjJ6T97HwgXk1GDNcEiBoVra8jKjWvY+YHcv86Us+NyzkHU9aH8WU/4hm7kBDaDpK
	Kxw12Ld2abOBqM0t4v6BiAYHpLqsbmC4apKR3pejs+mcMNrcvcTxyxjRwcxCZnvcgV6cja
	O15cpAf+TR1UJTZfSxNVC43qd28Y4QE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Lai, Yi" <yi1.lai@linux.intel.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [Syzkaller & bisect] There is INFO: task hung in
 __rq_qos_throttle
Message-ID: <kuvbuekbzs6saggfxleiaqtl5mleozqozpamivz2zo6pd4istq@c6hfl6govn44>
References: <ZxYsjXDsvsIt4wcR@ly-workstation>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxYsjXDsvsIt4wcR@ly-workstation>
X-Migadu-Flow: FLOW_OUT

On Mon, Oct 21, 2024 at 06:27:25PM +0800, Lai, Yi wrote:
> Hi Kent Overstreet,
> 
> Greetings!
> 
> I used Syzkaller and found that there is INFO: task hung in __rq_qos_throttle in v6.12-rc2
> 
> After bisection and the first bad commit is:
> "
> 63332394c7e1 bcachefs: Move snapshot table size to struct snapshot_table

You sure...?

Look at the patch, that's a pretty unlikely culprit; we would've seen
something from kasan, and anyways there's guards on the new memory
accesses/array derefs.

I've been seeing that bug too, but it's very intermittent. How did you
get it to trigger reliably enough for a bisect?

