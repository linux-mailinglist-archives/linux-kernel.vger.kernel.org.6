Return-Path: <linux-kernel+bounces-423708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9BE9DABBD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 17:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBC52165F25
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E55B200BAA;
	Wed, 27 Nov 2024 16:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wkTsPrSE"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C740200B9F
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 16:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732724653; cv=none; b=sWyRuzqxBoJifxlwqWb3YxbV/s2DJcEmSTrqsNXkatnbtOwWLuiWLAW65WOp/bM+TMfGylzR9kT3HBQqCBSnkdFV/FwuucoPBVJNsa7ZMHuj1MhfXrHl0/o88gmQ1JYVKoGux6ct/UZcRa4VGVec8qujS4PqB7SzyWSo94NfnKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732724653; c=relaxed/simple;
	bh=rKda9Awu4irodPKAZZW8j0P3UYNrlv+gac9bpLX6Xnk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MtF7Q/wTIgnIRWHBUyBIBp1qxnTqajbbvNZVQUJiNAytHfRR8YgVLTWYz3WuU+5INzr4qBMNo5g+qJ6jQ4EjAdsmTFzJlHvNfbxyz938zBWh5DTrvVUZxwB2p0A4nuN0orwtrD53psaMSW1lelggXTLzRhQzcRKWDhjiFld7DmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wkTsPrSE; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-434a852bb6eso15317665e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 08:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732724650; x=1733329450; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W3ci6YCIiDufTlH6QWOH+RcWY/SBARvhjUkFISOP+Eg=;
        b=wkTsPrSEQ20h6aP0HOoF/eQMNlrO/PBotYi55eoy0YzYFlPycEfeKlMiEhXrOiOw9H
         kFksT3vqU0zpUGQJXUB++m7fPwbmwclZ4DNSxdGP5eBoOzRDCsE1Vf8nArcrslNwA++/
         9NUXL0qtqmfYjlx6E8fbkbutqepwQfIyIsaWoQJSWdT+Nl1TxVeSbPfk4XBqlBgPJ/ep
         R+W5yBkF8kdrG5K3+uRA4nmtmOaEde8Q136HkBsLfs8+jKVOr3bcB3kgCfGIw00CldcK
         +XdxZUL/Ytk3WHNLPGVpz9wCGcP3ZLTFzDl07VmRtSADJI9Eok9agp5y08iEsSxEoxHk
         wbsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732724650; x=1733329450;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W3ci6YCIiDufTlH6QWOH+RcWY/SBARvhjUkFISOP+Eg=;
        b=oYK/UYcN0x6BmIMs5BwJz0kaPnJ/lNX14S2C5FsP6V7juSUWdSs4dMpK36iW1Tpt82
         UfGDmbV81xKJPa2tlotcv4++tTNamGRtd9i5rtpixapT1tbxfhkwj3fMz7IH8vV5pHXv
         Feg2oJfUwuKe9Dh0UvnoiWF+z1sak6pvoqPpnLeE3LTQHTYyyssHX6rl8KYMnvTpBS+h
         lnPPXMtZdBsfm2eQIoJ4DXk2B1lzKwtno7a26TQTA1lHoBN3QS6QZ8Sy9KlcOatYifr+
         PcC2l9do0w17MGK3VOLohM3NgO8X1huvlGgas6Qs9cXQKGTknKFjH2bEHLUtRze+T8+0
         kQmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJqOaGzGKgVorIcq7ktK3G34XcDmC3JoYjyafMJM2O68dzE3OLpJv4oq4emoCsJjdEdVPbJt3FetMoL8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjIasEXc3wq22olDsBrOOuPbVVYkO7FtmCOTZkrgfurADfW1zB
	piW0ht9pAozPE/4S1oDKvFHPnL75DpjUKIuLjPJzbZdM2kCAO3daZ+9IJ1JzCrw=
X-Gm-Gg: ASbGncu+QACvSTNvHpYzDJFTE7pd2QhWR4Rvc5D0aJwalXlsPfjgTBsLcULFt4UU4ZB
	L6abIGhhlPA7e0eu+ND71+iXpxVVUBLM7VMqXh7DM/lyB9PJ/o1zGBBYrj1rYbskd6Nh36NPeul
	pZHiL1YRlvIQu3Wels552m/lfIiG6I27OVO4kwWQLiE7gSuVkOXcBAQYfN4PPYuwCPmtyY4gCNK
	MlJPbtUCnunqo0KQoxih6qlIJ7QiFefH+c7Vq2UvcSCPtmKbtMb/w==
X-Google-Smtp-Source: AGHT+IGDZztPo405KuhE/5HQpdEcc6G4U1hi5a0UqN/AZl+cMPyQNrZOeFD27R5rS38JBrkH0dwofA==
X-Received: by 2002:a05:600c:354e:b0:434:a684:9b1 with SMTP id 5b1f17b1804b1-434a9dbbfc6mr34223735e9.4.1732724650556;
        Wed, 27 Nov 2024 08:24:10 -0800 (PST)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbc3defsm17311830f8f.70.2024.11.27.08.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 08:24:10 -0800 (PST)
Message-ID: <813713d8ac62be0782bcf36d1d23bec5f4a3c08e.camel@linaro.org>
Subject: Re: [PATCH 3/9] dt-bindings: phy: samsung,usb3-drd-phy: gs101:
 require Type-C properties
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Conor Dooley <conor@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>,  Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,  Marek Szyprowski
 <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Alim Akhtar <alim.akhtar@samsung.com>, Peter Griffin
 <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, Sam
 Protsenko <semen.protsenko@linaro.org>, Will McVicker
 <willmcvicker@google.com>, Roy Luo <royluo@google.com>,
 kernel-team@android.com,  linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,  linux-samsung-soc@vger.kernel.org
Date: Wed, 27 Nov 2024 16:24:08 +0000
In-Reply-To: <20241127-majorette-decorated-44dc1e7dd121@spud>
References: 
	<20241127-gs101-phy-lanes-orientation-phy-v1-0-1b7fce24960b@linaro.org>
	 <20241127-gs101-phy-lanes-orientation-phy-v1-3-1b7fce24960b@linaro.org>
	 <20241127-majorette-decorated-44dc1e7dd121@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1-4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Conor,

On Wed, 2024-11-27 at 16:00 +0000, Conor Dooley wrote:
> On Wed, Nov 27, 2024 at 10:58:13AM +0000, Andr=C3=A9 Draszik wrote:
> > The USB PHY on gs101 needs to be configured based on the orientation of
> > the connector. For that the DTS needs a link between the phy's port and
> > a TCPCi, and we'll need to inform the phy driver that it should handle
> > the orientation (register a handler).
> >=20
> > Update the schema to enforce that by requiring the orientation-switch
> > and port properties (on gs101 only).
> >=20
> > Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
>=20
> What is your driver doing if these are not provided? New required
> properties are an ABI break after all and I don't see a mention of how
> you're handling it here.

This is hooked-in in patch 8 of this series in
exynos5_usbdrd_setup_notifiers(). The new behaviour is gated off

    if (device_property_present(phy_drd->dev, "orientation-switch")) {
        ...

Without that property (i.e. old DTS or !gs101), the driver will behave as
before (meaning for gs101 it will work in SS mode in one orientation only).

Does that address your concern?

Cheers,
Andre'


