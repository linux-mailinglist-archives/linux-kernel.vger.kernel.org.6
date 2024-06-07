Return-Path: <linux-kernel+bounces-205552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FFF8FFD60
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 09:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B64EDB23FCE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 07:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EB815699D;
	Fri,  7 Jun 2024 07:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lAoM52O5"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD3C156997;
	Fri,  7 Jun 2024 07:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717746145; cv=none; b=mANqLRP/YIEPdkahKWHCKj1zQ8/w+hexYnzEe4hFHW1j+6+VTS5mw5a5Ihex9PZTln9qBj7WEXUcl2ZewRfNTqraMlfjywnWvJsnEAmaknTYULak8fpTLrxdqNaJC+S5Ys/bPFL0whbxsw6xAKIbm2alF53IeaaCwujrJentXcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717746145; c=relaxed/simple;
	bh=fAFSa1046tLaQ2J5k9hk59fp/d6a1Ubet9Edv7wJS/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=oCNOjkmM+jJlteNMJV0co/r57O/iw12KAGXeUvcmiprAL4BY8a8tEB/jl37G3pA7vE0AUiM8DXkPz51TEQEEBd2DiB58BL4SLcrvzoBrEcgKWEbeLcgXMkacbKUfhrJZV4pNQEpxiUtfm+Fw5YsS+0bhuEG6zWCGu/WsZQWLlTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lAoM52O5; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E540B60009;
	Fri,  7 Jun 2024 07:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717746136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8caC1Z562fBuPuBKeXYHWprDTaCdN40rYBd8+JqzFkQ=;
	b=lAoM52O50FVKPAywDp4p98XiACQXsgwxXMmZ2OMl+XzwepfGmd7D4TEYrZXrIXWH8+RbQ+
	MZgZ/dLfi5dEK+B5RUrIKtrYqUftTCWYabhgTm+cwV+vkXTChbjU2kX1TSXpQ3mOlyIQ55
	0x7E8XE3GWAamIs2Lyl40CFaWURVARxV2s9gjfgl7UJ7du5wrdWQ2YtGF4wMGyP7A1e/f6
	CPCUH+lAqwMGXdYWQIsJuXvfwaAJPsbm5OLEyY5fq6UPZWg2jkP22EiEk9oPluWZ4XhXRY
	hx3L20yxzyAzd/+uOKMt7lG+D39k+/MQpXlWbJSIcw6+Ox6aewiXX9tkadu6og==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 07 Jun 2024 09:41:52 +0200
Subject: [PATCH 2/3] ASoC: dapm-graph: visualize component On/Off bias
 level
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-dapm-graph-v1-2-bb302970d055@bootlin.com>
References: <20240607-dapm-graph-v1-0-bb302970d055@bootlin.com>
In-Reply-To: <20240607-dapm-graph-v1-0-bb302970d055@bootlin.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: luca.ceresoli@bootlin.com

Read the bias_level debugfs files (ignored so far) and visualize the On/Off
state of each component using different graphic attributes in the generated
graph.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 tools/sound/dapm-graph | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/tools/sound/dapm-graph b/tools/sound/dapm-graph
index 205783d124d3..4e90883912d0 100755
--- a/tools/sound/dapm-graph
+++ b/tools/sound/dapm-graph
@@ -8,6 +8,8 @@
 
 set -eu
 
+STYLE_COMPONENT_ON="color=dodgerblue;style=bold"
+STYLE_COMPONENT_OFF="color=gray40;style=filled;fillcolor=gray90"
 STYLE_NODE_ON="shape=box,style=bold,color=green4"
 STYLE_NODE_OFF="shape=box,style=filled,color=gray30,fillcolor=gray95"
 
@@ -159,6 +161,7 @@ process_dapm_component()
     local is_component=0
     local dot_file="${tmp_dir}/main.dot"
     local links_file="${tmp_dir}/links.dot"
+    local c_attribs=""
 
     if [ -z "${c_name}" ]; then
 	is_component=1
@@ -166,16 +169,28 @@ process_dapm_component()
 	# Extract directory name into component name:
 	#   "./cs42l51.0-004a/dapm" -> "cs42l51.0-004a"
 	c_name="$(basename $(dirname "${c_dir}"))"
+    fi
+
+    dbg_echo " * Component: ${c_name}"
+
+    if [ ${is_component} = 1 ]; then
+	if [ -f "${c_dir}/bias_level" ]; then
+	    c_onoff=$(sed -n -e 1p "${c_dir}/bias_level" | awk '{print $1}')
+	    dbg_echo "   - bias_level: ${c_onoff}"
+	    if [ "$c_onoff" = "On" ]; then
+		c_attribs="${STYLE_COMPONENT_ON}"
+	    elif [ "$c_onoff" = "Off" ]; then
+		c_attribs="${STYLE_COMPONENT_OFF}"
+	    fi
+	fi
 
 	echo ""                           >> "${dot_file}"
 	echo "  subgraph \"${c_name}\" {" >> "${dot_file}"
 	echo "    cluster = true"         >> "${dot_file}"
 	echo "    label = \"${c_name}\""  >> "${dot_file}"
-	echo "    color=dodgerblue"       >> "${dot_file}"
+	echo "    ${c_attribs}"           >> "${dot_file}"
     fi
 
-    dbg_echo " * Component: ${c_name}"
-
     # Create empty file to ensure it will exist in all cases
     >"${links_file}"
 

-- 
2.34.1


