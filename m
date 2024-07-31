Return-Path: <linux-kernel+bounces-269962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E38CE943959
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 01:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A18B5284668
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 23:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0C716D9C5;
	Wed, 31 Jul 2024 23:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="uY8jO4N4"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B606C16C695
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 23:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722468224; cv=none; b=GzRabKxDHB1SPCOLF8tCf+1ulCDv4pnlHS5XExnTqs8cmoa1DoHP3NjqAVCryjxyK0mYW1hninMTBx9Y2C+8rq7AqwDw50akWb67BRaJcRSqyOuav1KoTBhaDTtMQuOW4kUQYFX6lgbSy3yFA6S3b5E6rmrh36rOe2sdvhzaluk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722468224; c=relaxed/simple;
	bh=xJ/PoO+jSDXOXRYnuGkrm/s7en6iAfdvKpADsTSs6Aw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DKn9wpZ6pBTH7GjrcKqkjYSr4sJ3wrQN8cCd+Cy8KtIYk+zv6VVEC0tOQY+OCSQNgnDq7rxa7TDiuUy0FF67ya6LSlqKkXvOpvG/zTpb29evt/dE1K3OIgEDtw4K/zQZZ4x74LJV0PwqF/IAdaAeatTrGqfd3o4CHv5VquoCVEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=uY8jO4N4; arc=none smtp.client-ip=192.19.144.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id EEFB8C0000F7;
	Wed, 31 Jul 2024 16:23:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com EEFB8C0000F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1722468216;
	bh=xJ/PoO+jSDXOXRYnuGkrm/s7en6iAfdvKpADsTSs6Aw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uY8jO4N4Xj9au57a/GoZ51HbLBml82kRr8OgK8ouhVa4InUhMC+ZinFNumXhMSqpC
	 2pzRoj3esMGDJ4SCM6it/iGvZT2QeBFGEP7gcQ4BLU+WtZ1u32AnrtxZ4+DhhDDjUx
	 4Z/uc3d9/09MCi/MURGnre2cIq1zjo0TmAP0pCnE=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 53AB418041CAC4;
	Wed, 31 Jul 2024 16:23:33 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: bcm-kernel-feedback-list@broadcom.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-arm-kernel@lists.infradead.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Russell King <linux@armlinux.org.uk>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: bcm: Select ARM_GIC_V3 for ARCH_BRCMSTB
Date: Wed, 31 Jul 2024 16:23:35 -0700
Message-Id: <20240731232335.2716205-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240726233414.2305526-1-florian.fainelli@broadcom.com>
References: <20240726233414.2305526-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Fainelli <f.fainelli@gmail.com>

On Fri, 26 Jul 2024 16:34:14 -0700, Florian Fainelli <florian.fainelli@broadcom.com> wrote:
> A number of recent Broadcom STB SoCs utilize a GIC-600 interrupt
> controller thus requiring the use of the GICv3 driver.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/soc/next, thanks!
--
Florian

