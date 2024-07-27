Return-Path: <linux-kernel+bounces-264189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F9593DFFE
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 17:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3358A2820D4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 15:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBD317F4F2;
	Sat, 27 Jul 2024 15:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jtKziFm+"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA511EF12
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 15:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722094740; cv=none; b=BMDsbAkoj+8IMMd0/BYFZdQi5tx5FLz6k4fn//N03J/jEOZ7R3rLqiBqvoFPdax9RJAzHoSJqlFKFntK/oS4DSD+zKrxzeJrOYaHDA3iT9AAb/PT20o5ugpMnV8MXHF1VUgEgsPSbaUnRkfo1fbth5TtMjBNHisybh+NXwR7VFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722094740; c=relaxed/simple;
	bh=0LN7uqPMaZ51MY0Ff/+kPeqpYl3cDu6zDPufYKVMGVU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Bh/d7TTusllTX5jv7xYZQb0BCoArJuFKZAeyELMhqIpFuDyy5Az5ci0yuI0jKNCqTFAQiSJwhkhsq8fjWJyvIIDIfOe0ai11BpX2QldjOlKOa94a96yHb9WlaGNx9Fd/ftLlgU106y6khrt3ymVdVzLU9tolmNVysTJwQZZbw90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jtKziFm+; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2cb80633dcfso318456a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 08:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1722094737; x=1722699537; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8HNKPiNpgoslt8uTd91g/kgBmz+xn5BZUJtIHzALliI=;
        b=jtKziFm+UgljTyiilYuhYKcXlXyNSs1WBZEDD5/4JdxpRpzg9qosMs9g4jgGJg1EUB
         vFLqI8TlpqjJw4l1Po6cZP3bdo91TD15tUjz/GtPmNPg4YAw3yJ1d4tV+gLnXnxYpsLp
         5PDDIjgV5I0d/fdjmCIBJ1zCaLtN6BhhB3zQNLiEXhaHNjXUXynNMb7JL7N8+men3RnM
         sLK9Y+nh+t1Dkw+LZ8r6MJByLI04bdnqw+dKqRLk+yTnUCA4i9yn+kDTckEPXGbSS7ve
         oFCiUhp01IBectzcOG+mX1Y1S9ERL6SIqnttqjkMPhXn7ENxde7dFOSQsEj0oZUMsOKT
         Ik9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722094737; x=1722699537;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8HNKPiNpgoslt8uTd91g/kgBmz+xn5BZUJtIHzALliI=;
        b=Vn12TQujDQTJ7cYOxLNoEeOrffxO281KAZEr1twLDMyr21Y07AlPD6p53ExqFgRemJ
         3R/iJwSsnbxiMniA6NiYn7CZQxfsKZHkbytHrLhop1s/IyPInf6z/zUt95PqeC26C/i/
         Q8hBWKPKilc9mea3+C0XoKKbtDz3qA0yY+zbLK4pfXGqpHArVNI908+P996p4T8ytvTR
         ev0co8lCp4EUjXfORrvdCvuKGMAMkUH5PAoDjl4RNRLVxvt1HCVh8UgC3VN3CtG3KDSM
         XHlmCb8brtXOwag2YHZoSsmBWKUvI+ah6Dq9VphBzmOIdOF9WVD6bcDyFIgvaN1Nf+eQ
         pBtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZrumOns4Uf4AoKTw/ZyLVUAqSGqE1r9+1NdUMQ8DBwGEqgIAm0K7ah0zRPB4WJGSvMPoKVWuxi1t8GEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvMmoNKXnsJ6NTcYtnA4B17NAh2XOzr+C30Mtl8BsdFYw0Jzm9
	c3jlo2wAOz7vW572+vqjzi+5CE6KZtCIuc4Us/Dgk6pziZjVOcm1dIRHYGooU+E=
X-Google-Smtp-Source: AGHT+IFwQKbF0uBw5pgFxMEyfaar+PEss1lta3c/RwRkh8twV305KiNARJFmDgSWlSUjiqJFzl3SXg==
X-Received: by 2002:a17:90a:c914:b0:2c8:af45:adb9 with SMTP id 98e67ed59e1d1-2cf24bde04cmr6059841a91.0.1722094736937;
        Sat, 27 Jul 2024 08:38:56 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cf28c7b092sm5464321a91.20.2024.07.27.08.38.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jul 2024 08:38:56 -0700 (PDT)
Message-ID: <93243310-22cf-4d44-810c-17629b46a33e@kernel.dk>
Date: Sat, 27 Jul 2024 09:38:54 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] minmax: reduce compilation time
From: Jens Axboe <axboe@kernel.dk>
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
 <f26b8167-ee81-413e-b48a-0469680fb768@kernel.dk>
Content-Language: en-US
In-Reply-To: <f26b8167-ee81-413e-b48a-0469680fb768@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/27/24 9:30 AM, Jens Axboe wrote:
> On 7/26/24 4:48 PM, Linus Torvalds wrote:
>> I didn't even look at what the issue was with the
>> bio_for_each_segment() expansion, in the hope that Jens will make that
>> one look better.
> 
> I did take a quick look, pretty obviously bvec_iter_bvec() which makes
> it horrible, which came from Kent's immutable work quite a while ago.
> Not sure yet what to do about it, will spend some time on this next
> week.

Maybe something like this, totally untested...

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index f41c7f0ef91e..9ccccddadde2 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -130,12 +130,15 @@ struct bvec_iter_all {
 	(mp_bvec_iter_page((bvec), (iter)) +			\
 	 mp_bvec_iter_page_idx((bvec), (iter)))
 
-#define bvec_iter_bvec(bvec, iter)				\
-((struct bio_vec) {						\
-	.bv_page	= bvec_iter_page((bvec), (iter)),	\
-	.bv_len		= bvec_iter_len((bvec), (iter)),	\
-	.bv_offset	= bvec_iter_offset((bvec), (iter)),	\
-})
+static inline struct bio_vec bvec_iter_bvec(struct bio_vec *bv,
+					    struct bvec_iter iter)
+{
+	return (struct bio_vec) {
+		.bv_page	= bvec_iter_page(bv, iter),
+		.bv_len		= bvec_iter_len(bv, iter),
+		.bv_offset	= bvec_iter_offset(bv, iter)
+	};
+}
 
 static inline bool bvec_iter_advance(const struct bio_vec *bv,
 		struct bvec_iter *iter, unsigned bytes)
 
-- 
Jens Axboe


