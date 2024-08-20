Return-Path: <linux-kernel+bounces-293467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F0195801F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 750C4B21507
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 07:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E74189907;
	Tue, 20 Aug 2024 07:44:50 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B851E86E;
	Tue, 20 Aug 2024 07:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724139889; cv=none; b=dZPK9Mt9HNg8F+1fbvP7E8QXO6QM0u+psbTsNUL69fzdsV6RHDGIVfztrIdqIfQ2wliyfWvBLyGcrsuQF3yXfIwF2KbgxDpKiUq9MlBtiFQs88ZNVxxTIAR7SlYy/WYdke4ZfE51WYlcitc7WAOokBgIP4GbUySUKVU6Nf6eHUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724139889; c=relaxed/simple;
	bh=lf3gpRbFA+B3yZkvMYoYyM4mP/3oycLIzK0/eFbOelg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UsYE0rqR+SlwvyrZiOFQlrJ1U8zMeQ8oNyPTPkV8EdS28pIOKN4H2H/buvRzIpuGjd1NT976Rg2ZK2I+xz9e8lxqaoQNIxpQqMQ+X7my9rPIp8b4J0UKCNRkQ1plhGSELLY4jmk1XuTP++QhXLl44yXxZkHjNnxGm2SdIBdfQkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-429e29933aaso39326615e9.0;
        Tue, 20 Aug 2024 00:44:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724139886; x=1724744686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FvbirHJqUDXw1rweSKspUbcKFVV/FBP86r3X7Gn+7xk=;
        b=RXMqhlvjXcnbG5zcEWoWkIcCUyq6nU4F9gl6gWipSPZRfXUPoD5CLpRH/A0VWBza5D
         Sd5seDE9EY07UTQDLMInRQ0A7sO4MsNkZ7zzZsMTkcMbxGZzxyhmJJzXh1V1flH40/fc
         huyDpz243Csva4G2DZA2aPJ3+nsiq6yU5joES4yU0p6ymXL6m8Tld6PP5R5aXd7I3mmc
         GKacPZ3eXTiTOkWyeIPMwtnVXagFH8+nwKyvy3rdcz0LmcMamSJdgv9Xe9gjwaEJ/vEc
         fLicuQy5vUJPEolfiYs0FzBpUqkwm1ycVCoL00KoUrXFumV9BbTI+zryEFg9JCRukHFG
         FuVg==
X-Forwarded-Encrypted: i=1; AJvYcCWrYNQfamvX6DTFoFUycx5rPGWFryNpWBSDu2ApvAaaDFWVL+9TDefyD621N9S9D9Zbkvrbt3co6PD71n28HcsJL/EmiQ74knhlTK6dyjKvqGWZYo84x8TW0LtdQS0m9j8THy3Xk7Z2Dw==
X-Gm-Message-State: AOJu0YzJKGKoU7KvLCuGm/r/LMtNmtdBl0ZPb0McshmlIm+Jwr4KjjCG
	e8pk25B1SbudOQjzjbzyQqMaqLedVNvEF5WZ+U9UZGBe/F2MtAkbxwdiaw==
X-Google-Smtp-Source: AGHT+IHv1tNiXT3io6sPJzRosQuTieU+aQQh3DhVuQ8G9xlQs/ngAmnpcybXA0XpKi0WXDHZJdcOAw==
X-Received: by 2002:a5d:654e:0:b0:365:f52f:cd44 with SMTP id ffacd0b85a97d-371946a8294mr7799148f8f.57.1724139885916;
        Tue, 20 Aug 2024 00:44:45 -0700 (PDT)
Received: from krzk-bin ([178.197.215.209])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-371898aad93sm12393607f8f.95.2024.08.20.00.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 00:44:45 -0700 (PDT)
Date: Tue, 20 Aug 2024 09:44:42 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	"open list:NXP PTN5150A CC LOGIC AND EXTCON DRIVER" <linux-kernel@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v3 1/1] dt-bindings: extcon: ptn5150: add child node port
Message-ID: <bcdtctvl6mukoccr6kq5acuztqmhbwhpscf37wjhlqwgjrk3yp@wyd3ivbfanhy>
References: <20240819185734.372469-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240819185734.372469-1-Frank.Li@nxp.com>

On Mon, Aug 19, 2024 at 02:57:34PM -0400, Frank Li wrote:
> Add child node 'port' to allow connect to usb controller to do role-switch
> if id pin of ptn5150 have not connected to chip's usb ID function pin.
> 

...

>  required:
>    - compatible
>    - interrupts
> @@ -58,5 +63,12 @@ examples:
>              interrupt-parent = <&msmgpio>;
>              interrupts = <78 IRQ_TYPE_LEVEL_HIGH>;
>              vbus-gpios = <&msmgpio 148 GPIO_ACTIVE_HIGH>;
> +
> +            port {
> +                    endpoint {

Indentation is mixed up here.

> +                        remote-endpoint = <&usb1_drd_sw>;
> +                 };
> +            };
> +

Drop blank line.

>          };
>      };
> -- 
> 2.34.1
> 

