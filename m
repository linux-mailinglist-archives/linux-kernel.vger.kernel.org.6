Return-Path: <linux-kernel+bounces-341039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D997987AA0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 23:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 950681C21EB8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 21:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7351885AF;
	Thu, 26 Sep 2024 21:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/YUC4PG"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C0A18800D;
	Thu, 26 Sep 2024 21:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727385560; cv=none; b=RyNAc/7qadINu9qzmzk1phxVM7Qe9KUXjtQ69lJhHdrCax49pONdRFCyzV90dhw7qlPcgoa8alro+6M7BVR7IbLiKAHL7TJUwG1vb/Gcqw9W7pWMKLFxO8cdfD2Ed8qMflKY1cQFSlgfO1lRiUQFVqUlbOTpAdG4svNKQKJ2aMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727385560; c=relaxed/simple;
	bh=kDsArXBf6a8j6EERJV+eipbquN7VuWFS+lqT9h5+qQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MeAx7yQqx957TF/5Fm9dLD5pe2NtdTWDYrisVDfoRdsVRxe4LzTo5e/mbIr3Zo3G6moSpGkG0hT8EKRKCFZq3Om3GLvWERzgNc51Rq48sKex8Vqc2eHDt4IvNhIbvZbsLtk14FGtWdsfXtH/kBRJTJSMq/sSaNy0I7XxOaI3yAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/YUC4PG; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e0b467da03so88824a91.2;
        Thu, 26 Sep 2024 14:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727385558; x=1727990358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZT6vThl0w6DW/3vNhpd4p3yZrCiKGVkkePEpwNafr6M=;
        b=S/YUC4PG1A38zAn+zUB0pOfsmCj+QE2mE1rtpLBl9kOoIVTztXWSm7WzwH0fJHaOYF
         Wl8sdUlMBK5wQ62w6It33G8L4RMKtr3SnxC85SJohPljm8W8Ur4+5JixgmRXo3QIKNJB
         Rf2eHqLdfaSLp0LNPs7G7LPgXmbw+/genWzK+mJKSQZbVq52nMW9TUdfx1v08ltbWZ+j
         wkXCDDH7aydB0JOkb78rbx6Nm/tHXoHu/LqnDafBgTBjEoBuUT5kZPDicmFBIUmk5+n6
         U4UPAxSP90mfg6Vjh9jLvCaMfQCrlTSQUWKfd90DUhLaYC3LeFhHED/aDpCG3dJ1hR+r
         FzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727385558; x=1727990358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZT6vThl0w6DW/3vNhpd4p3yZrCiKGVkkePEpwNafr6M=;
        b=bUxvIGxAhv5MtkPkRKulDIANhNEA/6lcA37Anbj/aHGP3H3WEML5AcliRWdy4SKu77
         y5S0zbnaj033DAFXrwDVchnoOmuUknd4aSCfzOF6EWhVET5sMA0dwlHi2fmZm2GaPsRt
         OIzaA+cDSIZ+dxbC+Yn830bGRizqC+3wkVbNqLNjV2+g8CrQkBvC5dH+H5P88pXZW4Yk
         /HUSiHGKQ1AMt9xlUuI+oj4gxQ0V5TOX4eiOWgXC/rLvqk22gHul51TUBgkLYnFI9P11
         1JjyPqlhmD8anV0M3z4UsJapBsSEVbPxnA3AogkFUmUpSwruTA26a3P3pIhO8ncUVhKm
         DTWg==
X-Forwarded-Encrypted: i=1; AJvYcCVeUOrxRiNxk+uW+JcEchGJwHVGux5/U4yZj5C2J6zzwNwoeEifqcToMyl+5LlynL+nxc078ZOFb1QV6/Q=@vger.kernel.org, AJvYcCVw3FukN4nvsKfpoOzb/161VO9CHKoCvVuX/7bzKUcipvrehddHjjrx0t6kbxAN7/GAHTZxw0D7HXfHLaiEblQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz22vdpV+SRRomtfKkrWk5XTjRZ7cOT8PykA3SUdtzyO1g4V1jr
	8g8LnQQligySQEUw2ktpJseY6SzeVQkB3ZrNPnzMq4RpE8nJzcB1k2e29Phn3wKQyYPMiuwMIfl
	GOeZSrk4hle7yAV9FUwcpnqJgxy4=
X-Google-Smtp-Source: AGHT+IE4+BdZ3LfDobLEZiEw+lXACKHY9OjSMU9qsH6bL5zXt19ZyY2VBI87QSoBXPl6FJAr1a79Q74C+/jwv3zPANU=
X-Received: by 2002:a05:6a20:6a20:b0:1cf:672e:cf08 with SMTP id
 adf61e73a8af0-1d4fa78e967mr800601637.8.1727385558266; Thu, 26 Sep 2024
 14:19:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926093849.1192264-1-aliceryhl@google.com>
In-Reply-To: <20240926093849.1192264-1-aliceryhl@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 26 Sep 2024 23:19:06 +0200
Message-ID: <CANiq72k9ihcNNRkiGW4us1F_cQuotRFA9_8iJuCMUJnEjbKzrw@mail.gmail.com>
Subject: Re: [PATCH] rust: KASAN+RETHUNK requires rustc 1.83.0
To: Alice Ryhl <aliceryhl@google.com>
Cc: ojeda@kernel.org, a.hindborg@samsung.com, alex.gaynor@gmail.com, 
	benno.lossin@proton.me, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, gary@garyguo.net, hpa@zytor.com, 
	jpoimboe@kernel.org, linux-kernel@vger.kernel.org, masahiroy@kernel.org, 
	mingo@redhat.com, nathan@kernel.org, nicolas@fjasle.eu, 
	patches@lists.linux.dev, peterz@infradead.org, rust-for-linux@vger.kernel.org, 
	tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 11:39=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> When enabling both KASAN and RETHUNK, objtool emits the following
> warnings:
>
>     rust/core.o: warning: objtool: asan.module_ctor+0x13: 'naked' return =
found in MITIGATION_RETHUNK build
>     rust/core.o: warning: objtool: asan.module_dtor+0x13: 'naked' return =
found in MITIGATION_RETHUNK build
>
> This is caused by the -Zfunction-return=3Dthunk-extern flag in rustc not
> properly informing LLVM about the mitigation, which means that the KASAN
> functions asan.module_ctor and asan.module_dtor are generated without
> the rethunk mitigation.
>
> The other mitigations that we enabled for Rust (SLS, RETPOLINE) do not
> have the same bug, as they're being applied through the target-feature
> functionality instead.
>
> This is being fixed for rustc 1.83.0, so update Kconfig to reject this
> configuration on older compilers.
>
> Link: https://github.com/rust-lang/rust/pull/130824
> Fixes: d7868550d573 ("x86/rust: support MITIGATION_RETHUNK")
> Reported-by: Miguel Ojeda <ojeda@kernel.org>
> Closes: https://lore.kernel.org/all/CANiq72myZL4_poCMuNFevtpYYc0V0embjSuK=
b7y=3DC+m3vVA_8g@mail.gmail.com/
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Applied to `rust-fixes` -- thanks!

Cheers,
Miguel

