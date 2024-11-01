Return-Path: <linux-kernel+bounces-392891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C477F9B9956
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 21:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A53C282446
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 20:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FD21D4177;
	Fri,  1 Nov 2024 20:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="U+NkA8OO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA271CEAD7;
	Fri,  1 Nov 2024 20:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730492497; cv=none; b=I3G7wotBHBs+H2cGQiUBYqOjI8IUzg2Degr6Upb1kDJRpleB/7WpXinPH8DRHojmPnM1RWa8k1BqF4fBp8AcWIoJLVL3RHpy516SohCmhqYE0djItZFbyK380PBxW3NFcPFzaVRPAPSbaACQdkNYWGYp138qYdiLcTKIL5LDzy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730492497; c=relaxed/simple;
	bh=Cxd3gIj5vGIRySWcuR9MQxidZit/OhS5kA2lu61cn88=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=W4PGHrkOX2CNix881GWBDkqvGXwQethcYZD+dVENiBL/pWP/xzL+3w6tTKh/6N4tEMMdZR7qkrQ1RrfTJbsEb2hmO3pX6KCm5Tcs00f49/4ctaBZJGrUAC3AeS7Ta1AhJJKPL/SiAONEIQxtI2eMcipd4zZcykJWb+3w/XJ37JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=U+NkA8OO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65ADAC4CECD;
	Fri,  1 Nov 2024 20:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1730492496;
	bh=Cxd3gIj5vGIRySWcuR9MQxidZit/OhS5kA2lu61cn88=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U+NkA8OOnCgTImjssazzJ223LYrb30XXiSLS9yim375nP8kI4H+8tWzM5IU/BEMkC
	 MXU8Uq+YUx4ur5K1vNS4LLGDFkJNSni+ksBYwju5+f80g2sLz4KzuaE009H+kw8O//
	 Qhf8LbtlyvayR3awSXtNpf5TtkihLdkrHcsklSho=
Date: Fri, 1 Nov 2024 13:21:35 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-kernel@vger.kernel.org, Andrei Vagin <avagin@google.com>, Alexey
 Gladkov <legion@kernel.org>, Kees Cook <kees@kernel.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>, Oleg Nesterov
 <oleg@redhat.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] ucounts: fix counter leak in
 inc_rlimit_get_ucounts()
Message-Id: <20241101132135.80642ea36cd094fe83e3d81e@linux-foundation.org>
In-Reply-To: <20241101191940.3211128-1-roman.gushchin@linux.dev>
References: <20241101191940.3211128-1-roman.gushchin@linux.dev>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  1 Nov 2024 19:19:40 +0000 Roman Gushchin <roman.gushchin@linux.dev> wrote:

> The inc_rlimit_get_ucounts() increments the specified rlimit counter and
> then checks its limit. If the value exceeds the limit, the function
> returns an error without decrementing the counter.

Please (always) provide a description of the userspace visible effects
of the flaw.

> Cc: <stable@vger.kernel.org>

Especially when proposing this!

