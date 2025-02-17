Return-Path: <linux-kernel+bounces-517005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 756EAA37ADE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 06:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4A10188877E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 05:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135B8183098;
	Mon, 17 Feb 2025 05:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2HEyxN/"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9EC286A9;
	Mon, 17 Feb 2025 05:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739769882; cv=none; b=aUZxuYiQsk3jIG/HspSxxCy6KWFHI4RSnGtGYbxp+Z9UeYAQ3uJUzrkanNBt5/irepoFSJEEMEHz1cuwhUvZz6ezgf3KsDDILZcTMbtUKZf6znk/hm4goV0np7OTCcIdsCRB732c/A/Se+XLlnHRReGG/+w6sERi87dtGIrzmxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739769882; c=relaxed/simple;
	bh=EpiuTHpy+lhzlv6BfpU6PsMtbvloAlyuxmC7C9PtPC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XtaJzwiqcRd1beljx5Hn1m2MaUcjWMLFal+fVrwT4UdDmn/mxZhY/Rosg6tpSGE/K9/Vd4GxT7NZw/kv0Hcwon6hCf1jieXJBnPLq+OZ3NXTAdqcZR4gkEugLWNfbHotQBZRbSAFLkh/RKU95zaXCa4HLsX93ygm1q2Nky8lRGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2HEyxN/; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-abb75200275so213673466b.3;
        Sun, 16 Feb 2025 21:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739769879; x=1740374679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Og4gkd6LlM97O1HKuLnn2cCfC/qib/MYrhkHKRgHoFM=;
        b=N2HEyxN/ixII5b4r0oacfjFNBmQikCyIDUqADNBxtJN9dKFhaNasKFuREXWWsgWOkh
         aoCvxI+70q9GO1pAGg8klilzep/a8ug2p8dGBQXKMC53KIKZxxTS/R0wfKHDLjByVvN3
         yc282mKsAVGiUf/EDFTtkvOBcG0Y/85y1UaeJnwCCGgzTTxHCLs1fhJXRFepvLjpkpfM
         UnTad2cm6E9mI3jvvVdVi6r5k2IUnuPjyNg7cpPlZsXNjTnFmHsHeaesn9F7HFW9IZXL
         3qaOI9IU61wb2JMSy5IBvI5VLmUKxUu1/Yo8flbW8y6L0YpolaU2NKxFw3xSj2Y7FZbr
         +NeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739769879; x=1740374679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Og4gkd6LlM97O1HKuLnn2cCfC/qib/MYrhkHKRgHoFM=;
        b=aBLbu2MW4xomxskWcZ6VLu0SYPbMrKA6oEqqtIfkqN6VPfxrHffZ+Jj2PFKWaVhjvS
         0IBQfl5GhDKsxMktOx/fWdOH9HRUG5K/GLUKJMLEV8OAlE+FIJQnfDANRbp06+L88NX0
         7aOvJ1WURUyC7gBNXj+Bn2iOAOCauiQX0iX9tn5Rgw9/sL0p8uWErZL2AkeH5iAc+VGo
         gllRwdDUxVOy5EA39vuDnsKDQx8/P+YcKCModOE/XR1OtwqALMkf/iPX6unvyC7yD+8R
         c7bzjn3MX9+s6w5LVjEApiniK0dziWdPsehZt5rCo7b97AOEuLMrvOKzUbHX9VEfd932
         +RGg==
X-Forwarded-Encrypted: i=1; AJvYcCUN8TfjaToX5R0YujDLSmC+OENNXWxIGKM+Y/q8Jl7hlN8HNYRwqPsq8EYM8p1Pus5j+l+j13QXjhTYWK/A@vger.kernel.org, AJvYcCUXAB4GDghem4wMP4jedH7LLNhlqGNP5zTo7FWPYt5cAM0keuK9yVLKME3yJuE1oeB3ff707mMGmfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsSI7bgKGeZuSICx+iFWAu5Wwr2Kj5OmcpE9U4o0PfZeQlpqzm
	Himir3ssOvIGPUnEnDnGiE/uuj+sImbTE+Mn5PZgHJlmVF2B6IbHuQVmW/yM3oHG/SSNJWZTTgm
	BS0hLBfvHG7JBQAPbdg8HznhnZqQot+X50Gc=
X-Gm-Gg: ASbGncvuH+w2bfNuwb83OwcBgjc9fzKC4JRIUqGWjK2imxpPN8yV6UVLExoyPtP+KIs
	FiiH/MoS7zLi64PZUx3NA8v6ckjRTqOFhUQhl5z7x68qHvvF2THHVPOXP2nDN+d6vOizyPVLg
X-Google-Smtp-Source: AGHT+IEKu9BHznm2nWjeltvYW8C2vbeWdIhPrIfCSI2piAnQW2LJVGvulFY9G9DKNTYng4XT+7bt5yspJnXfpDHagUc=
X-Received: by 2002:a17:906:35cc:b0:abb:9d27:290b with SMTP id
 a640c23a62f3a-abb9d27296emr168081366b.9.1739769878821; Sun, 16 Feb 2025
 21:24:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217043109.3571459-1-dzm91@hust.edu.cn>
In-Reply-To: <20250217043109.3571459-1-dzm91@hust.edu.cn>
From: Alex Shi <seakeel@gmail.com>
Date: Mon, 17 Feb 2025 13:24:02 +0800
X-Gm-Features: AWEUYZlDOlUL96iDUlmSUNDubCeTxu2w5O8aaGgO2gWO2E26e4nETyN-Z0ZoZbY
Message-ID: <CAJy-AmmPtqJpw9KeRBQydMyMtnFWW2uqmdsSXFEVm35an6tmuQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add reviewer for Chinese translations
To: Dongliang Mu <dzm91@hust.edu.cn>
Cc: Alex Shi <alexs@kernel.org>, Yanteng Si <si.yanteng@linux.dev>, 
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dongliang Mu <dzm91@hust.edu.cn> =E4=BA=8E2025=E5=B9=B42=E6=9C=8817=E6=97=
=A5=E5=91=A8=E4=B8=80 12:38=E5=86=99=E9=81=93=EF=BC=9A
>
> Dongliang Mu has translated a substantial portion of kernel documentation
> into Chinese, developed scripts/checktransupdate.py utility to automate
> tracking of translated content updates, and actively reviewed patches.
>
> Thus, add Dongliang Mu as a reviewer for the translations of
> Chinese Documentation.
>
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 25c86f47353d..ae45135deb9e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5405,6 +5405,7 @@ F:        Documentation/dev-tools/checkpatch.rst
>  CHINESE DOCUMENTATION
>  M:     Alex Shi <alexs@kernel.org>
>  M:     Yanteng Si <siyanteng@loongson.cn>
> +R:     Dongliang Mu <dzm91@hust.edu.cn>
>  S:     Maintained
>  F:     Documentation/translations/zh_CN/
>

Welcome! :)
Reviewed-by: Alex Shi <alexs@kernel.org>

> --
> 2.43.0
>

