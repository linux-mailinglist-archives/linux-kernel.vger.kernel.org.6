Return-Path: <linux-kernel+bounces-298412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CF695C6E8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 09:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE3BCB2204A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 07:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8740E13DDBD;
	Fri, 23 Aug 2024 07:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DJRb4xhw"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F7D1304B0;
	Fri, 23 Aug 2024 07:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724399183; cv=none; b=ohBOi1Ae5tM6vEVysl43tE/LziKS0eBP2ruIDbvFVGVnjSnJo5wQ3ju6kBY0M7RibKukH7lCaBe/NgQ/LjcHpoliDfAD+rkaeFo5q5dX07nmVmLGEebdKdMCm3e/EjgQuDB3kRkxd8n1LyWIsdjvkBHUxn5ZSDEjjOaaSmw6780=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724399183; c=relaxed/simple;
	bh=fAFSa1046tLaQ2J5k9hk59fp/d6a1Ubet9Edv7wJS/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=lAqbYLtHR8L/oDM5p0DBJO91aom4sHyS70Dd36EXShqVRPsXAcaLkBDgJJ4VjPBGbyyn6B2GUhhIObklP9uMfHyMhbCj7zlIRVEegkf/CPqX1vSa62gNGx+oAwfgGqBxwlt4RCIZj7im54uH2JVz5FlGTAzrHtOSliIrKS1cJOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DJRb4xhw; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 986E51C0003;
	Fri, 23 Aug 2024 07:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724399180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8caC1Z562fBuPuBKeXYHWprDTaCdN40rYBd8+JqzFkQ=;
	b=DJRb4xhwqGH3ZIvBOG0cPUKSe+Z9+6OYj7xmc05kycLr89/mTQO1P1tocyJa0/IoFmOt0G
	wiUqfJklM0VHj+jIiTE6KnUu36rJI2wViHDLjNTOhuhrpWmYPeE7LVwIG0NPyvW5CYtarZ
	AlJzmMoUKx/wMGL+SJGEl1iEK7KQ5+E9DfBnjz1VqZ9PcAGA+i/BB9tGq1AhhtKXLP/1we
	8QAT1410hFCMEJLSg6th5lmU/9CNSDvQyJQEpKts8BJ8SSsYx0rSMqCbWSCMiWqUQ5kpTV
	pON0PFvNqQ5KgDCcN1qVz9GC5SzpdKAkBa83HabnOXtqv4ZHvxe6Vn+BAlWfpA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 23 Aug 2024 09:46:00 +0200
Subject: [PATCH RESEND 2/3] ASoC: dapm-graph: visualize component On/Off
 bias level
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240823-dapm-graph-v1-2-989a47308c4c@bootlin.com>
References: <20240823-dapm-graph-v1-0-989a47308c4c@bootlin.com>
In-Reply-To: <20240823-dapm-graph-v1-0-989a47308c4c@bootlin.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.14.1
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


