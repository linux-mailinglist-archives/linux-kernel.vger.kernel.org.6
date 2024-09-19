Return-Path: <linux-kernel+bounces-333562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B7D97CAC8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 16:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E5931C21E97
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 14:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AFF19F462;
	Thu, 19 Sep 2024 14:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ierh5v8x"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FC319D06C
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 14:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726755128; cv=none; b=eKWJt99+HlP6txD4Z80VjaN7bEWULEeKiwjeT5RUURMRmEedsgt7+5JPgNJC9Ie50o0mc95X/f8JBqtVZTwXjofQPeBR35DTmD4W8X+vOPuHR6Dha+sfTOFuowqijy6io5gzW90Z4f1B2Z2gvO3XX5rUi2lID+LR52+GaaBs77M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726755128; c=relaxed/simple;
	bh=gKYIrwWM4T+4pTLrMDj3UfsSfYvBSoDMQPXzFvX7ot0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jo38L92nGwYeFM2WbpebC2MBxayxPeBoiStTC0u9U+rjhys1OqsyzeTMN5t9ciO5eAxN+BXsNtSUy+2aNo+w4xas8/zCFaacmgfKya7MGsQEZKEd/1n3kVEcXaIoKElT+8Y2B023HtavoXTPJba75+S4l3dhjPYBlxfMaqQY0Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ierh5v8x; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7191fb54147so662843b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 07:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726755126; x=1727359926; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UtnnCn0Y9s81n+qtO2rzBAYRraJEO13QyZhtfk47L/8=;
        b=ierh5v8xIKP0OwC/PZYZ28jzaaf8FZJw8h5FfceFd3ybQG9bbI6RbahFLkJJzaZ8v2
         qnkQeB6UWjtb7JQET91iS/aa4VZnWcXChio3xJgWX8lPre1GqSB4Hqfv6wcYtZvrwV0u
         YYNAb8qgnJDmYprgK/AG4liYYnFxjUstnn7yg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726755126; x=1727359926;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UtnnCn0Y9s81n+qtO2rzBAYRraJEO13QyZhtfk47L/8=;
        b=rYZ/gZR4ipS86PgvlZZUFG7xTGyHhoXw6l0v+lRv6pHEyP5FTsps5PEb+4nh3S7IMl
         XTfHleJAgyQf1NMOQOlo4jJ5pxuohheG7C8WTWj1d1vMcBokn2XFQ2ukmMTX35suVmok
         g+7K0LGMsVShB1S3k0rEt9eRRHdC6u98zpHONJAEi+WFU3Lt7ev4kAHPuhRF+ZHQh3ef
         L90Nv2NnJWSIiRofrCcigkFWX23LRnnRBFgYRadXiVL5VgqF5lUe1WEX3YDoGg4vGtIL
         9oRO4pAWjNPbtGrx3Zosue+O3IVQrsVildCd288hrKWXD6KmSJxtrq/q4p83zaA+bXoR
         xUdA==
X-Forwarded-Encrypted: i=1; AJvYcCW8nWlx7wljiskOWzNxD4koE+fRqeK+0C6lWTmeJVvVdYfIh3rYUZMg8htOOKo6AlpsOrJe08mJDXyMB68=@vger.kernel.org
X-Gm-Message-State: AOJu0YxybQlL9qBLYcRLIuGdwj1xukM4R/2uPUVUFrFBcBrgn8JAIsT6
	gF+ATpd0Jb7oABMtvIA2o2bFbsglWHILNq3P0+2y1O4ml2BJgney8DNofKsepIpabsqCWok6ysA
	Q4aaKHIEwK9MB7Qq5VgcEP7c/mlVbszXEdFXw
X-Google-Smtp-Source: AGHT+IGoStBkUPa4cMi0EbIpGRCcX+qBpsWamtDxERCCwWwMTz0H/z/l3wbYy/jPsGN5xXbhZr5+SIkNuF7xBTjuMgs=
X-Received: by 2002:a05:6a00:4b16:b0:704:2563:5079 with SMTP id
 d2e1a72fcca58-71926211ddemr37413927b3a.27.1726755126090; Thu, 19 Sep 2024
 07:12:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com> <20240918152136.3395170-19-patrick.rudolph@9elements.com>
In-Reply-To: <20240918152136.3395170-19-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Sep 2024 16:11:48 +0200
Message-ID: <CAFLszThWr0zbnVB4wgNYFCK9Quxqa_MsHOcDOTixnMbn7Ly9tg@mail.gmail.com>
Subject: Re: [PATCH v4 18/35] drivers/cpu: Add generic armv8 cpu driver
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, linux-kernel@vger.kernel.org, 
	Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Sept 2024 at 17:22, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Add a generic driver that binds to armv8 CPU nodes. The generic driver allows
> - to enumerate CPUs present in a system, even when no other driver binds it
> - generates ACPI SSDT code for each CPU
> - Fill the ACPI MADT table (implemented in a follow up patch)
>
> The newly introduced code could also be reused on other CPU drivers that are
> compatible with armv8.
>
> TEST: Booted on QEMU sbsa and verify the driver binds to CPU nodes.
>       Confirmed with FWTS that all ACPI processor devices are present.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---
> Changelog v4:
> - Export armv8_cpu_fill_ssdt to use it in other CPU drivers
>
> ---
>  drivers/cpu/Kconfig     |  6 ++++
>  drivers/cpu/Makefile    |  2 ++
>  drivers/cpu/armv8_cpu.c | 73 +++++++++++++++++++++++++++++++++++++++++
>  drivers/cpu/armv8_cpu.h | 21 ++++++++++++
>  4 files changed, 102 insertions(+)
>  create mode 100644 drivers/cpu/armv8_cpu.c
>  create mode 100644 drivers/cpu/armv8_cpu.h

Reviewed-by: Simon Glass <sjg@chromium.org>

