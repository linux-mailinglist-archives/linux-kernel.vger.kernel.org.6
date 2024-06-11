Return-Path: <linux-kernel+bounces-209371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E75CC903365
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 09:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90B191F21BC2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 07:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB97172BAD;
	Tue, 11 Jun 2024 07:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2lKctGA"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F136B17276E;
	Tue, 11 Jun 2024 07:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718090611; cv=none; b=ujVr+zMXMSMuV6a+oRTOiZZa80C/AschUpZPr7AFBjhQ9lo2FO7+GT+yaYSX7Me8mVce5oDcZbOesyK4FWAmNbySQFrNb0pGt6TYj9J1B8w9ZebTmrmbsv/KSaLPg5IaG2LKSsmlxdqaIAxNJvO2/fSU0i/MdAjWnvCQ8gHvzqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718090611; c=relaxed/simple;
	bh=nDrssp+bBTxoQDRBYw43e3N4BsdJZeAoY+vczE9R6sg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZJO7wfnoTZMLG8ZTmPNfRsFr+38oy8r/5nhi1DnoTIEzCJ5WLei9gdEsB0Ka7PcOnYZjjPVdEKoDPIwHoUqlpA6UyrCf2ukXbhe7TTiqUbnpIcXY93irNIMUM3Jrka5Z5zSm5eC5F+OAKZVIYJcZ0LZibekLWRrXtr0KeG9YM5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2lKctGA; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ebdfe262feso25398391fa.2;
        Tue, 11 Jun 2024 00:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718090608; x=1718695408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDrssp+bBTxoQDRBYw43e3N4BsdJZeAoY+vczE9R6sg=;
        b=Y2lKctGA9ePGO1DzoLKAdDKL+FDEFxKsP5fAKenr9Ndbx+tCxfByJMz5bCljlEOUbD
         YGyibKa96Y5nH/2ecvQXxgctDAMH1SQRQAjx4wM056sVyYPTWRIiA6e2cYjd4hfjBXzc
         oedzzqqpynK0Y8Hi12U6cTWX7R64cLL4XSNoTWkUidEYqKc6zUGklePyQGy2ROwTwzOr
         SrYYa1Tvn8hZte3AJ5ZFd31D6VfLZwb7w63/FjW8BexQF3PhnK4HdWTiA6JyYLhBrqqs
         aHevBnGkQbrWtClwANUEbwDAloHejY2cGkCm4pabHxIe9Mrw9I5YOyS2UM3Kt+JEYgp0
         NktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718090608; x=1718695408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nDrssp+bBTxoQDRBYw43e3N4BsdJZeAoY+vczE9R6sg=;
        b=onfAnZob8tWkmnyJjsREkzDOEsICOhySBE6Owcnokm6Vi+Nhfg1TXrdMaTxT/QvlJb
         2ujhzUjGixJl3pc3/QWrVrqlMj7TtDCQirmxW0Hnk8TXOf541mRplxBTpgViRpsNlyPU
         wX0nWT3L9c3RCQFDIgGtVFeNS5dbR+TwC7sz12KjpIIsx0/bLB/RBjTjK6YP9uH64lme
         rmBvHTICHcCtKpJDTxQoAE4ovI9bvxGMCWQIuFVh1lHovaTaEQ79C91mrLadNTMzdo+t
         e6Ag3GpKz0SNyVVQL6z6q631ecnVWM2S8xqWQYw0m4VDUimoy8Fctw/JLWUXI3vw040j
         xlcA==
X-Forwarded-Encrypted: i=1; AJvYcCUcpRRYt3sHsp/Miwxbp+2HbGgW50SDywvEHEMGysQ4K4usCu8dWe+Uw5dfKDjDTQq7jbpypX6n6/DHLDviUbXNU7zMB+/CujDCSjNDd7TIu8eB7wuVN7DtZehn5O0PNCnEQ7stBIw5yw==
X-Gm-Message-State: AOJu0YymiPxZPf7y2J8OWGMfiTSn+1fTYWAOSiywE1WeBrLUsxPUA+MW
	szFY5pVHpxDJ+B3PDm5LhecDpZX7CQWTIveYBUdzpwtV8ZnURu4R0G85VwlcVsiJfRdv5aw6m9d
	rV9j4/+IKKbhl1Dq18nwh6ljiuIs=
X-Google-Smtp-Source: AGHT+IH1FbJK9HA8zmmb6Nf6apbJyBM4N/7iGRQRtBvNpb2wg58NXMYD6C6i0Fh0AoTBoUzS2e1dB2SMWvBzns3EJpI=
X-Received: by 2002:a05:651c:549:b0:2eb:e42a:aa86 with SMTP id
 38308e7fff4ca-2ebe42aab95mr42723911fa.28.1718090607802; Tue, 11 Jun 2024
 00:23:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611035329.33648-2-kanakshilledar@gmail.com> <398ee3a7-513e-4dd6-8ff9-b7585f005d28@kernel.org>
In-Reply-To: <398ee3a7-513e-4dd6-8ff9-b7585f005d28@kernel.org>
From: Kanak Shilledar <kanakshilledar@gmail.com>
Date: Tue, 11 Jun 2024 12:53:16 +0530
Message-ID: <CAGLn_=u9jnKL1Y=-+d2-A6BrO7xDZJS4VHtwO=mBHnww6qOaew@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: reset: brcm,bcm63138-pmb: convert to yaml
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	William Zhang <william.zhang@broadcom.com>, Anand Gore <anand.gore@broadcom.com>, 
	Kursad Oney <kursad.oney@broadcom.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Kanak Shilledar <kanakshilledar111@protonmail.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 12:28=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> On 11/06/2024 05:53, Kanak Shilledar wrote:
> > Convert the Broadcom BCM63138 Processor Monitor Bus to newer DT
> > schema. Created DT schema based on the .txt file which had `compatible`=
,
> > `reg` and `"#reset-cells" as required properties.
> > Added one line description which was missing in the original .txt file.
> > Added Philipp Zabel as the maintainer (took from MAINTAINERS file).
>
> One of the necessary steps EVERYTIME you make conversion of some random
> binding is to grep. git grep. You grep for stale paths and usage of
> compatible in DTS. Sometimes you find nothing, sometimes you would find
> something.
>
> `git grep bcm63138-pmb` gives you:
> 1. stale path which you did not fix,
> 2. duplicated schema...

There is `brcm,bcm63138-pmb` defined in "/power/brcm,bcm-pmb.yaml" and
"/reset/brcm,bcm63138-pmb.txt" but they both are for different purposes.
By stale path are you referring that I will need to convert
"/arm/bcm/brcm,bcm63138.txt"
to DT Schema as well?

> Best regards,
> Krzysztof
>

