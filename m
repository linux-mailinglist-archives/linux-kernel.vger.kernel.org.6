Return-Path: <linux-kernel+bounces-558552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0142A5E77E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 23:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E408317CA51
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 22:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832C21EF09B;
	Wed, 12 Mar 2025 22:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="lJQh7nHi"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31221EE7A7;
	Wed, 12 Mar 2025 22:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741818746; cv=none; b=U8ZyJpOe14jiJ6ndnm0BjMF8KvZKxIayU+RYaChzkUZM2uA09ajqb0ez4wmgSq8vEzvzgWstvvqMgBvjWmjdbPv+IQu6ftQ3C4IsnY9UN4bBg23xvB1l3rPFvz8N1JKv4mVAs6YQXyL39Ks6uEbfGJ3qUX6ppRNcJa9eqiXIinw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741818746; c=relaxed/simple;
	bh=KtI76n+O5O6nhKuTHqvqGNopnOGA1LLkaAn30RddlLQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RkiBTCZH2FZn2iqVMkW78IJgR2Ye72/1wjFq5dabpvwNo5aJ050atEVx3o/pEcRWcY+wx6lw5RmJocKJqBmlOctrKj11dBxkEwtDQw2MhjDyLoT1VoXTusMFh/H0lITk+XjVGY769xb5qE26IJ8/ahO1GkwStDeIOPrlwr8ZDLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=lJQh7nHi; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BE8E041063
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1741818743; bh=e5YZ8Buzyw07M50JDdwKBmHUBpDcOOl4aappK64F9Rg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=lJQh7nHiwXIF6WVpGa1a2HdXAk/o6hYWfRrNkEX/4mwYWZjC16lTCIJaoIxD+LQX/
	 +fbn4l8b6hh1FASQkZJZ6C+j5m99svDyNzhdNbTspVF1JPw9aNpk2eha8u4ohLIM+H
	 4/8OxjgPrrd68VEFGdBDWkBOStZ6fDx6l4Uc7YRfYVphLCi5XSmyYWJZU9dM+fpIaK
	 EDP45YxYJtuLLxnybxmtDJI7YQG4Wjr6zPjjtRXsPonYBUu9tEx9tY4V7v34lfJ14/
	 lEYTbz3FM9w9iQ8USBeo8ySwe0NSCOENjXrDlSbUm3aPOsDUSTyrvgUQiJjxAPZluV
	 iECx3+ulqJ8Vg==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id BE8E041063;
	Wed, 12 Mar 2025 22:32:23 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Shuah Khan <shuah@kernel.org>, gregkh@linuxfoundation.org
Cc: Shuah Khan <shuah@kernel.org>, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 conduct@kernel.org, tab@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2] Documentation/CoC: Spell out the TAB role in
 enforcement decisions
In-Reply-To: <20250306211231.13154-1-shuah@kernel.org>
References: <20250306211231.13154-1-shuah@kernel.org>
Date: Wed, 12 Mar 2025 16:32:22 -0600
Message-ID: <87senhlw21.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shuah Khan <shuah@kernel.org> writes:

> Updates the document to clearly describe the scope and role the TAB plays
> in making decisions on unresolved violations. If and when the CoC has to
> make a call on instituting a ban, it doesn't act without the TAB's approval
> and only when the TAB approves it with 2/3 vote in favor of the measure.
>
> These changes ensure that the TAB role and its oversight on CoC measures
> is consistently described throughout the document.
>
> Fixes: c818d5c64c9a8cc1 ("Documentation/CoC: spell out enforcement for unacceptable behaviors")
>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Acked-by: Miguel Ojeda <ojeda@kernel.org>
> Acked-by: Steven Rostedt <rostedt@goodmis.org>
> Acked-by: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Shuah Khan <shuah@kernel.org>
> ---
> v1 - v2:
> - Reword change log to better describe the changes and updates.
> - Add Fixes tag
>
>  .../process/code-of-conduct-interpretation.rst  | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)

I have applied this, thanks.

jon

