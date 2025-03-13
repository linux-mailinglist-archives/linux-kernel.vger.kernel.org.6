Return-Path: <linux-kernel+bounces-559351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B5CA5F294
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A89313B66A1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C187266B59;
	Thu, 13 Mar 2025 11:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAkaSCZy"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C07B266B41;
	Thu, 13 Mar 2025 11:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741865974; cv=none; b=hDANvkID0nYLMMk0RSjB8xQHYZRL/J7TmXYVK6UIVhO7yq0EPoWFNb+VGANvpVmNJGrA3zpIi6IZDHocK8T34PFGU06aR58FvZuN661b35lHejFqF1Z1X12P5Wn23hgIVZQ0nsTKMq58XSxqeL1AIS7yRNJoXkk+oPS3VBxkJ6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741865974; c=relaxed/simple;
	bh=Yn2ckkVm50xRxmu1dR1GZBET8dIQWBbRVvoSCuI8INQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gkxSrp9BXCI/6jkQswwzCMh0px1tOGhqlpUYayhMzqkZKvCDJxVRSdHWADSUDiRzNDCveSfVpPcnbR1OiYRp40Py3r6oXEAt626RojMiOd9DnMxFFiSAAmuQNIQuGUeRkVnW1ArK1nTq8D2IonGwYWqF+2ijBlPyQATJgZTlVdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZAkaSCZy; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ff5544af03so201723a91.1;
        Thu, 13 Mar 2025 04:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741865973; x=1742470773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yn2ckkVm50xRxmu1dR1GZBET8dIQWBbRVvoSCuI8INQ=;
        b=ZAkaSCZyDcBcBi1M7RLIW1p2vq5X3/XTz+U6ose073MHn6fYFUWNEmVMGfjrWuY6b8
         29NcZteY6wdcaKjcMX11gu/jxzTN31pYW6INl1mYypPvn22bw/nOLF93Jhiv0exMunIi
         1IHzgtI58vkgTmibRkFwOtYyXWmg5cx4QPH5kkWddeDlhJz9xyrwgM3dbtQ8SsFs7zYJ
         ILvsR1sTtX5b1HmblME1jvyMg7DZQWntBhCK1fk0eg2g7pMPYdKMo+juYlPGazfz9R5K
         oUZDH5uLwlMNNmvnycVvdMsq+590tSQpccH/YZl5ezf0/M3Z2bQQMVkahjyfOgvXy1v/
         nH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741865973; x=1742470773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yn2ckkVm50xRxmu1dR1GZBET8dIQWBbRVvoSCuI8INQ=;
        b=LYJ8U/PwoT5TDXlVWoxCmqX4tfneJ0K5eJmBuELOO0ODkLoiTnYd0mY2zzu67HwePU
         MqRn68qPQwSUekZAgoJPS400CMKfP5aP3Bm9SBkTq+zlrO+WnIUx56UL0lNH8cOr0ix3
         bKdKxEu7xS8Tq53/9d5xBtwacjJpQAWntIc0kXDxMdohGMrJrWSh0wcG/jg1WyOxHwYJ
         h0Jfu+ZllNsZs+Jx3KeYP0yQdR2nQbFsnJTN8jpI0j5qhbQyScBmxe4EiKG9OAOL4eC4
         9B68vp1O0tWuCYjtRyHBwdv7aLZonkAqEZx1l0OQ3OsJNvwtgCbU6qKhfYISiVUkFkbk
         IPhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVC9IyRUSc6f0k0s7B2NjAGfeg4d1lSKZtyH9OGilZ0LB/x+8qfIMboyWV46f5XEqP+DMiFhkPdX0RVQIXdXuM=@vger.kernel.org, AJvYcCX5QY0R+q7ZXGWlsB5r0+SHOJJCNPtOXbrvrlYKwguRhvSXBiG9Ad3lyndsdVFSmxw/q6TaJ3j35dyNvDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YywqtwdibyMoQHS6W9Ybx2liNV9Gp1VyBlsphw8xRIBJgkMBL7y
	mnaIB0xa+qUPLF0HHVww4bFgYMsDIPihPc6ZiNge+o1KrMCprYP5U4A7Gaj/Fy1xdr6oMezBQ4o
	EdVG43vl0Q1DjE1AFFsIrFVj/+x8=
X-Gm-Gg: ASbGnctF3UnLw07dHrshE8pVYTJmRqydPwMMlrcphAWpwMHh3PTtZqigcTvq3vjDONx
	BQ+OWO1K+bmIHDjM0CwgoegFVrXvr+u9rFyjJzA2n95ku7LG/+2waMe9hCTX8xhe3xfXoBFAA/5
	54Yxu6dajOhX/D6yzGCrRTVlYPAA==
X-Google-Smtp-Source: AGHT+IFsR2Nij6e8kPPnSH8RQHdSiQ8RcPiqZ32miuTp7mUYAipDwiQT0Z1lKatt+3MB1hpaQWfvYt+7+cVbMOSOKUE=
X-Received: by 2002:a17:90b:4d0b:b0:2fe:8fa0:e7a1 with SMTP id
 98e67ed59e1d1-300ff720794mr5410145a91.2.1741865972735; Thu, 13 Mar 2025
 04:39:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313053340.405979-1-contact@antoniohickey.com> <010001958dfeacb5-9039aaab-6114-494a-9f1d-f13982091169-000000@email.amazonses.com>
In-Reply-To: <010001958dfeacb5-9039aaab-6114-494a-9f1d-f13982091169-000000@email.amazonses.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 13 Mar 2025 12:39:18 +0100
X-Gm-Features: AQ5f1JogBaAvr748z5WH6Hso8c-4Y42TamkgAro3OIuEfLMwlfB26HyeT8OkhYg
Message-ID: <CANiq72=z6Y27AaXE9__8qDaAiaBDtUeLNzvZ=9pNTEvoThTpUQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] rust: enable `raw_ref_op` feature
To: Antonio Hickey <contact@antoniohickey.com>, Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Benno Lossin <y86-dev@protonmai.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 6:33=E2=80=AFAM Antonio Hickey
<contact@antoniohickey.com> wrote:
>
> Suggested-by: Benno Lossin <y86-dev@protonmai.com>

Typo in email (and that email may not be the one Benno wants).

Cheers,
Miguel

