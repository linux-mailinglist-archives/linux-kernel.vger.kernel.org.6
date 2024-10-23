Return-Path: <linux-kernel+bounces-378614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FEE9AD332
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 19:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EB60B21907
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700CD1D079C;
	Wed, 23 Oct 2024 17:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MohkiKZc"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4455D1D016F
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 17:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729705614; cv=none; b=GhCl22dp4GKzAlU+7I3TXceLlrgjeIyDUp7PElObV0UzGP0dkVCjGA3ZJ0u1m7pbQElVDw/C4DjQEVmiKnDEXTklzRcQA32r0Uw0YOULESHRVFcuMKAKdvgtXNDzxxBjTyWT/Vdl2m9wJxEiRLpDd3EYpRkx11n1UVQiX5F/AYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729705614; c=relaxed/simple;
	bh=i+7ZAlfoQfuCxLYaegZtLOps7LaYlV1n5wy00nEl8Ng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D4vDbq/ZINa6Zaxcq9mAl5SqS8ETLj752HpFGKnph9E+qkAab1tkYDRrd3Max/S/K1y2hgrjth8EfKN+kNhYeVYAzIxX41OElv9UZHcFUou6zOUDyC59aMqQgrtxM89GCve2mIJGglZyhDXEGRxfS+YPYAbnWQaapFavqQrKGwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MohkiKZc; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43153c6f70aso264195e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 10:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729705611; x=1730310411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+7ZAlfoQfuCxLYaegZtLOps7LaYlV1n5wy00nEl8Ng=;
        b=MohkiKZcZfLdETBGeL3NBfyNfaFWtugAsSQZDFk0g9qYeWCAR3g3QFyTJgazYqggu7
         yeKUpefqUeuBCao0j63DH/Usnp8U6h7a4AAz20bcy9Wc+P6H5WhLi6ie2ai30c0Z2za6
         lsvEcgxBqzpW3QKTP7qAobHDGHocks8rYbhL6IWDqzMhnIt72GZSZTYhBSlzdYcaLxaW
         T26p+j+oPfBZjM+XGeaUN6ALEsUE68zIKsg8QzOnaO6voaU+TaeHn7zn7yhqy0cn5joX
         DdHtSgDTrWuRFhzeUXBILpXEn1/WIktJNWxzr+4QaYzWXc19cvlvEF3jGsH7emKj6DUF
         6dJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729705611; x=1730310411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i+7ZAlfoQfuCxLYaegZtLOps7LaYlV1n5wy00nEl8Ng=;
        b=VTYQpiMXFeO0mrYhLTMigPIjrTdfD5iQKqf3Ph//LY1BE0tqzl+8dHsACMfhZ/JByf
         NHAAizqFoI4Rg7KRas3hFw0uTz3RRoOrYO6CNs1OdhAHIwS3GxGycjkQf25BF/JOhJw4
         6LHZ00bjj3dVFipKSmgyRs1Tzubogk8r63s0y6q8ObwZTLDfRvLbIyHwEtzhrxi9A/IG
         Nd7ywhtQrwOcygoxNoaJDI2EPG/Xh0IPQ3kQsbGbsBYq/9T2tAKd7wPfrYXufalwhgXC
         c/dDtugxqEXOXzQmwFQkkAOl+x8D+jPTv38Tma9oQGuH3dAqtLDkrrEJoT6aefmD2z6U
         wo/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXKwe903ZDMkoDPD5t+Wyxc2t23lzkX0y0Y1Zc5aMVUtnHmt5WxlzMh2KyNxvRd5+bzsMXDik3dpgpcRfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEj4iiKS4DK73ePwMmMXlVkVz+RsscFuS7431ua3JBX51wBsFp
	w/cx9GFgiVOKJ0CPfbuN0zMNhOFXrLWguY9nWJ7d9Ej6dp5Jd7C/EMebUHdkFcLYfDDhk/+vvgP
	Pz+cksCFHEaFSWHyEMghEO4Fub+1uWhtJN9S1
X-Google-Smtp-Source: AGHT+IGczg9abDGpX4ppjcVsgb3ui7YwoWlv9yFaws8RHe1ZuuGKPzBA2axsxRP2DJ+N1UUksoNEjs6hJSoRSIvhZtM=
X-Received: by 2002:a05:600c:3d0c:b0:431:416b:9ecf with SMTP id
 5b1f17b1804b1-4318a55bcccmr78525e9.6.1729705611429; Wed, 23 Oct 2024 10:46:51
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008183823.36676-21-samitolvanen@google.com>
 <20241008183823.36676-34-samitolvanen@google.com> <8fa10131-fae2-4052-b541-e4a6ef570d63@suse.com>
In-Reply-To: <8fa10131-fae2-4052-b541-e4a6ef570d63@suse.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Wed, 23 Oct 2024 10:46:14 -0700
Message-ID: <CABCJKufGTitE6bWwoY-5Pr6MfHnPu2m+RVk4UcZMik=Nri-=kQ@mail.gmail.com>
Subject: Re: [PATCH v4 13/19] gendwarfksyms: Add symbol versioning
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Daniel Gomez <da.gomez@samsung.com>, Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>, 
	Janne Grunau <j@jannau.net>, Miroslav Benes <mbenes@suse.cz>, Asahi Linux <asahi@lists.linux.dev>, 
	Sedat Dilek <sedat.dilek@gmail.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Petr,

On Tue, Oct 22, 2024 at 4:48=E2=80=AFAM Petr Pavlu <petr.pavlu@suse.com> wr=
ote:
>
> I had some minor comment about adjusting the name of function
> symbol_print_versions() and possibly changing sym->name to 'char *' on
> the v2 of the patch:
> https://lore.kernel.org/all/286b1cc5-1757-4f0a-bb66-0875f4608c7e@suse.com=
/
> Please have a look, it seems it felt through the cracks.

Sorry, I missed that somehow. I can split this into two functions to
avoid confusion. Also I'm using const char * to make it obvious that
the name shouldn't be modified by users of struct symbol. This does
require a cast when freeing the string, which isn't ideal, but I feel
it's overall not a terrible trade-off.

Sami

