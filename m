Return-Path: <linux-kernel+bounces-276673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4269496CF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 033AC1F248AA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DFE74C1B;
	Tue,  6 Aug 2024 17:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNpUPjrG"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E706C5339D;
	Tue,  6 Aug 2024 17:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722965428; cv=none; b=WZD7WCxbCbyHcGdgOTnML+GuPwEzZbG2m0i8JnQurwkuH81dnhPq/W0eZPbotHUyGlCvW0zRu6bRQ/lxeKRkk1K0JmZhP4ajfMDbsX8RY+7bjDIse24Hbv/eJWztjWnzyzSay+R2+JLKLG8xui5ZOXr60yE5jpdyVp1pzpg5+is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722965428; c=relaxed/simple;
	bh=8uMPD3zyzXh627Xdxpdk+jJutWpw0ZxVSvB/RP6lvGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qalDJTZl3BWwghQrjDzTIDwKTIApt7Rtd9s4rwK1sBtdi81jzgtZEd500HCuuHYp/1cDmYAS8+pdcvUXqQCrYkM15HNeLnM2s/WNS0y1CoizsdTAl5Iauqyul/aC1nNH0VCQtbO+R0BJVou5n35svm2o3qUi/X3PNmXhcEaKlUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TNpUPjrG; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2cfec641429so757387a91.0;
        Tue, 06 Aug 2024 10:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722965426; x=1723570226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8uMPD3zyzXh627Xdxpdk+jJutWpw0ZxVSvB/RP6lvGI=;
        b=TNpUPjrG9O7YpLP1vzhgWxTygs352xnb4jJU43eN1PC1Go9dw1hY0c8xIsARK4lUVZ
         BsgOlzNPOd4lV+kCjyF0OFf9rbkawAWoG/yyHapUSDtHhy49D5FlUh8MOJKcJcbR5HJm
         nXSJQbXer+lwafc2S01NZzoThGDhdJMfoaGnWIusKylYc8/8YvlM85kORZjir4sMYjcy
         nktuwWUvEJUhGZ8I0NRAP2goDsvcAKh+QJhn5aGXMlalf8yQBk8mgZTskZtgoe2O7DN6
         Bz01IdtJzb4kVSLs88awo/MrSrulrneKb45QB2VrhhdjcKmhJ5uVsUnT4E+/UdFG7doL
         qTTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722965426; x=1723570226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8uMPD3zyzXh627Xdxpdk+jJutWpw0ZxVSvB/RP6lvGI=;
        b=c4B8/tozf/rgK5mYxeErvmH8Bc4UnMJhkoy6hfq9EIO3I/VfZ3kzjaAOxhwnd6TekO
         /jR82B40t2JxXbcUov2ZGcKXV4LULUf4LZv9hVN/uNKuISS7wyiz9j+pTnAmbNiC+SCk
         AY1PcgDU4QUjTX2Qr33eEgWrugfRzOrup68GlXf6ea8d5aKLO6qhG/USsDXXiDqEltli
         rG6JHD8voWOg+g6kxAnpNgsdzddu/UECZeJVXsEa/XVSgzHMoY3HX8SSdh3n4i8c4JOh
         bUJdPKgLnHZSE2ZjGmTN0NagWGffGtU04pcZFwWDqaKZbXJiAp51RAFRLyumCc9Po17P
         Cu+Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6y87StSXBDcS4ZuXSXKLZCJt0IALrmqaXIE+4xQcgYbNlldkiGK3wfGG5dV+6bMgA85ILyBG8Fzvz2cCV9qaL9VBYUd+v4ojyNI2TcV/deY9ahkWIpyvOzhh94FMISKxWZzbRd37wzc1CG0E=
X-Gm-Message-State: AOJu0YySw33wOUYYNdYyLyXSlF1Ah6j/m5YIYmyOCTjJdqnFdFW4sKgs
	Tgo+XS8f57lCdLLH6A/MIrv9R5HCrITT7vkPQwe8Fet+yulbV3yArIHfCnN9TRihX2u0NZvRjgB
	RHu/6qU0WkpUqrsTnTd91bY3stYI=
X-Google-Smtp-Source: AGHT+IHJzFMmWNei6mhNNEgab9Cqof5HphfyR3QdzgwsZesseYZbZxB75Yex+rd94LxIhiJQPDJRu6VSzz0hBq8kjHg=
X-Received: by 2002:a17:90a:fa11:b0:2c8:538d:95b7 with SMTP id
 98e67ed59e1d1-2cff9547cb3mr14293429a91.32.1722965426241; Tue, 06 Aug 2024
 10:30:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806150619.192882-1-ojeda@kernel.org> <ZrJc9UE3xAV1ezdG@boqun-archlinux>
In-Reply-To: <ZrJc9UE3xAV1ezdG@boqun-archlinux>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 6 Aug 2024 19:30:13 +0200
Message-ID: <CANiq72kMXFXYkUnxU7dK6jhyCc=JK22zgdY6nZTLFbFe8b+4+w@mail.gmail.com>
Subject: Re: [PATCH] rust: add intrinsics to fix `-Os` builds
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Nathan Chancellor <nathan@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 7:28=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> wr=
ote:
>
> Put this one into rust-dev and confirm this could fix the issue with
> Rust 1.80. I also add a test with CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy in my
> rust-dev script, so we can catch the similar issues earlier.

+1, same on my side.

Cheers,
Miguel

