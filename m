Return-Path: <linux-kernel+bounces-317577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2730F96E0A2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 18:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2B29B20FBE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02271A2652;
	Thu,  5 Sep 2024 16:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sMLs3gNF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4C41A2559;
	Thu,  5 Sep 2024 16:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725555561; cv=none; b=G+cPBNkdC/BYUmLUmVkL3MT+xJiCYd0lzDmrvv9/Xv+2p3HD6rbs91DIN+5D/gl5hcM+kBOFZkTefkNPeOXHW10YpRBo9/N7gmZZnu5ru1SiKkVD2mmtr+bkY60xaXIyFvHXknzbfCV/8ctGDh+aR6Su1MgPE8PXMl0B/pYWxO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725555561; c=relaxed/simple;
	bh=b/RoyH2fpqJy/6V5fQZBvn2ucu8QGt9PcR14NPSjqzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EfegiYaDVv0Q36ynVtRXpY9Gr+45ySRWgz+/bDh3Ka9aQhtCjE8maHU1XOEEPYydWZIZ3oU9q07sjg/olLCfe3AufDse5OpHM3FR5/3q80YN3R0Csqd5TMN2oGZjGs81T6fVft4S0Oi9AM4GyfkiKqheIvAbPXqv8JMIHualIdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sMLs3gNF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9514CC4AF09;
	Thu,  5 Sep 2024 16:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725555560;
	bh=b/RoyH2fpqJy/6V5fQZBvn2ucu8QGt9PcR14NPSjqzQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sMLs3gNFTsAHf72BdBsl7em9OUMOFdc6ztP5C0RtwdvBTqxZ8uS2IBTYoVnpFCDqM
	 Sm9bFMGC1VU4hxtHkDkfyC4X4UM7zO4PSQY4DNAQ9EVDoc5wQry6Wc/Mf8cyRGfgVJ
	 730QfADELtQVtT3jir1YpfwzjgkjOgr9NTkJu/NcQOuSo46+JIPx4GP/jLo3FALwZ5
	 u++rE8oUZYSnnXbeCESefLFeIOL/r+OSgfBOzvxDoI5g+SO8+Y6Twz5pykEs6Iu+13
	 psLwKiup5AGJ9J6OpNr7n2WkOcbTyQyQUTGiD/2tuQlxdlsLhxXxD5uoPdgn+OUYPm
	 aK262VPCstq8Q==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53436e04447so940372e87.1;
        Thu, 05 Sep 2024 09:59:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUaBg9j8jPnjOyESsdipjTbDF9iJJI9GxtqcqvypSbo5t68Q1oyz9JyNtDJLprPBdznR59Pu0h4fFNNV1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlE/XI8dopFoLWwVWtn3yXUm2oAuVGL2wuRkVA/pLDCIJGZttj
	XtwdaXWCEshjuKcemnZpS1u6dIYdcXLsnNJo0iWZFdHMORZSfUsrxp5SCo/uI9ED1yF4Fy4jgxw
	Ya480MVLBAEOzR0Raaluf1rwVCw==
X-Google-Smtp-Source: AGHT+IFoFAONGYXdOGvO/9NwY/+sjcHA8u2Plrb0DEdo/+9Cta74IxJpeHkXH5lG6W0ziF8QBkQKZEwG/gQjy39DFww=
X-Received: by 2002:a05:6512:1116:b0:52e:fa08:f0f5 with SMTP id
 2adb3069b0e04-53567678b33mr2248269e87.13.1725555558903; Thu, 05 Sep 2024
 09:59:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904200253.3112699-1-robh@kernel.org>
In-Reply-To: <20240904200253.3112699-1-robh@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Thu, 5 Sep 2024 11:59:06 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLY-vNNMMRJvn5oBD8Rk2eJCq73NYuEoZKYyDYc9v6G_w@mail.gmail.com>
Message-ID: <CAL_JsqLY-vNNMMRJvn5oBD8Rk2eJCq73NYuEoZKYyDYc9v6G_w@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: incomplete-devices: And another batch of compatibles
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 3:03=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org> =
wrote:
>
> Another batch of compatibles unlikely to ever be documented. It's
> mostly old PowerMAC stuff found in DT compatible API calls.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/incomplete-devices.yaml          | 101 ++++++++++++++++++
>  1 file changed, 101 insertions(+)

Found a few more to add. I added them and applied this.

 1682m-gpio
 CBEA,platform-open-pic
 CBEA,platform-spider-pic
 gpio-mdio
 hawk-bridge
 IBM,CBEA
 ibm,axon-msic
 mai-logic,articia-s
 mpc10x-pci
 nintendo,flipper
 nintendo,flipper-exi
 nintendo,flipper-pi
 nintendo,flipper-pic
 nintendo,hollywood
 nintendo,hollywood-pic
 PA6T-1682M
 pasemi,1682m-iob
 pasemi,localbus
 pasemi,nemo
 pasemi,pwrficient
 pasemi,rootbus
 pasemi,sdc
 sti,platform-spider-pic
 i2cpcf,8584
 gpio-virtuser

