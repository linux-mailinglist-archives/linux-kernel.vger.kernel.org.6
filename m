Return-Path: <linux-kernel+bounces-356972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 322E59969BD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 14:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D2B5B22A5A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 12:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E371E192D60;
	Wed,  9 Oct 2024 12:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="R5W8Ov1W"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE871922CC
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 12:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728476130; cv=none; b=DJZqhS0aQ7fNmlnfOm6/Ng5wjKcmQPULpUP8JhVx6ffdbncUlPyCZ7eggiRecigwDZeOU04CldIPxN/iDK/mTFfNbQakD727BN6KXne/XvLAoX2v4s64pwVaDgTBIbX0TbpfTK1ZqPmHL++PyQSGZcx+PDnSl5fe97HNyvH0+7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728476130; c=relaxed/simple;
	bh=Tua6Pt6b4oDBptrka1GMffQCJjZofqiUKNxEfaYafCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MJuQsgF8OWUaOOArbfQwYqTYW7STIpiPR9fEgv4vorx98g67h/qPK7bmLzM9ALjAAlOY5tb/Aem29ME7xhi+VEAhLhfzeZ0lUc9hastDr9WRI6Pfvpil/AYRWAmenMWwgJxARmRyziBYzPFEEisFq0J6SueOZHDbN+dnJqHJk2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=R5W8Ov1W; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e2908e8d45eso48351276.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 05:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1728476126; x=1729080926; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OuVN1M6bgeATUn/64hNmgkiXZcNncOEw3XxOlbpzawQ=;
        b=R5W8Ov1WXDP717qiAU2c3JhNr2TCZtwqKorJdTFJ7BBMUN1CfW7L0PLBCQP07+z7ZJ
         bGxNCBeaboq6kCrr1ji+eZ7L2uFjWIgNNlJGhRt4qH0ERpNdIyBKK3eUitZ+GgbUH4/T
         l5C7XfO/NRwCiGRPGWVYYOxnc7LKikSIt+dFFJAMHeu9bp4QcsvDiIi2M0tbh7yMFE2I
         shH1wRLZPDjAFmR6V9YczyXzn/ncObCcFruZOe4iiG7tS3Gwyp90PPn6rnANc/VVCoPP
         V03ukF39hA6nSINWt+/pLkd3z1t4c1JglcTRPMXz2j/v0RMpWEUJ5j6wFWaNH8802Ayv
         cHvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728476126; x=1729080926;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OuVN1M6bgeATUn/64hNmgkiXZcNncOEw3XxOlbpzawQ=;
        b=asJG6pvEa2oPb1YEZjkAz9COgBZ33jrBkpa/P5UJuAkMme18hR/RFRGJ7vqCt/s861
         oghZ1LRQh3LHBmISw0nVrs+dxMLtjyajoVvfEKZ1FQPa4RdJNv5mN/LNT/DC5PQPHuA7
         sgFtjRsJsrzgCu46QqiFnCDbCpHflYAMRTZ74LNqgxBX338hMnm6wrZpKyutQDEUdGFT
         Bloqh/qSD1JJkd4k7cFczA4YIRfkp2gYlhYicj8+lEqhRMQzhzMar+7PK9znRi5uIXd+
         tc++4ITBb39AtI4BWi9E7YGGWIEcMmi10sJPP/AI9+7E0+h7PfhYnZWAmZbY+/LldwrQ
         bmsA==
X-Forwarded-Encrypted: i=1; AJvYcCVy3+dVLMufRqSXqbrm6nGmNiwaddxkLcwlfR7WFm8Gy2IrcfHHz4B1I6aER/v1Qzv4SLJlToXASv+Kgfw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn0POZx0br/PbuFelCcxV+Sla/VLu4VC4cHRWXXHpxAlTHbkXN
	PVpKbKl4i9YnOcN+9x9R5j3/eaBXNqn3ceKkqqp3qli0V42/42Oi9Vle6k8Ibd7fksQGYsEftqT
	w60XwnNzulkjDplbt4U5EnlkUwZRzYfZfzKIw6g==
X-Google-Smtp-Source: AGHT+IGH+mPZtcgiLwSwbLF6aVPi7xFylmQ8QnKfsrWUsP9o6sUsqNVzV0h22XmrQX/xE0hPvIi9MxOp5CYfizjtFnk=
X-Received: by 2002:a05:6902:1387:b0:e26:2bbd:29db with SMTP id
 3f1490d57ef6-e28fe38d0cbmr1933904276.33.1728476126456; Wed, 09 Oct 2024
 05:15:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008-drm-vc4-fixes-v1-0-9d0396ca9f42@raspberrypi.com>
In-Reply-To: <20241008-drm-vc4-fixes-v1-0-9d0396ca9f42@raspberrypi.com>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Wed, 9 Oct 2024 13:15:10 +0100
Message-ID: <CAPY8ntDFbGzPAOXZ=C80R=ymM6LGewua+xnWOY5JNbDxTP7bag@mail.gmail.com>
Subject: Re: [PATCH 0/3] drm/vc4: 3 minor fixes from mismatched
 drm_dev_[enter|exit] calls
To: Maxime Ripard <mripard@kernel.org>, 
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 8 Oct 2024 at 17:44, Dave Stevenson
<dave.stevenson@raspberrypi.com> wrote:
>
> These are 3 fixes noted from Marek's report that he was seeing lock
> held issues.
> The place he had noticed was actually triggered due to an incorrect
> change to a conditional, but also a further place was noted where
> it was possible to leave the function without calling drm_dev_exit.
>
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

Applied to drm-misc-next.

> ---
> Dave Stevenson (3):
>       drm/vc4: Match drm_dev_enter and exit calls in vc4_hvs_lut_load
>       drm/vc4: Match drm_dev_enter and exit calls in vc4_hvs_atomic_flush
>       drm/vc4: Correct generation check in vc4_hvs_lut_load
>
>  drivers/gpu/drm/vc4/vc4_hvs.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> ---
> base-commit: 2c34a5464007c45142af009d13c668b0630ef9c0
> change-id: 20241008-drm-vc4-fixes-4aceb259455c
>
> Best regards,
> --
> Dave Stevenson <dave.stevenson@raspberrypi.com>
>

