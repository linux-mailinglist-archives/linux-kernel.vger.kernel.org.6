Return-Path: <linux-kernel+bounces-337025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F95984451
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 13:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0481EB250F5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9471A4E9F;
	Tue, 24 Sep 2024 11:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njf9Sd39"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BE21C3D;
	Tue, 24 Sep 2024 11:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727176588; cv=none; b=fXICbuCV1y8IG+k868lPwveiKAFxjxSKsB1D5B8FNjxZqbFnGAzNqYuSEx+h7tKLR2rhsBt8GMDvKT0gVsY81nymY/wq/Os26fpjPZDOOu7RtQ+Z72DW9M7dVEa4qTPGuvivqRffXgRfiCgxj4Fy8rKUiU7GvXLq66LMTQ6l1Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727176588; c=relaxed/simple;
	bh=ZJnHAssklkneKFT4wY50362h9HDBf9imld/GaH8qaPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UzoGFTi4uI0ptuTGd4CyEg5859/Qv6/0a2YTacZXI+5ry+iaeGq19Hy68LNnhbihtQPJz71l+32r3FaRp/KcI1p5LO+vIeCpFVCd5vzTSzCmndR2QaFxFtGmB91OI6Lb1aZZb6iX9fblvXzfP62cYeuWqYYCAS4LRnaT2paBFRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njf9Sd39; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53653ee23adso4882797e87.3;
        Tue, 24 Sep 2024 04:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727176585; x=1727781385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJnHAssklkneKFT4wY50362h9HDBf9imld/GaH8qaPk=;
        b=njf9Sd39pBoI3oRFEv3D5UN1DgDFND4Htu80aD/oHSfRRztslLDzGwaFSoFti2zGFK
         7w6HAwNir37YUt1azhVjJEPNDDWZBmdHm/Dh3fVAX4J8DarAAUza43BeS9POEQlT1z13
         5ABQPZWDl9WXebb32rTbUjOAZN/aY3BTqosiCpW9Bi/kcIEPHnA37LFT7Ny0OJ+P+nfM
         kHbMnRGVJzprO+SYEY96babEowefDultKvbKVqmIDYbuAgeRD9+7ljORsZJKSe40bg9y
         g/h1pHgydLAyendIVEgQaPYo9OxqdPfk9B/O+zMrlFQN12KINNM5OQSJCHH6ERN0KG/t
         S69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727176585; x=1727781385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZJnHAssklkneKFT4wY50362h9HDBf9imld/GaH8qaPk=;
        b=C6cyfFJAeEFg6Ej6X4JRbh1OiDvWyyVKW2/CkqW6x+0Dny/uRBljyMbPjAnzGHw60t
         EsxV7GUSYRTMuJu6rYisDiaDWgtOY9x2Nas5We2kK7FmgGgyZ5HnerZItiap/adQvjD7
         1TqIdl6Zj9BD9WtVQeN61LABYScffCUUzWTflJxePkz8FApmxIdD0anhAkM5tuggCLMC
         PCPIu7e22ODkT82WVE8DJUthhdA7cQzzXMMPzVC9oRmwo63BsKHAhUKpk1iNon/RB834
         0Jm20jxMvmiWuWVVSqukUZdYaIpSMAvj6MMCgXPDOt3oT76tHqRZPDSmFHrTC17fmKkZ
         oReQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaMG1B8JFXoHMMDyuAK5heO3bq1S1u+52HQoCbFyyZ1ZWTMrDa3tnugdm9TRJIFjk6QGiITiW2gc7uaNf0@vger.kernel.org, AJvYcCWl4JqtDeRD/mAWA34uTQaWaOmTxlH+/cziB4AuyhhAp06QgoVHAOCe4TmlvuA59VguKAZ5Gzm5b8Kn@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvl2hgmM3XLadQfxs09F8iVRpP7Yfm6xBnMlURKBEs87U2B2UA
	3SkkEgYftrbl11kiiFyqEQi0T/Sh+GJpqpeEujdYEp/a1mb5X2nvosFm2YBmdByHIec0HRhh9L2
	6XY4gmMSvQQ7Jvh4LIZ61R8wwp8s=
X-Google-Smtp-Source: AGHT+IH4+cT4zwWzrFXVe0+tKnEFzRr7bKyh0GsnjCOocdPkd+rrwFhT4V3C6MLZrLtYNlVPd5V6oGwHQ5ZqeScaddM=
X-Received: by 2002:a05:6512:ba2:b0:536:554a:b9c8 with SMTP id
 2adb3069b0e04-536ad3d4ed8mr8466982e87.54.1727176585070; Tue, 24 Sep 2024
 04:16:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240915114311.75496-1-laurentiu.mihalcea@nxp.com> <20240915114311.75496-3-laurentiu.mihalcea@nxp.com>
In-Reply-To: <20240915114311.75496-3-laurentiu.mihalcea@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 24 Sep 2024 08:16:13 -0300
Message-ID: <CAOMZO5DR7xaEGj9=mzzFPy6wB0z7-SmvXkMnFH-wSjs01hp=WQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] reset: add driver for imx8ulp SIM reset controller
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Liu Ying <victor.liu@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 15, 2024 at 8:45=E2=80=AFAM Laurentiu Mihalcea
<laurentiumihalcea111@gmail.com> wrote:
>
> Certain components can be reset via the SIM module.
> Add reset controller driver for the SIM module to
> allow drivers for said components to control the
> reset signal(s).
>
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Who is the original author?

In the NXP kernel, the author is Liu Ying.

If that's still the case the Author field should contain Liu Ying's name.

Please double-check.

