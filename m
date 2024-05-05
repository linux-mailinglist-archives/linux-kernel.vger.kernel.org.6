Return-Path: <linux-kernel+bounces-169180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DB78BC485
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 00:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DF41281632
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 22:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128BF137741;
	Sun,  5 May 2024 22:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BoMyT1Q/"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3241F7EF0F;
	Sun,  5 May 2024 22:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714948170; cv=none; b=rYdTh+VlM+BKCMxI4DLioy90ZtYED0zjIOlX+9sf+CrRG+NiHAJGnsXgMqR4HEmZfq/hxi6nSlBoS6GY82TXOnDjFiglqJn8wwVvkxVjz67PoKaiGJNBCSkM2jjoOHH/MOKEpE6fLcImBDshEcQFXdVeImOpZaE18kJ2BQy36oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714948170; c=relaxed/simple;
	bh=1X/GMcqTC6Fg01Iw1hhvaA2syJt0U8epBn1VmgI+33w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oclp4osZxiQh69fIuyC2EYkUD4DAfQNPznbmc1c5DWi/bWIYSVeY1rITrg/EeQScEgOzqoTu1tI/CB7n+2h4z5+Ay4aoIK6A1LQNEwpENwGZ9xFzCBrg03M6pkxjXhASmWGMQT8Tpe6JNBGJjsJbYk1i9oUPNcs3yfRneRmkUE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BoMyT1Q/; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6f44d2b3130so1132132b3a.2;
        Sun, 05 May 2024 15:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714948168; x=1715552968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1X/GMcqTC6Fg01Iw1hhvaA2syJt0U8epBn1VmgI+33w=;
        b=BoMyT1Q/RODFsj9AyeKemCFWHKIkozFdzO0/aXKl4UFcsJ4nFG0KrnA3bwk/WRDPgn
         pF0Vo9+HyTBu41FbksXLExveYH7JMUo5c6MXfb4VtgCaToG20M4pnEcXVA1Yz1ca+PsY
         5OVQA5CkA2xOtGfAZKY7UPYc16eLzJAjrw2zNGloq9EXC6F3C8dBNiJJCxoWmfB8JlDE
         X7ETg3VUBKC3/Ny2KIKmjsNBKHBYXjdRAVdHQ+80oUTiy2k2TjfwkXyHHcPB4pnTdSMV
         Jf8OZX5s+mtyXe4k7xTYfKrEjJoHgTXsi7d4Dpr8rCiOl1cDlBljvnrjcR77b8n4ZqFC
         FCUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714948168; x=1715552968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1X/GMcqTC6Fg01Iw1hhvaA2syJt0U8epBn1VmgI+33w=;
        b=Uzd5C8ysP8QnPPdcvW60VwxISrYo8VnxynMZjxzv98LB7A+h9I9mJuODaGGSxlTMyJ
         OXmCFE4pMMgYXp5LAKuehIJqa6r01s7KyRyxZeLdGKt8acs1NLEBF1DhhAxSKaoah5WF
         6SUhlh1tFbLH61eQZUwZOhg5+taRL8HcoPpOgliyPBJ4aUSzfVrUX8qyk6PWb8eybkWL
         8ns57l9cm+Zg7g2Qh0c4sgmBhVo/hGjJqThiVbG15PIio0kCAy0qiTeCze5QNq/iKJLx
         pJvKpJrtuYRcrdCb2+V7O43tEhdKd+f4vx7a9Wo5uUPxft8NLeK0drOb6igigADCcX+y
         dqew==
X-Forwarded-Encrypted: i=1; AJvYcCVMuYcPhOnifQvgkgJ7bMVrWB/IybrfwPZ9SzprwDR0Gq4rYLlUrQIrCBbXrIY4RFFg69mNIeFeEUjfySN5ZbuYPKn+cdFRs3NVuS3uBQQW3+HB6NHksXJlPP0LkO0NSnEDMfvNg5UMFf3nDqQ=
X-Gm-Message-State: AOJu0Yx2Fou8T0TjzyW/dJYEcKpdy4V5yP2kGtsx/J0Wh6EUWF6wOpRy
	GoX5kTRdv0KmTErMjj4soN7Q8K8JXZDzzVpn2MIbAvIGsW+tro5v4EhM3rcqSAYNLwuC8qmOBH5
	jgpoRReEZaKBWOPn39VVflwTnIxc=
X-Google-Smtp-Source: AGHT+IEAd+ygeHaOYLxfv3yWReoTtfiFIDKC/TVtHPQcOSIR7O1iirvaz7Y8pPvd9gd2lzKew9USEXuyPIBSc3U2Kes=
X-Received: by 2002:a05:6a00:4f83:b0:6ee:1c9d:b471 with SMTP id
 ld3-20020a056a004f8300b006ee1c9db471mr9881294pfb.25.1714948168379; Sun, 05
 May 2024 15:29:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411205428.537700-1-thorsten.blum@toblux.com>
In-Reply-To: <20240411205428.537700-1-thorsten.blum@toblux.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 6 May 2024 00:28:03 +0200
Message-ID: <CANiq72mEU2RJ2HE2aXkStCd3UsT999pFyT87k91fXFZYDooZiQ@mail.gmail.com>
Subject: Re: [PATCH] rust: helpers: Fix grammar in comment
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 10:55=E2=80=AFPM Thorsten Blum <thorsten.blum@toblu=
x.com> wrote:
>
> s/directly the bindings/the bindings directly/
>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Applied to `rust-next` -- thanks everyone!

Cheers,
Miguel

