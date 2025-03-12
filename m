Return-Path: <linux-kernel+bounces-558216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65067A5E2DC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 18:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 459FC16D9A9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 17:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A1C250C06;
	Wed, 12 Mar 2025 17:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3l7Po3L"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EB524DFE4
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 17:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741800921; cv=none; b=fC37ptGJLqGZvaLcJ4o4fCXvVs0hP66e2MWkwJkC3L+lHVg++HhJrrmnhVKNXXBHhzfdqYh226PP4PeAG38iJth8vqoXO5QyUxVCSsDl7VzzLvH6xvBn5zg1GEmhw+dqYvbTVEzYz5Cwh35ZPxBTX7p1p7n2sTHitltxG2axgRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741800921; c=relaxed/simple;
	bh=6itC58RDPc9+jdX4hl/V1XStffyRKyTd6Z2t1zkuSMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oM5v1awYnii7ZN+Wf3/QbyiOjBNl36c8DHirXplUNSn3x/EQ3P8u2JwKjNN61Ey11Lz5vLLCr8TPnYieeijh0SG6pYaIcGnzT3PhmbYOTH/6yPUHdD/yiYj7yTw74UOPGX+Ek8hh/q8OI+OTvFa/1VOg7dZnBDRZgG1R1KG//I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V3l7Po3L; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e61375c108so27812a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 10:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741800917; x=1742405717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6itC58RDPc9+jdX4hl/V1XStffyRKyTd6Z2t1zkuSMk=;
        b=V3l7Po3Lr6GWjJWDHxtW8Au5OXS/HULu/2DRKejCfFpuGFjAGO+MqCZYsL//CLJkig
         92kX2u7FQwc98exle2INFEpJXXjo+exNk8PKJJ8AoeSUK0tsVfHGPv4dmrl0umGF4N/S
         or7EK9FymOxNH4jP24iYLnUkgDLS1qqmlL2ZqB45drpyGxB/BNGeaUzGuDTgsA+NoyYv
         BOv421dCugm39RBJXxjnvhoMJqJdsOSQiOOdNYb5IY0nxvUjav5bwc5cFemv31f8VNEP
         agf0AgStocPMquV8LrWXdN3fYGx+orYZBjoH2Z8ZWmNsrvAp29aiRntI4X+KSSAMoO/u
         VmVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741800917; x=1742405717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6itC58RDPc9+jdX4hl/V1XStffyRKyTd6Z2t1zkuSMk=;
        b=oHFYZsjpwrBE9FvP97QAdy2gSLgEAyLbtyR297a64w/uXkLNQPC9dbiXhkeupKg3ng
         76l2Y9JES6SxLUGs62f+UcDYEbld0i1gZ5x9tVBhcOMt9ObMHDj0pYeVCqQxU8Bn2YNa
         asBnL7DaOo1UMBVnUYKgHZwlYLjpJkPXxImyhCL+3vjb1LirwfTzdnhZmDTC21qpsTpM
         3FLsQrXHBzYLeSyrqEiH/33laQ1c3bjABwgwppaOc7JJDTz77HgRsUV0oinHw6WWP7b2
         0NfOfLqK1lg6OuNFYMfOzf8BHp4gG1oonrlJ3YJ3gUZ0572twW8fPV3+RsCTFJP0OMTB
         /mTg==
X-Forwarded-Encrypted: i=1; AJvYcCVF71KQSELSwyr6SzbRD9HbvMSq/GsTO1wv8zGlUoZI1tKgELt0eiKBsLwOmxsh4rrukErzDOEYxmlCCvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxywBJxDbekJ7aOWs5qnW7ZtF0LJoH90Q1hHulRr177w59+Km4f
	u2lBA7oVN5d/mvQAxgMjw3ZDulNlSafZIgzfAAeHmNPdbrncR6TH0UPHrFKzVWUMhv50ccC+D8o
	ZArNS8s9sJrgLwCFAfLcbg4EKfvxfoA==
X-Gm-Gg: ASbGncuS7mzsiT+klvSPulrfCoyw0Db7R6ssuu9A+UzXYPMH4f81FCVNk5PR0sVvy2i
	ReIOXo6w/1lCkCBHBZKXovGA+bRUSEk5F3AE3wkHiwk3cAUpuiojdXB+YOXUQ7eIZR973+Xyq2+
	evNELOpFe8LXtB4CJPdPcTbK4PNAgn
X-Google-Smtp-Source: AGHT+IFDzeYP1Rd72+Vr7SCEfb7pdNq50IjtiFv+mj1QSr9R/2om6v0abAOf0Jca+TaJsRapGKORZ3/gIqQ5/3PgskU=
X-Received: by 2002:a05:6402:50cc:b0:5dc:7643:4f3d with SMTP id
 4fb4d7f45d1cf-5e5e22b1c7bmr25671828a12.1.1741800916472; Wed, 12 Mar 2025
 10:35:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228132620.556079-1-vignesh.raman@collabora.com> <CAPj87rMqHWtovJy82WXuJ4ZsKg3PbD7Z4hX3kzOYpUyrrdxE2g@mail.gmail.com>
In-Reply-To: <CAPj87rMqHWtovJy82WXuJ4ZsKg3PbD7Z4hX3kzOYpUyrrdxE2g@mail.gmail.com>
From: Helen Mae Koike Fornazier <helen.fornazier@gmail.com>
Date: Wed, 12 Mar 2025 14:35:04 -0300
X-Gm-Features: AQ5f1Jpu-8A8U8eE3tfSxfRNN2kIgOKjLIFWgW5B5DHqO3j2Kp8f5iiPIZ4lXDE
Message-ID: <CAPW4XYbC2nbUfRG13Jxeva+wD62c30L6Pp2ia2S4bt1XiXc3vA@mail.gmail.com>
Subject: Re: [PATCH v3] drm/ci: fix merge request rules
To: Daniel Stone <daniel@fooishbar.org>
Cc: Vignesh Raman <vignesh.raman@collabora.com>, dri-devel@lists.freedesktop.org, 
	daniels@collabora.com, airlied@gmail.com, simona.vetter@ffwll.ch, 
	robdclark@gmail.com, dmitry.baryshkov@linaro.org, 
	guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com, 
	valentine.burley@collabora.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Em seg., 10 de mar. de 2025 =C3=A0s 05:25, Daniel Stone
<daniel@fooishbar.org> escreveu:
>
> On Fri, 28 Feb 2025 at 13:26, Vignesh Raman <vignesh.raman@collabora.com>=
 wrote:
> > Merge request pipelines were only created when changes
> > were made to drivers/gpu/drm/ci/, causing MRs that
> > didn't touch this path to break. Fix MR pipeline rules
> > to trigger jobs for all changes.
> >
> > Run jobs automatically for marge-bot and scheduled
> > pipelines, but in all other cases run manually. Also
> > remove CI_PROJECT_NAMESPACE checks specific to mesa.
>
> Thanks Vignesh, this is:
> Reviewed-by: Daniel Stone <daniels@collabora.com>


Applied to drm-misc-next.
Thanks!

--=20
Helen Koike

