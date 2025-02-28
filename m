Return-Path: <linux-kernel+bounces-537659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B00E0A48ECF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 03:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ED51169D2B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 02:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF8216D9AF;
	Fri, 28 Feb 2025 02:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doridian.net header.i=@doridian.net header.b="KT9El2D5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QFWQF4fP"
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AF1145A18
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 02:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740710483; cv=none; b=Oq7hL+iwPqhoKRFI4k2TvMHJkzL2pJBiJE4Yc8fudNCc34jxx4GnBuQkeO4HuVA08UdDwUUWzgCly3NPEfpc+/3q5wz+6T8d+niNClUjuW/DzXNYvAZg1+i/eI1THhRsUlWfFnIT1owhUCUrDtRZp0mKDzLKbmohcxAbBz2R7Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740710483; c=relaxed/simple;
	bh=Y1IsWeuuOSviB9Q6mrcThc4GHvp0DUw+/aom6Js6MOA=;
	h=MIME-Version:Date:From:To:Message-Id:Subject:Content-Type; b=cTEC/ttwjqLKmhaAUChEX5NcXK208bYPG29Ce6+83Vh+/+szZ2uuWVB8wl+mUwTKCGXmJ8EuNnLb7Z5nhXwwkbE5QR5F4ztljFA544nvM6XFjY6aX4AKOx+G9X6TGP99hy85vJkgShA1PHjbhiI1favonQeEW/QE9eYtk3oW/Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=doridian.net; spf=pass smtp.mailfrom=doridian.net; dkim=pass (2048-bit key) header.d=doridian.net header.i=@doridian.net header.b=KT9El2D5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QFWQF4fP; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=doridian.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doridian.net
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1378211403EF
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 21:41:17 -0500 (EST)
Received: from phl-imap-06 ([10.202.2.83])
  by phl-compute-09.internal (MEProxy); Thu, 27 Feb 2025 21:41:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=doridian.net; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1740710477; x=1740796877; bh=I1XXRya/wh
	Yvvb0FE5FRcM/g+sPzAqjsPyPRhMueVXE=; b=KT9El2D50+llySFE4oZSiL9/cF
	YCTQtnB++N66qCLO9+kQ4UxDbxanosb5J3eQOgi+W2JJoH+7g2qJHHB46AJQg1Oo
	4Wk7MxxKWznNV3BZ6+Y3S7awd0pIggvKDDFy6suK8+BsZu9EvihGHVE8kVCkJ1jF
	jFLtFWLPSzuP7BN+MXj007sFT+Hw11oNlPLb/tbOKPxyDoBIrfkDb2qOzXkkE9js
	iB+Yp3oqdLOf11ER6l2wQddL+5I1nx9QjWXpX+oWiJCmTGKfid1d12y7rWYhnxlI
	ImKKALvjS3UJ2AFCU194s09l6UDK2rUXELcKg0op/0TntcNRIdJhh2vFM6ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740710477; x=1740796877; bh=I1XXRya/whYvvb0FE5FRcM/g+sPzAqjsPyP
	RhMueVXE=; b=QFWQF4fP2KDHDD5X+sThog8jI9ZmiLAEyPXYof8aMkfNtpQ0zAE
	6GX8ydVZvJRGrLQVEPHQb39XCC4aby/TZuiuHoA8//+4Y4Gw7jaDdbG0OCqTbCZv
	F4Q3JoqmLW45XVm41A9focnyNj6FpI5V7LKXXcpeMnzzntfK/iDyunNCYsn+zvQu
	LV4Z/oeaDnAjKtSly17yaS4resuBblzGFu6s5EXSYyKkUHOajIJjoN//fZA+9Arz
	qnCERpZxHll6LEiLhOt0Pf1qHRShyr/kyXLamMfbau6KBU56vQWIDWSGOHVLICC4
	TMV6ingigim9zG7o4KhlCt6FtabS0clPL0A==
X-ME-Sender: <xms:TCLBZ7mAweF1i-cgHj4W1Z3yqlvPu17hfx2SmWi6XBe2LBy7oN0CXg>
    <xme:TCLBZ-0gjFno-XbsxvSWoXRxNbcuC_6xDfKLGtLvOuzeTHRhNViSxCq6ZlcFC-8l4
    S0QrLNx72xLyHccoB4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekledvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepofggff
    fhvffkufgtgfesthejredtredttdenucfhrhhomhepfdforghrkhcuffhivghtiigvrhdf
    uceoghhithesughorhhiughirghnrdhnvghtqeenucggtffrrghtthgvrhhnpeeiiefhie
    etffdvffejfedulefftedtudduheeljedtueekheetveefteejgfdvteenucffohhmrghi
    nhepfhhrrghmvgdrfihorhhknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepghhithesughorhhiughirghnrdhnvghtpdhnsggprhgtphhtthho
    pedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlh
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:TCLBZxpLG96RtzU-RRN23WUttfSL2hsmz8_upQg8bj90JsUmI8mKew>
    <xmx:TCLBZznC8yOvQYVPO_n-POqbb0jNFTIVmTWMBPXxaR-Oyez9nwJ2SA>
    <xmx:TCLBZ52sGAbkXWlOWxI0mSOkZtPHT7rhpLvUWKmB20lNkaINUBy-SQ>
    <xmx:TCLBZyspOYtrRtGeyDOg40iRcj0ilsoDHz51QdWZXF-WKAqzMYVrBQ>
    <xmx:TSLBZ697oZzotW3xBvR3UJA7ZSMtSNW3YiATJqZiyydTrYttypi9wzrx>
Feedback-ID: ie91947d0:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C9D2729C006F; Thu, 27 Feb 2025 21:41:16 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 27 Feb 2025 18:40:12 -0800
From: "Mark Dietzer" <git@doridian.net>
To: linux-kernel@vger.kernel.org
Message-Id: <1c96811e-4d54-480a-bc09-bcd2999e8e66@app.fastmail.com>
Subject: [PATCH] drm: panel-backlight-quirks: Add Framework 16 panel
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Similarly for the Framework 13 panels already handled in those quirks, the 16 can be helped by the same kind of patch.

I have run this on my own 16 for multiple months (hard coding the value to 0 before the quirks made it upstream) and it has resulted in a darker minimum brightness (as expected) and no issues.

The Framework community threads between the 13 and 16 for this improvement are the same one, so user reports in the link below will be mixed and likely more focused on the 13.

Link: https://community.frame.work/t/solved-even-lower-screen-brightness/25711/60

---
 drivers/gpu/drm/drm_panel_backlight_quirks.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_backlight_quirks.c b/drivers/gpu/drm/drm_panel_backlight_quirks.c
index c477d98ade2b..52aa2a7fa63e 100644
--- a/drivers/gpu/drm/drm_panel_backlight_quirks.c
+++ b/drivers/gpu/drm/drm_panel_backlight_quirks.c
@@ -41,6 +41,14 @@ static const struct drm_panel_min_backlight_quirk drm_panel_min_backlight_quirks
                .ident.name = "NE135A1M-NY1",
                .min_brightness = 0,
        },
+       /* 16 inch panel */
+       {
+               .dmi_match.field = DMI_BOARD_VENDOR,
+               .dmi_match.value = "Framework",
+               .ident.panel_id = drm_edid_encode_panel_id('B', 'O', 'E', 0x0cb4),
+               .ident.name = "NE160QDM-NZ6",
+               .min_brightness = 0,
+       },
 };

 static bool drm_panel_min_backlight_quirk_matches(const struct drm_panel_min_backlight_quirk *quirk,
--
2.48.1

