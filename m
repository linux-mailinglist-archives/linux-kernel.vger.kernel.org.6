Return-Path: <linux-kernel+bounces-285401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7932950CFC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 21:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9038B286E67
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4CD1A4F1A;
	Tue, 13 Aug 2024 19:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="u2qUM5LN"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511CC1A01A1
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 19:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723576521; cv=none; b=lyka16PPc4SBSQdCGkWTIAbuxa+GKPDFi0pqtm9ktSSdsrFAZU4gmohJ5RbUPU3QvZUQgaIrG+REmJMYzV6EvvhD4nTBdHcKSaowhSiV6pIq6xPpo992PZAGhxU+X03fq/2MaqD8Po90g+46dBdQW6wfA/kgLM1ofGHi6LmqyMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723576521; c=relaxed/simple;
	bh=U4Xyoz84NINmS5YaWTDoCODzk2mYuYN1PlkFZg6Da9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YReNRxh21SaNNrUxsyUf/lIlj0VEPWfK7J3c4j2gYVnE2YW3Y03T9ldM8O1P0sPS5EA2jx4jXXXnaCC4YGmI/eplY+ZyCazdnMLRHCFQXzOUPtyd2QbibVF32c7gc3bw35YRccT+WN7x5zQQTKn8C6VdWc//RuTkjxfeP8e/MUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=u2qUM5LN; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fc566ac769so52148265ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 12:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1723576520; x=1724181320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4Xyoz84NINmS5YaWTDoCODzk2mYuYN1PlkFZg6Da9o=;
        b=u2qUM5LNzTRDS65lVfrgve2nGnWnCpaCIKNX1X1oyF+GjldBkVZn+H0wzpJFgCum8S
         B3TE5+mm4onsKwhkN2IY2qMorv8n1kAk9vGjy8xBbrZiz6QAPnDOIx35of9AJH1j43uV
         eSjqZLTyn08ZOBvL/7mhDEFf3r7iXSsQgSsVwiqPhZB23Btf2yWlNZIHyiX4d0iRHk5Q
         vnMKjYP20YR/SFL1DpqxSfde9VHfbwWXQpSwWGSdkn8fkJCXU0qY7PdUZEfLtaRf60Rc
         P+QVesUPwEr0+ZP/BVwzjD9Kvmz+8uc4J8+zuZOFQnCGxXbpByFnW7DTuhjULfV2r4W8
         OeNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723576520; x=1724181320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U4Xyoz84NINmS5YaWTDoCODzk2mYuYN1PlkFZg6Da9o=;
        b=kD8iI+j1lVMwRKOhc65xLfb9nAS2LcWSaB75w5m+3nWuKjwkwhBLrSU64vcI+VMmDj
         ko8tBoiYtTT4SWlZ09MKVfbxvJsb3lFZejhGU6C6whikQrBQBsWHgLIoCN1wwKPvOOOp
         4C+SNUCRuCyuabufYUTf3IgTTc995gdchiwm/U73a1ILWF3FL8goG8czjQgqgeF1gVE9
         Zwkp+0PxX2jY3gXzK783ahBn/jE+OM7dppI+x6hcwz+DhUNSMDl02hm4WaC1OpfkRhBF
         67HyPoDO5vrpsc2WbWkEABTSWwL7pYr5KKAu9ts1egyF8w/r3MwTWU6wWU14refPo+of
         WpFA==
X-Forwarded-Encrypted: i=1; AJvYcCVdY80Bp63ucKpgFNILyZ6oKIZCZ5Ulzna6S9Uv8MEmKDBbibmmYbXumBE+bSDk27LrYXI+HqgssFUs19eoJINAhjmK6W0Ul4Akzm+t
X-Gm-Message-State: AOJu0YyCQ4tt6aFPph4n1vyWwIiRc5agPeonx2r+ZlxTSh3dKssmRFlV
	Exkgw3r++nbqQft2KeuOKsH53oMJCBPfOqter98ti/QsxNirKct50zH+GzCcoLG93S/KfmJ4Wln
	8plFeuSH+bXDemakork+nP+haxqTx42ZYbMxbPg==
X-Google-Smtp-Source: AGHT+IGLVONXb2C6YyhnguQvraZmtCfSPGP62p2pX40XsG5b0xAUk+IJq2D5zMhwvCt/35J4267uGhv5ZbOf+n8Ce4E=
X-Received: by 2002:a17:902:db10:b0:1fd:8eaf:eaa0 with SMTP id
 d9443c01a7336-201d645c66emr6228805ad.38.1723576519642; Tue, 13 Aug 2024
 12:15:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240803-qps615-v2-0-9560b7c71369@quicinc.com> <20240803-qps615-v2-4-9560b7c71369@quicinc.com>
In-Reply-To: <20240803-qps615-v2-4-9560b7c71369@quicinc.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 13 Aug 2024 21:15:06 +0200
Message-ID: <CAMRc=MeWFs+M+2kpotRqmcbPgXx8xCWEa-DqatGxWUAcixQb2g@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] PCI: Change the parent to correctly represent pcie hierarchy
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, cros-qcom-dts-watchers@chromium.org, 
	Jingoo Han <jingoohan1@gmail.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, andersson@kernel.org, 
	quic_vbadigan@quicinc.com, linux-arm-msm@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 3, 2024 at 5:23=E2=80=AFAM Krishna chaitanya chundru
<quic_krichai@quicinc.com> wrote:
>
> Currently the pwrctl driver is child of pci-pci bridge driver,
> this will cause issue when suspend resume is introduced in the pwr
> control driver. If the supply is removed to the endpoint in the
> power control driver then the config space access by the
> pci-pci bridge driver can cause issues like Timeouts.
>
> For this reason change the parent to controller from pci-pci bridge.
>
> Fixes: 4565d2652a37 ("PCI/pwrctl: Add PCI power control core code")
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---

Tested-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Bjorn,

I think this should go into v6.11 as it does indeed better represent
the underlying logic.

Bart

