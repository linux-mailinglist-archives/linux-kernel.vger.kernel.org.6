Return-Path: <linux-kernel+bounces-557850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F03FA5DE91
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E924F3A4E5D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E97024BBE7;
	Wed, 12 Mar 2025 14:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtTdam5q"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2BE1CF8B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741788141; cv=none; b=UVATRMCzt/9DtNUftiBaGl9a34YlX377IST1NZTvdqufktI6LlWY4aXVB/0u0PqkUFvlc6c7rfHKdTZwR427450sd2Zfw41bU5kp9KNzZ0kTDmkl1jviOgxcfwPREh+1hnC/kKBAYF+s+vV8fvHnLtuNVewgtFkuU1MrMm+yU2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741788141; c=relaxed/simple;
	bh=437Zn3x4neBC+xCUcLE2UHJW3omN4txaE2+F70T5Qp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dtohIXyz6ETt8IG0qWdxTZLt+NB0J84J2iaex4PmmzUHBvGlfyULSqSg5YaTt7/agU8qT6xdATuJAsFSIHih7pkAgyVQZLohmKV3Epm2ylec5XulT4WHjsfuj2CKTAZa0yiv/UDKe8sfbHuXX4ryTRLDCp8YFVGFxjD1sSOE7E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtTdam5q; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5499b18d704so4406068e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 07:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741788136; x=1742392936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=437Zn3x4neBC+xCUcLE2UHJW3omN4txaE2+F70T5Qp8=;
        b=YtTdam5q3qsdhQKQLdH+GUvpiZmrVyZqYMLTioz43lIOTbx/KJ1XKw5EegfD1UuwLJ
         3RvvukH4WOAtvsIZxHDLNy+eIcDZcFZYpxkI0R5a4O5iheZZSNHHmuLcN1xUhWifWsDP
         qUFBU7jy0c6HS3/MppO/wXDvXOVkpEkIJ+fBbvNZjNPigMnlj28Sr3wUPPkHK+b6tnWl
         XpeXmjnKyGkgMjsKXh6/yWwZ5v4WgG7yrO5PnbbWtzbkDJOYHu4MrfCtfSYBK1G0VrE6
         onGN411BdikwM4jLdcW+ogNs2wFAbUCwFtNuHSmSGB4BpmyB5yQqZ5z+wuZEbSogo3p0
         GRag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741788136; x=1742392936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=437Zn3x4neBC+xCUcLE2UHJW3omN4txaE2+F70T5Qp8=;
        b=UsHxfhRFQ/GByuPNyK3RzDxJrmio0hprkTU504EoQ2urVef9FkBiM9fCj7b10rlL/3
         yIcHfyGQMhCd1R1yzvbLvB8tmSw9+KbdufgT1G2e08dPE6Yw4rRJsFHaqMx4nKXbVapd
         B4knyohnRElVZwWZ1Y8LYVtro8nJorYPHYdVQiW2+f+k1p4r4pPmIY5RTdE1pG8J3So6
         NXjZmMk30001LY5/UvuDz7QxTTwNLtCXEcFpUPXSK8YrzA5Ism6ldB70oIz+8vs284ly
         YbQdW0I9X/vDjdLqATwoHMqmA7oHOJj5AH0noB28F5oYuDEJaYjQ7sTkSI2M8VEArO4b
         Z4HA==
X-Forwarded-Encrypted: i=1; AJvYcCV8UzFogwTRFHofrvRet3IojbHiKp4ymKJUz0E28t5v2U+pyn4Vp4FTa06tNr1AMlZ64w28pGpqKNC3Otk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXblQ1OkMkAa4Dyn+6XK0phCw8YdixhOA5bEXY8taEu+MkcVLu
	wMRQhYLp6MXR8/xjafkUUaPNDVujLwOxgoUf33YK7oox9iO4DrbzdCP2wM2r7fqlpe4hN5AuK1x
	W/LWMMP7jplQoaM8VJvrqzlQGan4=
X-Gm-Gg: ASbGncu+XPobetb8vv2erITxKLnxg3Jj/4rsKwjysLdl1UmAIRA722GVQ2qxU86SK5r
	xw3d64kRq64TOC2pqm+2u4I65EHrp+fjenVSFsgtq/ALM7XoeqIJ0uAJ8MEVBVDzGJIj76W8EQj
	B0fxfzNP+xSlbdCz2spJUGW4jOCQxZbmZXoJ7FUzTEaivuL2SZ2frr+/+9dw==
X-Google-Smtp-Source: AGHT+IES9MRtVBJGIf3uaFiDmcTHRHJ1Tz/y7CI96FKA+qwRFJjbPQ679borrFKUcnbPg+cs5kYVM3GySsyQiNz0Eyw=
X-Received: by 2002:a05:6512:3c9e:b0:549:5866:6489 with SMTP id
 2adb3069b0e04-54990ec654dmr7358475e87.47.1741788135371; Wed, 12 Mar 2025
 07:02:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312111915.2970032-1-naresh.solanki@9elements.com>
In-Reply-To: <20250312111915.2970032-1-naresh.solanki@9elements.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 12 Mar 2025 11:02:03 -0300
X-Gm-Features: AQ5f1JpciHVWFRomOcoZuMN99CiqjtQxpLaObbaR3c272u59VIpf0Q44vUTW2lQ
Message-ID: <CAOMZO5DaZbRXuv4vgWk9evNcV4iW6gXy2Vjv7oWsnMo_R9ku4Q@mail.gmail.com>
Subject: Re: [oe] [meta-oe][PATCH] meta-openembedded: flashrom: Update to v1.4.0
To: naresh.solanki@9elements.com
Cc: openembedded-devel@lists.openembedded.org, linux-kernel@vger.kernel.org, 
	"Signed-off-by: Patrick Rudolph" <patrick.rudolph@9elements.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 10:52=E2=80=AFAM Naresh Solanki via
lists.openembedded.org
<naresh.solanki=3D9elements.com@lists.openembedded.org> wrote:
>
> From: "Signed-off-by: Patrick Rudolph" <patrick.rudolph@9elements.com>

This From line is incorrect.

It should be:

From: Patrick Rudolph <patrick.rudolph@9elements.com>

