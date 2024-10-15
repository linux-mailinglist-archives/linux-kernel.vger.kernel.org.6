Return-Path: <linux-kernel+bounces-365985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D2599EF03
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 16:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DF741C21FC6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485FC1DD0C3;
	Tue, 15 Oct 2024 14:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJSfsARD"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BD91AF0DF;
	Tue, 15 Oct 2024 14:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729001464; cv=none; b=MGOS84mVSe5E3fkgpBg/VZyYBj6XP5Y4k014ERtycX14c/ttnBYo1ggadtJrCaSgR/7EpqZp/f9dAGZZrxOIZAitwCHlemYL50ew43GAGaluyQejYX8Fvi1VTFCwyPDga+WdjjY5USnD1G4eYRd56nlTD+S6ivWoj1zYUjv83lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729001464; c=relaxed/simple;
	bh=hFYqIA0hGGtzf239HaOGXHnxOyrXYhfyUMPpWEoSETk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lwX0wYls6um6sadOmC+4ISxCWM56Gij8eQgcuNIuaR5iffPjDeXw+UVBb0fn5v8kPUxzvprHNtO7sQoXe7SaNDBQ2b8AzmywFeBGS1Qt6kj58CLreImwaHHAp0zrgWgw4zdt9uiVV4iiQfk/hEfX5+k3hEQuaFppgOc+G+M6DQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJSfsARD; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5d5eec95a74so2477832eaf.1;
        Tue, 15 Oct 2024 07:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729001462; x=1729606262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yU7SIHnP46WmT+FWC/zVEM9bHxNRFsvDbjjWknoaYZI=;
        b=BJSfsARDf4pDkrs60VHBJnLZNt+fGQ7fQBhAKMMy4//21rlU9hSGDhnkus2mXgbY5C
         wqnH8UKp8La+Y4EwCIGuXOEV+3vzntRnOHzs8zczsvoTZL7+HObE0lAoFOtygVJdSCrY
         USYwPEODbsv7J2giL/L+8u+07g1rFGHsBXdIAtiNobBLSzaDeM2k1vwgiNuHINgwcQWl
         ZzxFyskoHPVqWNZFbT9xPLNt3BKeaLbZczIdJc83PjINUY3Kx428wn5imi/fbrkbrPdz
         HCUdLgcZ4Qu/9E1G3APD8ss7Vv+TFO0WLfdG85u0SzO4CuzpjuZ1+xvYHTg2Ku5cwfT1
         KQ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729001462; x=1729606262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yU7SIHnP46WmT+FWC/zVEM9bHxNRFsvDbjjWknoaYZI=;
        b=TcoVYOcF8Ln7FCfNyHVUPgzoHeIj6FA/rvfgYD7OCD0v83YQfJ2IBUhWoA+n2BeF+U
         a6MxMxC/2JZ/Ba8EHPNWMSDtzj30uBnuPxXFSEipCQ7FiUKF1o8VFVn25W9nKT9ClSEh
         KkNc8LsLb9jgL08EAECASNbu77KwCmbH4E0gLl9Grf2UAOpdrSUeJLVZt4HJ7rdC4Qtm
         wa8ult5SXtYs6OtnNl8zSNH7nZgTtmtUZAH1Hj3vWG2E+gnxqDll+erxpUSSn71zoF2e
         T1yM1c3r10v0q3eatHuqB4G+VlGcoPAGXnTlQ1LUVgJ8MTx8N5ukk6SPNnGuR2fQ2eF0
         F5Mw==
X-Forwarded-Encrypted: i=1; AJvYcCVyiVElNsUtqvSkQGa21Kxul9t0TeqlnvB2UBNEoGC8fdtAwzUOP3SuyvLW5SHoo9h+v305MEL1L1gH@vger.kernel.org, AJvYcCWtlzD7/QvBULv1CRPRTr44BquhMLRz+I91AqbD7WjW526fDfT7I5BJZR9kYfwardnCIdy45LjskDofxWpE@vger.kernel.org, AJvYcCXgy4jkNMn4Ivw81yIcxGh8TzXyxecDbcrKRojhss/8SApi7YByIxWH+c/zj+bJvy3TclTCO5ZHp58=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz5HENpd4JB4glndvqARRTA5TaEqTgXINHbMMVdWgwlW8DPgeN
	xvvvxNyNOpkbFzxLxRQLPhaPui+PLaZyDKDLdH6g75cD9LFqUv344vxIa/gW+DKY/zkiy9V5+E0
	A/HPREj3caKjHbtvBH2UHnUwodMo=
X-Google-Smtp-Source: AGHT+IG+aX9tgn9yna2FiY5Sm8AUzbZwsX8KxALnzkDdrtouHEhubIt7dztuPzDYw19in5mE73KB9z9keGZs1cEZkJ8=
X-Received: by 2002:a05:6870:ac87:b0:288:666b:9c5e with SMTP id
 586e51a60fabf-2886dd70e90mr10741729fac.17.1729001462320; Tue, 15 Oct 2024
 07:11:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015140159.8082-1-tttturtleruss@hust.edu.cn>
In-Reply-To: <20241015140159.8082-1-tttturtleruss@hust.edu.cn>
From: Dongliang Mu <mudongliangabcd@gmail.com>
Date: Tue, 15 Oct 2024 22:10:35 +0800
Message-ID: <CAD-N9QWdqPaZSh=Xi_CWcKyNmxCS0WOteAtRvwHLZf16fab3eQ@mail.gmail.com>
Subject: Re: [PATCH] docs/dev-tools: fix a typo
To: Haoyang Liu <tttturtleruss@hust.edu.cn>
Cc: Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	hust-os-kernel-patches@googlegroups.com, kasan-dev@googlegroups.com, 
	workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 10:09=E2=80=AFPM Haoyang Liu <tttturtleruss@hust.ed=
u.cn> wrote:
>
> fix a typo in dev-tools/kmsan.rst
>
> Signed-off-by: Haoyang Liu <tttturtleruss@hust.edu.cn>
> ---
>  Documentation/dev-tools/kmsan.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/dev-tools/kmsan.rst b/Documentation/dev-tools/=
kmsan.rst
> index 6a48d96c5c85..0dc668b183f6 100644
> --- a/Documentation/dev-tools/kmsan.rst
> +++ b/Documentation/dev-tools/kmsan.rst
> @@ -133,7 +133,7 @@ KMSAN shadow memory
>  -------------------
>
>  KMSAN associates a metadata byte (also called shadow byte) with every by=
te of
> -kernel memory. A bit in the shadow byte is set iff the corresponding bit=
 of the
> +kernel memory. A bit in the shadow byte is set if the corresponding bit =
of the

This is not a typo. iff is if and only if

Dongliang Mu

>  kernel memory byte is uninitialized. Marking the memory uninitialized (i=
.e.
>  setting its shadow bytes to ``0xff``) is called poisoning, marking it
>  initialized (setting the shadow bytes to ``0x00``) is called unpoisoning=
.
> --
> 2.25.1
>
>

