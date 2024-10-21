Return-Path: <linux-kernel+bounces-374847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3919A7103
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4017280CD5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB811EF93C;
	Mon, 21 Oct 2024 17:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="CvA7NC5i"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F111EBFFD
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 17:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729531506; cv=none; b=Sata6YVuTmXOT9GdTbylOFOUpczkdv5jCNwXs/bmFwt2PXWT0F5rbWS7YK++45Kc0UKRT3n1+6srENT10tOtvV83HOWQ8hN4lumfKaldlL3wsspg4K6Q2TNVWxvnEewguTN1ig1YHYOrhpDB08RglJtzeik0WaOsPTAQcbt18lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729531506; c=relaxed/simple;
	bh=aGV+q42G//4R3Eefg3TESg8PD+l9Z5g/MXEWDA2Elt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ucYZH35Bt0jjTSGhNVtXEnO6eL17oaot3etPz/yhOxnNiUWu63s9G/LWhbQ/5yxB4igq1uEMEL+BXs5eyGtiEnTENoh7DUAwMD643Gn4GFZOLC9Ppj1GhZSEyXs+m2WHNtdVM1G6yLPdoHS6YfPSUAArUKE1dDLhSvSB81N1oUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=CvA7NC5i; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XXMd63hypzlgMVX;
	Mon, 21 Oct 2024 17:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1729531495; x=1732123496; bh=hw8qZQAVa0fsEP4DqzqLzRK8
	H4LDPIl1V6td3jsiGfM=; b=CvA7NC5iAVjAXRWFJpNTXBVcpbEkTy3K81Z2P7va
	WZ2//RxUN1AG3pDDHOaLyYVmm9dTuwqtzUlQ+OBlph7rHwnzaSYSOfUP+4IZ7cBk
	LQ/oQD31jFaWDW2us43yqFGHjR2isEyc8KqYR2kI9mLbWHoS9mYPStFMeS02X1t3
	rorDpLCXyQB/Zx5BIi5z9wAOQ5rhZ7dt/LrsyIk6FNL17TlB3noWKrwNp7UipWUB
	dGPVB8+wj+uOBnlvnxQ7WevsWjhBmaJwcsXxAvoGa08MJy3bCqXLGU3Z1BHyfz9R
	eYFw37uIfGkZwIlSFQY3uZ5sQQuGZ8Sxr/1rAjE8OrVJZg==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ukFOgu6KXAyK; Mon, 21 Oct 2024 17:24:55 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XXMd20lZMzlgMVs;
	Mon, 21 Oct 2024 17:24:53 +0000 (UTC)
Message-ID: <e27ab2c0-ddee-4fc2-a41e-70b4a7775127@acm.org>
Date: Mon, 21 Oct 2024 10:24:53 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
To: Sasha Levin <sashal@kernel.org>, torvalds@linux-foundation.org
Cc: ksummit@lists.linux.dev, linux-kernel@vger.kernel.org,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <ZxZ8MStt4e8JXeJb@sashalap>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ZxZ8MStt4e8JXeJb@sashalap>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 10/21/24 9:07 AM, Sasha Levin wrote:
> Current testing:
>  =C2=A0 - LKFT: https://qa-reports.linaro.org/lkft/sashal-linus-next/
>  =C2=A0 - KernelCI: https://t.ly/KEW7F

Hi Sasha,

Is blktests included in any of the above? If not, please consider=20
including it. During the past few years we have noticed that the
test failures reported by this test suite are most of the time caused
by kernel bugs. Sometimes issues in the tests are discovered but this
is rare. See also https://github.com/osandov/blktests/.

Thanks,

Bart.

