Return-Path: <linux-kernel+bounces-571497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FE7A6BDE6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E21B8188DDDD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACB61CEACB;
	Fri, 21 Mar 2025 15:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KdMIoKVO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932F35CDF1
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 15:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742569328; cv=none; b=q3I2NOvg5QMFPgZLKpietJfgZ3yChqTmNaol+wXadnWhjBIZtV3YPsm5Apl8YD1AQk0KaeqU1yv4s46juq9rvWyiaK/+lUIPg9hAyoqLDGOhVNbFWzZ973pGEzFB4aJs+sli+F1XfOTN5mKF8jikjP3jfBo8ENgb81Idho35GMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742569328; c=relaxed/simple;
	bh=83Q0Qw7I4VIoIyFtcO3ONAKW+0v0w2T3F/DO/HaBXck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MeCzosXV2OthxehYyOfC7pGPTR9EQFAUNM4PTgiQ7gglCe2XtM+AO8qpG2c7Imm9NqzPfOkaFKzEKQDwYpieFrgz481s2ZP04Gz4CSV2k/ygsdXULTK5KtMqX+OH6MmZeYGUH1pEkqo4Wz+ltyQB26nnxZc3+DONPbrWwIOdWHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KdMIoKVO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742569325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mXDokhrAaPf86QJp4iWqtWLlS2xj4t/tKQqX3klhNZk=;
	b=KdMIoKVOFgPIslUFFIYxuuAo1HcZvAp+LMY4jiZGr4yPbkNXPN59SKywFslU+oi0jCuUkY
	5Va8nKupnAGRGId7YxuWXBcDPcUbC1eRboSU/LzQadfkyBGMrK3pgu2xygeWFH3kg7s2rY
	xDiWJFwwU3TcQ5cRm2ZL+EtLElsR7Ic=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-zCovJlPMP1aski_aINwThw-1; Fri, 21 Mar 2025 11:02:04 -0400
X-MC-Unique: zCovJlPMP1aski_aINwThw-1
X-Mimecast-MFC-AGG-ID: zCovJlPMP1aski_aINwThw_1742569323
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-72a2bc82f9bso657779a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 08:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742569323; x=1743174123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mXDokhrAaPf86QJp4iWqtWLlS2xj4t/tKQqX3klhNZk=;
        b=sA7e6ePj4GNSVi1lG6VHU8w3a8s23x6OAYNqCUdAPJ5NnccrJYaebrHwGwUObo8/LT
         YYksYOCI5BvftRccJBCnj2ZhIAsIYtlK19mFK1DsgDVrTY68K4HRdsJsxLpNvTO7xE2e
         i/X2bishBVBlnTDnmWM62YLU+E/fuDLs2rWQInYFP/2NrP9Jey4RFOgq2av8pPpx9XG7
         e588ymekMhBnQnTHbC7baqOaly6tRJUL9/1h5sJ41jVJWYxTnm+NCrAXdlxTMl55z4q8
         Pvl2RKdpi5sMRw5K5aaJefDT2pCcBWupvdjLtlQ70s8zBKKhMqPxwCvI850TwEJHSrg9
         sNKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbgHgB0niPi82V5KvMno9J1k5AenurDNXbkbzihXTYZnEaSACFvaNi+xiVIrst2Rkkn41DWryp26+jx+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI94XR3m1RfwtbKbPnwgGIv6KMnjc6P2wmatWWsRtiNEgj9hl5
	y9py8I8mEVXh9rRzQSx6DBA+7eb7ycpxjI7ANMIkQsv0MHDXH+s25xmf3e5rXx2DYpOO5iUva34
	NI/weGMqiDSFwpVR3Zub1aniWB86DnE0Ec68HA7nFjU3KUwS1tXSJKNhgRDS6zbjuIdAlgUDke8
	Kimabtxg+MdXLhNlgTRXtXA+6f0UrtK8W96apl
X-Gm-Gg: ASbGncsr1ObBvrYD440sfpiGmK1GdUfXA7CykB3m797IrCg4/5x2KYNFqjfowcKO1EJ
	Bl0L2MIwssiAXDdOAax4VYjf+Oc0NqYC4fPAvyKObvuLpwbfaBsgC9ZQkBwMN03wVEXNrsxHGFY
	1zb3z+L3Tlnmk=
X-Received: by 2002:a05:6830:44a5:b0:72b:a9f0:50 with SMTP id 46e09a7af769-72c0ae46583mr2281080a34.6.1742569323110;
        Fri, 21 Mar 2025 08:02:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzpcflRd3grvgJw7oYf7w7riEHFM2LiOJmYWlN+Yk2EYNXdODRH99L7hJO0uAsI/7DXMs7laRP2j8+TeIOHbo=
X-Received: by 2002:a05:6830:44a5:b0:72b:a9f0:50 with SMTP id
 46e09a7af769-72c0ae46583mr2281033a34.6.1742569322660; Fri, 21 Mar 2025
 08:02:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319230539.140869-1-npache@redhat.com> <618b8578-1897-45e4-83eb-b725102ab27d@sirena.org.uk>
 <CAA1CXcD4dOUWOXp0ODSEo4+g9_QQkJe1tmX3bVdcs3N_PPdSHQ@mail.gmail.com>
 <a0fdd818-a4be-446e-b18e-0c655bc94c9a@sirena.org.uk> <CAA1CXcDPg7Na9biCMOx4i_xwXZ5Y_qq-7SiYEU82v2a6TFpMJA@mail.gmail.com>
 <Z918-4psPV3j9c-d@finisterre.sirena.org.uk>
In-Reply-To: <Z918-4psPV3j9c-d@finisterre.sirena.org.uk>
From: Nico Pache <npache@redhat.com>
Date: Fri, 21 Mar 2025 09:01:35 -0600
X-Gm-Features: AQ5f1JpT3vyW0yGQ55DsCJSyymwDfJyOoIrPkZeKHZVfnPxN0vElQflPBO1DXGw
Message-ID: <CAA1CXcD4GRQhUf6BZ+STdKTpvzGKTA-kVidbcGZsKabu=_y6Sw@mail.gmail.com>
Subject: Re: [PATCH] kunit: cs_dsp: Depend on FW_CS_DSP rather then enabling it
To: Mark Brown <broonie@kernel.org>
Cc: rf@opensource.cirrus.com, patches@opensource.cirrus.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, simont@opensource.cirrus.com, 
	ckeepax@opensource.cirrus.com, brendan.higgins@linux.dev, davidgow@google.com, 
	rmoar@google.com, johannes.berg@intel.com, sj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 8:51=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Fri, Mar 21, 2025 at 05:37:50AM -0600, Nico Pache wrote:
> > On Thu, Mar 20, 2025 at 4:49=E2=80=AFPM Mark Brown <broonie@kernel.org>=
 wrote:
>
> > > Simply adding it to the all_tests.config will just result in it getti=
ng
> > > turned off by Kconfig during the build since it's not a visible optio=
n
> > > so that's not accomplishing anything.  all_tests.config is not UML
> > > specific, it's for enabling all the KUnit tests that could run in UML=
 no
> > > matter how you're running them.
>
> > So would the correct approach be allowing users to select FW_CS_DSP,
> > then apply these changes?
>
> That user select should only be visible if KUnit is enabled though,
> it really is library code so shouldn't actually be user selectable.  I'm
> not sure if there's some other strategy other KUnit tests for libraries
> use.
I'm a little confused how the FW_CS_DSP config which was added in
v5.16 is reliant (library code that is only used by KUNIT) on a config
that was added in v6.14. Presumably the library is not just for the
KUNIT test. What was the purpose of this config before the
introduction of the KUNIT test. Im guessing it was not user selectable
back then too.

>
> > It also looks like FW_CS_DSP_KUNIT_TEST_UTILS and FW_CS_DSP_KUNIT_TEST
> > are redundant.
>
> Possibly there's more tests to come that'll use them?


