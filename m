Return-Path: <linux-kernel+bounces-264015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6C993DDE6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 10:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C3831F22318
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 08:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A4043AD5;
	Sat, 27 Jul 2024 08:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LAAsN5yQ"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45A44205D
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 08:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722070725; cv=none; b=V9iBcsKiQfnJsQe61Z9O3yQ0p3zNgowSykuWLtIzPs27twQ279b1nxA50gwPJKyDXKD9lvF86pr2TO1bRSI1r0SDn6b7OTTl6YDiOxo8+8tWK6Sl9LEbIMeIYdJOU0Oz2hmdjAjgovYsgMAiHd2Z2kmJamJODj92kNklxskYAWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722070725; c=relaxed/simple;
	bh=LcgEyp/IYnAKXO+Dvl3srBVV/CmiqeEknQN8bVUv+ic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dnEFVRA++ZFcCEdTcAZpwcmtz0TQxq1vhz+qluXjOh5JlJvi2MlYyyoTTMEsnwLjUpWdsOoyrf+xyVYOP0hbE85zOEWp4dxfdv2njLYd6dcV6oL+jS0zSH8zG3yhpx92ATI5kPrbfj04Yns/dtaJ2af5XjsXxDz3OmFWx40H4l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LAAsN5yQ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-368557c9e93so273527f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 01:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722070722; x=1722675522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LcgEyp/IYnAKXO+Dvl3srBVV/CmiqeEknQN8bVUv+ic=;
        b=LAAsN5yQTlzWr95OtMG1eMfPHzmWkEbelCrLL6jbhKlcKz6cpujgl7sgV1O89Zzypx
         uWR6olz69hbcy9wLLl3Nf1AU8jnZTz69f7OGdw9jC6IyUXXzQSOyUSoxgK+5hDsvYlRF
         NWbyJ3GxbmqAnaYK/q9lFqdk4OZQMIvgK56QVyYBF0Abpsfyn2AqrQNmTQzv5aRhFYkd
         r59pHohX2x3k0Gt3TiEtSFjQHIqWnoLZQSZBn8epOdvUVjSt8YwV3pdoje8XJVui4+UM
         W0qAoNpKR51RW7EH2TmUS+OTMFGioFIdSwJ9W+yKTfdJt9tkCg6cdf4iEhbYxerDjBtE
         T5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722070722; x=1722675522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LcgEyp/IYnAKXO+Dvl3srBVV/CmiqeEknQN8bVUv+ic=;
        b=cBSTR0g3szzdFh1UN7TckvwIX1DUv0cjJPHwwfQ1p/BFUUPUiIAjSQ4+Ba3PI5Wq53
         BtUWc2FC55I1Z0KXKsi7+hE67NQh/y8p8Zpqei+EaCa8VvgjMDLGhkikPZvaSZ2F7WaH
         F2KJ1YbJmsrDBh5QQ6ao3GJiutEYBLVTZcuzaiVOiVFS25AwFLzfMux4V7dGbQKHRtDY
         eMLuf0bA87HhRljYue9kz99C76hgy/ZoBps1Tg0eQqyOJwgbLEhmlwtHWbyRw0WmA2o6
         pkzSMzqYa8jXsYZyJX9SbiDSfnoLhsuctpDoFjsxtI2Vzv6KnBhwLm0hlQLf+zgae8Kg
         NdFw==
X-Forwarded-Encrypted: i=1; AJvYcCVofGy03NKOtVWQzmLv16gsKR3R/fLCb5F9Y1mhLSm47Id0vYDaJjUSa5ZrxSyAbQDt789OGhdt0mYKizJSrGGnI96U+5BS1fM+BAO2
X-Gm-Message-State: AOJu0YwHRZ0G0wgQWve1GQNf+DDI7ydGDa9xJZZmWSjdrkZ1hHxT0lG5
	P26vaOqXm2zqTmNcwsya/Pd+5VxHHlPbB6t9eZAGCoM2bTG6Ir3tgG+34Gzm3ta4ih2rTp8VvyZ
	jvOAN/immjJ5H/IpsuKVekmqeCJi4D3MfHznC
X-Google-Smtp-Source: AGHT+IEJd0KUJd2pb3W32mJA6m/WBUd7vT8mCwjrAMv1qZd21H89mER5g+dz6DHruOk/X+WXnO7cGJ/ZJv5eKP8dpJw=
X-Received: by 2002:a5d:6288:0:b0:368:7f8c:1b38 with SMTP id
 ffacd0b85a97d-36b5cf23f54mr1123461f8f.30.1722070721690; Sat, 27 Jul 2024
 01:58:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240727042442.682109-1-alexmantel93@mailbox.org>
In-Reply-To: <20240727042442.682109-1-alexmantel93@mailbox.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Sat, 27 Jul 2024 10:58:29 +0200
Message-ID: <CAH5fLght8TRtSi0g1Tm8RjJVH9otOsTG+_4hzU5ZNrfBuwfFOQ@mail.gmail.com>
Subject: Re: [PATCH v3] rust: Implement the smart pointer `InPlaceInit` for `Arc`
To: Alex Mantel <alexmantel93@mailbox.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 27, 2024 at 6:25=E2=80=AFAM Alex Mantel <alexmantel93@mailbox.o=
rg> wrote:
>
> For pinned and unpinned initialization of structs, a trait named
> `InPlaceInit` exists for uniform access. `Arc` did not implement
> `InPlaceInit` yet, although the functions already existed. The main
> reason for that, was that the trait itself returned a `Pin<Self>`. The
> `Arc` implementation of the kernel is already implicitly pinned.
>
> To enable `Arc` to implement `InPlaceInit` and to have uniform access,
> for in-place and pinned in-place initialization, an associated type is
> introduced for `InPlaceInit`. The new implementation of `InPlaceInit`
> for `Arc` sets `Arc` as the associated type. Older implementations use
> an explicit `Pin<T>` as the associated type. The implemented methods for
> `Arc` are mostly moved from a direct implementation on `Arc`. There
> should be no user impact. The implementation for `ListArc` is omitted,
> because it is not merged yet.
>
> Link: https://github.com/Rust-for-Linux/linux/issues/1079
> Signed-off-by: Alex Mantel <alexmantel93@mailbox.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

