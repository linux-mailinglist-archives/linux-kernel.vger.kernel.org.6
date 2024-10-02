Return-Path: <linux-kernel+bounces-347505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3AA98D398
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91A121C21F67
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D5B1D040B;
	Wed,  2 Oct 2024 12:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCTcO/+K"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33191D0171;
	Wed,  2 Oct 2024 12:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727873192; cv=none; b=DI7TRVXptlng147cSu8fz75Qr7PJkgJTGWs+8WDi6z+Uq5y4o1TJ30x66ZCUI4N+XwTBwpAqyRYU9fSkJlw/MLeCXLNWu8rObqjjSHvKLS1GiQ7B9G5TLX7cEkSuQJAsdMorddqtnScqExPZ5PuagFu6xgcFk6gyN7Mw5KGz0LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727873192; c=relaxed/simple;
	bh=Roy6r1isMRCWeTf9TfqHew2mdQkXytCpfcTylQk5YDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EEIAzI7cINS/e6hmg5g7uQ/xPCc5RwdVru2NZphmTdfY+M81iVhF9IOnMdWN+ZduWx79TuBPGqp71VD8aMoUXQmLtQQgMm5iWSjMS1HGHl5P+ygldCVAfy/5sGFKIy8k8ufdIXzN6xtVZvERx9wY/OrsSWehrCp5i/0s7/D/BY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCTcO/+K; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71790698b22so960318b3a.1;
        Wed, 02 Oct 2024 05:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727873190; x=1728477990; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Roy6r1isMRCWeTf9TfqHew2mdQkXytCpfcTylQk5YDU=;
        b=GCTcO/+KKlXZix4W9nolwJ61jgvk2Y4o/87/RXfpejr9twA3iiVCOVob5FINjdsLVB
         bysBlLUi0ulRH5vwIxlhVdDBlEXZh7YjQ2DOQd4I1KU7+nXBnxDeugznhm2e6+HLCmWj
         LffUbimn991Ki3SoZ9xpF530+86rRWVbLKTIeDGTq0iozgdqSA9gaUuR39AqSMmYlQOV
         1uHO7AT9jQPV7aodjfO4n+qw/aYfXXTsZWPRsxniB8Dd9ynoXPAk0CcowlaA56kF44KV
         di5eyz7c6D7Sx/R26mNfFbQFewhlnUcw7Wl/iDKStHg/4BCFrbeqvIJ4wJaLoDDWldiW
         3z/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727873190; x=1728477990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Roy6r1isMRCWeTf9TfqHew2mdQkXytCpfcTylQk5YDU=;
        b=ZQAzFuFouz23xqGibqkgObWQSRF2SUV1cB8x0CUFGRFARNLm/d/hiQNwUk1/qp7KkD
         Ltmrxhqgn9d3Km3F9FduYUBrwCBrpwm2xYhhQiQMfdt9eUAmnbzPapdIj67J4Jtn3rQ0
         TwSvXApeNHimUlhbOJfWyBIXn5ofb9t6ByMBrNBGGuDC1qEWEDpJWJ7okgqR9QnL74+s
         7CW/Jz3iXhZmr9d8CLlim674BQI1iP1tf/cnXz+sc0NmscerArN4tD5c8VKJa4Gd8sm5
         YsDbMF93k7zwO4IHauOscRSPPjgtcqykzvfkKnamlm8JS3YBz4PhGAgr+KZSuRyRdo6F
         mwVg==
X-Forwarded-Encrypted: i=1; AJvYcCUi2jl5vWY8YvbNhLUJUtTJzjrJn7yup3QuTC2PFBhYch1MJsKvDffvd/mReUxM1kgEnaAWgyOy31ue450=@vger.kernel.org, AJvYcCVxVaGnwpWpVwKmVFNrrKd0iwN0yf/W97qXHrlc0Tx5miE82VjQ6yKUqueMKj4cjursojM9U7SyrRY97iIB9y8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzctGERVpkUML9qLgS6Me2heMbI2S2IBoiubrGeuCDZ4Hg0lOai
	xP4hW8rcyl2a/i7C7DD/ynp+oxGIVjzSeLtEyqMOa0ZccZe6MgTlrFx0fYMsOQSOetfEhRFzD7t
	6VJ23VVfafIkGeRTmJ/vTsvRyJ8/Q76PcZxqvFQ==
X-Google-Smtp-Source: AGHT+IF412yqKrrJsB7hRebwJD4+/B2g7Bcjpj9kmv8dZwzZXfk8zuxkg/0i5jqUwd2dABdyU5x9tNQ6n4ZtFkRVjbI=
X-Received: by 2002:a05:6a00:23c9:b0:718:e49f:246e with SMTP id
 d2e1a72fcca58-71dc5d5cce5mr2071438b3a.6.1727873190039; Wed, 02 Oct 2024
 05:46:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002022749.390836-1-paddymills@proton.me> <20241002022749.390836-2-paddymills@proton.me>
 <CANiq72kEPEcqqJmLEtT7=Ku5mseHe6Js_jptVQHMzRwfUzFtMQ@mail.gmail.com> <53f86af2-45b3-4bb8-b5de-54e3c6c70750@gmail.com>
In-Reply-To: <53f86af2-45b3-4bb8-b5de-54e3c6c70750@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 2 Oct 2024 14:46:17 +0200
Message-ID: <CANiq72=R_otRFu1J5X9Pam7u7t_K3t9fWDjEp03H=mKKT62CcA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] checkpatch: warn on known non-plural rust doc
 headers and empty doc comments
To: Hridesh Mg <hridesh699@gmail.com>
Cc: Patrick Miller <paddymills@proton.me>, Andy Whitcroft <apw@canonical.com>, 
	Joe Perches <joe@perches.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 2:31=E2=80=AFPM Hridesh Mg <hridesh699@gmail.com> wr=
ote:
>
> In this case, I suppose it makes more sense to use the From: tag to signi=
fy ownership than Co-developed-by since the latter is used when multiple pe=
ople work on the same patch according to https://docs.kernel.org/process/su=
bmitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

Definitely, that is what I meant by the attribution part. If Patrick
carries your patch (applies it and sends it on your behalf), then Git
will add it automatically.

Cheers,
Miguel

