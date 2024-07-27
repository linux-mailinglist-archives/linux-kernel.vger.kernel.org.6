Return-Path: <linux-kernel+bounces-264188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0FB93DFF7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 17:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E54FBB2141C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 15:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D40F17F4F2;
	Sat, 27 Jul 2024 15:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="UmhooHB1"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AAD2110F
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 15:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722094216; cv=none; b=B1yvDZoAG4Jw3k7NuJP2Dms7DaxGVOx+nyZbxQD9cCjJXGmc7qs/CVWtOR8X97xSfw0JZH2FfLf9AZTjswqa2cICi380CwKpGjlDxocDkiekzPPuPv12G06VOp8Ne0n2BmGrpRKjJICaF8I6BSRVzdYnBxnKPgmJH4/EX9JiHrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722094216; c=relaxed/simple;
	bh=bKqgLrIlLvelJxr5lIxagT4R8PupRQw91OJmVsaaxRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XNNYsGlBbxevL+5/BhFAAo0Oq5aCE6spj6Z2q0SOoyBGIHqa784/KWuoZUNKxEGmfnxpPn6cdnnQ0a2kjt57ipW00zXYAjTQGMeVmEvVTsqy/bigpuC3ffk1xtIiNAtf4QjP6CXQrgDj4QvfWrN0UvNHa5WttgHlj1JC3r3Yg2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=UmhooHB1; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2cb4c2d13a0so265344a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 08:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1722094212; x=1722699012; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xjSfcIhDjY4GV8D4Z8+SoPCU9UdpDJVAaklewxN8+/c=;
        b=UmhooHB1JBqRhyxxv8hjbzf6XdUV5UOLhOPtveJ3q4yXx4dUBV/ek3CUn4TnMMIV3s
         rTowP44FsqYTK/FyBgkfPQuwv8qZH9gPh0qz7Uc0I49Oq//MbLyLamxDDwQkEMyySxNE
         9jpKh5KfWnf4LXEv5IrJu8jIyCdAJgUS1vXkjRgMLxL9zCxOiBeKp6gJYwZVx1gT6dmH
         l0PvY+X+FlSIH0o3uvZD7/dsoXynlsWLjnt83TiA3pSQrpvLQ71vKDHUWE20vGmOH7Y6
         2xkb9jQUrz2htk7JXQ7VvIzu/1mG8xijy4v3KowKa9yuc1FInydZNYdnzZ12NzIXC5Gr
         bc3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722094212; x=1722699012;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xjSfcIhDjY4GV8D4Z8+SoPCU9UdpDJVAaklewxN8+/c=;
        b=KAYaUNcBrT6Dd+Kf9SWLcI1xz0iwbHwXR9y11PBUZDQ9F2Q9DHLtQ4Pf/xAO2h45Va
         89AJ5+bYd2a0NafWQrN50cUCZ8EiEjr+Da6rToE38wXI0dGICazv4pCYMe38l8jdtsrw
         gWqHZXoupnyRuZokajceRCzxVPdsx5bMNC4K55P/M/6AWD2tHCz9uVE26NBkrV+wgGjK
         uzTMzKG3m/WwGrNmNWtN7x0Hl1GpdFo0G2FZzn5fDU+MkYicJEEqS3snghbVEwqgqfeA
         lZgIwXoEwaheB/WVRH/aJgyd5gPuyiB6me3bnbzmCDZ8aSCk+KhrT3kH2UdiMRrXhavd
         ce6A==
X-Forwarded-Encrypted: i=1; AJvYcCWHVYIB0T202c+VTDWcdHoW12ZuYanCsSF+0QuI1pTD0Ur4ejpStJOPolBmZ9O1SgwNvEJY4Hsv9Svm12g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5aksj9+9p7SVHrpudeVp7eEQdym0u+EG526t+R4wjsE7hWZ3b
	osoq6ofiunsVK5rhiUIW0LZH0t2eLSPMvhkBxAzAtNgpcgIqKHCbbMwsZYttnHA=
X-Google-Smtp-Source: AGHT+IEYNa9R0N8wqgDwoHxj2CHabmFiF6HV0qBrlR4ClkTvtY1S5Pva1b0yDaVRgo7GrflgHSlPAQ==
X-Received: by 2002:a17:90b:1c10:b0:2c2:d11b:14dd with SMTP id 98e67ed59e1d1-2cf23f71108mr6401287a91.0.1722094212209;
        Sat, 27 Jul 2024 08:30:12 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb74e873bsm7399538a91.40.2024.07.27.08.30.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jul 2024 08:30:11 -0700 (PDT)
Message-ID: <f26b8167-ee81-413e-b48a-0469680fb768@kernel.dk>
Date: Sat, 27 Jul 2024 09:30:10 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] minmax: reduce compilation time
To: Linus Torvalds <torvalds@linuxfoundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Laight <David.Laight@aculab.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Christoph Hellwig <hch@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@kernel.org>,
 "Jason@zx2c4.com" <Jason@zx2c4.com>,
 "pedro.falcato@gmail.com" <pedro.falcato@gmail.com>,
 Mateusz Guzik <mjguzik@gmail.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <23bdb6fc8d884ceebeb6e8b8653b8cfe@AcuMS.aculab.com>
 <902a9bf3-9404-44e8-9063-03da3168146a@lucifer.local>
 <CAHk-=wjCV+RmhWjh2Dsdki6FfqZDkM9JMQ=Qw9zGmGQD=ir6cw@mail.gmail.com>
 <b8722427-cf1e-459f-8bad-04f89fb5ffc6@lucifer.local>
 <CAHk-=whsMPLro6RDY7GrjvXpy+WYPOL-AW5jrzwZ8P4GPBHxag@mail.gmail.com>
 <137646a7-7017-490d-be78-5bd5627609c3@lucifer.local>
 <36aa2cad-1db1-4abf-8dd2-fb20484aabc3@lucifer.local>
 <CAHk-=wjPr3b-=dshE6n3fM2Q0U3guT4reOoCZiBye_UMJ-qg1A@mail.gmail.com>
 <CAHk-=whH6rJeo1WxZWQzTeEXS+8MNV=A2c4qrF-uFYjU-J6U-g@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=whH6rJeo1WxZWQzTeEXS+8MNV=A2c4qrF-uFYjU-J6U-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/26/24 4:48 PM, Linus Torvalds wrote:
> I didn't even look at what the issue was with the
> bio_for_each_segment() expansion, in the hope that Jens will make that
> one look better.

I did take a quick look, pretty obviously bvec_iter_bvec() which makes
it horrible, which came from Kent's immutable work quite a while ago.
Not sure yet what to do about it, will spend some time on this next
week.

-- 
Jens Axboe


