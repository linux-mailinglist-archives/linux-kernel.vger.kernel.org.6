Return-Path: <linux-kernel+bounces-541912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CDEA4C34B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AA261886557
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496EE213E65;
	Mon,  3 Mar 2025 14:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMF06ffo"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2441D2139DC;
	Mon,  3 Mar 2025 14:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741011778; cv=none; b=GeluAOp1XDCMNcYqfj4K6vbB2t91xx0kG7Z6nuo+qMggVvQ20TgQw9zBrkx/VBemXIVR/4XfQ7EQOLdKDjAo1bVmeHaik+SS3ipdI21cPdJyzCtPbZdDObvlbIY3QxweZw1HL7keUZ9SpDt2dLVhI3RQHVUixLo0B1v8V4fNiSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741011778; c=relaxed/simple;
	bh=GDass88p1cGLMtvfYOyZ705pBwD7ETp6+5TXqoUYsik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qJI1LUxrtks7RWfmTn4Y1ynHSddnKs+BOJpV6QxGTt2deTMeeXirwuu0UKYZ5CqyOEe3xkhADoaFQgHPZY7K6QDdxgpUwu3Wr1a4aZ3avfPsa6DSjwRjrDWNT+gdLTcDQebNEamL/tGAQwGX+nD14yJo1bwrETZimn/nL6SUSw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMF06ffo; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4398ec2abc2so40491695e9.1;
        Mon, 03 Mar 2025 06:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741011775; x=1741616575; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eFbw9zj+cY999Hz95YSyZdn9V3ph925MvjjnzDYq96Y=;
        b=DMF06ffo5d2m6b1V3Duq7szKCQZk+YuggBSa9LhBbeO6AMl8Q7D7eXLfwgqSr6kT66
         C0KcdV/1Jj08uSEGLgXH8TDqRwliWD+Uwef5aoiXQZ+YpfxLJPCwiAEVcN6odTts5j6o
         0Zq5Og4xXlkGzBgxu411A0dO9+9ol5b84F2ecB4rwKq4Lwd2BZPaSFrAhD1AHiDHSik/
         H9hJ0UZ5EbxxJp5EDSBRWX3vO3UweOeh+xMd0whO/q748rjXbVceK8Hs844qQde0hTqm
         a8brYLZ/kixH7OVw5sBQHOEJfBeBLuZSlZqBesHnKU4xnmIC4igMAlPrsvSbjEcUp/YE
         aD1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741011775; x=1741616575;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eFbw9zj+cY999Hz95YSyZdn9V3ph925MvjjnzDYq96Y=;
        b=OWqE9mVLVEXp2bXMg0gxF+8PXYawir+bmwPUZflZUBUnymsM8gdAQK3t0vT67ubUie
         r9EMO4U0iTs2EuM4wKehu+C9OCJVtt00l5UtmqpERIE9pxo4CaoyapxR2GK2RFN/adlw
         sUn2YLupwrtjRoD8aOHy7NOFNH7cqzjSNVx4TT8aVmgU79Ii8IlIseoT6b7k3hvreH7j
         JUBTHl5zxwk1vPJuwYqzmdbCizUtP+WrPFkUb19K50quTf29VyEOD7g1uk9+YtqeMxdV
         2RZZ3ucpPxcmIWnVOPf1fV/hACCmVIzQAphu7VRZb5uvoqDRjU/lMyMeD+U1Hs0uRh1L
         LvUA==
X-Forwarded-Encrypted: i=1; AJvYcCUv6ZarX3pXsBIt4iu4hcEje2GH2K+sSB4Au24+4tMfOOhWFauM9Zex3HmOtRC0giTYUz2kfNNq8AhAlctZiw8=@vger.kernel.org, AJvYcCVWVuZwRAxBSrzEQc/VaoxsHdihMS8iUMDLIxqi4tQMwgJ150E9u6Ir54Y9IXJuZXvxNz+GrUm0mo/lGeM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/IOt9Ar+00ZJHXxggsTh58vn88/2HMXILcVm48cbejUXP19u5
	j1Wg1AFYhQ4GmNVbqGSv7FUloy615mf2JbaYc+T1yIlnQUzc5sxo
X-Gm-Gg: ASbGncss+GnS3G8gpm7aSRjpd3KZoV3IStelRNAgQ3QhK56BG7ys2R8MJYmY7hac9dm
	5/CxHdXecU+ZQDN5XXoyP8qnWnRbpAlT+0UA0Jd1m4nB83yLMY5gWiIyAiCshbH4ffhP2eV7k2E
	uUzsjPeyBomkWs5sEXJ370UgIUzQLagnYd8oXjHzCWusm4RAA8Eaw/Kh3lypVppdrJI6PmIYfYj
	sIZp935w3vebIV692AUFKX7ISuTmmbvmgoPVfHTQT9UpkckwvXIrKNzi64Iq9j56Bf1AXSz6rNl
	f84MolheT+8iyn2lQ+kKAjm7vCvjX6RcONgmcAsYVa+DzkM+Mr+vUAQ8aATvKWXf5H0XGUpiRjo
	kphH+clvMJ2N5+DfzSB7s2Zx0PgBlx0vpsxrgjFWJHcKFRXDJP63ihgnAABxCkmBZxgStdqaOzz
	Uu
X-Google-Smtp-Source: AGHT+IFjsqgYpSVb7d/uJ4qxNV61R4Ac2hhwtH9ODEPNzkG2d9qY9FyD8RKcQRJDK0eMa+x9SHopnA==
X-Received: by 2002:a05:600c:35c5:b0:434:a781:f5d5 with SMTP id 5b1f17b1804b1-43ba67593c0mr124476985e9.30.1741011775087;
        Mon, 03 Mar 2025 06:22:55 -0800 (PST)
Received: from ?IPV6:2003:df:bf24:2700:73f1:1935:b744:5d51? (p200300dfbf24270073f11935b7445d51.dip0.t-ipconnect.de. [2003:df:bf24:2700:73f1:1935:b744:5d51])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b73702bd0sm163241605e9.10.2025.03.03.06.22.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 06:22:54 -0800 (PST)
Message-ID: <a023e628-af43-4226-9ade-597dd54638b1@gmail.com>
Date: Mon, 3 Mar 2025 15:22:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 7/9] rust: sync: Introduce lock::Backend::Context
To: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>
Cc: Boqun Feng <boqun.feng@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Waiman Long <longman@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 "open list:LOCKING PRIMITIVES" <linux-kernel@vger.kernel.org>
References: <20250227221924.265259-1-lyude@redhat.com>
 <20250227221924.265259-8-lyude@redhat.com>
Content-Language: de-AT-frami
From: Dirk Behme <dirk.behme@gmail.com>
In-Reply-To: <20250227221924.265259-8-lyude@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27.02.25 23:10, Lyude Paul wrote:
> Now that we've introduced an `InterruptDisabled` token for marking
> contexts in which IRQs are disabled, we can have a way to avoid
> `SpinLockIrq` disabling interrupts if the interrupts have already been
> disabled. Basically, a `SpinLockIrq` should work like a `SpinLock` if
> interrupts are disabled. So a function:
> 
> 	(&'a SpinLockIrq, &'a InterruptDisabled) -> Guard<'a, .., SpinLockBackend>
> 
> makes senses. Note that due to `Guard` and `InterruptDisabled` has the
> same lifetime, interrupts cannot be enabled whiel the Guard exists.

Typos:

has -> having
whiel -> while

?

Cheers,

Dirk

