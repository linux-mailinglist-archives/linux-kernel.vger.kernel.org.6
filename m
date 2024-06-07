Return-Path: <linux-kernel+bounces-205553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8288FFD61
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 09:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3A1AB23652
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 07:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88E2157497;
	Fri,  7 Jun 2024 07:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="B2JjAFj9"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCF3156985;
	Fri,  7 Jun 2024 07:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717746146; cv=none; b=u8Etf6pojYiAWUxmnmi0mqh72+/lhCc+oyVYpi3zRHxe0LmJ/H4YdCI+BioKIl09nZiI+NjiP2Xciapuem6M04ERuuz4mUkaTSDoW0npFcfopk9D/SbL2pMNvtIpXTM/bxNlpw+kqgkPBrl6zLAPDikraI8jOjxonKuwdFfcAOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717746146; c=relaxed/simple;
	bh=1khzek1mpOyskhV/WZJAoR8W6Qt/xyLFvHy3BHVUR0U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=U2rYteKKrHr/4zwYprpHThwVG6v/LQL0JxQZYTxl/qEnX7Vp8TAme5j14KQNPvtWBSr0NO6uLngdR9KRwYUjjgdl/Ro6T5OZ3oQt/fZkpUUJ/Upi2IaQLHsaHH+XNMF6iq3IkFx25adp2TD/4nQ4r/EHv0fQ5viuSAyiyuW6Ouc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=B2JjAFj9; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8717260004;
	Fri,  7 Jun 2024 07:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717746135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7KUdMPyYR+5v/qbEBCxK1PceiwD8jwTiahptQXtojpk=;
	b=B2JjAFj9CoeN0CWOb2n9PHWt6MmdcWkgMWEfv8w/G+ipd/tOm0sSvctSuRV3HYBV1Hhm6q
	+Pt0mecagM4T7L+J450fXAQ2IH0iosTdL+kscRHlu+gGeY8SHLwobF4/w+9eNVwinjcnTd
	zp5hV9xlv0kboXXbBmePOJLcMyz++Jpuk96vK9NLKcIrcR37GzkIZL+n5tyEpp42RgBzgp
	IAifIVNQwMoV9fXxZzV3i6eyzJdsSdbFdrK8d2zZI7HkLS/N8MePAXqYK+ylV0mcQLPvrw
	1kE/zkniWPuTH3Vgc1Ox/mZIQRQnIBqLjgHg1w0GYr56hTv+4mDUTunNHIu/fA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 07 Jun 2024 09:41:51 +0200
Subject: [PATCH 1/3] ASoC: dapm-graph: remove the "ROOT" cluster
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-dapm-graph-v1-1-bb302970d055@bootlin.com>
References: <20240607-dapm-graph-v1-0-bb302970d055@bootlin.com>
In-Reply-To: <20240607-dapm-graph-v1-0-bb302970d055@bootlin.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: luca.ceresoli@bootlin.com

Widgets not belonging to any component are currently represented inside a
cluster labeled "ROOT". This is not a correct representation of the actual
structure, as these widgets are not necessarily related to each other as
the ones inside actual components are.

Improve the graphical representation by not adding a cluster around these
widgets. Now a dot cluster represents a card component faithfully. This
will be particularly important with the upcoming improvements which will
visualize the component bias_level.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 tools/sound/dapm-graph | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/tools/sound/dapm-graph b/tools/sound/dapm-graph
index 57d78f6df041..205783d124d3 100755
--- a/tools/sound/dapm-graph
+++ b/tools/sound/dapm-graph
@@ -150,29 +150,32 @@ process_dapm_widget()
 #
 # $1 = temporary work dir
 # $2 = component directory
-# $3 = forced component name (extracted for path if empty)
+# $3 = "ROOT" for the root card directory, empty otherwise
 process_dapm_component()
 {
     local tmp_dir="${1}"
     local c_dir="${2}"
     local c_name="${3}"
+    local is_component=0
     local dot_file="${tmp_dir}/main.dot"
     local links_file="${tmp_dir}/links.dot"
 
     if [ -z "${c_name}" ]; then
+	is_component=1
+
 	# Extract directory name into component name:
 	#   "./cs42l51.0-004a/dapm" -> "cs42l51.0-004a"
 	c_name="$(basename $(dirname "${c_dir}"))"
+
+	echo ""                           >> "${dot_file}"
+	echo "  subgraph \"${c_name}\" {" >> "${dot_file}"
+	echo "    cluster = true"         >> "${dot_file}"
+	echo "    label = \"${c_name}\""  >> "${dot_file}"
+	echo "    color=dodgerblue"       >> "${dot_file}"
     fi
 
     dbg_echo " * Component: ${c_name}"
 
-    echo ""                           >> "${dot_file}"
-    echo "  subgraph \"${c_name}\" {" >> "${dot_file}"
-    echo "    cluster = true"         >> "${dot_file}"
-    echo "    label = \"${c_name}\""  >> "${dot_file}"
-    echo "    color=dodgerblue"       >> "${dot_file}"
-
     # Create empty file to ensure it will exist in all cases
     >"${links_file}"
 
@@ -181,7 +184,9 @@ process_dapm_component()
 	process_dapm_widget "${tmp_dir}" "${c_name}" "${w_file}"
     done
 
-    echo "  }" >> "${dot_file}"
+    if [ ${is_component} = 1 ]; then
+	echo "  }" >> "${dot_file}"
+    fi
 
     cat "${links_file}" >> "${dot_file}"
 }

-- 
2.34.1


