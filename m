Return-Path: <linux-kernel+bounces-421442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 411E19D8B59
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 18:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7C2B16643D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1961B652B;
	Mon, 25 Nov 2024 17:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="ZImyOTXz"
Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net [178.154.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CAC7485
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 17:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732555988; cv=none; b=KDi8IxHhdIOYddBcgT+u+b4ob8oipUquuCoqBrGrK53OITELfp9CQm31e6tSNsXuSVaZtmUvX7ZqDp+buqZ8YYIMvIgqDNkublveg42UEdyTbq/KtH3CJno03tY8GdxUCKNG1ATN9hWcoLlEZHAH7UU6BLrtcr/q/byQR2JjISQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732555988; c=relaxed/simple;
	bh=1RTjtOP82GM84OKq05qH5bGhFHTg+9qqms04jZZL+Mc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AZoSFhgXIzSMEEqdy/yFnGN/YFBdA0CKGL3W/mLMf88VLB5ga3D//4dupRjHhJAf2zYkaDkK054hYTKmoU2y3l49lLBxy1/DQitizggk/pR695wBwlwNDSqMCXzxHCfy0JHCMzCxhiZ804TzzSz5/OnQa9brwmPTyyBiW2XnW4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=ZImyOTXz; arc=none smtp.client-ip=178.154.239.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-57.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-57.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:3a16:0:640:e1d7:0])
	by forward501a.mail.yandex.net (Yandex) with ESMTPS id 2FBC160BAC;
	Mon, 25 Nov 2024 20:32:56 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-57.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id sWbTKi7OoeA0-88Hn4CVe;
	Mon, 25 Nov 2024 20:32:55 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1732555975; bh=ybRznEpEzrLReL6KoQ9v8c6in7syNudsxHuDFl6gQbQ=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=ZImyOTXzvWky2MzwZBJMoh+DxHEZfw9ENjCv+94bYitzzSvTEIxgaNEmb8sXjdaWf
	 Ridm2m35wKtOkX3vcBUY4NpklTtyd9IFT21l1HmdEKxgShRFa3YWk1HiS3s5Nz5I83
	 KCK6UrhAbh8XzIh6l8pl9hihoj7uCbtkUgfYIL28=
Authentication-Results: mail-nwsmtp-smtp-production-main-57.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <9b68a811-ffed-4595-83a6-0ef78a7de806@yandex.ru>
Date: Mon, 25 Nov 2024 20:32:54 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: userfaultfd: two-step UFFDIO_API always gives -EINVAL
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>
References: <2d35e5f7-2edc-4ef0-b71b-82186c0627b0@yandex.ru>
 <Z0Se4BuVfqwjeCWV@x1n> <b0818813-5a4c-4621-9810-dc7443a23dd1@yandex.ru>
 <Z0Ssq15MQd3rimBr@x1n> <da978e8c-2a72-4b7b-ae67-41e6ff0d5089@yandex.ru>
 <Z0SwOILi4R4g9JBa@x1n>
From: stsp <stsp2@yandex.ru>
In-Reply-To: <Z0SwOILi4R4g9JBa@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

25.11.2024 20:13, Peter Xu пишет:
> Old kernels will fail with -EINVAL, new will succeed.  It's already an ABI
> violation, IMHO.
>
> Not to mention I'm not sure what could happen if uffd feature flags can
> change on the fly.  Your proposal means it can happen when anon missing
> trap is enabled at least.  That's probably unwanted, and unnecessary
> complexity to maintain to the kernel.
OK, thanks for considering.

By the way, as we are at it, I have
this usage question. I initially intended
to use UFFD_FEATURE_WP_ASYNC, but
it appears (and is documented so) to not
deliver any notification.
Why not?
I am currently using UFFD_FEATURE_PAGEFAULT_FLAG_WP,
but I only want to monitor the fact that
the page was written to. With
UFFD_FEATURE_WP_ASYNC it would be
much faster, as the kernel resolves the
fault for me. Yes, I've seen the mentioning
of /proc/pages in docs (I don't even have
/proc/pages - perhaps it was ment to be
/proc/<pid>/pages?), but why such a
complexity if all I need is the notification
similar to what I get from
UFFD_FEATURE_PAGEFAULT_FLAG_WP?

