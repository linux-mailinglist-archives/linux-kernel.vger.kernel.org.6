Return-Path: <linux-kernel+bounces-421357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8466D9D8A12
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25B091664F9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 16:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DD32AD14;
	Mon, 25 Nov 2024 16:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="AA9MMNth"
Received: from forward501b.mail.yandex.net (forward501b.mail.yandex.net [178.154.239.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62D82500C9
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 16:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732551318; cv=none; b=opIrdJ4R/Ys1Xpe90d7AMK+ZsprW3m8SeSSvFLwFMfRBq047nT2rG6qDzOdjxsbYbuN7CLHiZIu4p1vB31Phw6v9HR+GpxqD+4rkpBNuJ5cafRY1+GCYkb7qGqA/4szVmNy5L6N3hv0PGo5u6Mo3xbCtVm8nL03MuFpMAA6NbuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732551318; c=relaxed/simple;
	bh=1gDVGmg8L9iSjxj4F/V1zE1GY2JmGlTHDiYYu55Kwas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a6j48lx1+c/ZBRHx/5H+lTpRS0009+/JMb0bGQeBi2bky8ZXGpl1hMqrcY06mJAAOD+CubYSIblXOrkv5BBkwDpQQEDKqOTIcJ8FK6spBXyfwtUan0wbKIC76h0vSrhIi0pJVxVkEl3T/id+E2Kc7AcUGdvXDk3XceP9DR6Hs5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=AA9MMNth; arc=none smtp.client-ip=178.154.239.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:b908:0:640:4447:0])
	by forward501b.mail.yandex.net (Yandex) with ESMTPS id 7F56B6122E;
	Mon, 25 Nov 2024 19:15:11 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id AFanlKUOlOs0-07hg4h0m;
	Mon, 25 Nov 2024 19:15:10 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1732551310; bh=uEbSAkyBtkDcpmrKuFzkH4kEFSHfAaRNRPcb9jNawf0=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=AA9MMNthYaiCPE1I+0lNGDq24xOMMfDZy+pZOWJcRd42o6NsNiPLy5bpkESGYIAL3
	 zsnAwdTSUwoiLW6BLj+SWuQ3pIS7nSElIBVhLNeK3Bc3WEtx3q7VC5K7iedH6/bOWC
	 ZbVVLXBAGIfz0Gu4GUDS3s7O3WGmZG56omZZCDyk=
Authentication-Results: mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <b0818813-5a4c-4621-9810-dc7443a23dd1@yandex.ru>
Date: Mon, 25 Nov 2024 19:15:10 +0300
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
 <Z0Se4BuVfqwjeCWV@x1n>
From: stsp <stsp2@yandex.ru>
In-Reply-To: <Z0Se4BuVfqwjeCWV@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

25.11.2024 18:59, Peter Xu пишет:
> I agree it's slightly confusing but it's intended.  It's like that since
> the start, so I think we should still keep the behavior.
>
> The userapp needs to create one extra userfaultfd to detect supported
> features in the kernel.  To use it after a probe request, you'll need to
> close() the fd, redo the userfaultfd syscall to create another fd.
Hi Peter, thanks for info.
Unfortunately man page doesn't
say that. In fact if it did, I won't be
using the second userfaultfd just
for that, anyway. :)

Man page clearly talks about
"the userfaultfd object" (one object)
when mandating the "two-step handshake".
I spent hours of head-scratching
before went looking into the sources,
and even then I was confident the man
page is right: people should always assume
documentation is correct, code is buggy.

Would it be possible to re-document
this part? As all test-cases in kernel
do not use 2-steps - how about just
removing that part from man page?
Suggesting another fd would be strange. :)


