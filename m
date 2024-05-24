Return-Path: <linux-kernel+bounces-188828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D458CE78E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 17:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5370282800
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 15:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5586812D1E7;
	Fri, 24 May 2024 15:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gsgvX6Hj"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E16B12C7FD
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 15:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716563378; cv=none; b=N3Ylbzq0vsa1Iclg0tpS8tJgbNCJbqLhIzjz7FbQNkd7FkZxMNRCwN3lMd53SgBQgbOQU81czf1kf1QMAFWqbkz6N4D8SfDxHEWLgKAaQIyero/5upuu2xW0xNTMNj/MVP1Ka5O/qhT/vPI1+Wte4Nb6Nagc2GykOCCftMfoAJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716563378; c=relaxed/simple;
	bh=ZHnaZHaZskD/xonYeSEZFFMg+YXeoBIVEBxcMi8GbMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uEEsqZenzTZuvIQE5g8gIjnC/mHdINLdcITO/aXDL4bTJi/iNRMDR80IVZpInFfAQo8y/4ar1ZOBsmm925HQ7Nf+Wd6LNVVA/eg63/irDzcKDvln6TyF3PbYjOvNNWzsmviFJIX17+AG2lZgCmMgeHaxEMWTu68lNW2K3a5FXjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gsgvX6Hj; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-792ecce9522so268400385a.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 08:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1716563376; x=1717168176; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JPPk9ZMB0Ku0hRWNSYQthiNRSt0noAUHxb8eADGB9tY=;
        b=gsgvX6HjugJJ0dQc6gTulNKF8t0nJmmC/VSsBCBv7yr07ySteF8jDoolV6WS3cGRfx
         4I4Dte3aYty2pVGmlAw6+hBvjKwq06Vh1eS9LEWgXs5+smKd/lch5AxR4sdgztBagxMK
         t5DpFdTc/Dn2psnbn8xvy/NhTLicqpXZKnISF/xC4f1zBNE7VZIbdt9lRbLbxBo5cjg0
         QEDTPpsAzCUKIzmM2qdLKBfVBMSZ74TkgLF8LTAM+aqyl8DgF6j9ZHFo11oVFc+0UmAq
         b8wkqau1zPRGUl6+Kv2nEjw+ZBDJBqftbuqsN+lqs3aMcJi+/PXgNjFrtqcNy5VU4Kcb
         O6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716563376; x=1717168176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPPk9ZMB0Ku0hRWNSYQthiNRSt0noAUHxb8eADGB9tY=;
        b=vniQ4Iote0J/xukYV0pjew92rsPCMqzFrVHt7wdmsblxgIml/sufsKB11nWZdgkPQ4
         4eAa/QnYlNqJD1610jkuvtRAzRVN5QjsknYREuu/BpW8Ab6W2ayzq1Jv/khma0fT9Aor
         xAtcib/5d/866Vh3oThKfe5vAruplGBBvUWmn/MSxApVIb9QrkF7p98wET7dlLVbUFw9
         Ir1kAociGnB8lhb1MIin8hWMWWGA55qMooy1aR5sksgUgCJG+rOElXQJwTvSpPcJRfjJ
         I5c3GT78vjZQEsepY3e13S+q57yvT9FnMqmeJh7mCmDm/ojrXyNSW0GBTyJJeoY9o/7b
         kzqA==
X-Forwarded-Encrypted: i=1; AJvYcCUB0kTBkvSPHne6LbxCJXIeA6NmeHFCWrRGoRytBjlHUHt7v88YyaGgN//lE9JLjvh4wmbVb0ho6MuKnfI9J+OSkO40xZiudKFbDT1O
X-Gm-Message-State: AOJu0YxEAcL2u/ArBn/N82EZDEqWAz9JwEQc6s2NgzZ1bMqU8dEQmZWQ
	UX/UYG3sEbWk6rRBe+e2DBrW/6xCfiqB0YdxNVbJOpkiEfuK7uHvk6LOxhiat0o=
X-Google-Smtp-Source: AGHT+IF+iMK+Fk/kuTHFaJ9i9wXeJLcDfA5+fUTHGZpkoNnrMobEJ8vPGJL+mvQIBsyXRFWw9nLt/A==
X-Received: by 2002:a05:620a:2603:b0:790:d62a:da09 with SMTP id af79cd13be357-794ab08688dmr336194185a.5.1716563376237;
        Fri, 24 May 2024 08:09:36 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abcc0f04sm71408585a.42.2024.05.24.08.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 08:09:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sAWY2-001QzP-Mh;
	Fri, 24 May 2024 12:09:34 -0300
Date: Fri, 24 May 2024 12:09:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: Anup Patel <apatel@ventanamicro.com>, Zong Li <zong.li@sifive.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>, linux@rivosinc.com,
	linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Sebastien Boeuf <seb@rivosinc.com>, iommu@lists.linux.dev,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Nick Kossifidis <mick@ics.forth.gr>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-riscv@lists.infradead.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5 2/7] iommu/riscv: Add RISC-V IOMMU platform device
 driver
Message-ID: <20240524150934.GR69273@ziepe.ca>
References: <cover.1715708679.git.tjeznach@rivosinc.com>
 <4a1ac62b8b452f9face321c29502dee8ee88191c.1715708679.git.tjeznach@rivosinc.com>
 <CANXhq0os1R3kR7dCKWs1Yu1ZeaKoQ2b3Q7QbvyU9nRgbB8ZFmA@mail.gmail.com>
 <CAH2o1u4j9MS9Pq7d=4skq-nLM7c_x0Dwqy8WxVfO1FBSWqA0yg@mail.gmail.com>
 <CAK9=C2Wff07Q72LXrB9POz=91t4SNZ8AaLhQdjjjXhbqTYKCHA@mail.gmail.com>
 <CAH2o1u5N9ZdXePh=aJHkYOpLMXeuwQTzCuQJyLdgc3-FAKim2A@mail.gmail.com>
 <CAK9=C2VAWa4jzCW63q366rB60wk2KDUJmF86EtQkVcMYLyiPBg@mail.gmail.com>
 <CAH2o1u4jbObtXDAiXkedy_7P6VyRVTFj9OtmqwjgGYYfys1RmA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2o1u4jbObtXDAiXkedy_7P6VyRVTFj9OtmqwjgGYYfys1RmA@mail.gmail.com>

On Thu, May 23, 2024 at 09:13:43AM -0700, Tomasz Jeznach wrote:
> > > The activation of IOMMU_DMA for the RISC-V architecture will be
> > > feasible once the core components achieve compatibility with the DMA
> > > subsystem, which unfortunately is currently not the case. Without
> > > IOMMU_DMA enabled, driver will recognize RISC-V IOMMU hardware,
> > > register itself in the IOMMU core subsystem, and will provide basic
> > > IDENTITY protection domains for connected devices.
> >
> > I am not asking for IOMMU_DMA feature instead I am asking for
> > supporting device MSIs in this series.
> >
> 
> Ok. Makes sense.
> I've looked at the option to pull in / add small change to enable MSI
> bypass window for systems with IMSIC enabled. With that, MSIs will be
> supported, however without full interrupt remapping capabilities that
> could IOMMU provide. If that sounds as sufficient change I'll add it
> to this series.

Honestly I would prefer you keep that seperate as we really need to
discuss the irq window stuff in alot of detail. The current thing ARM
has done comes with alot of problems.

This series seems pretty good to me as is, let's get it merged.

Jason

