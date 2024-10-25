Return-Path: <linux-kernel+bounces-381736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A44859B038B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D64D01C22237
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 13:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBD31F818D;
	Fri, 25 Oct 2024 13:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="ebJMppbs"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A0B1632FB;
	Fri, 25 Oct 2024 13:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729861959; cv=none; b=UpVKz9dfR/EWZoDqI9YbtGO4NsWbL07TcGnmf0j+FUgo4l4slpN1SFd1PASPwo0EENivviPnfUcHncke2vxUlnSObJp4r3nO2ehvJk5pk4QerHVQ4J//nZxusvM5LohI0i0RMSC8fihQ92L3jqHZDyYbPmIwwpl6LADL6YWHFvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729861959; c=relaxed/simple;
	bh=wPrPDjvbuQeiP58khSTGY/QVQn6BJGp/uT7g+qbLK7I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r4vxun2J47+byJyJnuYszRX0uC/tSU8qpxed0uL4jtbZUq74IwF38K3Y0WFzfQP/vYTYZnVs0I3JWRRpldekP2VghOHJDn7Ws0lTsFE0zrwJoxZZbrxFajnRuhxfk4y0lQCqN4Y3RleaBh72+PwiJYbLIkUjwzL1VkxW7vHB6qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=ebJMppbs; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A296B42B33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1729861948; bh=BrHRkZL2jwggyue0IzkvCSWmi2sXcluKyZactR+0LE8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ebJMppbsW6ZgH4vAHtkwWdAILVSIHNfBY5Js/CLvA0fFihlvRYzkIvrEd+RzzXwU/
	 pH4HhKCjny5z4mn7l4ekPKKOvQWXFeyC76jGVBR6r69Tq3kSzP69pDct2PSjbA6iLu
	 gG9WQEzPglyq4ogCH94sszx0ZA579Hlz0tN2/cE5kIGshzcOd9c86YabZVrT9nQTJt
	 JS/Fy4tRUypp82kfNI2fQs97Ki8Eh3kToex/EK8N/2vzj6I0JDErE1Mj6FWsH2LDbx
	 vnEuRsn4MTpRbqqEJA4d7JrREGGUrE5kQjmv8FKVW+HGKD+mGBmNbhI5TWSHEmnDrH
	 DrIDFEtGaQUzQ==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id A296B42B33;
	Fri, 25 Oct 2024 13:12:28 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: xu.xin16@zte.com.cn, alexs@kernel.org, si.yanteng@linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 mudongliangabcd@gmail.com, seakeel@gmail.com
Cc: wang.yaxin@zte.com.cn, fan.yu9@zte.com.cn, xu.xin16@zte.com.cn,
 he.peilin@zte.com.cn, tu.qiang35@zte.com.cn, qiu.yutan@zte.com.cn,
 zhang.yunkai@zte.com.cn
Subject: Re: [PATCH linux-next v8] Docs/zh_CN: Translate physical_memory.rst
 to Simplified Chinese
In-Reply-To: <20241025150959063tInm4F6ZTyqASNRxU2GIJ@zte.com.cn>
References: <20241025150959063tInm4F6ZTyqASNRxU2GIJ@zte.com.cn>
Date: Fri, 25 Oct 2024 07:12:27 -0600
Message-ID: <87ldyc1g3o.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

<xu.xin16@zte.com.cn> writes:

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
> Update to commit 7332f9e45d2e("docs/mm: Physical Memory: Fix grammar")
>
> Signed-off-by: Yaxin Wang <wang.yaxin@zte.com.cn>
> Signed-off-by: Jiang Kun <jiang.kun2@zte.com.cn>
> Reviewed-by: xu xin <xu.xin16@zte.com.cn>

One does not normally put a Reviewed-by tag on one's own patches, so now
I am confused.  What is the role of you and Jiang Kung in the
presentation of this patch?

Thanks,

jon

