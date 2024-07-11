Return-Path: <linux-kernel+bounces-248585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AF392DF4E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 07:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1626228441B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 05:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B164EB5E;
	Thu, 11 Jul 2024 05:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RXy0+mo5"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D35F20312
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 05:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720674445; cv=none; b=URsFb1UdoK8F9R2BQzSn1pA0n9Bq4VsTZGK4pSWVyQAso17tqrUzIPPIgymsC5QsJt3rJz3pbn0c2CDl+SYP/noPiUadGKXilskLyt0gb+6dRmDNx/ZfZLGcSGYbkUFIapIbux2UwfK1H92jrj2gBmFmlK0dCdrvsMaOX2pubIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720674445; c=relaxed/simple;
	bh=nGrmC0u5rsERqyefhRnP7/QKTu/yo7p7qovzWnDCLCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q368wF1LTIWsJTiu15Vf9AvDv4AjVQ+rhUiie06CAgG7bESEEv767OdimZ/MXmW+u8NefVIWSfCTvqsTrtW4qCiKtmw2+6TEZr8Is1Z5Eq+z7NEDzGm+aHz3kVWp/4gA4+bgmEdobSRg3oMkecZZbAOED9Ml3QCrp+rm7xWmhOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RXy0+mo5; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52ea929ea56so903399e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 22:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1720674441; x=1721279241; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jtRyIrmKJ/IBvDIrDZPP2KUo8CcYvxcVDEjZhvnGRqk=;
        b=RXy0+mo5hbsP45mTrYWpL6eRHuOma/hVAKKp2XMJ9Bm0bfyKGnFVulb8lDNLJQAvv1
         Y+yoSyEMespaUGRm6QS8wbQtevJvmMMSfsM2x9klMjvvU1Kz6FWKWksv9OLaaBSxTVbe
         ZL0Wj3wMz5GJ6puJU55vfqeXSajkpA6DKsThs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720674441; x=1721279241;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jtRyIrmKJ/IBvDIrDZPP2KUo8CcYvxcVDEjZhvnGRqk=;
        b=bZ13opm5v89WUjwFXFfs0GbGCuLxwv4ch48+jBN+uDxTlX8rPeCrX75YfuJUJA/yed
         bcPmtNHmFqT6zT1aYECpCip2C683/SGW9h9MqwwxSPxSfupnvYds/ciXBQWcUEzfobSy
         J5eZY2Mp07R5GA7mbDOHNgwLLDOMvpklqfYOi4rfwV2+NzSgTulm8NNRYieLLIstmJ+6
         wRv7N/rLAy0DhleER1B6cw85yDeUaLUlLgOf5VLdktXOp8eEJMDidpFwQmVPkaxDFldv
         y8IS01sG0QT/9U1759q8OanKNxc3FBILBz03teNA7qNe1jz89nj7VcDYmczoOoEI5be6
         vAWw==
X-Forwarded-Encrypted: i=1; AJvYcCXNQKJ54iWL51GZA394vG6IGaHEagEOaf2MTqxRAWJLnP0YqPXX6uYBknPqBoqD0i1zBTKaUxUEZI5W84utkGKa/kPawRyUo4bQ1Z/f
X-Gm-Message-State: AOJu0Yx0S9JLruTChZvBm6hIT6I7aTqXkpkZLbfE7BfXuZ6Y1sUA62ts
	EdFFh7nNe9N8nA1MhPFZsQ629Orbmof1Vr98TqTxYmTTuL3z6HcK/yQZXDBzr08ZhtYxX4MK9Kn
	v
X-Google-Smtp-Source: AGHT+IHHTbSejddUZrg6ymBfC6gDheXkdoWLUQ2K70Cwk7rvgFtn4roWkRLuH5hNZNTDYwYpsnauQg==
X-Received: by 2002:a05:6512:1106:b0:52c:83c7:936a with SMTP id 2adb3069b0e04-52eb99d2717mr6110075e87.42.1720674441250;
        Wed, 10 Jul 2024 22:07:21 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a7ff282sm220869066b.130.2024.07.10.22.07.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 22:07:20 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa6b3so321867a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 22:07:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWBcUxrkkieJvmYunmxnn1LSNUS4En2sAAklfkKDnIndhMw4aRywOnCACORvifyYRKVLzbyT0RqMDABtbgdo2qBy5iB0TInxQLlcS8k
X-Received: by 2002:a05:6402:134f:b0:58d:77e0:5c29 with SMTP id
 4fb4d7f45d1cf-594bb181cb8mr5703709a12.10.1720674440224; Wed, 10 Jul 2024
 22:07:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709130513.98102-1-Jason@zx2c4.com> <20240709130513.98102-2-Jason@zx2c4.com>
 <378f23cb-362e-413a-b221-09a5352e79f2@redhat.com> <9b400450-46bc-41c7-9e89-825993851101@redhat.com>
 <Zo8q7ePlOearG481@zx2c4.com> <Zo9gXAlF-82_EYX1@zx2c4.com> <bf51a483-8725-4222-937f-3d6c66876d34@redhat.com>
In-Reply-To: <bf51a483-8725-4222-937f-3d6c66876d34@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 10 Jul 2024 22:07:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh=vzhiDSNaLJdmjkhLqevB8+rhE49pqh0uBwhsV=1ccQ@mail.gmail.com>
Message-ID: <CAHk-=wh=vzhiDSNaLJdmjkhLqevB8+rhE49pqh0uBwhsV=1ccQ@mail.gmail.com>
Subject: Re: [PATCH v22 1/4] mm: add MAP_DROPPABLE for designating always
 lazily freeable mappings
To: David Hildenbrand <david@redhat.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	tglx@linutronix.de, linux-crypto@vger.kernel.org, linux-api@vger.kernel.org, 
	x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, "Carlos O'Donell" <carlos@redhat.com>, 
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <dhildenb@redhat.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Jul 2024 at 21:46, David Hildenbrand <david@redhat.com> wrote:
>
> Maybe we can find ways of simply never marking these pages dirty, so we
> don't have to special-case that code where we don't really have a VMA at
> hand?

That's one option. Jason's patch basically goes "ignore folio dirty
bit for these pages".

Your suggestion basically says "don't turn folios dirty in the first place".

It's mainly the pte_dirty games in mm/vmscan.c that does it
(walk_pte_range), but also the tear-down in mm/memory.c
(zap_present_folio_ptes). Possibly others that I didn't think of.

Both do have access to the vma, although in the case of
walk_pte_range() we don't actually pass it down because we haven't
needed it).

There's also page_vma_mkclean_one(), try_to_unmap_one() and
try_to_migrate_one().  And possibly many others I haven't even thought
about.

So quite a few places that do that "transfer dirty bit from pte to folio".

The other approach might be to just let all the dirty handling happen
- make droppable pages have a "page->mapping" (and not be anonymous),
and have the mapping->a_ops->writepage() just always return success
immediately.

That might actually be a conceptually simpler model. MAP_DROPPABLE
becomes a shared mapping that just has a really cheap writeback that
throws the data away. No need to worry about swap cache or anything
like that, because that's just for anonymous pages.

I say "conceptually simpler", because right now the patch does depend
on just using the regular anon page faulting etc code.

                 Linus

