Return-Path: <linux-kernel+bounces-357457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FFF997163
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1E50B2136D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D471DEFF4;
	Wed,  9 Oct 2024 16:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWMZGUMQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9247C1DD86A
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 16:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728490832; cv=none; b=SGMXiRv4p1CwGvBkaoecTd5dv8hP2wjZMIv2iaWNQLowe+oiWrO2H64wGNlJ2MtxAzi4ctvuRje3/Bh6u8mgUcUaUUhsQGYE2fADwWbekSrbawKPYRkdwrShIS2QQFeD36oJ8T8g1UR51yYmVg1HHq+wRicXWxVR/mLggda3oI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728490832; c=relaxed/simple;
	bh=Uba5dcZr4KpnQUwqLKLl8MSM6Z2gkPYc3nfBePyhh4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFzh5RJflktSoxHmpbHeYXeRkB7dTbEguXR3yoAKdGrs18B4DL5bIkHfI8zdH45105cdsYeFkBqpWO1BZTTz3zRdLW48WhSgXvRBGkmnwtgN6cCQ5Mr5Ge/rS7Vrn21bDrgBCyo/6/Goo0XFIwRfwFbjA1uB4F91uhPFtu1jbZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWMZGUMQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D20A8C4CEC3;
	Wed,  9 Oct 2024 16:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728490832;
	bh=Uba5dcZr4KpnQUwqLKLl8MSM6Z2gkPYc3nfBePyhh4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iWMZGUMQLhfL7hJM+BhMhNP9MtoirSlnfvKgPq0O8x0QNTfxobcUKmGhuCFQWdYhI
	 pctbqvZ5Xs+KWWs9F5nHagH13mKeSGlkXWU4U/U5A3ZNx/jKq9H5GUkOAqspz0MS40
	 O5iuGVtnaQEldzx7TliSn4LAkAv4RmYi6/uCfZLghc2iEwkLkkcEmNv/BuAZ9DGLeP
	 vKBl6a/x5h6mR5b5C6l9BSQ0D6D/j4vClV7ULZ5UL92eubCQyIkw4MPo60JNNfdDF8
	 d+G24X5yovtt6YSoGQh3JHsS6+tKdOvtP1Jsa9HYEh29v2BUkhe1YCEg78UtxDzPKh
	 XSl7hBzvzl+8Q==
Date: Wed, 9 Oct 2024 18:20:29 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nathan Lynch <nathanl@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 13/15] powerpc/rtas: Use fsleep() to minimize
 additional sleep duration
Message-ID: <ZwatTfHxojsZwqHw@localhost.localdomain>
References: <20240911-devel-anna-maria-b4-timers-flseep-v2-0-b0d3f33ccfe0@linutronix.de>
 <20240911-devel-anna-maria-b4-timers-flseep-v2-13-b0d3f33ccfe0@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240911-devel-anna-maria-b4-timers-flseep-v2-13-b0d3f33ccfe0@linutronix.de>

Le Wed, Sep 11, 2024 at 07:13:39AM +0200, Anna-Maria Behnsen a écrit :
> When commit 38f7b7067dae ("powerpc/rtas: rtas_busy_delay() improvements")
> was introduced, documentation about proper usage of sleep realted functions

related*

> was outdated.
> 
> The commit message references the usage of a HZ=100 system. When using a
> 20ms sleep duration on such a system and therefore using msleep(), the
> possible additional slack will be +10ms.
> 
> When the system is configured with HZ=100 the granularity of a jiffy and of
> a bucket of the lowest timer wheel level is 10ms. To make sure a timer will
> not expire early (when queueing of the timer races with an concurrent
> update of jiffies), timers are always queued into the next bucket. This is
> the reason for the maximal possible slack of 10ms.
> 
> fsleep() limits the maximal possible slack to 25% by making threshold
> between usleep_range() and msleep() HZ dependent. As soon as the accuracy
> of msleep() is sufficient, the less expensive timer list timer based
> sleeping function is used instead of the more expensive hrtimer based
> usleep_range() function. The udelay() will not be used in this specific
> usecase as the lowest sleep length is larger than 1 microsecond.

Isn't udelay() for everything below 10us ?

> 
> Use fsleep() directly instead of using an own heuristic for the best
> sleeping mechanism to use..
> 
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nathan Lynch <nathanl@linux.ibm.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

