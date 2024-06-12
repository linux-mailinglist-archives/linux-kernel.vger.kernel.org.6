Return-Path: <linux-kernel+bounces-210912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C71FD904A0C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 06:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77FF21F24933
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 04:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACDB29408;
	Wed, 12 Jun 2024 04:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzrTowvE"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59260168A8;
	Wed, 12 Jun 2024 04:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718166910; cv=none; b=G41zBKwrB8zwwMmS2gdaYNXELSx3WBEepYE1psKgmlHgpmIEKtjx/ez8cMZslBNwMlyB7Czw/88TXG324+5tOIUIJJYOQ1NPrtXj+nLGDBMZje15bbvsT/l3I0QyxcX+F/tY1NoWHT+6vTOcHMb9GVYVLHn6Q35h6iQeUt6mCuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718166910; c=relaxed/simple;
	bh=8WP2CTYbpRv/nngLrCo1HwzPb0MLF05Fw4r0fwK6zRk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HMsvEIrHnR86Zwa5DUQV3b7LaCiiUhHPXqpe+88b052fETu5hTWOTwJ7cScFiZvYjuPjXTxlgWnmIkqBSC+g8PpCRigGmuW5sau9934DnNDYV74cLGse79pkRS2fsVyYEy9y8q15jx1jqLz5AbmPKQj5lzYG4ygjXWT1mPLtJvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzrTowvE; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5b96a95c5e8so3495366eaf.3;
        Tue, 11 Jun 2024 21:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718166908; x=1718771708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qTyD16RFQ5VgBq536t1s/LvsqXQluQ48tMeqJSZ+Xus=;
        b=bzrTowvEO3jEAECV2qDpZva5H3Qion7z62rwF7nY+7ch8vcu7k+PG//0flmR0JqVev
         G+Ajmb8ko3jRkP9TmKWi/gfB5d/MhPgC+u5hpVBLoIKdp/4SlE76FQWKchCPksh/u9U3
         g7ZWDc71fZimlMSXmiBDD+dn9dnsh5DTHnUMA1foqmP4o+xk1m6jHVQ9WKMCjXTw5XTz
         +VcIgz4T6DDKMegHdbyT8Ih5Ds3QPSwlo+rIo8dYGF+pY/8qFyGNaBzK5Elm652vK65N
         OJviDJ6AbEXCE6AhG8vdb1H0u1jqTYIVzDprQjvnYljb19vSKy1Y77ktSwCYFH41ydRj
         qQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718166908; x=1718771708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qTyD16RFQ5VgBq536t1s/LvsqXQluQ48tMeqJSZ+Xus=;
        b=RZfwKdK1keYqPFpitAHsSDGtud+uQZhZNWIdC5hwZsMiFJ1EMPuRAa0U8qMJ+pwI0/
         VfxuR01O6klhtwFjA8LkLVHNyInTlu7hLOQlWfkCZt1ydv7WURCodgQZh3QIaWKl4sf8
         OdHWb3a/LSHI3vJQhcwnB97EmHRH6//bcUgo5rq+Uu6GeJOLZddU5/fnhBrxi2ikftop
         Wv5F4bjnbNqGmNmtjcYIEpr3GNfyjZK7Y0T3qyXpGirC3CFDFa7g44Pf2VUIC2xDLkjF
         pPX4IMvq7LH4ZlsovZC+SgaRXaj7bRbS1lIZa58ypp7NV5howXkoVkPhmFGJYPjjkvWb
         J/yA==
X-Forwarded-Encrypted: i=1; AJvYcCV6ujYF2V3tWyJrOW0JDRF75RhM18fgwoWJcvFqDTpAav8T7oa7KGk7nTnOZ0TZOOMgJdJ6v1+KQqDZOrJwJ67DRH+56XM001zr3umk1D+VOobOtjH1IZPwjAeosSHrmOoa7IDn8Xdomw==
X-Gm-Message-State: AOJu0Yzjtt/rTwkPqCBOeHX4ZhFWjUnXmUbl203MFcyCeviw/moeUu9c
	mlKb2F57K+4mUfUbsgECIXZnyxCAnG2oGFfxlz6FDkO+eDi9VSIn
X-Google-Smtp-Source: AGHT+IGyC/QSfUB3ZpKqYU/VL3KGDjocadn6drhlahW8uh0DL57o6PXA3SQqhkrXEc5qD/6rFnOFyA==
X-Received: by 2002:a05:6820:1506:b0:5ba:c561:bdd7 with SMTP id 006d021491bc7-5bb3bad5bc5mr819684eaf.8.1718166908132;
        Tue, 11 Jun 2024 21:35:08 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6de276061e3sm9021275a12.80.2024.06.11.21.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 21:35:07 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
To: Corey Minyard <minyard@acm.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Quan Nguyen <quan@os.amperecomputing.com>
Cc: openipmi-developer@lists.sourceforge.net,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Patrick Williams <patrick@stwcx.xyz>,
	Cosmo Chou <cosmo.chou@quantatw.com>,
	Potin Lai <potin.lai@quantatw.com>,
	Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH 1/2] bindings: ipmi: Add property for skipping SBMR boot progress response
Date: Wed, 12 Jun 2024 12:32:54 +0800
Message-Id: <20240612043255.1849007-2-potin.lai.pt@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240612043255.1849007-1-potin.lai.pt@gmail.com>
References: <20240612043255.1849007-1-potin.lai.pt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In ARM Server Base Manageability Requirements (SBMR) document, Callers can
choose to not read back Response Data after sending the command "Send Boot
Progress Code".

Define "arm-sbmr,skip-bootprogress-response" property for skipping the
response of "Send Boot Progress Code" from userspace.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 Documentation/devicetree/bindings/ipmi/ssif-bmc.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/ipmi/ssif-bmc.yaml b/Documentation/devicetree/bindings/ipmi/ssif-bmc.yaml
index 02b662d780bbb..b21e958efc184 100644
--- a/Documentation/devicetree/bindings/ipmi/ssif-bmc.yaml
+++ b/Documentation/devicetree/bindings/ipmi/ssif-bmc.yaml
@@ -19,6 +19,11 @@ properties:
   reg:
     maxItems: 1
 
+  arm-sbmr,skip-bootprogress-response:
+    type: boolean
+    description:
+      Skipping ARM SBMR “Send Boot Progress Code” response.
+
 required:
   - compatible
   - reg
-- 
2.31.1


