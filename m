Return-Path: <linux-kernel+bounces-553355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8787DA587F9
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 20:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0C4916AEBA
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 19:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1396218EB5;
	Sun,  9 Mar 2025 19:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGxoYFV1"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA057218AD6;
	Sun,  9 Mar 2025 19:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741549866; cv=none; b=X1LLTpMePssyzYYIptl1xfucp8JpZHRUf7/g9rTIicJUt6MF2Lw/V98njU2GI5ve5cCkzS/Uk2jvKdl9864HqsibFaEd79PGePlTS+1kcoO3AMm/kr5y0z4RNzowjlOEPRq6Ilsn9vBlbfVvS9gOHGXKuIBSegmXaMV0NoTYzLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741549866; c=relaxed/simple;
	bh=dzyVokZIpDqiotKHrpU8Dw2U/v6X92xZQXOd24xBzNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CRxETNpOKuwPdTN0lcUqiWF2g2K2Zu43GLILEy9rGs7ZCMbInJtzKp0wPHRWdzEijZi3lyTKEi4CWKXmdSWh+fQDGNDrpZSsHYozi9DUxwx9VOGN3GeDtg7HclH3y/k/cdiqB83kArf5zhn5CVO6ZKU6IiH1nJYum8sG2Hv0Eqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGxoYFV1; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ff6ce72844so896750a91.2;
        Sun, 09 Mar 2025 12:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741549864; x=1742154664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzyVokZIpDqiotKHrpU8Dw2U/v6X92xZQXOd24xBzNU=;
        b=TGxoYFV16etpuUChScwsIxAON3KPVfuWBfSTbJ572dSPYDRKMWVvINqoiaN+GW9Dlh
         66Fc4uNHDFMetGvOLwC30gstV+3qYSU1UW9AYzrnsXkqFHpxyIou+ecdQp34n+pnTHyi
         mU1R6MzsUgA417cduxEqDhW4xw4/CZNG3sAw7ykp113noD+MVM6wDvmCUKGAKK/k1Nfg
         iGvFYfmHWsRUPpgtnoDrDCET9BQhdymcQjy6nXOPv8a5j/FGz/gQHfWdXVaR5GfgBS7p
         FwYmEMoQQg+nUnFVpo9Uow3xItgeMDghmxcD58ZgD4JuzO4LWBXovpaQHL62BETVHfAG
         tgeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741549864; x=1742154664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzyVokZIpDqiotKHrpU8Dw2U/v6X92xZQXOd24xBzNU=;
        b=cj+Y1GIikMHs/xL+L/VReaGRfOQDqfmhulZtRXr2Xkwjb/AKx1by6x6mX5/31J9Sfz
         h7yRJOZv2DXte8RAi1Vvr2Y36k8ChThghRCcASpYg0QLbnGitbSnIhsNUIMouhP9Wtn6
         HZ2hjSfc645X7zUbZL8IiThdwgyqJq/EJolS2Ude6nI5H9mte1htX8Jdilj9MMHPSjuD
         VctreyyI9xre/aypJRmy/Hu6vO+jO0xqTcqhkrOK3LsOGFtNDQCCOtDengczdI+v+OLa
         ZLfaOXbwvLDZxVUPHI+Qd3/zSayKHuneXGYCH9iothl6BhCBteitiuYVt9sLHa9MGEQ5
         7pyw==
X-Forwarded-Encrypted: i=1; AJvYcCVVp6zN4M5AM2qXDyfOUnqpVEBFtUzfYJ9+Ey57JB+IcgMzHIcZsiHBX+acJiBiKw30UP5Aw5Ox5lrlP8/Or/s=@vger.kernel.org, AJvYcCX2o1f2aWHHHnp1l9s+R+wQ/VCKELNMYqUW3aAhWsAlQFficBuC38VqUceLX+zMjLoCr4FvdprsoRcEso0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+7Z7HjjUrPLozIPqfpF8ypfMQR/NFfIUUZb+zAJSAUDqNPXYL
	8D3xOjpNvXwc3BGrSGjLh/MqvzZ+AFQG1G3ZBA5XW1CRjLwQYa4jm0KZ/VqWfrXUyG6p4ESap4K
	sYxhwDEs8A15mzpRiJJZMJsmvrR8=
X-Gm-Gg: ASbGncvqQhFFm7FO5mNFoz4Agtnwu7SuODBFC62+gNwG1Z/JJ6jhmcLv6gvO//2Q7fy
	3XP+lAYTMurySTaCaifnpcHWdHNDKaeRYYWpAPS3y//ZFwrsd5wpdgvKurTb3WJ/kSzCZFpbuT/
	YV4SSgeKLf5OH89m607rZnKKdYbtKXivPkqT/M
X-Google-Smtp-Source: AGHT+IHGCe9s2WblTrFMgpH8Di+4cRVJg4iC6xm/DMHz20ImOgtpVp9OzKQEgou6f82JbNw9B8+VEacVtEr6D7BHyc4=
X-Received: by 2002:a17:90b:1b0c:b0:2ff:7970:d2b6 with SMTP id
 98e67ed59e1d1-300a5788588mr4066553a91.5.1741549864193; Sun, 09 Mar 2025
 12:51:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250308164258.811040-1-ojeda@kernel.org>
In-Reply-To: <20250308164258.811040-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 9 Mar 2025 20:50:51 +0100
X-Gm-Features: AQ5f1Jp1Zj_Zln5b8Z8a8RBt1caexSZN8jo1ccd2tN0YFf2udtob6FXxDOKD408
Message-ID: <CANiq72me1J36RdY8_hYhOcMCF9qJH31HnE1Wwboqdz5UbNHN9g@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: rust: add tree field for RUST [ALLOC]
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 8, 2025 at 5:43=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wrot=
e:
>
> In the Rust subsystem we are starting to add new subentries which will
> have their own trees. Those trees will be part of linux-next and will
> be sent as PRs to be merged into rust-next.
>
> Thus do the same for the existing subentry we already have: RUST [ALLOC].
>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-next` -- thanks everyone!

Cheers,
Miguel

