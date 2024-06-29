Return-Path: <linux-kernel+bounces-235072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3114D91CFA8
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 01:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDF622827FE
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 23:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8263543AAE;
	Sat, 29 Jun 2024 23:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4JuMqsc"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C36A39863
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 23:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719703143; cv=none; b=hVOVsKfQHv7d4PxL1GZCB4/wi9XAGvK1fQrfjr+El5SPoavtVQhxZ++3eB/Bb9Uxv1ZqDaAy7nV1BbFqA10qfKSeesLshoebNyIF3zAfcKtfUCPn3rBF9QYIBhX7DYuJ/Q9u1VeqGfo9NzYcBOrj5MQwqnPb+Ma7b/+R4CFO1ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719703143; c=relaxed/simple;
	bh=FNv8/W0W5mKgnrGfxxg0WoBrrHGpsq48w5EU6tbPKHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YX5r/LiFLBp5rivBw20waHqEPkvqSlgVXhKaSWXJULEOpLwIp4i/UsGyCYdUh5FDeIuDi9OBJ09rysmfJ7nQnU4XwZVBNWc94yC6iSvEoW6DdaLbCCmm8FP9hs8q3hB5Yw8SPlIZyX82AwExz/4L+ZTES5Yk529sTFiQDRQtatw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J4JuMqsc; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6b5415b80c1so1759186d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 16:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719703141; x=1720307941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XroRg26Q/56W42BWJJi+I1OGaZL3CPZqLZHzczquNHs=;
        b=J4JuMqscv6iAaADSb/4yO+wKng6TtJsJVmh9U6Uhm6+tvdmiCQibLNSB7iOgz/t6z8
         ZB4MBje/CEtENh+74b3OYnZo7fVWeiAVlic0nB0FSQGIb9kkZB7w+s3F3OaBOYJCAeaI
         avfALinz8NYuNZYS3HNk03qaneiG7xqwEHJ5atXllGBw8sAboiRYwASXgd3Lbe4UfpoC
         sW9551SMeWXVPSmlybytTea7NnySvVeQw3Y0cfDczXrdvNG363CKs27CouJKAIzKuuUk
         sn2IBx/nEfnaIUXxZslnGrZLov02C+NyUbj2DERRT//BEb+WftMZSl8iSsR8Oh1Ricfe
         3UYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719703141; x=1720307941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XroRg26Q/56W42BWJJi+I1OGaZL3CPZqLZHzczquNHs=;
        b=CrFNhhP2gkdA2xx/hxLwipcnA8nYTJWEyrIOEf/JQ/Ov6U7VcCmsR/KTn3Lf9KIwI/
         ninTgXm51ZyJuQvoy5EirQcxM2Ry5QzK5N6rpthD2WY4fE5us5qgvCT5gucql2RDkWdM
         pfvBdTJkIs3VAmMzymlbj3tNoh+oceZ0mC5TP8xZPH1CjsvLE5FfH4DhLB0JR9xHcIbk
         qnurvfYsFwl3Fb3kHfYEkNrs6bp661p1LArJtFoJBINGawdC3sFw+Vx1UNz3FAd0Ee2+
         zPkQGN7eMsuVrUyQ443ImiaptD7sNENkRY7shb3djaMGnQ0iAFGq+VCLvQRIeO38QSvO
         ZVkw==
X-Forwarded-Encrypted: i=1; AJvYcCXeUXEzClVQWp2S9eLMrZA333Npw8CiRU79ojOcE57j0b/qloaVrzs+ed7ot9FgYS51Mv9mJcZUrPxdWdFpbWZO97pvfg6jRjTK0tlJ
X-Gm-Message-State: AOJu0YwpSzdm22v/4qA37KZHC5xf6goPUM4kFRm50bjPg3JMGBRrkOWr
	Q2c0+VjZuUD+S/QcayDkSSCw2y0HjoVnp7wHRBgghSlYNL6iXMkJxMojD6iU/HZGcGqdlDYcE+t
	ii25bI3oP4ahhki+aFQ5aVVcJxek=
X-Google-Smtp-Source: AGHT+IGhxpyC1sq9wMq2Q8/QZ9d1fuFaSnh4PKaVqBVKSUiIvqWIae53ZCaOAlyNYIk/opAz33KCSq9czjF9x4ULey4=
X-Received: by 2002:a05:6214:20a3:b0:6a0:cd65:599a with SMTP id
 6a1803df08f44-6b5b70a3951mr22698716d6.2.1719703141242; Sat, 29 Jun 2024
 16:19:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsNptxsQO=5=qi-JYiFX=rX8Ok5inK80Gn0qrUFWbtBGng@mail.gmail.com>
 <CADnq5_PDxJ8O1JUQ9RBYRFB9G1WZJos05ZAM4jUKuPBwPxjNkA@mail.gmail.com>
 <CABXGCsNN9LwHc2x2AAEH=5UNwpvkWkBqRYz3OP8MZ6Woy+HDXA@mail.gmail.com>
 <b6c440ca-e63e-429b-af41-5f27d4b8b2a2@leemhuis.info> <CABXGCsNoFfMn7LaqqFgEPg-ECyUPN=f=SXVrFi=GZk6c69-Gqw@mail.gmail.com>
 <CADnq5_PDSkr4hOHJmb1J30UC0a7sXsm5-TPkEmjzffMK_A+7ug@mail.gmail.com> <ea465a40-f673-42b1-8b1c-a2efb20cd562@amd.com>
In-Reply-To: <ea465a40-f673-42b1-8b1c-a2efb20cd562@amd.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Sun, 30 Jun 2024 04:18:50 +0500
Message-ID: <CABXGCsPyrUEqDq2gbr4VLw5ncd9cKoCZ9nOr2SRfg8Lh=9H5Kg@mail.gmail.com>
Subject: Re: 6.10/bisected/regression - commits bc87d666c05 and 6d4279cb99ac
 cause appearing green flashing bar on top of screen on Radeon 6900XT and 120Hz
To: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
Cc: Alex Deucher <alexdeucher@gmail.com>, "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, 
	"Deucher, Alexander" <alexander.deucher@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, 
	dri-devel <dri-devel@lists.freedesktop.org>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 29, 2024 at 9:46=E2=80=AFPM Rodrigo Siqueira Jordao
<Rodrigo.Siqueira@amd.com> wrote:
> Hi Mikhail,
>
> I'm trying to reproduce this issue, but until now, I've been unable to
> reproduce it. I tried some different scenarios with the following
> components:
>
> 1. Displays: I tried with one and two displays
>   - 4k@120 - DP && 4k@60 - HDMI
>   - 4k@244 Oled - DP
> 2. GPU: 7900XTX

The issue only reproduced with RDNA2 (6900XT)
RDNA3 (7900XTX) is not affected.

--=20
Best Regards,
Mike Gavrilov.

