Return-Path: <linux-kernel+bounces-198793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6278D7D7A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 10:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 062C228372E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 08:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DFD7E777;
	Mon,  3 Jun 2024 08:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="GUR0vCsj"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE71D5C5F3;
	Mon,  3 Jun 2024 08:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717403785; cv=none; b=qWc6ALA1A/wP2OiIeh1BtqdR+FODDtPvhXxh6L65YxESLpMvAm7gdWjHTmo6x22BEGa3q9VfREb9DX37rQmZAtK6NSPPI0r9RIHkGyloEn0b8B0tBwn1ML8sTfzw66PPNCmerJXmDXviMWrg+k7ryfQYUsate4/iAFzAb6OBtuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717403785; c=relaxed/simple;
	bh=SQeZ2mhhnMXg0yuYiYntPLO4Obs/C8RAJ9ZwZZPgy2I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VDoXA09y151L75AzRHBYDDq5xHRSrkkEjPULOuVTrUu0UwQaMTLFD1b65+qHCHDAj1SE2Iklz7Xy8RhxsjRUvu3Qq6ox77u1y934qpNj4vre+yr6TQjXgL3bnVK6LytcSppn72j4zheCh1js0Twbfbx0NcthPbR+Ng86hw15Fz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=GUR0vCsj; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id B7E101F9D6;
	Mon,  3 Jun 2024 10:36:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1717403772;
	bh=cjz3djNCgfBo1s0IP9wfX7FfPO4C8SEEcU1rb0z53ds=; h=From:To:Subject;
	b=GUR0vCsjDZFhtCdnXjgdMEzVTJNPBFb0nLDwWdEcMZtDgojbOLv0qtPoTJUadwZfq
	 fMFRCuWNVGqQbbwibRlHvZVXDCpX6lxGDnAt9jKQI9oacyn5INoG4ztblO+8OArYr0
	 UeuCcQk/d6VSSNZY6ky3P0uNqF/lSy40835+syWXyLydFqZO8+XpVNitXCHPlceAZ7
	 75f+EGMiMiQ388mvOrb86OHmpfriFWc167sLPZx1QNioOSUS9n7fOnlXdn/Wg7kIOz
	 IgvN+4EitpeJu9bz8vlybwAgB7lpW5Tek0SidvE65EWzKxeY+RMpbqDGboxIjma3If
	 GEhB8eoGmbD7w==
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
Subject: [PATCH v2 0/2] usb: typec: mux: gpio-sbu: Make enable gpio optional
Date: Mon,  3 Jun 2024 10:35:56 +0200
Message-Id: <20240603083558.9629-1-francesco@dolcini.it>
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

v2:
 - add Acked-by: Conor Dooley
 - remove useless NULL checks for the optional enable GPIO
v1:
 - https://lore.kernel.org/all/20240524071034.4441-1-francesco@dolcini.it/

Francesco Dolcini (2):
  dt-bindings: usb: gpio-sbu-mux: Make 'enable-gpios' optional
  usb: typec: mux: gpio-sbu: Make enable gpio optional

 Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml | 7 ++++++-
 drivers/usb/typec/mux/gpio-sbu-mux.c                    | 6 +++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.39.2


