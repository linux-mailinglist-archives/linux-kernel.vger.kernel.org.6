Return-Path: <linux-kernel+bounces-449771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A059F55E4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 19:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E91157A2250
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 18:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FECE1F8902;
	Tue, 17 Dec 2024 18:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5P+JkdE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1D814A0B9;
	Tue, 17 Dec 2024 18:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734459530; cv=none; b=UM1hIGaBPqAtqWITCCnuvOEAh3emkGa+A/l6tPG8SljRej7dwVcIRj6C0cTCCO5zmlkzlQnbb6GjdKZ5D1MZBXuxJMJy/4Q6pyBS7LM/LSX321O1cU09HXq50jgdk1gstHpMtTTs+PifownRDcFhrr+DZptJ6L4FUFmb5vlKGVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734459530; c=relaxed/simple;
	bh=L5mezHAUrKBlxKAGp5q6HBmp0mEqA8j99u5PMd5XXKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=giGpkHg4vHMssrYXw7vB5NuiCi4iAr6wRYOoe9jcWL2w/0vrZnBm75gY5SZ5Q13Itvjyo3Vb90XL5Wibd6OliEInFr5KX6y10uJ6OKsJ7NbuCw36bbRGzZOwVw03cabb06QhbXUO2p9v3nJfdfv9I5HEv88V1isBMR4fDKiDyfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5P+JkdE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C279C4CED3;
	Tue, 17 Dec 2024 18:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734459530;
	bh=L5mezHAUrKBlxKAGp5q6HBmp0mEqA8j99u5PMd5XXKM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X5P+JkdEXd8cqTvLjef7wEoeONheGW+JUV1JzXDsxtdIvvVuqhBzPQa7L9LNjeaoF
	 O4TTORyRScMlqptsR9otaIvC9wwzQUHggHrzZ3/f8kPZ99grOJEFD1C2g4EGORXQsn
	 yiwEKCNmUvz+arZGgqHc/kohvMXoshbUIhapzmIFV4ERuhu6s9bMUWVS6z2SLIo7Gc
	 /Jk3fSzTGhdzkhCfyPbBihEmXer6hzfycUQUx+thlhU5RJ94M4aFmNOgk+PGc5oqZq
	 l5izNmlS88H0oWIXTNIFtLeY6s/gUEIfITh3FNOKbBcRsn84c+IQKACbMsrXnayIK8
	 fNAjEGxOUZZzQ==
Message-ID: <c27875eb-0989-401b-98c3-f6e0a3ab88c2@kernel.org>
Date: Tue, 17 Dec 2024 11:18:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] loongarch/mm: disable WUC for pgprot_writecombine as
 same as ioremap_wc
To: Sui Jingfeng <sui.jingfeng@linux.dev>, Xi Ruoyao <xry111@xry111.site>,
 WANG Xuerui <kernel@xen0n.name>, Icenowy Zheng <uwu@icenowy.me>,
 Huacai Chen <chenhuacai@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Mike Rapoport (IBM)" <rppt@kernel.org>, Baoquan He <bhe@redhat.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>, Zhen Lei <thunder.leizhen@huawei.com>,
 Thomas Gleixner <tglx@linutronix.de>, Zhihong Dong <donmor3000@hotmail.com>,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 shuah <shuah@kernel.org>, "conduct@kernel.org" <conduct@kernel.org>
References: <20231009042841.635366-1-uwu@icenowy.me>
 <4f1af31b-15be-cb47-6b34-45de1b5696be@loongson.cn>
 <42b0e6f6-c2b5-49c6-b1f2-0200bef913da@xen0n.name>
 <3641d3fe-c2e7-868f-ab0d-3951c9a78b6d@loongson.cn>
 <8373ccfd93b0402caf9f5c06a2d9b93b3c0d0b49.camel@xry111.site>
 <dfc53da9-a1ab-4ab3-aba2-d100f7f28b9b@linux.dev>
Content-Language: en-US
From: Shuah <shuah@kernel.org>
In-Reply-To: <dfc53da9-a1ab-4ab3-aba2-d100f7f28b9b@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/2/24 09:23, Sui Jingfeng wrote:
> Hi,
> 

>> IIUC this is a hardware bug of 7A1000 and 7A2000, so the proper location
>> of the workaround is in the bridge chip driver.  Or am I
>> misunderstanding something?
>>
> 
> You are misunderstanding everything and ranting like a dog.
> 

Sui Jingfeng,

This is not the way to work with your fellow developers in the
community to express disagreements. I would recommend following
up with an apology.

thanks,
-- Shuah

  




