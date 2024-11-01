Return-Path: <linux-kernel+bounces-392618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE99F9B964B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72A19282DD9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 17:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4DA1CB530;
	Fri,  1 Nov 2024 17:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="d2fziDfr"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0112A1C9DF6
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 17:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730481079; cv=none; b=cuUCPD8Prk15EDjQyQ2nbtVXJasheO5LyoFQhdXqVz6qGbhc5HIZ/DmE8YfJWZyhrI6yPi+SsI5XeIxku2xoKRNrI8pfCx3GWGAInmEoQjaOnN64MkYD5Xy7/QR3a1XMJQsyb/jImhUpbEKB9R6tzUzcGla7DD0fQwymnEv7yxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730481079; c=relaxed/simple;
	bh=lDcrhvdKzxICp2em7eOQ2LPUn90y8jpF57EZ1rpkswU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NvAjBZQRefWdlv5TgJn1HS0vtREMFI/otnNnxn5rrM8VUWAe3PD2UZbJrF+vD3IY+JoZpeWb2UznGSc5kC1CWEuG+DvCtSH6sttK9gRNWITnGvqAt5AmYIw8o8cIigQOZ1VdpD/O9abPXEQAteIdTMmovVtXtsA7feGy53JEf4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=d2fziDfr; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3e600ae1664so1286553b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 10:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1730481076; x=1731085876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsDgBg/O7EWgquGbLeqs0lCpMz4K8vMjHSFQlw3dpv0=;
        b=d2fziDfrsVBwLlywZPnqnZzcyfsmSoonkiDzG7DdcQPVjKcR9RX9tatdpCVhR8iSD3
         75dEaX0OwPuTytIbsCcnxTJ2DpUB1LJJUgUHe44K8kHO3EID+ZC3zSmb2JB0ndFxTm41
         MuVYExRB63B5w2P5AKaqixApAIxV47e1sFDp7x8KxaRQiaVIsIzXmoHvuNP4UyN1SMWs
         MM5bpSgewBfej8qjAO8fFqk8D9ZHq6gC97W7gFvScTsd32y8qrf1KHOiY5rE4VeGx/wB
         A7USPWw3I2P61ntqiyxZUawmGWZJl8GFwCx+rtdMhgfW+K3S8vorWkOXBGWjBhEwr2Pt
         dE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730481076; x=1731085876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xsDgBg/O7EWgquGbLeqs0lCpMz4K8vMjHSFQlw3dpv0=;
        b=Spd0JM8jq4UPn1iqaKhcVDH1dh3sAI6adlbtN09x64JFEC1FqR+dxD1UCwF3cb7jCc
         RsHAbQhTTmYqlN88rCXN2i/0seizdi5BX2Z50EpCsGbSSgpyYfsjSmpMUt0O1171eaoW
         4YAvIk2hR4IuZmXRkTulfXwXdsKaT648xUu1RB96ZxN7UQHHfZoczO3bm7o6D/xcAgVS
         BrEBTCGdmNEsHz8xv7fUAjQ+4TATBSyqXPz2aqgoSE0pqWevTI8fd6H4BpG40mHhvsAE
         AxktEuDzNTroyJPmZ5BGk3LfNZy/QSMc+KlUzHkADKWtLVRkc6ZWPAFNDDIA/jwX8irv
         ykvw==
X-Forwarded-Encrypted: i=1; AJvYcCUGSwppOCVJXP2ffaMXPjJ91JahPNkS3tq01DkUiQvhO0UO4WaN1RnKH/OpA4y2G0IpvJuLsHVcZO/M1TY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwZcKW4Q+0XH9A1UgAeoKTtHuzLVw0tuy0OcPxLIOV/gtauSVp
	G2K3tOulveZas6VWxaSJ3JnPVuW8P7liGmSkZtIS6rA50O8/XxJn14pMMSbRu2Kv3ys4QqDVpMS
	y4LDc3+CUDN01/6ebdTDL6VrmbJII5+1wCt8R
X-Google-Smtp-Source: AGHT+IGE5XTIwiJsnCaOmbPdMrAHJsBW92DiCSlqSt4CdLLL2gNPk/w7OtlscWd0iZ98iATDQMkey/2O1dmRyfwwGwA=
X-Received: by 2002:a05:6358:80a7:b0:1b5:a139:4d92 with SMTP id
 e5c5f4694b2df-1c3f9da1a69mr1362649555d.3.1730481076126; Fri, 01 Nov 2024
 10:11:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYv_Y2tzs+uYhMGtfUK9dSYV2mFr6WyKEzJazDsdk9o5zw@mail.gmail.com>
 <20241101095620.2526421-1-aliceryhl@google.com> <CAHC9VhS5wLQeF4LX67UgUYVG3oViA7CmSZS_kugH+M5J0XS2Vg@mail.gmail.com>
 <CANiq72kcvpEqpwFTNFmxfJsfBMeBNiDrrvFBf_iS7+ozaECJzw@mail.gmail.com>
In-Reply-To: <CANiq72kcvpEqpwFTNFmxfJsfBMeBNiDrrvFBf_iS7+ozaECJzw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 1 Nov 2024 13:11:05 -0400
Message-ID: <CAHC9VhTQMo11s7mWg=zzDusJompOp01uJat-q9HjQCoEWzHRRQ@mail.gmail.com>
Subject: Re: [PATCH] rust: lsm: replace context+len with lsm_context
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, naresh.kamboju@linaro.org, casey@schaufler-ca.com, 
	anders.roxell@linaro.org, arnd@arndb.de, brauner@kernel.org, 
	dan.carpenter@linaro.org, kees@kernel.org, linux-kernel@vger.kernel.org, 
	lkft-triage@lists.linaro.org, ojeda@kernel.org, regressions@lists.linux.dev, 
	rust-for-linux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	lkft@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 1:04=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> On Fri, Nov 1, 2024 at 5:56=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> >
> > Thanks Alice.  Would you like me to pull this in via the LSM tree with
> > the associated LSM changes, or would you prefer to do this some other
> > way?
> >
> > I'm going to merge this into lsm/dev for now so that we fix the issue
> > in linux-next, but I'm happy to drop it or do something else, let me
> > know.
>
> Christian has the VFS side, and both are needed for this -- do you
> mean you will cross-merge vfs' branch too?

I think our last emails crossed paths.  I'm not going to merge this
via the LSM tree as we don't have the Rust security.c helpers.
Ideally it would have been better to have the Rust LSM/security
helpers in the LSM tree for reasons like this, but it looks like it's
too late for that now.

> By the way, merging both vfs.rust.file and lsm/dev I confirm this builds =
fine:
>
> Acked-by: Miguel Ojeda <ojeda@kernel.org>

Thanks for the build test!

--=20
paul-moore.com

