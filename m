Return-Path: <linux-kernel+bounces-399547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A259C006F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 09:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FA44B217D3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 08:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B821D95BE;
	Thu,  7 Nov 2024 08:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpxRIQoc"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6411B1991CD;
	Thu,  7 Nov 2024 08:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730969410; cv=none; b=GFnZwd69la29OamhyNQkJeD2yiFxbIuOFgzt8YRHv/F5gn0BrO4iH4g95tXp22AsUjZ68RPau+9f7D7DFUziBbh+V+0welotxOsGEUlF+L4LOO98gqDZG6D33evZgFelAsw73Vuoqf31AMiOgNWEZ9ALglmNX28qeVM93rM+b9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730969410; c=relaxed/simple;
	bh=H8MjRnjID1uTEDUAKHEgT4tFVgOx5diYG2ePznb9AV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XoftcMNowbRIivv1j3TKr7LA6W0m9yrDJzV9VDl/GKey/Jb8D6ycyzLTXg3gseMOwAD5M2AnWtYWyS0B4inSWAHmcU6YvQd4hNW1CSKmhE47ZRoWEzKGXfhgU27AtgYdk+2m4Zh4Al9oJmbn7xtOwfiC6y67oPQzcdV1AfIBDZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cpxRIQoc; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e2a96b242cso105369a91.3;
        Thu, 07 Nov 2024 00:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730969409; x=1731574209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H8MjRnjID1uTEDUAKHEgT4tFVgOx5diYG2ePznb9AV4=;
        b=cpxRIQoc9Cp0K+PNqhZQ3F68GIzVc0elHbE5ByovnwVL//wNxZeY61jB8XofIhYia3
         cO3GdhiN7QkhFUNwcnl+6MN82wVR4LvMR/Yleek6wNJ24kdqLrDW2m0HMMSGYiyl0lY7
         zlnIoIdXYez+YG7va/U9nnTGiyx9mBad9L3wi0elrD1v4lMXLgVERX5dvPQp20/Ejpat
         xtExYnhqOGLPbY1nEV8V+CEk+mxjdoxpYqdoa8s+W4fU/yFtXXlEepvys6vIg1rK+QVl
         7SZK/S+1BvqNdFOE2FXuNsoRML/Dg/YyIqN+85j2lGTC4ws+qa/iGbc2n/6NQc8f1uxI
         ChZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730969409; x=1731574209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H8MjRnjID1uTEDUAKHEgT4tFVgOx5diYG2ePznb9AV4=;
        b=cRn95lTGCUSgPiNMguTXeIWg7YqE6yHhUw0cqjBCwIc7z5S2gzw6+Is03XVxUih5rn
         lj2W9Zp1AqPG02cKco4HyEwFrrENnbdhWnOuutVTryRZX8d6d2+lExBCTng+NV5BT99c
         xbVLdNDMZioAyaF1GT9/eL4Eim7t8f3C+bcpuBNOGGDGvccVyGVTfDJTVQ0DWFBQaEZY
         R1o1tDNEGyDxNGqFmcCEIcC36WzbPbuxNRSeT6IMDh/YsQBF0EVsHEu8h7xOYGQLs71p
         jByyqztwJnUGsbr3WMU95sWal0nS5b5Ln4vd3TxiTcmFBANTNjPa0E23TZKPqbKOfVxa
         esFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUccnCrndvPeOIahZCCCxEoiUX5Uy4XBgEio14yhE28nV7S51m779XXUMyDWKPadWZyARZhw1yPoSZFTmM=@vger.kernel.org, AJvYcCWF8bh0JkP2x3IA52QpYApBI2NED3Lc8HXXCiuSXuAbJpMc6Ed60tzW0z5hmJVTGjz370sqaDIH4bpnKasS0aM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm13dyX0IycXCTLSjMuG3R89IFNi9xRGQP65ik1c2uihy7Rsis
	Y0pJtuelvnW4/skuKKsqCYsgRlUUcbNaizl74Ptn+odgC+dU7+gUO/NZB39Y1+eRvpH1wwBLUDL
	PHDD4lZq0mgKLNE3+g7cl1aTllnE=
X-Google-Smtp-Source: AGHT+IExNUP8piBVCyG0DG48joA3VriVvFmk5hGZt9eVqqXsAW1UKahoTZ4/Lr44ADXYzjoR4NSNTWrz2GnQdvMqqk4=
X-Received: by 2002:a17:90b:4b85:b0:2e7:8a36:a9ad with SMTP id
 98e67ed59e1d1-2e9ab0e6359mr185592a91.9.1730969408633; Thu, 07 Nov 2024
 00:50:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104-simplify-arc-v1-1-a4ffc290f905@gmail.com>
 <ZylNvC8enwPG4IQ4@Boquns-Mac-mini.local> <CANiq72nQ6b1wO6i6zWW6ZWeQFN4SJVB28b216FDU70KmtCbaxA@mail.gmail.com>
 <CAJ-ks9=xW_WWZXB0CbDvU-3otkYs-TY+PSYeiPyidM58QujC3g@mail.gmail.com>
 <CAH5fLgjXXE32k2VuC9yGrNG7ib5vo7V+fsvRxWG0ijopK7MDCQ@mail.gmail.com>
 <CAJ-ks9=b=UEp9KCZ5_dE5yDKWZ1BEfnTkAtS4LiNQ4wzMgdT4A@mail.gmail.com>
 <CANiq72=MmpyquVfi=796v0BAmx6=yuy_gvzeRgUVPhpq8E4rrw@mail.gmail.com>
 <CAJ-ks9muM0RRtawt-C=vwT7b29rhsHbh1FjpX7LbJ=a05tLuPQ@mail.gmail.com>
 <CANiq72kBo4x7D92Xe7Wkvu=Jj+YmMH+-ARiovG+SHt9BYECbvg@mail.gmail.com> <CAJ-ks9kWuQEaj7DUqHm50jAS3ageYZktsiaJvJmava=76mJP5w@mail.gmail.com>
In-Reply-To: <CAJ-ks9kWuQEaj7DUqHm50jAS3ageYZktsiaJvJmava=76mJP5w@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 7 Nov 2024 09:49:56 +0100
Message-ID: <CANiq72mmoPtPz7KEAK49KvsD9tmVuVEVW5UWyxgdcXQY_4S_mg@mail.gmail.com>
Subject: Re: [PATCH] rust: arc: remove unused PhantomData
To: Tamir Duberstein <tamird@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 8:09=E2=80=AFPM Tamir Duberstein <tamird@gmail.com> =
wrote:
>
> Thanks, I forgot that "Fixes" changes are backported. This makes sense!

Sometimes they are, yeah, but things that should go into stable should
be marked explicitly nevertheless.

Cheers,
Miguel

