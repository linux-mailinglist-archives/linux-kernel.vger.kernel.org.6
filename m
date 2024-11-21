Return-Path: <linux-kernel+bounces-417582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB049D562D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 00:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D4F5B2271C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 23:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E981DE4DB;
	Thu, 21 Nov 2024 23:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGXMj+SI"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D221DE3D2;
	Thu, 21 Nov 2024 23:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732231807; cv=none; b=pcbS4IDMPw+seCeOTIUxWoeR1BOgbZF8aKIQ/fNdWB7BzlyCorNpORRuqj2aY7pY/LKbjwYrW3XdRLZvrasFV1MdDn77fmA07/8Lo+fN+18QXP4t1bJ8NAlKa0C5/rI+UIiy5Kiet+uvhT/Nlmc4ad67xjyOnGpv7MSJ6d85DQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732231807; c=relaxed/simple;
	bh=PmJ6lkn58ZxljyegMVGGcxmPXHfrDsgippaoYUGBR7k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W3jxks1fYOBegFVXOqhqPoQ7CWWeNpPd5hJRq+/MmvdAaBZ92gO6a+8Pyif9r/cC4OGgr8gpKYMT9oZP4H8FRgp4K+2b/PFzRLOvoXq9mj17p2hchHg8WECwaQ65om3HVQx2STsxo7dY6tC89JomuqiZRPKLgqiXLXUuEkgNnbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZGXMj+SI; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-71a6b13bbceso679163a34.1;
        Thu, 21 Nov 2024 15:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732231804; x=1732836604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=owV7zU087L6xjLTYOiWTs2oqbkasPds8d3oh4BtDm/Y=;
        b=ZGXMj+SIdC9qq7S5i1AoOy3vce22WBN6BrlfdBQp1Zu472Jv14CZ6c43SBkidOmxqQ
         wyeFjEK8CGtOcGIm+IdpRmI56kVymw/BDcJzM6WPzle4JXLiUorSdKzDr9910PcWG8VF
         T/R5BBU8pQmKQvSzcsJwscS1woOhxnV1qwNLGDhYps94PjT7NnjMQxKaH5X9YF6fpmmP
         0B+at3skNdNtyzkS0TH91aKpof4kzBjpJc4H92BpCPNF9geShP6sN5I9vcpcK/9bztzi
         4r+V86imeEbfA7e6LWehx8QX4lNu4inPaAVF6lR4q7BVkK918zN1ZOtfsIZxRYBr4364
         JllA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732231804; x=1732836604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=owV7zU087L6xjLTYOiWTs2oqbkasPds8d3oh4BtDm/Y=;
        b=t1QYNoMr4V21tnWwbxc/Wi/1ut2TtOsGHwLCylp1P4bEGdo4qxYfnBmWqJW7nJ9B2w
         Wbmn0Ho6if6eRPCn7M8BWiUBiwpU/9bXMxJPlW8Ajqg5/l47T2jSSIchlE7Hyg4AIKK3
         sgjmtaUhsG9jaWmIF6tzEiefW6TuwkloW9JenW1Okj4oIWATtbau2HeupoDBrx3+ovhX
         1aAzLsDeodVQTX2IeOIucLaP6QdMimBVNGSVJWkEO6IThkg0Iz/MpTfjfPKShJEY4D2N
         RfGmw49Pub08t9ffU4ydfozDTjjUGLaKzVdM6l78UjqHYjkyITmTSXXeqB5CmCHvUHCY
         KL3A==
X-Forwarded-Encrypted: i=1; AJvYcCW73gilPIbEzh9aUeocod75pp2zkvmM427Y4R7wps3xL+CIY6dNYV3OFmpEIwXtek5WZ6DhOIEcp1GbEGw=@vger.kernel.org, AJvYcCWAXdqfa5no7VGNRtZyJGvFqzR90AsUTRSP24/6TogvzdehTFXaS8MZ0LxQGlIsXyKiieNpcdKsSWk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4vNPt+U5fHDV5CIlf59o5f7D07Dh/Kq5y5dsIs/lOnvpmEQ3M
	3cKDJsyLbOFAuFBiM7yMn7ejuwRUsGAwzXTqXRdLifOUDCdJJ9cP
X-Gm-Gg: ASbGnculsPduiDl7yw8UnF1Zg0tzxpiughYgSnO06whCxJyzN+DuRM3npfQw3s9mpSL
	oj8MslE7tFptWjHMLQzyHsFPUg2A6VlX51JYje6LaUSyRWeyNafAwXVe/GYMcNXIvTQvJMMw0IL
	v5aYj90bFcIHL5ADg6E7dnwMI5Pxsd1fMks3sn12m/hJR/Cm0l/SvHTVgjc2K/i/8Hh7kIt9ORU
	gMrzEsuJZJbnhmW9Z8/ggniSbwMNi/LRVO7KigcGeFB6m68QJjSOQ1LcvxeIeHxr+87yoS3fTe7
	H08MCqceHKHLlY0=
X-Google-Smtp-Source: AGHT+IEnnsRZ0NHjbTx3fdggf1Enpi2OR06QodDPxiOAf44oUcTuRYP905po760JgbDKEKa1p+KlTQ==
X-Received: by 2002:a9d:7306:0:b0:718:615:462d with SMTP id 46e09a7af769-71c04b9a0e6mr585586a34.13.1732231804217;
        Thu, 21 Nov 2024 15:30:04 -0800 (PST)
Received: from anishs-Air.attlocal.net ([2600:1700:3bdc:8c10:8925:1c80:f24e:ec0c])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71c03793533sm174284a34.37.2024.11.21.15.30.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 21 Nov 2024 15:30:03 -0800 (PST)
From: anish kumar <yesanishhere@gmail.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	corbet@lwn.net
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-sound@vger.kernel.org,
	anish kumar <yesanishhere@gmail.com>
Subject: [PATCH] ASoC: doc: dapm: Add location information for dapm-graph tool
Date: Thu, 21 Nov 2024 15:29:58 -0800
Message-Id: <20241121232958.46179-1-yesanishhere@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To help developers debug DAPM issues and visualize widget connectivity,
the dapm-graph tool provides a graphical representation of how widgets
and routes are connected. This commit adds the location information for
the tool to the documentation, making it easier for users to find and
use it for troubleshooting DAPM-related problems.

Signed-off-by: anish kumar <yesanishhere@gmail.com>
---
This patch was generated as a result of recent problem I was
debugging with dapm widgets, where I was looking for a way
to visualize as was shown in the documentation, I had to
do a lot of google searches to figure out this tool. So,
just adding the information here so that future developers
doesn't need to look around.

 Documentation/sound/soc/dapm.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/sound/soc/dapm.rst b/Documentation/sound/soc/dapm.rst
index 14c4dc026e6b..73a42d5a9f30 100644
--- a/Documentation/sound/soc/dapm.rst
+++ b/Documentation/sound/soc/dapm.rst
@@ -35,6 +35,9 @@ The graph for the STM32MP1-DK1 sound card is shown in picture:
     :alt:   Example DAPM graph
     :align: center
 
+You can also generate compatible graph for your sound card using
+`tools/sound/dapm-graph` utility.
+
 DAPM power domains
 ==================
 
-- 
2.39.5 (Apple Git-154)


