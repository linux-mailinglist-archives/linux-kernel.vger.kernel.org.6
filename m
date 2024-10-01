Return-Path: <linux-kernel+bounces-345262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8628798B3BC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 07:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E714B229F0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 05:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A821A4F2B;
	Tue,  1 Oct 2024 05:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLft1ETq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45801BC073
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 05:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727761100; cv=none; b=nbLM+fZuK9ArAfiTX993grKvl/eToV+xjkoqtXUlHXjrDGqpSmJAJedW4MZeHPLA4tnprFL06VfkIS5Zpy6WGRDavu5RU/uKv1my7OXBZCW2LZ8S5X5PFn+TrqHsC4qNkgqKK1CRmW41hHMX/GuE6fPHDH7b9j3jkA/v7z+DMvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727761100; c=relaxed/simple;
	bh=KWHKsBqafASDIcbljdst2Hf9v1Awn2C+S3J8HKqz9zQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tp4ajOxKdn4fPzixhtdHnZxuVzPh8SrV30kY7H5/8zZ2V1q4JgiYhjYQZASNw6i/3qgCuCnXsTqDMD/CSp0L4WnDwWc4RVp4BXu1rYtLi0doXza64LspBb2iCOispDuwB41KMHocqvJMoee84eGQiCWTmPDw4aq6EJbC2h2XwXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLft1ETq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D3EC4CEC6;
	Tue,  1 Oct 2024 05:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727761100;
	bh=KWHKsBqafASDIcbljdst2Hf9v1Awn2C+S3J8HKqz9zQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MLft1ETqhuR+CYOGxey7FAl9KzwHTi606ejrkAgQUwX7PmST7+XdLxQsxu81hzqFp
	 lbqfLgzQcXbzq62hbSkx7gRbHG+deOfHSZcRy+GXp5V2xxQm1VFR76SnvZxZavastI
	 V7hhwfbkTAVcQPcu4p5QLIF++ZP+XV5ynbXuw21zKcNuj+X7WU9CTSMMUJLcagtHjT
	 gN3yePvGSk2KFs/WxdRlNYvgf3RErGl5vM3Aj5f2D3IgSYvE30G0bFMWgb6lm8uzJJ
	 +HwwF6pel/0q7SPIf7EgtZ5gdkmBtKwcLYMQoO6D9mz79ZiGKawjrqF9YETS2KsEr2
	 g9q0ZSNfe5Acw==
Date: Tue, 1 Oct 2024 07:38:15 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, <linux-kernel@vger.kernel.org>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 10/15] acpi/ghes: move offset calculus to a separate
 function
Message-ID: <20241001073815.4720a986@foz.lan>
In-Reply-To: <20240926130348.00005e45@Huawei.com>
References: <cover.1727236561.git.mchehab+huawei@kernel.org>
	<5e8c2f0267a21d05ed09c8af616a92d94638c474.1727236561.git.mchehab+huawei@kernel.org>
	<20240926130348.00005e45@Huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 26 Sep 2024 13:03:48 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> escreveu:

> On Wed, 25 Sep 2024 06:04:15 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > Currently, CPER address location is calculated as an offset of
> > the hardware_errors table. It is also badly named, as the
> > offset actually used is the address where the CPER data starts,
> > and not the beginning of the error source.
> > 
> > Move the logic which calculates such offset to a separate
> > function, in preparation for a patch that will be changing the
> > logic to calculate it from the HEST table.
> > 
> > While here, properly name the variable which stores the cper
> > address.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> Trivial comment inline.
> 
> Given this is a placeholder for more radical refactor I'll not comment on
> the maths etc being less flexible than it will hopefully end up!

Actually there will be two versions of the math calculus after the
next patch series:

1. one compatible with versions up to 9.1 that work with a single
   source ID, using offsets calculated from the hardware_errors
   table, which doesn't contain the number of sources. Such code
   will be used only for migration. This is the one on this series;

2. one that will get the number of source IDs from the HEST table.
   Such math will be added at the next patch series.
   This requires a migration-incompatible change to store a
   pointer to HEST table. The math there is flexible and should
   work with all future changes, as it uses all offsets from the
   HEST table, using the links there to the harware_errors firmware
   file.

So, basically, the migration logic will check if a HEST pointer
is stored. If so, it will use (2). If not, it is because the VM
that was running on QEMU 9.1 had its state stored, and then
was recovered on QEMU 9.2. Such machine will then use the math
from (1), which supports a single source ID.

Thanks,
Mauro

