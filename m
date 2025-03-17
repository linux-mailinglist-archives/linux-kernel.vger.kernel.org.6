Return-Path: <linux-kernel+bounces-564263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FEBA6516F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A9143A701A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E7123959D;
	Mon, 17 Mar 2025 13:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VTyYtTNs"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B1C23A9BA;
	Mon, 17 Mar 2025 13:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742218738; cv=none; b=A2cqbK736KljNlSD5SOpUh+5EYUFrFa05Q+gRmBw4cEo99J0Cfc0RZMpUBdox0K0Sz7TFiHVRIyGok9q243JZFxRQfTWyk8r/0BDDYl+fo8aMzjRZS05b6w8Zx9XU1AAOUlv/9pSM7AxSPgXsDLU0cort8kyWM5dzsZuaDsb6wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742218738; c=relaxed/simple;
	bh=bAPzg4jZ6yCIFwOyTlpOE28lXMU29xomma+LuF2yFQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UpgJ/MeTHwu1wBxO4iAy9o0AOb0UMOJZTAupI5bM3beL4K0eHoZeuDYFVNj/YMp3SMMfkJu7xKmf6SCiaZtRZFFSQIfD2J7iAuO5AXx3jpHjvvmIiORutmEy6I4EGsJsi+a81grGw43H42dY/NvDpyOvs2t5iXLqPNDX7KByxfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VTyYtTNs; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 9C5A1C00151B;
	Mon, 17 Mar 2025 06:29:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 9C5A1C00151B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1742218193;
	bh=bAPzg4jZ6yCIFwOyTlpOE28lXMU29xomma+LuF2yFQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VTyYtTNsAbfn0v4FGtsHck+XBGa+bf7Vj4qt7NI64d9BWW9TkdmTYzb1UpHrArO5Z
	 ADSXXSp1nYHIk3sxWXjgKPdI2HT+g0lzFxw1s6N2exu+DD86u6jhszw2PHoIYLjfFU
	 MUKN/xNQLu7sAc0vVLmCOYFivnXcmumDEsCcclfw=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 0F8E818000520;
	Mon, 17 Mar 2025 06:29:23 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: bcm-kernel-feedback-list@broadcom.com,
	Artur Weber <aweber.kernel@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Stanislav Jakubek <stano.jakubek@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v6 03/10] ARM: dts: Drop DTS for BCM59056 PMU
Date: Mon, 17 Mar 2025 06:29:22 -0700
Message-ID: <20250317132922.2698513-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304-bcm59054-v6-3-ae8302358443@gmail.com>
References: <20250304-bcm59054-v6-0-ae8302358443@gmail.com> <20250304-bcm59054-v6-3-ae8302358443@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Fainelli <f.fainelli@gmail.com>

On Tue, 04 Mar 2025 07:20:34 +0100, Artur Weber <aweber.kernel@gmail.com> wrote:
> The BCM59056 PMU has its own separate DTSI, meant to be included
> in a DTS file after defining the pmu node on some I2C bus.
> 
> This seems rather unintuitive; drop the DTS in favor of adding the
> BCM59056 PMU node directly into the device DTS files.
> 
> If the amount of subdevices supported by the BCM590xx grows, and
> a common device tree turns out to be beneficial, it can be reintroduced
> in the future.
> 
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian

