Return-Path: <linux-kernel+bounces-340324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C959987199
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A88E1F21BD2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCC51AD40D;
	Thu, 26 Sep 2024 10:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGtFvE7S"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F3417BB30;
	Thu, 26 Sep 2024 10:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727346863; cv=none; b=kJiakibk/ReniBeaxDSZaJfGGe5mN6un8012JbGztdOZDyagooLDy0WqGLaZ5D2cqAQeow9Y2EEVzk25UUGR0+KTocjj5i/o8tcyFbf43Q8PXXnvnxFx2W/z4Zt7o+evo7/fv/m0TqnADRSArxJI1EscQ0c/Z/mDbdCvpYB8AGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727346863; c=relaxed/simple;
	bh=FvK9bOmpHob78lnfVZY4lnbnpriICJ+yitRchRcmfOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EznpRl34HGKvPEvOHMPsJTfb4jTjW1P9A9LRAW5E4Zy29YN8raQESgUizfqaxbqu/ZTyaCC8iIwrJf572elI25IJNfmB5pznScdmg8FhcFtZarssVUfxKYE4SbbJkB0WCY9AeUflvwoXtmPnmD6zOztux34lek48VQdyejp65oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGtFvE7S; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-718e65590easo70851b3a.3;
        Thu, 26 Sep 2024 03:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727346861; x=1727951661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FvK9bOmpHob78lnfVZY4lnbnpriICJ+yitRchRcmfOA=;
        b=RGtFvE7SfwGJaWQlTmpE/YZgGgvT5soaKCgjkg1mWSAUEUtv8uh2VV7bmBlc49pYyu
         YHHANqHexk22iDQNlZh5lyMnoEmCnwfZvYvQ+df8uB8ikKZ1faX2vLn+qumqyLzLyc8L
         j8WyiAQBDK+9H4VCURlY7gcMpd+B/Z/ZcaHA41BTwYAQ5/HIXqKwSQ7kvNmAlqpqgIke
         ayQ22UdhLb4qnNMKE3bxREMpKJ+pRenbfA0UKjjDpkmfmny27nqIjaB3p1fR7hn7TPSH
         Ud7ez4CW1TSQxSKAkzp3MParG0OT3W1cinLfwJydVz/yaupoojkATKy7Pxki38/TWYWv
         vPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727346861; x=1727951661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FvK9bOmpHob78lnfVZY4lnbnpriICJ+yitRchRcmfOA=;
        b=oNFAyQnxOyfS5zKfbGFMbu+CNVRW4D96YFQXBtVyAlG7eA4z1oap3JAs1fgOGsKFu1
         WHJVrDMxEVAIgL8OJcQQCg4zWrlZvwGBZ5rJxI1QdkwCaCws2ejCFjXxZJQurwg1H4Ii
         6NrggUxwnM5pXabzZl9yks/JeqG8T+9/c6jxLE2wSks+InQoIQbGDq3x3Lj3fZvJhImI
         jCOxgI4KMll3+BIgasnaOGe8bppICvX03x/8XrkZ7luWsuUft9kYyPQWCtZmiW+BPxDm
         yZep/J9K/M/nBiWWcRn4H5aJK+KPHEwQlqCINSUmXXlqL1mtnmcZC/yy48MMnnRAwVQs
         VbOg==
X-Forwarded-Encrypted: i=1; AJvYcCUkMMYM+sDx31rN/f1SLHVfvrg/O4BOAeh3MVo46dSfqgKCO1ej7Pq0wXQ9++VaIBY9cReI9RCKCncCybsgNW0=@vger.kernel.org, AJvYcCVwtiG+1THUVx1yO6tIi9r+mfxrML7VVEDG3POMj064qoW9rZOP+09MnJJvtzfz/lYE2Uu+4V1R3zLJJJU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi9cmn5cX/l2X5Qoz5FFzPcpsZwIPvOjpTmTQWx6kv8gRQ5J19
	syMWsdxTSvMF02uC2WjlKo6lU/nATKn8yR4C1My6AntC/kcPCK8FMzhwj6uTHMOZxxDvoHzeYMS
	kPS4gWBlx20rbzNjIdLG9TtFJ3ZI=
X-Google-Smtp-Source: AGHT+IFYST7+3bz848eQMnGBwxKA6843dw8fjWPNfnAQ7+K8F2PTQLVQOR9ByqppG/f1A5mi3kwJcf61gyy/DZtuy8Y=
X-Received: by 2002:a05:6a20:1595:b0:1cf:3be6:9f89 with SMTP id
 adf61e73a8af0-1d4bed207ecmr4315211637.0.1727346861317; Thu, 26 Sep 2024
 03:34:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926093849.1192264-1-aliceryhl@google.com>
In-Reply-To: <20240926093849.1192264-1-aliceryhl@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 26 Sep 2024 12:34:08 +0200
Message-ID: <CANiq72mGsevNqECufBo6EP8cxFd=vwcXDpVdsgts-Ve0+mPkrg@mail.gmail.com>
Subject: Re: [PATCH] rust: KASAN+RETHUNK requires rustc 1.83.0
To: Alice Ryhl <aliceryhl@google.com>
Cc: ojeda@kernel.org, a.hindborg@samsung.com, alex.gaynor@gmail.com, 
	benno.lossin@proton.me, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, gary@garyguo.net, hpa@zytor.com, 
	jpoimboe@kernel.org, linux-kernel@vger.kernel.org, masahiroy@kernel.org, 
	mingo@redhat.com, nathan@kernel.org, nicolas@fjasle.eu, 
	patches@lists.linux.dev, peterz@infradead.org, rust-for-linux@vger.kernel.org, 
	tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 11:39=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> This is caused by the -Zfunction-return=3Dthunk-extern flag in rustc not
> properly informing LLVM about the mitigation, which means that the KASAN

"...not informing LLVM about the mitigation at the module level (it
does so at the function level only currently, which covers most cases,
but both are required)" or similar?

> This is being fixed for rustc 1.83.0, so update Kconfig to reject this
> configuration on older compilers.

Yeah, let's go with 1.83.0 as we said -- we can modify it if needed
later on. I think the PR is fairly straightforward so it should
probably land in that version unless there is an unknown unknown.

Thanks Alice, looks good to me.

I will take this one soon.

Cheers,
Miguel

