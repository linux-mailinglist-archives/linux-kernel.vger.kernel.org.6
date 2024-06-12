Return-Path: <linux-kernel+bounces-211647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7703C9054DA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B51E1F22491
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D12F17DE25;
	Wed, 12 Jun 2024 14:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XS8Qeqge"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C62537F8;
	Wed, 12 Jun 2024 14:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718201733; cv=none; b=GjHvMqQf5M/mWOxqPSujYcfb8CjmYtBmR9uocauTU6PPHLHiaeEZ8P3IpsBONariV7Ze4F0WI9PcaEWtmWWgsUuvoajPI1SgIT7ppRURA4xEzQ3o9LnFVvCSlWNjQeENV6HnH0PneIyWNQH5ZIQet4K6S9hIYdkIdSLWv5bpPZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718201733; c=relaxed/simple;
	bh=YJVxt8DF7WEoLhSdgRziKoZjBqvgXUZ5KBOhQz+Eih0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UgNMBJ3/3ZlZaS8lWcG7sdaxo52t7Klz/B9P6Zt7FHY09nbR1RzHGJE2ta9F7zkNzJMj4QO8Rpv+LkRlLoHImmfI96qdhm6gfkB1GIH4UJ4hLAn74haMlKvtOqxU3B517WdJ0fafDAGLcXiqn04k6w5F+ck90eCnfo1jljmzGJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XS8Qeqge; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f4c7b022f8so63459145ad.1;
        Wed, 12 Jun 2024 07:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718201730; x=1718806530; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1giwCZy2g7nYLI/Oh2DWHIiIptYTKQAyqHfKbqylAtc=;
        b=XS8Qeqgeg4M3TAnXf5gaOMFZjTVSCFEsNQnbzf0WJpnx2+g3LQJQVcEoZqxKFIjHb1
         4w09XX1q4sEVILUIW3aE5RWpJyKEM4qwDKDEKFlz54sxoUdOyIlIZBO5GFk6+xHSRPIE
         qMM8yjPYzeVg7WRoJSCdD60L1+Hciawk5N4o1+wwpY7kXhro8XSg5incnne5cnAbp8up
         wXsAK9f5pJkqG9ZXTNjsjpJDzcc5Jw2peBlUvZbVvFVUsgTHWclNmdUzKNL0LBYdJj0e
         +9aGUEgsPqUGtABwLK3ae7Dgd+tlDoj/yR0YxCyAgXpTF5ZZrrvyohq2O6Yh6bgaeMMP
         NNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718201730; x=1718806530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1giwCZy2g7nYLI/Oh2DWHIiIptYTKQAyqHfKbqylAtc=;
        b=lZ5dHyiZdtL8THL2E7duU1UgktXcWVACaU/y3K8qAhGWe3tmO72ip8oViMgSalWQjv
         VIAbIp1bGQbzFIDfzJDKV11HguoESTz4DuSJdmxeohO/LPCyH8yGu2AeN3JGKUEemGTJ
         m53MeSPjr+6sfEhon/IeR8XWStAVt7Et8/hswRDrPVuOd1Bp4uFI507s4poLi+eeH8c2
         BvZd4yzQKAY4uyuG9hmO2qei4eRe9imqg66LctGKhj3jFHMuuM+zxOiG6cLV31EV4KbE
         UPw4LyHd2BNBTkSUouLz/y3DzepLLxzdQhLns188jNnzKajx7YAOIe7LDPhXuGVbJd5l
         3TNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdRwAwSjkjPb2vnMYRGnPll1hG4FRrjo1GI5RUR8ih2bLNRxzZDxQwnkYMeAqbioP8mbxwo4RTPgwbaVssYe8ed6V7z2VZRw7D18R++A2IERIQa6p8ZtGO44nucdW/4RoqDHh71Fv3/BkCk+GjjsIp74WtnO4hWStBe+5clBG++JaJFxQh
X-Gm-Message-State: AOJu0YxqxQRHj5Oe140zMxHF6WK0cs+2zo3HPKoJsM7SQ/T0VBPcIReX
	y9vA7etZ2l9EW9t7cqK83EluQMFhXOAarIgz/tNY+AeqXOoRqUXD
X-Google-Smtp-Source: AGHT+IF5y01LZGy9eDTKNNU2fQqbdfaQHNh9S4I+D9Fa2N6dtTDVrR7oBahQpyoy2ErWiuug31sjFg==
X-Received: by 2002:a17:902:cec5:b0:1f6:7f8f:65c6 with SMTP id d9443c01a7336-1f83b5e52b0mr22134935ad.24.1718201729793;
        Wed, 12 Jun 2024 07:15:29 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f70283b940sm70382555ad.265.2024.06.12.07.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 07:15:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 12 Jun 2024 07:15:28 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Amna Waseem <Amna.Waseem@axis.com>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@axis.com
Subject: Re: [PATCH v4 2/2] hwmon: (ina2xx) Add device tree support to pass
 alert polarity
Message-ID: <b2026c8d-c55f-4e3a-a42f-1ee684684b69@roeck-us.net>
References: <20240611-apol-ina2xx-fix-v4-0-8df1d2282fc5@axis.com>
 <20240611-apol-ina2xx-fix-v4-2-8df1d2282fc5@axis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611-apol-ina2xx-fix-v4-2-8df1d2282fc5@axis.com>

On Tue, Jun 11, 2024 at 11:36:26AM +0200, Amna Waseem wrote:
> The INA230 has an Alert pin which is asserted when the alert
> function selected in the Mask/Enable register exceeds the
> value programmed into the Alert Limit register. Assertion is based
> on the Alert Polarity Bit (APOL, bit 1 of the Mask/Enable register).
> It is default set to value 0 i.e Normal (active-low open collector).
> However, hardware can be designed in such a way that expects Alert pin
> to become active high if a user-defined threshold in Alert limit
> register has been exceeded. This patch adds a way to pass alert polarity
> value to the driver via device tree.
> 
> Signed-off-by: Amna Waseem <Amna.Waseem@axis.com>

Applied.

Guenter

