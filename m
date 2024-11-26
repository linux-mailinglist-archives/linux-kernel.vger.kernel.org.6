Return-Path: <linux-kernel+bounces-421960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2D29D929F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 08:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52EAA164C75
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 07:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AF6194137;
	Tue, 26 Nov 2024 07:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="SZlWiZaQ"
Received: from forward500a.mail.yandex.net (forward500a.mail.yandex.net [178.154.239.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1269192B77
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 07:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732606772; cv=none; b=nPE84jng3AxroC4RqsvKJ2WBUEU7aaFh9gV9OsphivdYKtZfxwbbGt55dNXCwYS0lIvdZ+1uqrinTx8+wswQpCX9jNkOuapmn1b3nWGnYsS/D+Cvf3I0H08mdjRfIdysDIcLpxy413RqH9Rs9OP8399FgPTgs7hHf12sc9PTzKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732606772; c=relaxed/simple;
	bh=7z8H+Y8tf5zXy8r4YBIPyj1j1YALVGcvE6HKnqHWGT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X6pQsTL9RtuplFywgXhfOfI7seiN1zopiTBnkYArBXK2N6ETVisP/sLQpmv7wtCkBfYcfxeCWOL27loVD3occ8VQ/UfpmbracKiXgMwWeZYZlAmaHFBJR+pD6sG0B6vAVHgxjt7CqKql7FGoDNERRHr6gWu4a1wRR01kNf3dWzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=SZlWiZaQ; arc=none smtp.client-ip=178.154.239.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-33.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-33.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:8101:0:640:a961:0])
	by forward500a.mail.yandex.net (Yandex) with ESMTPS id 80CEB60E0E;
	Tue, 26 Nov 2024 10:39:20 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-33.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id JdSMjlYOheA0-7AB2PAfL;
	Tue, 26 Nov 2024 10:39:20 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1732606760; bh=7z8H+Y8tf5zXy8r4YBIPyj1j1YALVGcvE6HKnqHWGT8=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=SZlWiZaQZZQ8oUggGBgdwRfl6hRgKSVFj6M2b+LO0lc1K8SS/ENm7+uU7+wbJPmsR
	 fT9g7dujtfUATH2UEYL4Mdt5DnZ+o7urJTv2HmwoV89hNCf/fySbG5B8AX24ImxLt8
	 +Lo/JYbZKel+y10rkBad6OvbW/tpFpo/GWU16YsE=
Authentication-Results: mail-nwsmtp-smtp-production-main-33.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <cfc58081-c49a-4f30-bb39-966c7f18b9eb@yandex.ru>
Date: Tue, 26 Nov 2024 10:39:19 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: userfaultfd: two-step UFFDIO_API always gives -EINVAL
Content-Language: en-US
To: Axel Rasmussen <axelrasmussen@google.com>, Peter Xu <peterx@redhat.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Mike Rapoport <rppt@kernel.org>
References: <2d35e5f7-2edc-4ef0-b71b-82186c0627b0@yandex.ru>
 <Z0Se4BuVfqwjeCWV@x1n> <b0818813-5a4c-4621-9810-dc7443a23dd1@yandex.ru>
 <Z0Ssq15MQd3rimBr@x1n> <da978e8c-2a72-4b7b-ae67-41e6ff0d5089@yandex.ru>
 <Z0SwOILi4R4g9JBa@x1n>
 <CAJHvVcgLPhAS583Hp_To1McpvZL2U9cXt+=LKRNcikat3JgMAQ@mail.gmail.com>
From: stsp <stsp2@yandex.ru>
In-Reply-To: <CAJHvVcgLPhAS583Hp_To1McpvZL2U9cXt+=LKRNcikat3JgMAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

26.11.2024 01:42, Axel Rasmussen пишет:
> For what it's worth, I still don't like the two-step handshake design,
> my preference is still an API like this:
>
> 1. userspace asks for the features it wants
> 2. kernel responds with the (possibly subset of) features it actually supports
> 3. userspace is free to carry on with perhaps limited features, or
> exit with error, or ...

4. pass the needed features to
UFFDIO_REGISTER, correct?

> But, I think at that point the ship has already sailed. I think to
> maintain compatibility with existing programs there isn't much we can
> do at this point.
Please, just why do you have that UFFD_API
const? Only to call every screw-up like this
one, a sailed ship? :)
Why not to add UFFD_API_v2?
Then UFFD_API_v3?
Full binary and source compatibility is
therefore preserved, you only need to
update the man page to document the
latest one.

