Return-Path: <linux-kernel+bounces-412799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E43C9D0F21
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 12:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D933B283A22
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352DA194C8D;
	Mon, 18 Nov 2024 11:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYpnaodH"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4043C152166;
	Mon, 18 Nov 2024 11:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731927761; cv=none; b=ehlcFCMQSS8PF95WqTBUGxoncY4BpzSR0yEmwZfRv9kpmA/IxGOqdUpc125kX/udsQ4WkbqkFaTb+snl57VyaVXFtsHS5f2+lYpqMl8JkMYGrRgKlGguRXlc9SKJ6wCEVp4Hef9TfKR62cuWmM5gRCVPWu0mCuRuQHIQbAb24oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731927761; c=relaxed/simple;
	bh=LfGCkkZyMx0jWUord9yvSHk7Bt1WaEeG4A66PVUlNW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GdKiO/L0Y+Y6x7a3Z2zNbEV6ZeFtVEad3B1neOe4D3WgClCqI0gh5d2Mlk6k+iTKEa7HXzjD57zna5Hef6cWmt+NsH20n3DabCFXvwT/wwtHk85VnQWMkXKuV8gzEUB39tqJNIyO2UWjX+A2m0f4iGeIBKDg8XQ7F06X+JdoO+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYpnaodH; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-720b2d8bcd3so2862338b3a.2;
        Mon, 18 Nov 2024 03:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731927759; x=1732532559; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WkuJdzi6EA4PVzFbbcShtq4EUebMOJtIJZmQvDYGsMA=;
        b=RYpnaodHxE8l0Njs9XY/DTGGLScRe3njQYWt8b5DYKyF23mvMUe/EAmipXmlieR5We
         iRlJJMrCFNlzEbgRlxjGI2M2p3WvSiBxATpwSqahNNrNOr2bLTjmOnwyQWFU/mvDbQty
         VNzi1HHEPMl5P9+0miCLbsTnquDraS0EdiKLA97BQYSU0Ot0besI72EBtLNKUVFW+wOx
         DguPsx1tLO1IwLUB8r/SS5+Q37yQwtNBSnYBtRoQOAnqafFzhlu2LD5bka8/tDpZtBSZ
         G94hSBoS2DBV/Cww4mqsZtpGj0cAxupqJUaPN8NZb6MpLmgUvn6tDrdrEAKG0w9Y4fq0
         rz3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731927759; x=1732532559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkuJdzi6EA4PVzFbbcShtq4EUebMOJtIJZmQvDYGsMA=;
        b=N3pUtBeXFJB207d57fhcyxHSiQKh8yjtDyXpeqHwhaiRGGQAAvst027//+vU9PmgKY
         8KT2qbHwM0Eu912gyO3ZiPm/QL1cmSPawXLxydzsHBZfABZYJt5G1ZKRU8JhpFuK54IO
         8akb5XjKPMm28eAmyMq36EiVdUpxBh2NWKGty2bwMVJaYgMXvlyWCY0Pj+DbDwbn4o6h
         F5Xn4Zdjy4WzEwnUAvSk6PpdIhW/N0FxfCSKlRNgXJ7CPyhqlzkl0N65YfghWNqWl+rQ
         wbGQnmQBautYP9yG0c4CCuohxL+Wvb0iN/R+gDPXVh5c5Z9KQHQtD7/cSYbEAQCofcBD
         A+rg==
X-Forwarded-Encrypted: i=1; AJvYcCUw9ZutwvhtpUQI03hFzO602o1eVyg1dQ5bpYGLoFga/NBWFgqMZUkhVyU3RCdzEY01vrbRkhERfzRoMew=@vger.kernel.org, AJvYcCX8paTkzcGWojEAPdwXWvZTBKj4aAzcNeJx2F84Ge5l6WHc/7HO/dCSRqaZpFQ66AJ3Hn6bDqC9LqerN4lu5By1d2zwwg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+4gqlIBPvwiVe8Dx5akqtDB8MkKyVhZLh8ysMypkCGcQEw/0H
	baCoEb7SAmSe5hcfTI2q0QPxgv+yHXM/Srs58OWsK1Fi7Qfl467k
X-Google-Smtp-Source: AGHT+IEnPCmDOuNosPP8tM8oM2CRosb2XWJKipg6I/acpqXd+B+byQ6lv/B1h9j0lc/+v6VQGoA/wQ==
X-Received: by 2002:a05:6a00:998:b0:724:58dd:43aa with SMTP id d2e1a72fcca58-72476bbaa26mr15704622b3a.14.1731927759402;
        Mon, 18 Nov 2024 03:02:39 -0800 (PST)
Received: from alphacentauri (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771e5be5sm5918854b3a.167.2024.11.18.03.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 03:02:39 -0800 (PST)
Date: Mon, 18 Nov 2024 08:02:35 -0300
From: Kurt Borja <kuurtb@gmail.com>
To: zhixin zhang <jonmail@163.com>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhixin zhang <zhangzx36@lenovo.com>
Subject: Re: [PATCH] Lenovo Legion Go WMI Control
Message-ID: <zqsq45oqvhmr3unqu55msqaxo47yrknw4rd6hqojepibdgecob@bfpgy5o5rkmy>
References: <20241118100503.14228-1-jonmail@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118100503.14228-1-jonmail@163.com>

On Mon, Nov 18, 2024 at 06:05:03PM +0800, zhixin zhang wrote:
> From: zhixin zhang <zhangzx36@lenovo.com>
> 
> This driver provides support for modifying the performance mode
> function of Lenovo's Legion Go series.
> 
> Signed-off-by: zhixin zhang <zhangzx36@lenovo.com>
> ---
>  drivers/platform/x86/Kconfig         |   9 +
>  drivers/platform/x86/Makefile        |   1 +
>  drivers/platform/x86/legion-go-wmi.c | 552 +++++++++++++++++++++++++++
>  3 files changed, 562 insertions(+)
>  create mode 100644 drivers/platform/x86/legion-go-wmi.c

Hi!

As a word of advice, you should analyze your patch with checkpatch.pl
before submitting. It gives me the following output for your patch:

./scripts/checkpatch.pl
[...]
total: 104 errors, 51 warnings, 574 lines checked
[...]

Regards,
Kurt

