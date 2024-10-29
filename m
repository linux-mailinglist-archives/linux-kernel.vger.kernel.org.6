Return-Path: <linux-kernel+bounces-387623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0053F9B53C0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 21:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61D22B22608
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 20:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5B320822C;
	Tue, 29 Oct 2024 20:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Swsv7f0o"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002082076CA;
	Tue, 29 Oct 2024 20:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730233961; cv=none; b=V+7sQETkVuttR54RXNMROw+B6ZwT7m6/EtUr9UyfXe/jjejQM7R4a0HlJt/yVaEP4MVIrgohPWRaRHfV4HZ88aVQo0WgwON7btDZpcJLhbebkrg8VukoA3nnRK7MgNtf17lTOj4GgxYq8JcKwd7NwKQVQgY+uOI6CJTI+U5i/yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730233961; c=relaxed/simple;
	bh=rCnZy1GL7WV4Wip6XypIEL3ndPbHR7S/Gl6coqGIAxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KD7/z9y+2/3gTjbVGbQSUw5Vpw9STG9I3DDuGO3xwcRNE3tSIYMMdsw0CfTIhEMK4jFxku7q93wrfeoPfYJpHFZggK4q11vvDViyfaxpHCgzDAmqGVcKIARlv1UR+e4YdytnmD6XJUc5bgL78q0IZvY57c8ElOl0kp1BIxQkAcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Swsv7f0o; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e2ab5bbc01so880720a91.2;
        Tue, 29 Oct 2024 13:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730233959; x=1730838759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KTBIW71Chv5hAZoNJmWHYtUtkojBbc0cIEsNfl0E57g=;
        b=Swsv7f0ox+wIHqjwjM7cH7QSEyPIjfRV/6m9Yz57gMaCpadUI4TnKmU6TeIwuxVc2Q
         7mbstu2e+7EqxSNkOZgG63njOSEvnL2ZAHP2KIclGsx2SD5OPsGgZT/KO7KDZ47lNZ0r
         QvtZCWJ7lquyjpHyW0gajbcVPDnuSUcEgX3NTuVo8q/UTrXqjpFFLIuf6x9l9TCM80wB
         9ZmkV84//dlkADVV07vipxFT8lympnkiirvmnGCaYn6U+EmJs7BoZKL8h8okju6txy4E
         LzTu0i+yQwgcrc3XMzEPnjHGVBZMOO7K26vaq1U4a08x4VfYX4n4Q1F86ShNFtKduHQY
         rr5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730233959; x=1730838759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KTBIW71Chv5hAZoNJmWHYtUtkojBbc0cIEsNfl0E57g=;
        b=fiQA+JrhRqbBndELkkmlpKVYY/dvv/pidWV7iuZnSvxO6qLw4/JeP/ReqP0Qrfm8uN
         4aNJ6J1KpYLwK+c1fpgqG1BPNOX4nV6ljiTQ2Ff5Zbpy9w0s6QwMSDnrFHfOWpY/AAU5
         4j16MwGOrN7KAGgbcbfW5LK2JWXN0LJXS7zj/UUjj9MZD0DyRCM3EO8WaOumuCo63XOM
         17YmDl9iUxITHf5JfYNRfs1ebdOtUQMjS5/L2cWLpBm6XpL+vgHXin+VFJWPb0Dl4ifn
         18+1vIeDZSzCyIIeW3AYiJG2KIIaK/tPV3tn54TnvurfBTR9LwMaeEx7UvdFbhqL20K6
         6vDg==
X-Forwarded-Encrypted: i=1; AJvYcCU8YMPyu2hHIbtbHF0Ug1GF1L2UzE8Z/mOE+65ugPnTNfAS6m80sHedV9hduGXVeXSOgGTUeJ9csVcYyVM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz37m0aphI5tSMNrIcMxF9RLCHNH9SnkzGlmAs16Nrwf09Fsb4D
	fXLfcBSpdqYcAGJlwuo4NpYQWJ0zrDHD8GOFl90F5K3XPs4fko1enQz2o/tFhnvV3RybsVxxStq
	hNdDcCA0ZR7iH2W5O3D1fGWUDxVc=
X-Google-Smtp-Source: AGHT+IEMTBEpP2wmKmHf1xja9ok5W2rQQS4881N6QvnEIymnrQmccSlAuI01ny103LcOg0nyFa/GJWKwXR8VNMj+wd4=
X-Received: by 2002:a17:90a:5185:b0:2e2:d562:6b42 with SMTP id
 98e67ed59e1d1-2e8f106d66bmr6669212a91.3.1730233959064; Tue, 29 Oct 2024
 13:32:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1728818976.git.hridesh699@gmail.com> <32382c55dbcb6482d6e686d541c2e15b282908cd.1728818976.git.hridesh699@gmail.com>
 <CALiyAo==Bk1qjVcnQKc+0YUOzgKuYSvJts+eNrMDx+E3XxMsGw@mail.gmail.com>
In-Reply-To: <CALiyAo==Bk1qjVcnQKc+0YUOzgKuYSvJts+eNrMDx+E3XxMsGw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 29 Oct 2024 21:32:27 +0100
Message-ID: <CANiq72noG77qLF1WcRu4qJNboyqs9Xvvu_ZmjVN8qitK_MNWnw@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] checkpatch: warn on empty rust doc comments
To: Hridesh MG <hridesh699@gmail.com>, Joe Perches <joe@perches.com>, 
	Andy Whitcroft <apw@canonical.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Dwaipayan Ray <dwaipayanray1@gmail.com>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	Wedson Almeida Filho <walmeida@microsoft.com>, Valentin Obst <kernel@valentinobst.de>, 
	Patrick Miller <paddymills@proton.me>, Alex Mantel <alexmantel93@mailbox.org>, 
	Matt Gilbride <mattgilbride@google.com>, Aswin Unnikrishnan <aswinunni01@gmail.com>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 7:12=E2=80=AFAM Hridesh MG <hridesh699@gmail.com> w=
rote:
>
> Just dropping a gentle ping=E2=80=94please let me know if there=E2=80=99s=
 anything
> additional I can do to help move this forward.

I think Joe wanted to take a look (?), but maybe I misinterpreted his messa=
ge:

    https://lore.kernel.org/rust-for-linux/9a8ed16ffc65d587ed2ff2d1e95bd61f=
dca5cc90.camel@perches.com/

The Rust changes (patch #1 and #3) look fine, of course. If needed, I
can take those independently to reduce the series. Otherwise, if
And/Joe want to carry them:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

(Ideally with a slightly better commit message, e.g. one idea is
showing the warning without cleaning those, but up to him to reword or
not if he picks them up)

Thanks!

Cheers,
Miguel

