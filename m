Return-Path: <linux-kernel+bounces-363765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDF099C6B6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F1CA1C226C2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209B41591E3;
	Mon, 14 Oct 2024 10:08:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E2D15350B
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 10:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728900485; cv=none; b=Szuzm0joQJZzAP+FncysNL3AJEy2jBF7xysHSkHGLw8mDi4SGJqdpFYCQJOUMYShvoCpt8+ukkw7mOH4Ez+WeUdO3FX0Erwc5l5JsRq5qIoGFiKieHhY2K0dy7pQJriOHud7DlsrIkoXAZbHGVMHQFSas8+tkj14olEa3Zt8n0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728900485; c=relaxed/simple;
	bh=eisguIa1DUbGZcCHzV5xbY6nRTsk7zaOgI5BbL9HOuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fzoXqPCXYK8tcz22N3gd+AJfXOiNXAo1CJTNtpKiW4ESPMQKf2GCuExte9LFZ71jjNGwcoy2QeshdhoIlv34MBDLlB/h8N/teZsk5TyM3N40pIEEebihMWLGIfixlyPo+DxNc9pvpDt3GI/EO8848AZGfLB9H5nmxtNsCFGYcNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8DD11007;
	Mon, 14 Oct 2024 03:08:32 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DFA73F51B;
	Mon, 14 Oct 2024 03:08:02 -0700 (PDT)
Date: Mon, 14 Oct 2024 11:08:00 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Gavin Shan <gshan@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	shan.gavin@gmail.com
Subject: Re: [PATCH] firmware: arm_ffa: Fix warning caused by export_uuid()
Message-ID: <ZwztgGdmNMrsqO7c@bogus>
References: <20241014004724.991353-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241014004724.991353-1-gshan@redhat.com>

On Mon, Oct 14, 2024 at 10:47:24AM +1000, Gavin Shan wrote:
> Run into build warning caused by export_uuid() where the UUID's
> length exceeds that of ffa_value_t::a2, as the following warning
> messages indicate.
> 
> In function ‘fortify_memcpy_chk’,
> inlined from ‘export_uuid’ at ./include/linux/uuid.h:88:2,
> inlined from ‘ffa_msg_send_direct_req2’ at drivers/firmware/arm_ffa/driver.c:488:2:
> ./include/linux/fortify-string.h:571:25: error: call to ‘__write_overflow_field’ \
> declared with attribute warning: detected write beyond size of field (1st parameter); \
> maybe use struct_group()? [-Werror=attribute-warning]
> 571 |                         __write_overflow_field(p_size_field, size);
>     |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Fix it by not passing a plain buffer to memcpy() to avoid the overflow
> and underflow warning, similar to what have been done to copy over the
> struct ffa_send_direct_data2.
>

Are you observing this just on the upstream or -next as well? There is a
fix in the -next which I haven't sent to soc team yet, will do so soon.

-- 
Regards,
Sudeep

