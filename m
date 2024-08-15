Return-Path: <linux-kernel+bounces-287644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2ABA952AAE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B279B283616
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 08:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573721A2C11;
	Thu, 15 Aug 2024 08:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iyiBunrt"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0594F1A08C6
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 08:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723708986; cv=none; b=AO1ohxoR5oEv2H2ueApW5rv18xVOVHr/Db2YQUAxAsIUHgbY1YhK7ilJo8FoXRCWZ1/RSZjMo6IKhzLmf1mLVAxzdVrL4OoWUM8j2LxvsAHMr/qLceXwGWTsQqXagceQP2ZXp/tbXgXysBITZGjfB0sX5QzTeEL1yxZuHX6GQ+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723708986; c=relaxed/simple;
	bh=cw4HOzF9efUrQHUoHgeWaw9GKc7xDSDNuyZWlW0WFOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GmHXqttR31guzb+MCGWOD+jqICfkybm5uR8MWNjo/tbV7etJhmYGhmri4VCIgVDBDmfO2CYVLc48677gxvPQuH0RX2uvLRUkf/ZU/wE/v2P5gGuRsO2tCPoOLi8j11oqi7xR7Wx4DsKsmZ61NZH8rWq8+PQ7isU2c4M1PcllV6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iyiBunrt; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2eeb1ba0481so9127831fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 01:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723708983; x=1724313783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cw4HOzF9efUrQHUoHgeWaw9GKc7xDSDNuyZWlW0WFOo=;
        b=iyiBunrtdyRuXIyKPp9Pphr9t0fBQWgg3w9IDz5Q3C7HJMtvUYMru/udVzxV0ad1+6
         Ymd1KpO7346en3v9nr5QBBMiVGCflMJmBj/tSdD7AznPEFFtq2UH99D9u7MYe3pWvxwf
         iX+sWGbSFPYwsJuAyaKeYK3Pa0FdnevJydicpBRfjM683sVrmlnxvPFzhTnEH3t0WDno
         0NWjCuOYT859tfH4Ib44LpUAh0dsFK4b0NlY4bJlBmodwWsDsyTxHqCqLH7cY9Ozse6t
         F+UnZE8bYoKVpKgz9X1SL0zrOs8Iy+At7f4oh2XeyZ4TQu/zuIk8J2NaHb0fOl5k4Ax2
         Pz1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723708983; x=1724313783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cw4HOzF9efUrQHUoHgeWaw9GKc7xDSDNuyZWlW0WFOo=;
        b=i8ZQegK1Solx23ETxdIFULPJWdCKOWjLrrOatZOA83TPqEwKmoT8kj0uBTKMVjDSrV
         B/rqZriR3/zFiiiJmS//c/YEia5g93wxq0fZtnm4SFcrQZ33xtbTlFY8Exo1oMLPIP0c
         N1se46M2jakeRXVeFMzoQKk9aQPCT9o6VozHZV8ENOd9Gpwu+prYLzC6GgUDFrRhx6y/
         96YadgKs9OmUUwk29BdJYLcznn7CDqmJqOwEL13Kge1DEG9f4ltCUNicjJ8JUXptgyEa
         QCUpo2YEPxUBBSUFfsWWKzleDMZzSYCt8+xyW809v6KsHn0odGQAiI2n4hriz2z7buWd
         ZMpA==
X-Forwarded-Encrypted: i=1; AJvYcCUGGWvTCGkBPeTXtI7Y9K1xAFrwXhat76LCASneZ/Yfy98ao+d7xFRIKFkhG+nBGtJWFm6U57FwwKHVfPOGEk2iALgYIc/JAbcXNZmG
X-Gm-Message-State: AOJu0YwaklccDm+dEJ2BtKr4jjF2WDYIuh8ZPRKwJsFw4NleNBLeHEAa
	hdhU5bcO0rIueLSKh3CSmBlGO3P+RySM6YSnXr6pUw9hulIQ38q8g3WUQfqkuQ+jnfMOnrLUU+h
	QDP9rIUFuE5iY8onxd0mp3nFL9rFb/8L44FCB
X-Google-Smtp-Source: AGHT+IFsQKTSHXbcYSYVRfO6L0p/unFzrhWsL62YkDkRkGxv+SKfw1LPGgC/R+8Wi49EsiT5RHmeVtUn2IL0tXEmOvk=
X-Received: by 2002:a05:6512:39cb:b0:530:e228:77ae with SMTP id
 2adb3069b0e04-532edbad7a7mr3564938e87.40.1723708982792; Thu, 15 Aug 2024
 01:03:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815074519.2684107-2-nmi@metaspace.dk>
In-Reply-To: <20240815074519.2684107-2-nmi@metaspace.dk>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 15 Aug 2024 10:02:51 +0200
Message-ID: <CAH5fLgiEcyGqV4USTvMGhaMBFrwY5winmGC7ymYT2Qr7R=OBug@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: fix export of bss symbols
To: Andreas Hindborg <nmi@metaspace.dk>
Cc: Jens Axboe <axboe@kernel.dk>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, 
	"Behme Dirk (XC-CP/ESB5)" <Dirk.Behme@de.bosch.com>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 9:49=E2=80=AFAM Andreas Hindborg <nmi@metaspace.dk>=
 wrote:
>
> From: Andreas Hindborg <a.hindborg@samsung.com>
>
> Symbols in the bss segment are not currently exported. This is a problem
> for rust modules that link against statics, that are resident in the kern=
el
> image. This patch enables export of symbols in the bss segment.
>
> Fixes: 2f7ab1267dc9 ("Kbuild: add Rust support")
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>

Looks good to me. I was using this change myself for some period of
time when looking into loading Rust Binder as a module, so I've
verified that the change works as intended in that context. I also
tried it again just now. Thanks for sending this upstream.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Tested-by: Alice Ryhl <aliceryhl@google.com>

