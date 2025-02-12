Return-Path: <linux-kernel+bounces-511108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BED70A325F6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 13:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72E64168AAB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7AC20C48B;
	Wed, 12 Feb 2025 12:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1FJc2Zt"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A02F1F866A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 12:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739363957; cv=none; b=gtoWvKlBmNwy9JXTfyNtdPKVmyylsGhVDhMfbIwy4qN4Q2rlWGbPfv/9YGFGoH0uwZhLx190aLHS3Sv5BqnvHHvtBLN9/sPTh1A2tNX1/5URt+BfgHlPqnWlTdxbcV9M/Sljb2mE5V/XcUT92aHwd9Gr10b61Wsa6LfQAS9THoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739363957; c=relaxed/simple;
	bh=cwXHPUhADcptkBat4qjbah2IpI4snMQDKRbV6TWNdRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uI9pbfuIIq5Sn0I5IYA2KvV7SKjVkDVGqt5tutUuRW8gO7xQxoRJmvKNh/GKK59r/m0IyJ5WcEvq8RpZB+JH3eMRfPFjm7G6UV3VWf94hOGy6RwZ8e1OHwiaWqyAlTJz5ichfVJiWrNESCaeHjUpjeG4iAcaCtXj4xWMrYSyNQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1FJc2Zt; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21f818a980cso61968835ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 04:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739363955; x=1739968755; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wf5TM+EPqf0h+MA78sRvraMgyJZcMD1wBD5w/oXTdE4=;
        b=I1FJc2Ztb9Pdi/ovRT0z3eql7gjB3M6FCCdvoELzGQY4Dl73CaRhFpfq1emti9awTK
         vbOkg2/dqc1tqnQjIzLyPoKIVKfhvq/54ZUCaoWqQrIhlErl0Zxpt/ipcyruFlS5F1iW
         KMviS+AOPHNxB4y5Tu75FAtQeWT/Kpzv9ThfrUcpT3Vyhkj3uRIhLrbLpZ3p/ydGpguD
         xmZb84nTGrbCA8xDmS7yuPSAuZYL10bdGvL7vplIPpicmyWC9L5LdOl4O7T7hIgvk4Zg
         2dF8HKNnEd7aIHO5fbwfTSip0/HZ+mX4rG8EIl3Ge50tpKW0ffTozy/aThSlLVqYicSE
         9/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739363955; x=1739968755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wf5TM+EPqf0h+MA78sRvraMgyJZcMD1wBD5w/oXTdE4=;
        b=MJY1M5HhCxlVIsNfHCHWiHxKdTEkrmXbWipKiR3UWVreDHDKOCUg0t4Ba4F2GwEqiY
         C05lhn6G6CrJGhubL3JtKEXAGQqyAD5dyenf0mysPBh8NPH7TZ9ZesInuvQjdpUF49Za
         sgxZM00I+PrF+GQrc3M1tS/64vDgFAh68ZuPt7c+bHEDYJyohl5PTKE+7S0c4M3SAxZ1
         MU6OCVB+9AqBrWdcJDpKj5+60mSWquLBUI3IXrVTcKaBJS4zaq/ZEHXB8sw/i4iK+gVq
         oqlveDwqeiu+CQLAGlQjFfpkBlWFVv5kJiucAhMTO+385j68SWeuelnezQ2mCAKLXHDs
         U7ww==
X-Forwarded-Encrypted: i=1; AJvYcCWJOYv/4PQZ6TOkksYbTXY5VxHB9lOJ+nvVTZfGwOE3+JrnAHtyR+zeB3Gsy753Vb8Fgo5ezgDyQof1d/I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8/IXi4Fc2ct1tQvK8EZdkxy/5ntVOMeVFniqgBraWC4ATHSQh
	Qr3DAfds/xgjiDdaje3kJj88Fa7gujyQkCoiNClSvZovwSMhhyY+
X-Gm-Gg: ASbGncscYqUmBilyx/nEUwPwado5hA/IRjUb8TECFVOU4HsFiYMx1vylvAlBMTz+2Zh
	4Qaa+QuPDmbsy1j7h2og6l8EVV6VjGR0P4nXmPAg4OjMy2/7ZwSVL4Id0ZvbXVLDb8oaC9eM293
	k/dqfaG5AYTxXaxyMDkCPCzAYcDZDi2+28vqZHuE/bTmlqe03lUtnqcwGRc+K0M+Y69xgNvMu83
	LW/GFtFAEnIf4CPv6MudkxaLiwvg4snBD6qpcufVmwwSoskK38FR2lkOBnAXaVAjJm5jF7xLrSX
	s2CP75BSaW7froAT5Zizsgxh248tY4c=
X-Google-Smtp-Source: AGHT+IEwoFNH8vKEKheDsG5klOKCRWG3RJFrzMBtlqvl5q0+QcUeqDNFn0YkXm4q5LruJnoytlXUcA==
X-Received: by 2002:a17:902:c94c:b0:21b:d105:26b9 with SMTP id d9443c01a7336-220bbad1319mr52418905ad.16.1739363954744;
        Wed, 12 Feb 2025 04:39:14 -0800 (PST)
Received: from vaxr-BM6660-BM6360 ([2001:288:7001:2703:bc75:3c8b:62e:1d7d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220cb6aeefasm411265ad.63.2025.02.12.04.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 04:39:14 -0800 (PST)
Date: Wed, 12 Feb 2025 20:39:09 +0800
From: I Hsin Cheng <richard120310@gmail.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: yury.norov@gmail.com, anshuman.khandual@arm.com, arnd@arndb.de,
	linux-kernel@vger.kernel.org, jserv@ccns.ncku.edu.tw,
	skhan@linuxfoundation.org
Subject: Re: [PATCH 2/2] uapi: Refactor __GENMASK_ULL() for speed-up
Message-ID: <Z6yWbROu5rREhw85@vaxr-BM6660-BM6360>
References: <20250211162412.477655-1-richard120310@gmail.com>
 <20250211162412.477655-3-richard120310@gmail.com>
 <20250211223045.5c2b92a4@pumpkin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211223045.5c2b92a4@pumpkin>

On Tue, Feb 11, 2025 at 10:30:45PM +0000, David Laight wrote:
> On Wed, 12 Feb 2025 00:24:12 +0800
> I Hsin Cheng <richard120310@gmail.com> wrote:
> 
> > The calculation of "((~_ULL(0)) - (_ULL(1) << (l)) + 1)" is to generate
> > a bitmask with "l" trailing zeroes, which is equivalent to
> > "(~_ULL(0) << (l))".
> 
> Yes, and if you look through the commit history you'll see it was changed
> to avoid a compiler warning about the shift losing significant bits.
> So you are just reverting that change and the compiler warnings will
> reappear.
> 
> For non-constants I suspect that (2ul << hi) - (1ul << lo) is the
> best answer.
> But the compiler (clang with some options?) will still complain
> for constants when trying to set the high bit.
> 
> That version also doesn't need BITS_PER_[U]LONG.
> While that is valid for C, the _ULL() are there for the assembler
> (when they are no-ops) so there is no way asm copies can be right
> for both GENMASK() ans GENMASK_ULL().
> 
> 	David

Hi David,

Thanks for the review!

> Yes, and if you look through the commit history you'll see it was changed
> to avoid a compiler warning about the shift losing significant bits.

I've browse through the commits of include/linux/bits.h , where
GENMASK() was placed under. Though I didn't find specific commit of it,
would you be so kind to paste the link of the commit?

I assume you're talking about warnings like the following?
warning: left shift count >= width of type [-Wshift-count-overflow]

If this is the case then it happens for the current version as well, I
mean from the perspective of operations, "(~_ULL(0) << (l))" and
"(_ULL(1) << (1))" are basically the same, they all shift a constant
left with an amount of "l". When "l" is large enough the compiler will
complain about losing msb.

> While that is valid for C, the _ULL() are there for the assembler
> (when they are no-ops) so there is no way asm copies can be right
> for both GENMASK() ans GENMASK_ULL().

I don't understand this part sorry, if asm copies can't be right for
"~_ULL(0) << (l)" , how can it be right for "(_ULL(1) << (l))" ?
At least from my pespective these 2 ops only differs at the value of
constant. Please let me know about it, I'm not familiar with assembler
and would love to know more about it. Thanks.

Best regards,
I Hsin Cheng


