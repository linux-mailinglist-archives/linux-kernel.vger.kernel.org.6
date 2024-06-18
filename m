Return-Path: <linux-kernel+bounces-219586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1A390D4FB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9510A290980
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A293E1586D5;
	Tue, 18 Jun 2024 14:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UusCoi3B"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DBB158A07
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 14:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719578; cv=none; b=Xk1fyggqElycXTR4L02WuSHgheL8lkgVNjgGEKdmvozJzxGWQ2NXj7Trt0FuMnr0lq3WDMpXM+sLhSZ1N1Pb53eu9+EYuI3f/SEnAl3enI0mFKW8bvKB/kCjaTfX6XL7QlEcye2hO2ejJC+7vOaDGERb6DRuA6dv+DFF4ieK+eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719578; c=relaxed/simple;
	bh=JIVKjv9o/hlqHws4mlvGqtvCExur4cvFhcjzhdAqB/Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KDa8c60/Jb9Uto1spZnUEmazNAQpwh3X1up9GkFSEnJhrajPedDh9NsUxL3YlaR5DMzUQ1It3mmo6QIRRIRMuDsxLAjqkPCT/3h4eF3f5+BX6RI/5QTgdCNf5hFCzGh4XHhyYwS60ZN79DFM8QxLgfFfXh/VJYiQOi+fg//1t9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UusCoi3B; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e02a4de4f4eso1164553276.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 07:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718719575; x=1719324375; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=G2G9ol4+qy118R59S97h3lDvVaYiNKtni1Bduo/B80M=;
        b=UusCoi3BEu0k9RhqTzuedvLcUA8IVzBAVUV0Hd18opEsPr+WkNk8JNwIpzb8AF76zC
         g+UvtzwyckdQpQBp080H5sTLOqguUAWFDzQTsvYVXwkgor71ycHVDtSfqIdgMxac+xXx
         HYUz0EmB+4SFbI+AvwRY6e2fOsRriNiwTB0BZrX8EaLNtjiR5aMxwXmn94F6NtPK6nCf
         snkAHBNREwFgK7mLPDVDJS52y4YNfvAKBXqpkV78jEsdXahrZ3BWF4eln6ZzU5uDiaiQ
         Z4PSLBXsnS5y4Njrbz+HUGR1g1TlQHr+umz7BVt3R+9rARZIfKj0pykYJk86SqEsCiWR
         qWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718719575; x=1719324375;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G2G9ol4+qy118R59S97h3lDvVaYiNKtni1Bduo/B80M=;
        b=deUX367WOXoHjA1oW7chm2r+uJ2rCCEi8wiWwdDKoSEvRRhHmJLiZQIZYM5iKfbc3K
         zJq/8ESbGA+2J6axAtp8ZRl6UGxRpMT/og0qJIdbwApsim8TKCkFwq2WAT3krSbEOst+
         dZG8Ofw1BEj7PMsm7W6O1BM2Dlos1P0awvHd/FL/HX7lR+zPFihYkMo54oUfkT8KX4mT
         uWNeHCi+hFgtL0WrJ2qTDZYkg095SfkFShFJ6ALQqn/hflXDEP3QZjuXYmDYtZii6UuW
         ApPj4rJYcj4DXC1/l9d5+OQN32FdoRKNWDlqfviVHrNumOodeeOFKpJ0LW5WxowcRRU6
         uXKg==
X-Forwarded-Encrypted: i=1; AJvYcCXP4w/cyRveCBHCXPZkpmRPoavK8RTs00k3UTAV4w1laZ3vyT36l9b6k7Z056HL9FlzRNQqgc0rKPKblRStzwP7oJGDT1qf/V/wZYEA
X-Gm-Message-State: AOJu0YwkS1R+bxZmmyv7kILO7kpRPfkR3nYVhxpG1IT/efR1Ekj8rOoF
	KRyGbU+B8KOzLyuos436ZTIE1oWQDqZHaF3lJBHRnWutzx4EdPmKmCy5g5fo3zsjIILFu0e6hpu
	zrw==
X-Google-Smtp-Source: AGHT+IEzJQkA0wwSsmNWrHMtvOFE67uD+a4zJelQVNSNlEgmlkViXQM+7Gk/318mGpxWOd2trXry35nlUgE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1005:b0:dff:35fd:c804 with SMTP id
 3f1490d57ef6-dff35fde096mr1085527276.9.1718719575474; Tue, 18 Jun 2024
 07:06:15 -0700 (PDT)
Date: Tue, 18 Jun 2024 07:06:13 -0700
In-Reply-To: <20240618113840.24163-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240618113840.24163-1-bp@kernel.org>
Message-ID: <ZnGUVcEUUF_1Vqmi@google.com>
Subject: Re: [RFC PATCH] x86/cpufeatures: Flip the /proc/cpuinfo appearance logic
From: Sean Christopherson <seanjc@google.com>
To: Borislav Petkov <bp@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>
Content-Type: text/plain; charset="us-ascii"

On Tue, Jun 18, 2024, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> I'm getting tired of telling people to put a magic "" in the
> 
>   #define X86_FEATURE		/* "" ... */
> 
> comment to hide the new feature flag from the user-visible
> /proc/cpuinfo.
> 
> Flip the logic to make it explicit: an explicit "<name>" in the comment
> adds the flag to /proc/cpuinfo and otherwise not, by default.
> 
> Add the "<name>" of all the existing flags to keep backwards
> compatibility with userspace.

If we're going to churn the whole file, why not take the opportunity make it more
structured?  E.g. use a variadic macro so the name doesn't need to be buried in a
string inside a comment, and so that each feature doesn't have to open code the
math.  Lack of third input omits the flag from /proc/cpuinfo, and a magic keyword,
e.g. AUTO, uses the feature name.

There are quite a few games that could be played with macros, and IMO pretty much
all of them would be better than comment+string shenanigans.

#define X86F(word, bit, abi_name...) ((word) * 32 + bit)

#define X86_FEATURE_FPU           X86F(0,  0, AUTO)

#define X86_FEATURE_XMM		  X86F(0, 25, SSE2)

#define X86_FEATURE_K8		  X86F(3,  4)


