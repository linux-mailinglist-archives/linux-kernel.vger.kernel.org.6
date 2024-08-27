Return-Path: <linux-kernel+bounces-302582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 108C1960087
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 06:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B62F128326F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 04:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5696EB64;
	Tue, 27 Aug 2024 04:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHqehq54"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457C54414;
	Tue, 27 Aug 2024 04:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724734371; cv=none; b=WzvU8WLcWG/8xT786D36fKckyplz9S7wE248h3f4I/tgkXZqbQWt11EvO2EZrkWTa30VqyVMFYlRHXEL3NIOsUyST8XK8i/6po3HMWBRNR1zBO8dpDyZeMb709mRjqGNXpqrEjlEM0Cz53M5U/ihiVTAlRff2tyRgDQRoCl1Gbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724734371; c=relaxed/simple;
	bh=92tkHhOZoaPwz+uBdFGTqEu/hnuztlUZM8LQ3Y2zuQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hp3bIOqaCmkHWmZ1QxN+hXkT1t8XOsB9WsnJsyuymIyAZUO4OPp4SKMjaq5jUqcr0CVi0pNlBJPnoSdEmdsWNJBzgDhDyAJKSX6ecVevLzdci0Yms0Tu5RoLw3BLWNWidHVozq7CKK+pUTFFUMVVrqOsicrbKDSpFznu1C8THO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eHqehq54; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e165ab430e7so5225283276.2;
        Mon, 26 Aug 2024 21:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724734369; x=1725339169; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=418E3MTktRHmY+leklOtGq6971YMsgcbUog7USmFf5E=;
        b=eHqehq54u99aqL/HOgdMQxF/4xjFeaJEdaIOcEi6h+uV35+vaqOBbo4qrU60cLHdXl
         W6IP43r3L9o3LhqwSD0dMqameS9viO48CIo8isEbs1nI53u0/vC2WTSOV7LkvMYMi5Ks
         i5JpsRh19/mZ0KyKmCCWtwFHPEBMve4sFbOXu/j5yLzzRzCjpyYzquhlUE4UTOEeA9UP
         10YMZb1pdNHNvswpxCqur6FEFM8BK7qVkP1SpV0wmiiMSUupm4JtkJs2pI4jpkOzYtsn
         M0sMe5EPZfeZEQxgZnhKTc7dIS2tj8XZTPRBQYgc2nLvllYVr4/hzXBlZxEtnM66gY4A
         lU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724734369; x=1725339169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=418E3MTktRHmY+leklOtGq6971YMsgcbUog7USmFf5E=;
        b=qYLYs0XLonjjIzHyFHj4bw05uXI4qy2XPHAWgzZUHEvasVvoShyaf897B8BrFJU4Dq
         2ZkKZlj8qFTXTj9/NcdwL1HG4b1O9Y0RBk5ETInOcbz9K7w2Wbdx0W6EBb5kIqvhvvY9
         vj5/CRu0CQge8+YYPsX8qryydZ920THOvUNntrljh8OGlpqfrlAAK8PmWQHGx0tHfMm8
         P2+oXgj6xDe6k8dJ4JJE92WYpbiEkZtpzb+HinpJss9R05s4DuvPo5/4BmQ7pFM+FplC
         COl5q24lsp1NGLTW9w4ZF1gRFsbOb8ejQI1vV/TNM8IDnR9NapRjpXSMELIJzlHz0g0E
         enPg==
X-Forwarded-Encrypted: i=1; AJvYcCUACg1RVtKU2MSCzwd3GLWvlV9G8nfffRZKlmJEF2xH2eWHepcQQWZXnmlbep9SeaxhgGKO3IZgtUzl@vger.kernel.org, AJvYcCVAG3uxZz5W1EtTAKUwpob41RkNBD49msGu1Di4rTWKZAyr07K1d3gXLyU0FmvH+DVRrY7mgXdYm141@vger.kernel.org, AJvYcCWHKAoUieFNQiDNYYkwTpHDz1LRKO2gd8QBCYQSLFRNsQ2LBkrgUiaDklUuDs0fhO/W4hLVxgzHfh/Gumc=@vger.kernel.org, AJvYcCXtyALfzkVfhvu8H2xyBoMOBGJ/xHDpoA93czK0gdstMHk6wQHwZDLntOMukHdTZ2CekMfvL5H2lchQdhhC@vger.kernel.org
X-Gm-Message-State: AOJu0YyiuRCf98lK35eaCk6qD6zAqEuZchxUz5ROFaVm182ZR8Q//yOr
	p7cFLshoDrLgAi87QQ2M4VCIC8MIxFmEK35l+qwojMSJtDhCODpb
X-Google-Smtp-Source: AGHT+IG9abeZfKP33m1kBLwp5ZcRFam4qvM6M6Qjkco1IbhHF/ioe2Wg9UichaH7JZICQ1R1vorh9w==
X-Received: by 2002:a05:6902:2405:b0:e16:69b5:ef66 with SMTP id 3f1490d57ef6-e17a86a8e16mr13105821276.54.1724734369212;
        Mon, 26 Aug 2024 21:52:49 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714342e0e18sm7750246b3a.104.2024.08.26.21.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 21:52:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 26 Aug 2024 21:52:46 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Inochi Amaoto <inochiama@outlook.com>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Chao Wei <chao.wei@sophgo.com>, Yangyu Chen <cyy@cyyself.name>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Hal Feng <hal.feng@starfivetech.com>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v11 1/4] dt-bindings: hwmon: Add Sophgo SG2042 external
 hardware monitor support
Message-ID: <44ddca1a-8aac-4041-b01f-190694637753@roeck-us.net>
References: <IA1PR20MB4953DF0AE7210A6D74162952BB822@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB49538276F283C4D01364AEB6BB822@IA1PR20MB4953.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR20MB49538276F283C4D01364AEB6BB822@IA1PR20MB4953.namprd20.prod.outlook.com>

On Sat, Aug 17, 2024 at 10:22:56AM +0800, Inochi Amaoto wrote:
> Due to the design, Sophgo SG2042 use an external MCU to provide
> hardware information, thermal information and reset control.
> 
> Add bindings for this monitor device.
> 
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Tested-by: Chen Wang <unicorn_wang@outlook.com>
> Reviewed-by: Chen Wang <unicorn_wang@outlook.com>

Applied.

Thanks,
Guenter

