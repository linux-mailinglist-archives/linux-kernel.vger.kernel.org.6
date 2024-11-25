Return-Path: <linux-kernel+bounces-421411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CB39D8AFE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 18:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D8D128B1A9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA76A1B6CF6;
	Mon, 25 Nov 2024 17:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="vzOVsUxs"
Received: from forward501b.mail.yandex.net (forward501b.mail.yandex.net [178.154.239.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10371E48A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 17:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732554462; cv=none; b=qw7SFu+3OCl+Krf91lIGO1JDK9ckZkGWobKQTB05ePZ0j00n5wJhQzdE1CfFEnHCBGrUaDZwZ2r2wXdOCDnLLjK2LOWwsmf3GjAW4qczStGpEAssqzC50d2xcXS3WvZnswoiaPPIJ6mshG9vF2Wl0k5oRl20ZOrUmEpepmb6veE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732554462; c=relaxed/simple;
	bh=dB+B3z4lqzN2/iLKqxVA0bLGtXOkemLVaiNYNr0if80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pLMQM+v3l4XtbivM+dJhzLuaur+gBonxjycO0ny5qyXB8KeUuRSw2V98w8XIGLlwvexvZNAN9QsvtwhSN6qoSaY6vGntmIaNPPY7l8k+A6diCg5VPaWdLcDck/hXlzQ77ZHYItJLXcSDKcQqOu42mh5EmD54ut6usewr0SMe9XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=vzOVsUxs; arc=none smtp.client-ip=178.154.239.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net [IPv6:2a02:6b8:c1c:320f:0:640:c550:0])
	by forward501b.mail.yandex.net (Yandex) with ESMTPS id C7F4661273;
	Mon, 25 Nov 2024 20:07:36 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id Z7bfNwiOqeA0-pcXSnK7e;
	Mon, 25 Nov 2024 20:07:36 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1732554456; bh=ti/eURAd27fnIzIVATsCf8rTn98cCGIF/UmWF9lMFGs=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=vzOVsUxsa6vXEO/uv9repKcnLHAA0Tk3gSYj4y9Dz4Ef11Fn8ZcSspsJh4uQZ57hJ
	 MmVPIjJGqc0ojSe8v94yowQbyd/SLL7VCj+E5mBct3aiBX8xLAhnxFFcMS8+BYnL4o
	 RzPwa2tUcTCJWmbQ1xVPMshLqjcuPlkistVWEiKE=
Authentication-Results: mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <da978e8c-2a72-4b7b-ae67-41e6ff0d5089@yandex.ru>
Date: Mon, 25 Nov 2024 20:07:34 +0300
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
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Axel Rasmussen <axelrasmussen@google.com>, Mike Rapoport <rppt@kernel.org>
References: <2d35e5f7-2edc-4ef0-b71b-82186c0627b0@yandex.ru>
 <Z0Se4BuVfqwjeCWV@x1n> <b0818813-5a4c-4621-9810-dc7443a23dd1@yandex.ru>
 <Z0Ssq15MQd3rimBr@x1n>
From: stsp <stsp2@yandex.ru>
In-Reply-To: <Z0Ssq15MQd3rimBr@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

25.11.2024 19:58, Peter Xu пишет:
> On Mon, Nov 25, 2024 at 07:15:10PM +0300, stsp wrote:
>> Man page clearly talks about
>> "the userfaultfd object" (one object)
>> when mandating the "two-step handshake".
>> I spent hours of head-scratching
>> before went looking into the sources,
>> and even then I was confident the man
>> page is right: people should always assume
>> documentation is correct, code is buggy.
> Hmm yes.  I didn't pay much attention initially, but then after I read the
> latest man-pages/, especially "UFFDIO_API(2const)" I found it looks indeed
> wrong in the doc.
>
> In this case we can't change the code because we need to keep it working
> like before to not break ABI.  We may still update the doc.
I wonder if some non-ABI-breaker
is possible, like eg keep the current
behavior of "features=0", but allow
to (optionally) override that by a
non-0 request? Yes, I've seen kselftests
are trying to double-register after 0,
but IIRC they tried to register wrong
options, which would fail anyway.

