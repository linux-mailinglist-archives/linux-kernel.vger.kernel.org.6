Return-Path: <linux-kernel+bounces-564886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC08A65C43
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3307A17D43E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F9D1D8DFB;
	Mon, 17 Mar 2025 18:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7l9KZMB"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E790C14C5AA;
	Mon, 17 Mar 2025 18:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742235565; cv=none; b=seS6QCnjMLFJHo+azHEMksoiUUaBV1QH3LULtLJkQe1ECDTQu9xmwtCqseXVr5y/QWW6i8htU70+ZZj80110zwIGEx33a9xZxhFY8PFAZaQTrIACCGuJ2VYMVYS34d/uCt8D6zJ9JdbunrtzbMuOwuH7bSrACCjpzJFMxgEtI/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742235565; c=relaxed/simple;
	bh=Mtvl/jyJUdtL4QFBo7D0YAZhHSay/PjR0/QIolqsMWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ld8kXdxBalqCCUV8WafJtcDphMjBjAPZdBpgseoSWekpBVpMLHfRGNQAPSbt9HpM/TyRyRk2Uv7/rdXq5BO9eOLZUjR7ehlyGRjTN9VbUnuqhqSpV2/etE45oXLdSKqTFWI0oxWcNZYFFbgnid6hlEr+Y2KoeiRBowy2+ldnu3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7l9KZMB; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ff615a114bso3260547a91.0;
        Mon, 17 Mar 2025 11:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742235563; x=1742840363; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1p/vJyLOF8KyVZFp2qeYUDBByhHRPvWe2lPITuY8vOw=;
        b=P7l9KZMB2Ylt0Sz/QjYBy0SKGTasenhVLI5N8s280TjcJfe4WPivnAizyHfR8aVL3D
         kyyV1NszRlvOBrSXdX2MiA2BqWNuAfn7M/GtQR3HOSO1+Lq/AL5Hdzw7oJXJ7NNOvn4/
         ceFw2982ybtN8OuTa+LJi25V4hyiZsrHLPJ4xCPG+X/5eW+BR5tpiKVLcTCiSUrj/7yO
         3Z7NRrtrIHnAWuOgBS0d5mIZI8Fpv2jjblMYXAKtTRcJnCTCZJ0YLgZFaVnsD7kqhB+g
         3XCqEuK67j+WYHjzPs7ApG+GSEvZ2u/VHa/5mjZdFNPSw/rJDSZiVQajEl6uMJvv8itV
         ezRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742235563; x=1742840363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1p/vJyLOF8KyVZFp2qeYUDBByhHRPvWe2lPITuY8vOw=;
        b=dBmrTOP6MgNUmRI5yC5oID7q1KKozOGCZ7cHbc5aSI17/6SWtM2foNmQGWUjlAhqIw
         MRrWMVLRdt0TRWXhO87Ck+6aZXU91RslUXtK1tHOcjKPM0auEiEgOgH15S6rZAnhAbAf
         c79eP5Rph9cBuCirTxwG8QdCAf+PnvZyZUEvKNF3HpeOx/0jnxwrCyKCIrA+iDmE5rYD
         T3cew9cAwdcjr7RfXST5xHkb9SzfiaFQtYMGfhnK6ezCvWNw3/hUf5SfglW206Tv9sOK
         mitxS4Cy9kl1ydb6O76LWTXuQzp0ButS3XpsyUGVCuIonx5/O4+PzgkRPtLsPSTkAIdR
         lDQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUULUKl/n4vgWsw/gol2eOUFwYOt1pJ5yszb61VglVojbG3BHoyZ/8N0qrnRgP3p9VTjdN02AhHWNmKNZAM@vger.kernel.org, AJvYcCUtIucSHBIJftbsEhsQjBaidfPXGHGweKQSbe7pNooefKXmf3Gd0Lx5yrSRtx3+7z1d5Fc/bIwp7qmY@vger.kernel.org, AJvYcCWWmzkhpGHH70xBGOqP4HefsOhVtYbRoa+4YBIZzpEfh44E4/oiDKOvVLtUYcvYfHffycCb7aVZYEFv@vger.kernel.org, AJvYcCWhZXQUaf5E7h4oY6PQkeMAUfqwjao2vaakSoco37yA4a7AZoghMm+CDEUAZcIZTjeGMUwMYwbUGghoSBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YztMy/L7kPVgj7s3CzvBD1vfZ/y6BjCXvvO/52Mv2yRzhunt6RZ
	aDOWJL7aME+GbLv/VtdM3YHdgVtQ6LRF6wEwVb6n4ZmYdyEQgBKa
X-Gm-Gg: ASbGncuoTQ3M11z2Yc3Ts5ubELQXaBrzISyTxHUFd+abc85Y4vf8GjiXUJuJaCYNqBU
	HdBbO7DPIPtq+VSl1shG3k70djtBJ+Ot5GP6v4G9JA7HD/zOaCWNOfbX+uHo8D1ErWmm8q42yEM
	MnYAqc2le+8n20wp4XKL3IzZuxsxCC1tKYih3VQltYzRwyXBJ6b+WF1qH870tB5dezFHU0pmQT1
	tKRbC87u8Vp7hfvutC90i5xLZ2qpVhOPzthncGLPlLmABg9izOJcfdt0fVt7wnYa4fOGD+0QNMR
	pHnr3k4NA+GpIJYFOe6cEOQg4doApZ5i/PmaGs1TzuoZzaUGErOp7BM9Pw==
X-Google-Smtp-Source: AGHT+IFGsTOd8uYKRb77bxFuXoZw2j0kYHafi/HpYTv7uH6M/4v9MlJQ5+zFAOZhK4Y8uixkSvjS+A==
X-Received: by 2002:a17:90b:4c12:b0:2fa:562c:c1cf with SMTP id 98e67ed59e1d1-3019f1f1203mr607059a91.1.1742235563180;
        Mon, 17 Mar 2025 11:19:23 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3015364d849sm6415219a91.41.2025.03.17.11.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 11:19:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 17 Mar 2025 11:19:22 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Leo Yang <leo.yang.sy0@gmail.com>
Cc: jdelvare@suse.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, Leo-Yang@quantatw.com, corbet@lwn.net,
	Delphine_CC_Chiu@wiwynn.com, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 2/2] hwmon: Add driver for TI INA233 Current and Power
 Monitor
Message-ID: <acd1c18f-780c-40d6-bd00-fcdfce85789e@roeck-us.net>
References: <20250116085939.1235598-1-leo.yang.sy0@gmail.com>
 <20250116085939.1235598-3-leo.yang.sy0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116085939.1235598-3-leo.yang.sy0@gmail.com>

On Thu, Jan 16, 2025 at 04:59:42PM +0800, Leo Yang wrote:
> Driver for Texas Instruments INA233 Current and Power Monitor
> With I2C-, SMBus-, and PMBus-Compatible Interface
> 
> Signed-off-by: Leo Yang <leo.yang.sy0@gmail.com>

Applied.

Thanks,
Guenter

