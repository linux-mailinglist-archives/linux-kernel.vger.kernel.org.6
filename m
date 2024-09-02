Return-Path: <linux-kernel+bounces-311106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC839684EE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 618AF1F211DB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8207C156F33;
	Mon,  2 Sep 2024 10:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=isc.org header.i=@isc.org header.b="H3DmO7rj";
	dkim=pass (1024-bit key) header.d=isc.org header.i=@isc.org header.b="DFFV2Azn"
Received: from mx.pao1.isc.org (mx.pao1.isc.org [149.20.2.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA65181CE1
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=149.20.2.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725273481; cv=pass; b=jUAk63owSloMRpMWODwVoOGrRoa4mPeXNhRR7x61tGFy8WYrd2b63YtBNRmFS4gJrAIGnbatvedYwvlnSIBpwiI+6LrDNpdKi/uWG69WBfZsnKxRnRw+jMEohBizZx9zL8QpfJ2zS5mjXt0wNZ/o2hbzl3YQU7A24R9dusRTB7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725273481; c=relaxed/simple;
	bh=LeFBq1yxAQxRwWeGRyOfJ5o8HJUHwgdMMd6UvsZaaH0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=E6XBrKPIPpDYSkcZrIxsjY7YNqbDZ2W29NMFlwIF6iCPv3OIftkEkleWtcV2ifvvmCAWd35Q5FKXkdHATNscTpLvN/wRbZcVJff5HFFwtbW5RWG8oZFEAISqoc2ks37SYIH7JGdvUaQBDyUJ1OlgYruVKsxKMXGR3fSqw0yfsfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isc.org; spf=pass smtp.mailfrom=isc.org; dkim=pass (1024-bit key) header.d=isc.org header.i=@isc.org header.b=H3DmO7rj; dkim=pass (1024-bit key) header.d=isc.org header.i=@isc.org header.b=DFFV2Azn; arc=pass smtp.client-ip=149.20.2.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isc.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isc.org
Received: from zimbrang.isc.org (zimbrang.isc.org [149.20.2.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mx.pao1.isc.org (Postfix) with ESMTPS id DDBB03AB29D;
	Mon, 02 Sep 2024 10:37:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.0.0 mx.pao1.isc.org DDBB03AB29D
Authentication-Results: mx.pao1.isc.org; arc=none smtp.remote-ip=149.20.2.31
ARC-Seal: i=1; a=rsa-sha256; d=isc.org; s=ostpay; t=1725273471; cv=none; b=QLhGCovoadLQ6uwfa4xCNFkipeM1L3w9dOyYPNrW6K3J+BFLb5IeU9uki29/g0PyP6nzSdL5EidAnfC9KXWFkWTHwkrwcX/xa8I8lM8mDaI7vVphYn0InkxISpVAAjobAET8kmmXqv9qm7E7rvNzJLyR+Ah5v2HoPwXt2XSTQrY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=isc.org; s=ostpay; t=1725273471;
	c=relaxed/relaxed; bh=LeFBq1yxAQxRwWeGRyOfJ5o8HJUHwgdMMd6UvsZaaH0=;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Date:MIME-Version:
	 Subject:From:To; b=nKzlMARpaD+4gqArMEqIRqbsHSFm218VayeA0PlzN7FhE+T9FA8xbxVuP8Q1YelFq/Y4xiQBKoPqb0qE0vnFh4Qys4qRgYc7W8hAKGFNijxx06wSiYWMQoZgZvfuKfvuyNeso3dCBKSriy+K3YUtieVmD3/xpY7b+Z4HFLn9K6c=
ARC-Authentication-Results: i=1; mx.pao1.isc.org
DKIM-Filter: OpenDKIM Filter v2.10.3 mx.pao1.isc.org DDBB03AB29D
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=isc.org; s=ostpay;
	t=1725273471; bh=LeFBq1yxAQxRwWeGRyOfJ5o8HJUHwgdMMd6UvsZaaH0=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=H3DmO7rjHxdWd94Yx0W1ZdFeEEQCTPIBlMixsqgp1+57vYhjCgdzfxIaPXrQHhP+Q
	 zg6wJWlboZMBTCLSnYv0qlURiYPi1T/BFDX9r1ackT+uUW7ieJgmgUF4rcp0WiqIV6
	 RFAGTbMbmTFbl1L0Fod+e0xGWOF6IXjaSAjUYw5Y=
Received: from zimbrang.isc.org (localhost.localdomain [127.0.0.1])
	by zimbrang.isc.org (Postfix) with ESMTPS id D806712CA1D1;
	Mon,  2 Sep 2024 10:37:51 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbrang.isc.org (Postfix) with ESMTP id AF0E712CA1D4;
	Mon,  2 Sep 2024 10:37:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbrang.isc.org AF0E712CA1D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=isc.org;
	s=05DFB016-56A2-11EB-AEC0-15368D323330; t=1725273471;
	bh=LeFBq1yxAQxRwWeGRyOfJ5o8HJUHwgdMMd6UvsZaaH0=;
	h=Message-ID:Date:MIME-Version:From:To;
	b=DFFV2AznyVYu7jApg0nVb/p/NxuZE9Y00hR1fzfs5rwxggRKZSCSoQPsXKoT5kyv/
	 PmcmbP8DjMBNWYly3IFiFcC24QUygmymwJPeIZYTFLgTbPsrahbVE0PMK+v68IO23q
	 1pPGlXM4ZvxlnXGhXKBbBL6fOxHBjHJ6Ay6B2CX8=
Received: from zimbrang.isc.org ([127.0.0.1])
 by localhost (zimbrang.isc.org [127.0.0.1]) (amavis, port 10026) with ESMTP
 id 9fD9_t50ahHL; Mon,  2 Sep 2024 10:37:51 +0000 (UTC)
Received: from [149.20.5.111] (unknown [149.20.5.111])
	by zimbrang.isc.org (Postfix) with ESMTPSA id 6CEBE12CA1D1;
	Mon,  2 Sep 2024 10:37:50 +0000 (UTC)
Message-ID: <2ff8d9c9-febc-4049-b79b-945efe8dcc78@isc.org>
Date: Mon, 2 Sep 2024 12:37:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] mm: mmap: Change DEFAULT_MAX_MAP_COUNT to INT_MAX
From: =?UTF-8?B?UGV0ciDFoHBhxI1law==?= <pspacek@isc.org>
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
 Liam Howlett <liam.howlett@oracle.com>
References: <20240830095636.572947-1-pspacek@isc.org>
 <90f07fec-3f46-4b38-86fd-07c9f8201904@lucifer.local>
 <82960a7e-9013-475e-9b80-7b29a5667482@lucifer.local>
 <5dca8600-0352-4b5b-acb0-0cd4f84733f4@isc.org>
 <mftebk5inxamd52k46frhq2llopoiiewsgdkrjbamg4yukyhqw@vf4jzz6lmgcu>
 <b8436b35-0c39-4471-baf7-ec9a07537f9f@isc.org>
Content-Language: en-US
Autocrypt: addr=pspacek@isc.org; keydata=
 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
In-Reply-To: <b8436b35-0c39-4471-baf7-ec9a07537f9f@isc.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 30. 08. 24 19:00, Petr =C5=A0pa=C4=8Dek wrote:
> On 30. 08. 24 17:04, Pedro Falcato wrote:
>> On Fri, Aug 30, 2024 at 04:28:33PM GMT, Petr =C5=A0pa=C4=8Dek wrote:
>>
>> Can you get us a dump of the /proc/<pid>/maps? It'd be interesting to=20
>> see how
>> exactly you're hitting this.

https://users.isc.org/~pspacek/sf1717/bind-9.18.28-jemalloc-maps.xz

RSS was about 8.9 GB when the snapshot was taken.

I'm curious about your conclusions from this data. Thank you for your tim=
e!

--=20
Petr =C5=A0pa=C4=8Dek
Internet Systems Consortium

