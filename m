Return-Path: <linux-kernel+bounces-261799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B25D093BC48
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 08:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAE461C21735
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 06:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468BD16A938;
	Thu, 25 Jul 2024 06:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Vp2Kz74T"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B87915F3E7
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 06:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721887248; cv=none; b=oqCxnfCnI8g/OvXq/5k+tBZmAziyxD8N1CFw2WKF+AWLlu/eJFpgwLgaL5JKY4JRuSOSU7/HfmzSoDajkUdY2u9sRw2PwqgKsaO8grsxAGm8M5nuo2qolYusAmWNXlBEWXzXN/ZB6LVnDGeMVca+sY8HhPIPEkbX1+hkD7tVbbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721887248; c=relaxed/simple;
	bh=Kr0zGBj0haczHBvbD8cwWEQM5RZiIsWiCpMwDSA66Go=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=fI1/R0+Jrir2l1z93EdbRxUH3Xfjk14ej9ojMXnXQQC7VSWgvKuZ2/+2W4at/wKOpEhI9Pc2IrtD3sAFRIDCvcuVcZpg3VPCN8Pa9MXFeV6M5orR4G1s3TlLx/F4aa9gaWhqX83/HtPnVJdenfmCn2l1YxboPo4IzdGeVFqhzRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Vp2Kz74T; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-80767b21543so27557339f.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 23:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1721887246; x=1722492046; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DaZBMfqSxMn/z6S8qgC8qo5GZ337t5g5xhl39jHsYNk=;
        b=Vp2Kz74TPV0YR6V34in7Ls9jSD49XoOoTiXqslkaXfyi2Maz71GTBfstA+WgDEFFAZ
         zBZaqHTo81UoXk4ZAXUjNmIBeykNYqYINtBwP22Ffqe34R9Lxt7dLWFyY1G+hNanIosO
         oXoQp5+oyRzf1Qh68Hu25i6T5D5HAcAwpUwGkt4eSKzLl4l85DIRVqwzPj5Q4Dr1u9Da
         58CqYJ83zbRWEkJXCxp1L7VSwV12xaZM6FhfwpBcjCFIH69x7mmANZ2wPDYCmHQt/5lZ
         XoD9rr5PUnEnS7s6QIFV4KHOG1ZnYh9tP/zVBiCW3K9K592Ev2wsDy4CbpTccpUUgfMB
         6aGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721887246; x=1722492046;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DaZBMfqSxMn/z6S8qgC8qo5GZ337t5g5xhl39jHsYNk=;
        b=FVIfoGKtWJgSk8OOTSIp1pqZrSjLpg38As/JmvEn7yUQJ+qxYTIrYsJK2WlotkmXiz
         8YTUNePvcuKEhUhPNANm+TI8/zRZBLsa142IC29jgd1f+yQUJ44jljXvSAwNadcpk/IT
         QQO0mQYZKUDGrawqBpdwMPOBNOvQC3/jxm2VKo/79IdHXdPt8lRQME022BGyxw6b+6Xj
         6v0pLz19QjJIKT6L2Pz4/VGwdk9J7CxLDj4Eo6B011iL1nYEWcRO9qaIM4k/PjUq48Yh
         PYXPeJfZOonN0jGtOZLdM7XnM2+KyRpIFaF2bwT/y59SoRdaeFn+b4jZNX5h1MKAgsqL
         7i4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXxm/3LURmEi88gcd4zM/ZNUhqD1W8sqnXF2pxb/2F3IeWLyrhxrS/tEYyQVFknMoVL97B1JMZInYISvmY8jr89KCj9NkCckDm5y9RJ
X-Gm-Message-State: AOJu0YyLnKbzRlP/eIa/5VYl2wUSbfwMZlx4bSMisvamy+MTgfuWX00J
	g4ZtLkEZTE2ZYnp/GjJ7JM3ttGGR03xc2LydtvIHGfUtpkOHgwct8s/qnaXXaRtVlWb+aQVvbwG
	KaLqC1xgQVR/8IX8Ywo2gKJMsISHEnH4JqEyikw==
X-Google-Smtp-Source: AGHT+IEmawVIdlSh5tTN/6IGK32WJedVx4JK9jP3GBjhVuarSLSuiA58BlnK1FARnDJFh0gnTg2HBeuLtad4jD8pMpc=
X-Received: by 2002:a05:6602:2b93:b0:81f:7f56:6000 with SMTP id
 ca18e2360f4ac-81f7f566531mr114544339f.15.1721887245778; Wed, 24 Jul 2024
 23:00:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619061709.15236-1-zong.li@sifive.com>
In-Reply-To: <20240619061709.15236-1-zong.li@sifive.com>
From: Zong Li <zong.li@sifive.com>
Date: Thu, 25 Jul 2024 14:00:35 +0800
Message-ID: <CANXhq0o8JnG6G71hhvwbmuc73j1XXit3UD_Kppdo8apEDzSZWQ@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: filter null file for dt-binding check
To: apw@canonical.com, joe@perches.com, dwaipayanray1@gmail.com, 
	lukas.bulwahn@gmail.com, robh@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 2:17=E2=80=AFPM Zong Li <zong.li@sifive.com> wrote:
>
> When removing a dt-bindings, checkpatch will catch the 'dev/null' file,
> and think there is a non-dt-binding file. It causes fail because
> /dev/null is not a dt-bindings
>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  scripts/checkpatch.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 2b812210b412..ac59a48162d2 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2896,7 +2896,7 @@ sub process {
>                         }
>                         $checklicenseline =3D 1;
>
> -                       if ($realfile !~ /^MAINTAINERS/) {
> +                       if (($realfile !~ /^MAINTAINERS/) && ($realfile !=
~ /^dev\/null$/)) {
>                                 my $last_binding_patch =3D $is_binding_pa=
tch;
>
>                                 $is_binding_patch =3D () =3D $realfile =
=3D~ m@^(?:Documentation/devicetree/|include/dt-bindings/)@;
> --
> 2.17.1
>

Hi all,
I was wondering if this patch makes sense to you? Thanks

