Return-Path: <linux-kernel+bounces-518870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4278DA395A5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9FEF3AC983
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC7922D4C4;
	Tue, 18 Feb 2025 08:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCzOHtc+"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA7F22B8C1;
	Tue, 18 Feb 2025 08:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739867782; cv=none; b=chuBB5pgwCwLvMXFmOXhmQRPBpHtLdsbr2lNDZlzJs2AlSpp7xvRydC+AhP4bd5RZOLT0/gSaSmdOKdXwo3lL4aQ3j1OhRTCoYRk64WgguAeqb5tFesYZ9anxS1uLaPBVrMpMGI4VNt2rABb993nLlyukRAXbEO2wG9ot9IyfZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739867782; c=relaxed/simple;
	bh=Qd5+REmZzMNSSCpYc+Dv909nqke9xxDIoWKydv7vufk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=axsW0U/dAvFSf0bSuZ+Rzttz0XpnAWdRR9w6RtAw7r6XGHXMrlE085qj5L8sOrbh66B508gLDfmAXjzC2d1RrZdwhVsAj3fCKEW7fh8igHj5ruGqlU/znFYkGsAJLELR2qWU8PC97x9IsYJ4YdwuRM2lOLVBMeOs8MHtx9C338k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZCzOHtc+; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-219f8263ae0so92384155ad.0;
        Tue, 18 Feb 2025 00:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739867780; x=1740472580; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=liQ2eSlf/sYgGWDLjfHM7DvSlE0ifb5tq7MQhvxFJYw=;
        b=ZCzOHtc+49OzUZGzqNbobMo1VLzMvF4w9UGw+cGY89ZPBJEZY0mDynVaIE2/gqfeHR
         kSiJvd7w3ypt6CnQGRRW+xTM6XnyQTfTY/bS54IaAlBdkREpJO6yVBqjuvueM9bi4771
         UOZjEiS7NxONPWhPPN7OTFMyUfMjq37aoVaFWCQTo5T48ZXzMZG7Gx7E+FusamO4315X
         LutT9SWON3J4d277kdo6x9YnXRSKJ/QxIhPNAjUB7lxuZLmkMkbvvJEaPIqXgfTMBrLL
         wN8Yg4sxLHnkBzPw89YX+xVpdoBsSavV9FqArJle1BYzXepz727MIHXaQcCtIuCMuVwE
         3wog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739867780; x=1740472580;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=liQ2eSlf/sYgGWDLjfHM7DvSlE0ifb5tq7MQhvxFJYw=;
        b=FSidgshSmfTpn95yc5QLkntCnqn5jqQUnQxTcAx3XpxB476Prn3efwNif2V9C4s8oa
         EHW7F8Culy44cVd1bWIpVmb1U0I4SMkpTmsCTGqCZ3M0IDmmtxgV2fUvyWHiFi6Y/1S0
         8+3pkUvUCYHDxr/11KbTUGozQvSz3BrIMiPKs3Z+0pThDbDMBTPQykDpeNUOHXIyGKvN
         9zU4pNNYZxtU5rH6EsQIJ/+9RzhHP3FhdTGfMOEM2ebK7Ie8EGZYl7OkvDUumn35kObn
         S8ldqUxWWViFu321b9qM9FcFvwJOnQPZ4a/qY3gAZmubUwKq1uxh4IolDYEA9cSTZj6f
         SkyA==
X-Forwarded-Encrypted: i=1; AJvYcCUUF4hohWur1LqPUiALHN8xMlD+xVgc5wQDRBhi250/CY6eTC+SqP6KRs9bcH9uOaCkVM5WSsJQaETxaa0=@vger.kernel.org, AJvYcCVLO1skCghm52+te7jawdigpYeBcSjzynAszyzT6/whWK84iCD0YTiKLjmBKQBEYlgg4CBxLa+GkZgN@vger.kernel.org, AJvYcCW8bMLcBu4XTK3oLaUCaRSJnzQ8VRhgba72KO4pPnjahSPtsDqHFafYbHnOYCJiK+/4WFIVdbKV8MXex4o=@vger.kernel.org, AJvYcCXbeSzPYhYLRWPKZlitYR+9oWxBs8lxGz81/pLQ3Izv0eTfIwv1RDQcnDBeBi5qABOKiOAPvOZxnXCyStZ4@vger.kernel.org
X-Gm-Message-State: AOJu0YwEFihg2qCiznNuSpNJ3/9Hpd6ZMkNiFRf9feYfjnK4vlSNqcZr
	A3sCoVFki4vY8ez9/lBTaIOzTMuXxV5X+ukvGly+zK1FaxlxXVc/UUOLK8VZ
X-Gm-Gg: ASbGncvUxjNnxwCI70wqJXfQdj+NJt4C0P65US76qX+/9GNFxhbjUe425HX5IzsWqzZ
	jNPDrY9OlsNn/FJeZesm1tJ0E/N/IFM6kCzpXkKMsMGvZVDAc6fEqgTyz6sXyzWuyNjD+BDmEVi
	MFEWdIUiXwYgIxDpyX134SN1EFQ2VznBiEFSPBDHEJcLUKOKyfLd7nc0WqVbIVr9jutVepmzA1E
	5d1YWlBP3JTgOIQkuvYkVU+oLKSzYHwMav2rDUG4KcG5O+MnCblTFWKiXT01TU8ZUt69Rv2cZnR
	udxTdjV7K7SvT01Y08cZW6Bet8Pv0D3MsQ5NBHfXprFkeVCOE/Jouu4nqHrQDzYhJi/kkx/p5Fb
	osEn52+Ih/A==
X-Google-Smtp-Source: AGHT+IHWnUgRHRwrl5gE5LT/GoKS4HRMWbZ0qZHjBnMf0PPkuoDaV+YrF7kSYDZ2wpRZS0JquDIXog==
X-Received: by 2002:a05:6a20:43a0:b0:1ee:69db:b0c5 with SMTP id adf61e73a8af0-1ee8cbd7f21mr24238616637.31.1739867778477;
        Tue, 18 Feb 2025 00:36:18 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ae1ee4febb2sm787325a12.51.2025.02.18.00.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 00:36:18 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Tue, 18 Feb 2025 18:35:37 +1000
Subject: [PATCH v2 03/29] ASoC: dt-bindings: tas27xx: add compatible for
 SN012776
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-apple-codec-changes-v2-3-932760fd7e07@gmail.com>
References: <20250218-apple-codec-changes-v2-0-932760fd7e07@gmail.com>
In-Reply-To: <20250218-apple-codec-changes-v2-0-932760fd7e07@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Dan Murphy <dmurphy@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shi Fu <shifu0704@thundersoft.com>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 =?utf-8?q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>, 
 Hector Martin <marcan@marcan.st>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-hwmon@vger.kernel.org, 
 Neal Gompa <neal@gompa.dev>, James Calligeros <jcalligeros99@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=952;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=Qd5+REmZzMNSSCpYc+Dv909nqke9xxDIoWKydv7vufk=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOlb3OLTlmQZXTnQ5vDw7N32gzNZs15FC77svfFonXKxW
 uX2VHmFjlIWBjEuBlkxRZYNTUIes43YbvaLVO6FmcPKBDKEgYtTACYSz8LwP0lmZXu137Fz4afn
 bbdsnHTVIHPRZrVvTmuO5dk0fN6oaMLI8PVF7ML5964WTPx9dddr8aZNFnw74++tavXMurhr2vL
 iYGYA
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

The TI SN012776 is a variant of TAS2764 found in Apple Silicon Macs.
It continues Apple's long-standing policy of getting vendors to
spin out subtly incompatible and Apple-exclusive variants of their
publicly available parts.

Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 .../bindings/sound/ti,tas27xx.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/ti,tas27xx.yaml b/Documentation/devicetree/bindings/sound/ti,tas27xx.yaml
index 5447482179c14ee78885e5bee02f4549428694a6..fcaae848e78a1137e4d44f98258207bba68772b9 100644
--- a/Documentation/devicetree/bindings/sound/ti,tas27xx.yaml
+++ b/Documentation/devicetree/bindings/sound/ti,tas27xx.yaml
@@ -24,6 +24,7 @@ properties:
     enum:
       - ti,tas2764
       - ti,tas2780
+      - ti,sn012776 # Apple variant of TAS2764
 
   reg:
     maxItems: 1

-- 
2.48.1


