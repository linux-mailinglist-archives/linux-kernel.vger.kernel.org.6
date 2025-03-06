Return-Path: <linux-kernel+bounces-548564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBADA5467D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0ED5172A0E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8554820A5F1;
	Thu,  6 Mar 2025 09:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXEicXM7"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EE1209F22
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 09:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741253880; cv=none; b=WdkkERUnIZJRPiBURBmPGYWt8Zj4yTYQWFoP86Y+Hy+SvK9YMHW8V0CSAyyKedrogwDrMwXNK2TQbWmnNXLWsOPg0rBlT+j7liDJ8W7iTo8uRZ0MCMctMq28oJPbMq/HLlhU9uVdQcvIC+kpPJGDfXeWAh4lqvXcdTjqXWCo2/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741253880; c=relaxed/simple;
	bh=1CM9QlPaK2Mr90DGYSdi1aINcfuQOOCHlPTgQsO+KiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tkOOfeqwdmS1DsUtwCBPgTqR73uPo5j3Qik3VtqFStpPPQ7U/DeouIXZWy5oKiqVj+D76MWegANwIIE28fkfE3oah9VJ21ZOKa9qxZa6sX5oZTuTMqmTfq3i12JZVfc2Z5NR21RI00pJdiSzBHhiwfVQJLTairkEefkI7vQI9ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXEicXM7; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3f67508fc3fso134661b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 01:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741253877; x=1741858677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ly4DUe1eU6957OuFSZ3eXS3BEy7ZnbSJGPgZO9Zt0qk=;
        b=nXEicXM7eAmXjam0mLqGNHdgEte06Zm4qJFH5ivf/qwkHyV6+Sfbj6/PZiULz39shw
         dQEiESH3cG0UH8GeETxuDUcSAQLqww7y4JQIg6kbXleYNQ/Pn1cdWnlEMToTzXEqmddt
         7jg7UeAx98PHwPsvBVyEmFRXTNz6C+4G+H+mL9Psz3g0rEl2W+gtjdxNq1LPwrBjW/4U
         hsuSuCqck2B4BRLRKoz7pHhE7xTLbhjR84aHK3eJH0tqnbu2s7Ef2QvqdzefJuHCqLaX
         Hvh3U7QciTmkvvTytzMjoOvJQV1GfoD2ksHfEqdZWmd9406b+19+qVu70WTQsxKw3j0R
         vcuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741253877; x=1741858677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ly4DUe1eU6957OuFSZ3eXS3BEy7ZnbSJGPgZO9Zt0qk=;
        b=qoJmMYBPUMUqMu0v1ODxlp9Oom7G+TqEog/ZuG8SJD3Pa79ZIBl0cHd9pRQtUcug1V
         aqjb+8fzu7KKgyYsxDUwewRGBd4neizdVURMYOhFDOGoeHt1WwwCkNQZNenCSJiU6F8g
         +vfNrUVS0lzTFMIJ6SzVAREbpLsoaaq9G9Z+iC6ZIWymDQ0zlNR345/oDWtlYEQII7bl
         PjTl9PLFCg0pyufH6iB6SCApzuouvjJCn8JCo8c4nUQYeGp+C+gJZTOub84ezttggezC
         SAFkIkE0ns4tD6BmHqg5UZGdrdkJRsc6xtqypzafylamYqd/z3/RYCvpcKQx9gA890IW
         KzAA==
X-Forwarded-Encrypted: i=1; AJvYcCXL4jRJbYeBfzwQufFYtD9voKFXWPrBrXHV+mnyyzhfcEzDUC2SkCEy96cPRLKXfsIfJzHVvG9+lvpziog=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC8XMENZ3qTiVWLUic7dctB2udXW2zek0OOYdjTSrmdW57LgBE
	7WDlmdPcg4aWEuNOVKN5il5Nh7tqjgE4IFz4zBfVErbTosZTGNqjKjUjtUvfMrUhi/EGQC5VIgc
	VPjusyyX+/iPyz3tqxUILpzWUjVc=
X-Gm-Gg: ASbGncsSm6ejlxNxrG1CC0jMqlJT3rEGUzNJhGXYCqNrcC8duKNrnShJBwL7y76V7L6
	fF72qKubJ44+BivH8lWhNJpO3twhQQyOjL027qDNQuobR79UeBNwS7l6r3963+zhdcWLjIwKdTC
	nTFX33KA5Jg4rdtFZgt4iKUaWh
X-Google-Smtp-Source: AGHT+IH2qoeCbMEwg0LuMk0rNhe0HnPjQOgBA6M22Fis4lXVJxP3n/tAQ7eCBTbfgxGvZE85sTDxaOzL4aO6krM9OGw=
X-Received: by 2002:a05:6808:2384:b0:3f6:7d8f:63e1 with SMTP id
 5614622812f47-3f683214aadmr3140491b6e.25.1741253877301; Thu, 06 Mar 2025
 01:37:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305084911.6394-1-hanchunchao@inspur.com>
In-Reply-To: <20250305084911.6394-1-hanchunchao@inspur.com>
From: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date: Thu, 6 Mar 2025 10:37:45 +0100
X-Gm-Features: AQ5f1Jq-LTLZ0dJ8bro4RfPbulbLn2H-ocB-6Y4LD68OracOtht3dbXXHPUJvAE
Message-ID: <CAMeQTsaQQoVQB8WBdQngeOFU=qXF-ajn_0SAOQJhuzk7EL3K6w@mail.gmail.com>
Subject: Re: [PATCH] drm/gma500: fix inconsistent indenting warning
To: Charles Han <hanchunchao@inspur.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 9:49=E2=80=AFAM Charles Han <hanchunchao@inspur.com>=
 wrote:
>
> Fix below inconsistent indenting smatch warning.
> smatch warnings:
> drivers/gpu/drm/gma500/cdv_device.c:218 cdv_errata() warn: inconsistent i=
ndenting
>
> Signed-off-by: Charles Han <hanchunchao@inspur.com>

Thanks for the patch.
Applied to drm-misc-next

-Patrik

> ---
>  drivers/gpu/drm/gma500/cdv_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/gma500/cdv_device.c b/drivers/gpu/drm/gma500=
/cdv_device.c
> index 3e83299113e3..718d45891fc7 100644
> --- a/drivers/gpu/drm/gma500/cdv_device.c
> +++ b/drivers/gpu/drm/gma500/cdv_device.c
> @@ -215,7 +215,7 @@ static void cdv_errata(struct drm_device *dev)
>          *      Bonus Launch to work around the issue, by degrading
>          *      performance.
>          */
> -        CDV_MSG_WRITE32(pci_domain_nr(pdev->bus), 3, 0x30, 0x08027108);
> +       CDV_MSG_WRITE32(pci_domain_nr(pdev->bus), 3, 0x30, 0x08027108);
>  }
>
>  /**
> --
> 2.43.0
>

