Return-Path: <linux-kernel+bounces-434874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE5A9E6C2A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1E492833B4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DA2200BB5;
	Fri,  6 Dec 2024 10:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANfX23Nd"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C651DB362;
	Fri,  6 Dec 2024 10:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480725; cv=none; b=Q5ZGrLsYCHXA92oFnEL7ql0zPhWa090EXMA/3XdPURuf98S1HqHgxlBs+23V4uTiAKEp++zcud0mg9hdGNd+/Tjq4C+jfvzPFEvvlN27OX/kr9MngywykgeAua3jL0N3sFcvN1+/AMOT9BVoNgGiFo1wL9ks5gET779Cje0EH+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480725; c=relaxed/simple;
	bh=qm56NxiQ7D7JfRK509GN0BXAuUb+KUhHJC5tRHfxPEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b7wSMtNfIsOJXz7TIacviUArhPIoLxk/xzjXP9rdE8vBv63qUaIf505RLTW2K0PTJcczxJ+dZjgaBpt2fuOiqj5QD8yQXDg2y4p6gXF+6RN5h9JEluUPIJ2wQ8u03DnUMEhwRux5ZaZ7b+dfFh6d7SZTiOy4BSX5/DUDpG2fFzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANfX23Nd; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ee4b72d4d8so195701a91.3;
        Fri, 06 Dec 2024 02:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733480723; x=1734085523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKj3vUCBPgGBSob8odmIw7UwyMKZuKmVMyOWN/FOIMM=;
        b=ANfX23Ndzx8F7YNNwVreBslPYSED3TowyKeDYyj7VDh+c4SiV/aoCj/majwiWhTqhq
         kje018oRuBXRmUXXU/VnaaxaW22gyZaQI4/aznScou1JNVzYB/odxeMZZUzGOxmMWxBP
         5KR3omsZTlZc2wq2XsrC4pAoseQovOXoucjk1SeWj/r2trBAqammLQ8oDpLwZnSZHpeg
         z14XvSdA+BMkqrlraNjVCiYniTWe/Rlc/PoCbTSlbkqK8c16VSFN3vqrFhX6CMUL5K7s
         X4AqjETffCO+4ZtqRNvJQMW63T/aXFZzCM4fnW1DUZLY0uvDvT/GlVCvFVJAe6HLyhE4
         2Ugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733480723; x=1734085523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sKj3vUCBPgGBSob8odmIw7UwyMKZuKmVMyOWN/FOIMM=;
        b=GgOCDr8Cb4dEPAHRjlWgQh1Z/J6X9oMuIWOmgfyiZNAwOKkLEy8KGIvCtrzvnHW/0s
         ZxaEYJfSS7Dn6147gWgRgFsr3fPlfFUNI+JDiDGL4iUK0MLm4KXz3bXK6KIzTQovHhtC
         KCr4YZ2vOCfdWYwBE7FzTmgl+/h0+j+uOGqJu/579m1vzyxJZ1QJgXH44dRwiwmJ0EMg
         2XxNMIvu5R4q5IE1teFU5QG8PXNdGRoH3XR+i+vGhWZz9x8UZnq1thRBvowpS2NhLQkv
         X1J1Jgl187Xs8INLhCoJldsfMe7BuHHovDpOpCduCDB1fRHdUOQS2FLdPT1KmvHs4SZJ
         kOaw==
X-Forwarded-Encrypted: i=1; AJvYcCWlyto4I2JSJlw+sVRJ4Skgsute/24Rhq+1//nDMZnkzHCLkuNg49pfPrSLDITSt1jjpRvvSapaEgu4eNK/5A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxuxnE2O1JL4fRfzyKVucHMIZmLUjBFOGmxT+ln18K/FNAxAkMj
	DRXah6RA0bM388OLt2nttXxR0lTVWHQCdi7uUtXBx1JbWBK9a25NyvfgPYA5yC5PslP8zMlY0i3
	/JTNLWZIAPWovYjIzgIBpzoh6jns=
X-Gm-Gg: ASbGncuifc3v9gICCCADSziIDoHbmyg4HiNsy1+gvcDZXB/fpmfToPazQ+J/pbaBIaw
	2G+z3Oa4T68Qq+FzYIVw+5Pff1tIZgxg=
X-Google-Smtp-Source: AGHT+IF2nYzMpsOtNWH4ZGahGBk3vqTp7bhp1dSpAohyPJS/dC8XJDRjuSpeJ5niDgeaibbIPR9wSGOTI9d6QS2LYRE=
X-Received: by 2002:a17:90b:1b50:b0:2ee:d372:91bd with SMTP id
 98e67ed59e1d1-2ef69462652mr1460735a91.2.1733480723115; Fri, 06 Dec 2024
 02:25:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206090515.752267-1-lee@kernel.org> <20241206090515.752267-3-lee@kernel.org>
In-Reply-To: <20241206090515.752267-3-lee@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 6 Dec 2024 11:25:11 +0100
Message-ID: <CANiq72=e=pNXYGN_=_R_g1UkxTPhdWc+izb0i=7_V+aAzD1c7w@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] rust: miscdevice: Provide accessor to pull out miscdevice::this_device
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 10:05=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> +    /// Returns a pointer to the current Device

Nit: please use intra-doc links wherever possible (if not possible,
please at least format type names as code). We also end sentences with
periods in docs and comments. So e.g.:

    /// Returns a pointer to the current [`Device`].

There was a comment about this line in the previous version, v3, but
there does not seem to be a change. But then again, the title of this
patch is v3 and not v4 -- not sure what happened here.

Thanks!

Cheers,
Miguel

