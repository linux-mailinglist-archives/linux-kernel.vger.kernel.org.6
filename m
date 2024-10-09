Return-Path: <linux-kernel+bounces-357445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AABF997149
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 054BAB267EB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87AB5A7AA;
	Wed,  9 Oct 2024 16:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="IWWB/aia"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A0C1E25EE;
	Wed,  9 Oct 2024 16:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728490549; cv=none; b=fpebZXDlOSpnwZSBUEft2oHIDsHRwN1+OEx8ZnNJ6gg5ztlltOiq2WJw/QAgjNcDAoLJQ1aupfz9QBY6IJpd703icEoJAo1LNa11Y/QO00vBAKotMVvxJvlYDgAVdgv46KduOntR503HoQ0rmgngTxUKu4jgWh1HU0PSvz4Lrus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728490549; c=relaxed/simple;
	bh=M/ITb2FVzNNNzUQiWSg2FGDAKOER5kCds7nowSGQ/zU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wo7Wqvp6VaAx4LPM8KR5RdXpqbfEnRE/FifUYqptO0wWx0kduXUOs+WF0jyelD76T1Ayhz9ld+Yjk9cjNiBkHCn3NIeCuBdNvt2g2x2aA3FaMInunyg1/GxcVegxAAwP6QjlQISrA/mOv/XgFnyW9lMwUJrAaahaaMdBR4Ku2NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=IWWB/aia; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C30D942BFE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1728490545; bh=NjqhBZRochyW4BAgB0vKuGodznxzOKCcr9igmm+TVhM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=IWWB/aiaGlTDm8lOAYxgYtBBXuq+PRH2tO0zfJbEX3zheyUtL1MqFjRKynOo9NSKz
	 U6+ixqLgXsEn17QP1drpFzgAkb2zNhpdrsnOcHjcdUMF2h9CoohFJjU4rS8lgVeVDt
	 AlN7XQw+z/XLicQl3gKiVwNr39XGXNuyR7izkQYtHtmk39KwHduaduqcnhg5tydd8J
	 aSm7/yLXr+HKOClrr8ThD1P4C2n4gHJzAhD1R8QSSB5WeDv4rYZYTBY+ecQGpaa436
	 YU5A4F5zQzlGKr1DlMNw4aWtEGGP+ae+AYBSkLJWG8ymIoybdYgHRpbub4oG/28OAQ
	 Z9+d3iLib/QJQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id C30D942BFE;
	Wed,  9 Oct 2024 16:15:45 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: jiang.kun2@zte.com.cn, alexs@kernel.org, siyanteng@loongson.cn,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 mudongliangabcd@gmail.com, seakeel@gmail.com
Cc: wang.yaxin@zte.com.cn, fan.yu9@zte.com.cn, xu.xin16@zte.com.cn,
 he.peilin@zte.com.cn, tu.qiang35@zte.com.cn, qiu.yutan@zte.com.cn,
 zhang.yunkai@zte.com.cn
Subject: Re: [PATCH v4 RESEND] Docs/zh_CN: Translate physical_memory.rst to
 Simplified Chinese
In-Reply-To: <20241009094607377dUpMqBUFFrp0LP303_o5H@zte.com.cn>
References: <20241009094607377dUpMqBUFFrp0LP303_o5H@zte.com.cn>
Date: Wed, 09 Oct 2024 10:15:45 -0600
Message-ID: <87ldyxb6by.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

<jiang.kun2@zte.com.cn> writes:

> From: Yaxin Wang <wang.yaxin@zte.com.cn>
>
> This patch translates the "physical_memory.rst" document into
> Simplified Chinese to improve accessibility for Chinese-speaking
> developers and users.
>
> The translation was done with attention to technical accuracy
> and readability, ensuring that the document remains informative
> and useful in its translated form.
>
> Signed-off-by: Yaxin Wang <wang.yaxin@zte.com.cn>

So that is not you.  If you are passing on a patch written by somebody
else, you need to add your own Signed-off-by tag as well.

I would love it if somebody could review this...

Thanks,

jon

