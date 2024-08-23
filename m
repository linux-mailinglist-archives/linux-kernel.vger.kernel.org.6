Return-Path: <linux-kernel+bounces-298411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6B695C6E7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 09:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2CA81F21DCE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 07:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784C913DDB9;
	Fri, 23 Aug 2024 07:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="X2ZzyKj8"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0EEE56E;
	Fri, 23 Aug 2024 07:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724399183; cv=none; b=pU6rEs6e2HtTmvUHGmybgWn+FR0fggY90GWnGRHhjshSpf+QDFT2O10F8ErBUEJZ/smW901ASOtKsNh9CYURnoNTaOge4Vsa6MUk/dXzWSmEhbDPSKk2ez6C4j5PMWrML/uGrJO0t77/OJ/FlLU2X+8bPpoPDR4C3gkNV4iLn2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724399183; c=relaxed/simple;
	bh=1khzek1mpOyskhV/WZJAoR8W6Qt/xyLFvHy3BHVUR0U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=LxMxe7Cp0cODkpr9CReSJBw0UsPyp6/a8TzSvQBE11emAFiU9GHo1ecGT+tu2cJ1nCVsZ15vF3PztS86gvMchC3lK/zcu+GTSkjPZaxaOl6hLBaX9ArRl1sk7ilMTyMRXSRqDXFXpif+AjR/CZ9ZLsrMdiMoGc5q2HyvoAqLMA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=X2ZzyKj8; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0C4B61C0009;
	Fri, 23 Aug 2024 07:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724399179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7KUdMPyYR+5v/qbEBCxK1PceiwD8jwTiahptQXtojpk=;
	b=X2ZzyKj8urvzrqsk6k+8Gco8lshbdru3Cfe4yOA2RoURFXfJ/9fAPEqeh2epkG+7JNLFNf
	Vy6Z6XEgKmuCCl7xJhjJZDhvasgkbqiofJhPxILOyTKvDeqzRWuXzbwy0claYJh1skvIeB
	QCeAuf8UGy6wIpqdAvc1t7oZOsfrpr2K+ih56NJbH5kuhGegf+MupS200bkCgNYUFv7B3r
	o1K2eUYwGQDsqFo8RLleqw1xcUiGLkdHNLLPzXnZUzCcB4xkcjPZ08OXK8aLf5i4ZbfShI
	D4xwR94TGnFYjZvttpLDLT/z1UAhdlFtMzGQRM5S/7yB1eGb6XQPVP2Aez6n/A==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 23 Aug 2024 09:45:59 +0200
Subject: [PATCH RESEND 1/3] ASoC: dapm-graph: remove the "ROOT" cluster
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240823-dapm-graph-v1-1-989a47308c4c@bootlin.com>
References: <20240823-dapm-graph-v1-0-989a47308c4c@bootlin.com>
In-Reply-To: <20240823-dapm-graph-v1-0-989a47308c4c@bootlin.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.14.1
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


