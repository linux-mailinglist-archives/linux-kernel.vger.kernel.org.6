Return-Path: <linux-kernel+bounces-316556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AFF96D132
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBFDB1C21906
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98123194138;
	Thu,  5 Sep 2024 08:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nyZsjO4J"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B181925B0
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 08:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523457; cv=none; b=lRIyNiaShFoNLjNWRyh34eHC53CEZ/kXVmAz2EVHXxC+ShjLHUPLqviPkuH/BMBLYo2eid3I35mN2VroN4FmXU4xlebSv2YZ190pMwtfe4Mj0q/zedu7pJWu0SD8NaN7ORMmhI1ovo5ldVEvMV4nwciUesddXoGAD2/ht5EPDqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523457; c=relaxed/simple;
	bh=2pLfpYslB2ZuYauJSQQHIlJZPnMxW6xOF3LASls58OE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CIy58/iBy0p4PiPAJRwKbHQ1Z+MGl/+o32791Pcexz6JLIOJlG2UjS7pESfBanEItFCrUPCUpxqTcu7RjUGajPtYSUD3R/KDCm8NsmRmtM4g40aHW90PrRUqHuAfUGUfbWewGyveHM8YhPd8VE2oBcsALh/lopzRQj0cbh5L/kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nyZsjO4J; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-374c3400367so316307f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 01:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725523454; x=1726128254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pLfpYslB2ZuYauJSQQHIlJZPnMxW6xOF3LASls58OE=;
        b=nyZsjO4JciQ53pQq3ygNaUBzN9d1JdOpmSukInG++EadQDE6RmK/980V5nRQPDJBeg
         XwjW2MURW5D/OOmqAdmPyHmpzusMB3l3Wgx16kVA2EemHdqOFwoT4TKTBqRraU+nhufS
         I1WmtkrcfBgsylIX3DRfxH284O+lZAv48+OqBMDp7I3HyWwSdlzdd9eWOQjgFj0VEDjV
         BrliXH3Q/YZLGB3kAGIDWI+nM5TCYqrQHCLd+7vUfxinDiavsQXgMhtsAJoOA/vhJpJZ
         HJuIVdYdSymn3jrRktkf9i6W170c0+NctnEP2Sb1cnwLI5hK7kXMSUG2i9kEXTmJQGfw
         0YQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725523454; x=1726128254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2pLfpYslB2ZuYauJSQQHIlJZPnMxW6xOF3LASls58OE=;
        b=aTY64rIrZv25/pnVEnv9ordgNok71QMGQVozHlnZqC45Euy80kJabvP70psYOiudxf
         kf1Q+NjqiEfJ5XQWrf7h9dsY1sHVqkMJOsoC0w/ell9pPtm+Qgp1+dFsE8wCZfXS4+1T
         pm2aObQakswMOgFmxmg5VBNAi+tPHwMzwagj3ZVG/Q7CemB0BDwwJlaug2nX1YhEzEdN
         +oT+Ndsxkb/lePIyDJLgknCpOk0+KbK3pStglfLb+yUE1/Pe6WH3+6DIPtCFkUm9RLb4
         MdD4kWMLPSfHPgrKErb3NflkZxkKD4hfKZEp4dwkaOgdVbdg/r3f0GOSVbFYP/aqAv3D
         tx0A==
X-Forwarded-Encrypted: i=1; AJvYcCXmwgtNvLRs3HDKrwSCw5AxwPzzRaHqhgSxZNtIpxbztu5YZ4DvGe10Op2twU4YGPjXVz2bBdtA16rGuuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyetlF7k+U68QL2/4sSuXcU+4GYSpCpZ7E730asapRQFVeaw7YC
	5d4nrKPs5V7j989e06IE0HAg1fcFUkdddtMsz+dlx1/g9TQY/Qi+/8CEGX3/lstNsPjM2mp07Oy
	JyFS+VPk9qrTPfS6C4nO36Cf1YRv0FxnhEgDL
X-Google-Smtp-Source: AGHT+IFXkQuUA6GvCxWiY5ZV2+dZ7ObdZQnAmrohv7u/9rzMrCvrlFR1MGRiX+3aUn2jzxx2iuNDgsCy59mtYNh8lQA=
X-Received: by 2002:a05:6000:c8e:b0:367:9903:a91 with SMTP id
 ffacd0b85a97d-3749b526808mr19134357f8f.11.1725523453475; Thu, 05 Sep 2024
 01:04:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904204347.168520-1-ojeda@kernel.org> <20240904204347.168520-5-ojeda@kernel.org>
In-Reply-To: <20240904204347.168520-5-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 5 Sep 2024 10:04:01 +0200
Message-ID: <CAH5fLgjOA7pNtQYTuRy5WAbxJd+uDv2Eh4Z3u6QxSJvd-xcBNg@mail.gmail.com>
Subject: Re: [PATCH 04/19] rust: enable `clippy::undocumented_unsafe_blocks` lint
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 10:44=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Checking that we are not missing any `// SAFETY` comments in our `unsafe`
> blocks is something we have wanted to do for a long time, as well as
> cleaning up the remaining cases that were not documented [1].
>
> Back when Rust for Linux started, this was something that could have
> been done via a script, like Rust's `tidy`. Soon after, in Rust 1.58.0,
> Clippy implemented the `undocumented_unsafe_blocks` lint [2].
>
> Even though the lint has a few false positives, e.g. in some cases where
> attributes appear between the comment and the `unsafe` block [3], there
> are workarounds and the lint seems quite usable already.
>
> Thus enable the lint now.
>
> We still have a few cases to clean up, so just allow those for the moment
> by writing a `TODO` comment -- some of those may be good candidates for
> new contributors.
>
> Link: https://github.com/Rust-for-Linux/linux/issues/351 [1]
> Link: https://rust-lang.github.io/rust-clippy/master/#/undocumented_unsaf=
e_blocks [2]
> Link: https://github.com/rust-lang/rust-clippy/issues/13189 [3]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

