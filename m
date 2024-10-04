Return-Path: <linux-kernel+bounces-351385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD5399104A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 22:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B76791C23070
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D6A1E3DEA;
	Fri,  4 Oct 2024 20:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y4rSMPJL"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB511DF730
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 20:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728072339; cv=none; b=Fiai+JAY4AUpEgDGTXSzaJ8kpoNLlkG/Gu86J0iIVHzVfLvJXt+b50k0suYuLKCJkvoMDoq4IvhveHScDzmHWTTDoLqUt64H1PNrtySneEUJc52xA6CH9ygsHfjICNAkMDnv5E4GI5/AntLK5cxoPkR7Ln7x0UOATMZ7sinTfjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728072339; c=relaxed/simple;
	bh=JiMxay4gnW+6wgKIgt9nl2obDExo8a/GF1PhTk/kOIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DSlnOe9hwGVNCZVWJtDAq9HEbdDktt0+ExCEyGNDJEVDTzpqiVXmDTkODWAjOg7u/I6OVXX9bF7c/M7eAFkZohQmIdPv0Q57mui1c8sV4930rdIvxS0sN1y1IGx2wkxpcolCM/NJ6gIgsNyFqpZspkD1Ff0hsw1DJFq0SkkzZok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y4rSMPJL; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c87a7782beso921a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 13:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728072336; x=1728677136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JiMxay4gnW+6wgKIgt9nl2obDExo8a/GF1PhTk/kOIA=;
        b=Y4rSMPJLXHmImyc9TcWFVcyPr2WszUekMzKkg3UtAAlSBLaBUYvrFYg6OfhT6u/iGm
         OFjQdQnGI/b7h+CU74FtcbQEaS+d+/lHBEcpL/uioBXdy3Aewt9ZXVPlCu1JN9SjB+0B
         7d0d0aayzk8M9ZiL2q+xsJpcpxm0lflFyZoQ2Ix5L31mFOVd4+7Qtp77fi7ifAySQ2dY
         sIG34iCjiFUWFnzrvPLwkw8Fwnv4jX4QrCFbqaWH95OSXwrbk8ay6ZWboBelPXAqD2QU
         myY2/qaQBnt+ARpaoPYanM/GZn9xi7L7BWKjz/hDMVOqZcXLFw1nEZ5GJqJhc+r7Q7IN
         4NOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728072336; x=1728677136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JiMxay4gnW+6wgKIgt9nl2obDExo8a/GF1PhTk/kOIA=;
        b=elM6Rzw8S8rdTTiFvVtLObRXS1XRVrlV3Rdn8KHOYq0B1pA8jK0URBpRaPHMUwNGWF
         dBmKDNGG04efV30/pJm5oj+FGekBP8Y/XGUYoPXeEF2Akm3ad2nnE6rTNSibCmTGEd4y
         /RmqGwcA035uHDHa1rD60dPFvyIOfemVX3Hv3xcoF6TjvKgyYxKSVNaAX/EY0Jx6+YCG
         JQwksy8g1Lw7AY9mPgqd5qnHIK3DIRCFfjjxJp9cfdRpKFuQozKxd9MBYYy9AeK0C+QH
         f3fZs55R05+AubwUI2k/Hee0fFRI/6/Me7xYQ9gTNJgqF8OQe0GRz5Bx7SZ5nQjP0wiU
         zZnA==
X-Forwarded-Encrypted: i=1; AJvYcCWJ5mWJL/YubIcEwqJWfb6WUtFaxrdBc7A0Mi+97V459utMaoZYXvaMszlwVj7EdiCR1wLdAknT/qmCS04=@vger.kernel.org
X-Gm-Message-State: AOJu0YyojLFl6tnLOgJp3BChc5dhiQDXwCDvkJooP+UfS4z9lFlfKIYP
	GL2B+uSBo4p7ELK1Tqtwer4h7f8/6h40TGp1YyLCNrYvvi8NWox3/lhsm2xDn9UGPm/JMO5ERPe
	8P6E4eS/sLURtUxsDbJHeZbfEAuD3X6yrxQo7
X-Google-Smtp-Source: AGHT+IGKj4ecSq7kiQmR5mFeEjukbtjqOAnsrq9GPARLECwAIVL7N3BRgGkc9MB+SMxU+dPJJPhJacrNmaMHMUr9wxo=
X-Received: by 2002:a05:6402:42cb:b0:5c7:18f8:38a6 with SMTP id
 4fb4d7f45d1cf-5c8e124ffe2mr74647a12.5.1728072335495; Fri, 04 Oct 2024
 13:05:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004195540.210396-1-vipinsh@google.com> <20241004195540.210396-3-vipinsh@google.com>
In-Reply-To: <20241004195540.210396-3-vipinsh@google.com>
From: Vipin Sharma <vipinsh@google.com>
Date: Fri, 4 Oct 2024 13:04:58 -0700
Message-ID: <CAHVum0eXVwpwsrVC21XN1H0JvJ_QWnr3ERPYvSyRpwudVFtg8Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] KVM: x86/mmu: Use MMU shrinker to shrink KVM MMU
 memory caches
To: seanjc@google.com, pbonzini@redhat.com, dmatlack@google.com
Cc: zhi.wang.linux@gmail.com, weijiang.yang@intel.com, mizhang@google.com, 
	liangchen.linux@gmail.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 12:55=E2=80=AFPM Vipin Sharma <vipinsh@google.com> w=
rote:
>
> Use MMU shrinker to iterate through all the vCPUs of all the VMs and
> free pages allocated in MMU memory caches. Protect cache allocation in
> page fault and MMU load path from MMU shrinker by using a per vCPU
> mutex. In MMU shrinker, move the iterated VM to the end of the VMs list
> so that the pain of emptying cache spread among other VMs too.
>
> The specific caches to empty are mmu_shadow_page_cache and
> mmu_shadowed_info_cache as these caches store whole pages. Emptying them
> will give more impact to shrinker compared to other caches like
> mmu_pte_list_desc_cache{} and mmu_page_header_cache{}
>
> Holding per vCPU mutex lock ensures that a vCPU doesn't get surprised
> by finding its cache emptied after filling them up for page table
> allocations during page fault handling and MMU load operation. Per vCPU
> mutex also makes sure there is only race between MMU shrinker and all
> other vCPUs. This should result in very less contention.
>
> Signed-off-by: Vipin Sharma <vipinsh@google.com>

I also meant to add
Suggested-by: Sean Christopherson <seanjc@google.com>
Suggested-by: David Matlack <dmatlack@google.com>

I can send v3 or please take it from v2.

