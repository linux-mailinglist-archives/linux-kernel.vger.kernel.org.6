Return-Path: <linux-kernel+bounces-449843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F779F56D6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 20:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F060916305D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 19:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3731F8F19;
	Tue, 17 Dec 2024 19:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bhMd8kkF"
Received: from relay.smtp-ext.broadcom.com (saphodev.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5983D1F8EE4;
	Tue, 17 Dec 2024 19:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734463408; cv=none; b=KpGN5YPWa29dLFvNkyakyN1c0BibumeBj0aY67DuLcpihkHNndt+Y94GUDMxvSoLuT6+IPprBd/Zx40zZLxd7jxVCnQk5xWeYTtKxc8XrYYo/iuUboHU6pD6slFnLiom8lWFson3VU191HsXPGudBoSp91Rv5Qe44QnniWKB0Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734463408; c=relaxed/simple;
	bh=z3O9X4cCETRNLKQE42m6HIig5AJctABu+gJD9WkgDG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nm7FN/S3rqRrvZi6lJlnTQ6ztxXmpq/8Qb78F8+orDYfbcznY3XLO3dt+XCw4dloQI1Uf/aZwYibsYHvUA0OYii9x6BrBEIVLOtIxoMRmdBb9ks4EDYxejYMKEGPVfs4ob/hkzCctMm8SoQrnBS58PGiU4NmC+gfF+6lOO0BcG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bhMd8kkF; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id E2640C000C84;
	Tue, 17 Dec 2024 11:14:13 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com E2640C000C84
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1734462853;
	bh=z3O9X4cCETRNLKQE42m6HIig5AJctABu+gJD9WkgDG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bhMd8kkFkRNFj2qmVJ4u8bXmDWWepJhvQ4Wookqg98ljKFkJXAZmN2vCM+7Oq/AVK
	 yKIJeLl7JJVsClJGi266erG+t87u8lKVCDTkdBxjNA9AgiyT+z/2aiwK6oRCNyc4v7
	 p/ddbLHB+SjXG+h9dcg9N570RjKrxqVp1BP37HuI=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 786D718041CAC6;
	Tue, 17 Dec 2024 11:14:13 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: bcm-kernel-feedback-list@broadcom.com,
	Rosen Penev <rosenp@gmail.com>,
	linux-arm-kernel@lists.infradead.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	William Zhang <william.zhang@broadcom.com>,
	Anand Gore <anand.gore@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>,
	=?iso-8859-2?q?Rafa=B3_Mi=B3ecki?= <rafal@milecki.pl>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: bcm4908: nvmem-layout conversion
Date: Tue, 17 Dec 2024 11:14:12 -0800
Message-ID: <20241217191412.872240-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241203233632.184861-1-rosenp@gmail.com>
References: <20241203233632.184861-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Fainelli <f.fainelli@gmail.com>

On Tue,  3 Dec 2024 15:36:32 -0800, Rosen Penev <rosenp@gmail.com> wrote:
> nvmem-layout is a more flexible replacement for nvmem-cells.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree-arm64/next, thanks!
--
Florian

