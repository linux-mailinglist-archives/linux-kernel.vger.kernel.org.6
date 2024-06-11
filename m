Return-Path: <linux-kernel+bounces-209837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77535903B98
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 14:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FF321F21F17
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 12:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8E017C213;
	Tue, 11 Jun 2024 12:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="P24EE+7/"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDDF17C201
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 12:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718107944; cv=none; b=oe8NOXlNKbQcYNmTiQxoh4WmHXJ5k9UcVFrA5c1zEawtVoKZLrj+9cYxtTJAt9TjLlmqbuIA6HAddgxYV9hdjLe8W2b6CRSmrUWEvKDD+YdHqhMROEopfkcZcv8DZuBdF9ecCFJlKRSrxKbZAabjnWGqmRElWctcQZxsM4rfq3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718107944; c=relaxed/simple;
	bh=sIbNJUSxjDR6r4OKpjG9oJgb7z911EUrOwt9KL6BXgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOoaIstEqXHkZiZGFuOTsn6DH5rEf74QTOHylMnuLw0FJikJhXf6O1TQj3VB3bm9dt0HqhHbjHbM8Iw7mhZGglBf2e4ky9Dm19NK9ROb8VCFqE4EGJoidrpAhJyq1KACbyXiPXY5M28ZRAc02U4SRWUigUCSUV988hYeHmr9rMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=P24EE+7/; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7971a9947e6so49902985a.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 05:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718107941; x=1718712741; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sIbNJUSxjDR6r4OKpjG9oJgb7z911EUrOwt9KL6BXgo=;
        b=P24EE+7/YyuEVvQOGKiDeS6CiAex8HT23tTTROqxjraUl3+kO2ce3TKNfUXEMgRcVR
         ToZEBFt8IGpElH7xeV0pvg4k0Mki0sq6UgagHZsrPKEPEpo+sc0UCh5VCmeuD2eVnstX
         /JwC3CxDx9e+it97mZy0Gikd4IcXnF6DwrERTplIgIBS5JJxPHBzJV7gUVEC+EMCL8m0
         72JMAHlzlQPUFjnAdc4gJTl2wNQMypLVxFIpynSvpKR44tFAcJz3OhQlAy1AHGBHMtha
         1FDV6hpFGEjqfD7qfxEwURReAWBOoCbHXCbzeVafEpXj1YL/IIblEAr/A5T0TVqtZail
         uKsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718107941; x=1718712741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sIbNJUSxjDR6r4OKpjG9oJgb7z911EUrOwt9KL6BXgo=;
        b=dNo7ngiVd4EBk/F+sdZdE9dLUawoQgRyEkadomzb0h8GpCrSZEht4dskeOtsjwAOVB
         kpmWOSZqegDlPhoaqCetMECPAQa8HEMO3NxofOVKwajBg3HnBIzeVyVz0vAM5LCLM/Mc
         8HqYJHnLg62BiflY+g1KVIb7KCwV0UD2ciLQTQmXNC2sCIICZ77bchQWQ2e1f2k2QAWW
         cKCTh4xe7Qz7lkT8KL/Obsker0ZB/wsFaogNxsKwpPLJ8m6rZ2rOw+JFvOOp6r+t5nGT
         lCsP1WHhIYG351m+lmbCsD8+Z9pngjlqEL5LQwPfBAaqCSTqwO5zvs9pVEKGRPtnHObo
         WLVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOSnG9k7OHDn43eU+MZ0f/luzXe2+LWJyLTtnVbhqZMHhwCBhP2ZK0wkfgQu8V9aaiCAFh/1zyg1t19OX4Dhcxi73HQVhC0z4TTK3K
X-Gm-Message-State: AOJu0YzOJJy++4RBifHx84f+7asmJOnPJamZV/nJokK/A9z07ecN9ick
	MPgRBWDSU/EJP882XC6waVVlIGd3cCa0A0bIo/mAprJv258oqVvoztKPDDl4363LmgME6KmHGjv
	Knc0=
X-Google-Smtp-Source: AGHT+IGrA5stCDnRo1H5n9Y5w5ElO81oVmgd60ewDFQ3Fm5sCDbN4V5n/Tt2xc1pS6BW64I2SfmIhA==
X-Received: by 2002:a05:620a:24cb:b0:795:4cde:3b1c with SMTP id af79cd13be357-7954cde3cf7mr1271288985a.6.1718107941369;
        Tue, 11 Jun 2024 05:12:21 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79556b3ac83sm292416485a.127.2024.06.11.05.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 05:12:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sH0MN-001OhE-1j;
	Tue, 11 Jun 2024 09:12:19 -0300
Date: Tue, 11 Jun 2024 09:12:19 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: Zong Li <zong.li@sifive.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Anup Patel <apatel@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Nick Kossifidis <mick@ics.forth.gr>,
	Sebastien Boeuf <seb@rivosinc.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux@rivosinc.com,
	Lu Baolu <baolu.lu@linux.intel.com>, Jim Shu <jim.shu@sifive.com>,
	Vincent Chen <vincent.chen@sifive.com>
Subject: Re: [PATCH v6 5/7] iommu/riscv: Device directory management.
Message-ID: <20240611121219.GP791043@ziepe.ca>
References: <cover.1716578450.git.tjeznach@rivosinc.com>
 <e18ec8ac169ae7f76e9044c26d0768e6469bad19.1716578450.git.tjeznach@rivosinc.com>
 <CANXhq0p4gERQeROSCSKqxnRZq9-fGfmROGV8JZyqFaenNpnsLA@mail.gmail.com>
 <20240610174934.GM791043@ziepe.ca>
 <CAH2o1u4c6ttUWTb1zrc8DScDMuDJJYR-tTHCPYW_3FV4uuQDtA@mail.gmail.com>
 <20240610222051.GO791043@ziepe.ca>
 <CAH2o1u7X2zu42ZYA9wBe4bmCXN9v+d6j9vo5DMifJA3BUew91w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2o1u7X2zu42ZYA9wBe4bmCXN9v+d6j9vo5DMifJA3BUew91w@mail.gmail.com>

On Mon, Jun 10, 2024 at 07:00:34PM -0700, Tomasz Jeznach wrote:

> For now, I'll change the implementation to assume negative caching for
> DDTE and will follow up with device tree / driver updates to make the
> invalidation optional when revised specifications will be available.

Is there a reason to make it optional? It seems like it doesn't have
any performance downside to just always invalidate, attachment is not
a critical path operation.

I could see making something like negative PTE invalidation optional
as that is more performance path..

Jason

