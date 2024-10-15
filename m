Return-Path: <linux-kernel+bounces-366121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C01F299F122
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 17:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 503A42855C4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409841B392E;
	Tue, 15 Oct 2024 15:27:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7A31CB9F0
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 15:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006040; cv=none; b=AfsmUyZXr5x+UIKQD296KxzJe6YlDFsBQCP7DCzhjNJrGWo1clbfnyfuCI8mpcspLIyp0v7gBdIRJQO4HbhgOjELquFnPVr3nMUjJafrZAkatZPA3PI7u+wUj0I7RRYs+Hnzn95XWr0O/CyHwHflHgXShZ60OXvuwuEEGPqFWfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006040; c=relaxed/simple;
	bh=N2Ln+aEjxKMa/7wm+47qp1m/vsaHP6ujHem9CtyRT2k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CDFcgk9jlxDUrSk3zl6Nyx3Vcn70lSXoM5tiinYu+DlMgSnrA3jjNDgfbUBXKuE+Vs04YEAAfdSrOk85HNRe9ydGitAtGdexDntNMOvEzaVIz5BG86l25kMN1ppKQsR0OwwMC2XvsoFG8h/31yG9sm7dK7Fin1QCBwDd3hYxh24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 718CAFEC;
	Tue, 15 Oct 2024 08:27:47 -0700 (PDT)
Received: from usa.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A668C3F528;
	Tue, 15 Oct 2024 08:27:16 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_ffa: avoid string-fortify warningn in export_uuid()
Date: Tue, 15 Oct 2024 16:27:04 +0100
Message-Id: <172900588452.967423.9099985566745262812.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240909110938.247976-1-arnd@kernel.org>
References: <20240909110938.247976-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 09 Sep 2024 11:09:24 +0000, Arnd Bergmann wrote:
> Copying to a 16 byte structure into an 8-byte struct member
> causes a compile-time warning:
> 
> In file included from drivers/firmware/arm_ffa/driver.c:25:
> In function 'fortify_memcpy_chk',
>     inlined from 'export_uuid' at include/linux/uuid.h:88:2,
>     inlined from 'ffa_msg_send_direct_req2' at drivers/firmware/arm_ffa/driver.c:488:2:
> include/linux/fortify-string.h:571:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
>   571 |                         __write_overflow_field(p_size_field, size);
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Sorry for the delay, was trying to see if I can test BE kernel and see if
it needs more fixing. The spec does require all memory region to be LE.
I will do that later, for now I am pulling this as fix for v6.12

Applied to sudeep.holla/linux (for-next/ffa/fixes), thanks!

[1/1] firmware: arm_ffa: avoid string-fortify warningn in export_uuid()
      https://git.kernel.org/sudeep.holla/c/629253b2f6d7
--
Regards,
Sudeep


