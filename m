Return-Path: <linux-kernel+bounces-272145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 524539457C3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 07:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F125D1F21FF2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 05:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F233EA98;
	Fri,  2 Aug 2024 05:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="Q2vAS+iv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WAzQ7YxQ"
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F5822EE4;
	Fri,  2 Aug 2024 05:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722577715; cv=none; b=WODNn9LmDDo1WXPO2yb5uwptfXeGeDR5mTdgDbWRwCyMMnidamKusIAyAI0GeqE9y8Get+uAk1uKhBJsaTVs9SJFtHoCostqh/16seUi1d5bfotDYJ24RnaqVK/nT9fM1JunToFcVjUwbDNDX9UdZ+SxYPi6ShJ0dk+pRMrSRaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722577715; c=relaxed/simple;
	bh=JxUn+v+sLiprvU8/YZ898YME8vnnjdW7HMZhlCtPxuc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=c393cIpeMbYwbecIVMKgBhJUWsqBcDmxJh3fUhyXzyoRTJNxuivyBDMoCij5v/WZjGc5QyzSVWsrs0Ai60qvHybUnfKx7MvHrtGazfA2Bw63myRSkx9uNwHV1p+tmP9m6IM1gPKWpe35RjRn6CjqTdnd9+/DglclXDue+e1bMng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=Q2vAS+iv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WAzQ7YxQ; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 295C5138FCAA;
	Fri,  2 Aug 2024 01:48:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 02 Aug 2024 01:48:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1722577713; x=1722664113; bh=Wt
	ZfLoN7q0d2TuzchcdSawaP0pmYD+NytoaGIdcrM/A=; b=Q2vAS+ivuy6JAXUBiE
	gC2Q2F4Q1p51yp4CU5xQ0Amjr/afAXNE1gDL2x1K2e5pjDHz8hQVhvMMU4B4sG8K
	vbrKTkhtUEWxtYc2A7eoxfEUnHYQUFGjvZTOxXdFuLOqBhAkM1XAE+BK6jWI3KUM
	/twa8SzlSe4V0gp5qQgArWGXv/XMLr8cJDraoHVxF8A0aLtsawLy6m+3Oj48L2mm
	Wz3riyZuXI40k/ZRSqpX0yjlAbTCBiZbT7+j1nOIGa+SPGVQBj+l9Q0RF7UBOVW4
	FLtVss5/qIXIYoNaWOvGWJOzY1pqEedz8QiSpFJl2beC1otWA2FY6uIJy/7qOkBG
	RLtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1722577713; x=1722664113; bh=WtZfLoN7q0d2T
	uzchcdSawaP0pmYD+NytoaGIdcrM/A=; b=WAzQ7YxQ1KeSliNsS8CWUrPw5/bmG
	ej9AYJQNUQmRt3gOXHIFInpHDlVIrc5VGerLIkvmWc82aJTi82OjNWeS7gqzVpCK
	DlRuBBw3HBRQjiIs4ov/Q2iWBGvP6kX8o8QzvJzJrHv7oL6CfzWUP6QSeWFVO9C+
	iYOQKuzwHfwJPol7G5+wk1E+F6CT0dHjB2nax5hKW6PAwrlWSJqLKN1dSVEfnS9N
	6OHU7et84AWGZA0jdwnTfcA8hOMpCVe/UassNd2bKN5Eeod0z/p+VuEvq5CaDJUP
	dG2OH+VczFGz7VSDTN+w8mxkH0s7Bz5sG3xjN7MLAIVNx7J86+d0fhcFQ==
X-ME-Sender: <xms:MHOsZtYbM5Yt0Nd4TJV4VCyOzg1Z1zgrupSglWAy2OLfIDHZ9ylfSQ>
    <xme:MHOsZkY6A2SrnLLVFehjVRHal07aTdB76A6U8H6cvq1JndN554rXIlZzz0hXMC8Y1
    jDEYJBqF17ikZaDP-4>
X-ME-Received: <xmr:MHOsZv8Lo98VGjwYAuUdVv0n67-SCjr3vAoVRMKRPNvtChnsUKX_8_muhH34Me97LGo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeelgddutdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpeflihgrgihu
    nhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
    ftrfgrthhtvghrnhepffetueegkedtgfejveeuvdfghfegtddvgfehudeghfegheetuedu
    heduveejtefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomhdpnhgspghrtghpthht
    oheptd
X-ME-Proxy: <xmx:MHOsZrqhKitztroNEbtGEabZmFoT7nZBgB2JcJLHhuCrX7VAWMzb-A>
    <xmx:MHOsZoq8L05kKaXmACABaXbYIrxkgOqbbRje-S_Iqh3pzLV8wKgb1Q>
    <xmx:MHOsZhTf1Sl_LoY9zleSdgzU97U1m3wyQ7Wj1q4cuUsd3A55d9yD4A>
    <xmx:MHOsZgqFiWf9Z-BKucoZxj5BXolBv7h4cQmxXe9zbCSBp1FZSnVoLw>
    <xmx:MXOsZgLiZwWl2hLOAJqYOzurfND5hWQYRqU_x5osXQN9WPgibxr__vjx>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Aug 2024 01:48:29 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 02 Aug 2024 13:48:23 +0800
Subject: [PATCH] dt-bindings: loongarch: Add la464 la664 CPU bindings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-la464-bindings-v1-1-4ccd299697f0@flygoat.com>
X-B4-Tracking: v=1; b=H4sIACZzrGYC/x3MQQqAIBBA0avErBPUhpSuEi3UJhsIC4UIpLsnL
 d/i/wqFMlOBqauQ6ebCZ2pQfQdhdymS4LUZtNQordTicDii8JxWTrGI4OzolUE1GAUtujJt/Pz
 DeXnfDxLsBVxgAAAA
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Binbin Zhou <zhoubinbin@loongson.cn>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=854;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=JxUn+v+sLiprvU8/YZ898YME8vnnjdW7HMZhlCtPxuc=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrQ1xboshc0XXl9+q/VqUyjnuWdCnxZse/TzSkXjhr4L8
 g+fOVY+6yhlYRDjYpAVU2QJEVDq29B4ccH1B1l/YOawMoEMYeDiFICJKAkwMuy4NGO+14NuSbnC
 Hst88a01BYVO72ZVSije95kgXv/1fxQjw6pHEyq6GI6fuipp9mC5jNwDps1LHz9kmr1s1eIz0u3
 ql7kA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

Document LA464, LA664 CPU compatibles for emulation machine.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 Documentation/devicetree/bindings/loongarch/cpus.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/loongarch/cpus.yaml b/Documentation/devicetree/bindings/loongarch/cpus.yaml
index f175872995e1..462d107fbb4e 100644
--- a/Documentation/devicetree/bindings/loongarch/cpus.yaml
+++ b/Documentation/devicetree/bindings/loongarch/cpus.yaml
@@ -21,6 +21,8 @@ properties:
     enum:
       - loongson,la264
       - loongson,la364
+      - loongson,la464
+      - loongson,la664
 
   reg:
     maxItems: 1

---
base-commit: 048d8cb65cde9fe7534eb4440bcfddcf406bb49c
change-id: 20240802-la464-bindings-ca86b1741371

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>


