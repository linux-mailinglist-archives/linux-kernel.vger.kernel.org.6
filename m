Return-Path: <linux-kernel+bounces-512677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D933A33C7E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B80116A97C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 10:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A3A2165E3;
	Thu, 13 Feb 2025 10:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="baYxDlmE"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E4F2153FC
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 10:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739441791; cv=none; b=MmYny7qTPnwIUa3w10DzPuAaUgjGdih6Pu/DgapYCO4vM4+Y2Mi97cLnsjTuq7DFK+kdpHb//VNHAaf0uAzcSf0CaqBV6WIB2k75NyEPPa8z9vzjfLN1muJQQ2WtQWzy7tXIMrr8oagblOQOGdzXQOLReX8iQySJOBsaPzA+JVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739441791; c=relaxed/simple;
	bh=xmBDEx12/MlSpiH6V4WRagCuKEu5iUiwWGczemVxZ74=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XC+QFPDCicDcbHhGu/v6NVy46cTNyn9Zbphq1fgSf93cgKL+1Ns1xT98hIuCyIHszUoGVO8q96qL5b+DMp/GaQvoRer9eBnGTZFNkYIgsVeX88OxU5NIbVmi/n3GTwEkoOAd0ss7OLWih3euKfxsAkwoaQEp8lSp6oLIdwrYGv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=baYxDlmE; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38f1e8efe84so245102f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 02:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739441787; x=1740046587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xmBDEx12/MlSpiH6V4WRagCuKEu5iUiwWGczemVxZ74=;
        b=baYxDlmEYIYvjfbu4jxW8q+NipL4xiZzYboYksA07dYyC/9+JEBKzgZ121waBA1QzK
         TTceqAW87LKEBjGo+NGh/r7H5TwGcK3hjbiQMnJdKL7Uo9smDwE8zpaZCJRHDvgsLSPx
         hUCWXEx+872+qjNfzWL42GE55KPXCCbsloGM+ZMmxG5AIOtXthF2sreQoq5aq7FoovhB
         5HBUIFPQVDaNQtgtoZAakH2ejW5TyNE+jD4zKdWPVCcUSW6aOxFgk8VGJfQATww5mQaU
         vKoNZJIYOFk4LRYA9skQPjAPwngn7lS3bpHUeJntCndndGpgHev2xXY8LigkonNYcOY2
         ayEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739441787; x=1740046587;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xmBDEx12/MlSpiH6V4WRagCuKEu5iUiwWGczemVxZ74=;
        b=MGm6UUMv5bKALajFKA/oqELklu3ablFat3WJcV3FQke772AptmyyV9FTxHbuhtyfEs
         CkEn24brVWoxwtGVKwNgeeTxGCUawP1okXQxFZD5zUWfq2/03WYOSLBAWhjnCaRlvKIy
         iius5+K74kku1QWwV/WB9r65FtRKAYHT8W0kIHKxKz5Sbe4SL/Euy2fjjwi3JR9bT7O5
         7dpZAwhluBvta7gvus0up2e+TyVpbxSgvz9klkFvZBM9EAyRoetaYRalmpAIvMbX4rHf
         8c7eR7VkrWx878NYDOv0QiqxZqCJ4DLB200GTe9q9jV7XkKaskdQHhVz72/suE+UeQKM
         JyLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVr06f6molBuaI5I/u/ad9unoQrHMnRr54i+5tq/6NbE+bKcZyID3QUIBl8QjcbqUdd87g/NmSKsSJmxvg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf0oS6GqmKzRa9G639p9+nrw8kSx4irqxaiaDwkUd1A1jFJG+O
	XCWvgu8FjRmRZH9IqCfeDJwKLTnpLowu9CezYue34zA0jUHvf4lTCp/XplTxquA=
X-Gm-Gg: ASbGnctuxBT9UZVRflkm4DPXbiorsw72FauRrUU8Yhko1zx3XZyEbev092PRZHrsaNp
	Gwr5ne/u8dGK9AHKRTp59sd2vXxsEMIgK/BRhpZNxxw2QxbIr1ppDcxZX3KbPTMYYpkzDB4ZhYY
	Y/GR7OHLpFEZbpDpJQquEBcVbGOtMmSguxOCXwppTQWmszU59Wk1sMmfZ9RGZeoDZxcVp17U9S1
	hA2R/nwed6BruKSH5XBO+qgRPEXwThjnXL/gzKJfy9hB8A3/OwsJeDaWskuzrqGiibgLZtqOxZt
	vaAojwtFxv07hg==
X-Google-Smtp-Source: AGHT+IEffmNN4Pb9+ARCo3GKUiuLAJbsEVpvuLGQpUwyPZc6Fg0ln2kIswpBpy9K/UypDXBJlkii1A==
X-Received: by 2002:a05:6000:1884:b0:38d:d8d1:a4e1 with SMTP id ffacd0b85a97d-38dea3c42dcmr5386478f8f.4.1739441787185;
        Thu, 13 Feb 2025 02:16:27 -0800 (PST)
Received: from localhost ([2a01:e0a:3c5:5fb1:b617:2c1:fc8c:2705])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f8602sm1451341f8f.94.2025.02.13.02.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 02:16:26 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: =?utf-8?Q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,  "Dave Ertman"
 <david.m.ertman@intel.com>,  "Ira Weiny" <ira.weiny@intel.com>,  "Rafael
 J. Wysocki" <rafael@kernel.org>,  "Stephen Boyd" <sboyd@kernel.org>,
  "Arnd Bergmann" <arnd@arndb.de>,  "Danilo Krummrich" <dakr@kernel.org>,
  "Conor Dooley" <conor.dooley@microchip.com>,  "Daire McNamara"
 <daire.mcnamara@microchip.com>,  "Philipp Zabel" <p.zabel@pengutronix.de>,
  "Douglas Anderson" <dianders@chromium.org>,  "Andrzej Hajda"
 <andrzej.hajda@intel.com>,  "Neil Armstrong" <neil.armstrong@linaro.org>,
  "Robert Foss" <rfoss@kernel.org>,  "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>,  "Jonas Karlman" <jonas@kwiboo.se>,
  "Jernej Skrabec" <jernej.skrabec@gmail.com>,  "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>,  "Maxime Ripard"
 <mripard@kernel.org>,  "Thomas Zimmermann" <tzimmermann@suse.de>,  "David
 Airlie" <airlied@gmail.com>,  "Simona Vetter" <simona@ffwll.ch>,  "Hans de
 Goede" <hdegoede@redhat.com>,  Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,  "Bryan O'Donoghue"
 <bryan.odonoghue@linaro.org>,  "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>,  "Gregory CLEMENT"
 <gregory.clement@bootlin.com>,  "Michael Turquette"
 <mturquette@baylibre.com>,  "Abel Vesa" <abelvesa@kernel.org>,  "Peng Fan"
 <peng.fan@nxp.com>,  "Shawn Guo" <shawnguo@kernel.org>,  "Sascha Hauer"
 <s.hauer@pengutronix.de>,  "Pengutronix Kernel Team"
 <kernel@pengutronix.de>,  "Fabio Estevam" <festevam@gmail.com>,  "Kevin
 Hilman" <khilman@baylibre.com>,  "Martin Blumenstingl"
 <martin.blumenstingl@googlemail.com>,  <linux-kernel@vger.kernel.org>,
  <linux-riscv@lists.infradead.org>,  <dri-devel@lists.freedesktop.org>,
  <platform-driver-x86@vger.kernel.org>,  <linux-mips@vger.kernel.org>,
  <linux-clk@vger.kernel.org>,  <imx@lists.linux.dev>,
  <linux-arm-kernel@lists.infradead.org>,
  <linux-amlogic@lists.infradead.org>
Subject: Re: [PATCH v3 7/7] clk: amlogic: axg-audio: use the auxiliary reset
 driver - take 2
In-Reply-To: <D7QJX632CRCV.P0ZI0WWT083Z@bootlin.com> (=?utf-8?Q?=22Th?=
 =?utf-8?Q?=C3=A9o?= Lebrun"'s message
	of "Wed, 12 Feb 2025 15:53:38 +0100")
References: <20250211-aux-device-create-helper-v3-0-7edb50524909@baylibre.com>
	<20250211-aux-device-create-helper-v3-7-7edb50524909@baylibre.com>
	<D7QJX632CRCV.P0ZI0WWT083Z@bootlin.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Thu, 13 Feb 2025 11:16:26 +0100
Message-ID: <1ja5aq175x.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed 12 Feb 2025 at 15:53, Th=C3=A9o Lebrun <theo.lebrun@bootlin.com> wro=
te:

> Hello Jerome,
>
> Why the " - take 2" in the commit first line?

Because, at the origin of the dicussion for this patchet, there was
another change doing the same thing [1]. The change was reverted do
perform some rework and now it is back. It was another series entirely
so v2, v3, etc ... did not really apply well.

Just giving a change to people using google or lore to distinguish the
two, that's all.

[1]: https://lore.kernel.org/lkml/f9fc8247-331e-4cdb-992e-bc2f196aa12c@lina=
ro.org/T/#m9ab35b541a31b25bdd812082ed70f9dac087096e

>
> Thanks,

--=20
Jerome

