Return-Path: <linux-kernel+bounces-302584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F3496008C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 06:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E852F1C2218D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 04:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981D674413;
	Tue, 27 Aug 2024 04:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AG7iDVK4"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8355A54648;
	Tue, 27 Aug 2024 04:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724734423; cv=none; b=JtmGVeICBCEOHB+6KF2kgxgK3I2jir+WfJoMXRdck6dBYAXXexG/TOzo4zv5iA93cETWxvdxNl3CkLMTSfLfVu7syRlgu9EqxK2tn6XReley2s3qNRs0lC8FxA9LAMLgPZyB67o1XD1d70Mmf9KDAyqNLQ6GIxdfhl5OpqalOGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724734423; c=relaxed/simple;
	bh=yMbQF0uHORUf0udirhElpdblOuGQiBeBYSNIiCP1D6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKFyT5gVIWU6N3mrAsJYiU2BQIVbmvbTrG2ZbwyD0ERy4b4EwG6iBV4SAskB2/T29PUqtPYmINPcWW0Xq6IbtH6jqbEUtHR5xYE5p7N2PSM/S1CO/jUnmpKCF6eWG9l4nuTmQKiM1LpxAOFA3XWMBOK9cHVUshWPXcXiFewIERs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AG7iDVK4; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20203988f37so49589285ad.1;
        Mon, 26 Aug 2024 21:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724734422; x=1725339222; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uvPg2odSODo+vDn/Yud57+BmBlEnCSstG5MaGB4eQ8U=;
        b=AG7iDVK4qjquQTcQyW9Gy5H2RkOh1YF7Tt8LwZmdUoDYIUyE9kIGlR3Gi97w0bvGox
         wsCI0AtGCzivxi25qSkCy31UdKIly0cOBZeK3PjAiN4NPjEbKK15uT/U752+d9cyOvL6
         vZVgoRiTWbFhLe7TrX0KvkKzWaGKGyRp6ZqdM0mTVo0LK6752CiCiOK4sFA+74qxBXqX
         dZ5Jm0SgIiwVJYrYDTGl0E9MoCAkVMmzNi+lG3k/smVuO2Hay7n/Ru96Jy4uFvwSSWuM
         6FwBm7nQ8ieXBJmeQryhmoSrAZycRcFDFJfEEN27wyHS+VNljv1V2DbNW87mVweeJrK8
         5RPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724734422; x=1725339222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uvPg2odSODo+vDn/Yud57+BmBlEnCSstG5MaGB4eQ8U=;
        b=AOFT0T1zkHjC9jk0MOOkZT3Y2CMPcorlgQpNX3umEQL92o4BFlLtMmGa5sih8T6Spm
         7aaR5BrJQjqsajAm8o/BLviGC62cecogy5TvSXLdCsquE01YdCfXrgjN8dtznERvE4d9
         FOsRKnbeueaHOrtcRjl0yQndApzAzSsuTOq0bdrN7L3cneSeJIdjrlSdxOrOhAlGicTe
         0r4bmqCzpOsBLNMYEL40zHN6fzsP3o0oRsOlybmeawsLYCKc1/AcudrZ+n60f+wsL8Dc
         hpUvuWiQ+AuMPWBq3JcIBqJm/ltHswMmMqYt6/fRpSLBu/6FgKefjYfcazrUVp2jP2BI
         95ig==
X-Forwarded-Encrypted: i=1; AJvYcCUmtpTLTjXyd0NqxJIcj/n5JQVwFRmyypo1ppWoK2i363EC1VYvI7kXduVqruwpo148k0Si+1lH3pw0rRXU@vger.kernel.org, AJvYcCVTm9DnyAjH4lxFfJjkfqHNppEFUKffWdUIrJFZyj/Ih+mHZ1lXlZgUO0q/fUmnbKGXjLwhKHPy73aW@vger.kernel.org, AJvYcCWzqE3ktXdCViJa3BET9dC7H7xsW9/9LJ0TeUGj+ay0qBgpSh6fPJjlbLXg9Fj5+IXot8b+UQNDMpcSmmw=@vger.kernel.org, AJvYcCX0oJ0UI+AqT0i+BxG1oa5FYhA7rrQ6YKWNma2aGtYdtu3OZuFgjQXjcANAw/qE3nK4OoX/7rhPvEn8@vger.kernel.org
X-Gm-Message-State: AOJu0YwH2mlaCTzZUbOfibZaKeLa9suNbNJolA44NxQ/AfE660iI5FUT
	rdYfGrOjUSfjB3jI6dE7+UCTZT4CHuP0124mWHyWx+/ofd4znXMx
X-Google-Smtp-Source: AGHT+IEL1kKWGCjT1JsS3shOvdnMLab3oIYLzpv2H9njpHNKyiMPBT8u41muELEiFrxu91t9FxKUFg==
X-Received: by 2002:a17:90a:6543:b0:2d3:c933:6c72 with SMTP id 98e67ed59e1d1-2d646bcd8bfmr14272772a91.8.1724734421649;
        Mon, 26 Aug 2024 21:53:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d82a6d3d42sm125910a91.1.2024.08.26.21.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 21:53:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 26 Aug 2024 21:53:39 -0700
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
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v11 2/4] drivers: hwmon: sophgo: Add SG2042 external
 hardware monitor support
Message-ID: <5c7d6c42-e9ab-44b3-87d0-f2e4711a8c24@roeck-us.net>
References: <IA1PR20MB4953DF0AE7210A6D74162952BB822@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB49536C786048D1E676BB9C20BB822@IA1PR20MB4953.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR20MB49536C786048D1E676BB9C20BB822@IA1PR20MB4953.namprd20.prod.outlook.com>

On Sat, Aug 17, 2024 at 10:22:57AM +0800, Inochi Amaoto wrote:
> SG2042 use an external MCU to provide basic hardware information
> and thermal sensors.
> 
> Add driver support for the onboard MCU of SG2042.
> 
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>

Applied.

Thanks,
Guenter

