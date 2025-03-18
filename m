Return-Path: <linux-kernel+bounces-565943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C22A6715D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 463E7421BF2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38650207E0E;
	Tue, 18 Mar 2025 10:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIjXBdlp"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B39320459F;
	Tue, 18 Mar 2025 10:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742294074; cv=none; b=KRCJ5JHNmPhmUHK7UF8Nb0gXGrKpn3oMsMFy02mj9hsYUJTrS0J5lWR3fUCV8wRqlyxcGG+NEY/VN4WRBsHq0Bvd2HbcCUCFub+xJJKZSViA7SrGE0ay45JpJqTvzSf1CMahg70LW29/knn223CwWGYE5VnfBMKamvj4y+f49ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742294074; c=relaxed/simple;
	bh=NgqBeCgacXz6i48arteRrLxAM0fCi4tfMNMBJPzxya8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XCXrjpU0jc7HPSHOk4z69YGUKkaXiE+O3D/DmQxr27PE0wsUInB4Tpl1azJ/Z+FsiOwVBwPFbSzsHzoGRsFX9o1KPwjLz6md2fvA9WWrolib11aHiZpDwO+NVEGxac5a7WbbovQOYgnfTrB/SXvPWPCJOdyY7F4r+G2o0s2OiPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DIjXBdlp; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5499af0cecdso697583e87.2;
        Tue, 18 Mar 2025 03:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742294067; x=1742898867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NgqBeCgacXz6i48arteRrLxAM0fCi4tfMNMBJPzxya8=;
        b=DIjXBdlpO42CcoM9w8xlSMZedM/ZnO7QOh91JGyjofMTtmBfTAZySxa4U2579iI9+g
         BxYhEvUtTnVLoobuh7tfbcaqlwg7+PF1pJX2ORER+kYVohRtNwQhSLyeRBrqo0FAjzVV
         Bk6i+W4z3cTcWduECS1GDFUDvoYzPIU/Nh02IcDAEqhJPm4eBaSvIVUu3yAmbGTy8NUs
         nmM7AgfnhWWxkGCEUmPy4DBLIAw9yaZkHHJbSrnTA0KZjmE0PMi8zwHH/FJPepIxX4oM
         ymOCGiM/fL8AzaWemApfZ9taTiH2Bg0St7kznFl8fWEp6Qar+iby8/h9QqFbHvnSCcZc
         YiPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742294067; x=1742898867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NgqBeCgacXz6i48arteRrLxAM0fCi4tfMNMBJPzxya8=;
        b=KmhlAI6mKn9K+SEpa8PlFJwYaz/UDwZ4BTFTTa/jkGKAXDgp0VVGuh/aZT0cJeryWQ
         kz2DzfZsoX2TSYUXXEP0ypGqDwzmNVhCV42dyXsapfk4WlaFB7WE547Zh71qAebW6Ja4
         sYxU77EBiHgLBuWyGCWJhIB9Dtvy/4K2LyJngzm4SuVXr2xeW90GJpIMRlXLSbjct3fa
         seE4Se3yAftZa8DfsR97ueMUaI6bfVwFw2P60owTngrfl3SWocwkvPJhY9EZ7MYTs4KR
         SzMoPF9ZuXxIm9ZLymaqF4UHlFX7/Y4DXP5R4Ux3P5BXXCjpQtJPHtN/3C1jirrXm6Cw
         G32w==
X-Forwarded-Encrypted: i=1; AJvYcCUzD6YNYxziWdTqkfdXNTDLj6f8N6Uj5QV1akQLiSti0LCRCc6wmZ6y/V6w9Zdf6uTs4JaGTH3+vQUQvoubaO4=@vger.kernel.org, AJvYcCWx+Cn1ooAZW1QlsdU0NgTOkq/mHA34tboWUIq1wiIwwT4cYZ1dhdLA7dBlIim+uu+O+RmuTzdnSarFouY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeTn75gLF5VaSnYl1c0wdMDP8p7HBNDLxXzwUSiwARxFhv+/Tu
	aS496dGwjgRc8eYejxwso05fWbD+p4ISZFS0lK6PyJ/k8YLZEyxdqoC+Db6mT8i7UbQtSOUpIu9
	WkqlYHoZydDezOQq4Y9LAQ2HfJPA=
X-Gm-Gg: ASbGncuZD4KU55tpEXtN6WvQl7JdAnqgieLuqPvi4tAoRcAOc1E8OllYA+hrEq7L4zW
	hBJGd028l2vsONi3+yEMCyvXQXpqGA6DHHHyAFsbxcWmRrzUyvzCQJSjdCt/JNMxD5sa6moY69K
	O7K8i3bZ4Mz71+eRD4Rh/+W9bpJw==
X-Google-Smtp-Source: AGHT+IHxAhk+yKtdKU5nIrrl6uVR6NufpxuMU8l75CVlABdoajg3N6hAhmBjCkoaytwWq5YHlhBoF04wjjcy3rVu/NI=
X-Received: by 2002:a05:6512:3e18:b0:546:2f7a:38a9 with SMTP id
 2adb3069b0e04-549c38d5eddmr3549957e87.3.1742294066844; Tue, 18 Mar 2025
 03:34:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250208-rust-kunit-v1-0-94a026be6d72@weissschuh.net>
 <20250208-rust-kunit-v1-1-94a026be6d72@weissschuh.net> <CABVgOSnwkDihbRzYF3uh3At_x0MgOB42_E8sUAD8moKwx+zjRw@mail.gmail.com>
 <CANiq72nnwopFAdETMhgkCfN9dj+JJZQ=K1BKz_A_xUViis7Avg@mail.gmail.com> <1a1ea09ae8cd82db0b8c3205bfd179bacfce4700.camel@sipsolutions.net>
In-Reply-To: <1a1ea09ae8cd82db0b8c3205bfd179bacfce4700.camel@sipsolutions.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 18 Mar 2025 11:34:08 +0100
X-Gm-Features: AQ5f1Jp9OwqriR53SJxEyK9ZWTkGMjnsXOLnics89veDT3az8A-65eRFKbZHjyU
Message-ID: <CANiq72=8PHXBf3QuCmKwvZxtm6XbVd0qwDq=gaNRYRHojrmYtA@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: pass correct target to bindgen on Usermode Linux
To: Johannes Berg <johannes@sipsolutions.net>
Cc: David Gow <davidgow@google.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um <linux-um@lists.infradead.org>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 11:14=E2=80=AFAM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> The list is fine, but the patch wasn't even CC'ed there, so we don't
> have it in our patchwork:
> https://patchwork.ozlabs.org/project/linux-um/list/

Ah, right, David added it.

> I was just picking up um patches, but given that it was a series, and
> changes rust/ rather than arch/um/, I think it's probably better if you
> do it, so:
>
> Acked-by: Johannes Berg <johannes@sipsolutions.net>

Thanks for the very quick reply!

I guess they could be picked independently, but I am happy to pick both.

Cheers,
Miguel

