Return-Path: <linux-kernel+bounces-188382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A39F8CE159
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 09:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C05D31F224CE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 07:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465D01292D8;
	Fri, 24 May 2024 07:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="ZMgnhy47"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F71636D;
	Fri, 24 May 2024 07:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716534655; cv=none; b=H11pSMmndfyadkgrKqjUTVfN9kEELqbnG7zT5t7cbDcmHsU97IA6xRqBRn4AJrJ+w+zHHPkwMgLR2RklEUafjalKg0J2CbRsHyidPQlrI8jvM7hKw9yhms/BErkdacmJib4ccGC3f/DSyKYAyn7iOwIaLzGwodc5i6dDQH2IZ3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716534655; c=relaxed/simple;
	bh=WSfq5gwwP+yapMCo97c+VZBPbsdGLckxozAp4hg7zAU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tiThyms1v80vo6TwyDccHlxg4Zkr8r++3Ln8tRn+mbsQjrpDed/CeHUzAqz4w854w87gIeAbj/lU4rbkEi/O7ZekkReatYeActE+EFQcemvBEg073qLfcpWNqY04fJWzqoLjIT98K/N8OYZjldbQPlxH/4pNH7jMLKTqOdzXwIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=ZMgnhy47; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id E2BFC1F935;
	Fri, 24 May 2024 09:10:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1716534649;
	bh=TCD9I0hI/Ajau4uCag4p3sCQJOunVpC8VMK6/kykAIQ=; h=From:To:Subject;
	b=ZMgnhy47RQab/1INWJhlAZqIQvf/OmajuHIWrahPRD9qkYU7rceyTPUY14n66Uaw6
	 Lt8eiVeTygITYRxbFcSQ/EVKQcNSY4tZo6sgSKjA3qXEAkh4QF64sqV8ixp2Py/dPt
	 ALca7vRIa2cd5pqyGqmUNhG2V9/LyVfgiwjEX6CaUMm7oeGWD+Cl2gCv4SyOy1i6Aa
	 lKPaHFr+/I//bnn+R/8qIsNfqhwREBcL49YbWdInzP/WWFpjGrlXCn3KAw/wfFZ3x+
	 ECs5ZRjidbp9Dwl/Qlo8BTpsgfEuOsM5TeohF2Ejrh+wB8vsCKHKPjbJq9ujUGDKZn
	 8grCR0uFgCPWA==
From: Francesco Dolcini <francesco@dolcini.it>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Bjorn Andersson <andersson@kernel.org>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v1 0/2] usb: typec: mux: gpio-sbu: Make enable gpio optional
Date: Fri, 24 May 2024 09:10:32 +0200
Message-Id: <20240524071034.4441-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

The enable gpio is not required when the SBU mux is used only for orientation,
make it optional.

Francesco Dolcini (2):
  dt-bindings: usb: gpio-sbu-mux: Make 'enable-gpios' optional
  usb: typec: mux: gpio-sbu: Make enable gpio optional

 .../devicetree/bindings/usb/gpio-sbu-mux.yaml         |  7 ++++++-
 drivers/usb/typec/mux/gpio-sbu-mux.c                  | 11 ++++++++---
 2 files changed, 14 insertions(+), 4 deletions(-)

-- 
2.39.2


