Return-Path: <linux-kernel+bounces-374333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6A79A689F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ABBF288A02
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B331F12F5;
	Mon, 21 Oct 2024 12:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpA+avOT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E961EF947
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 12:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729514148; cv=none; b=qLFhQMmoBUTGqlK0dQZtZ61LYG2rLJ9FUmDThDAnymPemlw6IkYtAZw6PNn81/flwAcJZTFxjOu1qLLo6NvhlZxwPLAX9McVtnWZkhMRupC00dV+wBuTozoSkteD+HD9rzETVzAXMAalwefBWdrOVjm2elsh2aCzTYgwK3/QeSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729514148; c=relaxed/simple;
	bh=47Xan2jr1hhv+/9jRVlzk4RsOtptUlXCbtcpPKyF3f0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jcuDDGdMucp/NtfAf4God//7l+D9VqTKVHsf3yGfomPqaXCgDCjtT/i7K3lLXwtt9x5uzI0asqZhgMgx/YNvMs1Pj5khKis/LKR2D1U2RbMzqwxXO6mCOBDIl1uWYfG0q77wL3M3/uz9inO3NfFrSpjmZ7Hlc4UQbE26fhpNzgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpA+avOT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D41C4CEC3;
	Mon, 21 Oct 2024 12:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729514148;
	bh=47Xan2jr1hhv+/9jRVlzk4RsOtptUlXCbtcpPKyF3f0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GpA+avOTh1E2kK/MJR4JsO3cZxS92x8la3/Arcz6BpxrEbi+e0FXs8AwVKRGenGJ6
	 PJVaM6kYt59gZm37U1mW2ZupncuUOCjPnJ9U5PuhAP2TXVKGj0mMzys1w5Izuci22g
	 MGTwuJSC5hQHHKexEqG+v1rkdDyK6SNBmQ8uSTxh7jVAU7BEBIIe9zhdpa0KRptffV
	 XZZbNlz61hW5xkXNRp7ptREiXmBEsEqqq28d/jxAjN2DVGTbVqVJRQ07Bzfu9UuqSU
	 ld/wSK05agwUq7C7D1IGY/UbM5rmEXQzDHkN9gIaLl6031BUxC08XZpKmz7vGh1qRl
	 rgyC30/7/suqQ==
Date: Mon, 21 Oct 2024 14:35:45 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V5 06/26] posix-timers: Rename
 k_itimer::it_requeue_pending
Message-ID: <ZxZKoZ2BmqvtZFQr@localhost.localdomain>
References: <20241001083138.922192481@linutronix.de>
 <20241001083835.611997737@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241001083835.611997737@linutronix.de>

Le Tue, Oct 01, 2024 at 10:42:07AM +0200, Thomas Gleixner a écrit :
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Prepare for using this struct member to do a proper reprogramming and
> deletion accounting so that stale signals can be dropped.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

