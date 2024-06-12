Return-Path: <linux-kernel+bounces-212276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E78905D9D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 23:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D08E283519
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 21:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3935D86252;
	Wed, 12 Jun 2024 21:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="JYUbA/sH"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF91484FCC;
	Wed, 12 Jun 2024 21:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718227660; cv=none; b=aQF8RoN7lkFOHrcToBlRoiDfWM3xsENItRF4Zj+/w9kFEf7dBDgMyIM1S0p8hfOrBtSLQ22q+q00vrAhtqRm4XnA4DsWDeaBhRF0zVW5gxC3m0pwe5BZ/CfwgybP+Ooz3mt+ZTswF4gywYNZVdekfqSUihfWrnozepBc4qrV+Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718227660; c=relaxed/simple;
	bh=iNKRAVmgVPuJjkZmutjGGUinWHg9HGMQVM1k9mQiruM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NC33ljqN5YU0+hICfoK+46Q5Low/77CdT3msMZjbesM4+N1XEECzQ5bnMmwnbc9qIudiJW7rrRu8olKOykjFz7L9TxoCP8kR1F8OOFA4BvumCLZD9tpfNJ5YW7cqd7GW7L9jWyHOcOY86QKzoTXyaicZEoL3eep4uGZJRbR0YXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=JYUbA/sH; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E43B745E09
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1718227658; bh=judTS4e2A9LJPkUHh8Mr7Rl655ZESyNbLNfX5WEC/0A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=JYUbA/sHmBKyzx3Msqf+4dR2is282yF6FGJpHw+tKhq77PptEDUiZ0zgJok6KlFIX
	 V7SiWwk1+e9W4xHb+GDZA4mb97du4cTT3Hp/FOI/ztIpNZB4YW43AxkriA2PtDstYb
	 wkldFEGwwryXfJeJW74BvaKuAJ0zhN8tqTwN/a8BtaHDNvuh+5z9pStNVMbT8VcXzs
	 YMg4x7IQ33nGG5xO/s0/OGh49FMSMDL9XJEtG8PuFwskqg4kw0nw/xoida52g6HJ9D
	 PF2o95v9i18Mlwzh76X/h1rgVUaLHAHRe8uftXT2AeWBGj37ZG7yqwEXeKRG2T2FzV
	 Yk8UKY2yclP4w==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id E43B745E09;
	Wed, 12 Jun 2024 21:27:37 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Dongliang Mu <dzm91@hust.edu.cn>, Alex Shi <alexs@kernel.org>, Yanteng
 Si <siyanteng@loongson.cn>
Cc: hust-os-kernel-patches@googlegroups.com, linux-doc@vger.kernel.org,
 Dongliang Mu <dzm91@hust.edu.cn>, Cheng Ziqiu <chengziqiu@hust.edu.cn>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] scripts: add scripts/checktransupdate.py
In-Reply-To: <20240611131723.53515-1-dzm91@hust.edu.cn>
References: <20240611131723.53515-1-dzm91@hust.edu.cn>
Date: Wed, 12 Jun 2024 15:27:37 -0600
Message-ID: <87plslonqu.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dongliang Mu <dzm91@hust.edu.cn> writes:

> The checktransupdate.py script helps track the translation status of
> the documentation in different locales, e.g., zh_CN and verify if
> these documenation is up-to-date. More specially, it uses `git log`
> commit to find the latest english commit from the translation commit
> (order by author date) and the latest english commits from HEAD. If
> differences occur, report the file and commits that need to be updated.
>
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> Signed-off-by: Cheng Ziqiu <chengziqiu@hust.edu.cn>
> ---
> v1->v2: revise the output format of git commits
>         add some description and usage of this script
>  scripts/checktransupdate.py | 203 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 203 insertions(+)
>  create mode 100755 scripts/checktransupdate.py

I have applied this, it seems like a useful tool.

I do wish the code looked like something a bit closer to the kernel
coding style, but so it goes.

Thanks,

jon

