Return-Path: <linux-kernel+bounces-399946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A94419C06CC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33007B23563
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 13:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D6320FAB9;
	Thu,  7 Nov 2024 12:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s5givOdv"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3A7217304
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 12:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730984366; cv=none; b=Eq+CutVUABLLoxv5P3Z33QbmWS10L67064EPfk2mI3C04I2voQlIxPkl7IsXqBYcOYsZtIpf54oWxfDE991ElHDNTCFE2Kgz9Fnq1PXiyiRik5Bq6drjbb/mATl0GjIjKus9koFZ6Gfm5X+rWWtBe/mATGLegFPIZH7bRcD7uAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730984366; c=relaxed/simple;
	bh=D9azaeqcGPZHNKK8UaHfFN4f10M/JxGS9M2ytkiQKrc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R+CZNEDmn+gT/hOwG+2mjHrRsGl9wiG9apF8MrGSINDL+KQlU2O3RjOqF9kb5zI1SJbe9OBcWWRWAc6NWRzipLZRxYvmXWerJZ/o8c9BokeY4AyADGAOiuIXfBopJVETAQvlkNvOEruziolkriUz2w486A2aecJK6JkvIu0frcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s5givOdv; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539f1292a9bso926464e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 04:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730984362; x=1731589162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9azaeqcGPZHNKK8UaHfFN4f10M/JxGS9M2ytkiQKrc=;
        b=s5givOdvQ1NVeG/2bwAgKn2QtXNV6VS3/HJgUKx1pPBUwUQAj7ZNakd6+N7QJoRhD6
         /x2BN0+9Wi+96A5kVIjp2RTaGtWIbCAdkCuK2trIr+slpmkKcZTQjXcOak6oYbNkbd7x
         x3pozHvM2bSGXLEqyURyeVzdJpUjmi3rTJKVgtetpZobXH4rQN1/HwhK43Ti8GgYqf08
         c7JvP4hSPGRB/dNSb/ea/UedHc9qjS5Gn6/oDr9L0eXZ8u0dFOOEJf+ELn8Eh3ftPCha
         uH42VxxVjeUqzhXnb+Hz2HMsKUJput9kE0o9ivf2iFI9GTVDH7gsVuC7vn0brJJYMTsL
         8rOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730984362; x=1731589162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D9azaeqcGPZHNKK8UaHfFN4f10M/JxGS9M2ytkiQKrc=;
        b=BYjgMhkBVaFg96c6ZIc035NtMGkC/rAf0YWFqx7XU6odSlPTbtSFCUVCb8KXOKWlOX
         dp6abCFVLUdWotd2UrqriXrF1Xicqg3HslnPv6X/Op23FBH7kKrpOHZJCyCS3x/GAk0m
         iBXb+0S+uXtgKHwZeymAaEKhGdnrWvlB48/V6r0dvpdSuuCUhTRvBdw1hYNcw7sskJbR
         SHVZhhK1/rlMAzZeGAN12hIPJn9o94tKFEBpDmVZpGY+UQM3pA7G9U8uTPGnbmuITUhC
         U+n7O5fJ5PHmKaQuwF1CXIy0Z7MoQVtekIYkvr/UV7MBwcYxCU8hB9zOVNxU/gTF6QYh
         cv6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVib3TA0efp1VoDTbGFp7WAZXAX7M9prtwzLMWMOMZnZ5LTKLeQ6Za9rcFVNs4x1mdEgjJhkgDhWiDx4y4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1Gm6LXVDxm3cKwGcJ23DTR8hjLwhUZDqUIYTlNGl1X4j/cEKF
	9yX2tjdQ7vAvH7gqFt7lyDOp64ItD2P99JvjvJWSumZ7VutiE5MipjmnEJVRE3W7h5Dr7TtE/ek
	rkhm6rlNUk1oUDp0etnAVYalfIBhegJIB7fT/
X-Google-Smtp-Source: AGHT+IF5Fj/HlZvf9iHKBddOaAWOS502Ay8be6gRTzxp4WGZHvguqRclJasr0m2+ZZjbSW2JJ+eLGAepIXaDNWPmSCo=
X-Received: by 2002:a05:6512:10c7:b0:539:fd1b:baf5 with SMTP id
 2adb3069b0e04-53b348cb072mr23974907e87.16.1730984361703; Thu, 07 Nov 2024
 04:59:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101010121.69221-1-fujita.tomonori@gmail.com>
 <20241101010121.69221-7-fujita.tomonori@gmail.com> <874j4jgqcw.fsf@prevas.dk>
In-Reply-To: <874j4jgqcw.fsf@prevas.dk>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 7 Nov 2024 13:59:09 +0100
Message-ID: <CAH5fLgg3aOoFAA5YEXinMsLFpBV0Q86VDizdbTb8unMQgFKnZQ@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] rust: Add read_poll_timeout functions
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, anna-maria@linutronix.de, 
	frederic@kernel.org, tglx@linutronix.de, jstultz@google.com, sboyd@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com, 
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com, 
	arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 1:50=E2=80=AFPM Rasmus Villemoes <ravi@prevas.dk> wr=
ote:
>
> On Fri, Nov 01 2024, FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:
>
> > For the proper debug info, readx_poll_timeout() and __might_sleep()
> > are implemented as a macro. We could implement them as a normal
> > function if there is a clean way to get a null-terminated string
> > without allocation from core::panic::Location::file().
>
> Would it be too much to hope for either a compiler flag or simply
> default behaviour for having the backing, static store of the file!()
> &str being guaranteed to be followed by a nul character? (Of course that
> nul should not be counted in the slice's length). That would in general
> increase interop with C code.
>
> This is hardly the last place where Rust code would pass
> Location::file() into C, and having to pass that as a (ptr,len) pair
> always and updating the receiving C code to use %.*s seems like an
> uphill battle, especially when the C code passes the const char* pointer
> through a few layers before it is finally passed to a printf-like
> function.

This is actively being discussed at:
https://github.com/rust-lang/libs-team/issues/466

> And creating the nul-terminated strings with c_str! needlessly doubles
> the storage needed for the file names (unless the rust compiler is smart
> enough to then re-use the c_str result for the backing store of the
> file!() &str).

For the case of c_str!(file!()), the compiler should do the right
thing. Not via deduplication, but via removal of unused globals.

Alice

