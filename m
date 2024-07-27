Return-Path: <linux-kernel+bounces-264219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F162693E04D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 19:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C9EF2821C5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 17:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C9E186E3D;
	Sat, 27 Jul 2024 17:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwUFZVa5"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B016B17D378;
	Sat, 27 Jul 2024 17:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722100445; cv=none; b=qMx707aE1QSLpIlrnxpxoQcCy9zEcWZaic3rsB1K5TKSuUtHEbx/6iembARaOSAsxPVBDTFNsqPkupX6yQZ7WEvxFFZoXKl2j58fE2g2DVAS1454WQZ72umGsm5cwTzqLhVzFa8WzDE9KC1rlcManYxS4AOPumC7Um5SdGjfMiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722100445; c=relaxed/simple;
	bh=B7cMUEZFKzGpbsNfnDV/DqUzvWReH5eq/6BRzwrBD3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cb7ZKkUyir4lVXQKXNQgzOMeF21MhHjqJSpcannGUjHN10RcBehy1OgW3HJ/Shx//rEJfeMC9Di11oQi93CrRwyMJVOVWUwfsl2/yEGUyoNYP76/fckVbakGhOQDxvYYI2ThcjBFPxzyYBn6gtVfNROI5Wh5EBhxTIi76TobflI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JwUFZVa5; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7a10b293432so1329362a12.0;
        Sat, 27 Jul 2024 10:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722100443; x=1722705243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7cMUEZFKzGpbsNfnDV/DqUzvWReH5eq/6BRzwrBD3w=;
        b=JwUFZVa5/I5V5IDqDeLDMC7yKZU/s2RTDQxOLVAqNsgL8BEWZ2z2AyI9YNixKOuhP+
         jaBCdux716VPz3N4rsVAz1utZRkp2WT9EQ9FSe0JlUgFWUNl9RrFmqLlRHmOOsfNFXMS
         LmMQLGUgFdKE6FW/i7tlxhYMdv24umPJlaqb4a/sSx6b7tnmCM5Wtfm9/vzw5kI2wD9x
         PqC2sKpJGmzFCgUDKhNDeYdCKoCtqDEO4pAxkXEbfKzLI/P7EXQTLRDllZ+PhQ1VCNK6
         VqiRNv0h33YErkWgYNmb/XZSFj1XSLheoKuOAYwQRYMUeqfnHC8FV95blb0FwfkQATvv
         UKPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722100443; x=1722705243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B7cMUEZFKzGpbsNfnDV/DqUzvWReH5eq/6BRzwrBD3w=;
        b=FDToLwnVfWty+EU+fsvoQidbjGHOvoPs5iNF9Me0Vzj8tsjQ9dfqQppq6J1YWpdUCf
         xDfLGgFRUCwz9raTO/eePFKEBzOGaRGP/HU4csT2ZAM1te53yxh1hWBxv+/8UYjKoXzD
         No7zXTSqvpjfMWJbQvcgOO30dWO3RZsipgjLOM02Ru/uhe944exKFfRlVI2+g6+wGuMz
         NCHXvYagCVFXtcZ0vptvb+uQ5OvsqLx8o6O3ZtvKqtnXksO3lCFlFBsPn/OEeDZaw1P+
         BH3z5DkQBKCKBd8dA2UUniwjCytwj5r/RvkfJpihl5L+TD8FsMhlRzB8fHKixDpqMANC
         KRig==
X-Forwarded-Encrypted: i=1; AJvYcCVUkELC11ET6oq8WI5pdhdvKQMb74/mZaDzzqKuXqHsTYvjQ24eQYUDrZGegCoQ8CI3eLRPJT18lhn2Iz846B93UebWWZjTSvhUZD7zYL4CeDwVyt3tIki7YSDmZjvY8N07CariplNTXwUgGgQ=
X-Gm-Message-State: AOJu0YxbeQwT1uvvi5WQyplYcIxEOrbNO+1dHCSw4EUHiVf1SJ6u1ekI
	su5uV8tpwW1WFYFiiYdu7XalWWpkbrv+7hMU4tDX0vqqNzpmV7OWpvsLOPHqrc2wagRAlKR/inY
	pqDFlZ8z/4AVA79AuZR06wxIpcjE=
X-Google-Smtp-Source: AGHT+IGIMqEo8w1iLYNTyLELyAc+lNBhMwc51EgAaJuLppv6RhedVK06ks6TzEXaUHDg7nuFT1CKjVpSWN6Fo4NdRWM=
X-Received: by 2002:a17:90a:d911:b0:2c9:6f06:8006 with SMTP id
 98e67ed59e1d1-2cf7e2135c7mr2801382a91.25.1722100442771; Sat, 27 Jul 2024
 10:14:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240727140302.1806011-1-masahiroy@kernel.org> <20240727140302.1806011-2-masahiroy@kernel.org>
In-Reply-To: <20240727140302.1806011-2-masahiroy@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 27 Jul 2024 19:13:51 +0200
Message-ID: <CANiq72n5gF-x5t-5sDRrpLoFwxOUjS-WMFquewMejr3V_zQvuQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: fix the default format for CONFIG_{RUSTC,BINDGEN}_VERSION_TEXT
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 27, 2024 at 4:03=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> The default of a string type symbol should be a double-quoted string
> literal. Turn it into an empty string when the version command fails.

Makes sense, thanks Masahiro!

If you want to take it through your tree:

Acked-by: Miguel Ojeda <ojeda@kernel.org>
Tested-by: Miguel Ojeda <ojeda@kernel.org>

Otherwise I can take it too.

Cheers,
Miguel

