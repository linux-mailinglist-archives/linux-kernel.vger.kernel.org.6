Return-Path: <linux-kernel+bounces-559722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC527A5F886
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B61D042167E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E188268C78;
	Thu, 13 Mar 2025 14:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzFHCdW1"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320A1267F4E;
	Thu, 13 Mar 2025 14:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876472; cv=none; b=ddtEY/YT4eiEHf6IpZXrKEtsVGsXUN19uAn6VnuICeC8g79l+XG/BX/fZHonnwtBTpCgeBElL1HLjorYES/AJ2ed6W2T3XUfgTY9efGjRIn+dZKxQ+uEQBWKNkxlvbpqCinHs+tWB5TixrXT8GSkctNqoD7ANLTqPOwz8lKC1tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876472; c=relaxed/simple;
	bh=UazzsAUWI6GAw0njs5UkMNVIT1Mhmutw/miu7AFOpo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=El5g6mVBnAi0hvE8PlksOG+PtKoXuTUzG1FeYl6EWxMZadaHwzwjBGtDHJRtIpOVs1SkbJ32rhbpGKDOx69l6OoanQP96MNH/0Dabhx32uVAig40laUWlhHs5HLI9qqSaWMm+WbS7s/1twLguAKu1ksziDlQv7wYOTrcRHhfzd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OzFHCdW1; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ff799d99dcso2193635a91.1;
        Thu, 13 Mar 2025 07:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741876470; x=1742481270; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GICFi0VoA04wMmuC8eF7tQ0MeFnd48JKTtPTlIjvHiI=;
        b=OzFHCdW1mKqbPs0aqvYt18o7IaM+Lh5Hg/8OKucIOWJMgQSBrXKd2hV35tUNUiZ9ak
         CBOlj3ZdxMtmx6D9yd9l2Y9uH7S7pb48TQGLUtpluiPFvt5iDI8i0Onj3u+TLYWpNyZP
         pIT4iSmiA/ZRxhggHkI041QYrGrqA+EE8oIO9OdWa/8TCviv87cwNfe2kniolMFG7ptz
         PQni3Xw8cILMJx9iKfwujohpbfGNuODnnMi7iNwTOoCr6V8S7v2wN37D1Lsz5P1T9ms6
         DE64ni3ZaZWm0rdQwhFR4dHj6o+cr+UAbIgqw4GiDX98ZHJlI5Gtmai8mnR5Yw1QIRN/
         S9wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741876470; x=1742481270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GICFi0VoA04wMmuC8eF7tQ0MeFnd48JKTtPTlIjvHiI=;
        b=KUEBHTPj/BYM+eVnBYGT2YZ0Woeob3M/nlqIflGtTD8n/MkIgbT+LYsEGFi+LHsT7Y
         6FKCRDnhPTl9E69+6qE2FdLYINSKVll8ek0ORTHmFsfahqFRF9c2B4Ocv/0sfCqhUCRu
         RsgoE/8aPgf8AcMc6vMnwcYxc/Wc6+3jF0uvCinANKHJd15V/tc60LNBcHlOLsuuJX55
         tOCPYaoKlVyVj4kRHLa6+gcCVLZciQ0FtnLJkyrlEC14PloPaiKn+bOI1ijpbiu1x8Rg
         RWJk6SjiBlf4aP32aSueTr1ukJNn3UWbKy6VPOLqQih3g9awx9jEEKgdo//ke6/NzH9p
         EtWg==
X-Forwarded-Encrypted: i=1; AJvYcCVFxQ/NCMtCKXE/QaKVghw/I9+zL7L+vy16NikZ0/VsN0BuyA36+23DVqWArpsPEMOzkGdy3caypI8jJ6JK@vger.kernel.org, AJvYcCXynmT7km+zC156V8fpYhRBYZDDuovWda8dUGSRt3hmoRI0kM0TXxUwCvrprXExTLvuE9V0EAVuyeYL@vger.kernel.org
X-Gm-Message-State: AOJu0YzSde3ayM0UHYt+Ja86tU7He0/cqsZOn+IzXZLUCCmq7lx5ft30
	TIhmHbON3ekqkkvqDXbm78/2IamDaJ6tfo0c6KhYkRFxgKihjG7T
X-Gm-Gg: ASbGnctcCSOZsqXbAtrfD/bnJzkX1NncB02EcBZDn2UOJT1tIC+Yd8elG1ZKUj3Lr3p
	Yc/HMSfywIoNQ+sABONIMYm2HbpzX88chQmRj2FjUNUtdVGkETgsp7oKqlQ+4M9BT6oBod6Yv+l
	J+pTa4lS9GsBbLo0cMkhnSbuVyDV+TV88OxW71flKKTVTMI5idKO4YujW4yd0xrjnJn2DAB1s7e
	oOzsSOdKfuaJ4Ym6NYkfzqYtr0NfaUPJ64l+Mzoxow2KI59zIzOG5ejCqREv9Iv9Hwsym9hnDIb
	nmtinFbahGykj4UMNiiD8BeCYMW9n+U=
X-Google-Smtp-Source: AGHT+IGfaVAk+c9RAVXj/AWvec/u2Em3Jena5j9eOn/cnAaGId16whELS7F/FD8YOMC2w8PrpvsyVA==
X-Received: by 2002:a17:90b:380e:b0:2f2:a664:df1a with SMTP id 98e67ed59e1d1-2ff7ce594ccmr39877404a91.2.1741876469920;
        Thu, 13 Mar 2025 07:34:29 -0700 (PDT)
Received: from localhost ([2a0f:7803:fac5:a7b6::1])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-30119265943sm3891865a91.36.2025.03.13.07.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 07:34:29 -0700 (PDT)
Date: Thu, 13 Mar 2025 22:34:25 +0800
From: Zixian Zeng <sycamoremoon376@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Chen Wang <unicorn_wang@outlook.com>, 
	Inochi Amaoto <inochiama@outlook.com>, Alexandre Ghiti <alex@ghiti.fr>, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, sophgo@lists.linux.dev, 
	chao.wei@sophgo.com, xiaoguang.xing@sophgo.com, dlan@gentoo.org
Subject: Re: [PATCH v3 2/2] riscv: sophgo: dts: Add spi controller for SG2042
Message-ID: <ujqeq5do2xqf5jvepxaynaxridccalbjows7gid4ehyj7jduyk@2axt2thtet6z>
References: <20250313-sfg-spi-v3-0-e686427314b2@gmail.com>
 <20250313-sfg-spi-v3-2-e686427314b2@gmail.com>
 <6262dfd2-9e0b-402e-bb03-a2174d544923@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6262dfd2-9e0b-402e-bb03-a2174d544923@kernel.org>

On 25/03/13 02:43PM, Krzysztof Kozlowski wrote:
> On 13/03/2025 14:11, Zixian Zeng wrote:
> > Add spi controllers for SG2042.
> > 
> > SG2042 uses the upstreamed Synopsys DW SPI IP.
> > 
> > Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
> > ---
> >  arch/riscv/boot/dts/sophgo/sg2042.dtsi | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> > 
> > diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> > index e62ac51ac55abd922b5ef796ba8c2196383850c4..9e0ec64e91a2330698aea202c8f0a2ca1f7e0919 100644
> > --- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> > +++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> > @@ -545,5 +545,31 @@ sd: mmc@704002b000 {
> >  				      "timer";
> >  			status = "disabled";
> >  		};
> > +
> > +		spi0: spi@7040004000 {
> 
> Does not look like you keep order by unit address (see DTS coding style).
> 
Thanks for reminding, I will read it more carefully.
> 
> Best regards,
> Krzysztof

Best regards,
Zixian Zeng

