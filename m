Return-Path: <linux-kernel+bounces-299324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD42E95D2FF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 18:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F227A1C23807
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 16:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E2318BC2D;
	Fri, 23 Aug 2024 16:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8bKoUfM"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB0618BC2A
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 16:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724429827; cv=none; b=CYz3mhhfYyl1eULD85KG52kYMfMCAjABphLlV9nigHrHbqewLfKQeyLGO2AKipG1RGopL26UQTMY41UxOH+gBVnYUL4oOH0EHv5qysnYPRRz4SJpUJYvpYJ70IaWfk8lSVuLPtX8kj5s2u8Ys8pua+VtLM44dR3NLaJoQ1WaaSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724429827; c=relaxed/simple;
	bh=flB7OHR5QrKHPhbrF3On1DA0RFx/CeDMftCyKCVbPiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g+kou5Z0Zc0tJW/rrWL3toiObj2oGCsxVv/8ocKj5S2vu29+/Y4QZA+AhECPDZNoM0GIn8uoRoHG231VeI5A2XhBuds0qZZJDgAFYWhwcdX/OHZtI8RQflaurxjkcGyvmmN+fvM+79vaTvhyMYIZ0RUskLRIwFMw32M0XY2+PpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8bKoUfM; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6bf999ac52bso10036646d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 09:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724429825; x=1725034625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=flB7OHR5QrKHPhbrF3On1DA0RFx/CeDMftCyKCVbPiY=;
        b=Z8bKoUfMG3AXU/rU5Cu7/9NBPY/nAkoJsvO3WnEF7++Pp+MZS81wMm+/9DIZP91axp
         owS2VYu+8xCdWhZoPEmhiyVcplRTPegfpaBRXpLGM2/FU+o0UtuzGB1ayyvZW1Ex8k72
         AlKZ+idasbrGo455Qi/TM79Hw7y243joLx0auYp/RPsXN4Rcno86CKOqhmEJnap6SM16
         /H/qaUJqJQRzCAE3Iv16RSU6uALyd+Mrz2elbk0NT7SJ9xxHXxGVvH1AvRoWZrUd0vbZ
         P4oUbhMAUq4F59leqabD9vmgYFUFqiwGVzOZbihH6fI18pCTo2cvgulQ2RUZf6naHsuw
         vUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724429825; x=1725034625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=flB7OHR5QrKHPhbrF3On1DA0RFx/CeDMftCyKCVbPiY=;
        b=WocrwBVzCPSOmnAUUYh1SxEyXec6F7lVWHLWYTpJeavpPfp88xIIMbabprSP67g6iT
         4dG6wMSleu0SIY5OcQDiEqbDOSsHxIjKxREm6tsfVRN0+5zJfYYV0gqzZYo+qKCxtz6t
         zrOgwAARgRUQ29sqHeCC6xNUOadCtjq5/zc5TW3hzP7u9WBPdGiMB0J5ER1uP1jstYb5
         Vk2vDqyM3lcnM1HiPjb1EI4kxrOGvwQ4N0XIC0iL6suL8E4WyFc4rlSn1u+6Irqn32HU
         Y+d5i4HUt4yQVS8//CdotPeiSS+00ABOCXxRNZzLtc4rCN/zOjLT8oDzgMG7N5DlmpnO
         oafw==
X-Forwarded-Encrypted: i=1; AJvYcCWcR6oj3ssj8ZMezafbtuWJ2P8/p6tv64pP1w+/v/7aRvUPYSNu38n9Nv/WDmkUHY+3EnuoMHT/x1fCrUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXJ7uPzcPxFyaFCc7IvapwHh+zspDL4O1TPIEEuVVLcu9fiIJP
	ZW7cffQQuTe0j8Vi4qL51ZO9AzKp9BWeUkp+sDIuYoPUpC53RBDQ5mGQvZu2IUv7kVEk9kANGOs
	ia273NDWYuIxeHsu/G842twaOBEg=
X-Google-Smtp-Source: AGHT+IFL358z/bGmiPDknmSO46yYht9Fbjiric2FHtiPjzBP0j8i9TbAuhNt5ETwz3uYpEPLaVomzadAPZWLpJ7izO0=
X-Received: by 2002:a05:6214:3a87:b0:6b5:e1fb:68ee with SMTP id
 6a1803df08f44-6c16dc7ca9dmr33223576d6.25.1724429824918; Fri, 23 Aug 2024
 09:17:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <BD22A15A-9216-4FA0-82DF-C7BBF8EE642E@gmail.com>
 <6f65e3a6-5f1a-4fda-b406-17598f4a72d5@leemhuis.info> <ZsiLElTykamcYZ6J@casper.infradead.org>
 <02D2DA66-4A91-4033-8B98-ED25FC2E0CD6@gmail.com>
In-Reply-To: <02D2DA66-4A91-4033-8B98-ED25FC2E0CD6@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 23 Aug 2024 12:16:53 -0400
Message-ID: <CAKEwX=N-10A=C_Cp_m8yxfeTigvmZp1v7TrphcrHuRkHJ8837g@mail.gmail.com>
Subject: Re: [regression] oops on heavy compilations ("kernel BUG at
 mm/zswap.c:1005!" and "Oops: invalid opcode: 0000")
To: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, LKML <linux-kernel@vger.kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 11:07=E2=80=AFAM Piotr Oniszczuk
<piotr.oniszczuk@gmail.com> wrote:
>
>
>
> > Wiadomo=C5=9B=C4=87 napisana przez Matthew Wilcox <willy@infradead.org>=
 w dniu 23.08.2024, o godz. 15:13:
> >
> > I wouldn't be surprised if this were dodgy ram.
>
>
> Well - that was my initial hypothesis.
>
> in fact i had few of them. Ranked (and ordered) like this:
> 1. downstream kernel patches
> 2. hw (ram) issue
> 3. kernel bug
>
> So full history was:
> -build myself archlinux 6.10.2 kernel; upgrade builder OS (only kernel; n=
othing else)
> -run normal devel process and (to my surprise) discover interrupted CI/CD=
 builds by kernel oops
> -downgrade to 6.8.2 and done 4 full builds (full takes 8..9h of constant =
12c/24/t compile). all good.
> -prepare vanilla 6.10.6 (to exclude potential downstream (ArchLinux) root=
 causes)
> -run normal devel process and still discover oops
> -make sure hw is ok by week of test with 6.8.2 (recompiling for 3 archite=
ctures on 4 OS (3 in kvm). This was almost 5 full days of 12c/24 compiling.=
 All good
> -because last steep was all good - decide to go to you :-)
>
> sure - this is possible that 6.8.2 had luck with my ram and 6.10.6 had no=
 luck=E2=80=A6.but i personally don=E2=80=99t believe this is a case=E2=80=
=A6.

Have you tried with 6.9 yet? IIRC, there are two major changes to
zswap architecture in recent versions.

1. In 6.9, we range-partition zswap's rbtrees to reduce lock contention.

2. In 6.10, we replace zswap's rbtrees with xarrays.

If 6.9 is fine, then the latter is the suspect, and vice versa. Of
course, the minor changes are still suspect - but you get the idea :)

>
> btw: we can go with elimination strategy.
> So what i need to change/disable to be closer to finding root cause?

Could you let me know more about the setup? A couple things come to my mind=
:

1. zswap configs (allocator - is it zsmalloc? compressor?)

2. Is mTHP enabled? mTHP swapout was merged in 6.10, and there seems
to be some conflicts with zswap, but Yosry will know more about this
than me...

3. Is there any proprietary driver etc.?

> swap?
> now it is swapfile on system nvme
>

