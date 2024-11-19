Return-Path: <linux-kernel+bounces-414847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DE59D2E17
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 19:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43FCC1F234BA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 18:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9D61D0E20;
	Tue, 19 Nov 2024 18:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+pV2Rcx"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0C313D8A3;
	Tue, 19 Nov 2024 18:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732041619; cv=none; b=uAQz6NKmuPy864NVFQp//IlY5uu0Rh13sn7UW29DEvMlNorByKLPLodFJwnOchiwz3aj2Px53Tlp+CQNnPcYcAtsysMX0zWqI39ns6UbOieQhce2tbra2iobKZ20it8YJlgJsrAoX1l8NLbSWeNqIK9O2LemEGF6Ex+qNYuj9AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732041619; c=relaxed/simple;
	bh=BFdvauQuXJqJc4TCdW4IR6Y0qZHG/UmYJq07BABLGJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mp5FWtlWZ6Pvb79fZT2/RZywbY3LDtgssqf0HKmF77NBBa8iUkpJr6rqUZByUiN/3s+B/M38dn8C6dn1B7uXlgZEpSob8cUuGqiCZtJuZYQxxodOxvyEEkUyFaRThk/bnwaUvPSGBl9K4U57ywWBHz+skiQBAhqhSv9bCw0jXBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+pV2Rcx; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e9ed2dbfc8so760103a91.1;
        Tue, 19 Nov 2024 10:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732041616; x=1732646416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFdvauQuXJqJc4TCdW4IR6Y0qZHG/UmYJq07BABLGJU=;
        b=j+pV2RcxnzVhuGF0p/ueQTrziQeDkGXUdZE3F+aNIJ1Sdtnurr0hRYTqaZMcMjfeWe
         8DXHmkDX50uVYGK2kBcKO2g0FOez4wox4jOjhhvJtSApfM9pp5vkIqfuesfBd6ecji/u
         epFJQ3ZlQpJZ/hI9ajLzHY+J1hmmOe+N+9MOBd3c7w98NPRY0judcyihOvBhA5tcLtYE
         MrjlRGOe76n3v5KLng7a/PFOu/Blh8/Jp3h4HQ70xW+f0Ij2YwosV9CmrnlVI2R+Rn5B
         bm5biV9L+SfkyB6762kfF809nbIhA7xQEXCy/95uVo6JLek7Xk++VicBkN3Ck/VsF+Mi
         YcKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732041616; x=1732646416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BFdvauQuXJqJc4TCdW4IR6Y0qZHG/UmYJq07BABLGJU=;
        b=XWzS1ZaxAT9azIYYe60IkkeWxp45eGsXuD+HA+byuHn81EaLE6f5TR/gUjxkncI9Rs
         4oiRzg4u1WkjYIITRAm+TIYcK1v8fAUsim9rXHVzoFwm6oe3B2AP9cOWI/DqoVUSLCNx
         3kUR1XkASRiiDbi/OJBRQ1KeoC9nT80PKY67gzATfBqofQPm/+hNJBTHtnAzekfZQBjL
         gI5AYdev1Aa9xwVLu1n+Tss8DyzdGOFPA3/v30WZ5i0G8mgxzu6ctl+K6DRTUKXH/Y0e
         QrMfG8yrGN854mf5dhIUsPyrQf+s23vaLIMF6Orwx644j3qs9yL27mAIM/CuyHOhVlO7
         yOGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdfLtXA0HEPxEx99jSlftn+4D/pr5uIFPA5d78m4OseODKrewEhGop0sK1IlNBQ5tWt0eTLeUJ2yiAkn3rQRk=@vger.kernel.org, AJvYcCWHp/9TQjB1vOTUPSNGQdkduDGtf64T0igazYSGK2w9xb5iEx+r272FuOXC5o+FSQWqBDRxT1SoXqJNmSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeEw97G4mk1Mu7/JIxfyCE6KZugnyHs3PCrOayggKM+zPUHl7d
	lOckgkHvq4zO5iQDC4nun0yBd83+BnkraaCoOxh07I1wmwclf5L0bfg+fGrS28GUCR9sYSsVFnJ
	Dg3E89Wxq6Fi2YkoGES75IDh89Dc=
X-Gm-Gg: ASbGncurQKQYy9CX9BcNMgFSpEydpYA2Ewu9aPn+EyM6xL/MBIpCllJkUniphvKBHNB
	vdukhMa5YVwB/+d1bu2kF24ko5kR5NQ==
X-Google-Smtp-Source: AGHT+IG4Wq7IoHZKNwVU8UxlUkc5dyR/wS6pVLxWdOXvEyGzlg9eh82jfPDP12otvyWgIkeKniwITcJpJh2r8/48wac=
X-Received: by 2002:a17:90b:3a8e:b0:2ea:853a:99e0 with SMTP id
 98e67ed59e1d1-2ea853aa30bmr3893000a91.5.1732041616390; Tue, 19 Nov 2024
 10:40:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118-rust-xarray-bindings-v9-0-3219cdb53685@gmail.com>
 <20241118-rust-xarray-bindings-v9-2-3219cdb53685@gmail.com>
 <Zzu9SzkDoq_1YQnJ@tardis.local> <CAJ-ks9mKArX37VzhcyymDoE-MsNxNcO8VvP4n3Xu1mdfOKiuag@mail.gmail.com>
 <CAH5fLggL7MTLVv2ym_tCCKH9hQtL=GpTwXjDUQzKQX9UdT7SkA@mail.gmail.com>
 <CAJ-ks9k4upcSfa2HXaMrtDJ37eTNc-ZiKZdcLuEYSnWHL5Bigw@mail.gmail.com>
 <CAH5fLggBZsarrRkZ1Mf5ND9-A6kCc65QRwhUW5X9nQxRJUOXrQ@mail.gmail.com>
 <CAJ-ks9=ZDRdh1UzBpV-ck2v5t4a3-81vD07Ndfmow4ABmQvJmQ@mail.gmail.com>
 <CANiq72=MeVViwfFGaj7MFev0ZOodVo2dJqOeHiPodHjN-xh9TA@mail.gmail.com> <CAJ-ks9kgaVGow2o1S+YAUpYF6pVFReEb2mf+OFMvULt2pykH7g@mail.gmail.com>
In-Reply-To: <CAJ-ks9kgaVGow2o1S+YAUpYF6pVFReEb2mf+OFMvULt2pykH7g@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 19 Nov 2024 19:40:04 +0100
Message-ID: <CANiq72mGzd-Y7b2DVczagfpNR7Uky6iNx+8dUU4g27e3O+GJjg@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] rust: xarray: Add an abstraction for XArray
To: Tamir Duberstein <tamird@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 7:22=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> Looks like there are merge conflicts between v6.13 and rust-next.
> What's the usual process for resolution?

You can take a look, for instance, at how it was done in linux-next.

(Nit: mainline is not yet v6.13)

Cheers,
Miguel

