Return-Path: <linux-kernel+bounces-419110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 770B19D699A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 16:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15D97B2110A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 15:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C2F29CE5;
	Sat, 23 Nov 2024 15:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="gqAXQMNG"
Received: from forward204d.mail.yandex.net (forward204d.mail.yandex.net [178.154.239.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A191208A9
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 15:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732375023; cv=none; b=KXcqiWfuHkpmdgnjwrbdqAHL49waJZF2lFHH2A7xzqgv0ApPc3DgZGBQYNg4bd/LHU0T18UXwmbw+N0sfw+3ZVczyqAD3IV5ljJ3bPKqdIGZo0BbJL0BtHKUr54tqcu9AVK+kH4afW//9EASacFcvxztR6VK9R9iYtjE1QCVh88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732375023; c=relaxed/simple;
	bh=89E34HORxkx77NcQK/rxh0dR8hjhiDw/u03zzSL3ylw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Wi6vpHIAwgtHCNNI05F6xe3A4wK92mWvVEGeEvZY7osVShq0jA2cdHykEqHdbLm+tS860ETirwtIQwMhfWjR4InBPvo+O9s9b/vI77UnriRPYtvOwo9bZasBbhpsn+my9U106d/VtiY0H8dH8dLfciwdIjxzNt7FIYwV5MgsWdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=gqAXQMNG; arc=none smtp.client-ip=178.154.239.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward100d.mail.yandex.net (forward100d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d100])
	by forward204d.mail.yandex.net (Yandex) with ESMTPS id B8E47627AE
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 18:13:09 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-19.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-19.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:3143:0:640:c03:0])
	by forward100d.mail.yandex.net (Yandex) with ESMTPS id 41622609F0;
	Sat, 23 Nov 2024 18:13:02 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-19.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 1DXd6xLOjiE0-jDjZkTiT;
	Sat, 23 Nov 2024 18:13:01 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1732374781; bh=89E34HORxkx77NcQK/rxh0dR8hjhiDw/u03zzSL3ylw=;
	h=Subject:From:Cc:To:Date:Message-ID;
	b=gqAXQMNGHE/PyfZ+OmQSpAbOwXg8mYtZrC8dBwG0DSwpN8TC1Evmidq0h8qkbqchk
	 h/8fJgjM0IV57B85fqsIUXTjnhGvLaETCLu5hDc1wQTynt180DtMzfxnjEKhXnInzv
	 fXsdhO+vYzA7RkPns8jeSg0TkdtIxeq6z8Qc8KcI=
Authentication-Results: mail-nwsmtp-smtp-production-main-19.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <2d35e5f7-2edc-4ef0-b71b-82186c0627b0@yandex.ru>
Date: Sat, 23 Nov 2024 18:13:01 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linux kernel <linux-kernel@vger.kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Peter Xu <peterx@redhat.com>
From: stsp <stsp2@yandex.ru>
Subject: userfaultfd: two-step UFFDIO_API always gives -EINVAL
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello.

I tried to use userfaultfd and got
that strange result: when I first do
UFFDIO_API ioctl with features = 0,
it succeeds. I check the needed
features, and they are all in place.
But on the second step, where I
request the needed features,
UFFDIO_API gives -EINVAL no matter
what features I requested (or even
set features to 0 again).

A quick look into the kernel code
suggests that the problem is that
uffd_ctx_features() doesn't check
user_features for being 0, and just
sets UFFD_FEATURE_INITIALIZED
with no features at all. After that,
userfaultfd_api() should always
fail with -EINVAL when doing this:

ctx_features = uffd_ctx_features(features);
ret = -EINVAL;
if (cmpxchg(&ctx->features, 0, ctx_features) != 0)
         goto err_out;

But I haven't checked my finding
by rebuilding the kernel.
So is this broken or am I missing
something?


