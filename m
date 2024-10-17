Return-Path: <linux-kernel+bounces-369516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9489A1E4D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 11:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BB8A1C2707B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 09:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E261D90B3;
	Thu, 17 Oct 2024 09:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b="UUo66Xlo"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A771D959E
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 09:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729157221; cv=none; b=Kr84arIf/d/6sxRAYRHeMQCpx1sp0dHL9o8Rtxpt+Z3tZfieBEwpyF+0FC50AfNYxPx0/T5WqE3wI0tbJkWawgcL89Y64jlN64WV6ao1M7lffADuH2vql6QbX69UTA+u6f81kIvyjqoJVs40qFHp4PhKba8CJn3Xmh/wLoWwUNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729157221; c=relaxed/simple;
	bh=t3KxzpM4k3PmUVr58LWHbzeL/RQDf+IDCWW4NsX0sp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U8ZkYELSLuREt0M20Hh1q3yP319AvXL/Aeid0/kYS4aElHvQb9V4eaP2+37aj+WMrYRFq7l5dcxUrdRnlTVnhgZIf0isBo6FqK8XENfy5nv25Jtg53Areyo2l9TSgmFjHAbkaX+ZiLhRPI/L9rFEzsX/X/IpL4Y8JgsLaqWYqE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np; spf=pass smtp.mailfrom=everestkc.com.np; dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b=UUo66Xlo; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everestkc.com.np
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c935d99dc5so857323a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 02:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc-com-np.20230601.gappssmtp.com; s=20230601; t=1729157216; x=1729762016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mEgrYIi7WzE12AwX8CZbYs+MlkznNlBl+g/tYuRmHxE=;
        b=UUo66XloY7EGjThXlbocl7kLhsoQ+IDG7M6iVezNrnURMoJzF67VdL94qX3861wHJ0
         0PFpICWk5WpJlyyFZDWhVWXOutd82eK8n/5H0OWZtuuX1rYd+8XShKcc9SdGEZbKUx5N
         rJ9/kh8Z46LfbmhEozCrxJGzHhRHrdp9FdFDwUDrVf+MEdHZpnRdh3coybXVsbb1P418
         W1rGT7gwz+SNQuWzJTWrXgnzgvHp1AzjasZD6/K60JKyLI75thOLmlCVlH7DAv7QHtbA
         JfAFETg04wxTqCLhk9g0PkD58drx0RRsA09eWL9p2mVg2JBdeRVvf8WQlzKWwSjvkgbQ
         aIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729157216; x=1729762016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mEgrYIi7WzE12AwX8CZbYs+MlkznNlBl+g/tYuRmHxE=;
        b=l9meBivj1hXobkzBNv3zjsaoBeqJtr47J+/BCQViqWpVrJKIAJL5TeQn3sKaJm5jd4
         LIhuH5C5zQ4octPdb9JkKSYDYByARnb6ascJNUNYQo43H02Qe4chLfMKBITdyz6xqRMw
         NjQD9dHL2s5BBpH9lV7IHORPHPgS7WBq1ezKEKox540qtYYn5EDHS+VV4aAE3MDwkge5
         3VsnITzjK8jcg/fDb+92ZwlrWutFe9eIRen8eoI1LzFiJWhG43lLO/2JqJ0yMir1xkzt
         qaa73nXhJTWsdwz38DB8k/SRxOZl3X3UNIJYcGSWh0vIO/UbCmKWV2XS9F08fbKg15Wg
         TTSg==
X-Forwarded-Encrypted: i=1; AJvYcCWUZiqVQjNIWngSd0dsPUJ19ZGnkVTmbzUnVSkN0diR491MFDdoTjkEQfMmxCRKHcxo9VCyA0dz+yGk6yM=@vger.kernel.org
X-Gm-Message-State: AOJu0YykOARWq50ZbR46HhB1tLRbPAoLpfvohCJkFEzgtjiZR1ZO5ZX2
	JVUSeQZ8/+NPhnDGIB1gCUYdHGYjHOQwApwYIrNeYIAK0tLu30O5Ejj0tlbfRnAHHixPaM37T9M
	9BKQoeAvSrI/756Cee8J1lmLF25S3IyorAWitCA==
X-Google-Smtp-Source: AGHT+IHjeELE9g350Z5J7d23ep+p8aXewpY15v8XcW5jGHiKOgM7beZeK0j94PyEO8YwBr64YtJfcwCRFgDO7j1z5r0=
X-Received: by 2002:a05:6402:3510:b0:5c9:8964:bb5f with SMTP id
 4fb4d7f45d1cf-5c99518e7afmr5286213a12.23.1729157216019; Thu, 17 Oct 2024
 02:26:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017082022.16874-1-everestkc@everestkc.com.np> <85cb4aba-60ca-4fea-8d1c-dd01578357b5@stanley.mountain>
In-Reply-To: <85cb4aba-60ca-4fea-8d1c-dd01578357b5@stanley.mountain>
From: "Everest K.C." <everestkc@everestkc.com.np>
Date: Thu, 17 Oct 2024 03:26:44 -0600
Message-ID: <CAEO-vhGhjX27YUkvue7dc1tn_k1wXDT7nv4kn=+zrcK=1j-yZw@mail.gmail.com>
Subject: Re: [PATCH] staging: gpib: Change return type and error code of fluke_get_dma_residue
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: dpenkler@gmail.com, gregkh@linuxfoundation.org, skhan@linuxfoundation.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 3:01=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> On Thu, Oct 17, 2024 at 02:20:22AM -0600, Everest K.C. wrote:
> > fluke_get_dma_residue() returns unsigned int with -1 as error code.
> > This error cannot be caught.
> > Fix this by changing the return type of the function to int and
> > returning the error code, that was captured.
> >
> > Fixes: 55936779f496 ("staging: gpib: Add Fluke cda based cards GPIB dri=
ver")
> > Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
> > ---
>
> So like quite often we would merge a patch like this, because there's not=
hing
> wrong with it and why not?  It's a step in the right direction.  But actu=
ally
> in this case could you fix the caller as well?
I feel so dumb that I missed it. V2 is on the way.
> Do it all in the same patch.  It's the one *whole* thing per patch rule.
Noted.
> regards,
> dan carpenter
>
Thanks,
Everest K.C.

