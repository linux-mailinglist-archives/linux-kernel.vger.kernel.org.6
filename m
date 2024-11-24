Return-Path: <linux-kernel+bounces-420213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 508109D76FC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 18:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E00C7163036
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 17:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A26F13774D;
	Sun, 24 Nov 2024 17:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FumobubJ"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B437DA9E;
	Sun, 24 Nov 2024 17:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732471010; cv=none; b=gsQjOpG+Tq7CInqYm3/rn5DW0IDdZnkDa5RbXE/zKn2j69ctMEZNXHdaBS6IgXAP6MP8lmkjO1t0uO6biunwZiCU8PR+O1EjLcWJ3e9Y2F98lIo8ZnYThijOmVE5PpY/+7iZV69KxGDtmKdZxm9wAT891HUBXgoxb3EdqDthrL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732471010; c=relaxed/simple;
	bh=/SBvytuI9Z8C816Rqt15Wi0YXl1GGrYWQ5VrqPQ7zo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EPS5XhAM+2zzU+/oL2JNBnLzN7AxoZVoT30UwSnbfItiSPnvhJuCesVxP5EJqC/gVZSHkynt74wT8+/ijREz6J5SKqfnShZp1nQpA29u3aodtIgio999CUH9b0OaCKSs6o3Xdbo858sINCe96aN4SlNKh8SgxihIvDpzgrhHg6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FumobubJ; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id AA4E8C0005C8;
	Sun, 24 Nov 2024 09:56:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com AA4E8C0005C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1732471007;
	bh=/SBvytuI9Z8C816Rqt15Wi0YXl1GGrYWQ5VrqPQ7zo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FumobubJ1/5491nB19drdCy132s7Rvt351SdSQ1/GvBUNODMl/Lq+X+xx0AUOdPdr
	 GnsQKjVM4kaj9+yuEpYBZhVYU1YAwmTAcdWB5+p9AKD9uuR0u2TzdGRfCigMkM3qw4
	 lXPcgUI/I0XGMxmjnu3XCKIcwK7eQOR4iv59OIGs=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 472C018041CAC6;
	Sun, 24 Nov 2024 09:56:47 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: bcm-kernel-feedback-list@broadcom.com,
	Sam Edwards <cfsworks@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?iso-8859-2?q?Rafa=B3_Mi=B3ecki?= <rafal@milecki.pl>,
	William Zhang <william.zhang@broadcom.com>,
	Anand Gore <anand.gore@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sam Edwards <CFSworks@gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: broadcom: bcmbca: bcm4908: Protect cpu-release-addr
Date: Sun, 24 Nov 2024 09:56:47 -0800
Message-ID: <20241124175647.718610-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241005050155.61103-3-CFSworks@gmail.com>
References: <20241005050155.61103-1-CFSworks@gmail.com> <20241005050155.61103-3-CFSworks@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Fainelli <f.fainelli@gmail.com>

On Fri,  4 Oct 2024 22:01:55 -0700, Sam Edwards <cfsworks@gmail.com> wrote:
> The `cpu-release-addr` property is relevant only when the "spin-table"
> enable method is used. It is the physical address where the bootloader
> expects Linux to write the secondary CPU entry point's physical address.
> On this platform, only the CFE bootloader uses this method: U-Boot uses
> PSCI instead.
> 
> CFE actually walks the FDT to learn this address, so we're free to put
> it wherever we want. We only need to make sure that it goes in a
> reserved-memory block so that writing to it during early boot does not
> risk conflicting with an unrelated memory allocation: this was not done.
> 
> Since the previous patch reserved the first page of memory for CFE's
> secondary-CPU init stub, which is actually much smaller than a page,
> just put this address at the end of that page and it shall be so
> protected.
> 
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree-arm64/next, thanks!
--
Florian

