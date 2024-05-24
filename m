Return-Path: <linux-kernel+bounces-188974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9671C8CE930
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 19:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52460282707
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 17:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FD212FF94;
	Fri, 24 May 2024 17:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="bynRRlQz"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E1212EBDF;
	Fri, 24 May 2024 17:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716571207; cv=none; b=E31aXLi0VO4IDAgCrnLys4iwvYElB4EZOdXP1rHXVB4tRNn5V5a825E84RkMrPPmWN8cMk5nQUclnWjSt61P0jnDnHBv3E6Ewei1YYvN+q2gOerEmGiRFUvGX74STPsXeNafmJS+w5exxXyn0G150lcyNtYVr6vCL0hlb8TiYsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716571207; c=relaxed/simple;
	bh=eonL40+Pk3asZc+UKBPZuGT5B95x6t/3L/bXvfzRsao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ATQJYRYEHtE44oLgn2ydgmc9cg+uwMy+HM8THzcggT6QlX3kevweB8Wq1d4Hql0C/IhO4/lPWvbzJivvTDzTnQuI8WnGF6OueX/lvgGb6idOmWq/TLWWQFXbDRbj8K/mFGGt+ARXc3RnFF06wP0LqzrdqedE8t60Z6wrVHSpIcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=bynRRlQz; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nLHTgtbT8puPWoNapYpLARnpHQaGv88/tvf3aUFDQxA=; b=bynRRlQzkKmtw0bttGssCy2U+l
	Bm0L74mjmqheDpnsoLrgz0DOazu57WjH47PWddaZikXF3hpqosQlGugW/FKvQzdCha830yxrHl8dM
	r17yy8BLuLosi0Pn1ImHxDov0ob0ImIPnZavF+i39fhVd2bN3VlmU1zRSihLxXA0x9Az0XYD6c4Sf
	UW1as9sIpw3RVcW+rgt5g+hn4/PBbVy66ppU9SQbXVoQSYjFE1IgU1cnjOdABRSjGw4NXXJAZg1XB
	xr8nlrTcRBch2N+AkifTYImuSwxvMbXV+xrOYGa8Rn8cm5uqWkwFcpZI39oqWjurLxdiwhwIdC40F
	K+aiNCeA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37100)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sAYa6-0005le-0A;
	Fri, 24 May 2024 18:19:50 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sAYa6-00087r-GA; Fri, 24 May 2024 18:19:50 +0100
Date: Fri, 24 May 2024 18:19:50 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Nicolas Pitre <npitre@baylibre.com>
Cc: Julien Panis <jpanis@baylibre.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 0/6] Mediatek thermal sensor driver support for MT8186
 and MT8188
Message-ID: <ZlDMNkdE2jmFgD8B@shell.armlinux.org.uk>
References: <20240524-mtk-thermal-mt818x-dtsi-v5-0-56f8579820e7@baylibre.com>
 <238nnn48-0o7r-22q2-2rpo-s3n7n62pn2q4@onlyvoer.pbz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <238nnn48-0o7r-22q2-2rpo-s3n7n62pn2q4@onlyvoer.pbz>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, May 24, 2024 at 01:04:38PM -0400, Nicolas Pitre wrote:
> On Fri, 24 May 2024, Julien Panis wrote:
> 
> > [RFC] When PATCH 1/6 and 2/6 are squashed, checkpatch raises this WARNING:
> > "DT binding docs and includes should be a separate patch." That's why I
> > split them in this v5. The problem is that the driver can't be compiled
> > any more at PATCH 1/6. It needs PATCH 2/6 to be compiled. Should the
> > checkpatch warning be ignored here ? Should I finally squash PATCH 1/6
> > and PATCH 2/6 ?
> 
> IMHO it might be preferable to preserve successful compilation across 
> bisection than to appeal to checkpatch in this case.

Or, patch 1 adds the new definitions, subsequent patches convert the
users, and the last patch removes the old, now unused, definitions.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

