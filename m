Return-Path: <linux-kernel+bounces-208979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F236A902B4F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 00:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58A7D281E0F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834F714C584;
	Mon, 10 Jun 2024 22:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyLkKC78"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7585337143
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 22:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718057116; cv=none; b=Na3LDSGd7Nvd1hv8/Zs/9sgNe0Qfbc/9ByOJb5Gkzwu+KV3an5kZpn3WzZcgUje3AZDroTrSESnfOPCvt/2Cu26xjTbwqkIAuH7XR5ODhOWSVXjfuDUVuLXGGfMCG/u8jTRUFzLWoJW4jWxCKj5lGXaplQGup9A6Rk48KkN3R3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718057116; c=relaxed/simple;
	bh=rP+ricIK5YBlNx+/fEIyVLa5KkTZrxTMhtE1WPEqf4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZTgniLXxXPmaPEFHqdSUKG/tl7eipjdUMyYsiY8YTHQXcjrZt489jXlaOMIobivy+PfK7nARA8ZK28AlYW9wr7REZL08zuaDSALlrclwIEc0128Nvgy3rGZqB9P3Wv1PM3u8BXjQOaZxwJVB1+3gL6V2dk8MxEKWgkNN44zTHiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kyLkKC78; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6b089f3d201so499886d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 15:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718057114; x=1718661914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rP+ricIK5YBlNx+/fEIyVLa5KkTZrxTMhtE1WPEqf4M=;
        b=kyLkKC78F4pdTPYounu0eXLxDzHXrZpOQFPqy8uV5bLluOihTIB3+MNajjNrgBq5MJ
         vnURfx51x9NiYtEU/n5QgK9WYw0Ex911jCRG/tBhtFA7AHUKqIKCMxyXGPYEJ+Ypev3D
         LdPBQEcobfeBJfHMlvqwC1CNnVVbbMuvdbdqYMucokjZOmzBXt+crfibfkyUTyjU0HBG
         muxK9AnfGSX2WXmxRYoV2kfKsZB8v8xdfaghTxy2xL5QOo0o0comD8KvuRakQJwv0fiv
         dNd2Wmeg1qkZCvX68fzZrQDkoljmiDnjrOwKsw58Alo6wukL4wn9zIzSHoLI8A/u/Alm
         k4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718057114; x=1718661914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rP+ricIK5YBlNx+/fEIyVLa5KkTZrxTMhtE1WPEqf4M=;
        b=nQXAbisG6z/wCYtlhNmQhor+RBzsuf9jm8H7zZDddTZLpxxsz5bx0l2DH46GzvglRL
         maY3jl4bDJmT7oSkl4vOj2QRmMVY8wnAesaTOo6VGegJ7I46w5gNdo/GyPMRhXDWVbFo
         ggTZ2/YnqLy5Z7k1BeXuylFFggdMWHHsNQNs2kPjrLKwmyBpxgeAfQKfVwvn0w9cvhWe
         WDhLTTMEB4dznnEQivu4+OCUbxo67HckBSpgMGQR944rqQdKVGnfovGTVbWO+YaRt2kq
         KCn+VxDCXsFTMjl0HAT8gq2fAefk4ZgW6q/QE327+WVC9Vq9n3rjysRuFeJjyoHg4AHE
         P6zw==
X-Forwarded-Encrypted: i=1; AJvYcCVdosTxmdZoKn7Yr34yYaSNUHFCfWihmEV9NF7V2iQR8+KTwRUdY3gh2jcODLf8ePSK+yDkqvM74de6YRE/l80ksWtUXbKzA++XqKOK
X-Gm-Message-State: AOJu0YzA7Oszy8voooHVAmiTTRiJwuy0rj9N6AfAgN5lsEyGcW2nKBs5
	b6yv6y34hPl3LNH+J1Rn1lh4uFMk29Etm/BKR9G6myGS32oaxDH8D2bubtJAZDLEt+UcQ5cQi5y
	//UQjGksGcUVkxm1imkTg2jErt7k=
X-Google-Smtp-Source: AGHT+IGQ20EsaNML79UmilV2KhIHb9TaWTviOWcBxEXXPuuWWdBV50/ZYy5/0HVkaRbg9Sl0MYe/UbHQP7ro8jTYxgU=
X-Received: by 2002:ad4:4b30:0:b0:6b0:6370:28d4 with SMTP id
 6a1803df08f44-6b063702b48mr99825636d6.6.1718057114072; Mon, 10 Jun 2024
 15:05:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsNptxsQO=5=qi-JYiFX=rX8Ok5inK80Gn0qrUFWbtBGng@mail.gmail.com>
 <CABXGCsN=9UFvGgKztzkkAM1c8cVN-h=TKLLxWhKgTm11h+H-eg@mail.gmail.com> <907df295-61b2-4cb4-9bcc-608d1ff2cf18@leemhuis.info>
In-Reply-To: <907df295-61b2-4cb4-9bcc-608d1ff2cf18@leemhuis.info>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Tue, 11 Jun 2024 03:05:02 +0500
Message-ID: <CABXGCsMRb3Lx=twRyi75MqgTEfMwxsEwTQg-MR0GNconhDt0pA@mail.gmail.com>
Subject: Re: 6.10/bisected/regression - commits bc87d666c05 and 6d4279cb99ac
 cause appearing green flashing bar on top of screen on Radeon 6900XT and 120Hz
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	"Pan, Xinhui" <Xinhui.Pan@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>, Rodrigo.Siqueira@amd.com, 
	amd-gfx list <amd-gfx@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 5:29=E2=80=AFPM Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> [CCing the other amd drm maintainers]
>
> Mikhail: are those details in any way relevant? Then in the future best
> leave them out (or make things easier to follow), they make the bug
> report confusing and sounds like this is just a bug, when it fact from
> your bisection is sounds like this is a regression.

Apologies if my pre-story is confused. I just wanna say I completely
moved to the 7900XTX more than a year ago and I was surprised to see
this regression on the old 6900XT. An accident helped me find this
issue because I didn't plan to use old hardware.

--=20
Best Regards,
Mike Gavrilov.

