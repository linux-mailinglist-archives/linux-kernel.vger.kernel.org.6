Return-Path: <linux-kernel+bounces-511200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A371EA3278C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 14:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49DA4166839
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 13:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4AA20AF89;
	Wed, 12 Feb 2025 13:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLnewegc"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CB720E6F0
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 13:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739368258; cv=none; b=DwIGf5DYhbOicEba7irpbjss/9WzW/ZzavkKfLxOReDwt4S9I5v/K+hAQ2Sp3uTSCTDsGZz/sbbeK8M0viRrOYfSHT693qpC6TS6Mo0XsaS+1OYBmbtwkdIFgPF7JLZJhtJoKIcGqsOzcS8cYJBCpqSMj50kqDbj5WksrIHr8Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739368258; c=relaxed/simple;
	bh=asgl/Sq7YDI0/sYZPd5eTa+xqhiYBEIh+j4l1E3cu+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLLMhvhrU766J0vgPEwp194d9jMzQ2MTvD+WgLqLQglt0YFk4P2Q+L+wNc35Ez3INCZN0hqbPqT2KrpWVve9NORuv6OEKxtPWGIHEEvd6wwiRPzZLQtxb1YrLrUTyFwRRMP5MwuGjOZBNC3+BIcZwaMY6Fk87agD9YcnXaUWZSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLnewegc; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2f9d627b5fbso12792967a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 05:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739368256; x=1739973056; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YZ3hnTtby6jKrz+P3onA953fJBXcNCcxqscNrYLepyw=;
        b=mLnewegc47AS96i3dgnCs7SoxjEnY8xPmASyJmCvTSGFhawsuwJwIs8AkztfuySQ/w
         QqrKR+rE8keOz4s1UqSvz0YBul3pK+9xbbfY5ARz0phz5QgZIHqWaQI4FVn0S/wLKDcu
         djeWJjz9s9nWWOEhN6LdGSvPMBerpz6ygHvXw43ykhrOhYO1um4R0mDD8wJksthrr0CQ
         UdGtPvtnDFQWM8HV2dDaqVggz9ZUNGj6DA/MVdzCYn1C+5rHfmJ3g+9/HGEwEgL4g29k
         R8Bd/CGGjU2ntAh3VO5WqynIOg4D24U/jUgCEI/CYR/bmB1nQSBO6kInzDD7o63jxw/w
         AAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739368256; x=1739973056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZ3hnTtby6jKrz+P3onA953fJBXcNCcxqscNrYLepyw=;
        b=ocx0TPbX39eEtPt535e8snBB2qTYhYVcBSgz/xA9UTt4VUAIiR/V4PxWssayhyBSBZ
         wWbakE3rU4g9d8Brxb5PEDkeEqN7AWGpGujAX58eYEnSaVT2fhD8HbCeXgLQCZBCjsuR
         vM7Bqe0EeHnWtNyHB/9eJSAezcZMq739Rh2/V7fNJp5BB6NPpSiwrsxCe3Y5M3m5+IGz
         stFHfM4Ak5GsvqPz+2tVYrGh5pVfNJ3XQPGR4g6ZOqMffqKSbqwStnjK7awyv/JQXWOd
         rm6a4EYqAwkQjSsRAwmgwGbvxFYwFHbKva/9Oatm+cckVzVoQfxLQyhu2Gu4btyhCTCo
         Pv9w==
X-Forwarded-Encrypted: i=1; AJvYcCWgVQGdFl7Q5203pUDiY4FUDhynnRaVMpnjRWJVtWG3rPVCQmLDoVcqfuL/CfBahzT+UEiTiWZFZWWtH4k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yznxy2AsIlKty69UEnZ1VONbjDi1j5FOUA4dzWPP5LqsxnFOJ93
	qpzVWx5QRgyHVLXo74B1rwaJWkjR5vlLbgRY68+RnfQoyz/rHFbBXb+53SBA
X-Gm-Gg: ASbGnct2AJlTUDhXfrSHV+BoBJhOhHgtlMsVIRwB8j2KLW4gQCkXTXfUVzoeSnxPE2O
	g8KAd+bD5rHx2z7HNJOPq3JpSDU6Mc/gtsMttjwn0i6gDu7db8cYJ9/nsP9ut3BZ6MyhEwHkcWT
	QVkz6Z8YynUl0tK4KTOChyrSi9/pIPpsDQ8WsUlJxFPU0jwzqlpo8ZAv1+86eDP0X6N00WtUiNo
	eqpxLiblFBya0IK2SXO5IJxmBryoETPC9yZdqRAE7ywGsF1VNKyQovMkEBGmFW20eKdC/sfLI1K
	WFs/f7rxDhR+ft17AOeOzLbeopaL6RM=
X-Google-Smtp-Source: AGHT+IGzHDgbwxG+M/f41gvrb8D4yLMvAaHT/SXvhLxIMG0ISztJ0mYvnq6O2IfRtUvICgb5jhfflQ==
X-Received: by 2002:a17:90b:53cf:b0:2ea:a25d:3baa with SMTP id 98e67ed59e1d1-2fbf5bb924dmr4995382a91.5.1739368255643;
        Wed, 12 Feb 2025 05:50:55 -0800 (PST)
Received: from vaxr-BM6660-BM6360 ([2001:288:7001:2703:bc75:3c8b:62e:1d7d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf98cff80sm1495715a91.16.2025.02.12.05.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 05:50:55 -0800 (PST)
Date: Wed, 12 Feb 2025 21:50:50 +0800
From: I Hsin Cheng <richard120310@gmail.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: anshuman.khandual@arm.com, arnd@arndb.de, linux-kernel@vger.kernel.org,
	jserv@ccns.ncku.edu.tw, skhan@linuxfoundation.org
Subject: Re: [PATCH 1/2] uapi: Refactor __GENMASK() for speed-up
Message-ID: <Z6ynOre3V6FdYvkn@vaxr-BM6660-BM6360>
References: <20250211162412.477655-1-richard120310@gmail.com>
 <20250211162412.477655-2-richard120310@gmail.com>
 <Z6uZZPpQ9YYfrL-I@thinkpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6uZZPpQ9YYfrL-I@thinkpad>

On Tue, Feb 11, 2025 at 01:39:32PM -0500, Yury Norov wrote:
> On Wed, Feb 12, 2025 at 12:24:11AM +0800, I Hsin Cheng wrote:
> > The calculation of "((~_UL(0)) - (_UL(1) << (l)) + 1)" is to generate a
> > bitmask with "l" trailing zeroes, which is equivalent to
> > "(~_UL(0) << (l))".
> 
> I used to think that GENMASK() is a compile-time macro. __GENMASK() is
> not, but it has very limited usage through the kernel, all in the uapi.
>  
> > Refactor the calculation so the number of arithmetic instruction will be
> > reduced from 3 to 1.
> 
> I'd like to look at it! Please share disassembly.
> 
> > Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
> > ---
> > Test is done to show the speed-up we can get from reducing the number of
> > instruction. The test machine runs with 6.9.0-0-generic kernel on x86_64
> > architecture with processor AMD Ryzen 7 5700X3D 8-Core Processor.
> 
> So you CC arm maintainers and provide tests against x86_64. Are your
> improvements consistent for arm, power and other arches?
> 
> Can you run bloat-o-meter against your change?
> 
> > The test executes in the form of kernel module.
> > 
> > Test result:
> > [451675.644026] new __GENMASK() : 5985416
> > [451675.644030] old __GENMASK() : 6006406
> 
> The difference is 0.35%? That's impressive!
> 
> Can you please run your test multiple times and print those numbers
> together with confidence interval?
>  
> > Test script snippet:
> > /* switch to __BITS_PER_LONG_LONG when testing __GENMASK_ULL() */
> > \#define __GENMASK_NEW(h, l) \
> >         ((~_UL(0) << (l)) & \
> >          (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
> >
> > int init_module(void)
> > {
> >     ktime_t start, end, total1 = 0, total2 = 0;
> >     for (int k = 0; k < 100; k++) {
> >         for (int i = 0; i < __BITS_PER_LONG; i++) {
> >             for (int j = 0; j <= i; j++) {
> >                 unsigned result1, result2;
> > 
> >                 start = ktime_get();
> >                 result1 = __GENMASK_NEW(i, j);
> >                 end = ktime_get();
> >                 total1 += (end - start);
> 
> Nah, this is wrong. I feel like you measure performance of
> ktime_get() rather than GENMASK().
> 
> Do it this way:
> 
>         start = ktime_get();
>         for (...) {
>                 __always_used result = GENMASK();
>         }
>         time = ktime_get() - start;
> 
> 
> > 
> >                 start = ktime_get();
> >                 result2 = __GENMASK(i, j);
> 
> Please test GENMASK(), not __GENMASK().
> 
> >                 end = ktime_get();
> >                 total2 += (end - start);
> > 
> >                 if (result1 != result2) {
> >                     pr_info("Wrong calculation of GENMASK_NEW()\n");
> >                     return 0;
> >                 }
> 
> For functional testing we have lib/test_bits.c, lib/test_bitmap.c and
> others. I expect you'll run them all to check correctness. Once you do
> that, you don't need to test correctness here.
> 
> >             }
> >         }
> >     }
> > 
> >     pr_info("new __GENMASK() : %lld\n", total1);
> >     pr_info("old __GENMASK() : %lld\n", total2);
> > 
> >     return 0;
> > }
> 
> Please incorporate this in one of existing tests and prepend the
> series with it. That way you'll let the others to run before/after for
> your series.
> 
> > ---
> >  include/uapi/linux/bits.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/uapi/linux/bits.h b/include/uapi/linux/bits.h
> > index 5ee30f882736..8fc7fea65288 100644
> > --- a/include/uapi/linux/bits.h
> > +++ b/include/uapi/linux/bits.h
> > @@ -5,7 +5,7 @@
> >  #define _UAPI_LINUX_BITS_H
> >  
> >  #define __GENMASK(h, l) \
> > -        (((~_UL(0)) - (_UL(1) << (l)) + 1) & \
> > +	((~_UL(0) << (l)) & \
> >           (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
> 
> Now it would fit a single line, right?
> 
> If it works, this is a nice simplification, even though it's only a
> compile time thing.
> 
> Please address all the comments above and run low-level tests I
> mentioned above, so that we'll make sure it has no side effects.
> 
> Thanks,
> Yury
> 
> >  
> >  #define __GENMASK_ULL(h, l) \
> > -- 
> > 2.43.0


Hi Yury,

Thanks for your patience and detailed review!

> > Refactor the calculation so the number of arithmetic instruction will be
> > reduced from 3 to 1.
>
> I'd like to look at it! Please share disassembly.

What I am talking about here is current version has ("-", "<<", "+") as
operators and after the change there'll be only ("<<").
Though I don't think these 2 macro will have any differences in
assembly, because they're all evaluated to a number at compile time, I
can still test to see the result.

I wrote a function for simplicity and check the disassembly using objdump -d

void test_func() {
    int a = 10, b = 2;
    unsigned n = __GENMASK(a, b);
}

$objdump -d genmask_old
...
0000000000001129 <test_func>:
    1129:	f3 0f 1e fa          	endbr64
    112d:	55                   	push   %rbp
    112e:	48 89 e5             	mov    %rsp,%rbp
    1131:	c7 45 f4 0a 00 00 00 	movl   $0xa,-0xc(%rbp)
    1138:	c7 45 f8 02 00 00 00 	movl   $0x2,-0x8(%rbp)
    113f:	8b 45 f8             	mov    -0x8(%rbp),%eax
    1142:	ba 01 00 00 00       	mov    $0x1,%edx
    1147:	89 c1                	mov    %eax,%ecx
    1149:	48 d3 e2             	shl    %cl,%rdx
    114c:	48 89 d0             	mov    %rdx,%rax
    114f:	f7 d8                	neg    %eax
    1151:	89 c2                	mov    %eax,%edx
    1153:	b8 3f 00 00 00       	mov    $0x3f,%eax
    1158:	2b 45 f4             	sub    -0xc(%rbp),%eax
    115b:	48 c7 c6 ff ff ff ff 	mov    $0xffffffffffffffff,%rsi
    1162:	89 c1                	mov    %eax,%ecx
    1164:	48 d3 ee             	shr    %cl,%rsi
    1167:	48 89 f0             	mov    %rsi,%rax
    116a:	21 d0                	and    %edx,%eax
    116c:	89 45 fc             	mov    %eax,-0x4(%rbp)
    116f:	90                   	nop
    1170:	5d                   	pop    %rbp
    1171:	c3                   	ret
...

$objdump -d genmask_new
...
0000000000001129 <test_func>:
    1129:	f3 0f 1e fa          	endbr64
    112d:	55                   	push   %rbp
    112e:	48 89 e5             	mov    %rsp,%rbp
    1131:	c7 45 f4 0a 00 00 00 	movl   $0xa,-0xc(%rbp)
    1138:	c7 45 f8 02 00 00 00 	movl   $0x2,-0x8(%rbp)
    113f:	8b 45 f8             	mov    -0x8(%rbp),%eax
    1142:	48 c7 c2 ff ff ff ff 	mov    $0xffffffffffffffff,%rdx
    1149:	89 c1                	mov    %eax,%ecx
    114b:	48 d3 e2             	shl    %cl,%rdx
    114e:	48 89 d0             	mov    %rdx,%rax
    1151:	89 c2                	mov    %eax,%edx
    1153:	b8 3f 00 00 00       	mov    $0x3f,%eax
    1158:	2b 45 f4             	sub    -0xc(%rbp),%eax
    115b:	48 c7 c6 ff ff ff ff 	mov    $0xffffffffffffffff,%rsi
    1162:	89 c1                	mov    %eax,%ecx
    1164:	48 d3 ee             	shr    %cl,%rsi
    1167:	48 89 f0             	mov    %rsi,%rax
    116a:	21 d0                	and    %edx,%eax
    116c:	89 45 fc             	mov    %eax,-0x4(%rbp)
    116f:	90                   	nop
    1170:	5d                   	pop    %rbp
    1171:	c3                   	ret
...

> So you CC arm maintainers and provide tests against x86_64. Are your
> improvements consistent for arm, power and other arches?

I don't have available arm machines or others now, let me try to get them
and test.

> Nah, this is wrong. I feel like you measure performance of
> ktime_get() rather than GENMASK().
>
> Do it this way:

No problem, I rewrite the test like the following

    start = ktime_get();
    for (int k = 0; k < 1000; k++) {
        for (int i = 0; i < __BITS_PER_LONG_LONG; i++) {
            for (int j = 0; j <= i; j++) {
                unsigned result1;
                result1 = GENMASK(i, j);
            }
        }
    }
    end = ktime_get();

And here the result after running old version of GENMASK() and new
version of GENMASK(). Each running for 5 times.

[530775.667879] old GENMASK() : 60
[530811.687541] old GENMASK() : 60
[530824.527262] old GENMASK() : 50
[530826.583092] old GENMASK() : 40
[530831.487851] old GENMASK() : 50
[530893.618084] new GENMASK() : 50
[530897.734948] new GENMASK() : 50
[530900.253968] new GENMASK() : 50
[530902.415798] new GENMASK() : 40
[530904.136347] new GENMASK() : 50

On avgerage, old version of GENMASK() cost 52 time unit, new version of
GENMASK() costs 48 time unit.

> Please incorporate this in one of existing tests and prepend the
> series with it. That way you'll let the others to run before/after for
> your series.

> Now it would fit a single line, right?
>
> If it works, this is a nice simplification, even though it's only a
> compile time thing.
>
> Please address all the comments above and run low-level tests I
> mentioned above, so that we'll make sure it has no side effects.

Sure thing, I'll append the corresponding test into existing tests and
perform all the test again, though for different machine architecture
parts could be hard for me, I only have x86 machine now, I think I can
get an arm machine, but can't sure for other architectures.

I'll try to prepare everything as possible as I can and send v2. Thanks.

Best regards,
I Hsin Cheng.



