Return-Path: <linux-kernel+bounces-352058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9999999199F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 20:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2A461C21252
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 18:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A77D1607B4;
	Sat,  5 Oct 2024 18:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VgKg/YY7"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67CF15D5B8;
	Sat,  5 Oct 2024 18:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728153892; cv=none; b=d7j2zWWUwLy2lzT5SSYmbM3blkpBql6hRfmvEWG0f/L+WapglgWO0Yt1xw4k5E0mQE4bxzAK4k8D/luILvzJiFRfgbzH4HFrl9oVV5SI04uBP0WSNcgnXTSoE5iu5Mhz44vHDTZwyoerixAm/V+LpWWXnfgA/Cs7SAr/2qMsr78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728153892; c=relaxed/simple;
	bh=rdPlQypxkxEKRG7EfDX6tnyB9NxiXrqPpCXuiIeR2zQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y96HqPiOD3vhcpUSqgYVsl+qopOfvENB+LqVms+yd3FdPYOMG06KFwJpM6IEDrXjzgzrw4heo8L2Y0uTNrZbvFQACEamw2PN9pXUn6PqtgDV8i0pPFTqQ6i/TrT/D6YxweoCawT8tAmvW9I6szGoEl1Is464mUkwm0B87QCJLyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VgKg/YY7; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7db74e00741so197793a12.0;
        Sat, 05 Oct 2024 11:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728153890; x=1728758690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rdPlQypxkxEKRG7EfDX6tnyB9NxiXrqPpCXuiIeR2zQ=;
        b=VgKg/YY7M0dnmYdOYHy/tuLA6MYERyMtDPxIdNhWOnZdB0+UXlzZguvjC6gb9Ig/A0
         RxKpUrHkgJS4QLHkrazgamDx5Nd6xZwS2myiHWWXiGFDKuxQU/lU4OmaeHGzCRSWMS88
         svX3C8P5UZbqPzyKa2zYolqnAbm/QL0eqt2hYbxrBNyAL/yaMlbg7FXdXWAYbrllpjMC
         3jG3isDcIOccOsfe/Ik8KFtX3WWonMjeYIwahB8AlOM7TzSMhcKk6lNfbVILeh7wAr1s
         6C0p7t0u4qEHmzK6KfAczjTZ0FuPpY7yqivrbeLcZOVJIGCp56s2S0eCVDvn54LA4uuQ
         Vy1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728153890; x=1728758690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rdPlQypxkxEKRG7EfDX6tnyB9NxiXrqPpCXuiIeR2zQ=;
        b=D/A7bEZq32F0onmUP/MeentgfoRARM6Cf4AfoO1xACse+L5aCCsfC3mxST1DwYF+Bd
         g6WdvKywObjKRUTCGPfofxUHe5webL2Mw6C+jR9AwvUlsBhYuFfWToGWJWuBHxWrcbnl
         /Q3eSx8Tz02hC7n/UJ6mQKj5WoUKyPjhTRYqKOD2PxrZSkxBqV+HaOIA/Le/iy8UpVnL
         1lGVmz8Xj2pKkGszbKOP/rKzpCgrDItpIBZqnGf4GAFYGSIbWsn4sd++sAS25OHx4rxX
         KOoF0xihCAmaTODjsem1rNlw153ZFkFdtA9CqTzYcHQN4E/OWm9ct3WyFsxEOY+8ghpK
         ttgw==
X-Forwarded-Encrypted: i=1; AJvYcCUMLOD9OUhYIH1bjd1PjNgCT3hMbb9EnUNOvq//Mj1uC06p3RZo7qrp4d8jwhf6LIl7QySDf44LdHsboWc=@vger.kernel.org, AJvYcCVjkZeiRL24k7JsbckDRpngGz2a2lk/Gqs1dvlEmGe9VyH6LYy5pM5IlnDnEIEFCpBqNI91mQ6XkRT7ffpuuKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiRRs4/Wl1WkulLAuNEVZUFliHt8iS+6y/tsu9/OdJqKtvna7/
	O8OF1dcbN2TrpcAdXlQR5TDZQ0mipTfXR73HTyC4DJInw/+mveqJyhUoDNS0gvd7GhS4+1Iunf7
	HHcHiB9CWO7OiSGjcIBb1zXoauzA=
X-Google-Smtp-Source: AGHT+IEzI+sEoAWUBqm3TWFiSDoO0qM6iySl60VXPKvonQtG/7apRtGmfFvJcwPnNs4ZBHXaVHc++rqSjEWNqywvxFk=
X-Received: by 2002:a05:6a00:4fc8:b0:717:87c5:84b with SMTP id
 d2e1a72fcca58-71de239ed9fmr4430514b3a.1.1728153890019; Sat, 05 Oct 2024
 11:44:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003221536.34826-1-iapain@gmail.com> <CANiq72k0c+QxWkxfZ5f2VvzYmaX4z9hQoYvbPtKfF3pwLq-E8Q@mail.gmail.com>
 <CACD3TDPbBnZuvr0jJVtrgs_4AXXk1+HGZEH_uPp2iQVf+4Ff6A@mail.gmail.com>
In-Reply-To: <CACD3TDPbBnZuvr0jJVtrgs_4AXXk1+HGZEH_uPp2iQVf+4Ff6A@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 5 Oct 2024 20:44:38 +0200
Message-ID: <CANiq72m-0or7w5Qdw5Ek9vf-w_ng5QOmeSW4u9HSMqj1iei-CA@mail.gmail.com>
Subject: Re: [PATCH] rust: update dbg macro outputs in docs
To: Deepak <iapain@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Nell Shamrell-Harrington <nells@linux.microsoft.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 11:00=E2=80=AFAM Deepak <iapain@gmail.com> wrote:
>
> Sorry for not being outward with my commit message and thanks for
> mentioning this. I will rework on that.

No need to apologize -- it is all good. v2 looks fine :)

Cheers,
Miguel

