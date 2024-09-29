Return-Path: <linux-kernel+bounces-343208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89ACF989830
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 00:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44F3BB21B21
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 22:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384A417AE1D;
	Sun, 29 Sep 2024 22:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="XSOb41Q9"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B3855E53
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 22:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727647309; cv=none; b=JFToAkwbmmyPQ3lLIAqNtzmFEdPUS1m+G2w65Lqa8OeF5dkGxUh9Zw0VBg8yv1Dejh/I4uu/nc0gY84uYvjR2KEF86P/9fQ3HoW7mIfGWeZ1KBumUIXS+7yfe1T1QlCCfr6RlE6U0u6qKyGeG3dT0V03tv4Z5rCH9kuIfmfhz40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727647309; c=relaxed/simple;
	bh=zMus0Pc79gKj189nyXTQAwgSBAQgMA8EYiDhd1e3tpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k4A8KN3v+UttJhhCL1ROz/ExeSfxvVQ7gbzkVHcMJv7aZmVkEhXcRAhe2+NrWDHjQLJu2VUSAso/y7PwckenWVwYYkd7Pg0etHHfXMSM3xv2zlPgRotlfucIeQ9VpfXRscknhR2PaLgBt1MUUTDU4Ax9YSCGboZWBiyvjEn0Cbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=XSOb41Q9; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6db20e22c85so32074317b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 15:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1727647306; x=1728252106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMus0Pc79gKj189nyXTQAwgSBAQgMA8EYiDhd1e3tpQ=;
        b=XSOb41Q92jvV+CQXjMGw7KUxwMBwGQSmc4nL9i7osXWbL0dkqCyeuoi99xHlsw0Kmj
         ZJyvt5p161V+2udjvwk5NlTr4NbjHWCXe1dQ2wmTOh+b8wygQJTkE3F8SZr5llom1HVp
         S49/7lGEATSMbgBqizTwWT9R4AsEQe059VOJVhONAwkY6SWMfMrhij/nZAdcaQAToCyi
         VhZFerv0/BIFQMBGGVjN4hxm2I+Gqos48jkojosr42nBaDH6U1SHIRdgMucMrCqBHdaM
         VNNS+f342Xty1KvxWICueKnpXLMcMDmPDeYF57djaVBJ5xKL8uyKpbhfkkuQIIy4lcUE
         3R5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727647306; x=1728252106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zMus0Pc79gKj189nyXTQAwgSBAQgMA8EYiDhd1e3tpQ=;
        b=IISMAaS6jsNnMd9GJy3Y7VOxZYyD/vPyjdClYHFvLJ2ZGH6yIj+a4ObH+rObPU/Eso
         swilXpz2o7RzIn3+aUKgiMlUoGWONyy6gF64QATdPj9hOd53hJx1ydRbe46Z7dPcOiA7
         a2OCK9WkVXn2uc5l5vwCq4B8bD3UPIh+Ynn+gHd5ecFbRibJodUh1HVQtbec/rasHrwC
         1ld+tU1m5CQ+qRuNVJmaBobE3osokpl9vk6SEQToWaOHikc+0kMdqmHj1ZmvVIU1gCkl
         4KFSkL87oOMjGksyhSI1hWIfhyvFXlGw0/6eUgQ+P23KecW2pSyiLvHKnQGRaMEvPVr0
         aGaA==
X-Forwarded-Encrypted: i=1; AJvYcCXz9Nreu1kMf16U24FTP6XM4QCx16HSa9P/aevwjz9dTd1wVstq7btuo0gDj6FGMSQKj4rUWQChJCfwv5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGEBFOIajs4ijBOi1C/Cvf2djsKkQ4HL8t7eNIXIkEMX4Vjl1o
	TtXz8Wp/OJbVMvRjq6jlPU+iCB/0gQ7vUk0p7A7pargy9ielJpWm4jUAmBC76Po/E0YbLCHeu5j
	3EHNwhL4Q69HsPqgiOltJWzQEaLuBeS491+OYzWB+iC0xG8rhBJQ=
X-Google-Smtp-Source: AGHT+IHq/TFRNvPSIRS6GB5Zg8xLp3T+T9PUAHYiATWgoREjCvsY04CX4FJtKGKhVBtOB4pDoj9VziUs/57ntqdlNgU=
X-Received: by 2002:a05:690c:3745:b0:6e2:1a23:7c07 with SMTP id
 00721157ae682-6e24754f0edmr82993087b3.11.1727647306612; Sun, 29 Sep 2024
 15:01:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dbb63b5698aa507bbe3dec54b4458a3f151899d3.1727606659.git.hridesh699@gmail.com>
In-Reply-To: <dbb63b5698aa507bbe3dec54b4458a3f151899d3.1727606659.git.hridesh699@gmail.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Sun, 29 Sep 2024 18:01:35 -0400
Message-ID: <CALNs47sgW2OFAUa2kdsZrkqu-Oj-HqM2qSWBtZ_o+pagcTZJwQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2 RESEND] rust: kernel: clean up empty `///` lines
To: Hridesh MG <hridesh699@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andreas Hindborg <a.hindborg@samsung.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Jens Axboe <axboe@kernel.dk>, Matt Gilbride <mattgilbride@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 29, 2024 at 7:17=E2=80=AFAM Hridesh MG <hridesh699@gmail.com> w=
rote:
>
> Remove unnecessary empty `///` lines in the rust docs.
>
> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1109
> Signed-off-by: Hridesh MG <hridesh699@gmail.com>

Reviewed-by: Trevor Gross <tmgross@umich.edu>

