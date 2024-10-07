Return-Path: <linux-kernel+bounces-353927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB40999348E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 19:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD4E3283C27
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C02C1DD53D;
	Mon,  7 Oct 2024 17:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5phIiAb"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46AA1DD52F;
	Mon,  7 Oct 2024 17:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728321292; cv=none; b=dOs2kPD2vhWe4823+jWoUQvkgvKI8wCMW0fF+4PN1dQ/LBSdPmLfKopfartzs/UyQT1mboiEpMMqi2dNvy8rlS+0aGKJoJnIIcl6mMlsacrtE9gsUIAhn7owiOsY5URwjgNyLF1DGwCbe3brwCQn5gG0v5AxxbSKALEprnxTwNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728321292; c=relaxed/simple;
	bh=BpYXhQah0fJT3SbEgLlFhwNGnaSQXJFg6G1TaS+EDOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pps9OQ8o60Akm2SzdfXqHLhcfP84kRLl7SVvEyhiP21BN0OobhQAjW543I+Y6vekVDHgqm3zLAsxDJsx8MlPVbAFaC/xcUavkVsIlWvxlzToJiOvf5hS69SSa0RlsiuYpKawCKTcM++6eaOlKCXftnZYzhLKUFBLs/Cd3TIn82k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5phIiAb; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7db3e962c2aso484296a12.0;
        Mon, 07 Oct 2024 10:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728321291; x=1728926091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BpYXhQah0fJT3SbEgLlFhwNGnaSQXJFg6G1TaS+EDOM=;
        b=h5phIiAbTymOpvlyBs+nSpvrdEH8HzPTOJm1O2/ZkW1jQVIUDDgYWaW1sJbBofdsWt
         OIz/PZ/c1ZkXhmCWsgZV77jlEL7PRJtapJ7+W9LHHU+ddATAH/HFPBvuwUmKj1sOkika
         HMAHB+DMicJ7z7PQ1b1LnFGqhiiFj4puh0d/zw72+RGNRBFv0DO5L7vaWePmfc2nPRlX
         7apxfQd3XA2BFMcaxD8BWVlRThLJ+W5YwRcjN0UxJpb0+1LZF3glaXQ0Mtlz3epN8lDd
         5A/07CjTkDL/TO+5TLamFUTMrB+pkZeu8vizS1rgcTkb3Vq+AEA+Y1LvT2r4v8IV4hdg
         FJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728321291; x=1728926091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BpYXhQah0fJT3SbEgLlFhwNGnaSQXJFg6G1TaS+EDOM=;
        b=QSHBVf34ToKFIO85mxMu4LE76oxue0en0v/ERT7/T3ieM0kbblF3MP435cKuCQOa5W
         jJNz0CktLQaLhOMGeqrj6uXOW2wYt1ny0hBo5rsYLpbsxQjQOC/TcNoMQz3de6DhtTrC
         itzynAPmzsg5uUjjdgDQzxEL0XrR9SFMRQwdrxUD0o6+1yfdBVZ5wmpp924ejdKcwqKO
         Fi4NTjHk0uUPqkiUWzYH218asGqS6YVFrPk0EwjECEwpy8Ifci2x6iky8bJKrVqlU6Pw
         NxiZs1s4zI0sRL1VylnUfaEtEflWz69Twk7sdLQAJv3S1TRlwFrv9k2Kix2dkrS6Wxi9
         7EdA==
X-Forwarded-Encrypted: i=1; AJvYcCVnFhQfpbATaB2L6h5kREbBg0218Zjr14elq+iLH5lH+Xy2piFuiEPQ+tQav4EoqnVn26o62Rfh2P+AA6M4Lg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyfvjUqVgQ3eV3LRJRgMPWqub/S7HhPo1zLl6zQkj+R7USrsrRl
	4v98KOHNNDfnp/jkokYn9pw/hE2otyIGnlBGgKCqmjKSe7P+0ARf6VspPITXmOL2IGtQ1XOIi3I
	pDmpKMX7mP4kiFGwEUAOfTYeYCWs=
X-Google-Smtp-Source: AGHT+IG+NPeTglkgCJ+Y1+VY72mMJP/S062G1APqaSWaI8AMKqTGElp9uGT8qmU1d8BdvMQfwASc3Bly/y/6mlnZtfg=
X-Received: by 2002:a05:6a21:6da4:b0:1cf:4bd8:3a02 with SMTP id
 adf61e73a8af0-1d6dfa1e607mr8475036637.3.1728321290777; Mon, 07 Oct 2024
 10:14:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72na=RqV=vhKZr8iZMdvKZXxqX5r7bDgo84KnPWddc4Z1w@mail.gmail.com>
 <20241006140244.5509-1-timo.grautstueck@web.de>
In-Reply-To: <20241006140244.5509-1-timo.grautstueck@web.de>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 7 Oct 2024 19:14:38 +0200
Message-ID: <CANiq72knW1J3=gRpEpo5TQSE=oKygObCSKkigFdVDS3315PUww@mail.gmail.com>
Subject: Re: [PATCH v3] lib/Kconfig.debug: fix grammar in RUST_BUILD_ASSERT_ALLOW
To: =?UTF-8?Q?Timo_Grautst=C3=BCck?= <timo.grautstueck@web.de>
Cc: linux-kernel@vger.kernel.org, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 6, 2024 at 4:03=E2=80=AFPM Timo Grautst=C3=BCck <timo.grautstue=
ck@web.de> wrote:
>
> From: Timo Grautstueck <timo.grautstueck@web.de>
>
> Just a grammar fix in lib/Kconfig.debug, under the config option
> RUST_BUILD_ASSERT_ALLOW.
>
> Reported-by: Miguel Ojeda <ojeda@kernel.org>
> Closes: https://github.com/Rust-for-Linux/linux/issues/1006
> Fixes: ecaa6ddff2fd ("rust: add `build_error` crate")
> Signed-off-by: Timo Grautstueck <timo.grautstueck@web.de>

Applied to `rust-fixes` -- thanks!

(If we don't get any other fixes, I may end up applying this to
`rust-next`, since it is trivial)

Cheers,
Miguel

