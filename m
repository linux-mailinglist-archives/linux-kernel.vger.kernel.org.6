Return-Path: <linux-kernel+bounces-366140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB36F99F14F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 17:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCFBC1C22678
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBE61B395B;
	Tue, 15 Oct 2024 15:34:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D341CB9E2
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 15:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006488; cv=none; b=Sd5qzeat9enVgzwlRAK2GNzEAQw+D7JfDzx4b9xFw0OFxMkQTMT0Xfou4nTriO0Qm6P4P1+lsozS1cA3cLZXfPEk5PJqyYUUVGF5t9FVIr2O8y76231F0QFGTMp+K7mZvUxnOp2mEzOcOLvbpr80PZEU3CeyAqshq33psbVmm5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006488; c=relaxed/simple;
	bh=xhS0XLp+5SZCTkY2kX7og82TOFnL3aT/8UkxttjeGLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eUB3M1weYQR6i0XR65prRCNVghGBY+lTaxR21PjnBrIA0WLShWh2Dsi1Tbi2hXU2dfNktKSpKIbm6nkZP/R7eA1dYjHWwJma5ipqAauseGhjmNJr2nw92lkhnudLI5CA4VZcAsjdYzsqITObNwNNtdBZn9DyAyD1hIRSKVDwpQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DA27FEC;
	Tue, 15 Oct 2024 08:35:16 -0700 (PDT)
Received: from usa.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8F6E83F528;
	Tue, 15 Oct 2024 08:34:45 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	Gavin Shan <gshan@redhat.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	linux-kernel@vger.kernel.org,
	shan.gavin@gmail.com
Subject: Re: [PATCH] firmware: arm_ffa: Fix warning caused by export_uuid()
Date: Tue, 15 Oct 2024 16:34:43 +0100
Message-Id: <172900612833.968325.8271791440801761945.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014004724.991353-1-gshan@redhat.com>
References: <20241014004724.991353-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 14 Oct 2024 10:47:24 +1000, Gavin Shan wrote:
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
> [...]

With the modifications to the commit message and subject, applied to
sudeep.holla/linux (for-next/ffa/fixes) partially as required, thanks!

[1/1] firmware: arm_ffa: Fix warning caused by export_uuid()
      https://git.kernel.org/sudeep.holla/c/b0798838418a
--
Regards,
Sudeep


