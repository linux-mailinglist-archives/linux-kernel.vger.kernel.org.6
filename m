Return-Path: <linux-kernel+bounces-323907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 704249744F5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 23:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0223B243F3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 21:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688E51AB538;
	Tue, 10 Sep 2024 21:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="A0qlvZfc"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B64176FCF;
	Tue, 10 Sep 2024 21:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726004428; cv=none; b=Rb2lhvXrz8DOwE3vH7ciaocR7Kv6eLWPlXu/LeglKigLTyH4Mw2PveSNp9B4YBhqBZbIUldwPk7d7CiyL70hZC23gPha52Nc+tWUcREpIsNdCd+BZcuZWopLOS3Ck3nh2PKFAiWOp/CBtDmCeJytj4e5CH0MWwT8Ql0e058ArFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726004428; c=relaxed/simple;
	bh=RrMh1hfl9glONOa/WfjbGVI4RuWn97+g9zY0JfmpDDI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HCylODNQGmOGrvYWjCMNULIFS0rmBac1/+5r7zxKAr5HBE17qYg7wWYpZdapgzyH6snrcunz2CVaMXPJ5Rxf3YaVpjZ2JBqw49HYPNVD8ucKY+6MQmQb3GuE4exMcemZnyYGb5JexeW2a4GjIIXJhHlT2gKsDKdo6WBNKBHdbbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=A0qlvZfc; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 645954188E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1726004426; bh=XVhWwf4U2d0wtmoDDSbpRb+OchS2TLIsAXcMaWYZdTw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=A0qlvZfcBJECqiniq3Kwy9VUMaxCoz8WFW2Rud5C5+kXYyzfTye1+E17gclA0TVly
	 uL/kxyyMGloWXY6P2iVjutwv3wo/SbypPiXXd+jhhBae8iuj/Xt+fi1Je3DSYL2KzP
	 JQ9b4TV7vloYYSOXWUfPq+TFkBophkvV5jf8DhmU5qhU2D14kHnUlj64nX5YdPq0wJ
	 3Om9qItXX0y7WK3FKVwZNU3/GZnz+AGwDOmXc8h5wcK0Fotxp/tsrTUeg4e0J0IQHu
	 ARm4IVvXKcLqqNN+UtCpZ4iy6INuWpvPTBNtbPzsb3sRQY13DRoZVPbL6hs9FW4CQC
	 DlH3wAwSxZ/CA==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 645954188E;
	Tue, 10 Sep 2024 21:40:26 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: jiang.kun2@zte.com.cn, alexs@kernel.org, siyanteng@loongson.cn,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: wang.yaxin@zte.com.cn, fan.yu9@zte.com.cn, xu.xin16@zte.com.cn,
 he.peilin@zte.com.cn, tu.qiang35@zte.com.cn, qiu.yutan@zte.com.cn,
 zhang.yunkai@zte.com.cn, Pengyu Zhang <zpenya1314@gmail.com>
Subject: Re: [PATCH v2] Documentation/mm: Translate physical_memory.rst to
 Simplified  Chinese
In-Reply-To: <20240904112020232OieLhsFZ_M10gBxJtUieP@zte.com.cn>
References: <20240904112020232OieLhsFZ_M10gBxJtUieP@zte.com.cn>
Date: Tue, 10 Sep 2024 15:40:25 -0600
Message-ID: <87seu75gs6.fsf@trenco.lwn.net>
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

So I have a couple of simplified-Chinese translations (this one and
20240830133230.7988-1-zpenya1314@gmail.com) sitting in my queue, but I
have no way to evaluate them for accuracy.  Is there anybody who can
help to review these?

Thanks,

jon

