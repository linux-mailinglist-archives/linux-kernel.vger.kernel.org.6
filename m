Return-Path: <linux-kernel+bounces-532188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B502AA449DC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 106F07A973D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAA319D086;
	Tue, 25 Feb 2025 18:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="DSL/nSIo"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C26221ABBB;
	Tue, 25 Feb 2025 18:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740507222; cv=none; b=R93lH2D3D6uvAYlpifFoActXJpx2bZ6vEnSYmg0Q9Cn+hBtU09Ss89n64FI4fMOWoB65K6fTXjy6uO47aDeXovcq3xO+Q3MB5Fqj5Y1SijQD5eNcbiz034kpzLqr1U0HkfgjotGWydpsvkWXgdQT2BUkJIaE/ArwCFlp0hTRnH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740507222; c=relaxed/simple;
	bh=Bk0u/iGHXg9Ki1eeZ9mntntqXtE97d+Kic6DcoUWm8Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lAxOLznIpZZV6p3Wze/4xFZaqYxsyRe03RIKW55v92uKnxSFvLNAW2/0v6li4UXP2A35mz6rijpH8OsC/3xGm8wzsl2vWA/lHGgWB0vRwHsJ3MmNtlJVYFzUzPT034xv+j0XtUgqxcWcqJ91ao9X6DM+dPOwSnncCnAc+AUDndw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=DSL/nSIo; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5FCA348EBA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1740507219; bh=Gwb7WVKf5nB6J5KPNqOALeQvZiHduU+S0+mZMtNtu+o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=DSL/nSIo3z/y2GPq+/eOpF7S0Q/YhDnPCtzjxYWKHe8hQ1jUlueP64QUz88Oq8xLN
	 kCH91O5dLlphWlu69lSVqx/RfWizWT1qTHKM1//h8WbL0wrzJwhXNMYXqRCdnyzS+h
	 +YV4ghglrAGNY8pEp5kzON2AIJBH4XNVcqhZhN9j/iVqLrbsKbl+WidJymcWpwXNZ4
	 M41x036ecicgpjb2a3adMLaKm+8zJ+45InGla87DpbkMl41s+G0wiRhGHC53xRAFMv
	 pm2uIgtahGhmQ4/bF/ykPKIcEaNFEpDpCIOsVPlQ7sdL+7ZA6dbTuF9ZIaHszZaHK+
	 BMEd3l6WGrxBw==
Received: from localhost (unknown [IPv6:2601:280:4600:2d7f::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 5FCA348EBA;
	Tue, 25 Feb 2025 18:13:39 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: jiang.kun2@zte.com.cn, alexs@kernel.org, si.yanteng@linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: xu.xin16@zte.com.cn, yang.yang29@zte.com.cn, wang.yaxin@zte.com.cn,
 fan.yu9@zte.com.cn, he.peilin@zte.com.cn, tu.qiang35@zte.com.cn,
 qiu.yutan@zte.com.cn, zhang.yunkai@zte.com.cn, ye.xingchen@zte.com.cn
Subject: Re: [PATCH linux next] Docs/zh_CN: Translate msg_zerocopy.rst to
 Simplified Chinese
In-Reply-To: <20250225194456879v1ipo2r4_8PJZn1s1J9Ge@zte.com.cn>
References: <20250225194456879v1ipo2r4_8PJZn1s1J9Ge@zte.com.cn>
Date: Tue, 25 Feb 2025 11:13:38 -0700
Message-ID: <87cyf5zyct.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

<jiang.kun2@zte.com.cn> writes:

> From: Wang Yaxin <wang.yaxin@zte.com.cn>
>
> translate the "msg_zerocopy.rst" into Simplified Chinese
>
> Update to commit bac2cac12c26("docs: net: description of
> MSG_ZEROCOPY for AF_VSOCK")
>
> Signed-off-by: Wang Yaxin <wang.yaxin@zte.com.cn>
> Signed-off-by: Jiang Kun <jiang.kun2@zte.com.cn>
> Reviewed-by: xu xin <xu.xin16@zte.com.cn>
> Reviewed-by: He Peilin <he.peilin@zte.com.cn>

So how did these reviews happen?  I have certainly not seen them on the
public lists...

Thanks,

jon

