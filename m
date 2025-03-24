Return-Path: <linux-kernel+bounces-574231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B7AA6E24E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 19:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2604F16B2D6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 18:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18B326460A;
	Mon, 24 Mar 2025 18:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VDNbC9nW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AC286334
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 18:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742841139; cv=none; b=nmRcvTBmR+nOItcMmKmFIoboiiVszPS/ivw9TyPONjBmPc98lFK5NmalMAaVg4dMu3tyOprY3QV5MW1Wxbw0bMk3mwBlpy/xYAAPe+j2T30hjm928MPOIw0gbS8TmcI6iJAsyofK2YVLJJYa+tMgR2uBWHUlcFCvZupm1fpmAZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742841139; c=relaxed/simple;
	bh=oakmLv2iqqzFhbF19BFPyeKtzxaV9nY+233remOab00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hczu5o+XzZpInE0L2aLWspQ3isLp5U/+lMlrrTWNa/GyKQIpE+UhsHJJzSi34qo13etqTaZ/C3qKV0T5W1R4hobO/DPJPsnLQzpCwg0HIJbsPRi4uwji5a8SYDKbonsmYymCHZeWtnRfVF1lJtMMo6UYLx3kbzCgRszog+sC01c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VDNbC9nW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742841136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NIigy3hykJg74sKLis/PR0k/snmQ9fhONRhiiia1oBg=;
	b=VDNbC9nWzbUuS2lMuzlcGvGNJCfSqLt+AJVOrOrmHQiDBKliZIo4gpI3mK6bvuZwyXlmfc
	rXVbuEnKJr4ncy2Ubnxzsadi4PW2wSZ4cGFjJEVG/jndA1c4u4W6BmLoTRteaF+L0ZFWQC
	2URVn1U+pymEaARCjts+b5EiEHFXDXM=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-XfyUAxgKOVafGPQhjwA32A-1; Mon, 24 Mar 2025 14:32:15 -0400
X-MC-Unique: XfyUAxgKOVafGPQhjwA32A-1
X-Mimecast-MFC-AGG-ID: XfyUAxgKOVafGPQhjwA32A_1742841135
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-e5742f52896so6916273276.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 11:32:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742841134; x=1743445934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NIigy3hykJg74sKLis/PR0k/snmQ9fhONRhiiia1oBg=;
        b=L35SkBUKJEq9DooEyle3Gf29LXnb6d/ue0HkJXxwzSoEc1y1Pc5J+E+8/HGHNbRWqU
         P37yvG7JmnxOSN0vFOhIhauzzczgQKPZfSsL6lTVP2q7w4SHud+abxaj2enn/NKLUCp/
         b8rLYUCHbp/dzK6zM5/li2zuHlImAMJm8U6sHGhGbrsO+2W18GZBURNor48ydl8Q5SUh
         CHM3cxVblGchkcXrHbxWmFndbtHrLSYCCTMIVJIskYSZe0qt+O9XQIV6p+rwIJfCCmfw
         8fVAzvHwa8fbyUirOtJzRGLPNW68bu34NIteEE4IYRQRtfWSgS+zF3AWCHCLAeYw7pah
         5QQg==
X-Forwarded-Encrypted: i=1; AJvYcCUa1SlYFMzi7Mh3lGXwDKMKvaAB5J9XL9+9pPZJAxGvU4Hz42MJGK64sT3qYyI3vM1q2Sq0UcBflzAx2eg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVn8UEccQ17ZMb64681OHkxly8S70wXZXTGvVs+okOL9IvwERp
	9A/4Op6V+Gv6xuOUTmg4EMZhvXBF8ofnTodl5C77TEJ6wXuueprZAfNiNcNGCVeAIweQ+3w2QON
	XACLVMf17pSBzjJc26L7+BR8RDlz6QiTABLx8XIl4ubekvxKIihtFXffBfYGEA8QpGzgeTffC0S
	6iK4HZRp4yp2St6MXr85StBLCsnKs0d8/bWLb6
X-Gm-Gg: ASbGncstZikddap6EwF3lWkhHQfEnO5DzRjEUtY0ytEASzHtsn+w1fhwCbyjW/J63zW
	AgguJRShZvov62utBn8c1CfYoLmpqiZsBJ5RAN7kEtjIW5d2JuNidjd+oLo+LGBS703bykwvKo6
	2hPVMHTnHFPYw=
X-Received: by 2002:a05:6902:1b07:b0:e63:f29c:d5a2 with SMTP id 3f1490d57ef6-e66a4fa22bamr16831351276.41.1742841134568;
        Mon, 24 Mar 2025 11:32:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9ws+JDGDm1gVuKV1LfSdm9aU9cJw61EBLpnyfXX4knYAlcqws+BjCL3Vj0fieu6iBUOg5yEFNwSaBhfW7CmM=
X-Received: by 2002:a05:6902:1b07:b0:e63:f29c:d5a2 with SMTP id
 3f1490d57ef6-e66a4fa22bamr16831306276.41.1742841134230; Mon, 24 Mar 2025
 11:32:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319230539.140869-1-npache@redhat.com> <618b8578-1897-45e4-83eb-b725102ab27d@sirena.org.uk>
 <CAA1CXcD4dOUWOXp0ODSEo4+g9_QQkJe1tmX3bVdcs3N_PPdSHQ@mail.gmail.com>
 <a0fdd818-a4be-446e-b18e-0c655bc94c9a@sirena.org.uk> <CAA1CXcDPg7Na9biCMOx4i_xwXZ5Y_qq-7SiYEU82v2a6TFpMJA@mail.gmail.com>
 <Z918-4psPV3j9c-d@finisterre.sirena.org.uk> <CAA1CXcD4GRQhUf6BZ+STdKTpvzGKTA-kVidbcGZsKabu=_y6Sw@mail.gmail.com>
 <Z92K_azA7A7RoQ0T@finisterre.sirena.org.uk>
In-Reply-To: <Z92K_azA7A7RoQ0T@finisterre.sirena.org.uk>
From: Nico Pache <npache@redhat.com>
Date: Mon, 24 Mar 2025 12:31:48 -0600
X-Gm-Features: AQ5f1Jr0J9eiFX7PLlFrZ6B59zgwgk28sqW9whPZfij3QsQ32DiEhJeCrVa9m1o
Message-ID: <CAA1CXcCsYAdAaO-C=2f9PGdYCNgBYjdz=wjE9KdG-8xTkCrB5w@mail.gmail.com>
Subject: Re: [PATCH] kunit: cs_dsp: Depend on FW_CS_DSP rather then enabling it
To: Mark Brown <broonie@kernel.org>
Cc: rf@opensource.cirrus.com, patches@opensource.cirrus.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, simont@opensource.cirrus.com, 
	ckeepax@opensource.cirrus.com, brendan.higgins@linux.dev, davidgow@google.com, 
	rmoar@google.com, johannes.berg@intel.com, sj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 9:51=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Fri, Mar 21, 2025 at 09:01:35AM -0600, Nico Pache wrote:
> > On Fri, Mar 21, 2025 at 8:51=E2=80=AFAM Mark Brown <broonie@kernel.org>=
 wrote:
>
> > > That user select should only be visible if KUnit is enabled though,
> > > it really is library code so shouldn't actually be user selectable.  =
I'm
> > > not sure if there's some other strategy other KUnit tests for librari=
es
> > > use.
>
> > I'm a little confused how the FW_CS_DSP config which was added in
> > v5.16 is reliant (library code that is only used by KUNIT) on a config
> > that was added in v6.14. Presumably the library is not just for the
> > KUNIT test. What was the purpose of this config before the
> > introduction of the KUNIT test. Im guessing it was not user selectable
> > back then too.
>
> This is support code for DSPs that Cirrus have in some of their devices,
> the drivers for devices that have these DSPs select it - a git grep will
> show the selects.

Ah ok I see! I'm not sure what the 'proper' KUNIT behavior is for this
config case. But I'll trust your judgement and expertise, we can
probably leave this as is for now.

Cheers,
-- Nico


