Return-Path: <linux-kernel+bounces-232442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2833F91A8E6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D03781F248CD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D702C198A2A;
	Thu, 27 Jun 2024 14:12:10 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7124E196C9C
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 14:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719497530; cv=none; b=gz2F/w0iTIVXVueHDPenIgNj/xUFCTljE9rtOEruchxBoo9HB3mxZW73LU4MF5RRgy+zraUoDjo5xFOOin7c4C471Zre1y91BrcuvkwvZtJz8XgEjs7Y8I6PSswwYW54aH5/ogJ4WnnbVnOS68vmZ1483bZ+5nfznZIxEqtPt6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719497530; c=relaxed/simple;
	bh=fgzXniqzYWp3hUHJWzJDPcENAUnrSBq6KvYjZywNUrY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K5tyvSh6TSFpFDfxN7xRkbPFx0K8yetQDiYzrPx/zseuc+TqthmQ7OleyxzO2tRTWXRSulNyBdUEqcKb/hH2tPSTGhoM4yGsbA8HNTsJLFaP3FxJ4VRDK8Oi+obj9sPmM2XHAimFa1uSLCHnzr0qWm8O+A+cEwyAvSSw6XAof/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B892C32786;
	Thu, 27 Jun 2024 14:12:09 +0000 (UTC)
Date: Thu, 27 Jun 2024 10:12:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Marc Zyngier <maz@kernel.org>
Cc: richard clark <richard.xnu.clark@gmail.com>, Mark Rutland
 <mark.rutland@arm.com>, will@kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, "Russell King (Oracle)"
 <linux@armlinux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Will smp_call_function_single(cpu, ...) broadcast IPI to all
 other cpus?
Message-ID: <20240627101207.0bbbead0@rorschach.local.home>
In-Reply-To: <86pls2isal.wl-maz@kernel.org>
References: <CAJNi4rMfRmWoYdsyH6ibNKN8DSCL_DO8Wa08mWbe8t7vH21Dpw@mail.gmail.com>
	<86pls2isal.wl-maz@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Jun 2024 11:38:58 +0100
Marc Zyngier <maz@kernel.org> wrote:

> You may want to enable stack trace recording and find out for yourself
> where these ipi_raise() calls are coming from.

Try trace-cmd:

  # trace-cmd start -e ipi_raise -R 'stacktrace if reason=="Function call interrupts"'
  # taskset -c 0 insmod /kmods/ipi_test.ko
  # trace-cmd stop
  # trace-cmd show

-- Steve

