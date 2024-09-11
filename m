Return-Path: <linux-kernel+bounces-324739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B085975049
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B72F129022B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A874185B4A;
	Wed, 11 Sep 2024 10:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="esdDKz+F"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640E93BBEB
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 10:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726052212; cv=none; b=XTKAoQFrJuY2bu/9AikAREoiuR1Yg7CL9BMvLPxgDJ4AwPw3eGHM85/htoUMJaS1hOKO2NGxZE3UWBSktcWF8PUqfgmGBrKdiIriYD/elMQlimzLAZgyRfUlsNG7XAvmLSLeBmqo8TjexoPDkzZ49aHjIhH16RktXc3+GGGk34Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726052212; c=relaxed/simple;
	bh=yMM35HUT7miV6QtJLuFsWwf5iXiMbNclaktulBrMxBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=itlQU/s0b/et/Gegk5Wz6j0IwzmsIdy/RUgsrP9ow7JM/Cfy3ASom+h93Rmp+cWbOJY/wWFVjqzVT0sTiP/QBvNZpQVY3+SM8uNxMvMZTaqzuRJIxo96Uiey/gFnPb0RJriiSObzJgRTcLha82hNQ2gdyVpjSkkwkhw23VLa8a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=esdDKz+F; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-846cfc2f010so1646883241.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 03:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726052210; x=1726657010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMM35HUT7miV6QtJLuFsWwf5iXiMbNclaktulBrMxBI=;
        b=esdDKz+FLLnnv+74bU0OZyTntKH9JmUujHJVdGmj8eiIGqnzdJXUZ/GIi6wzTRdLX3
         rPPBIY0TqziqyApGiPLVnJIzc3aPYvkpBAhYb+P2bgAcLMyWhzfh865WKA310ZQs4/fc
         T7/m82ZXTIV6pmkmxdbFDq4cgl+3u0Fqb3aDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726052210; x=1726657010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yMM35HUT7miV6QtJLuFsWwf5iXiMbNclaktulBrMxBI=;
        b=W/L5pl4HvyExnDSrGdqRQP4jOoOiEpJjCv/0pk0hNoCVxdrP5X09XV/3baL2WW1srP
         pDMcXzyAbCF3z8PArSfm4yBahtkzGYgxU1q8e0vsayPDwgQAOo+d0c05QbRaXB0doAAx
         93cDCvy7cRUmOEEbgdyHIqWKIQFdG5T4zTQk5ONxORjSf9HR5y03L+X53AbKwJaxbcLm
         8KWItU48NUu+2dLvqInzA+WtogVFBz3d+OrCimAIolEr2QnmAq66bj8xpGqoAC2QgYnv
         m5HX3TTBBOvgU9YqsTG8znr/PXVCM++/qsQeXstQoLFETzOzqgnLL7lVIdppVvBeDt3I
         p1gA==
X-Forwarded-Encrypted: i=1; AJvYcCVltgZvXzhbV76YvcA6KnU/1oDTQtWXtCxgaKqAioimAhVTEa//EgeoCYpWJ7tXrwJFRqswXA/XPaiY3+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz78J642QEzNOv4dPTOfg5SQ23pZaW8idwKVY9CDLXVjZ1+l0ip
	ruL9+YH3L2s+ZuSOQH96ejB12MqBDQRyrEWUasxk0qQKarzFjPeIkC4ZHF1sZDIJsPyGFiT5Pui
	rsQ==
X-Google-Smtp-Source: AGHT+IHoXCB5sOaUVW90htVtctuPx0e/6u5mOk2K/eW6R/+Kqu1/bGZpnGpHlfMx1MSI/pApYfw6aA==
X-Received: by 2002:a05:6102:a53:b0:49c:8d2:8ec with SMTP id ada2fe7eead31-49c08d2146fmr7053406137.3.1726052209878;
        Wed, 11 Sep 2024 03:56:49 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8489acacce5sm947398241.24.2024.09.11.03.56.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 03:56:49 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-49bd2b37fe9so1843536137.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 03:56:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVMcnNpubNBUgMBh5Un+a1uGaxXo3/aSw8O8YqCIqBFHskYbwJ17PtSgQ3npX+afUvXk2BtYew8TQ/vsxM=@vger.kernel.org
X-Received: by 2002:a67:ff82:0:b0:49b:f255:1779 with SMTP id
 ada2fe7eead31-49bf2551aa2mr6702532137.12.1726052208866; Wed, 11 Sep 2024
 03:56:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909111535.528624-1-fshao@chromium.org> <20240909111535.528624-6-fshao@chromium.org>
 <01020191e0b103c3-00fad6e7-f81f-4a76-a75f-1420574f71df-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020191e0b103c3-00fad6e7-f81f-4a76-a75f-1420574f71df-000000@eu-west-1.amazonses.com>
From: Fei Shao <fshao@chromium.org>
Date: Wed, 11 Sep 2024 18:56:11 +0800
X-Gmail-Original-Message-ID: <CAC=S1ng5+K5Rn7b6XVfm6rcJnBH4Ggm8vybSSeRgDX2tdv-VDw@mail.gmail.com>
Message-ID: <CAC=S1ng5+K5Rn7b6XVfm6rcJnBH4Ggm8vybSSeRgDX2tdv-VDw@mail.gmail.com>
Subject: Re: [PATCH 05/13] arm64: dts: mediatek: mt8188: Add missing GCE clock names
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 6:46=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 09/09/24 13:14, Fei Shao ha scritto:
> > Add the missing clock-names property for GCE nodes to fix errors from
> > `make CHECK_DTBS=3Dy mediatek/mt8188-evb.dtb`.
>
> I've sent a patch [1] relaxing the requirement for clock-names in the bin=
ding.
> There's no reason to make clock-names mandatory, as there is and there al=
ways
> will be one single clock for each GCE mailbox - and also the driver is no=
t
> trying to get the clock by name, but rather gets the clock at index 0 any=
way.
>
> Please drop this patch.

Acknowledged. I'll drop this in the next revision.

Thanks,
Fei

