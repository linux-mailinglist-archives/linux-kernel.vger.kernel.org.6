Return-Path: <linux-kernel+bounces-283059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7631194EC70
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 14:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31D7A28233A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF985165EFF;
	Mon, 12 Aug 2024 12:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRSj6vE4"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69C517276D
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 12:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723464620; cv=none; b=SZAFZuSwPLP0O8G420tPkYHH1aJQr0zK4lK4BStxjoJ3cZNjh87TZt1W1LQaE9zGwTN77dYn6bJp8VQ+7BOZtEXdGos7Nz5l4cb35jPmXFvZUZ6tRjP9g4wg4TGHwiZ6+EBdUHToovtMUZ9VZXUoDxUq8hMLiG2lNre4Hhi7TrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723464620; c=relaxed/simple;
	bh=Aga1t/9ExzSGHYZ63rABYdg6Ggromp/c8/b4IwooNEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eCNAhSsDwClBYYec6uijQS4uGFVFFFMoBHvIgHGyDOu2yveGPDvDQO0h+vRjPvvqc9FMy59cREKBNEI4dgMzJPUhS9gxKAM8uzRc/aLiBlyvQ4qEUy3sp+wyByt6fmAZ2YuyL0VFeXY5+Yez4CLOUsBzFRhT3HLsyAo7ZYuhjBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QRSj6vE4; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5ba482282d3so5210073a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 05:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723464617; x=1724069417; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RBdWp2CtRqMv2aeOkkyilCzRHG5GPwUE51RMHvyrusU=;
        b=QRSj6vE4dy0HI6FkqbJBIBPT8V6HgOtCsCCfdvggxSN59ilgCZYfro86PLQde94dge
         Wnz74jH+9lQIvkzFIyGOw6lUwt0WfLiQg8GrahKwF+hCa6wp0vI/kk4jXUffXhI5zX29
         EnC7+g3GpUF15uXglF8ooPIvJz3K+eF5nTLv2qCwb1cM4MvvAG+luDVO2aOoI/tWm/Kw
         Uy7e+1F0X5w/THB0Yt7sstojnekSNUAO1htwPkFmLP2+hCI4M2Bexi4ehnLPZhMasd28
         9T2FBgrkDN6ETq4TOXz6/H4NRYjFS8CMhcjbuE4JjB2OAucprVHm/bCKFdYntiMQ3a67
         uTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723464617; x=1724069417;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RBdWp2CtRqMv2aeOkkyilCzRHG5GPwUE51RMHvyrusU=;
        b=cb0nQGWM50bBTAnon0JK4ZFcw1fFAweuspazMwNezyCeNIp5iwjdYKQr2lL4tKWOQW
         o72ah/T2tR88Ns0yFF0CIP0GVjcM2GkadZWA+iUPbIP7beyjJbDkxR+PQcZDwB8g5frP
         d2R0A4RNDcfEjlpIPp7Temv5WGTAsjhmeRx6mMpHbnDDKD8UGmhSDdJ0l8Rn1LIMs7Dh
         DyJs/bBfqVzB903fWdFBJ60w7g7PLap1I+xP0JCqLUZMU7zTOwYqNBHu6cTpbtOa3eNS
         5b1ZA7WScTE0aMnfE++FpbKpfF7I1UDRv718mAngdF4Ph04idnR4ot/eg250vwD3RDNT
         SlgA==
X-Forwarded-Encrypted: i=1; AJvYcCXSpZZ1E93lIfc60aMznUFztfKygtnpObLdA1klvus9qXmt/BYCYPIt/W3BFwspeNF09Ob3JlZ9UvPeFTUhSG14cfKgeWdQPqTH9SRE
X-Gm-Message-State: AOJu0YwLdMv4UytlPitrKL0gSvB53N6gLkKGNFhBq6Ah61VAjKCV1gkv
	l1KaiOriD+Oow/i6MhH2e+g/4mzrSGZdccVcf0dVBxMmFYLfo7yOqZFneyWXLIda+2AxxeccmGV
	aYXBfgI4aWuaMypd8BSeYrZbZuBo=
X-Google-Smtp-Source: AGHT+IGhJuom75GkW292ArwE3fTRXBaPKYmmLkqVyVIP5BPMHYkTnIBx1dW0dIzV+YlUjxqTbkZ2bwfQ1hc6nraNqPc=
X-Received: by 2002:a05:6402:1e8a:b0:5b4:cd20:f13c with SMTP id
 4fb4d7f45d1cf-5bd44c26e19mr35535a12.16.1723464616531; Mon, 12 Aug 2024
 05:10:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230810100011.14552-1-max8rr8@gmail.com> <87le17yu5y.ffs@tglx>
 <66b4eb2a62f6_c1448294b0@dwillia2-xfh.jf.intel.com.notmuch>
 <877ccryor7.ffs@tglx> <66b4f305eb227_c144829443@dwillia2-xfh.jf.intel.com.notmuch>
 <66b4f4a522508_c1448294f2@dwillia2-xfh.jf.intel.com.notmuch>
 <87zfpmyhvr.ffs@tglx> <66b523ac448e2_c1448294ec@dwillia2-xfh.jf.intel.com.notmuch>
 <87seve4e37.fsf@nvdebian.thelocal> <66b59314b3d4_c1448294d3@dwillia2-xfh.jf.intel.com.notmuch>
 <87zfpks23v.ffs@tglx> <87o75y428z.fsf@nvdebian.thelocal> <87ikw6rrau.ffs@tglx>
In-Reply-To: <87ikw6rrau.ffs@tglx>
From: Max R <max8rr8@gmail.com>
Date: Mon, 12 Aug 2024 15:10:05 +0300
Message-ID: <CAJrpu5mm2j4U55wmcDTcFGBG41YrWpeg=reX2sWP_ajCpBLNOw@mail.gmail.com>
Subject: Re: [PATCH 1/1] x86/ioremap: Use is_vmalloc_addr in iounmap
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Alistair Popple <apopple@nvidia.com>, Dan Williams <dan.j.williams@intel.com>, 
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org, 
	linux-kernel@vger.kernel.org, x86@kernel.org, jhubbard@nvidia.com, 
	Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"

> So this lacks a Fixes tag and some deep analysis of similar potential
> problems. While at it please use func() notation for functions. In the
> middle of a sentence iounmap does not immediately stand out, but
> iounmap() does. It's documented ...

Yep, will do, not sure which commit to attribute to Fixes though. Probably:

41e94a851304 add devm_memremap_pages

As it seems to be the first one that might cause high_memory to overlap
with VMALLOC.

> The correct helper to use is is_ioremap_addr, as in the generic
> iounmap implementation.  This won't matter for x86 currently, but
> it clearly documents what the code is doing.

And will update that too. The patch is over a year old, and at the time of
submission the generic implementation used is_vmalloc_addr.

Best regards,
Max

