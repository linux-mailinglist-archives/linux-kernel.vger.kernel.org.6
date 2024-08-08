Return-Path: <linux-kernel+bounces-278861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 157B594B5BF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 06:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5B21284F6B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 04:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FE081AD2;
	Thu,  8 Aug 2024 04:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="V2wEDoT1"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403EBD530
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 04:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723090029; cv=none; b=LLuFfew+lStn0VvLTO8sSkGOdPIiFN20jaJk/ThU1GwRuwleGkwyol8QDNX69HES6mzjsB57RtnschgIUVdSdhkCl6e8Ch07rmWPr90opPYkOsPYvjbBW4wCzDlPuFUpOhfNwxJU/tJOWnV0d9zIgmpkDmsKIAiJEehqT5oz5NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723090029; c=relaxed/simple;
	bh=o6mZ+XFuDcchuwZNU7eQbylS4WywOQo4PxleCE7mo6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HDuvcPwkKk0Z1tYrqW1s5egz8B2460RniyZNGcmpvVPOvcOVaX54/gCtizYzvP2BYNWrvkSZq21JH7YXlrp0jPV6b7c+HfDKW0E6g3XN08O0XP9bhz6tmD8BXCORHxN8YOOk5pCQyTV1Xh/RdbxxUTPAIQTTn1v/PTZznZAblEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=V2wEDoT1; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a1e2ac1ee5so35448285a.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 21:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1723090027; x=1723694827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+GSPLPHttL16sT6tQners2xK8hI4QMogUGmK36uWxcY=;
        b=V2wEDoT1qMcrKQkuLaE8LmYFBz9X1Ux/NXLwH6oBFWWDhLGY1N9z3COvXLJJSdJ6gr
         tBVyyZRko+lo1nK/sJFTHQHBt4kZ0zyj5mnCdAnEdVPCEQ20uKjnlgrzHWnakwTFHYMe
         aGjf86K1GECdjxigN5mVsrq73Lrenlgsv1t4KSWkUz+DieM/qqZHsKV1gODZ+ghcpq14
         KLI2QqJEthDan9b0T9PcKsP12renx3CCpO1UjKvq/QVUt5hgbuVEtOPehdh62Ghsa6OE
         j2iYCBdGvSNm0X5FVx1aA5fxyOTfTWwXsOzBlQBeINzEn0OewSwJqyE65Eh9HOeB76RO
         PfYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723090027; x=1723694827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+GSPLPHttL16sT6tQners2xK8hI4QMogUGmK36uWxcY=;
        b=R2Qn2cfqcg9cLQjgg33pslaBYZr0s+IQrMRiV0ZNn/rTBPI1YnGMp8l+75uZACQSKP
         euE18d1PkANSruMqNvtgdkeE4UcJAk9I53kLi6O9Ogr6KF13A1ncDIV2OU9uVKXt2WQB
         /85mUMRyXdbyBXAx29Y5l0nt4WLLorftdjPaWA1rCC+euX2C4Zdvlt6L9JBkGWxm6Z9G
         Zx9LhAUUwYMMHOAAygr06DUjf7RD4zPRS8MaFsv87ibdo06EZd+BXu33NEvG/H1AIV2/
         jxLm/J8cc0pkwk8E9/QVSDtJov/QU5+SKtLlGuE2Btfjd6QbPxEtbdjbiGNhsdNBffYv
         Pa4g==
X-Forwarded-Encrypted: i=1; AJvYcCUIrWYMzNxq+s+avQwhs6vP60qFoVGcmFohjJuBQKD9YQl6FR3EX3n6eowNdb32EkZvR9HGs9FT8tKLKWIN2e1syiyKeF4e+sc8mwMO
X-Gm-Message-State: AOJu0YxIKwkFnizbg6RZuRUp/A9bAYXQ6NChrPEzH5VGJQrLLs690Nq/
	4PLHvjJv2nOgH+XiFPLCEhgSe8MlPRLJTA0V+l8gloLlK/VLrBk1cETJASdX9lGg3D5Rm7VuCWE
	RUH0X88HM9S7KHwtb/Ma9y3FVuRuUo6/UYYLkZQ==
X-Google-Smtp-Source: AGHT+IEdpBZquXxDF0TfOERvkZ7eml1/CCIW5IAcvi73rGjE9dkM735b2Uo3Qkrxcfns8UqQwuri2e+EZlVjzbCL6Ik=
X-Received: by 2002:ac8:774c:0:b0:451:d541:8b77 with SMTP id
 d75a77b69052e-451d5418c1cmr4374881cf.46.1723090027131; Wed, 07 Aug 2024
 21:07:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808135815.5e3f50b3@canb.auug.org.au>
In-Reply-To: <20240808135815.5e3f50b3@canb.auug.org.au>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 8 Aug 2024 00:06:29 -0400
Message-ID: <CA+CK2bDs150AbtnJcj5AWkMEtKR_AzY_hjzgscXmBj+yQzpEZw@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the mm-hotfixes tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 11:58=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi all,
>
> After merging the mm-hotfixes tree, today's linux-next build (htmldocs)
> produced this warning:
>
> mm/memory_hotplug.c:575: warning: Function parameter or struct member 'ni=
d' not described in '__remove_pages'
>
> Introduced by commit
>
>   ff4440b02821 ("mm: keep nid around during hot-remove")

This patch has been superseded by a new version:
https://lore.kernel.org/linux-mm/20240730150158.832783-4-pasha.tatashin@sol=
een.com

We do not add nid to __remove_pages() anymore.

Pasha

>
> --
> Cheers,
> Stephen Rothwell

