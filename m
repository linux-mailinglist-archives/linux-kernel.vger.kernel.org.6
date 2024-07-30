Return-Path: <linux-kernel+bounces-267142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7066940D44
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A24F41F2442A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048C2194C6D;
	Tue, 30 Jul 2024 09:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ap9kGuPr"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AC418EFD5;
	Tue, 30 Jul 2024 09:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722331280; cv=none; b=rojHbbW3pchppJyam/j1egC22Jun0Re+jWBKEk6qKB7IB5KAjmuxUixRv3OecOn5pT5vrsbFwxzFBmuedtOGE6A9Ys1JPz5F4P/1I8dATLpr3uoprE/8Pc+vonEeLYSasKASx+YlLWH0Kwa79z5EDkfMXU+jYRPvSA5cA6KEbsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722331280; c=relaxed/simple;
	bh=FA/UiuJmaG/0m1HKe1f4r8URUvynzRUD987l4lNhaGI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=m7Y1IPZxq0J4tYRJT8c3UPsWqw1ebkdu0T4y50Q4iDhpjkahcDunJJgDcifan4KUL/Xelhdcm940NqLb6g0Wye++J1SAbBlpMefJ+9w5egV7+ic1S3wrgnPBq+2ZWB9Djyj6KSq4dDEYPPRq3SYGUJ1vmqWue0FygSDrRts76gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ap9kGuPr; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722331277;
	bh=FA/UiuJmaG/0m1HKe1f4r8URUvynzRUD987l4lNhaGI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ap9kGuPraYlNzIGlcqUovaMUjtN8M5j8QrbITHjdVKvG4VsXgVP9xeruhmyuflNkx
	 Tq8dNkCqWWeI/eVCVAAcP7Eue5e6xQiIC5gDb18a6hFiEDSU/c8tAYdZjFQuKLe6Rw
	 M0BtUXGQB2VSI6CI7TIbrhI624bTA3bY4Pat5q/GYq347IYesG9Uqxcer9k2zP7tMk
	 P6bFjGW9uumighprO8neBoVe6BWT9KK4V50TFaGWyVjQf12r+KS1y6n0bOLh9VlTJv
	 yOif8LPZsqxPTs0n2/MdhXLJsQm5DVuGAm9sWpYFViBw8RK8YG8vXZHBsydQKTLr4W
	 Ip+NT1wszSV4A==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 573D83782190;
	Tue, 30 Jul 2024 09:21:16 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Tzung-Bi Shih <tzungbi@kernel.org>, kernel@collabora.com, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Chen-Yu Tsai <wenst@chromium.org>
In-Reply-To: <20240722-cros-backlight-dt-probe-v2-1-d77cdf7018ec@collabora.com>
References: <20240722-cros-backlight-dt-probe-v2-1-d77cdf7018ec@collabora.com>
Subject: Re: [PATCH v2] arm64: dts: mediatek: mt8195-cherry: Remove
 keyboard-backlight node
Message-Id: <172233127627.66997.14875341590066505765.b4-ty@collabora.com>
Date: Tue, 30 Jul 2024 11:21:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Mon, 22 Jul 2024 11:34:25 -0400, Nícolas F. R. A. Prado wrote:
> Commit 970c3a6b7aa3 ("mfd: cros_ec: Register keyboard backlight
> subdevice") introduced support for detecting keyboard backlight
> fuctionality through communication with the ChromeOS EC. This means that
> the DT node is no longer used. Remove the unneeded node.
> 
> 

Applied to v6.11-next/dts64, thanks!

[1/1] arm64: dts: mediatek: mt8195-cherry: Remove keyboard-backlight node
      commit: 4c03a44e266887190bdaacc7010970ae2b26b852

Cheers,
Angelo



