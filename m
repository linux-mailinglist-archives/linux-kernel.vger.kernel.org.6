Return-Path: <linux-kernel+bounces-295360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D046C959A12
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F0A01C21E3A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34631AF4CF;
	Wed, 21 Aug 2024 10:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkuoNDjX"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AC31A7ACE;
	Wed, 21 Aug 2024 10:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724237578; cv=none; b=YsSDUqt1nHMl3PQNcWoOUsWQl9eK9fisBNrlrGPqVaa4qiDCB8gOFprN5b1UwOI9Y4ZMzSa7CMF5S0ISJI3sY1pse+COxVxUhjmIBczb+HUdGya+vXTW46SKbe8czD8tmoX4H8teH0miAQCeFfmytk6c+Br9OJb0Yz+2W4WsDvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724237578; c=relaxed/simple;
	bh=cWo+had6U4TTZ/AMZ/4Dea/i+TbACyjARzDSe/o3lsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ixeCeFPrWIvhRO6I6S3kRk+ZakV27NM5N4wNyzy+SXHCc9Ms5t0B7pKnfqK0xjNYaFWWREgiRxUhwTQO56KJbj9E8Se/D/r5hvM2mR52CyCuE3DYYpbd96iH/7YbV9rVjWbjxLIQYtYJ2CZ3p+W8jYlk4xcFDa0VCOdazpWLl+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EkuoNDjX; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d3c4d47c65so79132a91.3;
        Wed, 21 Aug 2024 03:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724237576; x=1724842376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMSPdG7KQxNI6Tub4YCHXu5EFWuA68mvqjrG9XCAkDM=;
        b=EkuoNDjXvonMQGxbxagcMxRpbWFAmKHXUPgUZ7DiJW5wu1IuBsTnlzVLZCOZOYAO1N
         BO/3hzZMqqcdkf3ix3htGgyJU8pQaZA8EYl0m6H/yGw2FVebw5s7r73ABD9XSbMR/tL3
         +bIbueHM+ihEB3rtaSN0QZLyhmuDY2Jpf4jIcDXUZvFHt8XLUUiCnprOeumJRkGGNzul
         aQqN9l76gnZHhoxaXed4PIGAgUAsTq466SI3tvcGS7mZ0f5CDuTnt3O/fxL+6q41A5pA
         3y5psOFRPYVVaOWxy517P2lunPc8CHsn2u2Nc3MXJbtmkWNRLR3LIQSJORnv9CjfFGL3
         RE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724237576; x=1724842376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vMSPdG7KQxNI6Tub4YCHXu5EFWuA68mvqjrG9XCAkDM=;
        b=Ae0AfmczpIzjv0QueBGdWrGj1cN8DdjzomF793XOgYsf2zvu/u8sy/YJSNg+/+IB3s
         ioKNKyOF/vzKYfCUMWUmMpeP38YyUBKOrsbGXTFBIc7Fp4bRZBGp9JcdxyblL+Mtg/8D
         R6yXFkgh5PLDMRBuIOU1gKlzVcmk6uFuOsD2/ZH1cbPzUQR6VhYHrkLeL6GNfOdykW/7
         yRctlNKdKLiiem3g6rWn33FjGYEW4z5Qp/bz7JL/jTOuB6fS/oTLI3+pxA/Eg7vDv3ls
         kuP9Nl/tGlXgfPbahWSpAiILAHaceaRthR8uodbVRePbmm3+2Oel+dsoBhBBRSCsZpKi
         77oQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTiV6pooPAj551M0AN4fIFjk+M0xcq8f8+akBqtBIxD3ju/RhAK0GHt/L0zzYQ13Id6PYVYIpnY23V4VZ7@vger.kernel.org, AJvYcCXRY9mriO1nCwQHWztQZi8QwLDSnI2F/1skveS2NH/jDTZFkGTTdfsBl2qugRHqND9ujzpLEJlIc8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXL2ormAjdGuaEEqUnHHScNhrFL6bdCb2RBM193pvxkHo7WA7c
	sTxivDFqnjWW8eTwrrzrRTdphEvbNOAukxeA/goHjE7EJhFvPvfQx805zZla9JDr2Ppd+9K6O3i
	o/wNtyl5BZo0WMKxuHdOYdR1UPU0=
X-Google-Smtp-Source: AGHT+IEM50af18jvodT26Md3wOz97ZtT9CJBlxg+Xx6A1jFeZU38tmY3hI/5RyIzTN7uI12qNNlI25a70Thlm1tYbc4=
X-Received: by 2002:a17:90a:6888:b0:2c8:e8ed:8a33 with SMTP id
 98e67ed59e1d1-2d5eaaa746cmr1138454a91.4.1724237576095; Wed, 21 Aug 2024
 03:52:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816200339.2495875-1-vincent@woltmann.art>
In-Reply-To: <20240816200339.2495875-1-vincent@woltmann.art>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 21 Aug 2024 12:52:43 +0200
Message-ID: <CANiq72=kdZW5KYUVedJ=5LoxnU1s9UFog_vUS39cT=DLaQY00g@mail.gmail.com>
Subject: Re: [PATCH v2] rust: Remove erronous blockquote in coding guidelines
To: Vincent Woltmann <vincent@woltmann.art>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Jonathan Corbet <corbet@lwn.net>, Wei Liu <wei.liu@kernel.org>, 
	Yuki Okushi <jtitor@2k36.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 10:04=E2=80=AFPM Vincent Woltmann <vincent@woltmann=
.art> wrote:
>
> An unordered list in coding-guidelines.rst was indented, producing
> a blockquote around it and making it look more indented than expected.
> Remove the indentation to only output an unordered list.
>
> Reported-by: Miguel Ojeda <ojeda@kernel.org>
> Closes: https://github.com/Rust-for-Linux/linux/issues/1063
> Fixes: d07479b211b7 ("docs: add Rust documentation")
> Signed-off-by: Vincent Woltmann <vincent@woltmann.art>

Applied to `rust-fixes` -- thanks!

    [ Reworded title. - Miguel ]

Cheers,
Miguel

