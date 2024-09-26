Return-Path: <linux-kernel+bounces-341035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D43C0987A9B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 23:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92A7A2863F2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 21:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADD6186E30;
	Thu, 26 Sep 2024 21:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZVVHdBx"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529AC186285;
	Thu, 26 Sep 2024 21:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727385523; cv=none; b=Y6irOWJ50JnvAuMslrGld8dou6fxkJMm+vdgZzn44P15QmuReQMW74Qxy62trFcDp9xMBL+aHR9z0NM8LhU1xcunjnbKs5XWPwNRJT8bwoMNEyyO0KMorrNmd42AO2aqcLgazK8z0BbVPaq+UZPeLruW8ai2v8oqOqlmmKUKV2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727385523; c=relaxed/simple;
	bh=w1kclsqVlQLtrr1ruKCx/k3v8gTO8jNATS/pfglofHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oEGfWJ7AcVij1b4aawEogFgiqMFdoWKZBv0ngxGJXhokerAbnb317/va+JNXcOKB0cI1i0w7sm/ZM7DQb0yefUz6TQJg8GMHsco/ar/qnp0yuX1RKy54mNYdd7l/vfAu2lOeKZY85RaW0bT51Y+5RabHV8rTYlsWalYHTX6bRcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZVVHdBx; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-718e65590easo141121b3a.3;
        Thu, 26 Sep 2024 14:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727385522; x=1727990322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w1kclsqVlQLtrr1ruKCx/k3v8gTO8jNATS/pfglofHc=;
        b=CZVVHdBxAd+8bH+uIFRvdrnkLZhbqJJLrI9b3DuN85BOoFb7eoXEFbqp3tTCQdrtTw
         6IUHe093L9yDVlT9vYNGSzX/r5kVXd0U3AX5whOhvO1tbXgXAivfkFEfpZMjmu6LQyLq
         Rn61TT7bgmPrWuaD1PKvH7apRAjStVy7JnXt2EcgeQfmi2S2md8V0QSGo+LoxLOdVg1u
         PNYFXs84wIDJfuHTYrnP69kg5mIzM2Q8usG8AQ92OIZ4ndr9ZZtFcd2wXMbdk8uUP2VS
         wUpsarcRUEfE2LOCBcSlYXDEFeb9eWLum34tEihH/1mUkVzSaFbZfhv62YebhkLmp0Ul
         tUsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727385522; x=1727990322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w1kclsqVlQLtrr1ruKCx/k3v8gTO8jNATS/pfglofHc=;
        b=Qo/1qiQbvymNK3ed8gf4/YrhpZTbQQZWfWtkqoYMxBbRv3F2GCSd6UK/1V9GJeosdQ
         l1MvyksCxVHnf3UUvpqQ51Qf4N63akFigTIvFCayh7UxPB+5qBtA7rpLPbU4Yw4UaBiq
         HgeHu1P997Bf+MSbSxK+pTO5jt09VLeg6F1fwgef+pE0nPDNlyAXge7dqzHRVTTC46/M
         sOJNFjh5bA/shWy9TbNtNLh5AfRPRUvCZZo5AfWWk/bRWTtZuMjnF07MV8r6E/ZKIKe8
         VBlQV/7hBSJKT2gjabYtmqyMaQkMeyV+loI34C+Dc955vO+MyrphcDI98jFNowyLHutJ
         fNkA==
X-Forwarded-Encrypted: i=1; AJvYcCWeFqONWrtqe7hF2oiwmfyoX4n2eKSlxNA2WT4FpucwDopKJ9J6F7zvl8MZaVmw0/yEXvfRFcSVSRmcTPg=@vger.kernel.org, AJvYcCXBlrZadzCGRhRUSMMVzc5InnCg5zYmBvdlfWsBUm7BpYOgMgZXXZbDypILWFk6HGDfZ/DkmcTGWb4rYFD0WiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN+/RIfWqDW0YnH80Na5C68+rBmyKmsaXJqqVodzdbIviliXbU
	jhWtwUjjPSveyEWlERGnvZDUVEsycTA5/3NaY2fNe9WuaYlq1AqJ+uPEECa0Q9phqf5NMJ8fiYX
	HPkh70eLPjwiJMW65ZmbUCqcMd0g=
X-Google-Smtp-Source: AGHT+IE/EeYAY0BWAuVZA/I6KVCDUNVFb1hxR5KongAR5JI53gpNyt2LZUocYR7mqFv12xqOy3YDt2GBpHTFgFU2mrk=
X-Received: by 2002:aa7:8881:0:b0:70a:efec:6b88 with SMTP id
 d2e1a72fcca58-71b2605647amr749184b3a.3.1727385521502; Thu, 26 Sep 2024
 14:18:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926124751.345471-1-ojeda@kernel.org>
In-Reply-To: <20240926124751.345471-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 26 Sep 2024 23:18:28 +0200
Message-ID: <CANiq72mYdtnFUWNNEpihRodr9XeuUoHTmnC1E3u5qZ+HtT_r=w@mail.gmail.com>
Subject: Re: [PATCH] rust: kernel: sort Rust modules
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 2:48=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Rust modules are intended to be sorted, thus do so.
>
> This makes `rustfmtcheck` to pass again.
>
> Fixes: 570172569238 ("Merge tag 'rust-6.12' of https://github.com/Rust-fo=
r-Linux/linux")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-fixes` -- thanks!

Cheers,
Miguel

