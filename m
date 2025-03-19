Return-Path: <linux-kernel+bounces-568356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A961FA69457
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0468E427788
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3721DF270;
	Wed, 19 Mar 2025 16:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DImMQxs/"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E151DE4FB;
	Wed, 19 Mar 2025 16:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742400415; cv=none; b=QlT5jmoXnyVPX06ANY2FO9p7Zj5btBYBizRec3xy76SAHJlUpIvUNNOdabY5kYAXSyndZrhxYlq1aFoAg7IGiIvt1rS79ApwlNm7wTj9aJ0b2FwUXVVrKzVMU3Xq/5qK7CYlee/hW2SOwAoS9fyMiqirB29DpSTjG5ZkYMnFa/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742400415; c=relaxed/simple;
	bh=zOvNy6cuX1wOoW8pRGs7qcnquFhdC/sbHrVaQCrxSA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IjCKkcTcAst3q/wcLzE65a/3WJf2u5514GA6P08tTTmuYSRNlE/pz2o7MFOlFjJ7N3OfH/MeYzMirnGMa7ouwcoNfwkguiV5zyYBkG+huzQI9LCm3/4BAx4h16/Kvux9urxcQ2cXbvclGUAs4SYkDvyavIaremoBAqfgIDIM200=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DImMQxs/; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ff53b26af2so1085286a91.0;
        Wed, 19 Mar 2025 09:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742400412; x=1743005212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zOvNy6cuX1wOoW8pRGs7qcnquFhdC/sbHrVaQCrxSA8=;
        b=DImMQxs/Sy1fH0QJhXeW6pvGwWS9US/dpqxEofzGzYZCa0Dw1VuPOL2Q6UI2pD/FyZ
         MuNCe4lVQPFg4rL4n2ZnHC5CethZhAvHMSl8RNO/7NxPYV8PxlUsmi0934I9D7JzEuoI
         S8AKDDu/Rj0Q4gCod746la/CsBexwaEew2sRt0Y2v1CRePxyN94thK3Xe2b4pwRnORql
         owdyL4z+aJlX2K0C4sFOCai38+09VemZA6TKProQrt6dImI2nqkAFDmlSAf7HuvverYr
         I9gB24gATI3xRDgZuNEVX9usH50PBIY1dJI/yJJBl4AZb6k5ZGlVIQo1ZiB0DiEWp2CC
         MClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742400412; x=1743005212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zOvNy6cuX1wOoW8pRGs7qcnquFhdC/sbHrVaQCrxSA8=;
        b=snpV6JkVmbdUcrj0b1VQ2IK1qTaycTBG54J2UuP7Njva48WJuSFOMJECvIxrheg0Ja
         +4tDhKsVJKBOTAE+KAa0XcQLKgW+E2lAvJX4HShtTKbbFMTlFnDgPQkuk2tPkOPeG5B1
         HUqExUK1IyuuQU5PXQ2IT61Q0ADAz4z6MR4x+YUVEnWEdQ3k1gqT4U/Q9zoA+8F6oEWP
         zCMZ+x2UnUH0z60fLY3nvM6lz1NxUYlSvU6hb9mO/ZuX1aMvMl9xL3eZMjogA6pwJQom
         ibU29lRUg1k/Fl8pigbn0HYEkMQ5D0NiPHGmhkyXHA6ZGl54/5hdX4tJ7G7/SFr1dd6R
         w35A==
X-Forwarded-Encrypted: i=1; AJvYcCVmT428jCSEKDCoJnU4n6sMd/mtu8mMHuq3QjxFfcjQVd5XbWqSytzCBYoYempundCbvzPlveHZN4MXUaQO@vger.kernel.org, AJvYcCWb3EkSr4Y7vM2q1fgfOgNqrRr4Cx7Q8zNdWTmessAp46Hpru+KZXl5/QUrIR91MP9w+6aGyNiMshkjxJ/KN0Y=@vger.kernel.org, AJvYcCXyDGcMrE+0CbNHlKL3DSRHnivgsOdbQwjjFOrCKaFOHeb44Mlp7UJySm/YOGOxgGeLaAlv8rXtxRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaBZPf6y9Ros7MpL4+vUh/cjUo9KR+qEgTs/w7i2Rb8P4UlKQi
	KdrkD88sjltcP9VGLPFi7QtLKhYWlny6CT/NgabmAy6LiknvDquCsQ7VjY4uk3f+PP6a6QHzM07
	cmGZKJRnFYxWZ7f0Bu+cMQa9Jv8E=
X-Gm-Gg: ASbGncsu3okiWjdjnk7jxHPwDMFQ1p+sd1Fgivna5JEwNKnnST1itkMbI6lSw3pXCSr
	tJQeUZ/8NnwZur8xEHb+6DYCe6E18gHkDC5Mc6v539Aaz82qsuNKQn2WNLdzKpqtZSFtfuWBKTw
	FkFU10DSOJ8X5ZV6cdgjd7BqzvjQ==
X-Google-Smtp-Source: AGHT+IGKH7dGzo9CR9DyO61FwA7cxqxKg1zlVUXDQ/9/34mE4QzwcvBU2hSm+dhh6M/XvRm1n6FGq53W1euSYJyTZJY=
X-Received: by 2002:a17:90b:2246:b0:301:1c11:aa7a with SMTP id
 98e67ed59e1d1-301bfc749d3mr1656740a91.3.1742400412036; Wed, 19 Mar 2025
 09:06:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250316111644.154602-1-andrewjballance@gmail.com>
 <20250316111644.154602-3-andrewjballance@gmail.com> <CAJ-ks9kAROOfyPtxMe6LE4-UPsvXca2sQ2VDjhRchZp3HLddGg@mail.gmail.com>
 <D8JTWL8JY7DM.3IVH6FZ4M49CB@proton.me> <CAJ-ks9k+A1+0CWXZmD2m0+jRqTRTNFn-=d9VXqytiOqvn4BR0w@mail.gmail.com>
 <D8KBFC9M74H5.4ZJ2SJK06SGR@proton.me> <CAJ-ks9=NQrz3ySacKt+XXm2vS+Fn9gjmtqAaaoz1k=iTG_1HXw@mail.gmail.com>
In-Reply-To: <CAJ-ks9=NQrz3ySacKt+XXm2vS+Fn9gjmtqAaaoz1k=iTG_1HXw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 19 Mar 2025 17:06:39 +0100
X-Gm-Features: AQ5f1JrZzeF8YqgUhS2ui73zsg8Ty3fstbUTrdh2di_k7zMf5vS2OO4mnq0-LQ8
Message-ID: <CANiq72mnT73Mb7RJhZjf4de=_Orv4pipunMhOersOj_aqrFA-g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] rust: alloc: add Vec::resize method
To: Tamir Duberstein <tamird@gmail.com>
Cc: Benno Lossin <benno.lossin@proton.me>, Andrew Ballance <andrewjballance@gmail.com>, dakr@kernel.org, 
	airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, corbet@lwn.net, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, 
	tmgross@umich.edu, acourbot@nvidia.com, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 4:59=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> If we're talking about the same thing then I think we're both wrong
> and the correct phrasing would have been: "you can avoid underflow
> checking when CONFIG_RUST_OVERFLOW_CHECKS=3Dy by using `checked_sub`". I
> was referring to the underflow check implicit in `new_len -
> self.len()`.

`checked_sub` always checks (if not optimized away). The config option
is about the implicit one.

Do you mean avoiding panics?

Cheers,
Miguel

