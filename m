Return-Path: <linux-kernel+bounces-343905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D29D98A109
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 13:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E778D281170
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E6F18DF75;
	Mon, 30 Sep 2024 11:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cc+d8/sq"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C6F189BAC;
	Mon, 30 Sep 2024 11:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727696845; cv=none; b=Rfh9pIROHfoeLEAaJa5VfU7uImucthKPUoSYVC7ljDiSR3LGi+flgu4vo3OYG1BNmb5kV4MU3jYwtqeX72l1YO63mWTFdVO7eiDSBZRWVnc176TB8Ybwa2KC3N7dldf4BpMcd7X+RTb5ViM6Eq2WwTcFEgr3gFgkrdUWBYRZm6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727696845; c=relaxed/simple;
	bh=JCpSttHFP/sRNbXFgE6cXFPCgz9ErLHl5Fk8pNKtpWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PDkJB+zDamU+MyW548l6GPcZ8LGvEQvazdwyS9GGchEY9ccF4U8JNVQ/dqXbfYvAQxRjeYyPiYo9KIb4wKEAA3vWRLHl/xO0vsJdC7z3KfUWHw1UPPlIsRR0GbN6rPTny7lmqLjcfxf9jHn+02V5po2A7owMjDy41g4up/cQ+E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cc+d8/sq; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7191f1875d3so291108b3a.0;
        Mon, 30 Sep 2024 04:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727696843; x=1728301643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JCpSttHFP/sRNbXFgE6cXFPCgz9ErLHl5Fk8pNKtpWg=;
        b=Cc+d8/sqcX3LOPDY5aE06VkuyowAIITJDMggcAT6D1YW98acF5B35M9IDiSvd4iqVN
         qTIp8mgQ3AvxGLXIlLpdSJCqH55RGIGSHk+xloT0KHGR1H5IVnQYYC8Vj+DABjv7noHQ
         truLhu1ThJ2+ALsYDserX/3RDAzu/bgzSGjZQ+DdyeHcNUnWfPjCuzVuhMnSdGrqkWfo
         k9wi90dxPcBBRJ2j4jgnfta1wGaYtZc2mvIYOvJ9th3Pfh9dAhFSE/SXBH76xUCiJfYi
         PHj5fZifCRSjLDt2ZKrGywrd58jn/ulN31YK/ZOH08RSKQKT0qPhEyKneRNeR2G4FYK3
         l/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727696843; x=1728301643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JCpSttHFP/sRNbXFgE6cXFPCgz9ErLHl5Fk8pNKtpWg=;
        b=vJuvxnqA7NthGq2wbsrOfSc3gWIgzUWbmYVlsaqa6UFGzKZCwzdKeLowPdYrumU6gu
         d5hCG+a49/KaOZD2eeaFDboufKCUkHU2QlDbiWOiJYjh+lLciCcsXrC2UkPoHLDtmcC1
         OH3IW73fgNkwFR1caDJGIXbpjhE6SBnOFxAVO3FlbrAbJirCLZqCxI/IoDNsFh8ImEsw
         XaGkW1moTSJTHFqWuAQz61lZnbxj1rA30rxvqjB7QW4CgRNjO517OYONq5eCSbqHidye
         oBq14KXuuEtO0xkMCwiFho7P0Nc5FESX4jVg8XDPiR5hvZXCPzqPydiLz+BzQKkBG4uw
         Ur5g==
X-Forwarded-Encrypted: i=1; AJvYcCWgF54ABJjGG6uOjX+O4c7snuNNUDSq24JPAETdXKDB5x/paNvn2KANPkMLbcXZsQNFnn8vcRJdu74XYe8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/FGtr4cttLpnBPvbxOtdiMri0WifHT/RZMLUHIru23eEoWMcj
	KBrFpk/gEBtcf9NsPDdRv4GOX5QknrCnbA+anqtJ/HCfh8os2aVIdAH6s26wVXGizCLC19nxO37
	TWc1EFjNk9zFjViYxczjrzL4hzcQ=
X-Google-Smtp-Source: AGHT+IF75ggKJebpBSFErmR+84WGmKpaEKzUKHgJOEyYQDg7qv5O0VbMdemWI9cbiPuv9+Dbbx66lNegH4R+T3WMkps=
X-Received: by 2002:a05:6a00:b85:b0:70d:2c09:45ff with SMTP id
 d2e1a72fcca58-71c636f23c9mr4909037b3a.4.1727696843366; Mon, 30 Sep 2024
 04:47:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dbb63b5698aa507bbe3dec54b4458a3f151899d3.1727606659.git.hridesh699@gmail.com>
 <CANiq72mrcMq7KKn5UiT2GuZPCeFMtr63tj9JTHnVLfzmYDgauQ@mail.gmail.com> <CALiyAomzktZWhGmg4O7tY8ywAG-crb4AGoyFyvQv3SBTyNXH2g@mail.gmail.com>
In-Reply-To: <CALiyAomzktZWhGmg4O7tY8ywAG-crb4AGoyFyvQv3SBTyNXH2g@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 30 Sep 2024 13:47:11 +0200
Message-ID: <CANiq72k139A9C-gqHJ7nmChcnYyQ7b9iP1Yq3dpuasxn0O6S3A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2 RESEND] rust: kernel: clean up empty `///` lines
To: Hridesh MG <hridesh699@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andreas Hindborg <a.hindborg@samsung.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Jens Axboe <axboe@kernel.dk>, 
	Matt Gilbride <mattgilbride@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 12:36=E2=80=AFPM Hridesh MG <hridesh699@gmail.com> =
wrote:
>
> Ah, I think this is a cultural difference. The "MG" does indeed have
> an expansion but it's only used for non-official purposes; my name is
> stamped as "Hridesh MG" on all legal documents, so I suppose it counts
> as a known identity.

If that is your legal name, then it is fine -- thanks for clarifying!

Cheers,
Miguel

