Return-Path: <linux-kernel+bounces-354839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 195C8994335
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 11:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A33F28E76A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 09:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFB613C80C;
	Tue,  8 Oct 2024 08:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Zykpkf0S"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16055166F29;
	Tue,  8 Oct 2024 08:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728377733; cv=none; b=FJIxgpGQsxi4vGtVJglQYqVuxoPUdw6z6qvQM1RZFIO89l+P3WjvmVAN91IC4eJbK8bfW7KNlmwqRjd0vamsXqd6DnfC/aeP+iV/o6rISG8r0YqtVSp+AhVcZFeCjlb5tUItV3EAYujUiD6svkWvBO6Q6lFkh7oDXwJqpspa76s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728377733; c=relaxed/simple;
	bh=rvjGmFEsoc0/TUD1jfFG2aFMzQUg4L/iSKC6A+/Qo7E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BKekP5vizKY3FYhI0+vDIMsher1yOpgVDzpOEVcshi0T6ysyt4nXe0/ymr+uZTl+qE3g1hW+PkBxVJZ5vxMJqmGLO6EjXJTN/J/+yVYsC4r98H6qrx6/7t1qz/fEQFNxbH8PFkJA6x/TtwB2nGW8vdKcAlWYtMX2gRw12oZLEow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Zykpkf0S; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1728377730;
	bh=rvjGmFEsoc0/TUD1jfFG2aFMzQUg4L/iSKC6A+/Qo7E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Zykpkf0SnNylPL05nhtlqxHronlK952S9bxwc2slA0PKGVnU0lDmZMFov/NJULfoT
	 mZPDh/f9R3kWqGn13jrZzlUq6UZyqGPrEeJugWlIqs+nvrdyVAYunFUhKBV7PvfA19
	 10l52WpC4JQTuXUt2nwpKKNYJ0gBB8MBMr5wOeBTmgwH45bq4bGnrLsjjf0i39Lk7C
	 hFPKv1tX6l1fyxooUt72qsgFX4ny+lXUBiQcK1exeqvjtLeenDLNdMNkVj6hP4Ggsq
	 B5mtsHJKzARmWnE1PWIl2soqTE1btxukiSy6MVTrFag+CVnUf/rtNqOXRGcaA7uWUJ
	 X184jTVamDxHg==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AEE9F17E10C2;
	Tue,  8 Oct 2024 10:55:29 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Enric Balletbo i Serra <eballetbo@kernel.org>, Ben Ho <Ben.Ho@mediatek.com>, 
 Hsin-Yi Wang <hsinyi@chromium.org>, Nicolas Boichat <drinkcat@chromium.org>, 
 Hsin-Te Yuan <yuanhsinte@chromium.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
In-Reply-To: <20240909-eeprom-v1-0-1ed2bc5064f4@chromium.org>
References: <20240909-eeprom-v1-0-1ed2bc5064f4@chromium.org>
Subject: Re: [PATCH 0/2] Fix the address of eeprom of mt8183-kukui
Message-Id: <172837772966.33303.10861074513601839928.b4-ty@collabora.com>
Date: Tue, 08 Oct 2024 10:55:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Mon, 09 Sep 2024 08:33:45 +0000, Hsin-Te Yuan wrote:
> The address of eeprom should be 50. The fixed commit in krane one is
> older than the rest, so split it for backporting.
> 
> 

Applied to v6.12-next/dts64, thanks!

[1/2] arm64: dts: mt8183: krane: Fix the address of eeprom at i2c4
      https://git.kernel.org/mediatek/c/d7f3e27b
[2/2] arm64: dts: mt8183: kukui: Fix the address of eeprom at i2c4
      https://git.kernel.org/mediatek/c/c2f1aa44

Cheers,
Angelo



