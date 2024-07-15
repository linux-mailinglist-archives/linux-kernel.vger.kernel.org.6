Return-Path: <linux-kernel+bounces-252641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB14F931639
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 15:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 541F11F225EC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 13:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A2318E752;
	Mon, 15 Jul 2024 13:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BnhQUJyj"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0735C1741CF
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 13:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721051864; cv=none; b=JQY1R63uvi8rzgaWUtSFWjnkaX1HmMYT/cW3RTvhFBV6if0JBIpvojJ9CNaK5uauslhKdNE2tTjXJeW3/WRwki/A4r3nFXiW29BuIglRmh/SaJBbXsC6mQ8R++xxgDq292sK8++Dmqb0rxEoZORBRTgf+S1wwpe8GA/JXy7mvUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721051864; c=relaxed/simple;
	bh=LeSbYsChuw2CItwmR6vaX8jj0UmWfZW+UKjzYxTCTew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rzlC1Y0ET/+QM7HIsjBAjyLHzcNW78Uudj8BGSw3o7QIlFOFFjTWnhB216sU08s/Aov9/GH4X460ZMgEkwiLrktNHCf6mv6apmaGdSu326xrQKRnBbAgTw630qH7VW7XMMkZkc8k683c7kAdVoHPjfsknjAlS5VC7VK/VLb0yDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BnhQUJyj; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-447f8aa87bfso588721cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 06:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721051862; x=1721656662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1IdPkkbzvH/BAaWYOMPmxaCglX4fyw6oCXKUAhpCY8=;
        b=BnhQUJyjHg/mYl489BH9KNKNsbXAda1BG8p6E6XfM96Janb1aMHbKwgSMvR621fev1
         NC2FN7NszGV2gzjGZndq5lId/77iVUBeucwb2srWMFml8biV6KpHFDfp1v933eM9JKQb
         Z2I5Ile0iWnq2whEBrFrLbaDFwH5QPKTKYvU1L0mW8EJjMB0UxskFupnlezXi+22+K6G
         Ho0SvL/j0XqnPVLgYp3JXq9aL3bD7JLB2/IGDZCKDw6/n9MwtJt5qf1+qHQXKJwEzetG
         V0Akp5icvAnqFf4DYqlCImzTSFnbsqWfTIJccpblK1Tr038+q+roX1kB1XAd6g3MnutX
         pTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721051862; x=1721656662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S1IdPkkbzvH/BAaWYOMPmxaCglX4fyw6oCXKUAhpCY8=;
        b=d//2+VQBGSHLgMVDSKa7z2sjUDLb5LmOnDXIrCD/Krp8y1TDn+R5mVjxghCSmKAuyI
         V8NJqBwNbz+9Z5Ohh7qna5ruKInAcF4aPRrCKcBeGjOeC49zBBcwGHf8H0FpL4cDru77
         AKjmBoXi1qVGd7QEOHbaA11QMbG+9VtAnsa4LQ01H9tJw4YdzRoTZJC2nxlo6XTkWTwt
         o2zajLgK2/LrYFfWCW76tZKVb2LA3xzXvqu1BPIvu/w0suNHtDrC0do55KQlN53n5u6Q
         YscB1q9zSGzbr4b2nSE7n4waVpkQRozdhpAF9On6Sl8EkY6eytZF55ieDVKrpXwTUwn9
         fYyg==
X-Forwarded-Encrypted: i=1; AJvYcCWBrq1Frn0LK+0foVYayDanGfOj7IkSQ7doLnuDD1iR0iVAZzMfQOg6B1cIaBQYfjhwfehFUjlfBVgkT/aB+ufqHs6kxWLR7ofT8hv5
X-Gm-Message-State: AOJu0YyTiqwhwQBuSHwFbEti0/Pp/q4qgxgxDSEZO51nFeijHfZ02JNx
	KGBZqeMkPhMqnsfY2cTRmZ6IPBtv3PDU1sf0edeyVFfa2k0KMHcxZh5oXxaceYJQzLHeYmrJYGv
	C34fn1fuevjL3h9Nnt63ZOZJP06H1LAeLsJs3
X-Google-Smtp-Source: AGHT+IGLMm++Rq6uGcsEbcNXyU9MTIXd9G9Ph8BD4BbCN85VisAAtiYu9NsxCDZ5vogpBxxIaa7coN2dNIuSqgYEpqU=
X-Received: by 2002:a05:622a:298e:b0:444:fd8a:f1a0 with SMTP id
 d75a77b69052e-44f5acc840amr5520031cf.25.1721051861734; Mon, 15 Jul 2024
 06:57:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715031845.6687-1-lvzhaoxiong@huaqin.corp-partner.google.com>
In-Reply-To: <20240715031845.6687-1-lvzhaoxiong@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@google.com>
Date: Mon, 15 Jul 2024 06:57:30 -0700
Message-ID: <CAD=FV=XzWvvwsRrXDCdx_fLZkTLc=CCREDYt1gSmrOtN-EBBUQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/1] Fix the way to get porch parameters
To: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Cc: neil.armstrong@linaro.org, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, airlied@gmail.com, 
	mripard@kernel.org, hsinyi@google.com, awarnecke002@hotmail.com, 
	quic_jesszhan@quicinc.com, dmitry.baryshkov@linaro.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jul 14, 2024 at 8:18=E2=80=AFPM Zhaoxiong Lv
<lvzhaoxiong@huaqin.corp-partner.google.com> wrote:
>
> The current driver can only obtain the porch parameters
> of boe-th101mb31ig002. Modify it to obtain the porch
> parameters of the panel currently being used.
>
> Zhaoxiong Lv (1):
>   drm/panel: boe-th101mb31ig002 : Fix the way to get porch parameters
>
>  drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

For future reference, if you're only posting one patch, there's no
need to send a cover letter (AKA patch #0).

-Doug

