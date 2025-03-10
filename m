Return-Path: <linux-kernel+bounces-554772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC786A59C82
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2751316E77A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04DF23237C;
	Mon, 10 Mar 2025 17:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRtgTEsh"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFD1230BF8;
	Mon, 10 Mar 2025 17:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741626724; cv=none; b=LJHP15VtP2uARm09difS3FNPULfaija8HqeCJjoI74S6+kCRu2Sw1JDx8fvPLZ8gURbz8wMKxo5bpWbuEmvPemdLj5m0bRrICVrzB6YJTyzChS2vvZlT/soNR4mbsxfGEjU8us5Uhecveet6OXKS7LpAOW6s7mYYEkDGim2iH/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741626724; c=relaxed/simple;
	bh=+KeNyNeb0Pntm+P6vjDxjWU8vhXYlWOtttKSZLfPbvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HQzmVkcOsoGcLqfUEmb2cIl4OCgn8FFUGwkm90DvaYLFtucueqOLStxEnY/x+FMa/44H913gP8Z/CmcPDi8mqecbDjNAfWANX8XYAVI+EuxJt3bbzZx1k7WJppU1ShuoXYaoYP4+4os5J8e/ohw1AnemM+noacR9VLOw7KLkmik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRtgTEsh; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ff6b9a7f91so1166478a91.3;
        Mon, 10 Mar 2025 10:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741626722; x=1742231522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7o4EE0mgSwtI2960oGdwk2FqXpxX90B81HhVJX+s8tw=;
        b=VRtgTEshV9ngqWkrGi8RJy2Ph/44919Ag9EL3v9FlbyI5RMmVXh+Bwh6ofTdy1R+gx
         myL46wtJEeboRcV06l8Lu6YHhVLiHxcpOMJa43uPpp9tfz9v/w/35TgIA5kXVqNpcAdo
         OnChEtjImRcyBNuWoErHnT4tOH3q5WNQYNaBLR/22RtW9n+MOwYn4Dx3kbKu8oZ6BaGy
         3aLy/MIcAE4yo7XDSUnM/UrPk+r4aIflZ43u5Pkr3cenz/3JtGLDsmd9dTsp7guGS+VN
         YaIechtvLLpKEOjodU12L9PmpzLIQuBQ6nTpvvBekHpiE7TQhXPoSjnPcck89DLbcBgA
         DQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741626722; x=1742231522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7o4EE0mgSwtI2960oGdwk2FqXpxX90B81HhVJX+s8tw=;
        b=bDRR6k86eDNOZoSo6NalIGsWQJWl+POhwjs7rt/oR0fsIr46DbndgTmDMqdVqsrNYe
         wF6dqmZBDzVjfa5U5vbqePOdrb/yvAA1598I0KlnLp/RGGyj+GSssrkVHOa289B/rieG
         D2F6sDpRpHBciXac1MlBBpfKNPgrzQrD6pertM7Rh3G5EyNS1YucrfwF7oU1Zzv7CrpK
         Cy9Bt4/XGF3o+eodrCeBCn+Wr6KpbgXFy7K5VBmUVFZjqB9cn5xfy1tbULvqBuqJLGFX
         qP27BCsrjx2T91FNduacja+VfaYQTq8Kuo7Ic+Y94FTi2nWKWsLUo/6Q0W52M9m+WSXd
         QUnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUi+73Luwr5BcU6LxsxJuEMvtTjlDkpekXBaQuR1vUIhhHsY4azUotfITTklXq95cCWs28K5kVzE7FLFfvqBl4=@vger.kernel.org, AJvYcCXuwkYXPPdhRDXCAPbc3LAwLevnLA4FHaVkzNR4SGZ2pm3GTDBMQw1QSwJPEoSFrFcaix56pG9fzoh0L9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YygcY4Z3/vXvqqysbErSgJgyhfw77iYWw9S78JAt/201JQYKCQX
	9EaBs1ZJatTRmS+FD1a2f0ad2XhO+3wYyZ/wOJRzThWJ7RmxZnLrdNbYsSqjQ75FWV+7NfzrsDh
	licqvIFFig/yTC+JEG6KJCxxIYvc=
X-Gm-Gg: ASbGncsRjFMBUgTveEuo5ahDaDAKDHAmMnSseY/WLs7kxN7PiFqim0WovGUMq6Av8Pa
	te/6Ad7wzO86+3AbxtcSOGE4btG9U6a22oRHCqrUoxXEgg2bcIVFbDaUL0n+sSQsq/hlB93KnPN
	anVrI4h8ovU5AYhe3pk+qw7F/MFA==
X-Google-Smtp-Source: AGHT+IFRMp2YwdDQNOOG6ck+QiuaTJuTjyA/i0dHK4fDsZnwg0FDd3tqbXmlnRD2C21jmwL9FJ264YY6GXU8ERYF4DU=
X-Received: by 2002:a17:90b:1b0c:b0:2ff:7970:d2b6 with SMTP id
 98e67ed59e1d1-300a5788588mr5909745a91.5.1741626722028; Mon, 10 Mar 2025
 10:12:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250308-comment-fix-v1-1-4bba709fd36d@posteo.net>
In-Reply-To: <20250308-comment-fix-v1-1-4bba709fd36d@posteo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 10 Mar 2025 18:11:49 +0100
X-Gm-Features: AQ5f1Jp7hOMjOo3P1UrX-bQ7wsVU5rpdKSRsiJfkOHolh4r_xmBMIV3I0jA4eho
Message-ID: <CANiq72ngczwJNk-YVuz_pe+=Y5uZm06ZD_wy4HK_nw0+guHAsA@mail.gmail.com>
Subject: Re: [PATCH] rust: task: fix `SAFETY` comment for Task::wake_up
To: Panagiotis Foliadis <pfoliadis@posteo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Christian Brauner <brauner@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 8, 2025 at 5:49=E2=80=AFPM Panagiotis Foliadis <pfoliadis@poste=
o.net> wrote:
>
> The `SAFETY` comment inside the `wake_up` function references
> erroneously the `signal_pending` function instead of the
> `wake_up_process` which is actually called. Fix the comment
> to reference the correct function.
>
> Fixes: fe95f58320e6 ("rust: task: adjust safety comments in Task methods"=
)
> Signed-off-by: Panagiotis Foliadis <pfoliadis@posteo.net>

Applied to `rust-fixes` -- thanks everyone!

    [ Slightly reworded. - Miguel ]

Cheers,
Miguel

