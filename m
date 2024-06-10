Return-Path: <linux-kernel+bounces-208061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA0390201C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 13:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 086DE1C21287
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 11:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928257C6C1;
	Mon, 10 Jun 2024 11:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ljljwTWM"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5BC75811
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 11:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718017573; cv=none; b=cqphGqOmGfRSZDavQJPyf/89L0PPUrgiSrSUXOGVFea6ji2aw7GA8Y6hyEGUQzL5/V5eF1sWnP7xMkfpe9kP2yUJjGBktOuWrywS3MsD6w4d5aeeqDyzmU0oW4vua0j5URwDWZ3OxwlGAUhv2u7Y/Dtxq13ThuVwMYwLwxxzsLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718017573; c=relaxed/simple;
	bh=UHAN2MQAwy4F3MaHAlvjKZuTSk8SgdbiqOaACYFrup8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibEYSus7Jrm11xSZ+XNOE35o2U0yJLYb9vKrmFt8JX8TcvBvHurx8BmWYQy8n58mXKYhl6ApWRgppiQy04i8WVjt2oAPtmi4Qc/ZkBFjfvSlXIs2B/mesxSbUKlu5qkQIXwek0Cb4kZGbyrkyB5rCN4J9M5EbEf8R9Gr3sx6LP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ljljwTWM; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57a1fe63a96so5344003a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 04:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1718017571; x=1718622371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKRDnT36YiO5NHWmifxOcGKSpN9i3QJZvUnqhc0HlYc=;
        b=ljljwTWMZs2m1H3DSxmzx/qxIuNFsYHxsqZpRR+pPKfbJeW3wXnHX38UV4owxET6lS
         BB41rs6JptuSMByojqTi4zciFOn8xCMAg/vtdCaskGi+CxOEpX4EuD5+0ZwjadEhpZMC
         cZH+nwGwOxEjx6x8XPdlMKfESG+Ok6aTTwyzKxGRjJt5wLI96ZZG8BVTplbq2WNzrzL/
         9ZCdxCkl1q81XP0amhOAWjxi9bNGuIWgQngrKLSM89Hm90I9TPJBgShzJsQQ38s+8HSg
         /tc6P/K6n+QspSbphl0VmPQ8ItBqo0c3C1l//Msb7n5odGIIjEvO6gAZiaHKpFR7Jdhc
         YGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718017571; x=1718622371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZKRDnT36YiO5NHWmifxOcGKSpN9i3QJZvUnqhc0HlYc=;
        b=JNIR3ByM7M0OVNOJMlcbt/BI9wVz5SGeURdGn6skqwkp7QANEBU+U8T+wCuHu/ED7s
         SRQb+Ish+I8shUIIDWVBxGCacnAiMIbTrv9L19FFwKb6ZUNqG5XqY3qW5I99Z9PQ6Gzu
         nbVGWsMO26wxN7atOmI9HpiEa1cgboGAmIF2i4BjEd51PDO5d9dMWBDzTLNoOuBt8pRk
         35c8NphuYzxOI37dyIpE0YpHoUb7XuCX0bPDGki3XiaFuPsLebChWIL8mpM/gnxdecAX
         VG/VdeMJHPt+jC3VHW2NkVa8sO3+jeKliDa/3QpfQMwznazCuqCP0G5YEznVhExz0WE2
         tzxA==
X-Forwarded-Encrypted: i=1; AJvYcCX/q+wyTvNvlgaq+hEhde4/ipSJshRPkL5tYOFJdnhlU7EYvNxfE/TK8adI6gURaES9jl9MU+aGq4lGcKMlSnb5uO9Xlx40QXfpU9gE
X-Gm-Message-State: AOJu0YytGeEpvZVIDV4JPLgn7evytM3uGTIuVADOgfSzVBezL6SVWhWx
	MToGncWCNJ+zoIDwawc1XwSnjq06XkwuFCAGlW6Fd2XSdkjRi+7xU2ceUj3Ww64=
X-Google-Smtp-Source: AGHT+IHo0tOX7ZoqFEj30qNwq0kZf+ky7YJbEiSPIgRIvjy2gNXCneqdIFwRINKKmlx0kL4JUlY/jw==
X-Received: by 2002:a50:8d43:0:b0:57c:6d89:eaf0 with SMTP id 4fb4d7f45d1cf-57c6d89f06cmr3373682a12.14.1718017570481;
        Mon, 10 Jun 2024 04:06:10 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aadf9e093sm7201840a12.13.2024.06.10.04.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 04:06:10 -0700 (PDT)
Date: Mon, 10 Jun 2024 13:06:09 +0200
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
	Lu Baolu <baolu.lu@linux.intel.com>, Zong Li <zong.li@sifive.com>
Subject: Re: [PATCH v7 6/7] iommu/riscv: Command and fault queue support
Message-ID: <20240610-3cd1ba07c1b488a451dd7ddd@orel>
References: <cover.1717612298.git.tjeznach@rivosinc.com>
 <422f66285da1b164466b223f83d7f06564968f09.1717612299.git.tjeznach@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422f66285da1b164466b223f83d7f06564968f09.1717612299.git.tjeznach@rivosinc.com>

On Wed, Jun 05, 2024 at 12:57:48PM GMT, Tomasz Jeznach wrote:
...
> +static int riscv_iommu_queue_alloc(struct riscv_iommu_device *iommu,
> +				   struct riscv_iommu_queue *queue,
> +				   size_t entry_size)
> +{
> +	unsigned int logsz;
> +	u64 qb, rb;
> +
> +	/*
> +	 * Use WARL base register property to discover maximum allowed
> +	 * number of entries and optional fixed IO address for queue location.
> +	 */
> +	riscv_iommu_writeq(iommu, queue->qbr, RISCV_IOMMU_QUEUE_LOG2SZ_FIELD);
> +	qb = riscv_iommu_readq(iommu, queue->qbr);
> +
> +	/*
> +	 * Calculate and verify hardware supported queue length, as reported
> +	 * by the field LOG2SZ, where max queue length is equal to 2^(LOG2SZ + 1).
> +	 * Update queue size based on hardware supported value.
> +	 */
> +	logsz = ilog2(queue->mask);
> +	if (logsz > FIELD_GET(RISCV_IOMMU_QUEUE_LOG2SZ_FIELD, qb))
> +		logsz = FIELD_GET(RISCV_IOMMU_QUEUE_LOG2SZ_FIELD, qb);
> +
> +	/*
> +	 * Use WARL base register property to discover an optional fixed IO
> +	 * address for queue ring buffer location. Otherwise allocate contiguous
> +	 * system memory.
> +	 */
> +	if (FIELD_GET(RISCV_IOMMU_PPN_FIELD, qb)) {
> +		const size_t queue_size = entry_size << (logsz + 1);
> +
> +		queue->phys = ppn_to_phys(FIELD_GET(RISCV_IOMMU_PPN_FIELD, qb));

Shouldn't this be something like

  FIELD_GET(RISCV_IOMMU_PPN_FIELD, qb) << PAGE_SHIFT

ppn_to_phys() assumes the ppn it's converting to be shifted up by 10, but
FIELD_GET has shifted it down to zero.

Thanks,
drew

