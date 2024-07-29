Return-Path: <linux-kernel+bounces-266417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E0093FFA4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 22:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7345EB22A5F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 20:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B0C1891B8;
	Mon, 29 Jul 2024 20:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FdqSj10B"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ADC1891AA
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 20:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722285651; cv=none; b=jAahiLZUZCNkdyTvf8AphJTzCq9QlXd7yNUxUhjI1rGi2Jx+0fvePyiSFOPzdc8MtL2OEHXtk+0zkDEfr9PUWptLS5XihBAhou+d94NA4EBSkwmz9quTuVUbORnjNZIkap0uqHkchQdK/ojKDSdIgS525lBN6ylJVlF2yur7C2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722285651; c=relaxed/simple;
	bh=uvMm/YvV7rKKVvUlkwvjjo5zivb1VpW9LTG5evmKNPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r9afo48TWJYxvgXynKMT88eZrJS3m/PYOsIazsaW9ZuBxNdYCjSRpySslpw1caxWshJC14eLhoj1ZUvEhmkKkSFBWzk0ojake9UdNewPQgU3C04bk2eJU03Z8KwG9MMLIQjHTGU9QnjGWz+ZUOOb5A6H76GfQiPjA/qdkxQ/ASc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FdqSj10B; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e05eccfcdb3so2302610276.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 13:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1722285648; x=1722890448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/bpR9KnLTvNMzWB0BWL2SQvPz0QXhGOMr/3lSuaeXTQ=;
        b=FdqSj10B0dDtCoZyDs5DsDrdLj6cD2KpOfQFprbU7u5OGY/cwFAwkz0HUCAZ133eY9
         S90v9exM//OEC3YBtvMJPK7sn0+J6O+szoqYhVv+CjvRzndqlN0P5z2QlzQfDfYf+xxD
         7ekg58XTQDieQls0jpnvOIK33j/aG6a40P0BZpvHCwHQKV9nX54bv5G5k/IWsKGep6GZ
         aYWhBnIktsC7LVQPU98yu90nl+2ktjgznAtzJazyqqcUonH//ATQhSKYea9EEJQFMvb1
         G2XIgVOkE+JDY/2GidqfkJlmj5qK80PoRxJBC2Y4MwpJDWhjAA6WjQ7bWnK3OTso1Q17
         2MvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722285648; x=1722890448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/bpR9KnLTvNMzWB0BWL2SQvPz0QXhGOMr/3lSuaeXTQ=;
        b=veTFPNmMPWKMOLDg+4C4LpJihnRssOVLpfxipitSF/MXAzUe0wfrFkqT6M68i9yj/2
         Kw3WyZF3O+gBjhwgtK8puspvct+CzsOI6viR6gMs7XY0bK0C6fzP4Rt/UApWY9aeKbp3
         g2T6h8qqWr49ZZh5/4tN0OVWoZV7g/JUID1um/bFbbZqL2Zx4jeBQHVrIFdsiYdM4CIU
         DCarKxnc6ebYXTFNcsuvGiK6vU69EMydX76CbiG1Ef3/6TLJ7sqFaPGX+3D2LCGSrZ+Y
         kGeHMMAphStBlld5uYMSn+6CfyR2hmwAoJz6efD46679Zd2qayTMQ4cbZBVWRYXG4QGw
         9ELg==
X-Forwarded-Encrypted: i=1; AJvYcCU4BITtuUoPGuS0Tt/pe2dXXnZekcXQfkfpYl20eO7ZfuCobXP7Lp36PXY848JNEk+J+2tHIYRi98QxiMSY2cuMA4v36EzQ5RulqUon
X-Gm-Message-State: AOJu0YyAXj4sCbb3ho9qpCrbYJPFL1/3zpl0ryv9ns5Rk9BI0xF11LW0
	O07fAPKfOZ+K2FXMlbkF6Pm3Xu+eSkdtZaF2Tzm0LFtgSPli1SIE99E/L9L6+vjHEoXb+pNZVIi
	aLmU2a0/6rMuIq/G4nfrW0Lw9xzI1MNWJRULE
X-Google-Smtp-Source: AGHT+IH/RYHLRtsIbNoS5UxA+C29Edpt1BbZP5oMRgdZ4SAsO2Sg3xRUkJVa30nfZFtKQ4Uo4xvBHPTCZyhOOGaUiN4=
X-Received: by 2002:a05:6902:2193:b0:e08:5c66:7d4d with SMTP id
 3f1490d57ef6-e0b54468fb4mr9258020276.16.1722285647835; Mon, 29 Jul 2024
 13:40:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703025605.63628-1-guocanfeng@uniontech.com> <CAHC9VhQ8y8fYeLz8KHXVNrLmp3cLZtUPHsagf3fym3gJvoTs3A@mail.gmail.com>
In-Reply-To: <CAHC9VhQ8y8fYeLz8KHXVNrLmp3cLZtUPHsagf3fym3gJvoTs3A@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 29 Jul 2024 16:40:36 -0400
Message-ID: <CAHC9VhRRG2vYsi38Qfe38DYk33GMp32bErNjq7iFfAp4tDw1+w@mail.gmail.com>
Subject: Re: [PATCH] selinux: Streamline type determination in security_compute_sid
To: Canfeng Guo <guocanfeng@uniontech.com>
Cc: stephen.smalley.work@gmail.com, omosnace@redhat.com, 
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 5:10=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Tue, Jul 2, 2024 at 10:56=E2=80=AFPM Canfeng Guo <guocanfeng@uniontech=
.com> wrote:
> >
> > Simplifies the logic for determining the security context type in
> > security_compute_sid, enhancing readability and efficiency.
> >
> > Consolidates default type assignment logic next to type transition
> > checks, removing redundancy and improving code flow.
> >
> > Signed-off-by: Canfeng Guo <guocanfeng@uniontech.com>
> > ---
> > v2:
> >    Modify the format to follow the generally accepted style for
> >    multi-line comments in the Linux kernel.
> > ---
> >  security/selinux/ss/services.c | 36 ++++++++++++++++++----------------
> >  1 file changed, 19 insertions(+), 17 deletions(-)
>
> Thanks for the revised patch, it looks good to me, but it is too late
> in the development cycle to merge it into the selinux/dev branch; I'm
> going to merge it into selinux/dev-staging for testing and I'll move
> it to the selinux/dev branch after the upcoming merge window closes.

A quick note to let you know that this is now in the selinux/dev branch, th=
anks!

--=20
paul-moore.com

