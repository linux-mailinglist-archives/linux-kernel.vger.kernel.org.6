Return-Path: <linux-kernel+bounces-393714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 069189BA452
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 07:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFA5B2820E9
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 06:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04116154C08;
	Sun,  3 Nov 2024 06:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XhlX8Cb9"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CE413A3F2
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 06:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730617078; cv=none; b=aYSVE1WrVHTlTnQbdADkpzPcqE6//fguCPbeMhhY/pWp9kLDg59wp2WCvHoNcUMB8fNejq/ELfll+Mluh4IdytrQGu1/gVVeyAPQvnWCZjsiRpB70/j5nIdoWKFvKhDBbbEy3gBlBVRHtSZDjs1ldDZ1WukWQLA9WuvQHsiWz0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730617078; c=relaxed/simple;
	bh=7np/I76LHj5RuluQ3/YJmSLHvUBqTcAuqIlQuP1knkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tru/umcUrSqhffo6FSfKhiQ+MlFo8Gr2hg7kpkD/Uz29f/7HfehQtOzzcuJexavaxg7Wm2nAx0SzFWEMECDqlj4qQ404uRvpVBHbKDqzvyxrEOkUAha8eF1V48aEZWdR2D6eZTzey+i9Fo6KwZUgoWkWe1JSmH887jHrgN/qNJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XhlX8Cb9; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-290ff24354dso1437312fac.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2024 23:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730617076; x=1731221876; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fS1npImPfHb20Sl7e7er9IvRC0E477hQsJ+7VA0CBuE=;
        b=XhlX8Cb9hPa+D2zxSnv7jpB3Tl2BKh1SKouaL2nLzFZTxeKhPmqhId+PkOctHfayQ8
         ESxGOk6Jg6Td5ZdA2qjJYEk11i1wOeOuw+7px3B4MQ/BkMYYgA5McHeHSbyIPFwDd+Fl
         mvvrmgPTSYuebUCSC/daNHojBdNUDFpKbNkaFUQU8yRF9IWcCpQ7Y8aGJ55KYcySH487
         dK1Scwzhx5yYDmLPU6m9KQPW567lxShgFRuET3krYxbYWCOZnYQI6UX7n/l2PAk5XCZH
         g1ccHc+tfnnHBhgpIcNBft0bgB/IcdKf6IvNjOzGENu1HypNWxMYfKobXxF0HBAiqTav
         x1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730617076; x=1731221876;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fS1npImPfHb20Sl7e7er9IvRC0E477hQsJ+7VA0CBuE=;
        b=tlJ5dQdg5HD7RGGTjh1boER7TTI3iwi9uSuNv515cFoQGPcqrUhNCHkJEfX0HjusY3
         XYNhZ/EL5vI5NM+6zpnn30Sj2MykdBjrX8C3D79rdVcV/1dizeUtf9UnDX3+4KMEQ3wR
         dj1zcp6rTNpfx8WbLbShUUHIKrX9/fa8xkEBKc5y4969ZDL8riIZ8Z8+q9kQbOxsbEbl
         Y+oCQ8hTDOV05lpt+o4HQLS5V4zoYJvmKcOXl6MrdS+CR3DyJVhwljT7dmTnSbmugsv9
         SyLRzRV6eHvjkCvByXOjU2Dxh2OGxDBHbBdOIxQbeOLOuJx8HPRLaBV76CKBiPULAv3M
         5YGg==
X-Forwarded-Encrypted: i=1; AJvYcCXyPo1le/4bcdbLSMerqeOqS+cAGe/kkPG0DLpHViQsYPVp/zEOVfPY45U4beMcFJsIiylBRjIFt2UKrjA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9P+UmDVjXRERyKGjfQqYJXUChQVS9K/oiwoquX9WZFzHp7BBy
	ft1pQquV5pNiQzip+5h1xjWG91jzQ9ATh1u+rtpxxmH3VY8EKknGSq87pDLoLUs3HySdcyIgidf
	/Qhv9/UQrx0d/xGgxjfAaf9RcEXRcVVaY3a6u5Q==
X-Google-Smtp-Source: AGHT+IE+q1rK+3oCKtp9SkJcnFzCrL9vfkFECGy5BIRlaiafb9OMt6z17EkSsb1RPUubkyZ3F6wWlfWwl558mwfUioY=
X-Received: by 2002:a05:6871:c707:b0:28f:329e:9f23 with SMTP id
 586e51a60fabf-2949f07cb9emr7517716fac.42.1730617075872; Sat, 02 Nov 2024
 23:57:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031150033.3440894-1-peter.griffin@linaro.org> <yq1wmhl6rp8.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq1wmhl6rp8.fsf@ca-mkp.ca.oracle.com>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Sun, 3 Nov 2024 06:57:45 +0000
Message-ID: <CADrjBPp9-ucYgztdRNP81FfY0h+1s7N=LEPS2Ny=D2Vh2HsWYw@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] UFS cleanups and enhancements to ufs-exynos for gs101
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: alim.akhtar@samsung.com, James.Bottomley@hansenpartnership.com, 
	avri.altman@wdc.com, bvanassche@acm.org, krzk@kernel.org, 
	tudor.ambarus@linaro.org, ebiggers@kernel.org, andre.draszik@linaro.org, 
	kernel-team@android.com, willmcvicker@google.com, linux-scsi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Martin,

On Sun, 3 Nov 2024 at 01:36, Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
>
> Peter,
>
> > This series provides a few cleanups, bug fixes and feature
> > enhancements for the ufs-exynos driver, particularly for gs101 SoC.
>
> Patches 1 and 2 were missing your SoB tags. I took the liberty of adding
> these instead of having you resubmit. Please acknowledge that these two
> patches should have your SoB.

Yes those 2 patches should have my SoB, that was an oversight on my
part.  Thanks for fixing it :)

Peter

