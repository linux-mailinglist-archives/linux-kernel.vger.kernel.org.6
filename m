Return-Path: <linux-kernel+bounces-219228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1830690CB9A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88EA9285826
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29D313C807;
	Tue, 18 Jun 2024 12:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oLjLXBdU"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53B713C694
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 12:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718713408; cv=none; b=qqAcxngVcdplWTLGtSGzd8uR+6HoZLbL0vcKCXNkdoSDCnet+1xhvZ2pt7s0L8PzKHvyLpImXJuIf5a4If2WhIyVk8NFJ848Uqva2KtI9jSZuMbueVo80BCvuRBBMQgpfsBO+TK31pwBdion5sdo9kzAiuAhjUbT4u0WENZgai0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718713408; c=relaxed/simple;
	bh=7r9377QHeRx4YGuRMxxudwYWoomRsoHVd1b1XjrAH4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ttqHvWIUDDvRaZgUdAJz82uST6yYji9XbHFi7wWCs3o8fsDbr79e3M0DS0T6xMXo7mEGnuDzz4gq/xKVpmNCXQRY5G+xI9Vk27c5u8LJM8Sz6sLm30U/y+hFEvZcqNVoO5Zs/9GT1g+RIz3mNFOOBbj/BE2AiTfCAh4xce3U++U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oLjLXBdU; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-63152a07830so44746127b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 05:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718713406; x=1719318206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7r9377QHeRx4YGuRMxxudwYWoomRsoHVd1b1XjrAH4c=;
        b=oLjLXBdU73Qyz9mlpjJ51V9DXeiY4HN4EDhGZg87mJIhSS2mT3BGSHB73eqQj2LSmP
         wPPZva3HcVqLg3GrYTTpB+VkZsOKaEHE4vNavIICp++EhkybhGPQsxCrw0p4FsyizT/r
         mPGTl9oAeTuSiEuHC/Z6Xd7vHBCuekZFCAhljPcM4DZeGwyJe6BbTfYq/3IyKsBfeAkt
         jDNScJDAjWSKEsguf9DFCakl3YS0E1/pg6Ig95g+scgdfab2fWMbuCRSIP32GhGLVCWt
         4pIqCuQy6/9Wld+OGfiLK9d+N6oKGFdW9kc/GeeXdPxuuy+03n83VmZ8Q+BLV+F9xljy
         Rjdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718713406; x=1719318206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7r9377QHeRx4YGuRMxxudwYWoomRsoHVd1b1XjrAH4c=;
        b=J8y/bPk9zvfHDgeTByfz7wac5bI1BoTrOrRiW0ETqX3jZsZrnay1O95BDk9kF0ZaAZ
         uYr996Y2/AXJosvSzs3IDNlypEuIyo9qPOdmgx5571mCK6xprhjYUJ5QcLJpBe5owF/L
         ryma+HgZe4pnBpqnzghT1GmE3WXKXMO8kYK8EFvRm0QA0m2YjRPkX8OsHJwezEjXcEyw
         qFrR+iELy6zh+B+qZqVl3ab+4ltJC1TDqa+eBkV6Q6bXjDYfWDaLx8HqxSCobWaAENhQ
         FFDY2WNWmn31IVj+iaoPqujUMASiXBoxOwytnmNkjC4NSspBFDRII45POwHaC/RhOyv+
         HfPA==
X-Forwarded-Encrypted: i=1; AJvYcCW6eWPAGp0x4oNbZH0z5gAINnMIqlqiRH41mTx5M1GidhC4iOnDQQDthiRq2kDQEWbxDu00mOVwcoyUe3k+MM6DB8gIMEXJg9YirBte
X-Gm-Message-State: AOJu0YzzJY0WnrHeFvqa7INd77Y7DN1yK1/3jJIqCEUZ1PzlvVFcgwri
	evLCb831B7LcsIHnX7ZY735opd9MDkjxIDXya6T2rNuF6zX8jR06ZhAQzccJKPzOEMmh+kSNulz
	JbwkAH8mRB/6uUzVTT9KBrI7zJZK97egxXRDu
X-Google-Smtp-Source: AGHT+IGByXTFHMVNXIbwEPuEy6ECS8UlQ7NjRzqMyf5rOrRSa+3k76BSDfeXF6KiRmwBQfl6+NuPndA17rE7v9lMezs=
X-Received: by 2002:a05:690c:6a09:b0:62c:f01a:17a3 with SMTP id
 00721157ae682-63222a586e9mr136731667b3.15.1718713405543; Tue, 18 Jun 2024
 05:23:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613153924.961511-1-iii@linux.ibm.com> <20240613153924.961511-12-iii@linux.ibm.com>
In-Reply-To: <20240613153924.961511-12-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 18 Jun 2024 14:22:44 +0200
Message-ID: <CAG_fn=UEutgfgiE5xcFT=LXk51_PYmcCXCeNg3zSSEPYJ+tttg@mail.gmail.com>
Subject: Re: [PATCH v4 11/35] kmsan: Allow disabling KMSAN checks for the
 current task
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Marco Elver <elver@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Pekka Enberg <penberg@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Vasily Gorbik <gor@linux.ibm.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 5:39=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> Like for KASAN, it's useful to temporarily disable KMSAN checks around,
> e.g., redzone accesses. Introduce kmsan_disable_current() and
> kmsan_enable_current(), which are similar to their KASAN counterparts.
>
> Make them reentrant in order to handle memory allocations in interrupt
> context. Repurpose the allow_reporting field for this.

I am still a bit reluctant, because these nested counters always end
up being inconsistent.
But your patch series fixes support for SLUB_DEBUG, and I don't have
better ideas how to do this.

Could you please extend "Disabling the instrumentation" in kmsan.rst
so that it explains the new enable/disable API?
I think we should mention that the users need to be careful with it,
keeping the regions short and preferring other ways to disable
instrumentation, where possible.

> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

