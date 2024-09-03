Return-Path: <linux-kernel+bounces-313665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A82B96A862
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 22:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44C621F25123
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 20:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CED1D0177;
	Tue,  3 Sep 2024 20:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dZ0RYkCY"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1898191477
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 20:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725395726; cv=none; b=DuquhUYOkQtMLczKIalQYxTdxk+Sap52ScNB0M/MRcuw3BUbYUYRT2QfEYY2qTTNkigvsQShRQX+KJd7ucR0Ldqorfc8dHuxcvXAcaphwhhGp0tuf9F/sy7pNjT2w6OUmxuhcKqdz+28jX2/zJE+Ff2L5t/T+VGc8wi4gdzg6TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725395726; c=relaxed/simple;
	bh=HVywCwN2Yjj1xlHytjHC6YvMV97tXGxy0lNSGHiReEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q45Pmoeqf1J5z/PNMHbOstkNwLTadarj6m/ANjncx1UZjDrHGplyZqoDtuictNqu1SvgzEMBOXz2bsEcbEg11pBwHhsPEZbgTjqXLHqsk2VEwFZU/PY/4Cr74Fu4MWDBE14V8XpH1v2vql7/NBOTHoD2nhINMC+J1mE7FsP6B8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dZ0RYkCY; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-206aee40676so2649805ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 13:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725395724; x=1726000524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dz2oqIH/0AWPv3aut3C24Kjyp8vlJ1Vn5WqbVJER1nc=;
        b=dZ0RYkCYIwsl2lmVsHoxkwRchgpf62iNqQxyXUQZEURmmn/WhYMzM334bCzfIOwrli
         nsGmKb2TLUbWXW+YT+rxJVr5oqX3SvMNHxfnglhoR+rUFIOKhBYtRM/J7ejFLBeqYnYL
         BEfxtWWygTprfDUAuEQDD1OEtQlfBY/LUyB0Cq79UD/pVFeCAndOzYkZM/eJMBE8ceJU
         ATmINk/jeCyGr1EiS4IPd7zeULYCGVciBVHn8MvX6rkh/Xy5t435IlwUbYt17tIJdo7l
         xAZ/9RHoL5VaLAelF/Gp45XC0c7fdjnhYL0k/ndsVlsJuRpS8ZGPGsW2UVSRALcppWBC
         GiMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725395724; x=1726000524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dz2oqIH/0AWPv3aut3C24Kjyp8vlJ1Vn5WqbVJER1nc=;
        b=Q39ijo8HP86HyhepH6y4qhNJfRSPRmloYCbEEidA+fyl17zLDUQa/9rU9FIdAx+apE
         cmm7KldU7D2sD6A/XvwM21heEq4UkGSvd5wcdBwVaj2Mz7BZ0jGqPYd+7FKgvqkMoQI7
         mEMWiB6V5VPYRzXx3534mHMQOKNB/FmRiLHUpNx0vPDOqqdUQL4kqYwEab0c/vqG41wz
         aB4WC++0XL+wn9Nz/qu3jIxG+AC51B43TD2R1z0RknZOmqUzsgaPSuijRktCKUTRp1Ea
         CSTVFae4bH9gdbi2p+WkVXYu1pqnElDKoxjxS0u5Bbqq8hJYBkmpE5NfyQ7Eh+fxK8Et
         7G+A==
X-Forwarded-Encrypted: i=1; AJvYcCXLv4+fF4ajixh6JTJ8JvSrCLMFJaBTqNrORn0vCe8WVgSTVf7BZxAYajow7pcUOFplBpo7upzYCxsmukA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCtHLsKIu5friG5/x+zsxUXQCxXeu8gR0yr9pM7pjrLLoMTtCU
	FyFyYW70dyQk5VDff5W9E2AJ7X3CURdBBgox8Pyg9SuuZzElgLRLu31FFctHVyaTKOzqnq84LUJ
	q2wTbbrryIRstb3w7lB1JufvQ8WQMQTiGIqU/
X-Google-Smtp-Source: AGHT+IH/N8Nc3VK626Xbbdh1sJafaonZhRzjf611iF1Kc4/0ftxx84Yv4kOrSHuhJTy6MiwdI08UXUXBAFVGvy4UH68=
X-Received: by 2002:a17:903:947:b0:206:aead:6725 with SMTP id
 d9443c01a7336-206aead6a42mr13310815ad.65.1725395723593; Tue, 03 Sep 2024
 13:35:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903200753.2097911-1-robh@kernel.org>
In-Reply-To: <20240903200753.2097911-1-robh@kernel.org>
From: Saravana Kannan <saravanak@google.com>
Date: Tue, 3 Sep 2024 13:34:45 -0700
Message-ID: <CAGETcx-rHM6Hmu6bTBzsud=BaKTZgZsw2=R=fsZsLkMOzesGZQ@mail.gmail.com>
Subject: Re: [PATCH] dt: dt-extract-compatibles: Extract compatibles from
 function parameters
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 1:07=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org> =
wrote:
>
> Various DT and fwnode functions take a compatible string as a parameter.
> These are often used in cases which don't have a driver, so they've been
> missed.
>
> The additional checks add about 400 more undocumented compatible
> strings.
>
> Cc: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Saravana Kannan <saravanak@google.com>

-Saravana

> ---
>  scripts/dtc/dt-extract-compatibles | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/scripts/dtc/dt-extract-compatibles b/scripts/dtc/dt-extract-=
compatibles
> index 5ffb2364409b..13ea66d49e6c 100755
> --- a/scripts/dtc/dt-extract-compatibles
> +++ b/scripts/dtc/dt-extract-compatibles
> @@ -46,6 +46,15 @@ def parse_of_match_table(data):
>         return match_table_list
>
>
> +def parse_of_functions(data, func_name):
> +       """ Find all (device|machine)_is_compatible() arguments """
> +       match_table_list =3D []
> +       for m in re.finditer(rf'{func_name}\(([a-zA-Z0-9_>\(\)"\-]+,\s)*"=
([a-zA-Z0-9_,-]+)"\)', data):
> +               match_table_list.append(m[2])
> +
> +       return match_table_list
> +
> +
>  def parse_compatibles(file, compat_ignore_list):
>         with open(file, 'r', encoding=3D'utf-8') as f:
>                 data =3D f.read().replace('\n', '')
> @@ -60,6 +69,10 @@ def parse_compatibles(file, compat_ignore_list):
>         else:
>                 compat_list =3D parse_of_declare_macros(data)
>                 compat_list +=3D parse_of_device_id(data)
> +               compat_list +=3D parse_of_functions(data, "_is_compatible=
")
> +               compat_list +=3D parse_of_functions(data, "of_find_compat=
ible_node")
> +               compat_list +=3D parse_of_functions(data, "for_each_compa=
tible_node")
> +               compat_list +=3D parse_of_functions(data, "of_get_compati=
ble_child")
>
>         return compat_list
>
> --
> 2.45.2
>

