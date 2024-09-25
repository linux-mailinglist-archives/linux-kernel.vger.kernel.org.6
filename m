Return-Path: <linux-kernel+bounces-339116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFCB986085
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E13F1C26607
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8E818BC29;
	Wed, 25 Sep 2024 13:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+iqg4Ik"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9129184552;
	Wed, 25 Sep 2024 13:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727269598; cv=none; b=JhzHwqFmD6akaO/ehGV8aobo53dJ4Mgel/gsqAqJ2G2/OVNHfh7C9UUk0RaCPOGOqEAQQLCbmd9qduyBA4u9YVYgDmg+KVAxGNEleWGNXVbLqIvCsu63lDd4LjK4q+5p91+wEXZo3XGLYpb/hux1ZGKVTX07q3NWPHHZ4QhAJUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727269598; c=relaxed/simple;
	bh=iB6hdwxjFFfqGkel1dMY8vFpPFOXTTJKCe8eW4+Bi5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ej1VdUCMXVvaMoA491oHE5pLssP9zosTK/DTzMCz2/7FvHN4D9ep2gfe+tDEx25yGK1RyYJeGyLRY3SbJbJvDLWknR/MZlunCOeqCro5QhNHAlLJaP0PuheqdrxO9npP5u4DsKG70kL99cMBRAuSkKaxGcLKOilECqgwp709/vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+iqg4Ik; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2db6e80555dso836812a91.0;
        Wed, 25 Sep 2024 06:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727269596; x=1727874396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iB6hdwxjFFfqGkel1dMY8vFpPFOXTTJKCe8eW4+Bi5c=;
        b=R+iqg4IkwOaXUPbDKRogKJvqDXl/arJ4c/9Y07FWLI0yyuqlrejkf5jBMXA3tbAEn9
         LqqCYx2i2z08YXglmR/5Uyq/98KQFFsHQnq4pYF+2A66C91nX3KIW5VA/8I7OmDRg98b
         Wt+92owGP88sevUEpL+pSp2KLttr4E39vfkvf9LYX4UCrwT+daXRPpKtS/kS1nMoXQSh
         HKhTliA4gRDAbhEHe8gYnvUUvER0bHdg9Rj+8+kbbIQjIHf2WBSx/hzS/p2msfQnvjmb
         wm4tcsJRUbbHkiBwR1KnGyg4qTDTht+9Zp2K/sf9hv3FnLAcwRGrEpp/yagVioYFgIBQ
         xPPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727269596; x=1727874396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iB6hdwxjFFfqGkel1dMY8vFpPFOXTTJKCe8eW4+Bi5c=;
        b=aBv1bNz+ZNezgH8sgasDz7UKFPWVPzJnKhlwEQxNIEEGwXBoXqDy1I+rVKMvEvRRRW
         7VSw+MWL5ZJaeuLAKrnSE+a4YDZUFG6YSAzLAmlAnJwOTgBmLf0+J23XK13mvNXDMmUK
         wPMmf7rkRp5hcQsYydlWoj/eHSQ7OJfUbcz4yLKooG88NMrFdrQvQyYuCH2f6KjIpKcy
         NL8enOsTM+rIJRnPCXNxmD4NGvceug0+/D1TxegdwwYbFqxt8quzCGuJj1+y/FX0/vxK
         c6v1AD/ifurEp1PH6UNPF+S3LpoT9OrZQCypBr3/ZALkj4IaMQhJqlY2UoWK7SMk0/o1
         7mYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCl0A4DvHfTDQ5JwyfXeVfGF5pET+w/9d+Bdp37l2zKqFcW7avWsJFDmDl33ICZjsDsKIdQ0HhWPJz4p9vgZE=@vger.kernel.org, AJvYcCXdjRxg1zshlTjmAkfM+SPjlw9Y8xVvjpAbgy1m5Xs2PWrkhA+sE2lJWaKuvgbd0hu0rYZTAStANoIuhHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCvSwAm40UHgZ3jQcMLsVd2HrCnvgV4xr6xMidLc333zfiPaSl
	tASIVztPlmJlAM0zNQlHjlz7Tes9CK8Ca8E/Q7D8OfkD4sHZQIkmk0kYu+lXP/shSBDUXmUY1cs
	gnoLlnXBo+Z8atEFm4Ow5iQpT5s8=
X-Google-Smtp-Source: AGHT+IF7dd2wxaKwlXRqdkEhcjMFw4qV18UITJsIdeRTYuV2STRNWFgGJI/WJ2qnF1mkzpyinwhH0XCUdaEJWAefdRQ=
X-Received: by 2002:a17:90b:30d7:b0:2e0:8c23:fe5a with SMTP id
 98e67ed59e1d1-2e08c240880mr232340a91.3.1727269596173; Wed, 25 Sep 2024
 06:06:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816181545.45789-1-ojeda@kernel.org>
In-Reply-To: <20240816181545.45789-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 25 Sep 2024 15:06:24 +0200
Message-ID: <CANiq72=y3uy4ehCY-UHgywO8T_EOrh5da88sFt2Xg__E1VAHkw@mail.gmail.com>
Subject: Re: [RFC PATCH] docs: rust: quick-start: add Ubuntu
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	Zixing Liu <zixing.liu@canonical.com>, William Grant <wgrant@ubuntu.com>, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 8:16=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> This is a potential patch for the future -- Ubuntu Oracular (future
> release) works today, but the Rust versioned releases are not backported
> (yet?). If Ubuntu ends up deciding to backport them, which would be
> amazing, or at least when they start to appear in an actual release,
> then we can apply this. Thanks William & Zixing!

An update on this: Ubuntu now provides the versioned `rustc-*`
packages in older LTSs (the ones with standard support), which is
great!

I can confirm I can build the latest kernel in 20.04 LTS (using a
newer LLVM), 22.04 LTS, 24.04 LTS and 24.10.

The `bindgen-*` versioned packages are not backported (yet?) to the
older LTSs, so users need to build `bindgen` manually in 20.04 LTS and
22.04 LTS. For 24.04 LTS and 24.10, it works with the package. I will
add a sentence about that and send the non-RFC patch.

Link: https://packages.ubuntu.com/search?keywords=3Drustc-1
Link: https://packages.ubuntu.com/search?keywords=3Dbindgen-0

Cheers,
Miguel

