Return-Path: <linux-kernel+bounces-343790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E76989F80
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D7EC1F21DCE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7C618BB97;
	Mon, 30 Sep 2024 10:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJgmKAZ2"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208E51741D1;
	Mon, 30 Sep 2024 10:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727692532; cv=none; b=GPJWFjw1MIm+CPfchAmHO02D+cpsMvJTmniTW+L9j17YclCVXP+B+4A26sPjD/0uGFpntBHc7CxPzjULEeG5jZWuICNKVz/bmU9rVU/+LMb7AV5nXcXcg9VcwDJ1z2rEuzIq8FIQo8g92RJSOX9eStHaAAIydJTZuHAVwseglxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727692532; c=relaxed/simple;
	bh=xDoQkeunACq9RTNUefkWmnh7ul/d/CPAzvNoFEo2V30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vGd9vqxRVHHspGiBfAqk8hbDNEGhzvd23pozOuciF5mA4SXDsIMKvS4GHE5HXgluOabVPlWR5++hHN/4WYHBgJ82e+9TgZyze1q/wO3ahSrf0VOp5vhPWCe9LwfeQGz6A5c47VKfbr0Y0b6yE0FZuoM6H67udBu57Q96fNo6GYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJgmKAZ2; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71b00a97734so3624809b3a.1;
        Mon, 30 Sep 2024 03:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727692520; x=1728297320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDoQkeunACq9RTNUefkWmnh7ul/d/CPAzvNoFEo2V30=;
        b=BJgmKAZ2joC2T0DBlSaiQYUJeKH6CXm7Z3iHDBDfgf9qtxxi8QOyId7e7sKhf8p18N
         NuzKhyxaGGwZOBCzzoVRq/Q5PutvLNqy2m7JNz/QNPyp/gjA9JgXNjphGVXXCoOq0/7U
         eHupHsEepOlEHqsm+9ow9jK7N7/8rMS1e+9fQ+/aDe7R+pwFRMVAOw85QQWG04TZ2MwE
         2Zd0K5hUKQsCA2auCLrMLi8dp0IqRRib7FNjA1607aa6T8KZANB2nb1o8sth0iqxtSFP
         Onf7h8Shy8LsjQukOWtsNCx24dxuCLy33RvWI67ZZNUjW2xTHdkZ0Oyc0xvZayuGfzD1
         e4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727692520; x=1728297320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xDoQkeunACq9RTNUefkWmnh7ul/d/CPAzvNoFEo2V30=;
        b=mRcPiOb6WH60PXTlukbI9fSi9ge7iO9vmRps/wjP1fnf4297+V2YCn0eSr7rGEGYek
         K3sNEgpESttNANLHMOgWEy1P/dQjbD5pbs4U7J8P4G14CZP6oQAqFwF0t8eOUzUY692R
         V8+F1N8aiLHrZYRa3VYFjEU+HYdSBrCVvUI/UzdqYKr4gO+R9U/Tjyq3B1Isz58qvnwq
         tkKHh3oTg2Q9GVRiMZuBGamN48qIJ4+QZ9GQkeqxowyPmzRlWdEZQurWX8aMmEsOCm0H
         lGHkTFnIaGRMcK3hlcM9e6BdMXzVmRtnmzcdAgXtUzic9KLqcQEsBwkYkRfjQE/GpBNd
         mohQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAw11HLk5eCDxkfZBsjdyjV2kVMeenXtssNMt8QfGQIQyy0MJ3J6sauM7wuG50swNVjLtxUze8iI1fKlI=@vger.kernel.org, AJvYcCXBSRBmtvGaJ7dLNRBBTpT7Pe+JsYNINWUK4x78FEzSQODNfuEJgYuA2stIPb6oOi6CuCT7ebJNWRZveooq@vger.kernel.org, AJvYcCXrRh0YKV06Ldzfps4R/3jICRg7fxin3DfrkjyAVqVreNZd4OXgJlqytx0KI0LYbYvcVpH6IO6LSp1dHEGPRo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW39JGdA4Oawtpe+6+TsrquN2Aa+4HLQoFDSbxTvHRFtKrZ3/L
	/GfPS279V1hqjSayWCEsdiaDlzXSodrcX8Ncr1tMFj9OEX+drW5+2PICtX8COzveU7f6nr58H8F
	jNbhtFGEbA7FuFCU0E66A+cTQS70=
X-Google-Smtp-Source: AGHT+IElmg/UmN13hVhzMhg26sMLrTxWTmuCjrIpxUD7Q3MrV6kqCSdFAf6UhNnuRY+RaLn/nv7Qi8+DXcSuojvohtg=
X-Received: by 2002:a05:6a00:3cce:b0:714:2533:1b82 with SMTP id
 d2e1a72fcca58-71b260776d3mr20103715b3a.23.1727692520256; Mon, 30 Sep 2024
 03:35:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dbb63b5698aa507bbe3dec54b4458a3f151899d3.1727606659.git.hridesh699@gmail.com>
 <bf6544faba2b53ce901b2e031f3d944babcc7018.1727606659.git.hridesh699@gmail.com>
 <CALNs47vT=g2D7A_cDq_8F2xJRJTK-7KtQY4brFYfkopyCSjLTw@mail.gmail.com> <67il2JOf-dSurc3O-294W5k5mS-kf1FtFxKzXlxHHykGmIvIkfPel_pPe2LGX04HSnTg85LwEdU4Zz2VCrfXgIl5KVItUm5vPhbtkThc3BM=@proton.me>
In-Reply-To: <67il2JOf-dSurc3O-294W5k5mS-kf1FtFxKzXlxHHykGmIvIkfPel_pPe2LGX04HSnTg85LwEdU4Zz2VCrfXgIl5KVItUm5vPhbtkThc3BM=@proton.me>
From: Hridesh MG <hridesh699@gmail.com>
Date: Mon, 30 Sep 2024 16:04:43 +0530
Message-ID: <CALiyAo=udy-P4ki1-_CAk7bHWfAjoioYEZ_ah+i6DJZ0MmmCQg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2 RESEND] checkpatch: warn on empty rust doc comments
To: Patrick Miller <paddymills@proton.me>
Cc: Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Andy Whitcroft <apw@canonical.com>, 
	Joe Perches <joe@perches.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, linux-newbie@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 8:11=E2=80=AFAM Patrick Miller <paddymills@proton.m=
e> wrote:
> After the latest revision of my patch [1], I split the if statement so th=
at
> there is a parent check for rust files for future rust patch checks. So,
> this would perfectly fit within that block.
>
> Do you want me to add your code and credit you in my patch?
>
>
> [1]: https://lore.kernel.org/rust-for-linux/20240914181618.837227-2-paddy=
mills@proton.me/

Please disregard my prior email, I had failed to CC everyone. Since
the change is small I'm okay with adding it as part of your patch,
please do add the Co-developed-by tag, thanks!

However, I was curious how conflicts like these are generally
resolved. For example, if there are two large patchsets which conflict
with each other, how does one ensure that they are compatible, and
even if they are, how do the maintainers ensure that they are applied
in the correct order?

