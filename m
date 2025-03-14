Return-Path: <linux-kernel+bounces-561062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C8AA60D22
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E834A3B91A4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9838B1EFFA9;
	Fri, 14 Mar 2025 09:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ErztoXTa"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C21E1802AB
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741944135; cv=none; b=iZr3Idk/pd1k+2tYMhKcgtKWvgKbeA9a5jGh2GhKwP7AuLAwTF67LOjsfNpHSoYYSKsQWOsi+Lv2cLbfvGLfsjKLG6APXweEB6iBBw7FjVv3U5MkTBrPyGkNym83VhThLgqCD4jo5jV2aE1F0qlPIAB3vGQ0hXqbIequIj+28ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741944135; c=relaxed/simple;
	bh=wSLy/tKZRMSxZhgOPYP+lRHCiDRNfSCHCfpnD1lPsyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YoqDwDgx2g8StXxhW+rbXn/HEIfynsfn9GL/oHFQ8YaSZzieGUPXFGWB3CBlruybaiVG7GL2UwpKIsoECFkHx57nEtJq2utHk3m5ps5zLzSrAAzRGjmXaiJ9GEcssyAqpoUCMkw6COD4AmJQrhCMvwvbNihQkBUIevfiX/6qfTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ErztoXTa; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cfdc2c8c9so12328085e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 02:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741944132; x=1742548932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q+KUI4Lx73PJKjwhnAttQQrPPQ9GUBTUAKyve2K4V2c=;
        b=ErztoXTa0CXzHYmlFXmwVIZeYSVv7c/q5cdi80Re4K4o/pOn5akj3PpTSCRfxw7B9I
         rE6UN2F/zdyq6bhsuotYz5fO8BWHfB2Xh9FP2cZaQQU8HCnTXy+moG/0PtVElSL3ajzP
         a15elSx6S9G6A4NwFMm9PvctX16Fd2sCsdQSREtf6jBqxjB352Q86pmYXJVWjTxinSpM
         sgJcV+8m62bQlEmaFeHmI6+tp17jeoAu6OC92sWTAaAgHuG+LShAFJNc/XjwtGA0o63v
         ARCz1lvAKc6FtX16RGnfkgXEDxOeZMGse+8mnm6zqBAYLFZfTVSEvoEHfczCkIpBQF6+
         zq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741944132; x=1742548932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q+KUI4Lx73PJKjwhnAttQQrPPQ9GUBTUAKyve2K4V2c=;
        b=TnV5dvPm1eHkt8yamm1KPY5JRa/QYRdN32NVaZjsuq77rD6+YJQYCAKrcIqrZ86xIu
         w5Gi7Dlb4Bg+ASNgj1dpZnzejNKbRAUWVo3nhELKyy8+STC9MDi0inhZwwJs5rCendIg
         eLQLBQ65kUjk5AAhIZKs6y2gzqp8MjnWbWmOR6fgtqHTiyeKF8pDVM4aygFYTzibr15X
         YDjPUQOYE6KuR78UwBIsS5i67N6Iv+8PS5t++IxGfSUNNXoDKaHXLmpoZ92y1I7ctNoj
         nsC4iBy6/aNOIG2t4YTu4jAEC5S6lP4hp5TSmgP903yxfTqPMluOEPBC5RIXULDc6m5S
         TRbw==
X-Forwarded-Encrypted: i=1; AJvYcCXl/bgg3j9Q9a7U6QlGBIU6l3ET5reyls5CWkIm+UNKip7FSio4qfvV56WJW2adhNOTNCMFOICJMG8Ff3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQsgX4nyvXwxeYqhux3nrU1ntoyAbACzmwtp3jksqdyZwviqcx
	PTcShhwtN8lr9JZxP3dlXOo0hp1jrJbOiFueBvSZ31NC9Wi9h9Y1f1IIlE0gAukg0VlkOi6exAd
	BYCziy7iaqQNtABqNy8/JijjAHHogcqnHn7EY
X-Gm-Gg: ASbGncuiK1nihxVB+tGB61Gjp3IAOqxJ66Q2WC8yWj2aEcHMgF0wdT63/zzdlSvrNt8
	Bk0GXRBbREMZgekl3bnel9kTLDon+2UsSMa0VNLkUYr0/KUs+QlVYA2AmMVMEbLWrKwOXimZ5/p
	7mDcm9ipB+3xsTE7JUXZsr4i0lu5qJCLTwgfOCO0fbP4RU0TwCDfEMswUs
X-Google-Smtp-Source: AGHT+IFl2389eiJnSvgHMzd88pzFUgRlQu1y96idOrhkkY6/IW7t5kMp6T08rutu3B31Z91o7d44iA6hdHEiErEfyWc=
X-Received: by 2002:a05:6000:188f:b0:391:39fb:59b4 with SMTP id
 ffacd0b85a97d-3971e2ae150mr2211005f8f.27.1741944131623; Fri, 14 Mar 2025
 02:22:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313084525.773620-1-kunwu.chan@linux.dev> <Z9K3vokYu5osMCwh@google.com>
 <6c874a4f-439e-4ab2-807d-d0f59b9fe569@linux.dev>
In-Reply-To: <6c874a4f-439e-4ab2-807d-d0f59b9fe569@linux.dev>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 14 Mar 2025 10:21:59 +0100
X-Gm-Features: AQ5f1JpGzEAx4sBwjKxQGUxQi3t0tVfhh5Eh8mkLZ_0xoZt0Q9ivNhpJmJHKzV8
Message-ID: <CAH5fLgjErD9r8h_tjekZ+sNNDmkU3J3kcSmCG+Mew+-6zQq8tA@mail.gmail.com>
Subject: Re: [PATCH] rust: file: optimize rust symbol generation for FileDescriptorReservation
To: Kunwu Chan <kunwu.chan@linux.dev>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, Kunwu Chan <kunwu.chan@hotmail.com>, 
	Grace Deng <Grace.Deng006@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 3:34=E2=80=AFAM Kunwu Chan <kunwu.chan@linux.dev> w=
rote:
> > * I think it is easier to read the symbols if you list each sybmol on
> >    one line like this:
> >
> > ffff8000805b6ef0 T <kernel::fs::file::FileDescriptorReservation>::fd_in=
stall
> > ffff8000805b6e60 T <kernel::fs::file::FileDescriptorReservation>::get_u=
nused_fd_flags
> > ffff8000805b6f08 T <kernel::fs::file::FileDescriptorReservation as core=
::ops::drop::Drop>::drop
>
> If in one line, checkpatch.pl will report a warning:
>
> WARNING:Prefer a maximum 75 chars per line (possible unwrapped commit
> description?)
>
> If no need to  bother with the warning, I'll change it to one line in v2.

You could do this:
... T <kernel::fs::file::FileDescriptorReservation>::fd_install
but if it's still too long I'd just ignore it.

Alice

