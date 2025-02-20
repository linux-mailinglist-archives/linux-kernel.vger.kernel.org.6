Return-Path: <linux-kernel+bounces-523337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E1AA3D552
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2E683ADDE6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C6C1F0E21;
	Thu, 20 Feb 2025 09:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5mdIuFT"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6011DF72C;
	Thu, 20 Feb 2025 09:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044724; cv=none; b=jMgxt8AzTS54DFpYR/rJ8Jj43UN7fuxAydDay6MT1JS4Vhv2eTVrVhpGKUw1dPv2Dle5lj9DH4865GzXR88d/nG+6SjOUc+7r7GjFjo2nvpkrOuTKiKYZWRUwIPoPZm/xtSsnuZ0JdUNRuhBKEDBQWHtVrYAoJb54ZgvzbTDJ7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044724; c=relaxed/simple;
	bh=GY5IJTB9crrJYV++He/3k+zUYduWqIF2gn7rvzQcJUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ugmi4sDvyMFflZ4U3CpMrAiiiqdwQFHGTJaA49f28w0NOremEr3o04zNUqdBseF+hJ8suOVzZt2CmOGD65iDXN/QNzTmkNn9w+ZIe9l4ootgBiGKkam2pTej9EGguMA9QmvBK/J/lgPeHAgBkyhM+OGuA7GKeCEdqjpECcpOQRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5mdIuFT; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3092643f4aaso6483181fa.1;
        Thu, 20 Feb 2025 01:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740044720; x=1740649520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNAQqcnp/w2mCH0GloiTmsWauZH3DbpHe2YtXW/kSl0=;
        b=J5mdIuFTAn/o2XSLaanD0rhsFRE72HkXSxve1yKCbdxZKhiYeN7L0tFaHEbU0NuSMk
         ji8QenrEnTy4lD43rBZh67LGBkdTQaZD1Pco/UXF87byxP2sqGeY91btU8O0zUc8/tGg
         YIYi5k+giiJs+Gas0q6m+fINLm30L88Xjc2lK3W7uC9R5LrF7NlRhqaUOKGC2ypOQb63
         zaxv4MBAb9t0uxLbcW93Zozr0ITKCgFjIRm98vCDt/umdMHFbEel+WzhujyvX0b8aWz7
         aCD1iOoaQkCKJUPPHdXRwFLWbEXTZD9m2D7Rs9dWolaBYagiOAU8ayjlaFwYyz/76JFT
         R8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740044720; x=1740649520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yNAQqcnp/w2mCH0GloiTmsWauZH3DbpHe2YtXW/kSl0=;
        b=At54Zw6QgkXhqxVvxxxYYsPd3UNzpUo+mSI4oQ96+qgXQr0lwGodaJNxNn5kLLFgKP
         ezMmYr0Byl4HFgAYgO5iMNzJYf8S31YWdmCX0F7d5CgYroyQYHi9EJY2clXPJlx4JGpp
         IWZfD38gyR0NM9tpH2lOyoXdn95KOoS7xnBgrVkm9fMec9d/EZz/VUfhnBtA4mK8EHSC
         DmsRSRpRgeZMZ1lZn5rpEj8X11DwSL6aZBtbNQvm9UNoFjOuew2es+dUPOGStZS0p2dC
         cygbZFde+ys/VpolLuIrieb99EIVyfDrnA3M6GejOOUPYkUKb0V6hE8/NrTms+hRuobj
         KcWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJPdjO8IcdhU5PcEv+/Sms1pFlQQgWZ/o+cSZ+C9m96GggE1fduK34r1y5nWtzpooEywnr+Mmhh63uCSz/@vger.kernel.org, AJvYcCUqAAgwmokI9eYtYwHxYo8R3cn+7TE06HH1UhkWp2ba54lRYjutFYaPhsJHjrQJWO/UIDmPgF/SfSGQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyL75LFrDFXD8Dqp+l29vJF3r1mLZqtqp5vlgFkX/LxBJYsRWOn
	x9ZEY0T8YG7PwfeI6v3kZgr5rDe82x6gE5pT/nC+9TWNeJ0bFG74
X-Gm-Gg: ASbGnctd6zEYY/HE9Rk7DJGDNCmWW33WCzXYw9IlA9Y8oIYnnzAGsTZ/qFgq2CI39gb
	/A3drA5Ns6PuAkP12KKUu74llk7AjJdKbJX5WQbkXdrrneNr/PSP1EUQ5pwAv3AHT4Rf0oKi0lm
	HnPB0mXv3N4TkqcAwbVKCeXc7ElfFntjqp62xnO6t6FYG/ymf4QEYaE9Ng8B4N9RJ8uDA953snc
	+I+eX67JHbyM7WUyAXfIMGlnZZf97gx80Pc/1hRR+g7Zv1FlqAVTaqzyV0jA4rFtEyAgMR9eZrr
	wfVWxkU=
X-Google-Smtp-Source: AGHT+IHECrLIXVnP3hpGfpiTiYkWp6mBX4nHSegnCwkEK5eQPvF8vUGu37lWYyY6yKC5NSUCa1OmzA==
X-Received: by 2002:a05:651c:cc:b0:309:28c9:54c3 with SMTP id 38308e7fff4ca-30a5063fcacmr8363341fa.12.1740044719959;
        Thu, 20 Feb 2025 01:45:19 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a3a0d1c2bsm9574311fa.11.2025.02.20.01.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 01:45:19 -0800 (PST)
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
Subject: [PATCH v1 1/3] dt-bindigs: display: extend the LVDS codec with Triple 10-BIT LVDS Transmitter
Date: Thu, 20 Feb 2025 11:44:54 +0200
Message-ID: <20250220094456.32818-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220094456.32818-1-clamor95@gmail.com>
References: <20250220094456.32818-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Heidelberg <david@ixit.cz>

LVDS transmitter used in the Microsoft Surface RT.

Signed-off-by: David Heidelberg <david@ixit.cz>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml b/Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml
index 6ceeed76e88e..24e89c1d0c76 100644
--- a/Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml
@@ -33,6 +33,7 @@ properties:
     oneOf:
       - items:
           - enum:
+              - idt,v103      # For the Triple 10-BIT LVDS Transmitter
               - ti,ds90c185   # For the TI DS90C185 FPD-Link Serializer
               - ti,ds90c187   # For the TI DS90C187 FPD-Link Serializer
               - ti,sn75lvds83 # For the TI SN75LVDS83 FlatLink transmitter
-- 
2.43.0


