Return-Path: <linux-kernel+bounces-293060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B047A957A2E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 02:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1DBB1C2382A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 00:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA00F12B73;
	Tue, 20 Aug 2024 00:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bXl4tQxm"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA2BE57D
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 00:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724112031; cv=none; b=YpibWeiAIRMYqqPOq2IciPX5xSRwJgeJWsfYu6I906NqUHDa4hMcx1B1HWHQ0CIETskNuVeZfgouSy/UtXmwvuw3eo9kbe0Y2IDjcV+XF3/4y6pStGS9QG6pwmQDBqOvF7MSk+EQKvjL3L7DQNan9Obha0NrxcPTjcDwrh/SxFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724112031; c=relaxed/simple;
	bh=7sp3VsNcS1ZBdE6slYC/382qTXdje+YxQ0pZ8fy11HI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FdLfo166xgPgBQfykljiUCVDPP7oO4+BFFL3T6fB9di1Ui81nlIguMsQHAgRpo241x6vOz4RajfmYnfZag9KIEu3x5gATGl+YGRFTt/sP+BEHQYa1/p9bV7i+pupayBPNm8OxCCsG9beMKvSlO/056TIZGUxAAA5YVVYLqNTzvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bXl4tQxm; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20230059241so13031725ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 17:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724112028; x=1724716828; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qYwQZfpXfcofXq/WqC5i1bo4dCZz/4sz9h2uTbcnNtQ=;
        b=bXl4tQxmwBHPlsbF6JMlIot96KUYoQj51CnPw/JkN8P9iQkf19p0QojemSVsyBo9NU
         95ejD202iC9LcfSKlazuOTUodOvOqEwEtLtJonSb04On+aiGyI+ZgRrz3FWDVFjqBCuq
         Q3fROPE910vHTbhYSPBI8K9aMpeBOKzmkai3knPZK7NAv+3YuhfkHzT966Z6qWcoZwtb
         0Hl/VbWLGbM3o43/QN0ii+RmzuB3R88xrz8zKH0GTGZSq3hVF1NV7jcetRLvvyN/GXiO
         AAj+YDjDzDOshqdV+SsnUn1XPr1r/jJOY9FqbrAiXFnDIh0giOoBClaAZj9CcY49Kwzo
         SvLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724112028; x=1724716828;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qYwQZfpXfcofXq/WqC5i1bo4dCZz/4sz9h2uTbcnNtQ=;
        b=J4eXQgS8Jmh3AWWL/083Y8gTHFD1PxtD3CHtoVUbXc1tJ5pg2OcmP4cozhKhALfdFv
         duiGxgTafcDucrsGZTCxcmFb5Gc5hFsCfQcPk8iQxSaSC8UhXQ+kdHe6EyinNIZCHUxm
         dZLheIrQioSZgkNUXhmuHGTDuIS/dZIctsjKbdavCzDf3ylvfZUK5ahhBY5C5+sLFpnQ
         un/7Nf/vTHlI1fZncDtV9jh4Mv3T+VdNsRToju2GmkcS307uY6dv3+sbO2gqe8IivOub
         P0jTgBdOyT+ZQAclNGosmZxsu8HExSSnuIOgjEQXfacvP+HC6B7OCp1p6TaPp7W6s1x2
         9I7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVT0W2MGTnOcIxTZsd3PHw/tFb6hitNlJAXxsaMhx2Lg5/wDvkZRWMoqIjBo3d0imTOcUdFxobWC7VvU8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSR3naRC3R7VmLzr9PaA2xB+/Rj9ujacHjTVDWUX981kGY7cFk
	U80CpVpuS0bMsE1RvDalTpx8n0WCz1OCYy+rDFxDHc0fW66VgQFDEoQoRwN37RQ=
X-Google-Smtp-Source: AGHT+IGSXvukX7kbGClstg5grsq7V6LRd/un1ZgvccObqT3cUNKRgFzs02r59XyEcSU29E7zTMcDmw==
X-Received: by 2002:a17:902:ecc1:b0:201:f83e:c25d with SMTP id d9443c01a7336-20203e4c5f5mr144447395ad.7.1724112027672;
        Mon, 19 Aug 2024 17:00:27 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f031953esm67835405ad.90.2024.08.19.17.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 17:00:27 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH v2 0/3] pmdomain: ti_sci: collect and send low-power mode
 constraints
Date: Mon, 19 Aug 2024 17:00:10 -0700
Message-Id: <20240819-lpm-v6-10-constraints-pmdomain-v2-0-461325a6008f@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIrcw2YC/4WOQQ6CMBBFr0Jm7ZAWsUFX3sO4KHQqk1jAtjYSw
 t2t6N7dvMnPf3+BQJ4pwKlYwFPiwOOQodoV0PV6uBGyyQyVqGrRiArvk8OkUArsxiFEr3mIASd
 nRpdPtPu9sQdNtq6PkEsmT5Zfm+By/bKnxzN74vcJrQ6Uu5zjeCqSKqVE30n4hHsOcfTzNi7JL
 f3bcfi3I0kUaGSjWtUYMnV3bvV859ZTmV1wXdf1Df4dlLz8AAAA
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Vibhore Vardhan <vibhore@ti.com>, 
 Dhruva Gole <d-gole@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 Sebin Francis <sebin.francis@ti.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2842; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=7sp3VsNcS1ZBdE6slYC/382qTXdje+YxQ0pZ8fy11HI=;
 b=owEBbQKS/ZANAwAKAVk3GJrT+8ZlAcsmYgBmw9ya4MkY3hwzy0pDRAwwyoRlaI8y/D4sC6+mU
 qP7Z4CqnX+JAjMEAAEKAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCZsPcmgAKCRBZNxia0/vG
 Zd5nEACbVCHMqTDYdiiOhvkYGOIZPNs/Qp3JJtUfwL5p3kprSf8ELnu4DvmU8lLdepCUZOSAF2z
 ru6G6P+QjlAr+0YR3gAY11N6DTizTdPPaayzQwVJ/Zb9tPwTqjPgj4AEmbsT3LzSixvyZ3EVfas
 VCqTzXgQM9silr37Jf++aXZgVpb8ZMb0j3F+17788G1nx8Ni39HMin/xxnnqwZzHXvG1qofthRh
 UK0feRykXuAJOZkP8HJcSpLcAfo8AAFTA7XTAulrlqBXfVlzfOP1fF4TSqEhujzlzR+9889iLQY
 HdLkipc4bJuhTqz8FN79h2BgHioz/vxawGM9iI58HW3esfpJgCCElwdF3f4hjWGaUvWcUCavwMp
 YVhox2FwRAKGeEsk46NrXd9KnP+ucDfoajJAJWTiQu8Dctt52BBdtNvgv0D07KJo88yng8LGzWb
 nNK4I+c26jAodSRlj8FxFxohLEUzXMPY0wgiYJgi0cL239V3dz0603YNxULpJ9TJ7d+bkQjdWyO
 BD1KsCailX8omO0AmqiBHF/t2+LiedvVbR1/XYO6KVF2II5C3k/7/1g4wO7dSxl3kC6mxnxVpUu
 RAgOjBjSdnU3/cVIKoGQwBAU8649lPyw40GvqWOa86KiglP+hKFGI0fiu1UBHbUt2R4248dN3uy
 p28C+hTfL1PXYEQ==
X-Developer-Key: i=khilman@baylibre.com; a=openpgp;
 fpr=7B87460E16927FA9F5BFF10C5937189AD3FBC665

The latest (10.x) version of the firmware for the PM co-processor (aka
device manager, or DM) adds support for a "managed" mode, where the DM
firmware will select the specific low power state which is entered
when Linux requests a system-wide suspend.

In this mode, the DM will always attempt the deepest low-power state
available for the SoC.

However, Linux (or OSes running on other cores) may want to constrain
the DM for certain use cases.  For example, the deepest state may have
a wakeup/resume latency that is too long for certain use cases.  Or,
some wakeup-capable devices may potentially be powered off in deep
low-power states, but if one of those devices is enabled as a wakeup
source, it should not be powered off.

These kinds of constraints are are already known in Linux by the use
of existing APIs such as per-device PM QoS and device wakeup APIs, but
now we need to communicate these constraints to the DM.

For TI SoCs with TI SCI support, all DM-managed devices will be
connected to a TI SCI PM domain.  So the goal of this series is to use
the PM domain driver for TI SCI devices to collect constraints, and
communicate them to the DM via the new TI SCI APIs.

This is all managed by TI SCI PM domain code.  No new APIs are needed
by Linux drivers.  Any device that is managed by TI SCI will be
checked for QoS constraints or wakeup capability and the constraints
will be collected and sent to the DM.

This series depends on the support for the new TI SCI APIs (v10) and
was also tested with this series to update 8250_omap serial support
for AM62x[2].

[1] https://lore.kernel.org/all/20240801195422.2296347-1-msp@baylibre.com
[2] https://lore.kernel.org/all/20240807141227.1093006-1-msp@baylibre.com/

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
Changes in v2:

- To simplify this version a bit, drop the pmdomain ->power_off()
  changes.  Constraints only sent during ->suspend() path.  The pmdomain
  path was an optimization that may be added back later.
- With the above simplification, drop the extra state variables that
  had been added to keep track of constraint status.
- Link to v1: https://lore.kernel.org/r/20240805-lpm-v6-10-constraints-pmdomain-v1-0-d186b68ded4c@baylibre.com

---
Kevin Hilman (3):
      pmdomain: ti_sci: add per-device latency constraint management
      pmdomain: ti_sci: add wakeup constraint management
      pmdomain: ti_sci: handle wake IRQs for IO daisy chain wakeups

 drivers/pmdomain/ti/ti_sci_pm_domains.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)
---
base-commit: ad7eb1b6b92ee0c959a0a6ae846ddadd7a79ea64
change-id: 20240802-lpm-v6-10-constraints-pmdomain-f33df5aef449

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>


