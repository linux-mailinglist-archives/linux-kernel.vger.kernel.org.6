Return-Path: <linux-kernel+bounces-409171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBE09C88C8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BBE4B328D6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 11:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBC21F8EF8;
	Thu, 14 Nov 2024 11:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=merzmedtech.de header.i=@merzmedtech.de header.b="fwTtQKKH";
	dkim=pass (1024-bit key) header.d=merzmedtech.de header.i=@merzmedtech.de header.b="POqT6rAn"
Received: from mailout03.agenturserver.de (mailout03.agenturserver.de [153.92.196.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD211F8918;
	Thu, 14 Nov 2024 11:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=153.92.196.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731582097; cv=none; b=s7CpE/PxsxePm8g3qPc+S+uPi6znmbVBJqK9Ww1O4DH85T3rZvabswHiwH7Lt/Vpc3n975zmNMWeZ3m0qPDS21EMlpE5jp4k0qWM59esHFnVdVPIX/Uuy8h//SNSBc3xmfUklPtNQnRAuq+5mbA975uaIpLRb2CsQsZYGWnwsc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731582097; c=relaxed/simple;
	bh=CYuO5EWoIpATZW5fAeCXp0xJaarvI7UkFUm685nGyA4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pEYt52iaRayeytR4Wc7jXf/jFlxHZOELGu/e7IXwP1YiNrMkJyqCE2moey6oHMzx8Ru/2bsiIFPbsZfA5gphwL9Xza1fviMi1Ag4u0tc2tBgmY1QvMSHN5aYCHvbql3WWI5l66Wvb2w4QHkwJ5bv7lyrRJqIgMzNfMDPYiYcbaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=merzmedtech.de; spf=pass smtp.mailfrom=merzmedtech.de; dkim=pass (2048-bit key) header.d=merzmedtech.de header.i=@merzmedtech.de header.b=fwTtQKKH; dkim=pass (1024-bit key) header.d=merzmedtech.de header.i=@merzmedtech.de header.b=POqT6rAn; arc=none smtp.client-ip=153.92.196.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=merzmedtech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=merzmedtech.de
Received: from mail03.agenturserver.de (mail03.internal [192.168.51.40])
	by mailout03.agenturserver.de (Postfix) with ESMTP id 6090549EA;
	Thu, 14 Nov 2024 12:01:33 +0100 (CET)
Received: from XXX.XXX.XXX.XXX (XXXXX.XX [XXX.XXX.XXX.XXX])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: h.v.raven@merzmedtech.de)
	by mail.agenturserver.de (Postfix) with ESMTPSA id AA71B6137B;
	Thu, 14 Nov 2024 12:01:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=merzmedtech.de;
	s=agenturserver2048; t=1731582093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yBuSNivUQCH9IvZN1MgrJsasMYONT+12Y885z+wY1h4=;
	b=fwTtQKKHecN7UMn02dIh2PVBVH95gscLheVgSDxCEdKg3WstPm6JXzvGnGRt2bSABiNDJs
	6A/NOFZe/gUpZ6zafnqGRD7SpSovSyznpflaHlJNd4nZoMtGQ3PWFq2NpdsgsHQOUwKMGg
	ilUd+pUiohdEqR/OgZxzeXSu4gOHjNRGnNBZrts2vAxEEHM29YqtE0mtL3ElXEbuC7O9hD
	Arpj0OfNzkXTdguIQaABSJbJh/9lTq1INzABaioqQf5vdqPIJ7vs8O86N8GZn9UkjtXOBh
	1zgs4PAH7vSs5bdITxqnlYxx1DHA9Ug1BKRhAt6QBlwspLFWhasrRlSYP4rLiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=merzmedtech.de;
	s=agenturserver; t=1731582093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yBuSNivUQCH9IvZN1MgrJsasMYONT+12Y885z+wY1h4=;
	b=POqT6rAnBcrgSBvPax2mjaw7KWhpqiaMmN/ZDkPMMP5gqw8R3ArIrFeD5Y/NyIxNGEIClE
	c1k295vZp7HGS5o+V7MXU6SFJx2m2S+rsrGmH0luegpLgpUmEFVisJ5lU9iyxfgKW2Tx7s
	dEG9F8hzWgexilnkPpDWpNiVYJrNiXw=
From: "Hendrik v. Raven" <h.v.raven@merzmedtech.de>
Subject: [PATCH v2 0/2] ASoc: simple-mux: Allow to specify an idle-state
Date: Thu, 14 Nov 2024 12:01:24 +0100
Message-Id: <20241114-simple-mux-idle-state-v2-0-a30cb37d2be2@merzmedtech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAITYNWcC/4WNQQ6CMBREr0L+2pq2VgOuuIdhAfyv/YkF0tYGJ
 b27lQu4mzeTmdkgkGcKcK028JQ48DwV0IcKRttPDxKMhUFLbZRSRgR2y5OEe60lKSLEPpKQNaJ
 G09BJaSjdxdOd13331hW2HOLs3/tNUj/332JSQgo5yFojXs6mGVpH/uMII432iARdzvkLmNYtJ
 r8AAAA=
X-Change-ID: 20241114-simple-mux-idle-state-08dd2d49e312
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandre Belloni <aleandre.belloni@bootlin.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, "Hendrik v. Raven" <h.v.raven@merzmedtech.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=995;
 i=h.v.raven@merzmedtech.de; h=from:subject:message-id;
 bh=CYuO5EWoIpATZW5fAeCXp0xJaarvI7UkFUm685nGyA4=;
 b=owEBzQIy/ZANAwAKAQP8mG1lSaY7AcsmYgBnNdiMvCpT4hajK2n0v+IrCmUaj85Ni80alfWgK
 0GOIl6tSJ6JApMEAAEKAH0WIQRfy2xFNGjRY609IOcD/JhtZUmmOwUCZzXYjF8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0NUZDQjZDNDUzNDY
 4RDE2M0FEM0QyMEU3MDNGQzk4NkQ2NTQ5QTYzQgAKCRAD/JhtZUmmO8n9D/4uvrUC1ui+bQmsq9
 WSHmuZBBKsN+sszr/YTE683XpDqBkmhORZmj0CkOPnVX3TOm9bG5NEASULCgFb42Px0/TbnYR0P
 OYblys6Njnnti7DokX+LRfJ8FSAhmYtwa/xB3m51E8gqLQzvpaaoXubGMVIAA0FwuU5I2ItQM3i
 VavXDHJ6eeGBBfulQYXxirjxJKHxQAUVXAf4SEwDw17LDf+gkXNY0AaHiXpfaBeJVcta++uKlip
 yOwiJKQzxRWJYoiZVDOzVF3pdlP3zEEkYry9apvaFKNMmAkiAebJd8gIrFVQAKJQLptZ78VdKaV
 XTM8Dul8hbnYHSCVd/z05M5WKbq8sRtfW+xewJKKtTGtfg25up/YDMtKP8qO1/qKWqFNRyNd2EP
 i8xkqPsJarpelKRU+F9K7aRsiIb0VVYMTpjT6vWlMIYylSRls9YIgNcknId8OIHAAZBPNZklf2w
 qtzODQ1YdSh68OmnVsWrvgtCcfK1mv/gAol+dwNfG+GHIQoGDmoiDkrcJSuEZEwSOzhSuO4UbPu
 0bSAs1Pv26qg3scl834Ve72wz6u3KHXMYJ4Op7C0j/iVX/Hp8bRtx3PSVYFXknqCh5ypsMtmmIZ
 Fd+WG39uUbHk6uSSD8RkAqWh8JRVf6M9Xxsrhav6JgMj7o8Dd6vHu6Pf4J54+SfZTDhw==
X-Developer-Key: i=h.v.raven@merzmedtech.de; a=openpgp;
 fpr=7A67B9A9F57B4F324AB6B8EB045B81F5FB5BA3AE
X-purgate-original-type: suspect.url-count
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 997
X-purgate-ID: 155922::1731582093-1D5D8432-FAF5A0C2/2/61233497599

This series adds support for the idle-state property from the mux
framework to the simple-mux audio variant. It allows to specify the state
of the mux when it is not in use.

Signed-off-by: Hendrik v. Raven <h.v.raven@merzmedtech.de>
---
Changes in v2:
- Fix nullpointer dereference in simple_mux_event by accessing component
  from w->dapm instead of kcontrol.
- Link to v1: https://lore.kernel.org/r/20241114-simple-mux-idle-state-v1-0-0b082dd6549b@merzmedtech.de

---
Hendrik v. Raven (2):
      ASoc: simple-mux: add idle-state support
      ASoC: dt-bindings: simple-mux: add idle-state property

 .../bindings/sound/simple-audio-mux.yaml           |  5 +++
 sound/soc/codecs/simple-mux.c                      | 39 +++++++++++++++++++++-
 2 files changed, 43 insertions(+), 1 deletion(-)
---
base-commit: 2d5404caa8c7bb5c4e0435f94b28834ae5456623
change-id: 20241114-simple-mux-idle-state-08dd2d49e312

Best regards,
-- 
Hendrik v. Raven <h.v.raven@merzmedtech.de>


