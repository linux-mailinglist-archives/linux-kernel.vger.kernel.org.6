Return-Path: <linux-kernel+bounces-229966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B079176A2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 05:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D1E31F21D4C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 03:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B488433B3;
	Wed, 26 Jun 2024 03:08:07 +0000 (UTC)
Received: from smtp.cecloud.com (unknown [1.203.97.246])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639C01BF31
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 03:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.203.97.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719371287; cv=none; b=WwsMYQMbH8Dv6d6KZetLLDtfqTiaRHcZGraioUswUPF2OV4PcJ6Fmg0ar3wK/SiY5ZSEaV5mWuoCSd92sai7ThgFuSHwATejKIYWFi4hh91JsbY/ZLBY4p4XF/9wLKifoTkc9a7QLSMJKCZ+hecxOEU05m+7fe47024mFkIWaKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719371287; c=relaxed/simple;
	bh=phX7r94f0B4XgDM8W4Xm5iv11Qth0PBnKuBTST6Q6wY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WSakXS/bQ5fKrFaz1M0uuZ7oYScCxKj+qkKnMem2WuUE2qCe8l5ydXAnpPuyjSqS9OvzCAYY5T8rbAVwvQBOWlcv9JlYtDrQ246hPv0Z/mnpOExwnb/aa+nVGw0BZesWxLE0ypMYVPqZYBxIPVd0EqJBJMXUBrQOXyTtrMGjsdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cestc.cn; spf=pass smtp.mailfrom=cestc.cn; arc=none smtp.client-ip=1.203.97.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cestc.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cestc.cn
Received: from localhost (localhost [127.0.0.1])
	by smtp.cecloud.com (Postfix) with ESMTP id 500887C0113;
	Wed, 26 Jun 2024 11:07:55 +0800 (CST)
X-MAIL-GRAY:0
X-MAIL-DELIVERY:1
X-SKE-CHECKED:1
X-ANTISPAM-LEVEL:2
Received: from localhost.localdomain (unknown [111.48.69.245])
	by smtp.cecloud.com (postfix) whith ESMTP id P2702681T281466057453936S1719371274062938_;
	Wed, 26 Jun 2024 11:07:55 +0800 (CST)
X-IP-DOMAINF:1
X-RL-SENDER:liuwei09@cestc.cn
X-SENDER:liuwei09@cestc.cn
X-LOGIN-NAME:liuwei09@cestc.cn
X-FST-TO:prarit@redhat.com
X-RCPT-COUNT:7
X-LOCAL-RCPT-COUNT:1
X-MUTI-DOMAIN-COUNT:0
X-SENDER-IP:111.48.69.245
X-ATTACHMENT-NUM:0
X-UNIQUE-TAG:<21e3102dd15893daf6ecfb6599a630d4>
X-System-Flag:0
From: Liu Wei <liuwei09@cestc.cn>
To: prarit@redhat.com,
	Liu Wei <liuwei09@cestc.cn>,
	will@kernel.org
Cc: andrew@lunn.ch,
	catalin.marinas@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] ACPI: Add acpi=nospcr to disable ACPI SPCR as default console on ARM64
Date: Wed, 26 Jun 2024 11:07:23 +0800
Message-ID: <20240626030723.74067-1-liuwei09@cestc.cn>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <021b66fa-07ad-4ab4-8be9-94985f412d54@redhat.com>
References: <021b66fa-07ad-4ab4-8be9-94985f412d54@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Prarit Bhargava <prarit@redhat.com>

> On 6/24/24 23:05, Liu Wei wrote:
> > For varying privacy and security reasons, sometimes we would like to
> > completely silence the _serial_ console, and only enable it when needed.
> > 
> > But there are many existing systems that depend on this _serial_ console,
> > so add acpi=nospcr to disable console in ACPI SPCR table as default
> > _serial_ console.
> > 
> > Signed-off-by: Liu Wei <liuwei09@cestc.cn>
> > Suggested-by: Prarit Bhargava <prarit@redhat.com>
> > Suggested-by: Will Deacon <will@kernel.org>
> > Suggested-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> > 
> > v2: Add a config option suggested by Prarit
> > 
> > v3: Use cmdline acpi=nospcr instead of config
> > 
> > v4: Some description in comment or document
> > ---
> >   .../admin-guide/kernel-parameters.txt          | 10 +++++++---
> >   arch/arm64/kernel/acpi.c                       | 18 +++++++++++++++++-
> >   2 files changed, 24 insertions(+), 4 deletions(-)
> > 
> >  ... 
> > 
> 
> This looks good to me.  Sorry that this took so long Liu.
> 
> Reviewed-by: Prarit Bhargava <prarit@redhat.com>
> 

Thanks, my pleasure.

Liu Wei
 
> 
> P.



