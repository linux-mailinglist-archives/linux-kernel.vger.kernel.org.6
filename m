Return-Path: <linux-kernel+bounces-396192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E10C99BC92E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97AAB1F21BC1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7691C1D040B;
	Tue,  5 Nov 2024 09:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsAwKZzT"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3D41CEAA0;
	Tue,  5 Nov 2024 09:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730799134; cv=none; b=Ufb0nnVXoxqUrkg6VW8C2f9mjscchjMTmGcDKv535M7NtVwL7rxohyPcaU8m4fyKZdErB/sI1lm7QlshJLQrymS6HWwL6VXQL6WhmAaLvu3VC2FqDSCsNBVPldlzces5U9/QIOKrS/7ix/fNDYBXgDkj0uH1h6MSb8b5X3cf1ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730799134; c=relaxed/simple;
	bh=y3k9t7IlGyTNXiIeWwet9nwGsTFYHdSA6pQdrYorthU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sXE/s9XBZ5z5ctGssbDKAzDJF8OOmU1QWxvZvTAkXXXY0f9XG8O2lp1sRCHmdJ7SlhoG4AvHTlhm7SIApwclbaDP7v9VBfAoGeksmFOJfTOCynkBkQoHdeO8A+xX11t1LjmL9VRbiMuXunSm4f/c30L7Y1up0BJK0EZva2MT3Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsAwKZzT; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71e5a00d676so259709b3a.1;
        Tue, 05 Nov 2024 01:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730799131; x=1731403931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjScqKwTVHOB/jKA3HSvu1a3WrYkMhLJWnO+IQHcbSE=;
        b=bsAwKZzT1mlhwcxsvnXR1eUoXVHRPJBl8lQy4xkXGSzJICFgvKXYwnwLxSyY0LusQY
         KdWsmPwemfLmXa/Fk67xhgDKtOgKlxAVbH435k6CSvCNo07Y8hr8kVqvbkMWRYj7pllp
         4REc1WBFFQgnLdINAEbNRzvZ4o/0GACwl0iA58/mdaB2SUOT6IX6wzF2KPMmcZniyDUZ
         JNjZexnnJEZsy7wgW0uKrrlKnvzD/G150H58NmU91mWDBCcEXP+Kkl1U7ypyKXo3TCBj
         KVIT9L60prIdnv3PEpY9o6nB52qa3vNdrrEx6lO3CwkNexXGwRuPYG7mHU8HH3d6IaV1
         1lyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730799131; x=1731403931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KjScqKwTVHOB/jKA3HSvu1a3WrYkMhLJWnO+IQHcbSE=;
        b=XlHJkJOoAhfetPkI0l1RF2IXmj8aIKOAtou49i9RZjcymqlditzZYfMb2Y3OU1E0FF
         LEjHbYlKR6MqpPrEtt7dLdkmqANRViIkQalrv1eGCut4UI/ztkCuBZbibbArTyU1QldJ
         nWuPb5Y5D08lObiTLwccN+n7Wg+AgWOZ2T9QerSq7vyWEXichQwKGiJ57v/2hMVlYySf
         7VQFJUGqocHQuV65gIsRuz5hewIHJykKqiNv3qnfVx5g2gbmWYMXpFZcctkaXgZ9KHnI
         Eys5heOdjys9G1tsJCTHx9uUuhyALU6YAjQeP9piDcJQg4NHvrzZY5461rdm8a2h6StF
         SAHg==
X-Forwarded-Encrypted: i=1; AJvYcCV1CxoytjRdHNsbTKKFsn/3Hpm6TLNgKzkWpfm4UdR/sd5Pv9B+pY8wM5j8JJoq9z5++Ft0nZ5D3bpC1JZ3cg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyvjQn7pwRK02Hvxoq4Nfuo433Its6mCdaqOw5dAYzDVGsyPBGT
	2kClUVBSca69YedlFNpqHP+RdMTJIo/j6hJ8RsFXxhBnzUWnA7YtX3QJjCeyvhh0XQT43PS3oz1
	Bs1AFmeEhyW7ymaMANv1AHVFo/WI=
X-Google-Smtp-Source: AGHT+IGRd4XDNlYX0EkHremT6+nIdodm4gRNBRYKAOsJFM+Oj6DD4zTVHYe3RsWa+rp/MyTW7eaTvNcJ8+D7PVtENfI=
X-Received: by 2002:a17:90a:f016:b0:2e2:d881:5936 with SMTP id
 98e67ed59e1d1-2e8f11ace1emr17324063a91.7.1730799131484; Tue, 05 Nov 2024
 01:32:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105022143.1087112-1-alistair.francis@wdc.com>
In-Reply-To: <20241105022143.1087112-1-alistair.francis@wdc.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 5 Nov 2024 10:31:58 +0100
Message-ID: <CANiq72=L=CMUBu7jBn0H2Wb8vupYzOYFrSQ_9gyFZj_w2JU_uQ@mail.gmail.com>
Subject: Re: [PATCH] rust: bindings: Support some inline static functions
To: Alistair Francis <alistair23@gmail.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	ojeda@kernel.org, boqun.feng@gmail.com, a.hindborg@kernel.org, 
	benno.lossin@proton.me, aliceryhl@google.com, tmgross@umich.edu, 
	gary@garyguo.net, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 3:22=E2=80=AFAM Alistair Francis <alistair23@gmail.c=
om> wrote:
>
> If this is accepted or at least Acked I can work on removing the
> existing rust_helper_* functions and convert them to be auto-generated.

Yeah, we have tracked the feature for a long time, please see:

    https://github.com/Rust-for-Linux/linux/issues/353

So it is definitely in our plan to use (assuming it works).

But, yeah, we would need the patch with the conversions, to show how
it would look in practice (i.e. comparing before/after etc.), i.e. the
usual kernel rule.

> +       --allowlist-function crypto_shash_descsize

We probably should put this into something similar to
`rust/bindgen_parameters` (and remove this variable).

> +       @cp /tmp/bindgen/extern.c $(src)/

I don't think we can use/assume `/tmp` -- we will need
`--wrap-static-fns-path` or similar.

Thanks for trying out the new feature!

Cheers,
Miguel

