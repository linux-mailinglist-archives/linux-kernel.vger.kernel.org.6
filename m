Return-Path: <linux-kernel+bounces-383887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFF79B2170
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 00:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8104B1C2048B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 23:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D08B189F30;
	Sun, 27 Oct 2024 23:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rocketmail.com header.i=@rocketmail.com header.b="O6ZmSXJo"
Received: from sonic304-23.consmr.mail.ir2.yahoo.com (sonic304-23.consmr.mail.ir2.yahoo.com [77.238.179.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A9343AAE
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 23:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.179.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730072551; cv=none; b=ts7fy3Gc4uGbbs/S5ezJ9U7I7yXbbQY+Mu+jTsKHqiE+6eSgpgXTHNQzNSFODZDrnilGwWBucgJTXQZMiLwjgcLn75A5tQNB7cbVCy2tDWhRUaYY+k08+uK8fyhxIunGBkzJBARL4ncNbiSpUhq4K7G0jNRiIIPg/RvMRLC0XxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730072551; c=relaxed/simple;
	bh=ao39h9L43aTnh04TUS0HD3GF/NbiVx6RRrK7p5FY1eg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZL8EbvsYbGdiY60Y41Y5g0+v06ouoYv1peHTv7fNEkSOH5nVgF12NG5ByJ1D7rgJbd0wMD5d8lcxOSs7Clu+oBtehAHfLy2nr7R9K4nrY0DmMz8ivTbjWfiJ56ddAwEeIFtqVjfI2Pi5+kKr3OqBuDibHct3vvniKqm7Fn1rjkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rocketmail.com; spf=pass smtp.mailfrom=rocketmail.com; dkim=pass (2048-bit key) header.d=rocketmail.com header.i=@rocketmail.com header.b=O6ZmSXJo; arc=none smtp.client-ip=77.238.179.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rocketmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rocketmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1730072539; bh=bEMEzlLeqTyqrTSC3aMnQ9DpUX57joNhMyQhW9NZGr8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=O6ZmSXJoJgHYINrD6zDe21/tOv60CNzjAbJ7o/crtb21xzsJGaxKbEG5bHuEoHfxTdiEIJzUwzkRIKjOuvtuB09ZlhAbyzr0fXI0jwIiFgKW3sQc3mxL7B4GEHYo2/VvDeXSPWrnrzRdD4UWwXxHbrNwFYBj6sim8MHjGxWJ7UiKP0acN2uAPGiqvsTGaeshN3CqzeQN9JquWu48p1hfZzmD0709DZEW75pDcTgvyVqO18XxhNZSoupuq32F19lDAT6POVw82jmmOosyL21ifFqrCqqMBGjVKY4DK9hRAz7Ariv/sn2JcoZ+Q3k11+zK4N59nl7XVbjPJbZJMDa0LA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1730072539; bh=FCawKbN1H++h+BJ+ngu9VmLy+b1ZLPCLRMk7HCNyxB4=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=IQIfInkCeIKgE36pBnZ0fmyluSimeXZptBBBv+GV+QXBJBJcc+QHF13CP2f16KKktsVrVk4nnq2ENEYQfUrA3MrBPfYHmaZOj0hUA/3WPSGWFjDAfpXbaHdBnV0/vB0NVTpeEOlaRQnaHpabQgTk6a0yxFAXC+4TaeSn8w7KawKfp+Ucyfz7tr1WyesqiPJPUukRsVPFhXU1Z1vNjloNz9iQhsSIk40HtjUWQB8mA6QBulbb+2AIdLSNOG91wulnE8XAy7sQTjntSabM0mj9IzbM4z9Hg0JrEe+epjGBBKTVLbcoP/ku4uPqLylk50fANU+GVTcIqFxbZNNvvJM40w==
X-YMail-OSG: hypCiWUVM1mYgL.mkDqEhYFqOasE75GnN0kkLUKdW9m8gdhJzGwRTLGdRQUwll_
 EIJzarx9nkMrK8SfK6jm5mpDrWfV3ScBPQJ5E3H_w.jXwMEkzBxSjdDWfiDREvGDT.7Bj8gsp3l1
 U9Unx6mAYsi6kVO.RS.4H72JREe9DZVbJWMeHxkpXioQKASddmGk.2upYZxuCZy8fsQ2j4bCjA.j
 _2FOQURNE.zmcPT4FMIL7juj_JQTJSYMRYEmlFfVj8tJnAd3S_sVOLbMpq6qMGP4y1Ryb5qNb9GN
 ft4D3XMy1WVprpdgn18A3rFrQ8yP5zbNmUttKAJPmghZctxDczA2HYqrPl4zlDzuiOYk8wJC3gTc
 kPSIm7mZzECYqlqlMhFxUyfYaFvcMQJYx9exFA2wmFhUd5R6yFZhll6yVupfFWc1QH3Z9QOUPt0L
 66CWl1E4YScWYRoFG.w351MLPZr2ZFuE9t1Tsef16vWEKc02kk9H5L4eNoeEj8Toj1mkeCb_UM.Y
 nmoYW8THjawTxlMbMrckolK2idgPsiAfU0M7_r4NE6C.Kj1OagiqotS_SWn.bZC4G7UFOR5k1Qr7
 iHLjH9rHDcNe7SMPC_OjqCuKY9YHyiesz8iehDrk1dkZwT5ROU_Ni5ycmL7H_IlhniBIc7pqH981
 JaNXwN5t24B2vrViEXIvfE5vSoK9Fj4lHn_YAPHNEyokTYXAk0mMFAmP37yEbh6d4hH9WM_9M8eS
 I0ip.smGb8Otu0xB7cBqWAu0iPu5NcWyWP5npSOPP6tMGd2SM6_iJRJ_tIsHi3VgqTKlc8BQ5oYX
 kLQ0bkK0UMosdodgS_gha1g5b50vOApxMydHw4P3YmhrLX7zaUkH00m44Kgyn0eflf3yUf9ziV1O
 4Q32dzpa8zkGV0Xbn8.DBfhEq5Ky95gexwxbubha1SMINQltBKIXvvfK18LtTOLEDCeX9JLLVc0A
 MP1Eu6eihs5sAGWwUpmNW0WLTg1b9eyd6YgK3uTEgwBA7hV3VxwTepV4b_8qsYGy0Iv6t2LOGEJ0
 ey_daDWJgrZD3V2uXSq1oEXhJxzAgTWYV0wxGraRBwqKl7MsJm4b6yIbl04.YvGuEgbdu65lG0ee
 W5ZneV_8cYcHnUmaOI6krlMxPEUjCzrPdvFOyIaeUJoZxGtDCWYpYOjmKK86sSozxRJ337QkdIcD
 mTLTkb5p_GZyK9CqoqFA30Hp9.gwI71qddKWBTKk2kqVHmbRooYJg1gdXHJ3qHto9RvrCbKsOaAT
 5ek8bJwl5an8.XPf7En_kC4PER0M67vmkwgpIUU0Nv0yLihqQ1hEijSpZOARkRA5Fzt4sQ7wO4EU
 GBP0ukVV6ueV2Xsx9tr1qbWovbhve2Ip6at0RRI4bYn6hYNTDNfmz5tNElqD.uDTY2_q3zoHyBQH
 Gigqf9To2zTYR2RuNPjNiXMM9DFjAv2r5pPhXkFXZt2Ql7xR6xqlWTDmzyHot_0Qc_zaopYQU5ZC
 FCsw.ANmmk.T3Bys2WJmz1WWj4uf9Kb3L1dtqHlMaU_mbXsBZMi4hyKAEnTZpRJ3jZWozSv2tLCs
 p4tBd4kfYZM2RN6ovx0mSyX8q3J54uKUEeM0PZsz5ztxua4CbU7_xye6PkJRm9czpcl4duzMRw.r
 HdPZqhCzYaetS6uN595E10gXKv.MO4x8MnZVJKW5tK_tR3RSNe4GbJykRGn8yNrl1pBJxPH3LStX
 3eShFQM0YyerO0JOiVHwqjez7einz86AajPhZwP8nXmtvfvqOAI3XIrkwdui9ZYy3VUydZpkN3WW
 gG.1MRv1zh6w4RX5nHn_2ty3t27hZOCe9BWAYuMeDHdiFDxJn6KVpxK3uB1T4nr64XXeolyIkKoo
 fcNDav_V7YWg4bwNXMc9lCSfVEVDtEOOish4zLf7RI2Cx38Of0Pwz3B2IEJrZJfSuz2IpHCNFqHE
 8YS0X1geCS80O2UdHUNqOTrGOqmqzsxnFvquPlasfIdQV81nesP9UhZ0Xo3Zy62aLKSzGmYp5.jA
 3LPLfwLGb3ok9LLSRWXMwtdGQbG2rhuKHY5hQNVzz08y2mnyw9XnaObO6DD3KyNeJ72MONdt9eJe
 LVttuh0jJWMoeCSnjd1pimNa0IINiogASK5iA008RGCWn2XEqFp75l_UFdL4NjX20th6P5Vn1IuH
 hlq6GP6oPVhHWhW18CXYBE72hc_nzz3xgBnTESK6mho6vXSlG0aGg5SPcb0fppMbwf6Nf7dUEw6g
 Rk7W6.ZdW1DG2YdtnGKrkEHp3lCZOR2DGI0Bhuj6YlyNR6LVa7qr0p_1c.v9cBA9UpxW_qtUazTZ
 _LzonG6s6e3Fr6wf54bdBKF1DHpWD153oQyB79UQiAHFUp8TNNe0-
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: c9d8d11e-8e8d-42e4-9c5b-d38efddee023
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ir2.yahoo.com with HTTP; Sun, 27 Oct 2024 23:42:19 +0000
Received: by hermes--production-ir2-c694d79d9-qzm27 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID fc681596c483b48011d8a98a0d7203e6;
          Sun, 27 Oct 2024 23:42:18 +0000 (UTC)
From: Jakob Hauser <jahau@rocketmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Jakob Hauser <jahau@rocketmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/5] dt-bindings: display: panel: Move flip properties to panel-common
Date: Mon, 28 Oct 2024 00:42:02 +0100
Message-Id: <e4edd8fc07b89006207f5f8962a816ff7f8f4601.1730070570.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1730070570.git.jahau@rocketmail.com>
References: <cover.1730070570.git.jahau@rocketmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The flip properties were used by "samsung,s6e8aa0.yaml" only so far. By
introducing "samsung,s6e88a0-ams427ap24.yaml" they become more common.

Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
Patch is based on current branch drm-misc-next.
---
 .../bindings/display/panel/panel-common.yaml           |  8 ++++++++
 .../bindings/display/panel/samsung,s6e8aa0.yaml        | 10 ++--------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-common.yaml b/Documentation/devicetree/bindings/display/panel/panel-common.yaml
index 0a57a31f4f3d..087415753d60 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-common.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-common.yaml
@@ -51,6 +51,14 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     enum: [0, 90, 180, 270]
 
+  flip-horizontal:
+    description: boolean to flip image horizontally
+    type: boolean
+
+  flip-vertical:
+    description: boolean to flip image vertically
+    type: boolean
+
   # Display Timings
   panel-timing:
     description:
diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6e8aa0.yaml b/Documentation/devicetree/bindings/display/panel/samsung,s6e8aa0.yaml
index 4601fa460680..19c8cc83db97 100644
--- a/Documentation/devicetree/bindings/display/panel/samsung,s6e8aa0.yaml
+++ b/Documentation/devicetree/bindings/display/panel/samsung,s6e8aa0.yaml
@@ -21,6 +21,8 @@ properties:
 
   reset-gpios: true
   display-timings: true
+  flip-horizontal: true
+  flip-vertical: true
 
   vdd3-supply:
     description: core voltage supply
@@ -46,14 +48,6 @@ properties:
   panel-height-mm:
     description: physical panel height [mm]
 
-  flip-horizontal:
-    description: boolean to flip image horizontally
-    type: boolean
-
-  flip-vertical:
-    description: boolean to flip image vertically
-    type: boolean
-
 required:
   - compatible
   - reg
-- 
2.39.5


