Return-Path: <linux-kernel+bounces-530206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09596A43082
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 00:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CD097A18AB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 23:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9351B207A18;
	Mon, 24 Feb 2025 23:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IwU1ezg9"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8971FFC45
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 23:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740438436; cv=none; b=Tw2bn4zBy189VewLYJdTVMAzlqb99EFDjiCqu/0QN8H7ZkmknWeF1tZ6Qa1QugLb4v+O9LQPW7kfVvko77JiIf6hT3JttE501Ff62MZ+1kKFSeUhdvUyWBXBdwtmxMHmCQYczDU8F+zi5WPChHuD0xrCgJn0rKwLeZd+F00aQDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740438436; c=relaxed/simple;
	bh=FYfFMWiTzduSPtbvpZ0Pkv9pDjTpRTObNnikiDKwKYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pc61jMjgSOmykWBtJpNRMB7YDzyGHySy5LpKriiaX6JITRwX1UqFVE8s0L+2ai/YaDU3qjJoRHCbxVKP0qcVv9V02bzGmrlU5kExNUfTzS+Z6K401kZPE2z1Xr1e3KeccmZW65FFom+PEpzOhgTI2JwPMcj8JU+NEBV8POf1X0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IwU1ezg9; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-724daedf8c3so1283652a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 15:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740438433; x=1741043233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gt7M2cm9mI5eYr0nERX+qOY3z3eWRP2n3iQJDxTpkO4=;
        b=IwU1ezg9yFX8REbX70AWUvgJLlfygynQGT9OQl3mQmsKmY1Z8wfb42p6S2T5nG/1CZ
         Mx0MImm5cfkZedJfbk2PKz7F4FL6QRgZQX6H4vJZcb1do0WegnUkjAiDDaYU3q89mIG2
         568cdQ59KLnakjdjCWTPqJJk2vG+/NxOK9NkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740438433; x=1741043233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gt7M2cm9mI5eYr0nERX+qOY3z3eWRP2n3iQJDxTpkO4=;
        b=FkUARrTgwdVYIxIjcxJejW+F1zcuRQBa1mQoBXde1hD/87Z9+NgjEwUxtNIfHj7ueP
         44lQ4IkisrrrvxVv31QeH3B02pqksSiZUt6E894c7cl2Do084X6F/pTXQAaVxGjxDI5D
         wi+VJIww4qbnVocYuDLfYa8E8Dm+cEGV/7SExboSMk55E2hnwfMuwT0+iRteELZm5dmE
         v+vC+gJHBQb72Sw88aUm0SJknFRI3gAQEcsS0td5I540Pr+PjMUvZ4RBML8Hu+R1hcXO
         LNAK6wI24QGLJL9o/jpvsB4NBnhWDwIGAJSlUj9S89ZRh4m+q90CLZLsJFpj4YMcdN+s
         Fxkg==
X-Forwarded-Encrypted: i=1; AJvYcCXbzNPyIXI9RTl7gj2NeRPcnse779XCLFFg8mMBp0b9KI8BoICvcMuDXhQ48/KJN4hyISB2ON2iZjfVy+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJdWPZdNJO+VjFy/mjbjfceJI0L0B7wcSHj6bKW+gDufVKcnma
	lPmfnOeXQj7vtoivabfGlt9G7RZOKD3kYoF3BhXSxZQQtPe2uLF9o4g+3Dy1K2dqLxdNRkCfB4/
	GSTOALp596JvIZqUVcH+6UNwYSNtouKI3FmSz
X-Gm-Gg: ASbGncv2P92NGfFN3NiY2OmvH3esaj6x02osAHwYO5HzBt/GQiIMc9aRneCZ3RmnlEV
	yViPT/rTxXK0c6aSGHugewG0ZrkSqDHvYWj8QfTCrUF4QAuIW97tjizBpUSDuIvvQaxJ/Yp5ykr
	HlUkmu52g1WkmQKUaBTdp3qdFLacqgllQBHnuM
X-Google-Smtp-Source: AGHT+IEP4PV9DNBhdrXRh+chy4n1/lVYXwdesM2YhvWLjUuJsbctZ76XazgP1D4104ECH40KdG2B3ht8gtQ3Gkm0fcM=
X-Received: by 2002:a05:6808:191e:b0:3f4:23ea:f9b9 with SMTP id
 5614622812f47-3f4246b3c3fmr4357094b6e.1.1740438433475; Mon, 24 Feb 2025
 15:07:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224225246.3712295-1-jeffxu@google.com> <CAKbZUD03mBKVfOTQ4me79bZTLgWP8QLyD1PSxTcpw2YPmtsyUQ@mail.gmail.com>
In-Reply-To: <CAKbZUD03mBKVfOTQ4me79bZTLgWP8QLyD1PSxTcpw2YPmtsyUQ@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 24 Feb 2025 15:07:03 -0800
X-Gm-Features: AWEUYZlNlJhjCemXFyWfsLbYFok5NAL1CEToK9WkF-XdBylNHUu_GFihHhpgA0Q
Message-ID: <CABi2SkUaUMTS06mKm5_k7m=NpfyDR=L45xqp1i+FkvPJHT4-TQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] mseal system mappings
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	torvalds@linux-foundation.org, vbabka@suse.cz, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, adhemerval.zanella@linaro.org, oleg@redhat.com, 
	avagin@gmail.com, benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, 
	sroettger@google.com, hch@lst.de, ojeda@kernel.org, 
	thomas.weissschuh@linutronix.de, adobriyan@gmail.com, 
	johannes@sipsolutions.net, hca@linux.ibm.com, willy@infradead.org, 
	anna-maria@linutronix.de, mark.rutland@arm.com, linus.walleij@linaro.org, 
	Jason@zx2c4.com, deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, 
	peterx@redhat.com, f.fainelli@gmail.com, gerg@kernel.org, 
	dave.hansen@linux.intel.com, mingo@kernel.org, ardb@kernel.org, 
	mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com, 
	enh@google.com, rientjes@google.com, groeck@chromium.org, mpe@ellerman.id.au, 
	aleksandr.mikhalitsyn@canonical.com, mike.rapoport@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 3:03=E2=80=AFPM Pedro Falcato <pedro.falcato@gmail.=
com> wrote:
>
> On Mon, Feb 24, 2025 at 10:52=E2=80=AFPM <jeffxu@chromium.org> wrote:
> >
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > This is V7 version, addressing comments from V6, without code logic
> > change.
> >
> > --------------------------------------------------
> >
> > History:
> > V7:
> >  - Remove cover letter from the first patch (Liam R. Howlett)
> >  - Change macro name to VM_SEALED_SYSMAP (Liam R. Howlett)
> >  - logging and fclose() in selftest (Liam R. Howlett)
>
> Jeff, please don't send out new versions of the patchset that quickly.
> We were having a discussion on v5, you sent v6 today (acceptable) and
> now v7 (while changing barely anything of note). It's hard to track
> things this way, and you're just flooding a bunch of mailboxes.
>
Ah, I apologize. Sure.

-Jeff


> Thanks,
> Pedro

