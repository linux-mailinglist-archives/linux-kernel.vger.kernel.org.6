Return-Path: <linux-kernel+bounces-353112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7799928C8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 12:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E22E1F24D34
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 10:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E291C175D;
	Mon,  7 Oct 2024 10:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="BusjZvhn"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D5712E1D1
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 10:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728295522; cv=none; b=U0KP4lL2oTPjIYc4TVOXNaW4krf9WIqy70jcUaByOJ+e0JityVn7j1bXXBDsigBWY5ssLawI/EDA14J2Kuz3rnpm7YlreieVC/BlVuy6d89BaN6d8y+aH9+Xmqjp0R6YszCcJiQsNUTRQIgu/aMJlyzq8Mm09ClXU7y3qhPVcBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728295522; c=relaxed/simple;
	bh=60X5nUyAE9DrS52akUXLSBpRxabsnePVmWNJSqfHVqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g4Jq38pOX86rW8H5Vc5rVyp9wH23R9RvddiRGkIohqSFQgASWwsbutLew3A34mQQ1ZPEetQLvOTbqPAFy7SSC4XAocJiGu8iGQkn4lElsZvlCmjHdqFjBWwM05zIF+o0s5rCAip+Ff45ZPXYu289mplpIyUSnr88r/fnjVJj9WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=BusjZvhn; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5389917ef34so4710934e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 03:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1728295518; x=1728900318; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=60X5nUyAE9DrS52akUXLSBpRxabsnePVmWNJSqfHVqM=;
        b=BusjZvhnpQ+pE6LCNNDzU8CKH67hwvr3bhWzgM3pc3NZW9sxcvyHp2mejs4G/6urkr
         jPbbJsRcpvOFX7OZGbh4OlWuqmHObw1K9G70klCADV/Aiatn49VBwBirqb4BcwwLPDfH
         8FWVjXibpnIa/fsZUnFrHh7fgtvgvUmcWC/Ew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728295518; x=1728900318;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=60X5nUyAE9DrS52akUXLSBpRxabsnePVmWNJSqfHVqM=;
        b=pn2wgx0GkeZDNRfdl7neygxorKUsknrxeiY/qB5DgTclY6guazF+b/CVIqNBNyCu6f
         MKm1T12SaRxx3Zit/aEmu+EdbMuLs+0uUMgH279s6tjSyHNcLBeRH40GZqcXSmRqCekW
         +EwW6C5CElZcSS0YOTnJLOy0w48TzkodDYdSB2G7iy8ey4vCm2Z4zg1pYfL1L+jmlSET
         r+Dpx0ZPMh2kHekHITGDgUSEuN4GX/VNIqMgfWQrurU0uSaILFfRSkeajikbvz5X3oAh
         Qg2vPHWagkCBvYbl5HnxixtoMdKeq3GFex/Vr5MYL1A+CdQ3Gx/VO7z3KZ40u3UmM6d2
         M2Kg==
X-Gm-Message-State: AOJu0YwGENZQb0v48JnK67JxRBucnZjiu4vL3gAfN8+1s7HyYRaaulnF
	mFFIeVb8dFC3GNbaldFsI1TC55bEr4AXiaetgDZ7x3YzexoEtPjQQ+iXpj3S41qOFcBq3SD3zCc
	VsnkeUDw8l79GYiGg3NapdMpV49zHELNFwb7Csw==
X-Google-Smtp-Source: AGHT+IEMCR/7S6+NB65Ewgm85Y27kXieWu5X6dcSByOH//2ik5TJFm6oU52jizX6aN9ixkQGjMbaeNJrse8KTg0/+zE=
X-Received: by 2002:a05:6512:b9c:b0:530:aeea:27e1 with SMTP id
 2adb3069b0e04-539ab9e6cfcmr5778643e87.50.1728295518265; Mon, 07 Oct 2024
 03:05:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004182200.3670903-1-sashal@kernel.org> <20241004182200.3670903-45-sashal@kernel.org>
In-Reply-To: <20241004182200.3670903-45-sashal@kernel.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 7 Oct 2024 12:05:06 +0200
Message-ID: <CAJfpegumr4qf7MmKshr0BuQ3-KBKoujfgwtfDww4nYbyUpdzng@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.10 45/70] fuse: handle idmappings properly in ->write_iter()
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>, Miklos Szeredi <mszeredi@redhat.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 4 Oct 2024 at 20:23, Sasha Levin <sashal@kernel.org> wrote:
>
> From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
>
> [ Upstream commit 5b8ca5a54cb89ab07b0389f50e038e533cdfdd86 ]
>
> This is needed to properly clear suid/sgid.
>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

AFAICS, this commit shouldn't be backported to any kernel.

Hopefully it would do nothing, since idmapped fuse mounts are not
enabled before v6.12, but still...

Thanks,
Miklos

