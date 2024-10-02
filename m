Return-Path: <linux-kernel+bounces-347267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8CB98D049
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 11:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 176151F20984
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BB81E201D;
	Wed,  2 Oct 2024 09:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="F5iDH2c6"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060EF194A4C;
	Wed,  2 Oct 2024 09:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727861616; cv=none; b=ouYAZLL+a/lws7EC1cA3Y6OFeVum7y0MKaNKL1utQ/IW9WAh4FdQetV2fruok7vzEupPYuEizAETL7Ms/Tsphpxx/Y8L7I+5SaaqcdIm/Qu/Z9Vh9qAlJedfdbBKFz3APKu7jdt8apL8X51iHoRbNQEdEeaKiWWPBIZ5CxGkdgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727861616; c=relaxed/simple;
	bh=VTzA+1gkUUi2xDLP+JRBQlFWEL4kGMVHY3XG7CgyQe8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ohf5OedEMF9GyMJ+d4A3DnLvGDY3cQiL+vJVtK3FezNSCj7no4xQ8XsSHkqB0o2J7L81MjlQzp7w1I9s6iXpzKYaWxUP2xQua2jaXr4EQ0XhtuHPmShO8+TpyBPKD1rCufsDdeGQzyY4jZz94u+aWWrZSKdL6E1++f6I1u4ukaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=F5iDH2c6; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727861613;
	bh=VTzA+1gkUUi2xDLP+JRBQlFWEL4kGMVHY3XG7CgyQe8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=F5iDH2c641tW8Nb7C9o3px43DzLxB+c7jt9ZFNAy+j5apOXxvIuh8qj8JauZHusdf
	 A9K22V5hjrLzX282ASZldSmSwN/mc/I1J4Q7a2DB3S1wK/b8EX/LPNpWptgFZ+stZE
	 1Sp2jN0onzeUJjkm5yOermakRKV2b0dGKrVBPHmsL4+n1iO3VCBb3Krt7fKqhl3qGr
	 NZLUC0MPtxuYDCl5g51OW4Z0j5MlzcIF+Xhje+SUEt70TQOU3CukeZ8S8sJgDLQoGB
	 YwA57a8A+TGv5TX6UHF7SMhcM2PuC4EH3Ff58amwM/R8TZ5gDfRei82Y3MqWq4Cpmc
	 Yk+wJlHlgrCTg==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id F205017E12D3;
	Wed,  2 Oct 2024 11:33:32 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Hsin-Te Yuan <yuanhsinte@chromium.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
In-Reply-To: <20240911-venc-v2-1-5566c07756fd@chromium.org>
References: <20240911-venc-v2-1-5566c07756fd@chromium.org>
Subject: Re: [PATCH v2] arm64: dts: mt8183: Add encoder node
Message-Id: <172786161293.39477.1050965471166477083.b4-ty@collabora.com>
Date: Wed, 02 Oct 2024 11:33:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Wed, 11 Sep 2024 09:07:03 +0000, Hsin-Te Yuan wrote:
> Add encoder node.
> 
> 

Applied to v6.12-next/dts64, thanks!

[1/1] arm64: dts: mt8183: Add encoder node
      https://git.kernel.org/mediatek/c/4045f71f

Cheers,
Angelo



