Return-Path: <linux-kernel+bounces-407025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5DD9C678C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 04:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9338C2837A1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 03:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FB81632C3;
	Wed, 13 Nov 2024 03:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGLBgYjY"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E5716130C;
	Wed, 13 Nov 2024 03:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731467074; cv=none; b=U6kjYBOTf6DEuZnLJrnuJc9CES6StwUf0wI5wUxm+KSNg8tdi7+uYuYZFVdhGlWa0aQWbXsE3AATik4O5sgn+isFkOXNt3LKTq9ncowA462wqzq9dEdFDJ+PR0TZFD98iFj09LQRpeb2bEE59WDMQlG95yZrSHacDuWVmhaEckE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731467074; c=relaxed/simple;
	bh=EuxKVNmpNGfrOiahUvynnVXT5qofaDA0cpfjiP0F1SU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czVc96AfxhQ1KgssaUTIwQrgHD+Ra1MtHyT1x5fk/bPa1vcGfndhcnCc1q7WcAnHjM/as65A4ZtmE5D1xabDldTJNiR4rHOsgf3Gey+ZxVsaDRhFa9w/BjeEXXGdXqLBzn0DEpPPfreCCxNiauQF7b/CkhlNEZpRtsTARt6Iipw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fGLBgYjY; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71e4244fdc6so5422549b3a.0;
        Tue, 12 Nov 2024 19:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731467072; x=1732071872; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P4y2OBEpapBr/wW9aW632V6tkwGQczTUHp3LH8E+LKc=;
        b=fGLBgYjYDvhrDxWmQxQLENhW87mEFQ2zPbgZs0tqr4ao+mB2ndwp63q7ryMtzJ1av+
         Wre1Mw1u135m49WBj9ym2ZrHN68smLCQb2gWKAudWswBTD896xJiXBOsOC3KOYBXhj73
         8r/lK8dHIe9LI2mTFK78Th8l1k0F4bZs7Oo/DlFsNGpgPMNTx9tIwKhYFKLuZDN5Rhg8
         NNO/Va0PvB5Mr2PhSEhNwX71BLd8eCFLywYSRg1qlAbxHsUPJT33TejHtc1xt3SNFaPg
         SuZCI23lGmhKgxyCbX9thvAh9XYOEwfEG83E8TuUcblGK60aincQ1ahbYJA3GOMPVw9X
         wsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731467072; x=1732071872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P4y2OBEpapBr/wW9aW632V6tkwGQczTUHp3LH8E+LKc=;
        b=PdLRNfwzRnXYyepTrajuum62l3FpDnft9QBuFtUjJkgWHzdun03Oh0QgGBf30roOaF
         s0h9e8iNFTYVe9LC+sMh/8Qmru069mea4xW0HMebbyytdXlNSyBj8r8bQcXRAaNMkT1f
         ZMS0yM9w4YDqhuIb/LGkeDU6PADISLwOtziRvm6Hv5noiNOpvsjfafgO4R8tToS5K6XR
         kifLc3rQ2KtlJXP+zP2cglea7nVhO3NR8sLyX7g/zLSWgTnE38zNwPDrIfOhnvwNkRel
         71sN5SVk9ob2kOFLEY6wlB+7iss0rk2NT3Zxxk4SOR/CqHg81bNsv9MSWB03pumPHNaY
         72Iw==
X-Forwarded-Encrypted: i=1; AJvYcCUtSFVsdKPyYNzqS3YTPPAhxARjvJ73sY281X9ufvFrKx7SGF+YqqNWOWl7d6URmaHMQgD1TZkLJgHI@vger.kernel.org, AJvYcCWKANJqruDdcZ4mtExpQrnkHB+kPTDShV7+NbLpVVlSWALcXY3+QoljtRueQcHjaP9378a/hRc+ptYihY8=@vger.kernel.org, AJvYcCXG8/lUilbPT+cdLVzMfsSWCk1RUqPP7TJMVntxDTRyVsCUMAK4EH3qQXVwe588mPIcTjaFv6sNiqdjmg1H@vger.kernel.org
X-Gm-Message-State: AOJu0YzuD3+m3y2DRk3H621y27EtvKebBEgBf4NL/A8pxFuQYTHEWf7f
	itcEUmF0EpjE35bTJbH3IKd6pr7hlvlgahopbsRZxUIu3RU0NzQe
X-Google-Smtp-Source: AGHT+IHKHAm+cuL8lFCVMojYZqRqYhNq8Jtwk1CRNj2ESswXVkFPqmbb7UYjGkXkoHENzLQUmPqBbw==
X-Received: by 2002:a05:6a20:4c17:b0:1db:e9d8:be4f with SMTP id adf61e73a8af0-1dc22af3e51mr18186998637.29.1731467072421;
        Tue, 12 Nov 2024 19:04:32 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f65aa9csm11213055a12.74.2024.11.12.19.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 19:04:31 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 12 Nov 2024 19:04:30 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: "Sung-Chi, Li" <lschyi@chromium.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@weissschuh.net>,
	Jean Delvare <jdelvare@suse.com>, devicetree@vger.kernel.org,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v3 1/2] hwmon: (cros_ec) register thermal sensors to
 thermal framework
Message-ID: <39ffe084-0bc4-4f6a-9b10-aee6dd493db5@roeck-us.net>
References: <20241111074904.1059268-1-lschyi@chromium.org>
 <20241113024000.3327161-1-lschyi@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113024000.3327161-1-lschyi@chromium.org>

On Wed, Nov 13, 2024 at 10:39:51AM +0800, Sung-Chi, Li wrote:
> cros_ec hwmon driver probes available thermal sensors when probing the
> driver.  Register these thermal sensors to the thermal framework as well
> via setting HWMON_C_REGISTER_TZ as a chip info, such that thermal
> framework can adopt these sensors as well.
> 
> To make cros_ec registrable to thermal framework, the cros_ec dts need
> the corresponding changes:
> 
> &cros_ec {
> 	#thermal-sensor-cells = <1>;
> };
> 
> Signed-off-by: Sung-Chi, Li <lschyi@chromium.org>

Applied.

Thanks,
Guenter

