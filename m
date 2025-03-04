Return-Path: <linux-kernel+bounces-544700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 014F8A4E43C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28A97188D259
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B974627F4EB;
	Tue,  4 Mar 2025 15:28:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CCA27F4DA;
	Tue,  4 Mar 2025 15:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102120; cv=none; b=Y2g1jwDRlAxDFB2Em5T2zQoF11xcSVrQbkj+SnkURsWcgcNeeCXdZi0ud6eWaT6sjAg0cFoUKcYuSziHe/V7DZAlQk2x8R+zwYD25mheNFqtBcrxgXJNp3QUAz5n9mn11N2XaMoSbjWt2SodtZDwTDoxS0p+bfd42Uf2kpbUU90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102120; c=relaxed/simple;
	bh=xc4FEz4bXKZ8lIctaMZAYMrMWNeamvFBp6wijgRXR3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fM24qd9suDBE2I0cqZq/YzFVEYPeHITtZ/7ZRb4bl3nMaOLe40rZXk7VIS86R8XeWXKHTivfYrkd7lzHzFtU6ZASXqxKFmteX3u115mAQSBJtMcrqKq2TLrsasEh+PHjHPKSD0+r/Jpqz8MyZ18ms9FGi/bI6zpPdKekzhpUA9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D2A72B;
	Tue,  4 Mar 2025 07:28:50 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 399773F66E;
	Tue,  4 Mar 2025 07:28:35 -0800 (PST)
Date: Tue, 4 Mar 2025 15:28:32 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Cristian Marussi <cristian.marussi@arm.com>, soc@lists.linux.dev,
	Sudeep Holla <sudeep.holla@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	Luke Parkin <luke.parkin@arm.com>, Peng Fan <peng.fan@nxp.com>,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_scmi: use ioread64() instead of
 ioread64_hi_lo()
Message-ID: <Z8ccIBTgn6n7CYXh@bogus>
References: <20250304144346.1025658-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304144346.1025658-1-arnd@kernel.org>

Hi Arnd,

On Tue, Mar 04, 2025 at 03:43:34PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The scmi_common_fastchannel_db_ring() function calls either ioread64()
> or ioread64_hi_lo() depending on whether it is compiler for 32-bit
> or 64-bit architectures.
> 
> The same logic is used to define ioread64() itself in the
> linux/io-64-nonatomic-hi-lo.h header file, so the special case
> is not really needed.
> 
> The behavior here should not change at all.

LGTM. I just sent PR for v6.15 this morning. Either I can redo PR with
this included or you can just apply this directly. I am fine either way.
If you go for the latter approach,

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

If you prefer me to send updated PR, let me know. I don't want to create
confusion by recalling by PR and sending an updated one without consulting
you.

--
Regards,
Sudeep

