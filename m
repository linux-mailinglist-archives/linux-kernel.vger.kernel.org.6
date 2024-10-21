Return-Path: <linux-kernel+bounces-374927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 173809A7213
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 20:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ACA5B23200
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 18:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12411FAC3F;
	Mon, 21 Oct 2024 18:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjCAVKMU"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFF31C461C;
	Mon, 21 Oct 2024 18:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729534409; cv=none; b=RY0IoIA8HCQHFRHfwDFKf49Hc4NIAgHy/wd/x/xHusiSwhsHxU8pfA2fgYgBhUHe/Emj+mugujmm7PkNQ0bhBJO6nLGYNtx7sL3LS1ncTsxgICFdnMDsATr/TPIp5XGHrQe2nLCa6e8r5SQ7ox6IpSAICCm5BDxuKVvw5U6tTXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729534409; c=relaxed/simple;
	bh=yzpd+NWU+lQgRKSF0RCKk2mtb0Hr9paDxhG9P+HbKrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHTa8uWABsocZXt9HMaVydpk746us+g+yzTm4ufDW36WalvsPOJCJXbHaHwMf/AV0qur7XfkcrE9QJiR3b/DgKV3pyYm91y3JJKcMu4FuFvon9FLlW+KePoLmmwWMQuwWWnrE5sJrpuK6QJBla/7o3EkdmWqM2QUc50HWXHJDnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cjCAVKMU; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso3144817a12.0;
        Mon, 21 Oct 2024 11:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729534406; x=1730139206; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bK+Kb3CRrwNbEI7Yu3/DCQS3QmfzFI39y8oZaNmtEhI=;
        b=cjCAVKMUSXeE2hyuqrU7jyiedoUbNeR99mp+gBzmnt23bsB4MWFko8gr4lwqQ4NXf6
         hvp2hp8EamISoK243s5fm4eA6yOeHr5bNFXK/eCvIrhKh3g4712Gmp05jhXen03froCq
         0lSZh+3dXLp5uEwndsNEz1tvZwqlEfwyPUp2vNPTZs0X/E3cH1Lhj3GN2q72ne/Q7Lca
         KxoUJb0SBuUWSUgrRQpPC7QRx7eKEd1eB7XgHiOUS+UNJyx3QL8TqsMbpxKHor+gvR8l
         PmrInW0XPPHgD92jCz974d4uuUeR8s/40ZUGDG3qnbYUaijjfT4aMDIcMuwvSbBeSrK/
         Zeqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729534406; x=1730139206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bK+Kb3CRrwNbEI7Yu3/DCQS3QmfzFI39y8oZaNmtEhI=;
        b=Si02orcBREsIi07/ZWJANxhuDFh4Lb0Q9RQXrxsMtgOZ1Uv41LR6E8gSkHxVDca87T
         s6K37CUiq3Do5b8WUCuiISViC9IdcPysT8k0bpm8an89vt9LkT18f2KG+XbHVsyW9dJv
         byPjQQJPwyCbgEWrBokzPzqUYXBitJyw0qWSWJX0ataq0CrF2dtvI+wlt76Ac1dbcGjC
         OzsyuA8ny9Lg2RrFWL694lzqO1sRFipH4lFrMc/nnwto3rVvV7d0hZduGDKP9oEBSpbO
         j7bAIl5JSZi+tEkwT2JMcLw8qKwrjI+1655ThBcwoDJyanu9ZaG8EjmXkx7am+gpCbB9
         OWOw==
X-Forwarded-Encrypted: i=1; AJvYcCUPokg0njHahJp8dgr0+A2neWmzBaIAhTNVA+WKOGpTH9W435st5CrkUfTnWuTFCjygX2StSMsDDi5rHCPM@vger.kernel.org, AJvYcCVCX41msppBCH9L8JmmYsiDoVnbi/RO8I/ePQjppN5iJSwvVB3v/l1L+HoZGNNhpjEWv9CRgLmqRFCG@vger.kernel.org
X-Gm-Message-State: AOJu0YznBtJgQJkD1JcL+BE6EEZQsDtP4rvFqB+0ximUzErLfNUzcSSo
	MHvOQoDXytQ4bD8E/wibmgCcfEpS7M7jrbOY2M/gVf+/In9AzWBf
X-Google-Smtp-Source: AGHT+IE3n6zAepKFOnyn7up/M/0WjnX4CfERv9bMqeBZc9N19TjDL/xo9B5jJ8ZSGfpVA7yXAPNFHA==
X-Received: by 2002:a05:6a21:8ccc:b0:1d8:b060:37c6 with SMTP id adf61e73a8af0-1d96b4554fbmr1255679637.0.1729534406361;
        Mon, 21 Oct 2024 11:13:26 -0700 (PDT)
Received: from Emma ([2401:4900:1c96:190:5054:ff:fe53:2787])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5ad4ed248sm4199168a91.36.2024.10.21.11.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 11:13:25 -0700 (PDT)
Date: Mon, 21 Oct 2024 18:13:17 +0000
From: Karan Sanghavi <karansanghvi98@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] dt-bindings: soc: bcm: Convert to Dt schema
Message-ID: <pyizqjpxjgd6zdrhh65fklmyrxgxmlu2wmv7tzpdhdkwh7ifn6@efvaxhpekxtb>
References: <20241019-raspberrypi-bcm2835-power-v1-1-75e924dc3745@gmail.com>
 <20241021-exposable-seventh-baed2b1442b6@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021-exposable-seventh-baed2b1442b6@spud>

On Mon, Oct 21, 2024 at 12:39:28PM +0100, Conor Dooley wrote:
> On Sat, Oct 19, 2024 at 07:51:18PM +0000, Karan Sanghavi wrote:
> 
> $subject: dt-bindings: soc: bcm: Convert to Dt schema
> 
> That's not specific enough about what binding you're converting here.
> 
Sure will make the changes. 

> > +maintainers:
> > +  - Karan Sanghavi <karansanghvi98@gmail.com>
> 
> Why not the maintainer of the original binding?
>

I had read somewhere that who ever converts the binding file becomes
its maintainer thus added my name but will add the original binding
file's maintainer name which can actually help in maintaining this file.

> > +
> > +description: |
> 
> The | here serves no purpose, as you have no formatting to preserve.
> 
Sure will make the changes.
> > +  The Raspberry Pi power domain driver manages power for various subsystems
> > +  in the Raspberry Pi BCM2835 SoC.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - raspberrypi,bcm2835-power
> > +
> > +  firmware:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +
> > +  '#power-domain-cells':
> > +    const: 1
> > +
> > +required:
> > +  - compatible
> > +  - firmware
> > +  - "#power-domain-cells"
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/power/raspberrypi-power.h>
> 
> What do you use from this header?
>
Example for power node
power: power {
        compatible = "raspberrypi,bcm2835-power";
        firmware = <&firmware>;
        #power-domain-cells = <1>;
   };

Example for using the power domain

&usb {
        power-domains = <&power RPI_POWER_DOMAIN_USB>;
   };

We need the header for referring the power domain defines in the sub
nodes.

I didn't understood exactly how should I include the usb example thus
omitted it but if required can you please let me know how to add them.

> > +    power: power {
> 
> The label here should be removed, it is never referenced.
> 
> Cheers,
> Conor.

Thank you,
Karan.

