Return-Path: <linux-kernel+bounces-369677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADF49A20D5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D458DB23151
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 11:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AD81DB34E;
	Thu, 17 Oct 2024 11:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ia85zXEc"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4CE1DCB20;
	Thu, 17 Oct 2024 11:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729164135; cv=none; b=Ij+AqmY/41sdUMZ/G/WBUHLSgEQqsQSC03mKI4JbHF8akFk9l6wI5z2FUoM0TSfzm6MBNSPAP6vaJcWvaOiZ6Daz5wsMB7f9YZqVSm01hLche37phLGKK9mq62aIb/gDy3fDMs4gmrZ4rEhUmaLt1Y3Oupct5i7cj7qY2dxszzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729164135; c=relaxed/simple;
	bh=dg6kW0E7auxWV0POqBOWHIqceEqWu/lCqzB3gvn67SE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GigL7u43p0PhDzDbwvadXHBnzDpSy+njXONPLh9OKd2WgjUihnzS5QFw69bFLKfI20zilWPu6ponmSr6I+pVra2iT/Lu4bA6XI+fUSMNWsdnfV5AEYewZnEPLVL6254t/mVb5Ab670ABuKKNfxgXQz26iPpoy3+wRK1OtmxuUpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ia85zXEc; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539f58c68c5so1371448e87.3;
        Thu, 17 Oct 2024 04:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729164130; x=1729768930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Lpg70dVZFGWL0eBVtV0mgtxSnHXtZ24Juc2ryF+tOA=;
        b=ia85zXEcpGNyMzI66/RJB5UAPlXB/DsLLcG92DyP6irA2b3p9d+jL6iKQw+ydYkv7q
         0SYCDlKHtfa0tvWb/9Sv8pv3S5tROPSuTANJBoiEnzHkHhXe0ul9v0OwAIwTGbRU9+5K
         n8TxBsQw0FDqGsMo63gMoTMh2Eg1gqgT2Xg2T/H6qvL+48aYvxrUFMigU4oJOBMg1sgw
         Pb3dQWpI4wA2l0vOKusy6n46NKOt5VUG0bCEG8OYIavHXxj77iq6KFIlivFMYjICmvsf
         PYrHlXnBSP36TVbPCW0RsGR8YImpKS23QuSJywTENzSmoWo4+/YhsX+GIstT2PVdqDKT
         WLCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729164130; x=1729768930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Lpg70dVZFGWL0eBVtV0mgtxSnHXtZ24Juc2ryF+tOA=;
        b=BaC+zwQnuoWFj9nrfd5xwblxOWHVA8gpWi5EnyPKBzxX5VIO2N37R/uoXeyFbSUWra
         19PdbeJAtpRG1F0PyIFZKo7lKvc5wzhLkOg2XUd6Lm3GftF5B4NeEp3ZsRDl5HaY9PL+
         CV9sg4JQmn2MYq59+HeFSh62UGUlyFY/zOGAbm03DbvfVbqF47p+aK3QAZdAiVjvea5i
         DHfDTcBBJL0sNkVNFxRp8AsQbYZ6BjjjLDGXI/1rHkzyJ2wtDHX79ZCLazPueiNZIQ8s
         zusUn/RNvJwvEocPDosYEmn7WDj6zjN7uC6Xoh03WBoxyz5oaGicCuaj/I9gJgS3iPVC
         7mHw==
X-Forwarded-Encrypted: i=1; AJvYcCUbovIEG2YtRGbW3BfKDGSG3Apw5eKV9NUg46FltNtTKtFHitGg1QeTn7AI5CT7FO/xqu/8oJwmBTETsT0A@vger.kernel.org, AJvYcCVNb3rp7RIWzxvp9seyeJW+iI//UCPKHY/jOlQHW7p6fXVb943+oI3mdeh8kg57xSo4CHPCeNwWuJzN@vger.kernel.org
X-Gm-Message-State: AOJu0YzTrJww5dWpfRANxn0d0zWteXlCqpicw/YAQ/eLTODG7ocQbQpe
	iN23jjmDiLGC4POGCejOnYtKbZLUv6tx0ChGzvVvDJc+qQzn3LiJKbK/4G5Uj/n4x1WHr6bTdVa
	vUMD8rK7Mwzu/t2Bre4tPZdkXkqc=
X-Google-Smtp-Source: AGHT+IFmINcPbgxoJLt/7Ebjfjq3hSNSdJlHHzzYgp4XwPgYyWiLyCRbszfoBLoqzdmBxM4F5Jq7/a5nDiOmpi73fcI=
X-Received: by 2002:a05:6512:3a8f:b0:536:7377:7d23 with SMTP id
 2adb3069b0e04-539e571ce7bmr15312700e87.40.1729164129617; Thu, 17 Oct 2024
 04:22:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010081719.2993296-1-lukma@denx.de> <20241010081719.2993296-2-lukma@denx.de>
 <20241017103534.259584f6@wsk>
In-Reply-To: <20241017103534.259584f6@wsk>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 17 Oct 2024 08:21:57 -0300
Message-ID: <CAOMZO5DkmU4C0YQoVwCbHTBo=DTRGcz+9K1qHY=3V29eWAfEKQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] ARM: dts: mxs: Add descriptions for imx287 based
 btt3-[012] devices
To: Lukasz Majewski <lukma@denx.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Stefan Wahren <wahrenst@gmx.net>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

On Thu, Oct 17, 2024 at 5:35=E2=80=AFAM Lukasz Majewski <lukma@denx.de> wro=
te:

> Stefan, do you have comments for this version?

Rob's bot reported new warnings after applying your series:

        from schema $id:
http://devicetree.org/schemas/display/panel/panel-dpi.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: panel: compatible:
['panel-dpi'] is too short
        from schema $id:
http://devicetree.org/schemas/display/panel/panel-dpi.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: panel: compatible:
['panel-dpi'] is too short
        from schema $id:
http://devicetree.org/schemas/display/panel/panel-dpi.yaml#

Please address it.

