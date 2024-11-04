Return-Path: <linux-kernel+bounces-395207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F269BBA48
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 17:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5FDE285412
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 16:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8641C1753;
	Mon,  4 Nov 2024 16:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Soyizfe2"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B62942AA6
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 16:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730737453; cv=none; b=LDa3R+WpgB1DxuaXgz+9LDI2hy0EJhGt8L7gYoFCRS2K0Uc3IKc3kLhBdTstxVSKc0iLPTc0Wb21rGUGbyx9DrPp0xGG42QEE494KdXX8idcGErjulrEbAPuP+feOJjEtWegDA3aCIVJiZK51ZaIes795N7e+T4yJddT6ePEtUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730737453; c=relaxed/simple;
	bh=e7pNJpaZwa1h/gknfRxU8USeyEHQJgwWN4IkafBeL/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=deJ3AstIX5iDvwVqn6+ufyt/pWlNgAnTBZHRGzZaadS1EyGFzrADI1SfpO7yi90ywc19XB3WQySngpsFPqa4EjIPZbn5MUtorMTw65Dy/UHhd9E73XTzZKI4xbvscMv+D9qWFbPJct0aJefBa8+k8O5rXEJwiB2Jp4B5r5Am5pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Soyizfe2; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6e5b7cd1ef5so37473227b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 08:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730737451; x=1731342251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDG3pXtVip+KfodA4/0kQzuYn7NY3gOyTP352pqCET0=;
        b=Soyizfe2e9UB6S4OJYKyy9tkIM2LhMRo98IYlN3TvCgWhJwHLfndxQASxbTbJ4MZLA
         DakSL7kICWglsPZDbCgiuP9UX6vBtseAp+7j31wWJHGf2nitKQxNh9pShBB3Me9GCkkd
         kQpiXS4LKSKi8bOwjPkTBuYHHOL955lQNU5RRjch7BGVzFa3xWbYJq4AnRAcb31ysKyh
         nJyXDfPZ3IMMOy7GJk/G2n3y4xYr+k+/ej3k0FwCQFUBuaSFcfwXthnAoTGLqhzZ2W1Y
         CUU2kQ4+7hJhjrAgG7wDsagjoNdrOCP2S378tPQZpKNcJuHMKQN2WoWxHeeUtlF+xvM+
         p/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730737451; x=1731342251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gDG3pXtVip+KfodA4/0kQzuYn7NY3gOyTP352pqCET0=;
        b=vHE8OlAaX1praIvwmGZfwUucCfT1WTVqhcaQD37PknqL12kAijVwXnw1XSt5egeQnX
         yKzNeBabGeHOx6eSRLT5W6+BQFCQ9X6YIDn4bBG4CyLJmprrZCSGH/5R49v10IbRu2lP
         LBBQvfBB27PSpj+Ef6xHiW4VdCE3w4DO0PmO9x9Y8WZJiR4E5O/aGVf4lHW3J/uVQ2wE
         ooiBZUajMME1FU9YkEjBVaNL5WsYYf9SqKuYCZEWtv6t5dz/ibH3FgydU8fFHo2PIRSm
         rNN95puWPCl/ZFOyYWQxZ/fikBA4pPa7+wCyOmCasFfbaj54O8kvH4iFAmThk04BZGJF
         /57w==
X-Forwarded-Encrypted: i=1; AJvYcCV5ESGgIRIEXavVGmM0jJfcMGctkMqa2mYRUIUdIFhWpY78ACWFy8oFM/lpDhJCkGZ0zjkJTfpsEsxcWTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaifixdZs/TY8knH+bq1ndfpJh1ApKyJm+NqFFXhkE4xEz12At
	fz/BjiLPGvd/lJtosccH7d9bjme3axLbHHi9RtFjaErOBss1JMIv
X-Google-Smtp-Source: AGHT+IF8Et8+CgvYS0NUpJMFFTR142xgrloNK0418EFcQi3KHe4p7OMOSNlYAypZO3thIC+YMTpJoQ==
X-Received: by 2002:a05:690c:318:b0:6ea:8a23:76a7 with SMTP id 00721157ae682-6ea8a2380e0mr49198477b3.3.1730737450980;
        Mon, 04 Nov 2024 08:24:10 -0800 (PST)
Received: from localhost (fwdproxy-frc-011.fbsv.net. [2a03:2880:21ff:b::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ea7beaae0dsm11050907b3.48.2024.11.04.08.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 08:24:10 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: usamaarif642@gmail.com
Cc: 21cnbao@gmail.com,
	ak@linux.intel.com,
	akpm@linux-foundation.org,
	baolin.wang@linux.alibaba.com,
	chengming.zhou@linux.dev,
	chrisl@kernel.org,
	david@redhat.com,
	hannes@cmpxchg.org,
	hughd@google.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	nphamcs@gmail.com,
	ryan.roberts@arm.com,
	shakeel.butt@linux.dev,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	ying.huang@intel.com,
	yosryahmed@google.com
Subject: Re: [PATCH v2] mm: count zeromap read and set for swapout and swapin
Date: Mon,  4 Nov 2024 08:24:09 -0800
Message-ID: <20241104162409.2750133-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <2d73b4cc-47a1-44a2-b50a-0f67d25b3e22@gmail.com>
References: <2d73b4cc-47a1-44a2-b50a-0f67d25b3e22@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 02/11/2024 14:43:07, Usama Arif <usamaarif642@gmail.com> wrote:

> On 02/11/2024 12:59, Barry Song wrote:
>> On Sat, Nov 2, 2024 at 8:32 PM Usama Arif <usamaarif642@gmail.com> wrote:
>>>
>>> On 02/11/2024 10:12, Barry Song wrote:
>>>> From: Barry Song <v-songbaohua@oppo.com>
>>>>
>>>> When the proportion of folios from the zero map is small, missing their
>>>> accounting may not significantly impact profiling. However, it’s easy
>>>> to construct a scenario where this becomes an issue—for example,
>>>> allocating 1 GB of memory, writing zeros from userspace, followed by
>>>> MADV_PAGEOUT, and then swapping it back in. In this case, the swap-out
>>>> and swap-in counts seem to vanish into a black hole, potentially
>>>> causing semantic ambiguity.
>>>>
>>>> This patch adopts option 1 as pswpin/pswpout counters are that they
>>>> only apply to IO done directly to the backend device (as noted by
>>>> Nhat Pham).
>>>>
>>>> Fixes: 0ca0c24e3211 ("mm: store zero pages to be swapped out in a bitmap")
>>> I don't think its a hotfix (or even a fix). It was discussed in the initial
>>> series to add these as a follow up and Joshua was going to do this soon.
>>> Its not fixing any bug in the initial series.
>>
>> I didn't realize Joshua was handling it. Is he still planning to? If
>> so, I can leave it
>> with Joshua if that was the plan :-)
>>
>
> Please do continue with this patch, I think he was going to look at the
> swapped_zero version that we discussed earlier anyways. Will let Joshua
> comment on it.

Hi Usama and Barry,

First of all, I am sorry for not participating in the previous conversation
about this, it is my fault for the lack of communication on my end on the
status of zero_swapped (name pending). Sorry for the confusion!

I am hoping to pick this up in a few days (I have been working on a few
patches in different subsystems, but I will  wrap up the work on these
very soon).

As far as I can tell, zero_swapped and swp{in,out}zero seem to be
orthogonal, and as Nhat pointed out [1] I think there is need for both.

Thank you for this patch Barry, and thank you Usama for keeping me in
the loop! Have a great day!
Joshua

[1] https://lore.kernel.org/linux-mm/882008b6-13e0-41d8-91fa-f26c585120d8@gmail.com/T/#m7c5017bc97d56843242d3e006cd7e1f0fd0f1a38


