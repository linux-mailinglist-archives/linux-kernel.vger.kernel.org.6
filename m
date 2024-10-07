Return-Path: <linux-kernel+bounces-354085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A04993787
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 21:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ABF51C20DB0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 19:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214661DE3BB;
	Mon,  7 Oct 2024 19:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loCPoGTm"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC57F15B12F;
	Mon,  7 Oct 2024 19:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728330101; cv=none; b=s0DtpsWt2htC4v7uc8v5FK3vJdnGeXoOb7azsFSHaByEyp4JKrVHlllPwIGBTumcd9m4F2FrQQQcsosT2gS9aodDqOEbARullKZW7yfdrWRyqc9Fbu6Z4Uh57cqMnjxT83ZflDwarKF3GBj/zJKKFjsewVOCBoWnGKVPVfE5K1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728330101; c=relaxed/simple;
	bh=ljUxYzoj1g1D1rA9DFTeZILqaVD2Ed8BEUWIfYm2LTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HQZ99uuzd5iY5zcJZXyLdwc9ogs0AOQHTu0BBA5d+VAkgnnq6zIuQkRqqUcnqf2cXd+xdBu48PJtkx/KtxzoGpHpwKrBgXKD3qo2Ef2m+IefvHSst/VTOdIR946pOaUOJ/Nk8W+7alg4tbNoY3SHTctVplpZH5CcHr/jX243zBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=loCPoGTm; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-717839f9eb6so602430b3a.3;
        Mon, 07 Oct 2024 12:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728330098; x=1728934898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYIaLHRw0RYYzPaYhNdhFTsCvTaZcxbAiq3hADHMKuc=;
        b=loCPoGTm1A7iVtBpJ0vVfMF9TK77IZdg37S73+Z+fF/GMEO3/PAh1B4VVP2GVvgsHK
         RyJ727zSYnZwmTOtCdeyAQO5gdtimhTdPGj+2AmFXdyM10VYN5q/LtTtU2Vt1lNs4r97
         VmnrTGnT7VGCaCg4ZbL9YvBx+fURgwlwWDO9q1err/N32Uf+vQznsBLVUIjl9g0aDPmA
         ygOlipV2TzAwDspuMx846OC6K2CnVvsMrJGpJF3l8XWkjvk2E4Frh4AjlIXKfaN8HpQa
         q5BgWwfdZfmyydN6wPbpWhsgMTDryQbDRMiwUgO7I7Q3eucoRy8Vtezn0lKaqdoprCPv
         YP7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728330098; x=1728934898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UYIaLHRw0RYYzPaYhNdhFTsCvTaZcxbAiq3hADHMKuc=;
        b=m8lTOMzejvMM14Z13JqzLmyouUamQz5gN6reqqs/9b/tLqaOz5/LhKkYhS2XqlamWm
         qHnrh74uO8icXhfj2iTBp7Hv2yB616yoJIXmfokVssjiC666PS2cu45ycXbwfxhz/kdy
         EDeQamTfEdagHcYkoJZBGAU2OJLmT6bxRLoCkk+JsSBbMDpA6hvw5l1UaLrccfRZEtv8
         79aEIYKxAhP/3bssqrENGn63BEjAPu5AMmMIoTZTwT9T3JhCL5UnB0V7Hrv3a6GpazpB
         MOcg9pcy3uH1YYh2dbFQUZdvzCd8XEFrAdozvoMXwYOuZ9cwP0XbOfyPZFiIAbt1AGYh
         5+dw==
X-Forwarded-Encrypted: i=1; AJvYcCVGeaP2U0fwqVLrVp1H+s3R+MSo10Lb9+r7jYC/qtgtPC7qzz4WoCHfgN5tvLcp4zAtfkcJvk1mJBimVSQz7R0=@vger.kernel.org, AJvYcCWQlalW8LK51qjBv4RcpnLEX8Gu2luKRfrOR3+O7127kK7ahlinIQbRVUmDLth79QO6sTjNfqnyrUHGvwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsK8oB1QXzekOCUOD+qdIaQKXvwx6Dc7fLg0ujuXi/LgjbmsBn
	ljoFSFGjh6Uis5aVKB5LHMUxOL8lDKVykT739k9tnLK5dtnkFBx84CLDPs2RK4nKBIWLnOSzLeP
	64k8n5/2i250bygIKTwgDVZLxPC4=
X-Google-Smtp-Source: AGHT+IFzNGhj9rybt/LVmKAf91cTgM/AODOTO9uvvmYQNxRkZxxwnQPPSr242h8mSKwH7Utz1MO/CNdNR+HeBbtd8Eg=
X-Received: by 2002:a05:6a00:1785:b0:71d:fd4f:260e with SMTP id
 d2e1a72fcca58-71dfd4f27f9mr4127041b3a.0.1728330097068; Mon, 07 Oct 2024
 12:41:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004154149.93856-1-dakr@kernel.org> <20241004154149.93856-20-dakr@kernel.org>
 <CAH5fLgida5mybAqE=4kk022ui0hmjRMnAttWrkn213XGXBWLXA@mail.gmail.com> <ZwP8kTf3r3h40NKF@pollux>
In-Reply-To: <ZwP8kTf3r3h40NKF@pollux>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 7 Oct 2024 21:41:24 +0200
Message-ID: <CANiq72nfvmWof2qtbuADFsE6waotXPrJogRcCE2LEUyLGbqpfg@mail.gmail.com>
Subject: Re: [PATCH v9 19/29] rust: treewide: switch to the kernel `Vec` type
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, ojeda@kernel.org, alex.gaynor@gmail.com, 
	wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com, 
	akpm@linux-foundation.org, daniel.almeida@collabora.com, 
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com, 
	lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, 
	jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, 
	lyude@redhat.com, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 5:22=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> @Miguel: Can you please fix this up when you apply the series?

Of course.

> Unrelated to this series, but I think there's also a "regression" against=
 the
> lint series in this file:

Good catch, fixed in `rust-next` directly and added to my tests, thanks!

diff --git a/mm/kasan/kasan_test_rust.rs b/mm/kasan/kasan_test_rust.rs
index caa7175964ef..47bcf033dd4f 100644
--- a/mm/kasan/kasan_test_rust.rs
+++ b/mm/kasan/kasan_test_rust.rs
@@ -17,5 +17,6 @@ pub extern "C" fn kasan_test_rust_uaf() -> u8 {
     }
     let ptr: *mut u8 =3D addr_of_mut!(v[2048]);
     drop(v);
+    // SAFETY: Incorrect, on purpose.
     unsafe { *ptr }
 }

Cheers,
Miguel

