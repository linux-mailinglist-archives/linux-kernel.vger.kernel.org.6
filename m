Return-Path: <linux-kernel+bounces-529805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B09B1A42B2C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 847FE7AAF92
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CEA14012;
	Mon, 24 Feb 2025 18:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="G02tW++1"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA7C265CC7;
	Mon, 24 Feb 2025 18:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740421275; cv=none; b=VptHVG+8mM9p7F1sxqCzli5P/GEeiVy/f63sFWqCMhmSydpadYDjAfBTNb3flnptyrFXtC9cA2gWVppZMMiNVtL2naKfl3RmTfoRbK7iN6FnbwooRNb4D/Tt4xRUUP3h2oBuaveYUS/Wu/rOFlXvIzF1ievbS+EDv+y5uCJZzWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740421275; c=relaxed/simple;
	bh=N/T5IHIQwCEr77i8CTQCQnWFjgaLHWXY7H4FMMhO8NE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q2LgkzVn8YICyID30vWf2tJ7va+GhYZ6Ol/952KYluKM7eLpGaM3qlyx7KvdKANJVsDDlNYzTnmHZkCZw5rHaEseIYVsh4Efb1KsGq6XUWo+k9P1FSNCD56yDJ059aTAKB1+b7CBvz2AkezlajmcuomKe80+w+nLj86fKsdM8UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=G02tW++1; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id E3DD71F925;
	Mon, 24 Feb 2025 19:08:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1740420485;
	bh=1M7f396UBAmCxe+9OoMZbOkwcwDr8nFN1FiAHgkEDKw=; h=From:To:Subject;
	b=G02tW++1t59ah+gMQCw6rNIexMpCQn4tbkpggdZBESNP314KmWnX6I7l3UfvPON8r
	 lpwJs4TlO8idH2TYvsuD2TO9WLP23rOniO/1FT+C7+NmADsZC1hu2TXe0JeNFNZ6B3
	 g2B0+I8G0DggYTAdj5KIxNLGEOvXLda+fTGIq/rnJhIfBA3wzdenzPjK82/sl007Wf
	 4Fg0gSg1hZdqveaK7+Ag8ZMXWCqFx6pIq07+9Pz3vM2o2ykFACU876TZM5CxUKu7Sx
	 Q8MycmK8MjAtfanOWyh9D2yeQy8ItI1b5ARx8lUZmNO+/yQIjfYuRiyKF7Xdjb6Jx2
	 Jly1t9urHxBjg==
From: Francesco Dolcini <francesco@dolcini.it>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Farouk Bouabid <farouk.bouabid@cherry.de>,
	Quentin Schulz <quentin.schulz@cherry.de>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] hwmon: (amc6821) Add PWM polarity configuration with OF
Date: Mon, 24 Feb 2025 19:07:59 +0100
Message-Id: <20250224180801.128685-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Add support for configuring the PWM polarity of the amc6821 fan controller.

Francesco Dolcini (2):
  dt-bindings: hwmon: amc6821: add PWM polarity
  hwmon: (amc6821) Add PWM polarity configuration with OF

 .../devicetree/bindings/hwmon/ti,amc6821.yaml     |  8 ++++++++
 drivers/hwmon/amc6821.c                           | 15 ++++++++++-----
 2 files changed, 18 insertions(+), 5 deletions(-)

-- 
2.39.5


