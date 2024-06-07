Return-Path: <linux-kernel+bounces-205554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5C48FFD62
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 09:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 566691F22419
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 07:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB311581E9;
	Fri,  7 Jun 2024 07:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bGLtI+gn"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCB750285;
	Fri,  7 Jun 2024 07:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717746146; cv=none; b=iu2JJ7vQV5REAtSx/EDtLKheC//lgCUZ6PA5LAFZDJlqxfaPrDAIIuT5+hnj1Zr7GXJzZ1wpUPdxh2dthKSBD7T8AAckThSngAUoQQ9Ej2RezgXW8Pt5WieRmtp7UHW1haxRIpy/UsDsCEhAQ7kBtqoS49wrZYlIt7LcAY2z/a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717746146; c=relaxed/simple;
	bh=PhiycFAZ6DUxwrLFqux1DsdRyTs30I96gw95dsbO5ZE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=McNicgtuFv9T95amBJH0FPeIkdB3D/CJE4irZdhU1b1tdBH373eFV//e5fWQLftPjB5xGouIveSeq3E9vSiqQ3Zlp/bdpa8cBIVvu4DbtoNJknid7oKJ4F1Fe0Xh6TPUvIirIAM5lGt2FofYder4WomXpn2AyaiGsOP00wNFou8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bGLtI+gn; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 51F486000A;
	Fri,  7 Jun 2024 07:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717746136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gVscAZKiR7cHF1VmeHRXuAuQ1Thqw8JJ9KJo8HLfQHg=;
	b=bGLtI+gnU1AcvzCe7Xw8E82+QtPHHHpNxS6z/FX+nI+OjufS7pgrwTWhVPEVx/RoM8huSc
	bjGGZjPFcEvIZ3VrsKl8XwOnQauuBQBBDlogkgoBV7vUGVX/UuCAiewCT/3zosyyOQOVOU
	tUjPn8/miCoWbCUMVzIXsKXVPbzZl2sltZ7uut/Hm+mlr2duHwrcO5xHieCPoOe4yvIM+g
	41NIf94mH3y1RHufj7YdrX7NT0IueQ2gOi0JBjTXLzZ5eYVn4O9qP9nbNuLkQZcng44I9W
	dMbswMp3UN2TsdxCDyDn9cbuj9+8gPUClblF12263zZzqjDtOXrRXFFj/pDukw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 07 Jun 2024 09:41:53 +0200
Subject: [PATCH 3/3] ASoC: dapm-graph: show path name for non-static routes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-dapm-graph-v1-3-bb302970d055@bootlin.com>
References: <20240607-dapm-graph-v1-0-bb302970d055@bootlin.com>
In-Reply-To: <20240607-dapm-graph-v1-0-bb302970d055@bootlin.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.13.0
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


