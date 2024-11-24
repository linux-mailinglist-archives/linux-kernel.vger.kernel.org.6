Return-Path: <linux-kernel+bounces-420212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D7D9D76FB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 18:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34DC0162E3C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 17:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1358D136658;
	Sun, 24 Nov 2024 17:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Zr4OYZPW"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328327DA9E;
	Sun, 24 Nov 2024 17:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732471000; cv=none; b=P5Mp9D6OGhGk553s3/oxtZkpJthuJXkJBs6fIkRGIUj48uHupdHTUCpw07f2bR78DhwISklFckFlpl5VmY8TMlgH+E0G9ST22iU47kap6r9RBU31xhpC13moH6zlMF1O5k3rW7LvbkoR7fyyedYI9v4+Uix7UQ0wghW+tdU2P1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732471000; c=relaxed/simple;
	bh=omKfrIu9Szug/NDSWVuj7hq1/WQIb1fsz5nxzoOP0tc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PNAIQJJcc5WR6hKc/okGWapf2qdeIhb0pUuI0weCnQtmrz3ezDAxWBzg3s48AXAApYhbUrYX9SszCZbt2tVNu8QUTPV+I0wqKCxuBKEdYi0ihNJFGvd35g+jusVdVZ3nUbzLXe8fp/ciJg5sk4sJAIlTc12/Vd5mhlIxfqaTNVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Zr4OYZPW; arc=none smtp.client-ip=192.19.144.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 30E61C0005CA;
	Sun, 24 Nov 2024 09:56:38 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 30E61C0005CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1732470998;
	bh=omKfrIu9Szug/NDSWVuj7hq1/WQIb1fsz5nxzoOP0tc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zr4OYZPWdIrszxHZdD9AqxfrZHoS9RzwmIKI/4D7j3Qp0/ixhkl/WVYrdYL6d4u2g
	 jwRoxERLcwMTJQF7vrKgvM6/HQG7t9MwjhqwJEy7IGr+neiFv99FbbsFdzCO4vZ2mO
	 94eKMyFG8gmOicgTdnRdFc8nlO+tjDv79+PzBjXM=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id C09E418041CAC6;
	Sun, 24 Nov 2024 09:56:37 -0800 (PST)
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
Subject: Re: [PATCH v2 1/2] arm64: dts: broadcom: bcmbca: bcm4908: Reserve CFE stub area
Date: Sun, 24 Nov 2024 09:56:37 -0800
Message-ID: <20241124175637.718510-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241005050155.61103-2-CFSworks@gmail.com>
References: <20241005050155.61103-1-CFSworks@gmail.com> <20241005050155.61103-2-CFSworks@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Fainelli <f.fainelli@gmail.com>

On Fri,  4 Oct 2024 22:01:54 -0700, Sam Edwards <cfsworks@gmail.com> wrote:
> The CFE bootloader places a stub program in the first page of physical
> memory to hold the secondary CPUs until the boot CPU writes the release
> address, but does not splice a /reserved-memory node into the FDT to
> protect it. If Linux overwrites this program before execution reaches
> smp_prepare_cpus(), the secondary CPUs may become inaccessible.
> 
> This is only a problem with CFE, and then only until the secondary CPUs
> are brought online. Ideally, there would be some hypothetical mechanism
> we could use to indicate that this area of memory is sensitive only
> during boot. But as there is none, and since it is such a small amount
> of memory, it is easiest to reserve it unconditionally.
> 
> Therefore, add a /reserved-memory node to bcm4908.dtsi to protect the
> first 4KiB of physical memory.
> 
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree-arm64/next, thanks!
--
Florian

