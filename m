Return-Path: <linux-kernel+bounces-553965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC86A5913B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D8E43A945E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336AC226543;
	Mon, 10 Mar 2025 10:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXuI27M1"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E188B22578F;
	Mon, 10 Mar 2025 10:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741602657; cv=none; b=dXdWVlEWNmYkpNsptkT1DvWZFWlsROA3ZTLobUU40v/F0d+m7ylNy6A0iTGPoZ66CrQECZ3Nk6JFk1HVJ4hSnHpZoeWNgeeyebht5mTKmIVA6N81MHTHHimwniZpQYh5w8yOlD0uIn18mXMipg8zcVzjtWa5oAgqbKB+vtZq4II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741602657; c=relaxed/simple;
	bh=NgEc5/eyDsM2hrEW1RmGOqc9E+kFy+95H4SiztZ6Hnk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTmRmVjk7zuUqFNH5nofjHQiAc+EnPYMvfkZYsW1bqYac4h/h3dy+XRLWmz35pKtVb5n0n8/JVGd7q0PH9lGjqOpRI4BmkNseIiZGkwZk6MXqsLJedW17U/eQLxCQl9uXuwzg4Dw1Qy02NCxIxmkSLCNh9C58s0wxaq/Z/2xgX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXuI27M1; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e66407963fso2235499a12.2;
        Mon, 10 Mar 2025 03:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741602654; x=1742207454; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kNhM/0IjcjblchV98Qq8e/1t6zgAbQVQNq8rXKMpriY=;
        b=RXuI27M1ZZ2EDK+NwW/jLNuulYzmFql3mQ2Qk9avvK+qmcHO4LucBTvhUerCEhgG5J
         rcIJcN8CSB3TMEd5it/uPQuV619eI8Zw2CH3TZ1VWwCj/leFbALYNmNbW4E/5fa+r5Yw
         Va7v2YwzKU+c9VQU1yP+tRPSHiSRxLqKs0mlsxpa71iBSvSp3aBNfnq6MxAToMIm6xXH
         jgq507Pk/yDzEUak8FqtPceMqusnsahOBO5q8DyjjNNOBGsat305Y6OF8omzNvn3a5GW
         zneW3SbyzQRFHqS0n0w7sgUBIy6vtxLGkfE/piMFkQ/c3qh3cVDg+o07Q9s0Ly2Fn/Qj
         fsuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741602654; x=1742207454;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNhM/0IjcjblchV98Qq8e/1t6zgAbQVQNq8rXKMpriY=;
        b=lovOuE3B8mwi4r/Frrz75aH48n87ktkrwkdKkmge6enrk+PSoRtEWBGpIgEgoy3BHq
         nCTIeYNbev7RhuP1Q6dydbQVE+XkbXXS3wcVpnv+9pWoKfY9wyEL4hqxOOnCF4QOM0iX
         RrTxwnr2x608H/jcEI+qd0pyby9QftIbKLCBds32MZUL0Av8+E/opNnSGWhp0g177c1o
         wjoWnFeM4Lar1NnNuZPr6GoYEJoQNNxji+bAdcpqUP3lnIUlGjxMfXMDvwQ661udAE4B
         r7kiGFuRbngM8+SSPgBghgdOsHeXNwPk1MQ1JSzWELbbouZUvlzcbvH5tUA6NZdVoC+w
         4A7A==
X-Forwarded-Encrypted: i=1; AJvYcCVaCJmVWWAZGGt7NVMikEy6+BRO4h0Rn9ZwGBaftmwn818ouy/BQOq7I/mkrgr9ujfdd0pHGxuRCNPxBAvO@vger.kernel.org, AJvYcCVqQvsvFG/dYcetrt8nWbruRixO1Is6zbIK/5mwA6avRHPbJHyoHk6W9TPqngwyFPqqRM2LT/41Zucl@vger.kernel.org, AJvYcCWRK4CHOruCOpPnw4+y0KiBW+oQ3HjAIKKJny9XiJKkeN6yR8e4jCQVe+JAQz2hqX5tO7JCkGdD89d7@vger.kernel.org, AJvYcCWTNMWcD/CbUhf//+4U2QCXm02idP8FCkhktA1nxYSR/WycLWkOUD/soyFLPI8j3cvYr5+BL4BgNakz@vger.kernel.org
X-Gm-Message-State: AOJu0YzeELg9YWD1sdET90gGOV80ZyT6KkM3/v1313+mzMzetCJje5IS
	Q/kGPDC72Xn0OTnZq1o/8JqMYSukyyFm5BwIRrhN0FJqDAFErK4b
X-Gm-Gg: ASbGncv8yBe6C8kaT2hZtXuT+so8xQ9uk7I+7arRw96IpfxzE2iCExhlnSQNeWclKs5
	itobLAnQdx3nvnSCyzlxnBC3eZcIEAjkFpoo6Na/qSGEnanTU3V5ZN0jLpT4pyvKL7lHHeGUpXR
	Mx3wFKiCvGfJNZNG+lQwkySqbIK5K9zgJdfcykaRYFnTFElpd54DRKaaofrhs5PJ7RCSVZA1inE
	/EndJVCb39yDvPIKBSbzuqeBME1h7GTJPSFHdeX+99EOU77mR+RlU0pj9qFP5QASeT3ueht8jUL
	uHGnfqYloG72B2w+T1ezLNFNj0Z+Y+nFP4PjujKd3w==
X-Google-Smtp-Source: AGHT+IHOgY/2k2K6r8nbyooLCIqhLZNyi8g28UASQ2a6eAtRtlwzSxaLJolXF0bJ1EZNYwNFw8sjfA==
X-Received: by 2002:a05:6402:518a:b0:5d9:82bc:ad06 with SMTP id 4fb4d7f45d1cf-5e5e22bf16amr15660909a12.3.1741602653855;
        Mon, 10 Mar 2025 03:30:53 -0700 (PDT)
Received: from Ansuel-XPS. ([85.119.46.8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c733f9d4sm6630840a12.10.2025.03.10.03.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 03:30:53 -0700 (PDT)
Message-ID: <67cebf5d.a70a0220.fe6c9.6ad3@mx.google.com>
X-Google-Original-Message-ID: <Z86_WkfgZk_HLWuy@Ansuel-XPS.>
Date: Mon, 10 Mar 2025 11:30:50 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Daniel Danzberger <dd@embedd.com>, Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nikita Shubin <nikita.shubin@maquefel.me>,
	Guo Ren <guoren@kernel.org>, Yangyu Chen <cyy@cyyself.name>,
	Ben Hutchings <ben@decadent.org.uk>, Felix Fietkau <nbd@nbd.name>,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org, linux-mediatek@lists.infradead.org,
	linux-usb@vger.kernel.org, upstream@airoha.com
Subject: Re: [PATCH 03/13] dt-bindings: soc: airoha: add SCU SSR Serdes port
 binding
References: <20250309132959.19045-1-ansuelsmth@gmail.com>
 <20250309132959.19045-4-ansuelsmth@gmail.com>
 <20250310-ultraviolet-earthworm-of-honor-df114b@krzk-bin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310-ultraviolet-earthworm-of-honor-df114b@krzk-bin>

On Mon, Mar 10, 2025 at 08:54:14AM +0100, Krzysztof Kozlowski wrote:
> On Sun, Mar 09, 2025 at 02:29:34PM +0100, Christian Marangi wrote:
> > Add Airoha AN7581 SCU SSR Serdes port binding to define what mode is
> > supported by each Serdes port. These special binding are needed to
> > identify and provide the port mode from any user driver.
> > 
> > These modes are mutually exclusive and driver needs to correctly
> > validate the current mode for the Serdes port in use.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  MAINTAINERS                              |  6 ++++++
> >  include/dt-bindings/soc/airoha,scu-ssr.h | 24 ++++++++++++++++++++++++
> 
> This should be squashed with the binding for the device.
>

I split them to mute checkpatch warning

"DT binding docs and includes should be a separate patch. See:
Documentation/devicetree/bindings/submitting-patches.rst"

But I think I always took it wrong and with "docs and includes" it's
intended in a single patch.

Ok will squash!

-- 
	Ansuel

