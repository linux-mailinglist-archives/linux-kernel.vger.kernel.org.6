Return-Path: <linux-kernel+bounces-298413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D7195C6E9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 09:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BF52282499
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 07:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0A8140E3C;
	Fri, 23 Aug 2024 07:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Meh10dmP"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C53F137932;
	Fri, 23 Aug 2024 07:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724399184; cv=none; b=VHMhxDNCDGP1Q0sX+VRiJbqU0PPYVhHY1f6Chy4oez4mChFEb/G7JrvzDkJ6HoCs160+NM3YfoyxzydWaXOMzdD2/dYnPerGmb7SMl+APg9PBx+BTvvYgIvw8sKuvlbqCVc3fKg8ch7eI6KqefxbCg9bjHCfFBSGfWEC1GfGLTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724399184; c=relaxed/simple;
	bh=PhiycFAZ6DUxwrLFqux1DsdRyTs30I96gw95dsbO5ZE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=M86by1a/W4+55zgbKs5kIWDmNZEY1Z8FpRgJWtqb6Tq5E+fyuuaowSmsS7t29ur29XA9L10YdopZBtWBj3Gd5fQSdRJoCpGwak2JImQdvMdm4Iae6OcnZjWlGng4C3BvHNBbUuWeXbG2FrtHFpuvV8MdZeWkrGlpTRs9tZEEtKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Meh10dmP; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 335C31C000A;
	Fri, 23 Aug 2024 07:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724399180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gVscAZKiR7cHF1VmeHRXuAuQ1Thqw8JJ9KJo8HLfQHg=;
	b=Meh10dmPXL587/64sNZbmFs6JiqXpgSLeR9CGzhN/o+4qMNQ56Cg1qnaQPz/7vu2C1PmJu
	YwRY6LqHWg8KMvV25I5oI9Ambfr0b40mKDGUyi0uraoXW/V+hDrLr1cqUNkRm8y/Go25Qj
	RVTwv+gZImJ3aRTtV3z8s3KYi89bj20NZfoJG6+O74zHpAusWOfRMPx6T+Ma02C91RDsRa
	zCT0YoNgrv6p2qPZQ8ZTeiXJQodfAoQydic5OQSZS36ujhe4sblp8/pGh5SXIJ76MLPWx8
	VPhtTCJ/kDDf7fOihLi2cNuWDAeCzX7vSJcZbw9fJn16Bsiy7j9PIBhapVnDAA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 23 Aug 2024 09:46:01 +0200
Subject: [PATCH RESEND 3/3] ASoC: dapm-graph: show path name for non-static
 routes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240823-dapm-graph-v1-3-989a47308c4c@bootlin.com>
References: <20240823-dapm-graph-v1-0-989a47308c4c@bootlin.com>
In-Reply-To: <20240823-dapm-graph-v1-0-989a47308c4c@bootlin.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.14.1
X-GND-Sasl: luca.ceresoli@bootlin.com

Many routes are just static, not modifiable at runtime. Show the route name
for all the other routes as an edge label in the generated graph.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 tools/sound/dapm-graph | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/sound/dapm-graph b/tools/sound/dapm-graph
index 4e90883912d0..f14bdfedee8f 100755
--- a/tools/sound/dapm-graph
+++ b/tools/sound/dapm-graph
@@ -134,11 +134,17 @@ process_dapm_widget()
 	    # Collect any links. We could use "in" links or "out" links,
 	    # let's use "in" links
 	    if echo "${line}" | grep -q '^in '; then
+		local w_route=$(echo "$line" | awk -F\" '{print $2}')
 		local w_src=$(echo "$line" |
 				  awk -F\" '{print $6 "_" $4}' |
 				  sed  's/^(null)_/ROOT_/')
 		dbg_echo "     - Input route from: ${w_src}"
-		echo "  \"${w_src}\" -> \"$w_tag\"" >> "${links_file}"
+		dbg_echo "     - Route: ${w_route}"
+		local w_edge_attrs=""
+		if [ "${w_route}" != "static" ]; then
+		    w_edge_attrs=" [label=\"${w_route}\"]"
+		fi
+		echo "  \"${w_src}\" -> \"$w_tag\"${w_edge_attrs}" >> "${links_file}"
 	    fi
 	done
 
@@ -220,7 +226,7 @@ process_dapm_tree()
     echo "digraph G {" > "${dot_file}"
     echo "  fontname=\"sans-serif\"" >> "${dot_file}"
     echo "  node [fontname=\"sans-serif\"]" >> "${dot_file}"
-
+    echo "  edge [fontname=\"sans-serif\"]" >> "${dot_file}"
 
     # Process root directory (no component)
     process_dapm_component "${tmp_dir}" "${dapm_dir}/dapm" "ROOT"

-- 
2.34.1


