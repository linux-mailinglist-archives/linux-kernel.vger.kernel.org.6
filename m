Return-Path: <linux-kernel+bounces-524928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0428DA3E8CF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2401F42230F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB6D268FFC;
	Thu, 20 Feb 2025 23:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBc9a4hr"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D70268FE7;
	Thu, 20 Feb 2025 23:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740095247; cv=none; b=qi39gn+YabNO9hs0nA6XYQKYI8ix8I3J5cTu/KVyX/3FWUGB59qhj/CsENfhA7PZM+gHtVJ+CriPoJ1Yl418TR1mlk7favugqw8oyIG+q0W7UzcHIZwh8JVTLKx8yhfSmMHDAnM0RhwXirLn56fis3YO2FAAfinAtzMW+B/mgb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740095247; c=relaxed/simple;
	bh=uktFcM7ofiq4EF29b7l0zsd0L5DM5eWiNfdLEwXdeDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c32raZX8oFOcbTaQ2k1P2lCHHnmnIoCwwtzsHay2g/7l3292xlwQMp2GUS0DSEM/gKRWhqYMrNmqjIx+uaGvfGgqSQhQTIOV2D/+uTOA4l6QYzQXi4H5GQa2Wo0U2AwS4TNAe68OIhT2h3m20NmrzC1QVta6J8JfeT+BxN8mj+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBc9a4hr; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2217ea6d8daso4073325ad.3;
        Thu, 20 Feb 2025 15:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740095245; x=1740700045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rcbiIWTlMI+SlCmwNzkzCWnSjlPgQuj2JSvyxeAzcIw=;
        b=IBc9a4hrlDC0sb2baOt9D2xoVVCkO9lIgn/0Jmoosq4xXtfVP5cCcXAF6qYvDiXqsu
         99v9XI+rV7Nn06A/j/I1HD+T+cHM4O1mW7P2uMPYFHmE2S4KGf9ZVjlV7npOv8et6onf
         FNm6quC114tly23wcouSgvEricoXoaZaeCwa6GoPr5bH1bm1HpOVR8/hC45o3LPLjbYh
         gbCnElg7N7M0QCFWTBW4vSV98pLEQdiMTX+iabaKDh8TdUG7nVn1FgmC9IJpCWCVj1Tu
         Mlik8QRCqp2+7PQHYDkYiFYRQvC2vysEHIa75cdY8s7sGC88uitZCS8FiNXkJ/0J87L4
         SpJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740095245; x=1740700045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rcbiIWTlMI+SlCmwNzkzCWnSjlPgQuj2JSvyxeAzcIw=;
        b=Lp7xzmiwBs/Tc8dTAxo33f7fe8QyEb1WsYhFhpd/rriTvX7ohjWLct7B5+J9fvchsx
         Pvx+vMCZ7MbUGyTNV6afzLcZa/A5bUnukHGpsFQRqofhaSvzjaQ8Ix4rsQCRmO7CdGua
         mR/CN8z+Ldk/YQ8LjricGX7u0XRhsJ1dDJR88/RBuVo1wmQ5pZkojLOat/6wz6BZFY5K
         SZPUcdtGdlXxFe5ppSNsl1izBgqPC01ViPOtoyy0zJSZf6l0pE9VbqK6rWrBmbCjL+QR
         ijEpbuTUMW3Rzx+yp4tfWWHB0/Gl/eocsyU6LaaHJ4SfSRwvAQ++NbYNazvJqkjbqP2u
         RPpA==
X-Forwarded-Encrypted: i=1; AJvYcCUKTWllrVmfIMFx/IKMh0mx5Ufj+h9eOPxSH7J0t3hKxvFVnrB96sDCQaJKUjI4FHVDuSd9yADnvRQm7ro=@vger.kernel.org, AJvYcCWjh1aoRPWClgnbsiUAyg8EWSx1p5EhODVryGbGG9Hz1YPAl95MrCxTUSq/spduzKoOhhBlFpxVvPqUNIlvKow=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY5Ju4nvykJHC2k1a3lg9uD3RRFzG0LndJWc/ZCaPvpJ1yGO5b
	17o1JzQ2y67GSxUWARlZQvf71hM4S1RjL2B26DSqdsV6gm4Gdvi6r+u1V+kEZ1sgiU6LylDO9XY
	kCaxT5Q76vEXB3WkMdpKlH4YadWc=
X-Gm-Gg: ASbGncu30q8teQj+w7kZGCVXEE3YopJUjEA06wSD5BAKSylXVMUI/wmSayTBrkrCP9n
	THF50md+hcMBmjxWfG0jCDi9ALnpyPu2S8YYIYWt+cV31ugTJDfqVs4ekDYaQqdhYBawMSuFn
X-Google-Smtp-Source: AGHT+IH0bs1iToL6V0EuNvifVGL6NdGd70byTgfL6uq1rCj0t+FM/MUR+8hVyUWrzlM/mFIo2B+AfXPCTdv+UQ+qRuU=
X-Received: by 2002:a17:903:98d:b0:215:2bfb:3cd7 with SMTP id
 d9443c01a7336-2219ffba7f3mr6709025ad.10.1740095245464; Thu, 20 Feb 2025
 15:47:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z7SwcnUzjZYfuJ4-@infradead.org> <b0a8ee53b767b7684de91eeb6924ecdf5929d31e.camel@HansenPartnership.com>
 <CANiq72nnnOsGZDrPDm8iWxYn2FL=wJqx-P8aS63dFYez3_FEOg@mail.gmail.com>
 <a627845f73f2f7bedc7a820cfdf476be9993e30f.camel@HansenPartnership.com>
 <CANiq72m5KB-X1zck1E43yffXOTeD4xRmZgDx_oUiNwR941ce0w@mail.gmail.com> <f7b44799a3feeab3b255f3b0fc4dc164aa72a6d7.camel@HansenPartnership.com>
In-Reply-To: <f7b44799a3feeab3b255f3b0fc4dc164aa72a6d7.camel@HansenPartnership.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 21 Feb 2025 00:47:12 +0100
X-Gm-Features: AWEUYZmirNGIZrUdh84qKrY2kE8MT5a1w-XvyAHf-8actLBHDItgVVCNV612XPw
Message-ID: <CANiq72nDcXrSo79-nsM_Cu-npoVirksiRpPYJiPrcsB5OEVQag@mail.gmail.com>
Subject: Re: Rust kernel policy
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Christoph Hellwig <hch@infradead.org>, rust-for-linux <rust-for-linux@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Greg KH <gregkh@linuxfoundation.org>, 
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 5:03=E2=80=AFPM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> OK, this is just a terminology difference.  I think of bindings as the
> glue that sits between two pieces of code trying to interact.  In your
> terms that's both the abstractions and the bindgen bindings.

Ah, got it, thanks. I was confused by the "headers" bit, because I
didn't know if you were referring to the C ones or the Rust "headers".

> You say that like it's easy ... I think most people who work in the
> kernel wouldn't know how to do this.

Yeah, in the general case, one needs to know Rust and how the safe
abstraction is designed. I only meant in simple cases like the "gains
a parameter" I was giving as an example.

> I'm under no illusion that this would be easy, but if there were a way
> of having all the information required in the C code in such a way that
> something like an extended sparse could check it (so if you got the
> annotations wrong you'd notice) and an extended bindgen could generate
> both the bindings and the abstractions from it, it would dramatically
> reduce the friction the abstractions cause in kernel API updates.

Yeah, it would definitely be amazing to have. Nevertheless, I think
annotating C headers is still something we should do as much as
reasonably possible, even if it does not lead to full generation. Even
if Rust was not a thing, it would also be helpful for the C side on
its own.

> Yes, I think it does, thanks.

You're welcome!

Cheers,
Miguel

