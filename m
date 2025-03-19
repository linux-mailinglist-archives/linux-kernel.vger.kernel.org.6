Return-Path: <linux-kernel+bounces-568952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1DBA69C9B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 00:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFFB47A54BC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 23:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D4D22259C;
	Wed, 19 Mar 2025 23:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ctJVAq1Q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B37721506D
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 23:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742425936; cv=none; b=m2NDFvEtL3LGVN1ecNI5W0WYn6TtsuFUCR4lyKKn+4XNp5YpkN68/hv2Twwoosi+HJ83zPbCaSxPM0UN8okpHKA2VVylVGhusSdzlRQtH57Hq13+fMu/U0FhH2MQvT+HMfDoiVFVzNPlblH0KEe7tTawOjzbjPhfyI8M7Z7syqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742425936; c=relaxed/simple;
	bh=1s+mT13Po59uk7JTIoXRVLteCQIeAS7uaT5/b1rskCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TwvMFgFgiNXSeSFz3GyhrazxOb3P1UZhKkFBolQ4CY9UMZf3VTSz8iB+uq364I8P7bmN/pSRP6jLd/YMox7sf9kZw7x/pO/oTEQIHVVH405J9QE4KPkd0qmZj64LmeIRcu1/rJtOU5heEeanfH1gQhe9BjAf5TAEl/si8in8IHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ctJVAq1Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742425933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UwKvnnVbbmyLH9edSeNILr3inqdgiQDTas58Nmmy7mo=;
	b=ctJVAq1QOsd0RCA3pnia+ilargYE+BQBECUnh+vFjNnrtT5pqzeClTJ0r6K7Xi0/v9XG32
	g7ZCm2di2qAYaSkLWG/Hi3OPhzUU6TROnxnakOii+G+LWRUYXniY9PPniWsdRJY7cn6Z3f
	2PVfAG2lmlc5G4CFcf6Pt2W2F7SDi1s=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-BGhKcYVROH2nBynp4OPcbQ-1; Wed, 19 Mar 2025 19:12:12 -0400
X-MC-Unique: BGhKcYVROH2nBynp4OPcbQ-1
X-Mimecast-MFC-AGG-ID: BGhKcYVROH2nBynp4OPcbQ_1742425932
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-e3a0f608b88so191441276.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 16:12:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742425931; x=1743030731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UwKvnnVbbmyLH9edSeNILr3inqdgiQDTas58Nmmy7mo=;
        b=VmZQ1JEjm03ksFLEVdZMvXfq+vp4X03pI71U92Y2ylUvmJA/ZF1XGiov/aN52yYv0x
         l2fuZoXmrZrex26rqhvw1q6Keyhyn5HE8NFuLkSmftMLRbR5h/V8C5YF0MuSjfViGwbe
         0LTF5XLmzwFIPVlhHiV8/mQBCASNl5AkqDKIoqe9s4DK6N+a6VRdLCy0PrLL+Efxa9xv
         +btEnxdquzXt0JeVJT6qW8AW1xSFa/iCYBnut/NRB3ccIqjF1Ca3bUgtl8/opcLYDBMA
         d6AAlwxMS7+LaKVZ9NtoNZPBp3Xmd25kqdXr6P1YPnD/TVg+zQl0sG/K2dcCQ4ALyqhB
         1nuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCAo5Le8gRIckTDT0H5w5/HiStGI5VIHMIIVf9BwKLfDba2FodB+dBM689ZRgANghdbr4lfMFpAkpojNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQbDRAogHXolWwrTnz+17MKLQiHTvFg8MhRaCB04ALmQWIyltI
	Yc8HbpRsU7sj44K5MTy/ONaGRjTrL3jzgn1R/V8aoeV+ljHD4Qn7Q6j1rIQJjCeXe6k4hYfmMex
	dNUxXPUjSK9LkLF2sVUQZOIb1QmYU7oKi+/kltL87IPLtMLY6PRVcBgQtWiJDwa8f6wpnBeib0h
	4SbULp9ooZoRn+tnKrdrvebVKXI6BLGI3jm7Fr
X-Gm-Gg: ASbGncsnouZnXT2kBUzpGUOxWbdiZqv5t92Wg/UpkHqqL3EWLMP+UG5W4pY7pz6BRCO
	cp4zKI1MtfhtRPrTNhg+iIfv5Hl66lciukiz27wwouVmkpH+859Y+rqj6wlcf+5mXAkakIaPkso
	CAQfBAWa9Ja0w=
X-Received: by 2002:a05:6902:2205:b0:e5b:32f5:e38b with SMTP id 3f1490d57ef6-e667b3dd988mr5498771276.23.1742425931737;
        Wed, 19 Mar 2025 16:12:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFz6FeV7+mWqOI/3/OyEWXgIzufD492CON6BYOPad5bM5/LtU2mCh4VKx46YcYVWPrbpTkPdRVob2IhGifFeY0=
X-Received: by 2002:a05:6902:2205:b0:e5b:32f5:e38b with SMTP id
 3f1490d57ef6-e667b3dd988mr5498751276.23.1742425931486; Wed, 19 Mar 2025
 16:12:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319230539.140869-1-npache@redhat.com>
In-Reply-To: <20250319230539.140869-1-npache@redhat.com>
From: Nico Pache <npache@redhat.com>
Date: Wed, 19 Mar 2025 17:11:45 -0600
X-Gm-Features: AQ5f1JoUzsJo2CV6xpdFsEEpCBkHT07cu984t-d39OyyRxqZm4KEhHFzcrh-1EU
Message-ID: <CAA1CXcD2g=sRRwgLSudiOAqWXq3sCj+NPuE1ju7B2gFXXefjXA@mail.gmail.com>
Subject: Re: [PATCH] kunit: cs_dsp: Depend on FW_CS_DSP rather then enabling it
To: rf@opensource.cirrus.com, broonie@kernel.org, 
	patches@opensource.cirrus.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Cc: simont@opensource.cirrus.com, ckeepax@opensource.cirrus.com, 
	brendan.higgins@linux.dev, davidgow@google.com, rmoar@google.com, 
	johannes.berg@intel.com, sj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 5:05=E2=80=AFPM Nico Pache <npache@redhat.com> wrot=
e:
>
> FW_CS_DSP gets enabled if KUNIT is enabled. The test should rather
> depend on if the feature is enabled. Fix this by moving FW_CS_DSP to the
> depends on clause, and set CONFIG_FW_CS_DSP=3Dy in the kunit tooling.

A further note here:

This test is failing and panicing across multiple arches, and
triggering kasan slats on debug kernels. I think this test needs more
testing ;P

>
> Fixes: dd0b6b1f29b9 ("firmware: cs_dsp: Add KUnit testing of bin file dow=
nload")
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  drivers/firmware/cirrus/Kconfig              | 3 +--
>  tools/testing/kunit/configs/all_tests.config | 2 ++
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/cirrus/Kconfig b/drivers/firmware/cirrus/Kc=
onfig
> index 0a883091259a..989568ab5712 100644
> --- a/drivers/firmware/cirrus/Kconfig
> +++ b/drivers/firmware/cirrus/Kconfig
> @@ -11,9 +11,8 @@ config FW_CS_DSP_KUNIT_TEST_UTILS
>
>  config FW_CS_DSP_KUNIT_TEST
>         tristate "KUnit tests for Cirrus Logic cs_dsp" if !KUNIT_ALL_TEST=
S
> -       depends on KUNIT && REGMAP
> +       depends on KUNIT && REGMAP && FW_CS_DSP
>         default KUNIT_ALL_TESTS
> -       select FW_CS_DSP
>         select FW_CS_DSP_KUNIT_TEST_UTILS
>         help
>           This builds KUnit tests for cs_dsp.
> diff --git a/tools/testing/kunit/configs/all_tests.config b/tools/testing=
/kunit/configs/all_tests.config
> index b0049be00c70..96c6b4aca87d 100644
> --- a/tools/testing/kunit/configs/all_tests.config
> +++ b/tools/testing/kunit/configs/all_tests.config
> @@ -49,3 +49,5 @@ CONFIG_SOUND=3Dy
>  CONFIG_SND=3Dy
>  CONFIG_SND_SOC=3Dy
>  CONFIG_SND_SOC_TOPOLOGY_BUILD=3Dy
> +
> +CONFIG_FW_CS_DSP=3Dy
> \ No newline at end of file
> --
> 2.48.1
>


