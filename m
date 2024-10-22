Return-Path: <linux-kernel+bounces-375393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6B19A9566
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 03:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FB31B21767
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 01:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF5384D29;
	Tue, 22 Oct 2024 01:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqKpjvmm"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBD0A927;
	Tue, 22 Oct 2024 01:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729560203; cv=none; b=q8JlTtNjwLfv00eY9CK4qKmaouLgiUt/9dQ7xq0v3JX9xchDD9lBja1otAlS09ZWjY2+kpGm/b1oIPfxA/mwXjuvCv6z9lPtr9kdAsBzL+3XTc+vUpnYp522ZAxgMqwpmzLhN9+7TM/sup7/iYicKCSUdlBzhpG2rvi7Y2sWtJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729560203; c=relaxed/simple;
	bh=UkJsOrwcfH9BNzQhTmrxQCQo4/Kg2M03/sGd8f6tRiA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=se4+5RT3Sbb4pK9uZsmxT3Lo+iCPYRaNmD/UAu8nnSiUA8J8hHLEcHIoDmAD68K9dO1wSNLV+GxRJgnymgqCM7w2MnQWSlYgpEp+TkVMj1JuICjhqZDZjKbMG/PkU/aC+NeIJDrVYJ74i/D2u762dS5Cy7SgA3Ksr4uKBGT5oBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LqKpjvmm; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e2ad9825a7so3365699a91.0;
        Mon, 21 Oct 2024 18:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729560201; x=1730165001; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+nflOpJ1k5Cf2lDEoAyTHn5bOyR9tNFOYHzbVfupr0M=;
        b=LqKpjvmmFnVA3VB3oUyPSXEC8NFnoD6ELfKoAUXbMhDGyZ2WhiHpLpnHXsfvnvVH1a
         qb/1C9m8NfCx9L6cAnyP9sCev0YnT+LhL+elwQpv1JY5k+ROMKtlo6yCYObXs1aNjGqb
         y1wlrwH0iehGRSRTTVe74oxd/eOs136vQZL7TREbyaonpzfdC+5AsCFJAxrlc2r9XasR
         IhFuV5N3LcXMY91EuJ0Vsa/EPDh5KoXSs6R4r3ltaHktmDlZj4QJR7RYx2ctK830YV05
         F7zdKdb+FtGsWb+U5VxKQXwwaYD7WIcMQ7L3VlX6l5kiT9sl/XknIAn+o0825HGfiTNf
         PJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729560201; x=1730165001;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+nflOpJ1k5Cf2lDEoAyTHn5bOyR9tNFOYHzbVfupr0M=;
        b=VBSqryOuZtyXBkyltUP2ZhqGYXi5wzknyZmPGnl/T+NmxkqD8ff5aNv3ZKZbUAihoN
         Bvj9Dv6GG67G66fvs9qB0ftCc9yXTBscdM01pURBiyShVbmdxyLchxATAj0goukRSs9J
         AsIBGNPI1IT11DgGXlSwQcxuEHSDzE5PVj8CJ0T6FuSpNhGpHWbVbt2AFu6QlU3aqn5L
         MA4aIMiDjfdI39obpQHGht8ELbKSNnuafe4FrtvfHpnLyD9NBLUnACAKzFYOUD/TDAF3
         mUiylq7lzItWMHlSaLEl+G1Yqhzxm+XvhoOIibRZHLgfMiz4npgJVeNVIpL9Q+NVCmBI
         BOSw==
X-Forwarded-Encrypted: i=1; AJvYcCU2ADmdFOdPhI5By3wTQmymK5S7aVjtQyFwI5GRGjQcqkzb1iGzmPvGhKmDw89AcbH6+OUVA1otVaFg@vger.kernel.org, AJvYcCV2ANfSzqb2VI3+qdcL7CioWu99woc9cmDf2UIO91nv8jWMfXt0GEMBydijsrF2Tj7H43sHZuA1MAEWDVU+@vger.kernel.org
X-Gm-Message-State: AOJu0Yw53VbsewyAdxJShq5IA3GU2wPpCc3Vc8CEvrRE1taZ4fOpWu7i
	6Lf/wXkLpvINZ2sE+afARxeJFTlBnNUZu3kvsAxqdfjWXlfbixCX
X-Google-Smtp-Source: AGHT+IFpH9RU2ziv2bxygbSHhj6Zj70zW+1nPlHR7YFC+kAWuacLofnLqeXTbuUIimcOjXvQ0UCMcw==
X-Received: by 2002:a17:90a:d90c:b0:2e5:5ab5:ba52 with SMTP id 98e67ed59e1d1-2e56165ea76mr16533730a91.20.1729560201295;
        Mon, 21 Oct 2024 18:23:21 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5ad365d14sm4718919a91.13.2024.10.21.18.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 18:23:20 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH v2 0/2] ipmi: ssif_bmc: Add GPIO-based alert mechanism
Date: Tue, 22 Oct 2024 09:20:45 +0800
Message-Id: <20241022-ssif-alert-gpios-v2-0-c7dd6dd17a7e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO39FmcC/32NTQqDMBBGryKz7pSM2tJ05T2KC38mcUCNZERax
 Ls39QBdvgff+3ZQjsIKz2yHyJuohDlBfsmgG5rZM0qfGHKTl2TIoqo4bEaOK/pFgiK11t6Ns5Z
 agjRbIjt5n8lXnXgQXUP8nA8b/eyf2EZosHwUzHxLyb6o/NTIeO3CBPVxHF9Y+oonsAAAAA==
To: Corey Minyard <minyard@acm.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Quan Nguyen <quan@os.amperecomputing.com>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: openipmi-developer@lists.sourceforge.net, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Cosmo Chou <cosmo.chou@quantatw.com>, 
 Potin Lai <potin.lai@quantatw.com>, Potin Lai <potin.lai.pt@gmail.com>, 
 Cosmo Chou <chou.cosmo@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729560198; l=948;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=UkJsOrwcfH9BNzQhTmrxQCQo4/Kg2M03/sGd8f6tRiA=;
 b=ec/0MNy8XjiQvAWal6jFtLTRVYirTseqj59EcLZg9DyiF/UlHf6qAkMBr8b0lvW8/0la7zinz
 6CGtgqkxLkuD63/Fcx0EynXgs6i1D0MruFmDACf+1MgxSu1/PWKFF0H
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

This patch series introduces a GPIO-based alert mechanism in the SSIF
BMC driver. It allows the BMC to notify the host when a response is
ready, improving communication efficiency between the BMC and host.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
Changes in v2:
- Adding gpio.h include in ssif-bmc.yaml examples.
- Link to v1: https://lore.kernel.org/r/20241019-ssif-alert-gpios-v1-0-483eee5f99d3@gmail.com

---
Cosmo Chou (1):
      ipmi: ssif_bmc: add GPIO-based alert mechanism

Potin Lai (1):
      bindings: ipmi: Add alert GPIO enhancement for SSIF BMC driver

 Documentation/devicetree/bindings/ipmi/ssif-bmc.yaml |  8 ++++++++
 drivers/char/ipmi/ssif_bmc.c                         | 15 +++++++++++++++
 2 files changed, 23 insertions(+)
---
base-commit: 8e929cb546ee42c9a61d24fae60605e9e3192354
change-id: 20241019-ssif-alert-gpios-1b9960f991b1

Best regards,
-- 
Potin Lai <potin.lai.pt@gmail.com>


