Return-Path: <linux-kernel+bounces-519898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E62A3A35F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A1F03A7167
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56C326F474;
	Tue, 18 Feb 2025 16:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="Si+94s//"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FF926E65E;
	Tue, 18 Feb 2025 16:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739897815; cv=none; b=IJhR6g392vx3Fe5KV+OpHgTz0dUMQ3QyZNChA6c069x0WmUk0LHANpnrOCL3ekNtJdF79H4z+SuTOWuwijqW1L9gy+P9IsG8cmZhLGfFcTMRfSVaLYAUeI3ZH06pAMZJ+xYz8xRCJPgkzCTRNl9fTVlFu9hQuS6djya6mGPPSxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739897815; c=relaxed/simple;
	bh=nUgstS9Bz0V+6EdpaA6ybhmwoju+hzVF/CQKiYqHMO4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cWo63fw/AEeD6cvtT5sGGiNm3De0TVXIAq1LTZHYXBr3BmgdpmDZOyU1r/GKbeVMaNfh5ildEY4zzcwlidLox4A1trQ/wPX3N/nhe7z9G83oPTsV+rOtVvNoREb0If2cRCaiFkmWx/fzszx29RG9MLsxMLMXvWW9d3nt9oBq6yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=Si+94s//; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.corp.toradex.com (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id EDE391FDEF;
	Tue, 18 Feb 2025 17:56:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1739897805;
	bh=2sMKnoxr8Hte0c9i+FFuxPif1DleXcXgnToZ8GFi+5k=; h=From:To:Subject;
	b=Si+94s//SuURs3JeT1w1JjBP9hs/y0A8eUGLvwsCjZv9/W6MOk7A9n0dNgson2dzI
	 eDABb/rhShkAx6fdoHLjdSgsuhBMIbQrgB/9ptMVvITeHamkRzbs1w4S545q6S8W+Y
	 FRnT+IdNSPcP3z+85U3ozHWeyTilca+zqO5O9rY1w8ARbrWi5gDfCMi4kA/ojFR1tL
	 NslCHMiEPh4SnNILdwbyjE+gmYndl5dww6Pe80t30uIzO8Hy+EPrFsyIvWbkMzLOrG
	 I8SLC1FaJl6PzGJGCfIEtV580QJsYu6aOAAD5fNE9P7flv3kkOY9W8GPq17Vm6Ybms
	 dYIrb4XziC68Q==
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
Subject: [PATCH v1 0/2] hwmon: (amc6821) Add PWM polarity configuration with OF
Date: Tue, 18 Feb 2025 17:56:31 +0100
Message-Id: <20250218165633.106867-1-francesco@dolcini.it>
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

 Documentation/devicetree/bindings/hwmon/ti,amc6821.yaml | 8 ++++++++
 drivers/hwmon/amc6821.c                                 | 7 +++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

-- 
2.39.5


