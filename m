Return-Path: <linux-kernel+bounces-203696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 054D98FDF2A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1778C1C218AE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 06:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D1B13A896;
	Thu,  6 Jun 2024 06:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Xd1GeeWG"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9D63AC16
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 06:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717656878; cv=none; b=H6wn0p/x6PYNdHbjq4RUwxEvJ3HwyezAkzg+z1rBeikNSY8BhTJpYA6bMs24btsKp2WuddUUZfxNtrXwh7pv1TFVTjETjP22Ilja+z1ILbAuneEGXw9uf9L3xLdHQbq4ZpUDVQxJy9yZkjUff81gCs+AJDjDploblAbGIIUKgEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717656878; c=relaxed/simple;
	bh=KSdDPxC5VUh1WnamIAbzz671Erp4LUNSssBAt5dfhn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txR7GNss6IS07bRlEqhyCWHmu76A4RdzSC1C6XGQ6i27IhqJ8XxOdENLdNkmTkUe/GgsFTpgglAI0Y4qrR30qU4j+GTGFlyFAVUelD0uisNxmqA6dDjhbS6BOKBh9cWQo/8QWPoDb0+2+uCHkSVD3DY3rgUYPrELXhf8elIGhjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Xd1GeeWG; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-35e83828738so680787f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 23:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1717656875; x=1718261675; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a7TCmXGWr94ZoD3g1UVXKN5ISjES07LkwWyEhWG4/I0=;
        b=Xd1GeeWG9v03txlf+IeiUr4isYxVXO7sIlwVrFgtx1zja6n/fz2iQPtu9T/SkSo4K+
         DpyV/FkNfNHxSIxjwzogopPQt73IMD3+32oj5r1+swWqeEdbBTODAoWErX6qJ5EhbA0R
         HtTfy7QuwaPn4Xw2Vnc3ZKfxCc7TComljJDoArtRbb7vtxsbwXhv3+n3YSv7av+TlfXd
         Cxw7LiDF6mp/sNv39elNFu06CElZEKRl1/b4t5s7zI5rVUcrjmcAe5u8tm1H9iTQCg4n
         IWigq2oVWJBeoHB0JUs38ul+2sI5OrV4XqceY9663k5lfLm1aTv5aOw3k9g1eAia2hF4
         S/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717656875; x=1718261675;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a7TCmXGWr94ZoD3g1UVXKN5ISjES07LkwWyEhWG4/I0=;
        b=MadEW5zNaSn7O0byd9dbWS3AThx+2nJqmDHW0m1uNf+/S6W6qPp1VhSgMJSxz+tcet
         1eYuh/Y5PHAILIQnKVuBMrBmZGVVzBbfcvKTfuR0NUSfVTo69Hop3rdfRoNpHx8avWbt
         EksRzr7fnAbYdM3zD3CbCHVh0Rz7JMpQow3ceVLy+f3tez0kTg8MrHNJcGEMeUvrzN/W
         rZquj8pUU6FYDZqUqJ4cNzLq15ybPri4OXN+cP2eTm7vH9L1M5wUX+crv7e+80eLLVEP
         SWuHLwi/MMrznWsR3DnQl5mtOliE18JtT20Ong56eFQAAri/UFj6huUJFNCX6DCixcRO
         AUTQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3+2v+al6c8agjiRSyd6t77VtatA3xIK6eEYPpaBLRXoAnRZ8VqiRNGB4gnyM5IuUGJz+BsMoAY3sLQCm99TC1vqcrdxeuyKsqh+nE
X-Gm-Message-State: AOJu0YwJyWa6Z0Ne0WmBGIsptI3+MVSnzXDeF3CwasCo6/tOW76747ag
	uTEeKyWGhme+b4qY2v5LIRu4kkPuNIY3U91SSSXpTekld8axsbzQhmC+DQztRvU=
X-Google-Smtp-Source: AGHT+IHNKnXIBb3qZJygU2iYDImkZ9rzUJkNBWDBUa1dYfWFLGg6a9Ze5BMW5kuAh9PHrPhk9uqCHQ==
X-Received: by 2002:a5d:4711:0:b0:35e:83f3:ea0a with SMTP id ffacd0b85a97d-35e8ef65b69mr3594626f8f.48.1717656874844;
        Wed, 05 Jun 2024 23:54:34 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5fc1ca8sm714821f8f.97.2024.06.05.23.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 23:54:34 -0700 (PDT)
Date: Thu, 6 Jun 2024 08:54:33 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Anup Patel <apatel@ventanamicro.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Nick Kossifidis <mick@ics.forth.gr>, Sebastien Boeuf <seb@rivosinc.com>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, iommu@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux@rivosinc.com, 
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v6 2/7] iommu/riscv: Add RISC-V IOMMU platform device
 driver
Message-ID: <20240606-988b5519747e28c276f9a952@orel>
References: <cover.1716578450.git.tjeznach@rivosinc.com>
 <7dcd9a154625704cbf9adc4b4ac07ca0b9753b31.1716578450.git.tjeznach@rivosinc.com>
 <20240529-08fd52a8e703418142bdfa84@orel>
 <CAH2o1u7N03b3dzxxG8jp7qW2jmCDADwq_OL2Ayv1AL1XsA7s5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH2o1u7N03b3dzxxG8jp7qW2jmCDADwq_OL2Ayv1AL1XsA7s5w@mail.gmail.com>

On Wed, Jun 05, 2024 at 11:58:28AM GMT, Tomasz Jeznach wrote:
> On Wed, May 29, 2024 at 8:15 AM Andrew Jones <ajones@ventanamicro.com> wrote:
...
> > > +/* 3.1.3 I/O MMU Directory cache invalidation */
> > > +/* Fields on dword0 */
> > > +#define RISCV_IOMMU_CMD_IODIR_OPCODE         3
> > > +#define RISCV_IOMMU_CMD_IODIR_FUNC_INVAL_DDT 0
> > > +#define RISCV_IOMMU_CMD_IODIR_FUNC_INVAL_PDT 1
> > > +#define RISCV_IOMMU_CMD_IODIR_PID            GENMASK_ULL(31, 12)
> > > +#define RISCV_IOMMU_CMD_IODIR_DV             BIT_ULL(33)
> > > +#define RISCV_IOMMU_CMD_IODIR_DID            GENMASK_ULL(63, 40)
> >
> > RISCV_IOMMU_CMD_IOTDIR_* for all above
> >
> 
> I've checked latest RISC-V IOMMU Arch Specification and it looks there
> it is a bit inconsistent in IODIR naming.  The acronym IOTDIR is used
> only once, while all other references to directory cache invalidation
> command use IODIR.  I'll keep _CMD_IODIR_ here.
>

Indeed. I've made a comment on the spec clarifications PR to suggest the
s/IOTDIR/IODIR/ change.

Thanks,
drew

