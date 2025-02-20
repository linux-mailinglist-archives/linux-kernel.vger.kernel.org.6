Return-Path: <linux-kernel+bounces-524127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 348D2A3DF88
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20CED170F99
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B231FECBA;
	Thu, 20 Feb 2025 15:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PNwqK2ba"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5510D1FFC78
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 15:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740066948; cv=none; b=XCpQDh2/5Y1+ydWWuGV4TVADGPH82Rrmo/RIenSNHas/VYkhi1OJZ7AslZb61zfybvS6mjieXgxrubi28SGWEVlGfYGpam5+dGnkMgH88arEn1zbgArurn22lNsVHnvWs5wlnNvyB5MRS11YmYXv6WMTTAHXXtX38IEzoR57SOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740066948; c=relaxed/simple;
	bh=nGjY0pcALgantTol9y3eDcS8ift8hVBdT5A0SWQDHUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IXBesTRiEqATZ6w13EycS0wMEA+9lD1No+CmnADZJRwC5QCdjpU8nsPFl5/2yAsCPWrf8JTg2Toe8wjM5p0sNaqqN+x5/SxZzEUWf1YAtDucWQ6TL/Yxe7coXz65X6i4++SjZ1bFnkGY53zaoWspEUqPnN5oSI3OAcGmx4irB8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PNwqK2ba; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-472098e6e75so300111cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 07:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740066946; x=1740671746; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xqf65nED3NYJwmlnVPTvXBomckILIduk3AQAFu4O9k0=;
        b=PNwqK2baPDmaRfZtyCmk1BJ6kk3baSK4E16rOBF/bIHfe4lkGs5XNVDXGNVkRgIfjt
         stKA9To9oVOE8LvHh0AAVIYguoBxSmE3DnV84MFxcaJw5046bze+eM5A+jWASaqPtfG8
         KEdnQoDTKMd7nDNOzz2nWsNnljOPXExVdHmAgiA+bjktH9eGjWFwqxG/SWz+yoiButaU
         FUkZX0QEB7apg2yPundG0d/M34Ms3KIGq+LEHUvKum7rYbQvx06ZART0ztJefGX4uLpb
         2dQ2qZPM661rXQzpy8zgFy77z6jsKSHV1NgR3UVGqZaqYAYzFBOu2gjc/WLP5acxCvgK
         c1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740066946; x=1740671746;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xqf65nED3NYJwmlnVPTvXBomckILIduk3AQAFu4O9k0=;
        b=FfhVeyp9SM77Qq65RBTgyjITzH9vYqogXTwCMRebbxf9Gz+ziThOMzVXUMWJLH/mdP
         Hir0S/ert7iRUJdxUss4Fn0S4CzbhOU9KmnNxnqpULDaiZIvG/DLeHln9zsQt4HTppS8
         Z10n46smr2ZmhAkmxW76pP5N8bm3TOtIqyHlQnydBaBksNH0auhHh9ltJutn9H1fKvfM
         vbdfzMlaj2LR4iaJ6cAkCkHP10xNgCh5ReteeDGRBfe4fEXZSw+lW1+NyeUw+uJYq4HB
         0Adx7TFupsdY5VHZL/MokYdlSPOSjr/w2XxfDSO5CuXHNHRGdQD8FpcqTX3e2GdIJNpn
         mELg==
X-Forwarded-Encrypted: i=1; AJvYcCXQsYQ0Zk5wRLfOOvWLKu7RP2/jaQ5UC68muxt7/EIbh6ydzTT5A8orA4WcmmQTDdx9kjlbIyizKIwwexg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsHQAQ+p3XgaJzwntkxTFf5YnR3uc/FwjT7C/4WHrQRL3pWZ2D
	0Q8tJZzTpWe6AA+0STsCaFoUHvVlHrQ1lPkfVreRodPEyIjuP3ApAGfrqNS/+id8aKT2h+1mqFR
	8Pikplepb2UrPa0UOcNAJ2PR5swR87lPFh/kL7+UQeJitViL3FWh4
X-Gm-Gg: ASbGncs2caZn+foMcm8yIMSTbMmnokzpo5XZI265T2k6gXe/7gVteclk0v/WyAzq9W2
	ZDqbiQRMB2fVDnzbxcZpyAlUqSO6BxwZvDeirT86A9dg2mPDI4LsAQk2S4ndN4ygSYG5UTeiZZm
	DHmsYJ+EwICPdlrLoqfd0S3rGY2Bc=
X-Google-Smtp-Source: AGHT+IHOdWO/3Z/ofouQMFSA/yPXXraLlaV7hAkItx8s9YCocwCXJATlNZf0CcBawq4mps1HDugVCO75m47tbi/iLio=
X-Received: by 2002:a05:622a:428a:b0:471:f257:7a5f with SMTP id
 d75a77b69052e-4721711149bmr4179751cf.13.1740066946034; Thu, 20 Feb 2025
 07:55:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220-mm-selftests-v1-0-9bbf57d64463@google.com>
 <20250220-mm-selftests-v1-6-9bbf57d64463@google.com> <da1c3dcb-5296-47bd-b5ed-9cb8833377cf@arm.com>
In-Reply-To: <da1c3dcb-5296-47bd-b5ed-9cb8833377cf@arm.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Thu, 20 Feb 2025 16:55:34 +0100
X-Gm-Features: AWEUYZlPMDgaqu__QrVZ4KFp2sTS1uCxjoo7b3B-CAxYQcbUHy2R1SAZIvagXmU
Message-ID: <CA+i-1C1VjdMb6YLEvORkZhiqVCE_G5BphJmAcr00U6KCfC7xtw@mail.gmail.com>
Subject: Re: [PATCH 6/6] selftests/mm: Don't fail uffd-stress if too many CPUs
To: Dev Jain <dev.jain@arm.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Feb 2025 at 16:48, Dev Jain <dev.jain@arm.com> wrote:
>
>
>
> On 20/02/25 8:33 pm, Brendan Jackman wrote:
> > This calculation divides a fixed parameter by an environment-dependent
> > parameter i.e. the number of CPUs.
> >
> > The simple way to avoid machine-specific failures here is to just put a
> > cap on the max value of the latter.
>
> I haven't read the test, but if nr_cpus is being computed, then this
> value must be important to the test somehow? Would it potentially be
> wrong to let the test run for nr_cpus != actual number of cpus?

Based on my _extremely hasty_ reading, the variable is misnamed and
it's actually a thread count not a CPU count. I can double check
that's the case and rename it.

> Also, if the patch is correct then will it be better to also print a
> diagnostic telling the user that the number of cpus is going to be
> capped for the test to run?

Sure. The level of detail in the  logging and error messages is
extremely low here so I didn't feel like being too anomalous, but why
not.

