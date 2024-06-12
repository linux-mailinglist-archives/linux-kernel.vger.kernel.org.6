Return-Path: <linux-kernel+bounces-212272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 839A7905D90
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 23:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23AAA283BE3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 21:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F12085923;
	Wed, 12 Jun 2024 21:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Ema3X1QG"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690BE86246;
	Wed, 12 Jun 2024 21:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718227192; cv=none; b=IkA0e5K6sSdR+MUAqcuhvAbcK5AZKlD3Cmt2nUwZEhCaHtI+1Ng3CDk/RldeYNwHyqK0c2AzAWm+EqbAAc5nmk+CHd/ubDz9H/EPWaheCiKgVIM5wMyKpijoEYP+Ypv9al7emNp0YXTks3shrI1VqKxnqbxuX2Tg58y2ht1EI7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718227192; c=relaxed/simple;
	bh=UsayQhmTBbvZxn+JkkAWjEXdx/n/EfUJPBTaHwfBl+Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QP/D5A8ejwlT0sApuWYf82et/HxXDQxOgSfbgLZCvjmcXI6n0fx6jPstF+fVsxje0Q8Zb1vU7enAXw9+h7kTxB0aaBJhsg2ETtmBkdTTfwmDeZo+3i2ruFqq5pTHBBE8Zl3YfH5hcl7qNS2CjiJckTMOaiMOGqzrbOIC68N1t68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Ema3X1QG; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7580045E09
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1718227190; bh=YVlysxHYc+R4PU9I+W2TxiWjXx4Savar4Ok/gHlaNik=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Ema3X1QGawfwpLLAd7RwyteM/wRwO1yqI0rFNauhSSTScHVObU1230YBg807hkrXe
	 fQLBHZSsjpNZc1Xw52NYBoHtCPT218P4ID1vELinhvmR5Cvb21Xua6BmVFr5iPYOd2
	 hhTrIn3EosNNOoPSBFkZj5ca7ML834qjG4xhTqsDO9nxDRVdAvWxeHw7YYC6TYufc+
	 az2IVBIyjVvJa9JYULfXgsjAtRipMIuSGgzTd2Nk9s/21R0FLhd79gHhyNcgsA7f/h
	 P/Ljsh0gzoucXmiQnOiT0UUeErD8OR3qd+vRQKwUGF9OotBtutJbrCPP8QnHwxNjh7
	 utKZb9e1I100A==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 7580045E09;
	Wed, 12 Jun 2024 21:19:50 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Dongliang Mu <dzm91@hust.edu.cn>, Alex Shi <alexs@kernel.org>, Yanteng
 Si <siyanteng@loongson.cn>, Dongliang Mu <dzm91@hust.edu.cn>, Konstantin
 Ryabitsev <konstantin@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs/zh_CN: add process/researcher-guidelines
 Chinese translation
In-Reply-To: <20240612021845.12036-1-dzm91@hust.edu.cn>
References: <20240612021845.12036-1-dzm91@hust.edu.cn>
Date: Wed, 12 Jun 2024 15:19:49 -0600
Message-ID: <87tthxoo3u.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dongliang Mu <dzm91@hust.edu.cn> writes:

> Finish the translation of researcher-guidelines and add it to the
> index file.
>
> Update to commit 27103dddc2da ("Documentation: update mailing list
> addresses")
>
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
> v1->v2: Revise description suggested by Alex Shi
>         Add a commit id to keep track of the translation status
>         Add a new line at the end of researcher-guidelines.rst
>  .../translations/zh_CN/process/index.rst      |   2 +-
>  .../zh_CN/process/researcher-guidelines.rst   | 129 ++++++++++++++++++
>  2 files changed, 130 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/translations/zh_CN/process/researcher-guidelines.rst
>
> diff --git a/Documentation/translations/zh_CN/process/index.rst b/Documentation/translations/zh_CN/process/index.rst
> index 5c6c8ccdd50d..5a5cd7c01c62 100644
> --- a/Documentation/translations/zh_CN/process/index.rst
> +++ b/Documentation/translations/zh_CN/process/index.rst
> @@ -64,6 +64,7 @@ TODOLIST:
>     management-style
>     stable-kernel-rules
>     submit-checklist
> +   researcher-guidelines
>  
>  TODOLIST:
>  
> @@ -71,7 +72,6 @@ TODOLIST:
>  * kernel-docs
>  * deprecated
>  * maintainers
> -* researcher-guidelines
>  * contribution-maturity-model
>  
>  
> diff --git a/Documentation/translations/zh_CN/process/researcher-guidelines.rst b/Documentation/translations/zh_CN/process/researcher-guidelines.rst
> new file mode 100644
> index 000000000000..66e4840f208a
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/process/researcher-guidelines.rst
> @@ -0,0 +1,129 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +.. include:: ../disclaimer-zh_CN.rst
> +
> +.. _cn_submittingpatches:

This label here ^^^ adds a new warning to the docs build:

> Documentation/translations/zh_CN/process/researcher-guidelines.rst:7: WARNING: duplicate label cn_submittingpatches, other instance in Documentation/translations/zh_CN/process/submitting-patches.rst

This is a fairly obvious error, and one you should have seen when you
did your own docs build.  Please be a bit more careful.

jon

