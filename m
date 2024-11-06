Return-Path: <linux-kernel+bounces-398719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE309BF51D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D757D2825CD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0199B208204;
	Wed,  6 Nov 2024 18:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IgC5XZw5"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173042076DF;
	Wed,  6 Nov 2024 18:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730917202; cv=none; b=ZmazkgrcliiLvJCctNVvZ68D762WubEZ9zFc9Lkqp9Ahb4HbmenDnFxLyI89GTXgjbwQwA1xZVT7aiixAXow67jwQgEIESTgZPo4kNC0GIbVOcg3HYHqsXxLlCh4V448wQoMO6aeBmR/s4zEAPifc5Mors+l8VlW+F8U/w9HFxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730917202; c=relaxed/simple;
	bh=K5WZLSX54TuljmRtP55sPi8GdaghrzyWtHwvHCPcI+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=djskXCkW+TkKybHIUx+O8xs7FrZWb0WWjETOuTp10JDrtY8Dls2cJr+rjBpwP+efDM3euUXUp5s+XLTWXggIDzqJPzuVUnkytU/l0xdiyYe1ijO6DCZyebH2pyoH2K98TYV/mqhU3axwZzk5EKXpFsuyILZIJRgOoU6zXTWvjmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IgC5XZw5; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e2d83f15f3so13188a91.0;
        Wed, 06 Nov 2024 10:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730917200; x=1731522000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2CSyCtnTXK2z/ELGxW2knZ8xjo5nUO/vy+j0+w/piiY=;
        b=IgC5XZw5fW688o6buIH+eeXdK0YeR00IKHdO5YuZFK+cRYa1bbFt82nrxsSg9mrfey
         x1YVtLkUcGT54uzQluOqxz6xWaCyr0DSqfV9XCT7Ih5444YBg9HPtLFMRiuDM/05LQRL
         kuZ+dwjt8pYia4SrVHpL69OlrchIQiYW5oB7TsESkBR1x/iH800RIEhxotifV9vUKOzJ
         TAStOPieT5HnFFdzvGWvnON845OFAljKsjo/JUYY8HFcELL6ZZ1mU8qbKaRoCGAECBZ5
         UHw4QwlDYajwirM/atsL3/6UYDGiW7BLqx0f/k4zJohFBRW/rgeOVet1CHdTW62tpmmD
         W6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730917200; x=1731522000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2CSyCtnTXK2z/ELGxW2knZ8xjo5nUO/vy+j0+w/piiY=;
        b=cqeZZ3AdVRqpfTQdlE9c1hbiIzyoTqj3OYYDxnSZHs5I2FpiY5MdOwO/5K249KsxU9
         0ekL3R1NW15pVuicjTkIhDi+i22HrDhFTBurXZEWYhc1E+jGPemkyl/FNTmRtdRuii7r
         bzGfhUsS8jiYVBHrNx5m6tZ+cODne16IfLb7MvMYG1JLsmCQuPM9OifG7cPV9IY69uSw
         GhZklaKE7jJLD6qBLCxM3p91EfomrGvpGjHETJcXVBIu134rKSrT3tR7ZqZ+xua4siki
         s62KFphr6boFDMIPtrkJXcuzf/LYfYjUod/F0xFCGUzC/KNfqvEQdiGyqVYE8MKj7QGo
         UQmA==
X-Forwarded-Encrypted: i=1; AJvYcCVD7aqiTK4Axch5mlfTpUQyPDPkOtd7oIVQ2MGZ+ISuAIc/OHYbqFXsHhxgk566VS5jFR6x7aTODWTi9Oo=@vger.kernel.org, AJvYcCVLa8bC51AAvKaWbU4exGZqt6PZqGAMV4xbD+k3TOe/JInXvOTlnvHRX/0X17fF7k5r3V+fX8S/yXlE4XLoQdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN0t0JVP+UZeLBGrR+l5R31Ir2g18WxF4aOabUxOGhoK5dmiAg
	80kxh0YgcxXjJ7OA0gzuMZyZVh5L2LSAxOTA45ZCY/Ymv1t5fD4eN4sZrzFSZDFWny1quOgOK7f
	rVAdL7RRxI6vFw6d9u/4wMRwZZLc=
X-Google-Smtp-Source: AGHT+IEhQregVD9i1hTW1C+B83pDguVfdjn9ZTHPguO+bdACJ7OG6RUQjRg8g/wcsY0RA74rmbZVDJz0gxwruE/Npvk=
X-Received: by 2002:a17:90b:38cd:b0:2e9:4a0c:252f with SMTP id
 98e67ed59e1d1-2e9a4a80d40mr126391a91.1.1730917200171; Wed, 06 Nov 2024
 10:20:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104-simplify-arc-v1-1-a4ffc290f905@gmail.com>
 <ZylNvC8enwPG4IQ4@Boquns-Mac-mini.local> <CANiq72nQ6b1wO6i6zWW6ZWeQFN4SJVB28b216FDU70KmtCbaxA@mail.gmail.com>
 <CAJ-ks9=xW_WWZXB0CbDvU-3otkYs-TY+PSYeiPyidM58QujC3g@mail.gmail.com>
 <CANiq72=9XiYOMQ9ttDrgqTt=mPZnWJuCL0EgQBjFObfqVmr1UA@mail.gmail.com> <CAJ-ks9kNmH2t2Lo2PdLuH5rwSC3UQRGWd-cTAX9-Q2FE6oGHiQ@mail.gmail.com>
In-Reply-To: <CAJ-ks9kNmH2t2Lo2PdLuH5rwSC3UQRGWd-cTAX9-Q2FE6oGHiQ@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 6 Nov 2024 19:19:48 +0100
Message-ID: <CANiq72k3AJgMq_US7MYGpzKRqOXZQKpOkBXAd8DwBKyE+Bz3Jg@mail.gmail.com>
Subject: Re: [PATCH] rust: arc: remove unused PhantomData
To: Tamir Duberstein <tamird@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 5:33=E2=80=AFPM Tamir Duberstein <tamird@gmail.com> =
wrote:
>
> I would be happy to add the relevant details to the commit message but
> this is one citation that I haven't been able to locate. The closest
> mention I could find[0] only vaguely mentions that this change was
> made, but does not reference a commit (and certainly not an RFC).

In Boqun's first link, there is a reference to the nomicon with
details, and the section:

    https://doc.rust-lang.org/nomicon/phantom-data.html#generic-parameters-=
and-drop-checking

explains the change, including:

    "But ever since RFC 1238, this is no longer true nor necessary."

There was another RFC (1327) after that, for a finer-grained approach
(`may_dangle`). The name of the feature gate was also changed.

Anyway, I don't think we need to add any of that to the commit message
though. Perhaps linking the latest RFC is good for context, so if you
think it is a good idea, of course please go for it -- but in case you
are referring to what I said, I didn't say that we should add the RFC
bits into the commit message.

Cheers,
Miguel

