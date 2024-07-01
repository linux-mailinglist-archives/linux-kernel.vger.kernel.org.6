Return-Path: <linux-kernel+bounces-235630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA7D91D7B4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 07:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6D27280F96
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 05:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FE241C85;
	Mon,  1 Jul 2024 05:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="CpEu1hZC"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBBB383AC
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 05:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719813143; cv=none; b=BIvEzWiMytVbeUFq8epgxfNooXPa0iC/OgEPlS/HQfu1A7CX98XorQ+xtP2wBbsaBTIDDNVQ58zUubP+VRdd3i932/E18NJA8tmSrr4X8FTqQzYxgw0X1jXAIOZew1Ep+NCTR2zs19x3gYoqXNKlsyAD8yzJBdbqfnjlMNqtzAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719813143; c=relaxed/simple;
	bh=vZGko0eoNLnj84zRoOPdlydINGSPQ6fYtJo/KDahuY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNm4wdFwcAYdk6a/BLPCqtWcex4cnlm+3xWVH+ADjFcY9PL1OnoRRdO60yLKvfXAYTDBryCqxmdEwlxdA6J5Th2so0dsXqJnwDOCX56Q9xQlD+VJaPBOeMw3gTWlPX1mYxywkaxwV5ynIooLGAePFI85/4T0dCN8Wzp+6FR/Nl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=CpEu1hZC; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-702052976f7so1105193a34.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1719813141; x=1720417941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aKMU8DKIWEClgPDBnmDjtT7Ao2B1dNYMjzwF2iFrrjI=;
        b=CpEu1hZCoRVZqXhtpRCFV7/VZ4tUIUEaOQTxBIG4rA9LQvmcuZn+UZBbHFdE13kyZi
         4XCjy6vPsX9WCOA0m5PbhVqIEJDMoNnmHGcZfVQCvTRbdAJgS70RmEPSomNcy5D+pugp
         wjQdPHLQXyg4cxrxz0gnFsWDYJKw7nIi6qt+UBwUIphXz9blveDHDUM+jPQnlB7s+1EP
         mzHFsoDt3Ulf/ru4hdUtcFuDD+yukWX7ccTwfUnoqRX6BBHWniQGV6rAXmbVPshlpCMK
         1KNT8NFAYsbe/7OP5JySlZyPLAr/fLzu3b4wal6zXkbfkulDNBj0HLSJfJS8KhiouGSm
         Kjfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719813141; x=1720417941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aKMU8DKIWEClgPDBnmDjtT7Ao2B1dNYMjzwF2iFrrjI=;
        b=SKQ9UWR9GnHZpM8Rm4bTBvmloU8enNIDezpRGEB/Fa2fQ3cU/YeSwcwx/8VH+Lbs6i
         FP/66MinWDT+Tru78wHFZwtpGaFKQRTT5vYs18yKsOX0NJ/A7wbJRmsCr8fFuw6yM/bb
         i1Rq3n7q8ULPvnDwPlGpXZeUZMDOBEzFIK++hdOrrh4InNY5L48GVY9H73L5YZpIL6LA
         0r8PFmQ8N1nouHO8TmyDVneu4gYy+fLk5fdvR9sR3MMhOY8kEy73kBec3JvgZYx81jRx
         76I4jQpO8OkpJkcXq3qlhly7+dbfYbIIRkOlycHUazQJBNUJDecILOYjUG8AarxNYmYD
         eJmw==
X-Forwarded-Encrypted: i=1; AJvYcCU2rQOeDXeY8PLF+acBkf4EjiGn88B5eFoDr0nnSy8ELEdTjCivjbSrRQjRe41VqzHXuL6mgJVjqjbFTKr91NOH6EsJ/mItUWxUEn5U
X-Gm-Message-State: AOJu0Yx6tQdJWrZDBqDuVz8swQOCPsvBHyysdvAYFnI0vVCKfgLQfTw2
	EJkuYgkWZ+6NTH18HoT40V7u+J3CrvhdIC6XUqbVkS43ejT3sl+pqk50GgZoqJc=
X-Google-Smtp-Source: AGHT+IGm7YJAgZMyphMx4GQMzsUKLII+YHeZwD23+Ey+akRFhATjAn/ybArgYnMmQp/igw9JEjVJmw==
X-Received: by 2002:a05:6830:903:b0:702:1d8:4d08 with SMTP id 46e09a7af769-702076a4d47mr8000813a34.35.1719813141012;
        Sun, 30 Jun 2024 22:52:21 -0700 (PDT)
Received: from sunil-laptop ([106.51.187.237])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-701f7a9b2d9sm1167621a34.6.2024.06.30.22.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 22:52:20 -0700 (PDT)
Date: Mon, 1 Jul 2024 11:22:03 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Haibo Xu <haibo1.xu@intel.com>, Palmer Dabbelt <palmer@dabbelt.com>
Cc: arnd@arndb.de, xiaobo55x@gmail.com, ajones@ventanamicro.com,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Charlie Jenkins <charlie@rivosinc.com>, Baoquan He <bhe@redhat.com>,
	Evan Green <evan@rivosinc.com>,
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
	Zong Li <zong.li@sifive.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Chen Jiahao <chenjiahao16@huawei.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Jisheng Zhang <jszhang@kernel.org>,
	James Morse <james.morse@arm.com>, Andy Chiu <andy.chiu@sifive.com>,
	Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Tony Luck <tony.luck@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Robert Richter <rrichter@amd.com>, Yuntao Wang <ytcoode@gmail.com>,
	Dave Jiang <dave.jiang@intel.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4 0/4] Add ACPI NUMA support for RISC-V
Message-ID: <ZoJEA85utEK6u36t@sunil-laptop>
References: <cover.1718268003.git.haibo1.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1718268003.git.haibo1.xu@intel.com>

On Thu, Jun 13, 2024 at 04:54:32PM +0800, Haibo Xu wrote:
> This patch series enable RISC-V ACPI NUMA support which was based on
> the recently approved ACPI ECR[1].
> 
> Patch 1/4 add RISC-V specific acpi_numa.c file to parse NUMA information
> from SRAT and SLIT ACPI tables.
> Patch 2/4 add the common SRAT RINTC affinity structure handler.
> Patch 3/4 change the ACPI_NUMA to a hidden option since it would be selected
> by default on all supported platform.
> Patch 4/4 replace pr_info with pr_debug in arch_acpi_numa_init() to avoid
> potential boot noise on ACPI platforms that are not NUMA.
> 
> Based-on: https://github.com/linux-riscv/linux-riscv/tree/for-next
> 
> [1] https://drive.google.com/file/d/1YTdDx2IPm5IeZjAW932EYU-tUtgS08tX/view?usp=sharing

Hi Palmer,

Can this series be taken for -next?

Thanks,
Sunil

