Return-Path: <linux-kernel+bounces-421543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 365919D8CAE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 20:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3DD3286BEF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 19:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADEB1BD00C;
	Mon, 25 Nov 2024 19:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="BsG9J1qH"
Received: from forward502a.mail.yandex.net (forward502a.mail.yandex.net [178.154.239.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707741BCA19
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 19:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732561952; cv=none; b=BtLCiEPZmqTfi2IGCy3+3pu0lhdTqkFJEAgA7WrzKu8gqp4HlfcJ2z9HKiNVcXJzizdMUpwnM9BLaxP5u9pneyXVy5+2Aiz6MCi1/jbhyMKte7L5NGBd/a2ebLaNtO9qG2PQlQOxoYTisv9mDlPUcx0JG9B2KeFQiivG+Bs5974=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732561952; c=relaxed/simple;
	bh=JC+fXeUoKkNrn2Em1uen8majeM3HYSrMt/SoB32f7S0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nqs2qLMQV6/FKXsw8D1E5bbcyaP151BsTadGJrRdDi9HMDUpSEr4cXJVp9BFLEnEjxL2z36p144hEAdTAkEW6aK00SoGT8PdQ8tADknsPXfZQKfIa2L637zOLhJqN26eMyTMVbzVGFsgpQ2uK1oakq3DxXYaPCb2qq1N1g5yJR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=BsG9J1qH; arc=none smtp.client-ip=178.154.239.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net [IPv6:2a02:6b8:c15:2e9d:0:640:5e79:0])
	by forward502a.mail.yandex.net (Yandex) with ESMTPS id A9AE661399;
	Mon, 25 Nov 2024 21:01:48 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id l1cKLClOm8c0-wNvFb8PZ;
	Mon, 25 Nov 2024 21:01:48 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1732557708; bh=JC+fXeUoKkNrn2Em1uen8majeM3HYSrMt/SoB32f7S0=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=BsG9J1qHyrSKfozgTI22QFATltSIY+/cexzIxcFgkxjjCFVfh8JjgWD1rtx0mjGLL
	 LfGyaWkwYEFqlJ/5UFV/9Q4a2iuOtmU4wyaa5YDyomhKf6aXl3vn1q10vJxV52uqvO
	 Th01mImLH0hAOH7Im3tsN9EibB7RaoIn+uw+P+mc=
Authentication-Results: mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <4689f014-2885-42b9-91a4-ff8b8133599f@yandex.ru>
Date: Mon, 25 Nov 2024 21:01:47 +0300
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
 <Z0SwOILi4R4g9JBa@x1n> <9b68a811-ffed-4595-83a6-0ef78a7de806@yandex.ru>
 <Z0S3isgc-QlEF7oW@x1n>
From: stsp <stsp2@yandex.ru>
In-Reply-To: <Z0S3isgc-QlEF7oW@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

25.11.2024 20:44, Peter Xu пишет:
> Apps who tracks snapshots needs the unmodified pages before being written.
> Those cannot rely on kernel resolution because it needs more than "if the
> page is written" - it also needs the page data before being written.
Say I am writing a frame grabber
(not exactly, but very close to).
I monitor the video buffer of another
process, and "snapshot" it with some
frequency. I only need to know what
pages were modified, to reduce the
bandwidth to an absolute minimum,
and if the process is not playing - then
to not grab anything until it resumes.
UFFD_FEATURE_PAGEFAULT_FLAG_WP
works quite well for me already, but
I envision a huge boost with
UFFD_FEATURE_WP_ASYNC.
What would you suggest for that usage
scenario?

