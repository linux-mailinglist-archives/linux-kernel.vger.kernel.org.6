Return-Path: <linux-kernel+bounces-395445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF3C9BBDF4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 20:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 288991C21B3A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 19:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3C11C3026;
	Mon,  4 Nov 2024 19:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="klx0eLPS"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970C818C342;
	Mon,  4 Nov 2024 19:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730748449; cv=none; b=W6JNgerrAHHiwQ5Ob4z/vnPK2ZLA7Tk+XOEGCxTzc4/lsucofqQ77eslhl9Xjh0uTdNxnFkI5wasXQoktdRqt0yLsWqXyCvXWElNa6/XNaohsib1VWMZIUVQhXzqvV1s2z6wryQIuo6Z6pRiPNCpda5yUnqPONuMcRhgV7ibmSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730748449; c=relaxed/simple;
	bh=5ahiCxIeZ7Zrt1cRCp5O4yGFLwbtDrlU6FhUnRAbct8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gwNlCqKGyC0Hj9X4Ld9Iu7NRvkwYD5XxZT1zHWKOyfekxWgnHG5WArTqaDsPp7turOXI6NOEqjGudWb5rWeXF3bha5lTAqJCqW4jyFSaNUDQtX8U/VYMAriZJFXKyhGMqmJfsS5ql22zl8EocMB9DpUPQQHfAY9Ix/r50DYeC94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=klx0eLPS; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B0B1242C30
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1730748446; bh=MHJe88wvtxmCRW4ig638nW8IyXo/qVPt9CcKtlrPNmk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=klx0eLPSMwaoBnjz9CLwEYI3z7WCAB93gg4Niq8lpCA2We7OMAqwIH3BJnURQgp/B
	 HNHq/Hotc/1FSWgVk0RBDJx93ap0TEmHaQmv//p663DWHIGDDnyP10vkfB/XS0pznZ
	 6p3wgL1gGlAYbVuhTzgjmvjigjxLQ/ruT5RdQ8eTTXCcMa7Y9TAyevozZxooZPTCTI
	 I4KYEusl72ACasNjAHg11ig8DlbiVTN9UR3iyz8X0p6RPER/Dv6lrYyJ2AxD3bMURF
	 CneFXoroeK7NJX+D1cG5YKTrvvtZM5CdrbB5lCFvLfrCbRN8rhDYJQeoXywmx+aQv2
	 CQ5V5C3DdmPbg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id B0B1242C30;
	Mon,  4 Nov 2024 19:27:26 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: xu.xin16@zte.com.cn, alexs@kernel.org, si.yanteng@linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 mudongliangabcd@gmail.com, seakeel@gmail.com
Cc: wang.yaxin@zte.com.cn, fan.yu9@zte.com.cn, xu.xin16@zte.com.cn,
 he.peilin@zte.com.cn, tu.qiang35@zte.com.cn, qiu.yutan@zte.com.cn,
 zhang.yunkai@zte.com.cn
Subject: Re: [PATCH linux-next v8 RESEND] Docs/zh_CN: Translate
 physical_memory.rst to Simplified Chinese
In-Reply-To: <20241028135321916ZWK032bHhlbncjvmzDkZs@zte.com.cn>
References: <20241028135321916ZWK032bHhlbncjvmzDkZs@zte.com.cn>
Date: Mon, 04 Nov 2024 12:27:25 -0700
Message-ID: <87ikt294v6.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

OK, I have applied this patch.  A couple of comments for future reference:

<xu.xin16@zte.com.cn> writes:

> From: Yaxin Wang <wang.yaxin@zte.com.cn>
>
> This patch translates the "physical_memory.rst" document into
> Simplified Chinese to improve accessibility for Chinese-speaking
> developers and users.

Our documentation requests that patch changelogs be phrased in the
imperative tense and avoid terms like "this patch".  Some maintainers
are quite insistent about that; I'm not one of them, but it is better to
follow that guidance.

> The translation was done with attention to technical accuracy
> and readability, ensuring that the document remains informative
> and useful in its translated form.

This is not helpful in a changelog; if you have not paid such attention,
you should not be submitting the patch in the first place.  Comments
like this can go after the "---" line if you really need to include
them. 

> Update to commit 7332f9e45d2e("docs/mm: Physical Memory: Fix grammar")

...and this I don't understand at all; why do you need to reference that
patch here?

Thanks,

jon

