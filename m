Return-Path: <linux-kernel+bounces-376734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C92E9AB544
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B614A2861F1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 17:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13CD1BDA81;
	Tue, 22 Oct 2024 17:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="DZjm3ev3"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC241BE22D
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 17:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729618762; cv=none; b=H8KJbkU7RmubQ4v0vDz66dKSy5W2wYX43gKd0cYPrpr4Wr/RuGAkZpRWBEMPjWSD8ojtHV+wy484TUeuDUkpVn2ULGWnd+ODdczeTSA9f/QLle/XJW7jUmn15+5iP/zsMgpK3SGSt5NENlXCm5/Vxj8JYdVEx9PJzmvRosCShu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729618762; c=relaxed/simple;
	bh=LlLzd7M/7SsX6nncXDGfDEEeNGVIcqrAhkOqr2TXBv8=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IboEDId05vH9nIe+hR5EccNWIzuHOYhjs0fZwK189NRKQQDlPSczEkhtTot8lZm1ptEkaqAAE///FBJW7i37/aBk9C6QPxXpVeVEacyXU20SFt4L+idtXQ493kOIvud9ZUD7Mi+fgbYtK/1jHNTabXoZ/VXoEkA8bu0wbo57xU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=DZjm3ev3; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9709F3F28C
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 17:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1729618751;
	bh=gIp82CbtDDICzfhljA3RfNnMq4WLw57LTcEeK1RhMvg=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=DZjm3ev3T8lJpSVQb/o+TxLml4FINUXQ93RD7uCoIdF4rK+Eal2cawAG9+huSiT7y
	 /ppRODHs1xQIW9IzbyzXTUOLi34/1Nv6ntaoyjz/lj1kaQIz1L3uJZ2nKAfrhjRvEM
	 wnR/h8l263+JBOxKbFQQzrlHkjl7DCLaIftI0sCJSd6fkOvMCGs/vEZZEjQdyJSJeH
	 6gqPbBn73f031jnyafig91mrjMzCvpfp0PlMHaC4iWutbNgW+Z65aaVoa8t9+0ssLg
	 yQBF5dy+bh/s/VEMs8rEo0mUbBvF0eKJMJ/Q1nd23eYires3YLmAaHTzBVKMwamusk
	 Y5CBtNm9FAzyg==
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-5eb892b366bso3634050eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 10:39:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729618750; x=1730223550;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gIp82CbtDDICzfhljA3RfNnMq4WLw57LTcEeK1RhMvg=;
        b=OkcKD9cT/RUHYyGwR3OyHScQVDY4W/ERqqb5l0qGBOB3F6z4RXbRj8qFWaDPlr3pOm
         vdU9/rLspPwwYhFste12RfFQTtaFII642+63md8qe5SX9PFEyAnYmA6KAWvC9KcPXUx8
         iRDokl2tYJ7oK5Y78EPjvyqFCrQXD7QcNOWvsS8Wze633F+ITINUAvWtJY6SptfGbG/r
         Vc1Tu28ebPZAPXnixzMuT+gA9ZbivCVqhSpXch/P8z5cyufqPqzQjqX3QttgxYcYRAqN
         Chnw6audPXHtr+ciVOl3c6AoQ+7asl8r7pF5qdCOZCsRoel4Nw5Xdw+NbnuKvsaIGh0c
         LeVg==
X-Forwarded-Encrypted: i=1; AJvYcCUQkhpXb2ZIxRQhnrNtRq4JqwwMdbk+2NryQ+cqUf4wKJXQkSKYwOvhfFYgjRyljS5Q/JbV1cW/wjmpD6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqETZy9pJhcu++R1uwtmXBro79G+uH6MXNDK9fuNkjD7PGxuhI
	9qjIesMiXbfA9JPmp0TtJ7Yrc+e6IuYGznbdR0o2SfHE7E0RGtDwdcRU20iIG2h9nKHoyIOhPsn
	jPo8UvfxejkYO+0xsXc/Odwitr2Z2cpIWfftoMlTRFQyNI5Zh2iuBEPmOsSUJ/MrxdZyqabUv+y
	g+v5tqX6gYayn72AsCKgncvBXnz3wAOqO/oL6n31UcgOOVcmOtNJYG
X-Received: by 2002:a05:6870:14d6:b0:270:184b:ccd9 with SMTP id 586e51a60fabf-28ccb63856fmr15128fac.39.1729618750419;
        Tue, 22 Oct 2024 10:39:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHp2eOIro3rmG5TpkZ8Vs1zAmqxePU9Yf+aTCteWKwLEX1pSdHkee4wAR+DRJadUrVYphpsbkFcpqUY2k5VgeM=
X-Received: by 2002:a05:6870:14d6:b0:270:184b:ccd9 with SMTP id
 586e51a60fabf-28ccb63856fmr15106fac.39.1729618750027; Tue, 22 Oct 2024
 10:39:10 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Oct 2024 10:39:08 -0700
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20241022061004.62812-1-e@freeshell.de>
References: <20241022061004.62812-1-e@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Tue, 22 Oct 2024 10:39:07 -0700
Message-ID: <CAJM55Z9ApObth8AD1gpNO0ppxUmvYW3m0q1dAyqekRhXwVxb9w@mail.gmail.com>
Subject: Re: [PATCH] riscv: dts: starfive: Update ethernet phy0 delay
 parameter values for Star64
To: E Shattow <e@freeshell.de>, Henry Bell <dmoo_dv@protonmail.com>
Cc: Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

E Shattow wrote:
> Improve function of Star64 bottom network port phy0 with updated delay values.
> Initial upstream patches supporting Star64 use the same vendor board support
> package parameters known to result in an unreliable bottom network port.
>
> Success acquiring DHCP lease and no dropped packets to ping LAN address:
> rx  900: tx 1500 1650 1800 1950
> rx  750: tx      1650 1800 1950
> rx  600: tx           1800 1950
> rx 1050: tx      1650 1800 1950
> rx 1200: tx 1500 1650 1800 1950
> rx 1350: tx 1500 1650 1800 1950
> rx 1500: tx 1500 1650 1800 1950
> rx 1650: tx 1500 1650 1800 1950
> rx 1800: tx 1500 1650 1800 1950
> rx 1900: tx                1950
> rx 1950: tx                1950
>
> Failure acquiring DHCP lease or many dropped packets:
> rx  450: tx                1500      1800 1950
> rx  600: tx      1200 1350      1650
> rx  750: tx           1350 1500
> rx  900: tx      1200 1350
> rx 1050: tx 1050 1200 1350 1500
> rx 1200: tx           1350
> rx 1350: tx           1350
> rx 1500: tx      1200 1350
> rx 1650: tx 1050 1200 1350
> rx 1800: tx 1050 1200 1350
> rx 1900: tx                1500 1650 1800
> rx 1950: tx      1200 1350
>
> Non-functional:
> rx    0: tx 0  150  300  450  600  750  900 1050 1200 1350 1500 1650 1800 1950
> rx  150: tx 0  150  300  450  600  750  900 1050 1200 1350 1500 1650 1800 1950
> rx  300: tx 0  150  300  450  600  750  900 1050 1200 1350 1500 1650 1800 1950
> rx  450: tx 0  150  300  450  600  750  900 1050 1200 1350      1650
> rx  600: tx 0  150  300  450  600  750  900 1050
> rx  750: tx 0  150  300  450  600  750  900 1050 1200
> rx  900: tx 0  150  300  450  600  750  900 1050
> rx 1050: tx 0  150  300  450  600  750  900
> rx 1200: tx 0  150  300  450  600  750  900 1050 1200
> rx 1350: tx 0  150  300  450  600  750  900 1050 1200
> rx 1500: tx 0  150  300  450  600  750  900 1050
> rx 1650: tx 0  150  300  450  600  750  900
> rx 1800: tx 0  150  300  450  600  750  900
> rx 1900: tx 0  150  300  450  600  750  900 1050 1200 1350
> rx 1950: tx 0  150  300  450  600  750  900 1050
>
> Selecting the median of all working rx delay values 1500 combined with tx delay
> values 1500, 1650, 1800, and 1950 only the tx delay value of 1950 (default) is
> reliable as tested in both Linux 6.11.2 and U-Boot v2024.10
>
> Signed-off-by: E Shattow <e@freeshell.de>

Thanks for working this out.

Acked-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

