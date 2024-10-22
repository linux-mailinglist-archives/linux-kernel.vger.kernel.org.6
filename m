Return-Path: <linux-kernel+bounces-376337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AAF9AA36C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 15:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2839A1F23A4E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 13:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C198419EEC7;
	Tue, 22 Oct 2024 13:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1gi0bE6"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CFC19E97C;
	Tue, 22 Oct 2024 13:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729604490; cv=none; b=mFucEaMtByVySz4WarxQrpCB26LxUKFKa9m551TD6H/3TRedhxTO/I3hf5gXcMd8euMTyw/2JXoky/b6cjmvgRMLMzRaDIvUepncmz8EN3e+/2lgSgNLSmnpeEVJb8VApjInXOHJWpuH5BhLRGySUI/EUthzCGcLdieNeRQbIwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729604490; c=relaxed/simple;
	bh=kHXVsbSVUHdY/4EZzHc9gSCL2gVhVL34+fqJL+oRLug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OZTBY7s0w3e7Gw3M4Ah/kxqDk2xZna6gEgCGU1tUxkUHrOsBSu4RWhB6rEdCLHl21HGmuAGY3PlyednS8RE/p3Okqbd/DdmODF0yuxLojiIhCxmINjqRnIKg83eTcUosY4fAnrfoMnXEx3bcVndV7FPuxLtqepjOOSSOnvm5rcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1gi0bE6; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e2e31aacbbso856555a91.2;
        Tue, 22 Oct 2024 06:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729604487; x=1730209287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHXVsbSVUHdY/4EZzHc9gSCL2gVhVL34+fqJL+oRLug=;
        b=Z1gi0bE6MRDas7spR7K/aczuEeb/YbHi7Q1ckUBRPYNQD4RUnrfhUk4Estpiciuf5I
         OtsmRYu/iofcX2l2mrBr9XWwFTkSywNd73Uh+UGn/1jIT4qSL2FAL8nblITFpaz3J8Se
         AswG6VSFooxTRuEkgE12aNzNwuBwQ9JNbnrhF5kWJjyOuqzQrEEdJ1eemxkghjpR1qNM
         2n5MupyVm/1rJ6C1HRXyHRfYDHVfHl8XjBG+Ah4dPx1j7Iq3u8u9VqjdcdeM7q+0eHIu
         NmkayfckC/dOPDDa24In+NN/+iebWE3v1Fjby8xY4gS3iOyH0jE1JWsJp+UYBXtBxevb
         oM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729604487; x=1730209287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kHXVsbSVUHdY/4EZzHc9gSCL2gVhVL34+fqJL+oRLug=;
        b=H7qv47elmwrzMTQajKWZVCBRmGt2WwqkQ2JDGVwzq9cBUJKePque4XVllnn9gpBnJg
         Kcgr0ES5grHWOyAx06MDFIGFNDOH2vmnIlNVR8p1Ex8klYmmu1mEP/SQGOaDMNLDtiiU
         J9/A5/859XDG2DYranygn/gNmGPIMw55XfGbD8RvGIQ5sHDQGrbNZhbaUjl0B9E5ktnQ
         cFoV21zVCnhO7JtZLIa6yTQ+De2tEKou8/Ft9OQVgKueBsjk5ER6yhGO+ybKlShkVKV3
         Xkctdi5ngsonhIvJJG4Dr27YSeXCB9hECv8se6Vm88/hobI0E4KnWILKTzaGpLdWyo0l
         oVRg==
X-Forwarded-Encrypted: i=1; AJvYcCUjFWwZi9t+hfdoqIHodW6CH0Zl6Ls7ZzM2Kpki9SWqpqpMmqMEG3u4ffHY4BE3E4ntutQ8nSlsRswrpkE=@vger.kernel.org, AJvYcCVT6hyr5xYGvCbJ3f+uHqE5vffu5lsdYtV0pLkA1OfXA9JRSELq9huZ19R6S2X8NioiRCLIx+rlHAk4de+y+2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIU9HRB5X8I6UvO0VuTykUaVE1qVjqCEJI8Wke/SaRZUNsIeCa
	6tvWHVbek9LIPWlNs9uQvv0H2JkPatoOwNYMZNYM1mLodXLJhCn6wSW1AlNpjewYMMz2o8SQNpC
	PQbd+TrktFAVALPZ1u6jOqcYwGco=
X-Google-Smtp-Source: AGHT+IEjnXkwwLw73Y+LilpA9ntQEBSAJ4vHJAmzrdCf6nFYGaFNW9SnDDMIM6aB1ZYF1HTfofZxTc6eK2kGvsp5gvk=
X-Received: by 2002:a17:90a:68c4:b0:2e3:b92:aaf6 with SMTP id
 98e67ed59e1d1-2e561611ebamr7556070a91.3.1729604487053; Tue, 22 Oct 2024
 06:41:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022-miscdevice-unsafe-warn-fix-v1-1-a78fde1740d6@google.com>
In-Reply-To: <20241022-miscdevice-unsafe-warn-fix-v1-1-a78fde1740d6@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 22 Oct 2024 15:41:14 +0200
Message-ID: <CANiq72=pjR3dFXGtmhz4RCRQKQ+8+13hqtABDx-8nsK_2hExpA@mail.gmail.com>
Subject: Re: [PATCH] rust: miscdevice: add missing safety comments
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Arnd Bergmann <arnd@arndb.de>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 3:14=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> Reported-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Thanks Alice!

Closes: https://lore.kernel.org/rust-for-linux/CANiq72kOs6vPDUzZttQNqePFHph=
CQ30iVmZ5MO7eCJfPG=3D=3DVzg@mail.gmail.com/

I guess this will go through char-misc:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel

