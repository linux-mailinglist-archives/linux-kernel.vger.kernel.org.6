Return-Path: <linux-kernel+bounces-355381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 680FE995185
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 833D51C255E7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 14:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D97A1E00B4;
	Tue,  8 Oct 2024 14:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xdc2kq1v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEEC1E00A8
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 14:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728397451; cv=none; b=JS69DWpXJ7XDjiSK9vOvRDgi05yFAMisTv1p1+qJ8zMjrfGw5jX9MS2+Om+7seM85gkarhVc/WKExH4fz+1cGDvjEivGaKRH0eQCbtjWY/c0vOhjjmJJuesVXLd4kXaCTVFzhfO8/At3hfuRpFU4hAG+KmYPdw8uxNvLg7kjASo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728397451; c=relaxed/simple;
	bh=j/XkY64T5hKXINQuwTchdDMxKMroAIbEaZO3VAzuoIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQi6ZmEZ3BCTY8gMLORCP+e5Ta9Gv/xCokhLwuWMOfRD4WsEMkCON4AlI1/jLao5o8n/jpL6Lc2dPeqq2FQ8pGbfDrisC340mZmaIGuMoDXnqoFTx6MsONOPkMGJXgZT4GNT8ALvc1XIn/IM07AXAX9YWBPcvigxzds4oMpvGj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xdc2kq1v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75AC2C4CEC7;
	Tue,  8 Oct 2024 14:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728397450;
	bh=j/XkY64T5hKXINQuwTchdDMxKMroAIbEaZO3VAzuoIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xdc2kq1v6FFQk56Gp4mkIXyYta2DRc+nscSPv2GZ7jUcDMeWfcmrzfqVS4oCI+loN
	 AT+otPrHlR2DY/vAhzZMgZCUYMAIS/qaUDpi2C7DIixW8AxzcVbyeHwIcOJOnoWTh2
	 SKgJ0abX72LctmnNVYobLrbAFPeogJVnJRjLPP2cDYF3De+H8cSYQ4xR43mn5Tn0z3
	 gGbnCWzk6PchBdjdfedsnF5QmeR1LN0QXktqCq8BlQ9qNKLmjHKYRwHjmuGflGlqlE
	 A17YClShpv5TtihZy3v7TOiTpms8bmnUaPGu8gS1CAXzehkwirUkIZ4pzbK46L57jd
	 HdZxFbnunGj1g==
Date: Tue, 8 Oct 2024 16:24:08 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 06/15] delay: Rework udelay and ndelay
Message-ID: <ZwVAiJa9J6AXvIJi@localhost.localdomain>
References: <20240911-devel-anna-maria-b4-timers-flseep-v2-0-b0d3f33ccfe0@linutronix.de>
 <20240911-devel-anna-maria-b4-timers-flseep-v2-6-b0d3f33ccfe0@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240911-devel-anna-maria-b4-timers-flseep-v2-6-b0d3f33ccfe0@linutronix.de>

Le Wed, Sep 11, 2024 at 07:13:32AM +0200, Anna-Maria Behnsen a écrit :
> udelay() as well as ndelay() are defines and no functions and are using
> constants to be able to transform a sleep time into loops and to prevent
> too long udelays/ndelays. There was a compiler error with non-const 8 bit
> arguments which was fixed by commit a87e553fabe8 ("asm-generic: delay.h fix
> udelay and ndelay for 8 bit args"). When using a function, the non-const 8
> bit argument is type casted and the problem would be gone.
> 
> Transform udelay() and ndelay() into proper functions, remove the no longer
> and confusing division, add defines for the magic values and add some
> explanations as well.
> 
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

More light at the end of the tunnel for my brain!

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

