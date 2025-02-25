Return-Path: <linux-kernel+bounces-530741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A27A437B9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A3F13B74BA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 08:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B455261372;
	Tue, 25 Feb 2025 08:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEyCEbrK"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C96260A36;
	Tue, 25 Feb 2025 08:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740472456; cv=none; b=fIyvwf0EGTdMVd+ZtbfBGXiFHnfXfUNc5hdYKPRsut6Xjt7mN4+JpnGuPLo4eARd8ZiSyv26Ssg/zC6ZmEsfiQu+8111Xfp+yCerr+zkjLpohYQPPUk/iraQLD3DQl+uO84Uf4xoq3D1l00rJC5Bat+VeuHxUAR6ShvBSn7ViSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740472456; c=relaxed/simple;
	bh=rZikCDv8fD+Rzkk4RfVp7aDtd/aBZpILIsTNbD23F+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WR3ZVWPlqAOjnS1sWhPADXBP70mUhA0JD+oOoYgFJ90MnTJBpz5FjRXoVuzuYzclLD7a5sitfPvUMk9aJ4mBj7STAlpdJxX8x3POm6EBBOQCb9lSfvhGPHTm4c19mKAwXjmfcDaQQJ+pE4CTfFEWxS3fiIIyYa5HX2YRkZM6vBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UEyCEbrK; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-abb75200275so839992566b.3;
        Tue, 25 Feb 2025 00:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740472452; x=1741077252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q34w3RqR0dtKEGKyYXofcB2jlNCM2LrnhrF1NCKpgfo=;
        b=UEyCEbrKsfIp6CdqvKUxkkFvamnPV6RtAasTO36lrgAvK6FiLCFrhL+n87am76ds0Z
         MWNiFFz0VAxJIAD2yR9nMinrX5QFSoiogvPHfE8SZPGKgjBWktXZpIH0uXODvjgDpxT2
         9ypVadHbg3gCS3Xq+S7wIgyWIiLMlxMdp8qM1ht39faxi5AFpIFczeBz1fXEewTP/MHV
         /VMJlBed+FhZk3oU3aqbueyYzTQDaugUKlIfBNEN4fUp+I5oChZ6Hg28EQUE8BGECDZm
         fH0AiaE5fjQn+DqGALcO/LE++FtvU5ZIb+HqeylUBkbGThP1Q22lSt/GgCR8LbtogFGt
         huwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740472452; x=1741077252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q34w3RqR0dtKEGKyYXofcB2jlNCM2LrnhrF1NCKpgfo=;
        b=BKw+eoCMudMag4IVqT59ieM9T9V6pikyWXAmj3siSPOT+V0fFdaBGQP8FBMl2YJDAR
         wYqVGHsKvi1aRLj8zx1HF4Mt/hV9DoNMn7Ey70RZ8czXPov5Ixhbg1jDdkIFvHdI4wNI
         F3q2WastCh5Uu8sH0JWOSNeQ77udFIBr3rzeliaUZ9/4Mm9Pr8YBO88NwIIxxZNE4pwZ
         bqcHifsAo6PlzH7O3XAFKi1lRXgVhpkvalyc6FQzESRa4WdTtw+HIKjUImUGtXp/SERN
         grfRRjoAWKuBXqxC0aeoVwCaxZcSXTrvumvJ4iCazSfb+0nauFtXgwm/OzWzHWFOtjAQ
         igAQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1CN/n8/47UeLy6dXIbNl0dcvyhJPryKmKPa84h1Qr8Nhkul+1B+OKVeOwmZTrh4c0VoRZWUwrQ5JqDDQ6@vger.kernel.org, AJvYcCWc8y4jjWlzEaCcuTMDur11ls7UkKvpkBiQP3X/7KPou4KHc6UurbunXhr6cOOp652t50MDBhSK9g1V@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxdw6i/5OM0FyBrwgEvfZ5KeyPf/Uu06T7O3OGfNP1u9RD4Whg
	S2J5h/xPaZi0JirbmenorGhg2Rphd74flYYG2R5Io3X+o5A2VySQ
X-Gm-Gg: ASbGncuqVG6qA2EXBgrqOpK9Ix4oIkMCK+utWRHdv1dXKC4YGG1hKqmmZSFqxHosOFZ
	DGhAz1n5GhOb7VsTWGVaTb46MrH01dTt9F/rYwHaso9prqZutPnmHZe9Fp6/Sup8iKW43Bg6tew
	e8PzAsbBdAU5mMmBbkyrd043TZpu0nagLWRsp7Ak5BMO9TKjGR3jjzXo94dWegojcTSqkmRKSck
	MzgQ0c2w7+pn+3CLmT6rhf568WhChGOxuYWQhjfdy5mRL+8IIyAptDYj9VBsKev8H7c1lvipzhb
	nqeUd0Jbmosw3BoscA==
X-Google-Smtp-Source: AGHT+IGM/ptCrD2L+foIgR/sI8mwv+UTIQrXbkp7n42BdtHJzaV1GcZ5GgCB3g5Ien9AH9WgFu5RTw==
X-Received: by 2002:a17:907:9c05:b0:ab7:bf2f:422e with SMTP id a640c23a62f3a-abc09a80912mr1903767466b.27.1740472452313;
        Tue, 25 Feb 2025 00:34:12 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1cdbe0asm102660766b.36.2025.02.25.00.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 00:34:12 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Maxim Schwalm <maxim.schwalm@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindigs: display: extend the simple bridge with MStar TSUMU88ADT3-LF-1
Date: Tue, 25 Feb 2025 10:33:43 +0200
Message-ID: <20250225083344.13195-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225083344.13195-1-clamor95@gmail.com>
References: <20250225083344.13195-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A simple bridge used in ASUS Transformer AiO P1801-T.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Robert Foss <rfoss@kernel.org>
---
 .../devicetree/bindings/display/bridge/simple-bridge.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml b/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml
index 43cf4df9811a..441e5e5b27c8 100644
--- a/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml
@@ -28,6 +28,7 @@ properties:
       - enum:
           - adi,adv7123
           - dumb-vga-dac
+          - mstar,tsumu88adt3-lf-1
           - ti,opa362
           - ti,ths8134
           - ti,ths8135
-- 
2.43.0


