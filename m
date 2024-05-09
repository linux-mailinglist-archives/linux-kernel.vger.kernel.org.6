Return-Path: <linux-kernel+bounces-174771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D4C8C14C0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 20:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 289F41F21B6F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 18:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7D977110;
	Thu,  9 May 2024 18:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B7focNjW"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977ED770E9
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 18:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715279363; cv=none; b=mYAaClvRCTzNM5z1aRULzi/RrWPX2jW6AI+85clsbN4R9RMUK//lHrrHakS04drwVE7DIGmr/sNFGvc5jSt8CPzblow/bw2VkCJGBm3s8GaAkNFvZWYkzupx7GMDTJ3X9WNRDcVnsIWSTxBpDBxjxX2UJRbUxWO8nEKmplX+APc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715279363; c=relaxed/simple;
	bh=793HW6htL8B7/EsJYrL/cvujTrb5WJgtWEB3ehJFwXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GHekogzjgH6q6wsGy0cJVQM33TUedwDrz707jLp1WvCKwgXbbws1mo89a8Owa/paYa7Gvs8VFKt91rjTb0+7qNk1OA5ApUBtVzasanodRbWNv18x1PmnbWzf+XnCaLHV5Q58b7vXrkvMaWtW7s/IfihM4C0CbcpkUbp5ttsmnIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B7focNjW; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51f2ebbd8a7so1294681e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 11:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715279360; x=1715884160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQAjRUsko9Xv5LVyLqE7ufxRjR8xwotdk5KDDfiA9ZU=;
        b=B7focNjWR//KDhpi3LrK/kVp1upX2855OlPD4gpAQtZvS6eHMbV2dBZ2hzNN7ru4BH
         PYvEhUSG/Mr3oQuzGOWBGl0TQ7sURqNgKjk4gYZU5TMhdhRS6LeLo2MG/Ozwyrg7bVYG
         fcajn4ERMZsucoFUYyjjnJf3kKisHM+61odwzwFNmxhjzlT5mJ/kt6G7THUfi9/gNwM7
         6IqiU9i+5Y0C3coo/vtKg35vX6EDpWvhtgKcBfVRtHheoSz5T1UWe+C+KbW8TCEw09Qr
         dH+x0SqMTj5xJyQhquZ8iJwA41U0CluIvYG0H8vlUJYQfYxDD9U0ttNEmsF6cAImmdGH
         Bu9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715279360; x=1715884160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LQAjRUsko9Xv5LVyLqE7ufxRjR8xwotdk5KDDfiA9ZU=;
        b=ElQITOpuZU/b1RqqBmxWmnmMFDtGlH0AzA3t2MAW22TQbsESKIaXTcDrSWJPRg8dTk
         jqxe8YGMsaczMQejTHbw3jjFlMHFodMpxsH9d1aLbJKVuz/9EfhQGIEzbSDHoT2apmkv
         3b/9XAxaQlKKAbSEFaO6sCGbvP10bKnzQLwwmvE6DDjd6DaFuCm8CiaZPVfd3gKbPP0M
         ccvqBBFilEDxHDgPQme6oJqY8tjbVucQ/ee6uPakY0PY5uEZP4AJz8xOoJQI8xSzXqXX
         p77XEs1JSdvzWx3upTdF+zKYlHvLL1+woXhrhugmCiQyRanLMJYSaQPSLeggXTQpdAnt
         Hnhw==
X-Forwarded-Encrypted: i=1; AJvYcCXLoLqpmqjx9/SItQGF0YPqmGxzMqEfcLtEey3Ge3xEFNUhFVU2LeQVO6FE0xQg7U4Csvcg5NNPZpcafivvO2vEKe8drw2wBgVrmfvY
X-Gm-Message-State: AOJu0YzYKGH/8GyzUQ82ljfQzQ3FMmRo0QUKtjMfa3MFdaq4bs+hooOB
	JWSnrHWGeI8GubYZYTRqISsACFBab3h1mvFGpPrOJiBy1GYSD8E3DSJ8ObAMblYOl0PvJQzEHBy
	NvUd0hxFFhM/g2Pz4sBlzOet4GnoZSv88soNt
X-Google-Smtp-Source: AGHT+IG+8Ejr6qcc3S3W3yr6Vnr/kT7otr2hV9t+oxu+LmkMtocXimlWMUEFunG2Y7MSbuWTyYLew2/NcnazK+3HXrE=
X-Received: by 2002:a05:6512:60b:b0:518:d3f5:e6d2 with SMTP id
 2adb3069b0e04-5220ff70b4amr205786e87.51.1715279359569; Thu, 09 May 2024
 11:29:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418012835.3360429-1-yosryahmed@google.com>
 <CAJD7tkZmDQi2HBOxe5u-Lji88NDuZKCQ_=N_O5aE1nq23aUPqw@mail.gmail.com> <9531f1fc-f91e-40ce-9432-5bcbba2fe2f7@intel.com>
In-Reply-To: <9531f1fc-f91e-40ce-9432-5bcbba2fe2f7@intel.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 9 May 2024 11:28:41 -0700
Message-ID: <CAJD7tkb7wz2P17pehTQtqjueMUxGaUOpFwzoQr_V39npOwuy7g@mail.gmail.com>
Subject: Re: [PATCH tip:x86/mm v3 1/3] x86/mm: Use IPIs to synchronize LAM enablement
To: Dave Hansen <dave.hansen@intel.com>
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 11:22=E2=80=AFAM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 5/6/24 07:37, Yosry Ahmed wrote:
> > The merge window is approaching, is this patchset ready to be picked
> > up? Is any further action needed?
>
> Yosry, the merge window is when we send content to Linus.  We generally
> create that content weeks or months before the merge window.

Right. The patch series has been idle for a long time so I assumed it
was going to be picked up for this merge window, but given how close
we have gotten I think we're past this now.

That's fine, I am just trying to get some clarity on whether anything
else needs to be done for this to be in a mergeable state.

>
> The best action on your here would be to touch base with Andy and make
> sure he's on board with the solution you think he suggested.

I have been slightly pinging the series and/or resending every once in
a while, trying not to be too annoying :) Hopefully Andy will voice
his opinion.

