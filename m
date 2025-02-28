Return-Path: <linux-kernel+bounces-538808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2A7A49D46
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B07321888059
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652DB2702B9;
	Fri, 28 Feb 2025 15:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZcWiBkF"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD1C1EF370;
	Fri, 28 Feb 2025 15:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740756117; cv=none; b=o12hUvRgFzmD5I43crYPBAt1Rgl+N0gsN4mpvRJSoWWiDmEt9V7ysrXDJ9NoY0Dg8oIV/I8Kq/u5qk3RAMBO8Fr+31IocTuZ/9H+ukOEytdDrtHvLvXZh+bgBq2ssenK/Dc0bW4bW6Zbbv5rJQGc3tAjWE6uK9+XhBJFCuEZAJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740756117; c=relaxed/simple;
	bh=7ACmhJ79hYH9IFo3LzuVdaynq3mT8w0d1v9RWvg98Pk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WVthPlbOPz0wW9+K7hDBTxh3J21zZuCCwATAS//2ovS7Y+D7R9K3owJMDI9vgne1FHaNDuFO2qtteBDD7ft2x8qLGCQH8wdw9o107m2Sli6gp4oyEzFFs0kh381mq+EeiOB76cHylf09C64iQ+2S+73NDc0LDoAAtH9MPVz1fic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZcWiBkF; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22348051cf7so5412925ad.1;
        Fri, 28 Feb 2025 07:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740756116; x=1741360916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ACmhJ79hYH9IFo3LzuVdaynq3mT8w0d1v9RWvg98Pk=;
        b=bZcWiBkFlyLIjebJriG0TJ6YMw9yzAllMXa67/skBT4tBmIcC9qpAOyu28xkN84EKP
         u/Uuti2iT4Q4sJrfCSX0IHo/XdYJ6zEVUQN22Le+hlxT4BRCNgbCGjbns0HRd67Ks5NS
         ibj6NKqC9cOWIJXDd61IHF3W8BNoPLXTYlfpffTgK8ORhYchG7U0j9MbU+/uwuSkErbK
         nfZ7agCZ/WWstk8ZD9+mS9UCwBVG3V7TOy/mCGvlJEgXFDNCIA6f8RmCY8iCasyUJfFg
         frsyFVeGzf+pIBDgKOUM/o7tgAA1m6n+dwatz6SAGHAmz5n4uSRxG4PhUcGRtR+2Tkkb
         MwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740756116; x=1741360916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ACmhJ79hYH9IFo3LzuVdaynq3mT8w0d1v9RWvg98Pk=;
        b=uj2mhQaiS1Ovp5z7jE/TBj9t3ghWkvxSjhB+kzZNWPk8YDODDij6GgTlnVmNfKIYdo
         kNipYncWPPKzXiL3ButGpfL8H8WjYSswA1OGwU8jTntmYIByQ+mksvWE2Mk16V8H2DvO
         F03oUE60U8x3T1TpNsK56ZZu1D65R877Q82OYgEkqFc4emRUJqYH0mQNNu21Hz5UbKla
         c33990sAwYhN2P/mvfUnYpw2dR/6aiTX016wBj9pFnJure1IQKehNCZMNH5LhVQ2WTwl
         BShNprnqQ9bXDKzXhbHFlUUTcGtlQJ3a+sjKnIbwYoLWXe3n6JO9k9hQRX/JUBWd8gO1
         QgeA==
X-Forwarded-Encrypted: i=1; AJvYcCVRF+Uv0RlqoWXNrPHSYDJeutS5WrisDXUDBAZtsEFeCh9WcfuX0vNio03Ca7YUQs1VppbCpEN8zIV/7y8=@vger.kernel.org, AJvYcCXRO2WQJvn43TgeVQitEdRgNBIjEgHBphPTYR+f02H4DRTuYN+5Gy5niVFFXtbvLJPFHYGUeN9JSO1IZmcpmWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCA3ZrJqVZ9GghuOrUdMZOutWbUAsdjf7/vSnemW5Oqf5QTaKo
	QcSMPVevSlnFrym0+keiBc5zC6pNfCw1Oa9giebZ2iYpI8CiYK+n+GrSPAU3NLEUCp8uA4TO0jC
	X5ekoWc5Br1ibCksflx9ImRXAa+4=
X-Gm-Gg: ASbGnctfN6iN+6gMLxkQ5X3BoVbz/RkkEDMHcsydyeDLdjCxbSz2h0I1C2wpp8n4kJN
	uFzUMdiqAGu91wWkupIIqRuu5ZdMFBWTHvOv1YKfm0cBuIxW1uiVzBIOs/vh3jemm79WzwL60ni
	XIGiiU6X4=
X-Google-Smtp-Source: AGHT+IE0xocSm5hllgwGR1/fNKAARoouiHtcKZ6V7E50P+V7phTQQVYrrlf4TPAFnN/ZEGTqXUIgXw8bZTtXdyxvZjo=
X-Received: by 2002:a17:903:183:b0:223:364f:7a5 with SMTP id
 d9443c01a7336-22369213d54mr21406765ad.11.1740756115602; Fri, 28 Feb 2025
 07:21:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <EiaQ-C0o3GMQQpw3jCnXUnNgph2WIJ5-Cm8P5N9OysIlDKYrjHNun5Ol4Q1FfVGw64k6TGCfUVBJK5r0_2eypg==@protonmail.internalid>
In-Reply-To: <EiaQ-C0o3GMQQpw3jCnXUnNgph2WIJ5-Cm8P5N9OysIlDKYrjHNun5Ol4Q1FfVGw64k6TGCfUVBJK5r0_2eypg==@protonmail.internalid>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 28 Feb 2025 16:21:42 +0100
X-Gm-Features: AQ5f1JpUZd9TEX2wazFqdL3Wa8n4UksTu_xV86C587GpeNV0TZCu_fE9i5NuHeY
Message-ID: <CANiq72=q5subtcx=kEmX+Jh_ryB0=P0RtraQM65CcvPWGvnD7g@mail.gmail.com>
Subject: Re: [PATCH] rust: adding UniqueRefCounted and UniqueRef types
To: Oliver Mangold <oliver.mangold@pm.me>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 3:43=E2=80=AFPM Oliver Mangold <oliver.mangold@pm.m=
e> wrote:
>
> This v2 of the patch, addressing the issues raised by Andreas Hindborg.

Hmm... Something went wrong here -- this patch looks broken, e.g. the
SoB is at the end, the title does not say v2, these replies seem to be
part of the patch, etc.

(Also, by the way, in case it helps, the message got marked as spam in
my side for some reason).

> Got it. This version should be okay for rustfmt, clippy and checkpatch :)

Thanks for doing that!

Cheers,
Miguel

