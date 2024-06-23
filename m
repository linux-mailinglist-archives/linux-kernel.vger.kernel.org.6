Return-Path: <linux-kernel+bounces-226318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C71913CF7
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 19:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE9421F228E0
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 17:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7F0183095;
	Sun, 23 Jun 2024 17:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bCUV2wVS"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0DA183068
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 17:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719162369; cv=none; b=k0SLhabqZuUb065K7HaGC2rvs84jgfOjHhFGnxRZZjfStqniD5/ZAANaWqPauq3Jb0ncXzzr1ggZtnSkoM1jIGVbG8K3XjfXj6wQ1MTjHjj+wq5TuFNn3ncwctD1OP2gVzhBJhKtqrm/anwdqWWjBNIxysT5/7ayODdFtLFVoIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719162369; c=relaxed/simple;
	bh=45LdDu3bOcCKbhXgg4h83UgXbR3JletssymwhGumCDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B/w+6w5AKE2aWA9AL79syAt9KqcyMkAzJRiC5uHHGYegZthIXeW4+aw59q5Bzy4uTH7TQr+32y47lg7RVYDo81lqKNpcLTFQrJ6Y7qogC1XCFtC6mSIouTaKXj2FrZuYZbCMYtD4PGN1yYBrG15CkC/JPAkHBUzm8NBbRgzQleU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bCUV2wVS; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2eaafda3b5cso38438921fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 10:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1719162365; x=1719767165; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J2lcMIrHytzsqZNd1SmlAzfYjjTDrAQdmPKhyqoEJj8=;
        b=bCUV2wVSSoqycZceeirILSUDtlbOvriZVEPs4XZnRjT0EG303lqlevlNMKMTIVw4ik
         aCckcJ0hI76TliUTk5b/yuxNlV+F/l+LxFcZerQa4y8qp9D1V0Os/UZo3ncSFDqxTO6i
         ITYda13gS91P3LGqU39ebmak24hnQn/gI9yRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719162365; x=1719767165;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J2lcMIrHytzsqZNd1SmlAzfYjjTDrAQdmPKhyqoEJj8=;
        b=Zv5vJ1YWCpfn0AWU15MvIHOUsCvhR+RMgLbBpOcfmISPYkw7YJmOjlg7Azh79MuSdU
         +bUHT/uctLSm6+X5ylcumCK13gsQSZhhrABIyYDr/3RXj8+LToJphPg77D5m0NqLQXO2
         HTiDLbGeyrBo/DA0fX5ZPHYi92IxFm79DCJBbEcdbezj5fGP6eMlAwi/Y2OMaoM/a29h
         soeELl+3tjHpCMZ3z0XfD8C1Ly3nevjhxQj/awyILDhq8cPHKluYcjXWyvBhwO0+jdA+
         B9hJPGczz24RHv8NsKnyH0aOs0culNR8LQx6uSFJuUavwzzcpD3NwchyArCIfHX8NoC3
         Uqvw==
X-Forwarded-Encrypted: i=1; AJvYcCUKDr9uYhnmab0XtPfsleqUXtqpS6VkJbG/7ThLvIKmKLglC0PFjQB1BS8jvxHF0SSI1RKInWumjss2gQXOL6l5OGTkAQGcnI1Np64s
X-Gm-Message-State: AOJu0Yz0z+I7Efq1MsNe4DQqUzN5A+opg5nGj4PBFQTodZwCl7NkzbTf
	45xshpnZawrTIwvv1qOhz/HuW0ikw5tkI33YkLB8Ag8JVXRDHVZYSqosEGeoaMG97q1VsP/FUtS
	0OzGAjA==
X-Google-Smtp-Source: AGHT+IFnTTUis3zXRC0cFLejrwXjctV54iT/lmYuYdyeLFyRLieU2FsXpoKhGplvdpm5mPPq2ybNww==
X-Received: by 2002:ac2:5617:0:b0:52c:b606:2b2 with SMTP id 2adb3069b0e04-52ce0673b84mr1749356e87.46.1719162365096;
        Sun, 23 Jun 2024 10:06:05 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cd63b4bf1sm762601e87.49.2024.06.23.10.06.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jun 2024 10:06:03 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ec0f3b9cfeso40620101fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 10:06:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVgGrnpITF7KhrJ5hQlmmeYKBg2Dzg5EP+aI6e414X2LfWu2Du8QY3xxXj5Tyd/bnfKR6hKDzPdkDZ8sWGU2amHolVQVCLh+jjtUrAI
X-Received: by 2002:a2e:3101:0:b0:2ec:1cf1:b74c with SMTP id
 38308e7fff4ca-2ec594cfe8fmr16692871fa.32.1719162363025; Sun, 23 Jun 2024
 10:06:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620181736.1270455-1-yabinc@google.com> <CAKwvOd=ZKS9LbJExCp8vrV9kLDE_Ew+mRcFH5-sYRW_2=sBiig@mail.gmail.com>
 <ZnVe5JBIBGoOrk5w@gondor.apana.org.au> <CAHk-=wgubtUrE=YcvHvRkUX7ii8QHPNCJ_0Gc+3tQOw+rL1DSg@mail.gmail.com>
In-Reply-To: <CAHk-=wgubtUrE=YcvHvRkUX7ii8QHPNCJ_0Gc+3tQOw+rL1DSg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 23 Jun 2024 13:05:46 -0400
X-Gmail-Original-Message-ID: <CAHk-=wiBbJLWOJxoz7srMPtKcN7+9cEh79fzf8GKXTJyRdk=tw@mail.gmail.com>
Message-ID: <CAHk-=wiBbJLWOJxoz7srMPtKcN7+9cEh79fzf8GKXTJyRdk=tw@mail.gmail.com>
Subject: Re: [PATCH] Fix initializing a static union variable
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Yabin Cui <yabinc@google.com>, 
	Steffen Klassert <steffen.klassert@secunet.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Sun, 23 Jun 2024 at 12:51, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I *hope* this is some unreleased clang version that has this bug.
> Because at least the clang version I have access to (clang 17.0.6)
> does not seem to exhibit this issue.

Hmm. Strange. godbolt says that it happens with clang 17.0.1 (and
earlier) with a plain -O2.

It just doesn't happen for me. Either this got fixed already and my
17.0.6 has the fix, or there's some subtle flag that my test-case uses
(some config file - I just use "-O2" for local testing like the
godbolt page did).

But clearly godbolt does  think this happens with released clang versions too.

            Linus

