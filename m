Return-Path: <linux-kernel+bounces-227005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADC891470D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 12:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D2901C22203
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73708136E17;
	Mon, 24 Jun 2024 10:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cot4bJqO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB8A1369AF
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 10:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719223587; cv=none; b=Q9uQcjzw8FwKJnrfjA2R/xSW9uF0uzFXU8+SW63AlHntPRphmP6IbMMmXDU5itfUAfp9Dy9NnV3Oluukj5wpRomZfD9J7kAUsnYYBkPTyO0PM5cQS7OzeGMQA1uhDpbVFNqopU4m98CQGiGH0/ZLXUCc4DaZJey2gPBofjoWLtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719223587; c=relaxed/simple;
	bh=kC0KxY1SOanbHb1h55y9chmZJBgDMtmjItEPmlIWC0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XT6g120kFWlYq990KmO0vwsDO+j3OO1M9MJoYbATmODTOOYRQ2Lskv6EdA5OoFmNRf9wrqJacOuair699XUUmzQ8m2ibxoM4bph+lUYLlCs5TTiBHakkum63mqhQVlq5/gw6iTkPaxJa6wuSK4tlWzpiAwv/Y2sKJvA5n5xO7NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cot4bJqO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85257C4AF11
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 10:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719223586;
	bh=kC0KxY1SOanbHb1h55y9chmZJBgDMtmjItEPmlIWC0Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cot4bJqOSPGeAV1VC/WAebkbLRlVOEjYDtOYNDe4ohr3+wuvFa5TBrdEAljYQgLNR
	 KYzC6yCJL4o7x0vFtZ6iq64kEHBj6VhhuLZ91KI08ja6UqhSZToNbiSjONXn3YUe6S
	 viPfHTrA1N7Kw1x4w6ESMekzPu+E4NoxaAOMD9plJ0TUOm7Cg+xcrwGl07GG5Pp9wO
	 MMScL5f0WxUV7Y/nPD8JKgs6lUYHqrj6VCRUXAN+MLq4Yt5Nn0v6Y4Q4ee/ob1BFxm
	 6rb3EaZJ8m8syZ3s0EMKuTYIB11X2FTH9MiwW9n1B5SQ35zL+J4VdKjqRQgvKt4t3h
	 ulvDdZMyutecg==
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3737dc4a669so16481495ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 03:06:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWeYqgLZQoTtY+ZUXnFDac3SPiLU6j4gyi2xEEAGOMmIqF+1p8frd1JcXdCHIwx4QRjmZ1MpzHTAIKKyeSDrzjiVNB/3S2m4HINiw25
X-Gm-Message-State: AOJu0YxnTepwv8m7RJkwND3adS1bDE3ksZIwPnmAlnJxf/6eH/l4/Hku
	wyrzAoso0O/qpTtLHHyvYhLck1rCm7LUiKQbka0QnzWrhtHWcIXyE2ujZKhp/Aj3wvEyu9qSgOX
	v6nFSvE1mz78GFbWNhEdxR4ffPFmvChwYfqsh
X-Google-Smtp-Source: AGHT+IGUkvMr1/qVRpOSOfUFRmfZgUwqvSbTs2uWsBrnJ3Ud5NON6uZ1HMtBNFiojnUG+BOkXHZvHRKGRpB7GXb+4ZE=
X-Received: by 2002:a05:6e02:20e8:b0:375:ea33:1120 with SMTP id
 e9e14a558f8ab-3763f5ca1cbmr54610005ab.2.1719223585503; Mon, 24 Jun 2024
 03:06:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240622071231.576056-1-21cnbao@gmail.com>
In-Reply-To: <20240622071231.576056-1-21cnbao@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Mon, 24 Jun 2024 03:06:13 -0700
X-Gmail-Original-Message-ID: <CAF8kJuMeorg8xa03X9DAKiCWr5UKCLWjqdYSyJmPpARb5K9dJA@mail.gmail.com>
Message-ID: <CAF8kJuMeorg8xa03X9DAKiCWr5UKCLWjqdYSyJmPpARb5K9dJA@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] tools/mm: Introduce a tool to assess swap entry
 allocation for thp_swapout
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, ryan.roberts@arm.com, 
	david@redhat.com, hughd@google.com, kaleshsingh@google.com, 
	kasong@tencent.com, linux-kernel@vger.kernel.org, v-songbaohua@oppo.com, 
	ying.huang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 22, 2024 at 12:12=E2=80=AFAM Barry Song <21cnbao@gmail.com> wro=
te:
>
> From: Barry Song <v-songbaohua@oppo.com>
>
> -v2:
>  * add swap-in which can either be aligned or not aligned, by "-a";
>    Ying;
>  * move the program to tools/mm; Ryan;
>  * try to simulate the scenarios swap is full. Chris;
>
> -v1:
>  https://lore.kernel.org/linux-mm/20240620002648.75204-1-21cnbao@gmail.co=
m/
>
> I tested Ryan's RFC patchset[1] and Chris's v3[2] using this v2 tool:
> [1] https://lore.kernel.org/linux-mm/20240618232648.4090299-1-ryan.robert=
s@arm.com/
> [2] https://lore.kernel.org/linux-mm/20240614-swap-allocator-v2-0-2a513b4=
a7f2f@kernel.org/
>
> Obviously, we're rarely hitting 100% even in the worst case without "-a" =
and with
> "-s," which is good news!
> If swapin is aligned w/ "-a" and w/o "-s", both Chris's and Ryan's patche=
s show
> a low fallback ratio though Chris's has the numbers above 0% but Ryan's a=
re 0%
> (value A).
>
> The bad news is that unaligned swapin can significantly increase the fall=
back ratio,
> reaching up to 85% for Ryan's patch and 95% for Chris's patchset without =
"-s." Both
> approaches approach 100% without "-a" and with "-s" (value B).
>
> I believe real workloads should yield a value between A and B. Without "-=
a," and
> lacking large folios swap-in, this tool randomly swaps in small folios wi=
thout
> considering spatial locality, which is a factor present in real workloads=
. This
> typically results in values higher than A and lower than B.
>
> Based on the below results, I believe that:
> 1. We truly require large folio swap-in to achieve comparable results wit=
h
> aligned swap-in(based on the result w/o and w/ "-a")
> 2. We need a method to prevent small folios from scattering indiscriminat=
ely
> (based on the result "-a -s")
>
> *
> *  Test results on Ryan's patchset:
> *
>
> 1. w/ -a
> ./thp_swap_allocator_test -a
> Iteration 1: swpout inc: 224, swpout fallback inc: 0, Fallback percentage=
: 0.00%
> Iteration 2: swpout inc: 231, swpout fallback inc: 0, Fallback percentage=
: 0.00%
> Iteration 3: swpout inc: 227, swpout fallback inc: 0, Fallback percentage=
: 0.00%
> Iteration 4: swpout inc: 222, swpout fallback inc: 0, Fallback percentage=
: 0.00%
> ...
> Iteration 100: swpout inc: 228, swpout fallback inc: 0, Fallback percenta=
ge: 0.00%
>
> 2. w/o -a
> ./thp_swap_allocator_test
>
> Iteration 1: swpout inc: 208, swpout fallback inc: 25, Fallback percentag=
e: 10.73%
> Iteration 2: swpout inc: 118, swpout fallback inc: 114, Fallback percenta=
ge: 49.14%
> Iteration 3: swpout inc: 63, swpout fallback inc: 163, Fallback percentag=
e: 72.12%
> Iteration 4: swpout inc: 45, swpout fallback inc: 178, Fallback percentag=
e: 79.82%
> Iteration 5: swpout inc: 42, swpout fallback inc: 184, Fallback percentag=
e: 81.42%
> Iteration 6: swpout inc: 31, swpout fallback inc: 193, Fallback percentag=
e: 86.16%
> Iteration 7: swpout inc: 27, swpout fallback inc: 201, Fallback percentag=
e: 88.16%
> Iteration 8: swpout inc: 30, swpout fallback inc: 198, Fallback percentag=
e: 86.84%
> Iteration 9: swpout inc: 32, swpout fallback inc: 194, Fallback percentag=
e: 85.84%
> ...
> Iteration 91: swpout inc: 26, swpout fallback inc: 194, Fallback percenta=
ge: 88.18%
> Iteration 92: swpout inc: 35, swpout fallback inc: 196, Fallback percenta=
ge: 84.85%
> Iteration 93: swpout inc: 33, swpout fallback inc: 191, Fallback percenta=
ge: 85.27%
> Iteration 94: swpout inc: 26, swpout fallback inc: 193, Fallback percenta=
ge: 88.13%
> Iteration 95: swpout inc: 39, swpout fallback inc: 189, Fallback percenta=
ge: 82.89%
> Iteration 96: swpout inc: 28, swpout fallback inc: 196, Fallback percenta=
ge: 87.50%
> Iteration 97: swpout inc: 25, swpout fallback inc: 194, Fallback percenta=
ge: 88.58%
> Iteration 98: swpout inc: 31, swpout fallback inc: 196, Fallback percenta=
ge: 86.34%
> Iteration 99: swpout inc: 32, swpout fallback inc: 202, Fallback percenta=
ge: 86.32%
> Iteration 100: swpout inc: 33, swpout fallback inc: 195, Fallback percent=
age: 85.53%
>
> 3. w/ -a and -s
> ./thp_swap_allocator_test -a -s
> Iteration 1: swpout inc: 224, swpout fallback inc: 0, Fallback percentage=
: 0.00%
> Iteration 2: swpout inc: 218, swpout fallback inc: 0, Fallback percentage=
: 0.00%
> Iteration 3: swpout inc: 222, swpout fallback inc: 0, Fallback percentage=
: 0.00%
> Iteration 4: swpout inc: 220, swpout fallback inc: 6, Fallback percentage=
: 2.65%
> Iteration 5: swpout inc: 206, swpout fallback inc: 16, Fallback percentag=
e: 7.21%
> Iteration 6: swpout inc: 233, swpout fallback inc: 0, Fallback percentage=
: 0.00%
> Iteration 7: swpout inc: 224, swpout fallback inc: 0, Fallback percentage=
: 0.00%
> Iteration 8: swpout inc: 228, swpout fallback inc: 0, Fallback percentage=
: 0.00%
> Iteration 9: swpout inc: 217, swpout fallback inc: 0, Fallback percentage=
: 0.00%
> Iteration 10: swpout inc: 224, swpout fallback inc: 3, Fallback percentag=
e: 1.32%
> Iteration 11: swpout inc: 211, swpout fallback inc: 12, Fallback percenta=
ge: 5.38%
> Iteration 12: swpout inc: 200, swpout fallback inc: 32, Fallback percenta=
ge: 13.79%
> Iteration 13: swpout inc: 189, swpout fallback inc: 29, Fallback percenta=
ge: 13.30%
> Iteration 14: swpout inc: 195, swpout fallback inc: 31, Fallback percenta=
ge: 13.72%
> Iteration 15: swpout inc: 198, swpout fallback inc: 27, Fallback percenta=
ge: 12.00%
> Iteration 16: swpout inc: 201, swpout fallback inc: 17, Fallback percenta=
ge: 7.80%
> Iteration 17: swpout inc: 206, swpout fallback inc: 6, Fallback percentag=
e: 2.83%
> Iteration 18: swpout inc: 220, swpout fallback inc: 14, Fallback percenta=
ge: 5.98%
> Iteration 19: swpout inc: 181, swpout fallback inc: 45, Fallback percenta=
ge: 19.91%
> Iteration 20: swpout inc: 223, swpout fallback inc: 8, Fallback percentag=
e: 3.46%
> Iteration 21: swpout inc: 214, swpout fallback inc: 14, Fallback percenta=
ge: 6.14%
> Iteration 22: swpout inc: 195, swpout fallback inc: 31, Fallback percenta=
ge: 13.72%
> Iteration 23: swpout inc: 223, swpout fallback inc: 0, Fallback percentag=
e: 0.00%
> Iteration 24: swpout inc: 233, swpout fallback inc: 0, Fallback percentag=
e: 0.00%
> Iteration 25: swpout inc: 214, swpout fallback inc: 1, Fallback percentag=
e: 0.47%
> Iteration 26: swpout inc: 229, swpout fallback inc: 1, Fallback percentag=
e: 0.43%
> Iteration 27: swpout inc: 214, swpout fallback inc: 5, Fallback percentag=
e: 2.28%
> Iteration 28: swpout inc: 211, swpout fallback inc: 15, Fallback percenta=
ge: 6.64%
> Iteration 29: swpout inc: 188, swpout fallback inc: 40, Fallback percenta=
ge: 17.54%
> Iteration 30: swpout inc: 207, swpout fallback inc: 18, Fallback percenta=
ge: 8.00%
> Iteration 31: swpout inc: 215, swpout fallback inc: 10, Fallback percenta=
ge: 4.44%
> Iteration 32: swpout inc: 202, swpout fallback inc: 22, Fallback percenta=
ge: 9.82%
> Iteration 33: swpout inc: 223, swpout fallback inc: 0, Fallback percentag=
e: 0.00%
> Iteration 34: swpout inc: 218, swpout fallback inc: 10, Fallback percenta=
ge: 4.39%
> Iteration 35: swpout inc: 203, swpout fallback inc: 30, Fallback percenta=
ge: 12.88%
> Iteration 36: swpout inc: 214, swpout fallback inc: 14, Fallback percenta=
ge: 6.14%
> Iteration 37: swpout inc: 211, swpout fallback inc: 14, Fallback percenta=
ge: 6.22%
> Iteration 38: swpout inc: 193, swpout fallback inc: 28, Fallback percenta=
ge: 12.67%
> Iteration 39: swpout inc: 210, swpout fallback inc: 20, Fallback percenta=
ge: 8.70%
> Iteration 40: swpout inc: 223, swpout fallback inc: 5, Fallback percentag=
e: 2.19%
> Iteration 41: swpout inc: 224, swpout fallback inc: 7, Fallback percentag=
e: 3.03%
> Iteration 42: swpout inc: 200, swpout fallback inc: 23, Fallback percenta=
ge: 10.31%
> Iteration 43: swpout inc: 217, swpout fallback inc: 5, Fallback percentag=
e: 2.25%
> Iteration 44: swpout inc: 206, swpout fallback inc: 18, Fallback percenta=
ge: 8.04%
> Iteration 45: swpout inc: 210, swpout fallback inc: 11, Fallback percenta=
ge: 4.98%
> Iteration 46: swpout inc: 204, swpout fallback inc: 19, Fallback percenta=
ge: 8.52%
> Iteration 47: swpout inc: 228, swpout fallback inc: 0, Fallback percentag=
e: 0.00%
> Iteration 48: swpout inc: 219, swpout fallback inc: 2, Fallback percentag=
e: 0.90%
> Iteration 49: swpout inc: 212, swpout fallback inc: 6, Fallback percentag=
e: 2.75%
> Iteration 50: swpout inc: 207, swpout fallback inc: 15, Fallback percenta=
ge: 6.76%
> Iteration 51: swpout inc: 190, swpout fallback inc: 36, Fallback percenta=
ge: 15.93%
> Iteration 52: swpout inc: 212, swpout fallback inc: 17, Fallback percenta=
ge: 7.42%
> Iteration 53: swpout inc: 179, swpout fallback inc: 43, Fallback percenta=
ge: 19.37%
> Iteration 54: swpout inc: 225, swpout fallback inc: 0, Fallback percentag=
e: 0.00%
> Iteration 55: swpout inc: 224, swpout fallback inc: 2, Fallback percentag=
e: 0.88%
> Iteration 56: swpout inc: 220, swpout fallback inc: 8, Fallback percentag=
e: 3.51%
> Iteration 57: swpout inc: 203, swpout fallback inc: 25, Fallback percenta=
ge: 10.96%
> Iteration 58: swpout inc: 213, swpout fallback inc: 6, Fallback percentag=
e: 2.74%
> Iteration 59: swpout inc: 207, swpout fallback inc: 18, Fallback percenta=
ge: 8.00%
> Iteration 60: swpout inc: 216, swpout fallback inc: 14, Fallback percenta=
ge: 6.09%
> Iteration 61: swpout inc: 183, swpout fallback inc: 34, Fallback percenta=
ge: 15.67%
> Iteration 62: swpout inc: 184, swpout fallback inc: 39, Fallback percenta=
ge: 17.49%
> Iteration 63: swpout inc: 184, swpout fallback inc: 39, Fallback percenta=
ge: 17.49%
> Iteration 64: swpout inc: 210, swpout fallback inc: 15, Fallback percenta=
ge: 6.67%
> Iteration 65: swpout inc: 178, swpout fallback inc: 48, Fallback percenta=
ge: 21.24%
> Iteration 66: swpout inc: 188, swpout fallback inc: 30, Fallback percenta=
ge: 13.76%
> Iteration 67: swpout inc: 193, swpout fallback inc: 29, Fallback percenta=
ge: 13.06%
> Iteration 68: swpout inc: 202, swpout fallback inc: 22, Fallback percenta=
ge: 9.82%
> Iteration 69: swpout inc: 213, swpout fallback inc: 5, Fallback percentag=
e: 2.29%
> Iteration 70: swpout inc: 204, swpout fallback inc: 15, Fallback percenta=
ge: 6.85%
> Iteration 71: swpout inc: 180, swpout fallback inc: 45, Fallback percenta=
ge: 20.00%
> Iteration 72: swpout inc: 210, swpout fallback inc: 21, Fallback percenta=
ge: 9.09%
> Iteration 73: swpout inc: 216, swpout fallback inc: 7, Fallback percentag=
e: 3.14%
> Iteration 74: swpout inc: 209, swpout fallback inc: 19, Fallback percenta=
ge: 8.33%
> Iteration 75: swpout inc: 222, swpout fallback inc: 7, Fallback percentag=
e: 3.06%
> Iteration 76: swpout inc: 212, swpout fallback inc: 14, Fallback percenta=
ge: 6.19%
> Iteration 77: swpout inc: 188, swpout fallback inc: 41, Fallback percenta=
ge: 17.90%
> Iteration 78: swpout inc: 198, swpout fallback inc: 17, Fallback percenta=
ge: 7.91%
> Iteration 79: swpout inc: 209, swpout fallback inc: 16, Fallback percenta=
ge: 7.11%
> Iteration 80: swpout inc: 182, swpout fallback inc: 41, Fallback percenta=
ge: 18.39%
> Iteration 81: swpout inc: 217, swpout fallback inc: 1, Fallback percentag=
e: 0.46%
> Iteration 82: swpout inc: 225, swpout fallback inc: 3, Fallback percentag=
e: 1.32%
> Iteration 83: swpout inc: 222, swpout fallback inc: 8, Fallback percentag=
e: 3.48%
> Iteration 84: swpout inc: 201, swpout fallback inc: 21, Fallback percenta=
ge: 9.46%
> Iteration 85: swpout inc: 211, swpout fallback inc: 3, Fallback percentag=
e: 1.40%
> Iteration 86: swpout inc: 209, swpout fallback inc: 14, Fallback percenta=
ge: 6.28%
> Iteration 87: swpout inc: 181, swpout fallback inc: 42, Fallback percenta=
ge: 18.83%
> Iteration 88: swpout inc: 223, swpout fallback inc: 4, Fallback percentag=
e: 1.76%
> Iteration 89: swpout inc: 214, swpout fallback inc: 14, Fallback percenta=
ge: 6.14%
> Iteration 90: swpout inc: 192, swpout fallback inc: 33, Fallback percenta=
ge: 14.67%
> Iteration 91: swpout inc: 184, swpout fallback inc: 31, Fallback percenta=
ge: 14.42%
> Iteration 92: swpout inc: 201, swpout fallback inc: 32, Fallback percenta=
ge: 13.73%
> Iteration 93: swpout inc: 181, swpout fallback inc: 40, Fallback percenta=
ge: 18.10%
> Iteration 94: swpout inc: 211, swpout fallback inc: 14, Fallback percenta=
ge: 6.22%
> Iteration 95: swpout inc: 198, swpout fallback inc: 25, Fallback percenta=
ge: 11.21%
> Iteration 96: swpout inc: 205, swpout fallback inc: 22, Fallback percenta=
ge: 9.69%
> Iteration 97: swpout inc: 218, swpout fallback inc: 12, Fallback percenta=
ge: 5.22%
> Iteration 98: swpout inc: 203, swpout fallback inc: 25, Fallback percenta=
ge: 10.96%
> Iteration 99: swpout inc: 218, swpout fallback inc: 12, Fallback percenta=
ge: 5.22%
> Iteration 100: swpout inc: 195, swpout fallback inc: 34, Fallback percent=
age: 14.85%
>
> 4. w/o -a and w/ -s
> thp_swap_allocator_test  -s
> Iteration 1: swpout inc: 173, swpout fallback inc: 60, Fallback percentag=
e: 25.75%
> Iteration 2: swpout inc: 85, swpout fallback inc: 147, Fallback percentag=
e: 63.36%
> Iteration 3: swpout inc: 39, swpout fallback inc: 195, Fallback percentag=
e: 83.33%
> Iteration 4: swpout inc: 13, swpout fallback inc: 220, Fallback percentag=
e: 94.42%
> Iteration 5: swpout inc: 10, swpout fallback inc: 215, Fallback percentag=
e: 95.56%
> Iteration 6: swpout inc: 9, swpout fallback inc: 219, Fallback percentage=
: 96.05%
> Iteration 7: swpout inc: 6, swpout fallback inc: 217, Fallback percentage=
: 97.31%
> Iteration 8: swpout inc: 6, swpout fallback inc: 215, Fallback percentage=
: 97.29%
> Iteration 9: swpout inc: 0, swpout fallback inc: 225, Fallback percentage=
: 100.00%
> Iteration 10: swpout inc: 1, swpout fallback inc: 229, Fallback percentag=
e: 99.57%
> Iteration 11: swpout inc: 2, swpout fallback inc: 216, Fallback percentag=
e: 99.08%
> Iteration 12: swpout inc: 2, swpout fallback inc: 229, Fallback percentag=
e: 99.13%
> Iteration 13: swpout inc: 4, swpout fallback inc: 211, Fallback percentag=
e: 98.14%
> Iteration 14: swpout inc: 1, swpout fallback inc: 221, Fallback percentag=
e: 99.55%
> Iteration 15: swpout inc: 2, swpout fallback inc: 223, Fallback percentag=
e: 99.11%
> Iteration 16: swpout inc: 3, swpout fallback inc: 224, Fallback percentag=
e: 98.68%
> Iteration 17: swpout inc: 2, swpout fallback inc: 231, Fallback percentag=
e: 99.14%
> ...
>
> *
> *  Test results on Chris's v3 patchset:
> *


> 1. w/ -a
> ./thp_swap_allocator_test -a
> Iteration 1: swpout inc: 224, swpout fallback inc: 0, Fallback percentage=
: 0.00%
> Iteration 2: swpout inc: 231, swpout fallback inc: 0, Fallback percentage=
: 0.00%
> Iteration 3: swpout inc: 227, swpout fallback inc: 0, Fallback percentage=
: 0.00%
> Iteration 4: swpout inc: 217, swpout fallback inc: 5, Fallback percentage=
: 2.25%
> Iteration 5: swpout inc: 215, swpout fallback inc: 12, Fallback percentag=
e: 5.29%
> Iteration 6: swpout inc: 213, swpout fallback inc: 14, Fallback percentag=
e: 6.17%
> Iteration 7: swpout inc: 207, swpout fallback inc: 15, Fallback percentag=
e: 6.76%
> Iteration 8: swpout inc: 193, swpout fallback inc: 33, Fallback percentag=
e: 14.60%
> Iteration 9: swpout inc: 214, swpout fallback inc: 13, Fallback percentag=
e: 5.73%
> Iteration 10: swpout inc: 199, swpout fallback inc: 25, Fallback percenta=
ge: 11.16%
> Iteration 11: swpout inc: 208, swpout fallback inc: 14, Fallback percenta=
ge: 6.31%
> Iteration 12: swpout inc: 203, swpout fallback inc: 31, Fallback percenta=
ge: 13.25%
> Iteration 13: swpout inc: 192, swpout fallback inc: 25, Fallback percenta=
ge: 11.52%
> Iteration 14: swpout inc: 193, swpout fallback inc: 36, Fallback percenta=
ge: 15.72%
> Iteration 15: swpout inc: 188, swpout fallback inc: 33, Fallback percenta=
ge: 14.93%

My working in progress allocator patch:
linux# ../thp_swap_allocator_test -a
Iteration 1: swpout inc: 224, swpout fallback inc: 0, Fallback percentage: =
0.00%
Iteration 2: swpout inc: 231, swpout fallback inc: 0, Fallback percentage: =
0.00%
Iteration 3: swpout inc: 227, swpout fallback inc: 0, Fallback percentage: =
0.00%
Iteration 4: swpout inc: 222, swpout fallback inc: 0, Fallback percentage: =
0.00%
Iteration 5: swpout inc: 227, swpout fallback inc: 0, Fallback percentage: =
0.00%
Iteration 6: swpout inc: 227, swpout fallback inc: 0, Fallback percentage: =
0.00%
Iteration 7: swpout inc: 222, swpout fallback inc: 0, Fallback percentage: =
0.00%
Iteration 8: swpout inc: 226, swpout fallback inc: 0, Fallback percentage: =
0.00%
Iteration 9: swpout inc: 227, swpout fallback inc: 0, Fallback percentage: =
0.00%
Iteration 10: swpout inc: 224, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 11: swpout inc: 222, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 12: swpout inc: 234, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 13: swpout inc: 217, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 14: swpout inc: 229, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 15: swpout inc: 221, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 16: swpout inc: 223, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 17: swpout inc: 232, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 18: swpout inc: 225, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 19: swpout inc: 218, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 20: swpout inc: 227, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 21: swpout inc: 219, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 22: swpout inc: 225, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 23: swpout inc: 228, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 24: swpout inc: 227, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 25: swpout inc: 212, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 26: swpout inc: 224, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 27: swpout inc: 218, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 28: swpout inc: 226, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 29: swpout inc: 222, swpout fallback inc: 0, Fallback
percentage: 0.00%
...
Fall back zero between.
...
Iteration 78: swpout inc: 224, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 79: swpout inc: 222, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 80: swpout inc: 230, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 81: swpout inc: 224, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 82: swpout inc: 221, swpout fallback inc: 5, Fallback
percentage: 2.21%
Iteration 83: swpout inc: 221, swpout fallback inc: 2, Fallback
percentage: 0.90%
Iteration 84: swpout inc: 230, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 85: swpout inc: 228, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 86: swpout inc: 219, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 87: swpout inc: 223, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 88: swpout inc: 225, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 89: swpout inc: 232, swpout fallback inc: 1, Fallback
percentage: 0.43%
Iteration 90: swpout inc: 222, swpout fallback inc: 5, Fallback
percentage: 2.20%
Iteration 91: swpout inc: 217, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 92: swpout inc: 229, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 93: swpout inc: 220, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 94: swpout inc: 223, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 95: swpout inc: 224, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 96: swpout inc: 226, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 97: swpout inc: 226, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 98: swpout inc: 224, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 99: swpout inc: 215, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 100: swpout inc: 222, swpout fallback inc: 0, Fallback
percentage: 0.00%

Occasionally I can get a full 0.00% run, the above is more typical.


> ...
>
> It seems Chris's approach can be negatively affected even by aligned swap=
in,
> having a low fallback ratio but not 0% while Ryan's patchset hasn't this
> issue.
>
> 2. w/o -a
> ./thp_swap_allocator_test

My WIP patch:
linux# ../thp_swap_allocator_test
Iteration 1: swpout inc: 233, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 2: swpout inc: 146, swpout fallback inc: 86, Fallback
percentage: 37.07%
Iteration 3: swpout inc: 75, swpout fallback inc: 151, Fallback
percentage: 66.81%
Iteration 4: swpout inc: 52, swpout fallback inc: 171, Fallback
percentage: 76.68%
Iteration 5: swpout inc: 47, swpout fallback inc: 179, Fallback
percentage: 79.20%
Iteration 6: swpout inc: 40, swpout fallback inc: 184, Fallback
percentage: 82.14%
Iteration 7: swpout inc: 40, swpout fallback inc: 188, Fallback
percentage: 82.46%
Iteration 8: swpout inc: 39, swpout fallback inc: 189, Fallback
percentage: 82.89%
Iteration 9: swpout inc: 38, swpout fallback inc: 188, Fallback
percentage: 83.19%
Iteration 10: swpout inc: 41, swpout fallback inc: 187, Fallback
percentage: 82.02%
Iteration 11: swpout inc: 32, swpout fallback inc: 197, Fallback
percentage: 86.03%
Iteration 12: swpout inc: 31, swpout fallback inc: 189, Fallback
percentage: 85.91%
Iteration 13: swpout inc: 31, swpout fallback inc: 197, Fallback
percentage: 86.40%
Iteration 14: swpout inc: 29, swpout fallback inc: 195, Fallback
percentage: 87.05%
Iteration 15: swpout inc: 32, swpout fallback inc: 194, Fallback
percentage: 85.84%
Iteration 16: swpout inc: 25, swpout fallback inc: 190, Fallback
percentage: 88.37%
Iteration 17: swpout inc: 31, swpout fallback inc: 198, Fallback
percentage: 86.46%
Iteration 18: swpout inc: 27, swpout fallback inc: 200, Fallback
percentage: 88.11%
Iteration 19: swpout inc: 29, swpout fallback inc: 189, Fallback
percentage: 86.70%
Iteration 20: swpout inc: 26, swpout fallback inc: 194, Fallback
percentage: 88.18%
Iteration 21: swpout inc: 24, swpout fallback inc: 201, Fallback
percentage: 89.33%
Iteration 22: swpout inc: 28, swpout fallback inc: 202, Fallback
percentage: 87.83%
Iteration 23: swpout inc: 31, swpout fallback inc: 198, Fallback
percentage: 86.46%
Iteration 24: swpout inc: 32, swpout fallback inc: 194, Fallback
percentage: 85.84%
Iteration 25: swpout inc: 30, swpout fallback inc: 199, Fallback
percentage: 86.90%
Iteration 26: swpout inc: 38, swpout fallback inc: 193, Fallback
percentage: 83.55%
Iteration 27: swpout inc: 28, swpout fallback inc: 195, Fallback
percentage: 87.44%
Iteration 28: swpout inc: 29, swpout fallback inc: 195, Fallback
percentage: 87.05%
Iteration 29: swpout inc: 34, swpout fallback inc: 191, Fallback
percentage: 84.89%
Iteration 30: swpout inc: 28, swpout fallback inc: 195, Fallback
percentage: 87.44%
Iteration 31: swpout inc: 36, swpout fallback inc: 184, Fallback
percentage: 83.64%
Iteration 32: swpout inc: 38, swpout fallback inc: 187, Fallback
percentage: 83.11%
Iteration 33: swpout inc: 37, swpout fallback inc: 192, Fallback
percentage: 83.84%
Iteration 34: swpout inc: 39, swpout fallback inc: 191, Fallback
percentage: 83.04%
Iteration 35: swpout inc: 30, swpout fallback inc: 197, Fallback
percentage: 86.78%
Iteration 36: swpout inc: 34, swpout fallback inc: 195, Fallback
percentage: 85.15%
Iteration 37: swpout inc: 35, swpout fallback inc: 182, Fallback
percentage: 83.87%
Iteration 38: swpout inc: 29, swpout fallback inc: 196, Fallback
percentage: 87.11%
Iteration 39: swpout inc: 33, swpout fallback inc: 190, Fallback
percentage: 85.20%
Iteration 40: swpout inc: 33, swpout fallback inc: 184, Fallback
percentage: 84.79%
Iteration 41: swpout inc: 30, swpout fallback inc: 188, Fallback
percentage: 86.24%
Iteration 42: swpout inc: 35, swpout fallback inc: 190, Fallback
percentage: 84.44%
Iteration 43: swpout inc: 30, swpout fallback inc: 193, Fallback
percentage: 86.55%

> Iteration 1: swpout inc: 209, swpout fallback inc: 24, Fallback percentag=
e: 10.30%
> Iteration 2: swpout inc: 100, swpout fallback inc: 132, Fallback percenta=
ge: 56.90%
> Iteration 3: swpout inc: 43, swpout fallback inc: 183, Fallback percentag=
e: 80.97%
> Iteration 4: swpout inc: 30, swpout fallback inc: 193, Fallback percentag=
e: 86.55%
> Iteration 5: swpout inc: 21, swpout fallback inc: 205, Fallback percentag=
e: 90.71%
> Iteration 6: swpout inc: 10, swpout fallback inc: 214, Fallback percentag=
e: 95.54%
> Iteration 7: swpout inc: 16, swpout fallback inc: 212, Fallback percentag=
e: 92.98%
> Iteration 8: swpout inc: 9, swpout fallback inc: 219, Fallback percentage=
: 96.05%
> Iteration 9: swpout inc: 6, swpout fallback inc: 220, Fallback percentage=
: 97.35%
> Iteration 10: swpout inc: 7, swpout fallback inc: 221, Fallback percentag=
e: 96.93%
> Iteration 11: swpout inc: 7, swpout fallback inc: 222, Fallback percentag=
e: 96.94%
> Iteration 12: swpout inc: 8, swpout fallback inc: 212, Fallback percentag=
e: 96.36%
> ..
>
> Ryan's fallback ratio(around 85%) seems to be a little better while both =
are much
> worse than "-a".
>
> 3. w/ -a and -s
> ./thp_swap_allocator_test -a -s

My WIP patch:
linux# ../thp_swap_allocator_test -a -s
Iteration 1: swpout inc: 224, swpout fallback inc: 0, Fallback percentage: =
0.00%
Iteration 2: swpout inc: 218, swpout fallback inc: 0, Fallback percentage: =
0.00%
Iteration 3: swpout inc: 222, swpout fallback inc: 0, Fallback percentage: =
0.00%
Iteration 4: swpout inc: 226, swpout fallback inc: 0, Fallback percentage: =
0.00%
Iteration 5: swpout inc: 222, swpout fallback inc: 0, Fallback percentage: =
0.00%
Iteration 6: swpout inc: 233, swpout fallback inc: 0, Fallback percentage: =
0.00%
Iteration 7: swpout inc: 220, swpout fallback inc: 4, Fallback percentage: =
1.79%
Iteration 8: swpout inc: 228, swpout fallback inc: 0, Fallback percentage: =
0.00%
Iteration 9: swpout inc: 217, swpout fallback inc: 0, Fallback percentage: =
0.00%
Iteration 10: swpout inc: 226, swpout fallback inc: 1, Fallback
percentage: 0.44%
Iteration 11: swpout inc: 223, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 12: swpout inc: 232, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 13: swpout inc: 218, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 14: swpout inc: 221, swpout fallback inc: 5, Fallback
percentage: 2.21%
Iteration 15: swpout inc: 225, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 16: swpout inc: 218, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 17: swpout inc: 209, swpout fallback inc: 3, Fallback
percentage: 1.42%
Iteration 18: swpout inc: 233, swpout fallback inc: 1, Fallback
percentage: 0.43%
Iteration 19: swpout inc: 219, swpout fallback inc: 7, Fallback
percentage: 3.10%
Iteration 20: swpout inc: 225, swpout fallback inc: 6, Fallback
percentage: 2.60%
Iteration 21: swpout inc: 228, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 22: swpout inc: 226, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 23: swpout inc: 223, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 24: swpout inc: 233, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 25: swpout inc: 215, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 26: swpout inc: 230, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 27: swpout inc: 219, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 28: swpout inc: 224, swpout fallback inc: 2, Fallback
percentage: 0.88%
Iteration 29: swpout inc: 225, swpout fallback inc: 3, Fallback
percentage: 1.32%
Iteration 30: swpout inc: 225, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 31: swpout inc: 224, swpout fallback inc: 1, Fallback
percentage: 0.44%
Iteration 32: swpout inc: 224, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 33: swpout inc: 221, swpout fallback inc: 2, Fallback
percentage: 0.90%
Iteration 34: swpout inc: 228, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 35: swpout inc: 229, swpout fallback inc: 4, Fallback
percentage: 1.72%
Iteration 36: swpout inc: 228, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 37: swpout inc: 225, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 38: swpout inc: 220, swpout fallback inc: 1, Fallback
percentage: 0.45%
Iteration 39: swpout inc: 227, swpout fallback inc: 3, Fallback
percentage: 1.30%
Iteration 40: swpout inc: 223, swpout fallback inc: 5, Fallback
percentage: 2.19%
Iteration 41: swpout inc: 231, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 42: swpout inc: 221, swpout fallback inc: 2, Fallback
percentage: 0.90%
Iteration 43: swpout inc: 222, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 44: swpout inc: 224, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 45: swpout inc: 219, swpout fallback inc: 2, Fallback
percentage: 0.90%
Iteration 46: swpout inc: 223, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 47: swpout inc: 228, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 48: swpout inc: 220, swpout fallback inc: 1, Fallback
percentage: 0.45%
Iteration 49: swpout inc: 216, swpout fallback inc: 2, Fallback
percentage: 0.92%
Iteration 50: swpout inc: 222, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 51: swpout inc: 226, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 52: swpout inc: 229, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 53: swpout inc: 220, swpout fallback inc: 2, Fallback
percentage: 0.90%
Iteration 54: swpout inc: 225, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 55: swpout inc: 226, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 56: swpout inc: 223, swpout fallback inc: 5, Fallback
percentage: 2.19%
Iteration 57: swpout inc: 226, swpout fallback inc: 2, Fallback
percentage: 0.88%
Iteration 58: swpout inc: 215, swpout fallback inc: 4, Fallback
percentage: 1.83%
Iteration 59: swpout inc: 222, swpout fallback inc: 3, Fallback
percentage: 1.33%
Iteration 60: swpout inc: 227, swpout fallback inc: 3, Fallback
percentage: 1.30%
Iteration 61: swpout inc: 215, swpout fallback inc: 2, Fallback
percentage: 0.92%
Iteration 62: swpout inc: 214, swpout fallback inc: 9, Fallback
percentage: 4.04%
Iteration 63: swpout inc: 220, swpout fallback inc: 3, Fallback
percentage: 1.35%
Iteration 64: swpout inc: 220, swpout fallback inc: 5, Fallback
percentage: 2.22%
Iteration 65: swpout inc: 216, swpout fallback inc: 10, Fallback
percentage: 4.42%
Iteration 66: swpout inc: 213, swpout fallback inc: 5, Fallback
percentage: 2.29%
Iteration 67: swpout inc: 212, swpout fallback inc: 10, Fallback
percentage: 4.50%
Iteration 68: swpout inc: 216, swpout fallback inc: 8, Fallback
percentage: 3.57%
Iteration 69: swpout inc: 214, swpout fallback inc: 4, Fallback
percentage: 1.83%
Iteration 70: swpout inc: 209, swpout fallback inc: 10, Fallback
percentage: 4.57%
Iteration 71: swpout inc: 217, swpout fallback inc: 8, Fallback
percentage: 3.56%
Iteration 72: swpout inc: 231, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 73: swpout inc: 215, swpout fallback inc: 8, Fallback
percentage: 3.59%
Iteration 74: swpout inc: 221, swpout fallback inc: 7, Fallback
percentage: 3.07%
Iteration 75: swpout inc: 221, swpout fallback inc: 8, Fallback
percentage: 3.49%
Iteration 76: swpout inc: 219, swpout fallback inc: 7, Fallback
percentage: 3.10%
Iteration 76: swpout inc: 219, swpout fallback inc: 7, Fallback
percentage: 3.10%
Iteration 77: swpout inc: 221, swpout fallback inc: 8, Fallback
percentage: 3.49%
Iteration 78: swpout inc: 214, swpout fallback inc: 1, Fallback
percentage: 0.47%
Iteration 79: swpout inc: 223, swpout fallback inc: 2, Fallback
percentage: 0.89%
Iteration 80: swpout inc: 220, swpout fallback inc: 3, Fallback
percentage: 1.35%
Iteration 81: swpout inc: 216, swpout fallback inc: 2, Fallback
percentage: 0.92%
Iteration 82: swpout inc: 225, swpout fallback inc: 3, Fallback
percentage: 1.32%
Iteration 83: swpout inc: 228, swpout fallback inc: 2, Fallback
percentage: 0.87%
Iteration 84: swpout inc: 222, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 85: swpout inc: 214, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 86: swpout inc: 223, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 87: swpout inc: 223, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 88: swpout inc: 227, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 89: swpout inc: 223, swpout fallback inc: 5, Fallback
percentage: 2.19%
Iteration 90: swpout inc: 225, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 91: swpout inc: 215, swpout fallback inc: 0, Fallback
percentage: 0.00%
Iteration 92: swpout inc: 228, swpout fallback inc: 5, Fallback
percentage: 2.15%
Iteration 93: swpout inc: 219, swpout fallback inc: 2, Fallback
percentage: 0.90%
Iteration 94: swpout inc: 221, swpout fallback inc: 4, Fallback
percentage: 1.78%
Iteration 95: swpout inc: 220, swpout fallback inc: 3, Fallback
percentage: 1.35%
Iteration 96: swpout inc: 211, swpout fallback inc: 16, Fallback
percentage: 7.05%
Iteration 97: swpout inc: 224, swpout fallback inc: 6, Fallback
percentage: 2.61%
Iteration 98: swpout inc: 223, swpout fallback inc: 5, Fallback
percentage: 2.19%
Iteration 99: swpout inc: 226, swpout fallback inc: 4, Fallback
percentage: 1.74%
Iteration 100: swpout inc: 228, swpout fallback inc: 1, Fallback
percentage: 0.44%



> Iteration 1: swpout inc: 224, swpout fallback inc: 0, Fallback percentage=
: 0.00%
> Iteration 2: swpout inc: 213, swpout fallback inc: 5, Fallback percentage=
: 2.29%
> Iteration 3: swpout inc: 215, swpout fallback inc: 7, Fallback percentage=
: 3.15%
> Iteration 4: swpout inc: 210, swpout fallback inc: 16, Fallback percentag=
e: 7.08%
> Iteration 5: swpout inc: 212, swpout fallback inc: 10, Fallback percentag=
e: 4.50%
> Iteration 6: swpout inc: 215, swpout fallback inc: 18, Fallback percentag=
e: 7.73%
> Iteration 7: swpout inc: 181, swpout fallback inc: 43, Fallback percentag=
e: 19.20%
> Iteration 8: swpout inc: 173, swpout fallback inc: 55, Fallback percentag=
e: 24.12%
> Iteration 9: swpout inc: 163, swpout fallback inc: 54, Fallback percentag=
e: 24.88%
> Iteration 10: swpout inc: 168, swpout fallback inc: 59, Fallback percenta=
ge: 25.99%
> Iteration 11: swpout inc: 154, swpout fallback inc: 69, Fallback percenta=
ge: 30.94%
> Iteration 12: swpout inc: 166, swpout fallback inc: 66, Fallback percenta=
ge: 28.45%
> Iteration 13: swpout inc: 165, swpout fallback inc: 53, Fallback percenta=
ge: 24.31%
> Iteration 14: swpout inc: 158, swpout fallback inc: 68, Fallback percenta=
ge: 30.09%
> Iteration 15: swpout inc: 168, swpout fallback inc: 57, Fallback percenta=
ge: 25.33%
> Iteration 16: swpout inc: 165, swpout fallback inc: 53, Fallback percenta=
ge: 24.31%
> Iteration 17: swpout inc: 163, swpout fallback inc: 49, Fallback percenta=
ge: 23.11%
> Iteration 18: swpout inc: 172, swpout fallback inc: 62, Fallback percenta=
ge: 26.50%
> Iteration 19: swpout inc: 183, swpout fallback inc: 43, Fallback percenta=
ge: 19.03%
> Iteration 20: swpout inc: 158, swpout fallback inc: 73, Fallback percenta=
ge: 31.60%
> Iteration 21: swpout inc: 147, swpout fallback inc: 81, Fallback percenta=
ge: 35.53%
> Iteration 22: swpout inc: 140, swpout fallback inc: 86, Fallback percenta=
ge: 38.05%
> Iteration 23: swpout inc: 144, swpout fallback inc: 79, Fallback percenta=
ge: 35.43%
> Iteration 24: swpout inc: 132, swpout fallback inc: 101, Fallback percent=
age: 43.35%
> Iteration 25: swpout inc: 133, swpout fallback inc: 82, Fallback percenta=
ge: 38.14%
> Iteration 26: swpout inc: 152, swpout fallback inc: 78, Fallback percenta=
ge: 33.91%
> Iteration 27: swpout inc: 138, swpout fallback inc: 81, Fallback percenta=
ge: 36.99%
> Iteration 28: swpout inc: 152, swpout fallback inc: 74, Fallback percenta=
ge: 32.74%
> Iteration 29: swpout inc: 153, swpout fallback inc: 75, Fallback percenta=
ge: 32.89%
> Iteration 30: swpout inc: 151, swpout fallback inc: 74, Fallback percenta=
ge: 32.89%
> ...
>
> Chris's approach appears to be more susceptible to negative effects from
> small folios.
>
> 4. w/o -a and w/ -s

My current WIP patch:
linux# ../thp_swap_allocator_test -s
Iteration 1: swpout inc: 227, swpout fallback inc: 6, Fallback percentage: =
2.58%
Iteration 2: swpout inc: 91, swpout fallback inc: 141, Fallback
percentage: 60.78%
Iteration 3: swpout inc: 36, swpout fallback inc: 198, Fallback
percentage: 84.62%
Iteration 4: swpout inc: 19, swpout fallback inc: 214, Fallback
percentage: 91.85%
Iteration 5: swpout inc: 12, swpout fallback inc: 213, Fallback
percentage: 94.67%
Iteration 6: swpout inc: 11, swpout fallback inc: 217, Fallback
percentage: 95.18%
Iteration 7: swpout inc: 8, swpout fallback inc: 215, Fallback
percentage: 96.41%
Iteration 8: swpout inc: 8, swpout fallback inc: 213, Fallback
percentage: 96.38%
Iteration 9: swpout inc: 2, swpout fallback inc: 223, Fallback
percentage: 99.11%
Iteration 10: swpout inc: 7, swpout fallback inc: 223, Fallback
percentage: 96.96%
Iteration 11: swpout inc: 5, swpout fallback inc: 213, Fallback
percentage: 97.71%
Iteration 12: swpout inc: 8, swpout fallback inc: 223, Fallback
percentage: 96.54%
Iteration 13: swpout inc: 4, swpout fallback inc: 211, Fallback
percentage: 98.14%
Iteration 14: swpout inc: 6, swpout fallback inc: 216, Fallback
percentage: 97.30%
Iteration 15: swpout inc: 9, swpout fallback inc: 216, Fallback
percentage: 96.00%
Iteration 16: swpout inc: 9, swpout fallback inc: 218, Fallback
percentage: 96.04%
Iteration 17: swpout inc: 10, swpout fallback inc: 223, Fallback
percentage: 95.71%
Iteration 18: swpout inc: 7, swpout fallback inc: 211, Fallback
percentage: 96.79%
Iteration 19: swpout inc: 7, swpout fallback inc: 220, Fallback
percentage: 96.92%
Iteration 20: swpout inc: 7, swpout fallback inc: 220, Fallback
percentage: 96.92%
Iteration 21: swpout inc: 6, swpout fallback inc: 221, Fallback
percentage: 97.36%
Iteration 22: swpout inc: 5, swpout fallback inc: 227, Fallback
percentage: 97.84%
Iteration 23: swpout inc: 4, swpout fallback inc: 213, Fallback
percentage: 98.16%
Iteration 24: swpout inc: 6, swpout fallback inc: 218, Fallback
percentage: 97.32%
Iteration 25: swpout inc: 6, swpout fallback inc: 214, Fallback
percentage: 97.27%
Iteration 26: swpout inc: 7, swpout fallback inc: 221, Fallback
percentage: 96.93%
Iteration 27: swpout inc: 7, swpout fallback inc: 216, Fallback
percentage: 96.86%
Iteration 28: swpout inc: 7, swpout fallback inc: 214, Fallback
percentage: 96.83%

Chris

> ./thp_swap_allocator_test -s
> Iteration 1: swpout inc: 183, swpout fallback inc: 50, Fallback percentag=
e: 21.46%
> Iteration 2: swpout inc: 75, swpout fallback inc: 157, Fallback percentag=
e: 67.67%
> Iteration 3: swpout inc: 33, swpout fallback inc: 201, Fallback percentag=
e: 85.90%
> Iteration 4: swpout inc: 11, swpout fallback inc: 222, Fallback percentag=
e: 95.28%
> Iteration 5: swpout inc: 10, swpout fallback inc: 215, Fallback percentag=
e: 95.56%
> Iteration 6: swpout inc: 7, swpout fallback inc: 221, Fallback percentage=
: 96.93%
> Iteration 7: swpout inc: 2, swpout fallback inc: 221, Fallback percentage=
: 99.10%
> Iteration 8: swpout inc: 4, swpout fallback inc: 217, Fallback percentage=
: 98.19%
> Iteration 9: swpout inc: 0, swpout fallback inc: 225, Fallback percentage=
: 100.00%
> Iteration 10: swpout inc: 3, swpout fallback inc: 227, Fallback percentag=
e: 98.70%
> Iteration 11: swpout inc: 1, swpout fallback inc: 217, Fallback percentag=
e: 99.54%
> Iteration 12: swpout inc: 2, swpout fallback inc: 229, Fallback percentag=
e: 99.13%
> Iteration 13: swpout inc: 1, swpout fallback inc: 214, Fallback percentag=
e: 99.53%
> Iteration 14: swpout inc: 2, swpout fallback inc: 220, Fallback percentag=
e: 99.10%
> Iteration 15: swpout inc: 1, swpout fallback inc: 224, Fallback percentag=
e: 99.56%
> Iteration 16: swpout inc: 3, swpout fallback inc: 224, Fallback percentag=
e: 98.68%
> ...
>
> Barry Song (1):
>   tools/mm: Introduce a tool to assess swap entry allocation for
>     thp_swapout
>
>  tools/mm/Makefile                  |   2 +-
>  tools/mm/thp_swap_allocator_test.c | 233 +++++++++++++++++++++++++++++
>  2 files changed, 234 insertions(+), 1 deletion(-)
>  create mode 100644 tools/mm/thp_swap_allocator_test.c
>
> --
> 2.34.1
>
>

