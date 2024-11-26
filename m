Return-Path: <linux-kernel+bounces-421947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A92109D927A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 08:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48383166C2B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 07:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D72A192B63;
	Tue, 26 Nov 2024 07:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="a8rUgQJx"
Received: from forward501b.mail.yandex.net (forward501b.mail.yandex.net [178.154.239.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B2D653
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 07:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732606360; cv=none; b=c0AvCbgL+rfKsh3kfMCc53EaWY7Ctniu3i2FUWypOq++mvRp2chEE6SproHRJaqkPy+bAoOVarwZ2tSu4RKRl8VkUNeHdgBuO7LJPA/i/v15nDlkf+W07GU3nYOqqfMqEgxiOasYMmSnU9WdaPZF76lHrW3pTaVn9H9wydc/1NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732606360; c=relaxed/simple;
	bh=RYvhAKrhcpXzqfbPQ1zlE0bl8HDYf3GbTPgVvi5wmQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ndyTfozIM6aq60VCqYXa36rsPH7oBvcrL3q7hXOtg4fyeyPWbGnr/kmLu9k2BaV+1pBA4HOd4MJm90BkVm6KCSfiUlJvrjA/GBJO6qRYc75F5qcoVyHWZJDeKKurHijdkTOMnHOuBss0j9XAxhX1NsY2CQtdG1Y9IR3ipJEwG6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=a8rUgQJx; arc=none smtp.client-ip=178.154.239.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net [IPv6:2a02:6b8:c16:201c:0:640:301d:0])
	by forward501b.mail.yandex.net (Yandex) with ESMTPS id 21F25614D0;
	Tue, 26 Nov 2024 10:32:29 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id SWSIAhoOqCg0-zKXZKjyX;
	Tue, 26 Nov 2024 10:32:28 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1732606348; bh=RYvhAKrhcpXzqfbPQ1zlE0bl8HDYf3GbTPgVvi5wmQg=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=a8rUgQJxeKF6D+PFPLpKLWWeF6eXDkZxpmX+MJIpJHubpTBhf5E+IJ57ClNs6hOUT
	 JSabVmKSXm0X5x/cpNy1XrBZwRCcfiC5xg7zTuMqIacTEClOzDSsSplH5If34+nVN1
	 6T5li2/jAew1rQr95sPZoJ3mEgVDYEv8V1l1FbTI=
Authentication-Results: mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <2dd0bcee-a594-4de9-b499-a8ad37be155c@yandex.ru>
Date: Tue, 26 Nov 2024 10:32:28 +0300
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
Thank you!
I studied the examples.
They are quite clear and good
for copy/pasting purposes.

I had yet another "problem":
I tried to create the usefaultfd,
then register the API and fork()
the process. In child I do UFFDIO_REGISTER,
but the parent can't see that.
So instead of copy by fork, I
had to use SCM_RIGHTS.
Is this expected, or should it
work fine with forked fd? That
would be a bit simpler than to
apply to SCM_RIGHTS tricks.

