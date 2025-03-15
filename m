Return-Path: <linux-kernel+bounces-562569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E080A62C97
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 13:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9E351680CB
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 12:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919941F9EC1;
	Sat, 15 Mar 2025 12:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsMQOyvz"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591941F5847;
	Sat, 15 Mar 2025 12:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742041256; cv=none; b=f5zQtICDVxKJNF/olro0lH7LOiYjMjN1gtkrFE1SViUaWkqKtU4zCLjl0N9r3tbclRSodcJ5BwRxMZJxtTO8JAm5Rwgd9e+fEBMnrOF7KYbAA4Lazqx4Je2RI0x+EYMyxce0Ukzj/9W7w1IJu4RGCxRtcrwrMFuNrxxrfvrHVRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742041256; c=relaxed/simple;
	bh=taJL1i+nVWCBfH1Pg+oM1jKI+MUMOq+Y602lDIgw4Tk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bv/ZS+MwCCmM4g5HZkryxGc1Z5ZFxVftfr7fJEYWdzePY5c80QTt8kiVpgnOE8LQe7lSv46Ln3VJaM5f7T1bfZoqiG7KXiBFydGTNTmKWsKMwYGthksktEnoDwxdYZlD2eobWesAmVsalV27E69/tYY7CKAxFIxjjg+LY1l8HdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dsMQOyvz; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30613802a04so32537471fa.2;
        Sat, 15 Mar 2025 05:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742041252; x=1742646052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=taJL1i+nVWCBfH1Pg+oM1jKI+MUMOq+Y602lDIgw4Tk=;
        b=dsMQOyvzQt7PLXC3iSm1EB84HixZa79LbE6ug+mlySoE2S7qyTokDxBzhrRGspdSgz
         EEPdNO1XxTsh8k/tNyl3TprcmjNFCLQBrYyYnAzHiEo0gEaJMkpdQil+kE6eiWaMkqlE
         TMJEwYyNEZTajmum4R68O/k/YTsQGW4olVKr+Lw39QQgZU6nWZJbWiwacaFNvo0Kl5PW
         aK9PTnmG+NRj6sz79HaB/+HfXlbLnLRoa56BbXGeGKGcJgRy1JUJIpqpBA2dwljlL+Es
         Rj6eJ4EnBUSxyf5TCOiXH7LOA3+LUVUPhmgTt+sUVe/mXsr9J+kqhVc7B8dH56BaKogH
         ptlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742041252; x=1742646052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=taJL1i+nVWCBfH1Pg+oM1jKI+MUMOq+Y602lDIgw4Tk=;
        b=cXlGq0zk7MHL8f53fddazZkadnivWk0CJeshr0qV4Wg3iADrIkjVdRCciS+RSlaeXy
         ujTTBTgxA0BewyspxozGJ2ACWipghIY+YPI+0Iai7O0M5Ykutw7Cd70kLZACRTnKFp3c
         PXN7ZpGLR+ahqoGYW3TIAk6DU6pPAXtYwOF09s/9+7CvLxvP94gF7PWBvMCj86ULceD9
         5kYNaMML9Flub5ysrWso0uoLFmQ/zjz2is739wqY6njbczzRrZ3scWKARYrW0TbgKagX
         pPGjdmUCNQGSgLplFJwswNciaUEXcZk3dOTEYfcQjkt9tCVGPSkxegkzblKs62SWeP8L
         1dMw==
X-Forwarded-Encrypted: i=1; AJvYcCWvDGcbJeJ+maFSum8/G74tvN7TM47/9w3MZksZ1JfONQOXVGyQEUKEUWWc9mQL4cAnuxyVpFt1jkxi9d0=@vger.kernel.org
X-Gm-Message-State: AOJu0YybBCY3ept/CD/U6B5JU+V1NWrZgJ60xcR4a3+yYTyUeVKrdMif
	K4tZvjlaCQuXFstPoMAL6M29xP4BTc0JiNc2M42Z31Nuy/MrXHQJDwOJQmc+apCwpkzOxVqHjyr
	kYNmABhYfB1ljgyLH2tKkKKvLMfQ=
X-Gm-Gg: ASbGnctHQKn45vjyRGnyoRgDm5SUyDWg4Eo6QaeHUrJcnoTybnhi26Yg4OW5myeENkx
	/PHUp14QHGB+kxs54+FUYvncwijQ6CoeQtH2CMOX97V2kT8+m6vP6w5dsnbbvVs2LNcCrxr9FCh
	XGAEQS6/8MrLg7aFPiHFpVFV8vxRlI0Qq6PijW6ngRc8R6lZkqm2wdexbATamh
X-Google-Smtp-Source: AGHT+IHre8gYoYOxjXZSdvK2VzoVhuvrxJ9TIF3avtTIz/hIj/9w6vb3T0czu+u0FCkSwNp+EhS9bXAl7HkZLU+ZjSw=
X-Received: by 2002:a2e:a547:0:b0:30b:b00f:9507 with SMTP id
 38308e7fff4ca-30c4a8e1231mr23955491fa.24.1742041252095; Sat, 15 Mar 2025
 05:20:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311-rust-analyzer-host-v2-0-30220e116511@gmail.com> <20250311-rust-analyzer-host-v2-4-30220e116511@gmail.com>
In-Reply-To: <20250311-rust-analyzer-host-v2-4-30220e116511@gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 15 Mar 2025 08:20:16 -0400
X-Gm-Features: AQ5f1JpDsYW7F82__CF4lYDi-7o_mn90Imk8mmsBMVstzX4IxocD2ibF3zNr-xs
Message-ID: <CAJ-ks9kSxK_=p2SMJWNVjS9wCSmNB9O0eOEDGEbwjCrAxsXMxg@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] scripts: generate_rust_analyzer.py: add type hints
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Boris-Chengbiao Zhou <bobo1239@web.de>, Kees Cook <kees@kernel.org>, 
	Fiona Behrens <me@kloenk.dev>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lukas Wirth <lukas.wirth@ferrous-systems.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 9:17=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> Python type hints allow static analysis tools like mypy to detect type
> errors during development, improving the developer experience.
>
> Python type hints have been present in the kernel since 2019 at the
> latest; see commit 6ebf5866f2e8 ("kunit: tool: add Python wrappers for
> running KUnit tests").
>
> Run `uv tool run mypy --strict scripts/generate_rust_analyzer.py` to
> verify.
>
> This removes `"is_proc_macro": false` from `rust-project.json` in
> exchange for stricter types. This field is interpreted as false if
> absent[1] so this doesn't change the behavior of rust-analyzer.
>
> Link: https://github.com/rust-lang/rust-analyzer/blob/8d01570b5e812a49daa=
1f08404269f6ea5dd73a1/crates/project-model/src/project_json.rs#L372-L373 [1=
]
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Gentle ping. Please have a look if you aren't intimidated by python
type hints :)

