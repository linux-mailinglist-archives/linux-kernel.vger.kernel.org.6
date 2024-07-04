Return-Path: <linux-kernel+bounces-241491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C41927BDB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81E821C231CB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F79F3B79F;
	Thu,  4 Jul 2024 17:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="J13W3Cxc"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7CC39FD6
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 17:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720113715; cv=none; b=bfZ52fM7U9vESVXfHx/g0qsPFTOZIyIB2sJugyfb96p+ps0vIXqaigmS8HERBny+FSCLWrFbSW+P3sWLS6VKec6yBNw579ri8nx10+/n5xxEyPFg/XCfI/BKCuCKIliWAmKTHYLKlBabxtHxJVoO9ggA5k7INTykRYeTCll3M1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720113715; c=relaxed/simple;
	bh=9ef5A7y80msba590+oipUmON56QOJUNR/WjFyH/KUVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F7a2o3/5Eiwv0a9feV83v69YP7W+IAdkKp6p07Oa0iDQIyWcIOW6AvuWo5p/Ts1g641jTsro5L9GJYMP0sgNJpPzR75Xu8MrW5ytCi5ed6cKPkdQImgtt/jtm7x/pc7CDYTLeq9CPO2oXbKfEdvrz1mE9QkVzRDvJpOlblPfoEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=J13W3Cxc; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ee75ffce77so10468881fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 10:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1720113711; x=1720718511; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DetDEHP2EiTR5k+8vmbxRHmyuu1O/rRB95hogFXnegU=;
        b=J13W3Cxc882rmyJzsAtI5b+UfxL8v53iY9EF28pqX8DCnzENtz4a53VBMZgTaa5mg3
         NCtx9ERM1P5BOWns0K5qemq93KZyMRnzXXWiE/4FYQkqdYBZsSNIecoslW85Jobvjsi3
         ebOtaAtNqxnOALIDJvhoDwLm5u/Oem7FpS1Kk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720113711; x=1720718511;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DetDEHP2EiTR5k+8vmbxRHmyuu1O/rRB95hogFXnegU=;
        b=OBN3Z3Ntqb4Z6Ad3apcdKiRqAlhNv47GKITOAfHYtMEkysXniJ8ntofz45AJddr9JW
         L9t6UAuX//IAo2Vfn9Il1CHKL1jBshkgDnWG8ZLX5cJKNlpVDQQ0vHvPL2uMEWEngE6D
         Z/t7ujmZiXblIhcqj1hTCd2v6e0BZJKOq4K1mRF6hivAE+L0S1b1igTxX0RuNYVd43Zl
         4tLizRGLkhxL0w7sEfv/BPxVE96rp5RL7fEVDFeyfBGEpMyZmNy070PWwuYjAhZRnT9A
         S2xHTEAf0wOQnAdgrFVdw8ByAkCIMoRRpYjA0DlvFYzogzDVRFAsvLuhu+ckhmMdisc8
         ZQwA==
X-Forwarded-Encrypted: i=1; AJvYcCUOgnIyPBKgWsxyMhRY97l7dO5Q/Yp6EEEhc65iz9UQNCjLAf6+bdZW8YMBDoxix5OL+LPsS5xBgG7vV9KVj3p8jB12xoF7Ac8Bj4Mn
X-Gm-Message-State: AOJu0YxWtScVa1OZqoFpDcg0td1UjRp6n4jDJON1ICb5rIYO3UYdSNfo
	QTENW87a5eGvcnRI5iVLNnwpiTmvwl0MGxUPol1uyTVuce4SsmmEPuvc3BBPsVqot1nymygvJv5
	9F1YLwA==
X-Google-Smtp-Source: AGHT+IFdZ0XvQvTapn2ZuRYZVz9MOwjiZxq1BcxSyNSCbB4S3HU1dht5yoL8Vi4+G+SLzhNQBUBHrA==
X-Received: by 2002:a2e:2205:0:b0:2ec:165a:224d with SMTP id 38308e7fff4ca-2ee8ee0e7a1mr19369971fa.38.1720113711480;
        Thu, 04 Jul 2024 10:21:51 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee8aa4ba62sm4026971fa.64.2024.07.04.10.21.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 10:21:50 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ee75ffce77so10468551fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 10:21:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUEvh5MqAmIehPXzENKHXLh7cTn+2KH2ONyeRrC/VkJV0FuSVRnflUDMvYTvagOrdpMAQ8YY1N8YZjRgXWlgVHEnKe5zGwrX8mqHx6/
X-Received: by 2002:a2e:8789:0:b0:2ee:8817:422d with SMTP id
 38308e7fff4ca-2ee8ed69ce3mr18811771fa.5.1720113710184; Thu, 04 Jul 2024
 10:21:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZobXdDCYBi8OM-Fo@zx2c4.com>
In-Reply-To: <ZobXdDCYBi8OM-Fo@zx2c4.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 4 Jul 2024 10:21:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiGk+1eNy4Vk6QsEgM=Ru3jE40qrDwgq_CSKgqwLgMdRg@mail.gmail.com>
Message-ID: <CAHk-=wiGk+1eNy4Vk6QsEgM=Ru3jE40qrDwgq_CSKgqwLgMdRg@mail.gmail.com>
Subject: Re: deconflicting new syscall numbers for 6.11
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: jolsa@kernel.org, mhiramat@kernel.org, cgzones@googlemail.com, 
	brauner@kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jul 2024 at 10:10, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> The three of us all have new syscalls planned for 6.11. Arnd suggested
> that we coordinate to deconflict, to make the merge easier.

Nobody has explained to me what has changed since your last vdso
getrandom, and I'm not planning on pulling it unless that fundamental
flaw is fixed.

Why is this _so_ critical that it needs a vdso?

Why isn't user space just doing it itself?

What's so magical about this all?

This all seems entirely pointless to me still, because it's optimizing
something that nobody seems to care about, adding new VM
infrastructure, new magic system calls, yadda yadda.

I was very sceptical last time, and absolutely _nothing_ has changed.
Not a peep on why it's now suddenly so hugely important again.

We don't add stuff "just because we can". We need to have a damn good
reason for it. And I still don't see the reason, and I haven't seen
anybody even trying to explain the reason.

              Linus

