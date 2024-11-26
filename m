Return-Path: <linux-kernel+bounces-422131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 034FB9D9506
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 11:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18BA1B25B4F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 09:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7AF1C2323;
	Tue, 26 Nov 2024 09:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="C71WlpIV"
Received: from forward500d.mail.yandex.net (forward500d.mail.yandex.net [178.154.239.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504031C8FBA
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 09:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732614531; cv=none; b=dq/QSYPu39CmXUjxQMzlAjPQHFR7snaPxW/u9fijZ7C9L21BxsKUpofnCz8LKqCun4RM6U8ogvy2xzx06gET3vhsboGWmezNJeyjX2GE4zgH3sPOzjaM3SNyaU1/ziW4eWo3VctjuPfD8B9SlHk7+Flx+ejQndHogOqdv5jYkQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732614531; c=relaxed/simple;
	bh=fV9bIqTJ7zO1QpFzlB0pqsLosaA+P2BwKEVcaceGsWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TgCzfoW4cLViy4g8ZUx+gj7VKelawpdAuq63/LZTBZ7PAHRytnks4PphREcKz2YD8W5zxbSIr1vrfI0qv4ZPZ6yOgqfjjT64JCnnbmUx2cHFPXqKyYEcpDdY92p0CkxF+WuaV5nFmt+MOotC6Nfw4TNShpNy4Ka2qULOu6pAT6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=C71WlpIV; arc=none smtp.client-ip=178.154.239.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-95.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-95.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:874b:0:640:bc97:0])
	by forward500d.mail.yandex.net (Yandex) with ESMTPS id E31B960E10;
	Tue, 26 Nov 2024 12:41:11 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-95.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id AfU38hlOo0U0-H2RlBR9M;
	Tue, 26 Nov 2024 12:41:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1732614071; bh=fV9bIqTJ7zO1QpFzlB0pqsLosaA+P2BwKEVcaceGsWc=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=C71WlpIVdw6YfG4e8cFrsLdsxz3yaQqc+nD50auNcGO4tljfdeSNkIIWPoBRW2Oy4
	 XcBUWihjoGbhqnOe6tzrLeu4UC+FuDqCdfu2dH987+ZjYYXdodrsk4Tu8dJJopI5RW
	 YrIbVST5+idCFgPb1gsE/KdaVQqnopwXxJceDzCs=
Authentication-Results: mail-nwsmtp-smtp-production-main-95.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <85464663-4406-4e06-92e4-6f0f2353d147@yandex.ru>
Date: Tue, 26 Nov 2024 12:41:10 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: userfaultfd: two-step UFFDIO_API always gives -EINVAL
Content-Language: en-US
To: Muhammad Usama Anjum <Usama.Anjum@collabora.com>,
 Peter Xu <peterx@redhat.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
References: <2d35e5f7-2edc-4ef0-b71b-82186c0627b0@yandex.ru>
 <Z0Se4BuVfqwjeCWV@x1n> <b0818813-5a4c-4621-9810-dc7443a23dd1@yandex.ru>
 <Z0Ssq15MQd3rimBr@x1n> <da978e8c-2a72-4b7b-ae67-41e6ff0d5089@yandex.ru>
 <Z0SwOILi4R4g9JBa@x1n> <9b68a811-ffed-4595-83a6-0ef78a7de806@yandex.ru>
 <Z0S3isgc-QlEF7oW@x1n> <4689f014-2885-42b9-91a4-ff8b8133599f@yandex.ru>
 <20a1d49a-1f5d-4d3d-b59d-29b9791b72bd@collabora.com>
From: stsp <stsp2@yandex.ru>
In-Reply-To: <20a1d49a-1f5d-4d3d-b59d-29b9791b72bd@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

25.11.2024 21:44, Muhammad Usama Anjum пишет:
> The UFFD_FEATURE_WP_ASYNC was designed for exactly this case.
> The IOCTL will return you the modified pages. An example of usage
> can be found in selftest/mm/pagemap_ioctl.c.
Am I right that in this case there
are no more async notifications?
I.e. I need to run PAGEMAP_SCAN
ioctl() periodically, and there is
nothing to "ping" me on that?
Or have I missed that part in the
pagemap_ioctl.c?

