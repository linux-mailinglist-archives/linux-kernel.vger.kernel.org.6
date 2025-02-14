Return-Path: <linux-kernel+bounces-514237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B73DA35477
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 03:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68432189103C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 02:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07DC149DE8;
	Fri, 14 Feb 2025 02:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4AMHSgM"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADE38634A;
	Fri, 14 Feb 2025 02:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739498685; cv=none; b=oK1JCVJ38B1J5feJBIVeBN16apD2HGDTuAGTt1SVaEVkog0/poRa9BXh5z9IXdJQbqUc0fv40dvpoM3GFE9JswQjTYD5TdKzhZSWwdrK7aoq6tlxuCE4/LjITPyz9jfJKPUPNydc0PNssI6WBRHvR9/OD4mtH03oKsQuFaOQuSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739498685; c=relaxed/simple;
	bh=wCuN/Me1tUz+HHho8HUih2pbaQUcQ85cqSJpLlmtl5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YTG8SDx/FjbNZ/87202sZBTkHzhZ3fm8EWPpn3HAt2e1dgzZW57iLG3JKcrXNDjl/GJAShiUtDTAmcwdMD0pTjNk+r5nxWQ8GlGGm10IXAm8+bQ1Txa8X1OC0dNkcabWd6qK/CW1XSTlt4xuei6/GVY+kPgEOGnCqHkEvjucf9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e4AMHSgM; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d9837f201aso5283490a12.0;
        Thu, 13 Feb 2025 18:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739498681; x=1740103481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTMDK4W4OtyBBtTePoRW5Y8GLPQHBH4t4A9os3wpHBI=;
        b=e4AMHSgMmGRw1V2UzuuyNS8I4gqzgXmzEs+p5wC2x0H8/bCIFHBKIze083wHkmyTTo
         ebfEsdNyQ8mHWw9h5yxZ3YjjqM+aJziTfRYnujfpAa13Zy/plISVbeXW3DLcC/HrJ50g
         JeYbzndTAR4ud+bpxLRMVaaAuG5qpWm453BzltHWt5WyL6bz1KpiIVPK9N5iNReQ4p9S
         eCMqIsyEOFfeGcwot/bJZoqCucRtzTFomwYVtt76SjlccePdiqnBOqeoNqN1W5oeH0nw
         Ew/f5tGdnoNIXEFxOD4pBsGRv9eRK4R4o1oy6VfshwWfcbo2nWgkAm2/t26jje2HxFxF
         UAiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739498681; x=1740103481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LTMDK4W4OtyBBtTePoRW5Y8GLPQHBH4t4A9os3wpHBI=;
        b=com0eCQXwzwj44Dcx92ryr99S5cClLoGZrEQi1VX1AA2PyhaAOHN/Wa6WOqJVFdRpc
         Th5tqs/PEm9laHBYGyh+LNl1frACjWJd3zQR+XA0dWrNBv8Ek0j+2tdhhaT8iFCJEEd+
         n/PpBLyvmrNSW/Ls8NE3zJJUWpSgFGcKZ8rVx6gIg0U7cCcGuuM3y1cZDpNlVRLRoS22
         TowYhKgB3ORRWbq2Dg1t13YFlIcBRWZ/HE1ztm5ii/mQui7T7wwFd8Tt7gLiNinYCo6W
         U4RxfAzoR78qUcp3E1F3eNXBp/XDFBNScrhBny163F0KMth7q0Y1y7/N/5EQWJRN+Szo
         Oz5w==
X-Forwarded-Encrypted: i=1; AJvYcCVSfKxsJfbP212zTC6hFCjvj0bt1VJ5SK+id0HS+58ULOMBKnATY2g7k//H5Lz8OPapgE7351hokyc=@vger.kernel.org, AJvYcCWhx8GyoBHFHfg0GRpu33Hv4ak8siMNjeHq3yOsX+NtjyNdFyS+2jCzF7blXL59U+w0WxIMo+f8aSAJLfis@vger.kernel.org
X-Gm-Message-State: AOJu0YyRNkgvvLAUxBnurRVotJ/ZB2qmwRHD8uyDToUyEt6CrgPJeHP5
	iMsar6PM8sAM4cIgkXYYEdtQtD7Aix36zvGxq2X0Wg+wQIqrPfQB8XlOs9v3CsXVFLs6cY5ALb3
	4bSz6OImCTVquTKmjsovpTaNcLH4=
X-Gm-Gg: ASbGncvxdxYT/eKRcjPuHU+Osxu97xKBAOdHI66G8kC/52Var5wKJ4xZrMqpy3hLnA3
	htjWqYYqklC1PJ/yNOGQJhnF0D5WLFGloqu7jwo0OWrOVb+q3+lKUA7xWogGxF0qq6BSYeiPK
X-Google-Smtp-Source: AGHT+IH5PC31aulzx/QhuD3wz7AJM9yq23HvyRt3VXboNjIRtQMIKmCa29IZXfnIVNhlrIcZ1l9baBQBlXbLPSMXdSY=
X-Received: by 2002:a17:907:3f1f:b0:ab7:bba7:b758 with SMTP id
 a640c23a62f3a-aba510aedd3mr396969666b.20.1739498680743; Thu, 13 Feb 2025
 18:04:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213054222.21776-1-alexs@kernel.org> <632baf9c-773f-4bb0-b01f-cd689e0ed1e2@linux.dev>
In-Reply-To: <632baf9c-773f-4bb0-b01f-cd689e0ed1e2@linux.dev>
From: Alex Shi <seakeel@gmail.com>
Date: Fri, 14 Feb 2025 10:04:04 +0800
X-Gm-Features: AWEUYZn9sNiKrXhBwv4t0FsLcILqPrH5-uECHcH5My_caNqaB3NigLa8cpbaltA
Message-ID: <CAJy-AmnN0VeicBoP-J=iOJ74Ay0oiU2HVRssTCM5GjjS3ky_Ag@mail.gmail.com>
Subject: Re: [PATCH 1/2] docs/zh_CN: add maintainer tree for Chinese doc pickup
To: Yanteng Si <si.yanteng@linux.dev>
Cc: alexs@kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yanteng Si <si.yanteng@linux.dev> =E4=BA=8E2025=E5=B9=B42=E6=9C=8813=E6=97=
=A5=E5=91=A8=E5=9B=9B 18:13=E5=86=99=E9=81=93=EF=BC=9A
>
>
> =E5=9C=A8 2/13/25 1:42 PM, alexs@kernel.org =E5=86=99=E9=81=93:
> > From: Alex Shi <alexs@kernel.org>
> >
> >  From now on, the Chinese translation doc should be aimed here for base=
.
> >
> > Signed-off-by: Alex Shi <alexs@kernel.org>
>
> Reviewed-by: Yanteng Si <si.yanteng@linux.dev>
>
>
> > Cc: Yanteng Si <siyanteng@loongson.cn>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: linux-doc@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >   MAINTAINERS | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index c27f3190737f..dbb7f982e9c3 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -5306,6 +5306,7 @@ F:      Documentation/dev-tools/checkpatch.rst
> >   CHINESE DOCUMENTATION
> >   M:  Alex Shi <alexs@kernel.org>
> >   M:  Yanteng Si <siyanteng@loongson.cn>
>
> I have left LOONGSON, which means I have permanently lost this email
> account. Could you please help me update it conveniently?
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 92fc0eca7061..e00e0baead9f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5411,7 +5411,7 @@ F: Documentation/dev-tools/checkpatch.rst
>
>   CHINESE DOCUMENTATION
>   M:     Alex Shi <alexs@kernel.org>
> -M:     Yanteng Si <siyanteng@loongson.cn>
> +M:     Yanteng Si <si.yanteng@linux.dev>
>   S:     Maintained
>   F:     Documentation/translations/zh_CN/
>
>
> If it's not convenient for you, I'll submit a patch separately later. :)

Your patch to update your email address will look more appropriatly.  :)
So, go ahead to send a patch.

Thanks,

