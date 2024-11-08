Return-Path: <linux-kernel+bounces-401635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 855439C1D2A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F33BB1C22E10
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6D61E882B;
	Fri,  8 Nov 2024 12:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klzGkgE6"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE6D194A48;
	Fri,  8 Nov 2024 12:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731069674; cv=none; b=kc/tNuj23ztYAG/O9crdURf/ZsdufOdHjb3EfB+gNWMwpjNKEwt/uQLs/h6G2dMvGsrrcCFifdwPdiWajos6E1pr5gHKD2Oho8dVRGeP0ti0b4Q+rHDK7fmb9LgX4SWA1q4uTyrsnni07oMaH3G7isfbH04IntWmKcADK4Q8kgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731069674; c=relaxed/simple;
	bh=+Yg2wtM9L10+yYwPZvCTOi+WQqDYohy18cvtdDm8ZyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oC8/2nqyXiwP2ycYYvkEdGJZq3963J+h3rHpcp5Nu53QM9JNYNkb/dHet/NtwGP4F/1OSiEh++ZNK3Lcgf6ov+gw+iggBIRfLHxOfJPbHovESM5xlEkIGfSQJZJhbVYQ3AJ0SyXxIAmt6KnwZFsDy9OEf/hmnfJwIyZ4D202lTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=klzGkgE6; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fb599aac99so21568241fa.1;
        Fri, 08 Nov 2024 04:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731069671; x=1731674471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Yg2wtM9L10+yYwPZvCTOi+WQqDYohy18cvtdDm8ZyI=;
        b=klzGkgE6KS5WHiLpJy9aTgtVU2yZlNmbVE3QrRkO5GGW+nbwJgA9HLoUKA7ks2DNZZ
         sJl6fPm7iVAKMnidHyMHPiImxFnsb/lAdV7wijD4KXYdRfnH95Y3LyidkfMLHnIY/wbR
         AO/UGMzvLJ48bgsp9VFQL1mofkCYJscrVxA0xdnUBdgTApuDEwCcSMN+URno15XQTdhs
         jh4+yD+1aKjb09jfLIcqhavI/E0P+DKKampESmdLeJJxw3ruK8Rnt77jK40fMdI+vbq9
         lTw0k4uTZRqezlpmpuM/U7Cx4ETVLZZoRUu6GAo0E9l4e15bwZmFx/TaFJsDSptX711W
         VHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731069671; x=1731674471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Yg2wtM9L10+yYwPZvCTOi+WQqDYohy18cvtdDm8ZyI=;
        b=NIsqc4ycYXe3Nx6BDQtAnpMM+8OpcmARsq5WqvizQ+jnwTLFuI0wPidcHm5S/HLNqa
         D+kENpPoCB1FMBorRH+EG8ruBnZoSY3oT+w6y4NXeSlSeCmhkfRu7/8S/OQoxMOfAsUp
         WSiotO5fTEwUne9E31ISL0Bbl8Usr+Exq7tUY2SkVWeCHQdIg2rpmV7yiui34ggPtULz
         dw8nptpZ/ABVCw5C67AInh91ewpfZ8EV4p0F/54/l8zId1EPQUdw5QchFDPJnmXSInAY
         6o1Jqa2vguEkGqWHUaPQll0cEGZ6xVGDpbNxG4IWP4c4UMuS5i7TFpTviXsoubMzerg4
         BeUw==
X-Forwarded-Encrypted: i=1; AJvYcCWvCvhZyQRrgfmAtJ8tksA2U1OOzP2jlcNWFIIaBIkOEamcuGlsoN6Oz6VafxAvkCl4m1kJU963rS/yzf5zMZU=@vger.kernel.org, AJvYcCXQuQuYj6w77XbRp5E29GsGzcLqmxDP/nPLqAlj1+0ew+dPYPO4YPQc7b3OgSKLzmKcSkq/ZFoI126sHtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmD2F0X+ACst4AH3PO7sZdg6Wcc2h9wpWgDXMD6qH+YK/Egd1r
	iyb0e0R4ReigB0rC0JOQN6Hquq6XD/l/1BtIFbZCYYbIPmwcfEcdzUea3ddc5RKEjiYsWgsM/C9
	yE/1UaefJooUPnWe7M93o3EFjENE=
X-Google-Smtp-Source: AGHT+IFQhdpWXqutbk9OnQ4mSIZnZBIA8hcf0of9Mz6JzGKoTjkNcyfFN2lRGK7hgRMVSXLxpeHqWZUA7pA5MxX6uFI=
X-Received: by 2002:a2e:bc84:0:b0:2fb:5138:a615 with SMTP id
 38308e7fff4ca-2ff2005c69cmr16650621fa.0.1731069671409; Fri, 08 Nov 2024
 04:41:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104-borrow-mut-v2-0-de650678648d@gmail.com>
 <20241104-borrow-mut-v2-3-de650678648d@gmail.com> <CAH5fLgiMHE5GXQv8pSR_KYWsa44zr1o_FNrg1mj8QuTvNQmXhQ@mail.gmail.com>
 <CAJ-ks9=Ej0St7XnmvTysdnjPHh6O+4XdYFC6LouwEJR9GpUPNQ@mail.gmail.com> <CAH5fLgi=n-v5C4hH-+uozbiwwWCU_QGzhxfdTXfTyyy2ejJR+w@mail.gmail.com>
In-Reply-To: <CAH5fLgi=n-v5C4hH-+uozbiwwWCU_QGzhxfdTXfTyyy2ejJR+w@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 8 Nov 2024 07:40:35 -0500
Message-ID: <CAJ-ks9n8eSPsb7_RqWk-3OgtsrZquA=94uBopkdwtHuTPUisaA@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] rust: arc: split unsafe block, add missing comment
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 7:37=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> wr=
ote:
> You could write `unsafe { (*self.ptr.as_ptr()).refcount.get() }` to
> avoid the as_ref call.

Doesn't `(*self.ptr.as_ptr())` have the same problem?

