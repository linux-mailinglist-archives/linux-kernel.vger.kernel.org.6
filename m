Return-Path: <linux-kernel+bounces-357438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8717997135
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9A901C2152E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D64A1F12F0;
	Wed,  9 Oct 2024 16:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVL2fI2g"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DE31E3DF0;
	Wed,  9 Oct 2024 16:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728490365; cv=none; b=Z4U1UmwQ181SVHhfZ/GeGa7TxqgpfV0QskzIBYo8Ln0+4K12VcOyS5nbnQPznLcOSJw640ZgR4NvPVU7KzH441cmlp3wqJrI5OPYsB8DhECG5zcaZZfLHHLltQWEsdZ91bZEpqeqB8iWAKUe3WzZC4isMvVGXIlB0mL/Opp3lvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728490365; c=relaxed/simple;
	bh=69tuDMbP1YGPAufhXNuaE7Ux/IU+jY5G7QxUuCyhzps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GyBfXcpsdLwVqCHhgyFcUcpBegKT5f83ry4nCB90Dc7dTckbluPhYbrVN8eFTdVRQc3vUt4+SzQKaMCEe444zchN9UtdYtnm+lmKT+0uKgL0HRkrEn912ivubMOlEAnRCkZ1zr9FZMU2xRdyxLE7JGKGhpz1RN0Xcy+Q02jfdCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVL2fI2g; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fabfc06de3so78339081fa.1;
        Wed, 09 Oct 2024 09:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728490362; x=1729095162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=69tuDMbP1YGPAufhXNuaE7Ux/IU+jY5G7QxUuCyhzps=;
        b=BVL2fI2gUlUw13BUByBMrRtBIOZ8NkYx7bCqFZpaFBp6T31s/99rxy9ROGnWt17dGO
         KCZ2EbgpixBNpIXVhW9GR1GAAgpqC+a1mXLwXrriOl1KEI2fz3Q5y3V2Z9x4RtKOgUfe
         UC/sE5KDUXlfRUUrWExTdnekd7IjOfgCMBuiCCVOdMlCorbpVgMds8RIEHZiuPd9z5Q0
         RzVFwDo9axYtczJQ6FlKsLP6t1+HqdVdL+GdikErOLfKbhnkH6yHmkPPnnMZVXDgWYcO
         cZrqRLgBUWjStILI2j/TyRsobq08t2ab8OtAeY3pmQdCNf5fqtDqLTE2PugQBdwbjgqy
         +Fww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728490362; x=1729095162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=69tuDMbP1YGPAufhXNuaE7Ux/IU+jY5G7QxUuCyhzps=;
        b=k/IZF64FFWW97KoMLqldwbKBgYquWmJjfQu/U2KcZgCLCzcn0nikgYiYRD2b1ywlXa
         75lNi2P6jmcDHvnH0n7QyHazQFV4Vdhs9z+Zr+PPhrpS6S6J4R68eiCRXXNOqi3KFiqY
         529U2jtPCnIGLw/72wQXO1tLrXxzOL7rtP0S3P1D+kTJji4uDyzXtDRgJyQrThj9GhXF
         ZAk5x8fGtY1uXv6WAP6l5U0cFmKlHKuiodNxgoCO3m+pvpiTJjByHi+1UxOQUE94uv2R
         I7M4cs+4qll5jdGDYR5QTUk2lvHD2sIZvZmw1HeaA7kuG2+Es3/jY2kIvItCNWYaXDNd
         U39Q==
X-Forwarded-Encrypted: i=1; AJvYcCVgtSgXl0zNVnEMfjcE903B0qgu5Lw3uWeU2THlgkn9TRIyJo6sojJ3kWkwpcli23sAq8wJR8gNS/3fulI=@vger.kernel.org, AJvYcCWmfbcjYEht+FkqHt1t1bN2y1B0p+s+lVDRL647tK6c4SbD899IihJ3ktmVoD8olttbrt3TnlfTtI9GpwbnadI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhvtTTiGNILSCnRVOjrYAcU9cJcBIuBZZ77xpp+IXpz6VkFvnr
	PiKOCqiWRde1i3XITpphiZjrdmjAVitz8x+2Bgx4xjjxbF3FELChSPFrAwlUlfluYasGOg1nniD
	ZODH+A0IeiIedzlXo08AqoXeUkrE=
X-Google-Smtp-Source: AGHT+IGypjyCLbkV7PrttejawXPCcXu3I+JPDZwft4+6+pBVti85EQEi8U9XMPZOMvFJF0KxXJyxu9lgXQG4+a8XpFk=
X-Received: by 2002:a05:651c:211f:b0:2f3:f168:f91 with SMTP id
 38308e7fff4ca-2fb1872fb01mr23188151fa.11.1728490361887; Wed, 09 Oct 2024
 09:12:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009151017.26685-1-tamird@gmail.com> <813594ff-b167-4ae2-8105-e2f958ec2cc7@gmail.com>
 <CANiq72nUT6cFXCGg4jfN07W7UE-8vma=o9a5DQjsRwtNsKUGbQ@mail.gmail.com>
In-Reply-To: <CANiq72nUT6cFXCGg4jfN07W7UE-8vma=o9a5DQjsRwtNsKUGbQ@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 9 Oct 2024 12:12:05 -0400
Message-ID: <CAJ-ks9=ejys3cQsKRkHkZGLFJ_Po9B4yeWKAuSHyQ3vBRDJXwg@mail.gmail.com>
Subject: Re: [PATCH] rust: remove unnecessary #includes
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Dirk Behme <dirk.behme@gmail.com>, rust-for-linux@vger.kernel.org, 
	Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Dirk Behme <dirk.behme@de.bosch.com>, Filipe Xavier <felipe_life@live.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 11:58=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Andreas: was there a reason to keep those `#include`s, just in case?

FWIW already not all files in rust/helpers/ had these `#include`s,
e.g. `uaccess.c`.

Thanks for calling out the grammar fix, I'll state that in v2. Should I spl=
it it
into a separate patch?

