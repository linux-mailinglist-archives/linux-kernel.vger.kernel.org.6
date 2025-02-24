Return-Path: <linux-kernel+bounces-528417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DC8A41781
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28BBB3A14A5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051E41C84D0;
	Mon, 24 Feb 2025 08:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HxHfLoAY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hJujK94I";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HxHfLoAY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hJujK94I"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4AF1C84B2
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 08:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740386205; cv=none; b=qNDvDjawfNMSERMYfId4C+ynTVH04Tccpy4hK0eDYZDuSYJzjaTTS/rnSIX4A0oCRppSUgkR+D8q+32Dal9Zy3gZuqoL8RHr6TCGirFYNdNaP1bXS2mJ56a90E+hMxs/168O2Fxi9QFSmTWLM47z5kmpU37tM8anN8eKSEwsuhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740386205; c=relaxed/simple;
	bh=FNpQTuzeCGo31XNVzvjzELsSzegLVr7SicLD33GUca0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gnmdkil6sn3UesCAB/kYBd+4YLtwO+vO6KMzKx9YD5LAxPyAEVm3IlNgE4zfvZ3z3Re0ipFAAAihhyVBVatYDoSWNEy3GVLoY8V0mGsf0yKk9K3FdsqtwVuSF1rAbWP7InJ47eVJggM6UwPKX7UlY2PR4wgJXppxlEmpS8hhiBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HxHfLoAY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hJujK94I; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HxHfLoAY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hJujK94I; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F0B492117A;
	Mon, 24 Feb 2025 08:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740386193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AJkbniysythA0sc6bcyFOvbaXQUvqUuptYrqmjRM03c=;
	b=HxHfLoAYslaqIO6423815klkNZWRCPfoRdxbGp8nJSn6VFMe/hwptOEmFg/kyXP5Kt0HOf
	tr39j/TyCP9YLyZD8W/DfuqWisL+n2gdGqr8USf3vQKNW9q2yiETNBGlGJqDIfdPXSuzrg
	3jiujW6B+xUNJSa5feBSWF3Y6gIFP+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740386193;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AJkbniysythA0sc6bcyFOvbaXQUvqUuptYrqmjRM03c=;
	b=hJujK94IM4Jxo/iU82vWB+SRxP6gDIx8FFVo7pvpjfDe3MHeiDjuSevjiVeo1oaSRE6d6O
	WebOi015HY+5dnAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740386193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AJkbniysythA0sc6bcyFOvbaXQUvqUuptYrqmjRM03c=;
	b=HxHfLoAYslaqIO6423815klkNZWRCPfoRdxbGp8nJSn6VFMe/hwptOEmFg/kyXP5Kt0HOf
	tr39j/TyCP9YLyZD8W/DfuqWisL+n2gdGqr8USf3vQKNW9q2yiETNBGlGJqDIfdPXSuzrg
	3jiujW6B+xUNJSa5feBSWF3Y6gIFP+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740386193;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AJkbniysythA0sc6bcyFOvbaXQUvqUuptYrqmjRM03c=;
	b=hJujK94IM4Jxo/iU82vWB+SRxP6gDIx8FFVo7pvpjfDe3MHeiDjuSevjiVeo1oaSRE6d6O
	WebOi015HY+5dnAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A7E4813332;
	Mon, 24 Feb 2025 08:36:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mJFGJo8vvGeJVAAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Mon, 24 Feb 2025 08:36:31 +0000
From: Stanimir Varbanov <svarbanov@suse.de>
To: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	kw@linux.com,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Andrea della Porta <andrea.porta@suse.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Stanimir Varbanov <svarbanov@suse.de>,
	"Ivan T. Ivanov" <iivanov@suse.de>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: [PATCH v6 2/7] dt-bindings: PCI: brcmstb: Update bindings for PCIe on BCM2712
Date: Mon, 24 Feb 2025 10:35:54 +0200
Message-ID: <20250224083559.47645-3-svarbanov@suse.de>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250224083559.47645-1-svarbanov@suse.de>
References: <20250224083559.47645-1-svarbanov@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -5.80
X-Spamd-Result: default: False [-5.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[24];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[dt];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linutronix.de,kernel.org,broadcom.com,gmail.com,google.com,linux.com,pengutronix.de,suse.com,raspberrypi.com,suse.de];
	R_RATELIMIT(0.00)[to_ip_from(RL7mwea5a3cdyragbzqhrtit3y)];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

Update PCIe controller bindings with BCM2712 support.

Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Tested-by: Ivan T. Ivanov <iivanov@suse.de>
Link: https://lore.kernel.org/r/20250120130119.671119-3-svarbanov@suse.de
[kwilczynski: commit log]
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
index 2ad1652c2584..29f0e1eb5096 100644
--- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
@@ -14,6 +14,7 @@ properties:
     items:
       - enum:
           - brcm,bcm2711-pcie # The Raspberry Pi 4
+          - brcm,bcm2712-pcie # Raspberry Pi 5
           - brcm,bcm4908-pcie
           - brcm,bcm7211-pcie # Broadcom STB version of RPi4
           - brcm,bcm7216-pcie # Broadcom 7216 Arm
@@ -101,7 +102,10 @@ properties:
 
   reset-names:
     minItems: 1
-    maxItems: 3
+    items:
+      - enum: [perst, rescal]
+      - const: bridge
+      - const: swinit
 
 required:
   - compatible
-- 
2.47.0


