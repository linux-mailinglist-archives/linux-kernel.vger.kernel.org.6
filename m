Return-Path: <linux-kernel+bounces-349454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC3C98F671
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 20:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 083801C22860
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 18:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D231B0137;
	Thu,  3 Oct 2024 18:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWEb4dUM"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2071AB6DE;
	Thu,  3 Oct 2024 18:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727981086; cv=none; b=cjQ9gbViKYm9LmcAx2yyzjgeFeJ/WfI4Bu4v1zaI2MEyIl/Bw8dHn8+ma2FdAlXuWzQAbOrq71cSSOCi8M8pi2jM4hzfd4sRyAbiWWo1Ztvswms00ylLE1xaafxdsXuTVr+1aPa5pn/8SDKPNzrhYXRdSZ+MLlL3wAeTqJrio8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727981086; c=relaxed/simple;
	bh=Ycb3Cnm6ICTwEhO7rPuXIICGBEt5as3cnbaVCZ21XBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GmOfwPFhEWAid7rQZOPC49jaD37te5Cbiuq6wl+ovUpT76cr7+MRs4l9WTDNeLPx54tq3nPeXKICkpY6thGQwMiWlFdrev8b++b49raCB5jnqdCj2nFC/VoKYVjZqvacLHSF31Aj6aFeiYNIJ+5DLuG8tkJwrkqDJOiFbq4Kwiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWEb4dUM; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-718ef6a26dbso64120b3a.1;
        Thu, 03 Oct 2024 11:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727981085; x=1728585885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ycb3Cnm6ICTwEhO7rPuXIICGBEt5as3cnbaVCZ21XBs=;
        b=DWEb4dUM7ehtuHqvSMEIB8YBuirIcHYJFfLtAeopte8wk4GR/s/NF7AnAmRsbFA2Co
         DKKNV9HXJOIRxp7RaiJ88QlbCX4uGCl+rzhGBWOn+M6Ph3uFPgpiq2xwi0dws6qXJr/4
         WrqLNqNLFB3QxCypQTC1JXDxbbBNtOgITLNbmyZQNi4YhevlzrFftdoROWAelwqhwzC8
         AfURZs+ciYmfqF+EXqrt8uLQ0OROY+RH2YHh5YXxjpEKf51UkD9eiBrl14kse9/XlRqn
         UALICMG1kWN2AxIxF05TKdMZvr34jnAz9A0FZMybCcAGUDw8e8vE4dD/LRYIol8wonOO
         US1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727981085; x=1728585885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ycb3Cnm6ICTwEhO7rPuXIICGBEt5as3cnbaVCZ21XBs=;
        b=EA304smk2Bx+9bCYRhQ0AoX31QEZCKo5oicjMXY1KGcQZtZuOY2RsvDw9B3/QYTjzY
         ZBq2tbi8OzVANjG++rW4QQozcqBnZ6ulsq5lQgfvUDg1IOC7eq6+HqvaR8aLpWuIpy09
         YeYXojYSkHAc/B7te7x7gGBH+x6Mg1twPMwSGrxgMBlIw6GPupxpK5R0quTb7zHfposk
         86MF9pzjmZGIlgUfUykOW9NVBbNuvfiXwuwb4hm+xhb+Yo96/NbLaVpcNKn9O/k1b8Vt
         NYlgS6kNDPRyPVrLvnS+K13+x6ecN6DW1Xgsdt1oUk/p/BRjDZqYMfXEMIfGw/KPRNUZ
         yCUA==
X-Forwarded-Encrypted: i=1; AJvYcCUuc/L6BzX3aaQ3pF+8N6LffiUnSNKg4yBlGoPeU0LSP8SvTNRbfu6aEv8LLcWGSO0WwHq51jILTgT88g0=@vger.kernel.org, AJvYcCXJJ/p4749qMTzqbcTWQ6jwR0+gXh8UnGpqJWshBhXdZX9y22fUzFFUGpeaqVK249rekGcqkEm0LsxEHgTOPwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIb9pYPHLHv0fEjmKmjqynEz2H3dqJ05ZHCTZ3Thwe3ce7xgU2
	XqbRqdwHJb8iCjZ49ZoRxc/4Kek3b4ErobGRwge3NtSz1MxK462zKEumHZvMeQtAu3dbsb+715S
	KiN9jdA6yI00ZavJLGtIJ2LypT4g=
X-Google-Smtp-Source: AGHT+IGDZcv1EGR47N/kbV/QRNk7qllYDnalvMwH5ygy0m438oy36PucEWG5clvW/m3wLDIZr6Xq5L0xpe+GaUrcNhg=
X-Received: by 2002:a05:6a00:4b4e:b0:710:51cd:ed43 with SMTP id
 d2e1a72fcca58-71de23a662dmr57137b3a.1.1727981084725; Thu, 03 Oct 2024
 11:44:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904204347.168520-1-ojeda@kernel.org> <20240904204347.168520-15-ojeda@kernel.org>
 <CALNs47u+vEO5+v7dS3Zm2QbeOQfp9OdNv_y7G5c_AxqxjppFHg@mail.gmail.com>
In-Reply-To: <CALNs47u+vEO5+v7dS3Zm2QbeOQfp9OdNv_y7G5c_AxqxjppFHg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 3 Oct 2024 20:44:32 +0200
Message-ID: <CANiq72kp2uW-miyjb8pH6Thg6p4++CPnupEOM8PfDF8JgjEypA@mail.gmail.com>
Subject: Re: [PATCH 14/19] rust: provide proper code documentation titles
To: Trevor Gross <tmgross@umich.edu>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 29, 2024 at 6:56=E2=80=AFAM Trevor Gross <tmgross@umich.edu> wr=
ote:
>
> I think some words got flipped around, should this say something like
> "...a couple private cases we had in case checking..."?

Nice catch, fixed in the version I am will apply -- thanks!

Cheers,
Miguel

