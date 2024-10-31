Return-Path: <linux-kernel+bounces-390584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B657F9B7BB9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 14:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A14D281FB7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 13:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AC019DFAB;
	Thu, 31 Oct 2024 13:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWAS+snB"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7654814901B;
	Thu, 31 Oct 2024 13:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730381456; cv=none; b=eaSjau+bsRCXDlkkhZHRRoARx4MKOhhNt2+8ULhDLKIy5SaaeTJILOV5i11cywYttz2YFpJaqs79qpnyhUdC0XbelBmSUpV7EXYlqJGmM5pmbUy8W9P7A1c+bHfhKZsSEMxIbqTBhXFcC6ddRPM4aGq2Q7CZKO6Bu5A9LiW/rfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730381456; c=relaxed/simple;
	bh=NfLIGeDaw18FAGlX4fbe7xt3D2534q3CjGw2MZWy5hA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LVcDXHtBienWyttJpg+tIRl0ZbBQ4hYW+toL3oraeOjz48z3Mv/faIzsqlYlrMnuk81YKXoAnhVXwO8YiL4fHJptrmxHDa8FTZTeISmWLNfEexpQay5g/Nff2700AFFSfmc0xB3H5HI9QFg8xewUf38PAciVt6Bp9umCgfcLHys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWAS+snB; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fb5638dd57so9019241fa.0;
        Thu, 31 Oct 2024 06:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730381453; x=1730986253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NfLIGeDaw18FAGlX4fbe7xt3D2534q3CjGw2MZWy5hA=;
        b=UWAS+snBWR6S71ZXHfKl50HbWX+Sg5Q5TyICYN4OH4mC46IeUeF0xmImVb6icTva26
         5djHyTXY0hYx2xjW0z2NcE937euKVeRUtOxJbktv9VHlwj43LHw/IA7z2d5EkTecZtiJ
         pGMjhi6zPE0G9osgpbjrBuvVwTujr4H6CS9mamIQnt0jGRNohjcZwE30YegzzbjFBwfJ
         A5xQlmT3wLJYUbtbmiWIZkwo08ooUeOwS8ZPzrEsA0HuQI2gKND4rx//yxAd6rEBZxCN
         dT/WZixvtoFzAmxTgiIHLYmncK3l3AhUXm4ZbiI6og7+sSG0dJR9iM8IO/dbLXq6X0k9
         zqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730381453; x=1730986253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NfLIGeDaw18FAGlX4fbe7xt3D2534q3CjGw2MZWy5hA=;
        b=ondBIS+5k7BVIunYfNlZhDkpl5+XtIimlFRGhpRtLud3O0mkQcGSQXHoyUGOWZOFD1
         MwDrygP/xccNG/tTgen9q3WCdPYT7pCk07hlph66EiWIfg8mPU2vSrgMmnMfZe+BS3V1
         6t3CNeUHLJKZQEmPOJGTE+Xsnw8R+M9uAOJ2UCtv4HILQhgmOhJ5Vpldm0O9S0G8I8bi
         A/xZIBJ0aZ6uU/YHhH1bxGUojXCaamgacIbDcRNt8kvhZP4rjE6/HsxwMZBRUlCbcp4M
         fOfX2n0IwHEVoE58z0cyqQIf3m51G3ABKciCvuyZacTtSgApgWF2ikPwxbFLBMuGl9gy
         3Dxg==
X-Forwarded-Encrypted: i=1; AJvYcCV6R2ZInEhDWlw7txPbLAQ6PHrBDnxf6wEytD+CJZEglyMEHy+5qYTBv0M0xaLVHDvYJyChRuzDjsNPe3w=@vger.kernel.org, AJvYcCWow83zcSqWSuuVE0pDgnI4BZFyttk3fadVqla2QIXBQ1+OWXTP5+Q4JEAk8MguL1oSsDeXYFrmT5sr5DanwCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPd5AkwqbZZ79Nm7IgiOi9D7rvOcZbyxsMQ+0kGikPx6WHfnH+
	UmYu2X2TBm3n2kxRvGFh5zv7o3Uplqal9k4Okg7vfhn876QfQ37yc35WX1B/2fXk7TVFkrfP1+L
	uBks/Ll60F+yCRAMIeSGc2riApFY=
X-Google-Smtp-Source: AGHT+IFcwTon6tIY5EFfcay8SqKZjCjiZZdmJoWLH6TXRlHf74KaW9+MCxKW5n3qJZtXQKFgo96Tb5GG8pucmrjJ8p4=
X-Received: by 2002:a2e:b88e:0:b0:2fa:e658:27b4 with SMTP id
 38308e7fff4ca-2fcbdf5fe55mr93967721fa.4.1730381452321; Thu, 31 Oct 2024
 06:30:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030-borrow-mut-v1-0-8f0ceaf78eaf@gmail.com>
 <Pn1b5OU4cqz38Aiv4RL7MuzPDwDGvxLVRrLuCF7Q3_HaeLzlh4jaM0krBqB39DCFmRLWK59Do8DPaVxLNaaTNQ==@protonmail.internalid>
 <20241030-borrow-mut-v1-4-8f0ceaf78eaf@gmail.com> <871pzwpsm9.fsf@kernel.org>
 <CAJ-ks9m-THyqK1tYL39t979BagBqj3Z-MOSn8wPhDc82awjzug@mail.gmail.com> <CANiq72nX2=yigRKhP3jN0kQ8vD0kMvUOp3rFpRQZJGAX6RrRhg@mail.gmail.com>
In-Reply-To: <CANiq72nX2=yigRKhP3jN0kQ8vD0kMvUOp3rFpRQZJGAX6RrRhg@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 31 Oct 2024 09:30:16 -0400
Message-ID: <CAJ-ks9mf2H8xZ+uZyeQqiGEDY35tyDBP-UpaqXhe_padv=Dqmg@mail.gmail.com>
Subject: Re: [PATCH 4/5] rust: reorder `ForeignOwnable` items
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 8:40=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Thu, Oct 31, 2024 at 1:23=E2=80=AFPM Tamir Duberstein <tamird@gmail.co=
m> wrote:
> >
> > This change was part of the original patch. Do you prefer the code
> > movement in the same commit?
>
> If we do it, please keep it separate, that is a good idea.
>
> However, I think Andreas means to avoid the movement at all,
> regardless of which commit is used to do it.

Understood. I'll update the commit message to explain that this also
avoids inconsistency with the implementation in kbox.rs, which is
already in this order.

Andreas, please let me know if this is acceptable.

Thanks.
Tamir

