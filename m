Return-Path: <linux-kernel+bounces-389740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EF09B709F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 00:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4392A2827B5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 23:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8270D217446;
	Wed, 30 Oct 2024 23:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVbQ6/y7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE831C4612
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 23:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730331748; cv=none; b=GDAjdkePCCLC+QgWrCjcZubPz8iRna3M1qWN4xiNv6SXjzAthQnNtFuLdRcW/HwrQ5Un8HoUbgeQHy3IjvbR3dLG5XKmtqKFFyrxN1l+K9n1wrBPRcOF72klQR/YPBB6Thfy8FyAu1sIUcI/EUmCDJsELXB9GdbN3n3LXZswzsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730331748; c=relaxed/simple;
	bh=k9bOMp2HT61Oej6gu2Ql5vK88fG8w93+kfnnHQ5wPv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GEJT5ew+ik3bPgy5hX4y8haxWbhsCOjypyqpDc0Fq1w0TpWB9ZKBB8O4KH+6KlmY03DDLoz5ST+SZrEC1xZmWisChkK/9a3ZV4FQaCVG92HdSPe94JoKIWf6jRzUcfbpzt5YYVwe+Qkcg2JKWgDnEIqgjC1pnGxAgDRS2HKVXQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVbQ6/y7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44405C4FE92;
	Wed, 30 Oct 2024 23:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730331745;
	bh=k9bOMp2HT61Oej6gu2Ql5vK88fG8w93+kfnnHQ5wPv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oVbQ6/y7DHsQGEQ1iugbnsUsqvrip1Ym/Ud33S9lTm+jCt+52prExPSE/FexK1l7i
	 4oA0FGBZ3lJOYYWV0BL0jOaOyCw79lhCqq/ETR2PvqSJiLW2jxUDLwtBSvMTtHekOF
	 9BKPM1dsePGU1VIvpfNepE0YmkHBko6nBrvc5Js27THk+dPcV+lwYd2aLjr+WQbQoT
	 UqQi8M6GcaDxyAXF/Ut6SEUmTkacSfsfg+w6/RV7AwTs9dvX8BvpLLn5dldt907rY3
	 mwAMrMycAaJYxct0+Z4WhaRG1kkeRxr2s/B3bbst6KmJTmGJN1xf12fBIswj90sdkN
	 gz8xxeGc3q2Bw==
Date: Wed, 30 Oct 2024 13:42:24 -1000
From: Tejun Heo <tj@kernel.org>
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Doug Nelson <doug.nelson@intel.com>, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
	syzkaller-bugs@googlegroups.com, x86@kernel.org
Subject: Re: BUG: Stall on adding/removing wokers into workqueue pool
Message-ID: <ZyLEYMZP2SiVGeSD@slm.duckdns.org>
References: <1cf7b0dbfa4190eeaf0b3401bf7a991b8db59a59.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1cf7b0dbfa4190eeaf0b3401bf7a991b8db59a59.camel@linux.intel.com>

Hello, Tim.

On Tue, Oct 29, 2024 at 03:03:33PM -0700, Tim Chen wrote:
> Hi Tejun,
> 
> Forwarding this task hung seen by my colleague Doug Nelson. He tested
> the 6.12-rc4 kernel with an OLTP workload running on a 2 socket with
> Granite Rapids CPU that has 86 cores per socket. The traces 
> seem to indicate that the acquisition 
> of wq_pool_attach_mutex stalled in idle_cull_fn() when removing worker from
> the pool. Doug hit this problem occasionally in his tests.
> 
> Searching through the bug reports, there's a similar report by szybot on the
> 6.12-rc2 kernel. Szybot reported similar task hung when attaching workers to
> the pool: https://lore.kernel.org/all/6706c4ba.050a0220.1139e6.0008.GAE@google.com/T/
> So we suspect that the problem is not GNR CPU specific.
> 
> Wonder if this problem is a known one?

First time I see it. The trace doesn't show who's holding the mutex. There
doesn't seem to be any place where that mutex should leak at least on a
glance, so hopefully it shouldn't be too difficult to find who's holding it.
Can you trigger sysrq-d and sysrq-t and post the output?

Thanks.

-- 
tejun

