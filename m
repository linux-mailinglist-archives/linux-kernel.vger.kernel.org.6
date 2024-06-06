Return-Path: <linux-kernel+bounces-203540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8EB8FDCD2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 04:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 563FA282764
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 02:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434E31BC20;
	Thu,  6 Jun 2024 02:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TKSH6ndk"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC01318654
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 02:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717641325; cv=none; b=A0AeyygmtsdCemoGO2Woiult2sUIg4F8baG/3j1abVtIzM3qX64G4EpAp7KE99Do5tAUtd6XdwNLjpsuQYB4BMFM4MqPjoqgR/eCTsuV50R5v39+lXAdrWy8Xgm6xdis8jOQrnKrutFsXuBmS4KKyQ3D2OPGqT7aW+KiuR4DTBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717641325; c=relaxed/simple;
	bh=jWbZE4IHnSQNJX1Cr059FeAfCDjIY7ZcvY1qnkeTunU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gYeL+9HlB6FNrkQ8q35O0lqxonCB5R/JVEjm6NmADlflUPRWWObQb9ITDdrZJLcKxsLaygRdQa5+tytTifnUDPdZExsXwXjCKbyvbjws6FEdYGqeBFdI2WRzkZk1UbqpQqqt0Pmbvlz3VDdytjwF2EHOygNITiuOzRyVg2RAkRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TKSH6ndk; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-627dfbcf42aso4190247b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 19:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1717641323; x=1718246123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jWbZE4IHnSQNJX1Cr059FeAfCDjIY7ZcvY1qnkeTunU=;
        b=TKSH6ndkVsYPm5k9DR8Tth/BtICGU2bFCCxVt9Z5WGMQTHydwRWSxnRcdzRZzZKmNm
         xE1Xx9k5MYMUiUSwKx5j/01jwPHrWfUH2yMqn01PSQU16pC59z9oE+/9ni0NvuQ1gwJK
         R2y1eYWAgFnKUNMoiSkvdABvG4OR6zMKeTRl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717641323; x=1718246123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jWbZE4IHnSQNJX1Cr059FeAfCDjIY7ZcvY1qnkeTunU=;
        b=twVNaVGNFt674CE1eVRhryxczwuXnVG8AJ8I9XobpYYKKot5MGryMepYF2NoLF1AL5
         GB+7a8uBs/GLWdZrROqbhmeksqHhvSfT3RzINm4Oi5KlEyZzIBqg1O/2iynSkBOQGGmb
         5mHNrBquSd0IQU6vscMnBnY8/Gdx1Wvvuj8kbdVKcqKPQaLn5sRWXxZWDmxiHfehGdMD
         SV9SYfstpXu20JDiOF6YfuDNGUnF+LQyQN164aolKXHXA5ZWyeKRhiqdAaIG8UpiNUHj
         gp7cs7y7LQ/LeB2hzIPJJeLAe7XtRcjwZtDgICPcBejPHSu0KRx6zBztlHI68wBSmNYg
         CpOg==
X-Forwarded-Encrypted: i=1; AJvYcCUOQaNWPETs0qrBGT3qjQ96bBeeg7/YAZSQOQNXVGb9/q9D4iYCES5YMQ/QuCgnm29JvpQxeJ9bfj4if/nPwuo0pOKwsn3gx6hX8khs
X-Gm-Message-State: AOJu0YzZ/BKfConyy3QsK/dLkvNAZE5+eJZhkYmut/C//wdCbsNIjooY
	ycSFfDQktzqTQVNOGuQRbyQsaOa3lLAkOQtTavMHoU/BT0dT5+2+WNLjLDYb6Yv4QVcl4VgAK9H
	K8QN2Z86D6SzyWAVW0Yshc/YT5TIZRHqFgb0Q
X-Google-Smtp-Source: AGHT+IEetZtg3sd1WRfUjCaJp694k1J+jq1d22kipTdG54+7IYVn7+AwLxlfHKh9spCBKCQDFhYxQNkIgI+5c7y8imY=
X-Received: by 2002:a81:4c8b:0:b0:61d:fcf7:b79a with SMTP id
 00721157ae682-62cbb4ab5ecmr40559257b3.11.1717641318577; Wed, 05 Jun 2024
 19:35:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517232858.230860-1-linux@treblig.org> <Zl38XRm7TAfb3azW@gallifrey>
In-Reply-To: <Zl38XRm7TAfb3azW@gallifrey>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Wed, 5 Jun 2024 22:35:07 -0400
Message-ID: <CABQX2QNG67dehASGQS-0C+9ikqk0Bb6Sfb3FtxrcXGhW+aXBaQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] drm/vmwgfx: remove unused struct 'vmw_stdu_dma'
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: bcm-kernel-feedback-list@broadcom.com, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, daniel@ffwll.ch, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 1:24=E2=80=AFPM Dr. David Alan Gilbert <linux@trebli=
g.org> wrote:
>
> * linux@treblig.org (linux@treblig.org) wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> >
> > 'vmw_stdu_dma' is unused since
> > commit 39985eea5a6d ("drm/vmwgfx: Abstract placement selection")
> > Remove it.
>
> Ping.

Thanks. I pushed it to drm-misc-fixes.

z

