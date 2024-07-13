Return-Path: <linux-kernel+bounces-251402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B73F930483
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 10:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C2E31C22D0A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 08:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAB24595B;
	Sat, 13 Jul 2024 08:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Osjjk4yj"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288141EA85;
	Sat, 13 Jul 2024 08:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720858638; cv=none; b=AVGzHF2llGlV639yYBje0pR51EJxN3XYqmgXYUW55thTyXj4j0BZUv5JeUpOfvKmuSUwyyfT8BJZkT2ZojA4OPVDW0SzcExDlOarpfeDlP74M+jz1CYe1wXqOByeM6Cb8XdZ30yUIIfB2spQyNLI/gSZKysNZK39yAKPCqNIagw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720858638; c=relaxed/simple;
	bh=vuTDpjOknZIP3OPJBIYnYVOkq2l4rHcKJCw+bFO9yU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E7f3ypFsOQiO4PcG9d2olaglv0V2ARzCaDfr1h122P8pcAJdyBODOKqDXSeqx2OEPnejbfk1mkGP597pV6pHGKSJ3Nu6ITEIc6mTihx2DptnPEd8K/K6QWn4spLK6naJxN+6VE201Y04h7tOHKkx7R1PQptXDY/8rpZ5pRkcSjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Osjjk4yj; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2c964f5a037so2043551a91.0;
        Sat, 13 Jul 2024 01:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720858636; x=1721463436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vuTDpjOknZIP3OPJBIYnYVOkq2l4rHcKJCw+bFO9yU8=;
        b=Osjjk4yjBqt9do5FgRuJ0ktxPUHrHjUW/aKjQO7X8cvAESTlKu3+LxFScfU/RtZS+h
         c1QkV3LQNVBxnSQDxeaaqSiZUm1bmeF5zpxIKw9ez2HtkA8v9RTepRgtg3pxKtiauevG
         w5Kb7qNybPC3F7oArlu1mdXM8GV5x87W/xijA6YvQkbDGXiXbVLS5T03GcAMvr1+YyyM
         PW7vdsPJrQvUO3cpNDhTGgf62G2CzwWPmXF8e0SMZrgRqfwunD1xdBrguxuZOcPwPKyY
         675fLhRjqiDHKI5qMsVhUXXOEjy6eoPO8nnSIWYcsf17GS5PEqu0X0pJHVkFnfu/+VkS
         n1Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720858636; x=1721463436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vuTDpjOknZIP3OPJBIYnYVOkq2l4rHcKJCw+bFO9yU8=;
        b=svK0MoM5vXwdcCOZKuuNOli4H3u/owdMHa9OTw+iiNWWSZyNde31Re5hAOn38xp1tZ
         gFEKxczRy4IaUBYwEfC+ktz1JvyRSDDlB4lJrALjZLkKyF6yukcCpkE8sckTBIpmtR03
         UZcChWau5OvFaURqrLCvjuiYb6aMQeutacM7DH1uY4gJrOC24M6DMC47YAdWwACRrxZg
         8KV5Yts8LvmO7SCQPOBOxI0zavu+hTvk9sv81UdByVDHq4z6B0t57ZDuh84gofVO9Yxo
         rDXajO/FZtCmU0tkDnQSh2y+tvDbTMplSyegBmOOcVuaM+ahREQO9RJk7F4XWZTMVYpb
         O0ZA==
X-Forwarded-Encrypted: i=1; AJvYcCXQpqg42cndKDukq61uHliHQaPSmEDpxM4QwBLK3LpPK35eJKEjxgU29Ker2n7h+b2AVCT9Ki1MWuZKe0pMipQWNxSxuSnPrarmOqTd+H4zKXML9+7qJmW1sMhbfMrQ47QxvSfCpys9l/9qyy0=
X-Gm-Message-State: AOJu0Yzl54/MzSrRKGzY7a5OzQ8VAEkOlBW8A8k7dJas8PUKx56GRKsY
	iqmWhhpkFm8dDmQdb0z4O6/tdGuxnW3N4J4a95z1ObmT7dIOS2FQTsoJIzcu4hvu1E2d0uzKh2U
	q7+xtff6Ykh3/jwin935OxJLnFl8=
X-Google-Smtp-Source: AGHT+IG2cm8kzFCASH5FbYxr2z1a1YaZfkV2ynwONRqoxeKn7KGsSrpsEXY6g7FXnyh4IWb1I3jo/N2wLeVEGq+V/uU=
X-Received: by 2002:a17:90b:1c10:b0:2c7:b11b:e327 with SMTP id
 98e67ed59e1d1-2ca35d8606dmr10280290a91.44.1720858636218; Sat, 13 Jul 2024
 01:17:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710225011.275153-1-daniel.almeida@collabora.com>
 <fe84a028-01a8-4987-b1b7-141fb76d263c@arm.com> <4344B22F-D859-4C64-A351-69FFB5208362@collabora.com>
 <ZpFDeajsuVONbSYJ@cassiopeiae> <0A0C1EFC-29A1-4D73-8B02-CC1C693D6A7A@collabora.com>
 <ZpFMmAEdqo1dhj0s@cassiopeiae> <CAPM=9twNU3Wm02zCqzipSt4mDU3UUF5AyVycpBkPTGqv7fwPAQ@mail.gmail.com>
In-Reply-To: <CAPM=9twNU3Wm02zCqzipSt4mDU3UUF5AyVycpBkPTGqv7fwPAQ@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 13 Jul 2024 10:17:03 +0200
Message-ID: <CANiq72=J=RVRy+f8+B=Eb_J6sNBsGqvBT8-io-m+VqJNgZRnkw@mail.gmail.com>
Subject: Re: [RFC PATCH] drm: panthor: add dev_coredumpv support
To: Dave Airlie <airlied@gmail.com>
Cc: Danilo Krummrich <dakr@redhat.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Steven Price <steven.price@arm.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, ojeda@kernel.org, 
	lyude@redhat.com, robh@kernel.org, lina@asahilina.net, mcanal@igalia.com, 
	rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 13, 2024 at 2:48=E2=80=AFAM Dave Airlie <airlied@gmail.com> wro=
te:
>
> I think I'm on the uapi should remain in C for now, we define uapi
> types with the kernel types and we have downstream tools to scan and
> parse them to deal with alignments and padding (I know FEX relies on
> it), so I think we should be bindgen from uapi headers into rust for
> now. There might be a future where this changes, but that isn't now
> and I definitely don't want to mix C and rust uapi in one driver.

Agreed, I think with what you say here (changes required to external
tooling), even if the generation was done by `rustc` itself and
guaranteed to be stable, it would still be impractical at this point
in time.

Cheers,
Miguel

