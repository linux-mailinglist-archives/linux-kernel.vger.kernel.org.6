Return-Path: <linux-kernel+bounces-196988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 666A98D64A3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CDCC1C22165
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405BF46433;
	Fri, 31 May 2024 14:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zm+OGz41"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062872374C
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 14:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717166334; cv=none; b=aLb0CkQpETYLxQcITps1fOIg7wlUpVafWqBDE74Rqd74sMGBsfKiNFF97nZcUJQy3NcHvReBqFduFCsedQueYKmDS0Xh6s+Nkj0PKizN1clH/7GZuzdjBa3Iydfy6rvPSxe9M8OYX0T0xcwsELjQP2dqt+x/Iw4pp0IBZiZKbxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717166334; c=relaxed/simple;
	bh=rD1cK89x0gwQ1Akf8e1MCQlJyJh8IFbiQBAk6Tz76lQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AX4Z6pPj+/4+J5eLcToaCQDY3F8XTPMidb/W2DeJyGhyd6r+CTnrNs3qT0PD3oE1vCM5gOjQiA9B3iGXceC7KLOHAlbFymNbLK/DsXEkJ05OWTgk2sob/bf7GNTg2CBqIeZmoMJSsvBguHHaqkLdAgViOuRkhXvyfszMJy7xeNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Zm+OGz41; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-43fd1a5a586so12104081cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 07:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717166331; x=1717771131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w93Mo8Seh4Ih0DonXdf2s7kp6WzdgYrxnnUHUop/6+s=;
        b=Zm+OGz41MEclD1zgAeEIXDyo5f2VH5NXEgf34IBqCGkgJkfp+cNoPNn41yXCOHHPyT
         1HWbn3Kc3J+8f/ALD3EyuDyDJ8RkXSiPaKr1E2KFLZV6mqChf6XpfBi5dwCsudeX0UaH
         se0hSn87dCD6H/jq2UaWOxOMmzh9zM/blGlgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717166331; x=1717771131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w93Mo8Seh4Ih0DonXdf2s7kp6WzdgYrxnnUHUop/6+s=;
        b=Gs7r9zCuB7ZZENDHbMx0KX/EqpbsR7PRT3G3n9T78rPc9byThkcSv5kZGqoMSHSjGr
         ra9PJTL4PkzPZBIMn9ylCpv8qitnTjtQuDpse1VBPsFa2A8D2kzyzuVyb51h4Tfkyeez
         /+XivTFBJ200GtSWs2AqtxuGNC4arr2SjPe793DxgHmbzehT224/HBisXA71LSLsDNrn
         TmD9VqMmLac4SsxBGyDKq/TIxbZxOH2/ot0dGFTIIpilqczND2op8/b/5E1qWBIOw4D+
         HIstrrfi842w9+aunefriJQ7780bPMjakxwj9HJmDw51186TIfTY/6Yg2kmmC5OT5VW5
         4mMw==
X-Forwarded-Encrypted: i=1; AJvYcCU9+TBMsh7MHr2fCUfF7mzba0s2MGF1xjeWBc2bxoSMtWlqRgUM6844WUgwy/fyTDkJRuCBXn9kbVEM2OjH8yVUVTsjVemjBkPrWoEq
X-Gm-Message-State: AOJu0YxYC22EVjBNP1QgltyOu1aXmoaFHyB2KqY8gSyOJjtcaa4xd+n3
	nZMgLNDCLh65ch5rZXL953IbYgjBJcPV3vStpnV5WNz6y/5MDycN0bZ7hKlVFtxzvpjNMM3oFd2
	O1Y2J
X-Google-Smtp-Source: AGHT+IF0bQRCtjz+BxLg4yv9G5/I3G1V0/T1ni7PzcZr6M0I3y2tFs5nflAHGPHZIMLNRB3K0Sfmmw==
X-Received: by 2002:ac8:57d0:0:b0:43f:f018:6a79 with SMTP id d75a77b69052e-43ff52b67damr22097571cf.44.1717166331477;
        Fri, 31 May 2024 07:38:51 -0700 (PDT)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com. [209.85.160.176])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43ff5b5d475sm5950811cf.55.2024.05.31.07.38.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 07:38:50 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-43f87dd6866so390521cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 07:38:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWGZ7jCKOSSAmGLLYDc1uqz0S6MR5C5J5C2RYcR9Fr7cWyBap9CzjWjgq/wBg6kmsejgQoPjPnXE3qHlBTwZaUMznRF7N4AvO9uVwJN
X-Received: by 2002:a05:622a:2596:b0:43b:6b6:8cad with SMTP id
 d75a77b69052e-43ff2c53bc9mr3353421cf.10.1717165910903; Fri, 31 May 2024
 07:31:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530082556.2960148-1-quic_kriskura@quicinc.com>
 <CAD=FV=UhrCKCv5R-LAAugrLXFp=cDcj2=Pp9-N3qk5pk2=sGEg@mail.gmail.com>
 <e732257d-cd16-4e81-9a20-af481184ce0e@linaro.org> <CAD=FV=XO_8SwDLJfoNwwCKEO6CZyMRMY_BdsWMLPBkpczErppA@mail.gmail.com>
 <d61ede0b-f689-46af-9bc8-e715784b86c0@quicinc.com>
In-Reply-To: <d61ede0b-f689-46af-9bc8-e715784b86c0@quicinc.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 31 May 2024 07:31:34 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xwf4eW+zwPecDg5855nVEY2NQMqpvHu59_e2xma6=wxQ@mail.gmail.com>
Message-ID: <CAD=FV=Xwf4eW+zwPecDg5855nVEY2NQMqpvHu59_e2xma6=wxQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Disable SS instances in park mode for SC7180/ SC7280
To: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, cros-qcom-dts-watchers@chromium.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stephen Boyd <swboyd@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Matthias Kaehlcke <mka@chromium.org>, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	quic_ppratap@quicinc.com, quic_jackp@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 31, 2024 at 7:27=E2=80=AFAM Krishna Kurapati PSSNV
<quic_kriskura@quicinc.com> wrote:
>
> > My only guess is that somehow SC8280XP is faster and that changes the
> > timing of how it handles interrupts. I guess you could try capping
> > your cpufreq in sysfs and see if that makes a difference in
> > reproducing. ;-) ...or maybe somehow SC8280XP has a newer version of
> > the IP where they've fixed this?
> >
> > It would be interesting if someone with a SDM845 dragonboard could try
> > replicating since that seems highly likely to reproduce, at least.
> >
>
> Hi Konrad, Doug,
>
>   Usually on downstream we set this quirk only for all Gen-1 targets
> (not particularly for this testcase) but to avoid these kind of
> controller going dead issues. I can filter out the gen-1 targets (other
> than sc7280/sc7180) and send a separate series to add this quirk in all
> of them.

Sounds like a plan to me!

-Doug

