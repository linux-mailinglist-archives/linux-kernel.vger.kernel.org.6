Return-Path: <linux-kernel+bounces-319456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BC296FCC1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 22:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B22591C24534
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 20:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C8E1E6DC2;
	Fri,  6 Sep 2024 20:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="m1eWSad5"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE47C1E1A18
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 20:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725654509; cv=none; b=nVPJWSIIhBJVbzkALRNHZm/DglDQK+mN3CrXLpJBkm749ngpT0ySlcVL1KejmDZeGoKhAhd+CpEDUsCvBkMUk/n/ey8xJiMfwRAbNJvXW2hGSJA/HBm4Mji5k6IrMaO0S80Lm1Wqh1GAWfyux1FAIi4MSbRvGTjBuyVxxTH/FLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725654509; c=relaxed/simple;
	bh=JZ41Hb7/UZd2+fA36sYxks+5a7KG3YyM6CyHkbkpwr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XV4XCTtIXHEU4XduFq2yr9viSRF/Plna50xDYdzRoDVb8OXdBSpOmGYQAtb1Hl9EmNO76iKk8gfdItIi+FZB06/QjYn+VoNq1fnbjpEFjMqro7NBEzhJXbJRMJvhgBOR3zCJ2S7UaEuueDOc/2Q38gAm7okYYvgyqhZpn1pYmQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=m1eWSad5; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7a9782651bdso296027585a.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 13:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1725654507; x=1726259307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qY1HTk2ePHnVObjiUrKBcGOuLQv3wyl16cvFBMoBIo=;
        b=m1eWSad5PBFvwie1QaX62vmL8UuQRjMFUROf/tNySEOG5ARrGOKO6JrEs84OnHNWLX
         ncGh0b8ssIFRNS6fBWBtqqQ+ZCNWOrlygYWTb1L5zZ+2iWWyxzpoWNyXH7AKhtpyNW3V
         +Iv4qux7FlABozayIJN3odj3YaHsyGSFEK+JgHd7WeZgqUruCpN+oLLsXxpKBMolLxjg
         ZmS8fPrFbmNhkYbU/7Yye+iLM0pO+JxjakSE6KNsIBRDON4xNN5s369U5rlLJxMDbcBK
         NbkLu/HXXCbJZ2chTf1Hrs6C8E3CVRZ9diLFmfoZT8dv0oi5q0l7cx2Df3gjejAFfXiI
         7/Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725654507; x=1726259307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7qY1HTk2ePHnVObjiUrKBcGOuLQv3wyl16cvFBMoBIo=;
        b=JjFsSlSqBd434Cwey6sGu4sjnLRB4YMY+0ObazM+k09VHnGS84Yejx2lu/u+3/yWiR
         aDTycM/uMaQY2b3hzOqIqfXdjVFMfVT6NYsQJ+7DF9Nq5uRihz6n71XF4drElmd6iV7K
         pC2q9anDE5Hx23j/9cQeH6MF8uaLPXBdRNPqetydevs5h2h2DBKJAyMXOwXIpU9PYtCg
         xgeeMn0afS+PoLyAiKuJ7Onilh4e/mhcWNyMc1IEPilccl1yD68ZHN0pK6hIspS2hHM0
         2BanNkpqoz+APzBJZKHkBGeNxsmlVH8un8MaSTx8Y1jkfDxlvyDhC6LRk/wmRrRkQaQZ
         R5TQ==
X-Gm-Message-State: AOJu0YwenH5vOQzLpITc3txFYr2Mxt6WajGv6EMWY3ktjyIumqnjh/4i
	NZzcMJY/+9rftVPmfdx1q1uHjxzR2nEKoT4F9wEJeGz68WfoelyPoZFA57f/VZI=
X-Google-Smtp-Source: AGHT+IHFAOsyAS1saP4F/TdfdR3JBN+Ae7crbCz/ei1WfpsqQgWENY6HB+FbK+cs01k0KPOEVsJfTg==
X-Received: by 2002:a05:620a:3187:b0:7a8:512:b57f with SMTP id af79cd13be357-7a98870d102mr1939603085a.0.1725654506873;
        Fri, 06 Sep 2024 13:28:26 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a98ef1e653sm200519485a.5.2024.09.06.13.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 13:28:26 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ardb@kernel.org,
	leitao@debian.org,
	usamaarif642@gmail.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	ilias.apalodimas@linaro.org
Subject: [PATCH 6/6] libstub,tpm: do not ignore failure case when reading final event log
Date: Fri,  6 Sep 2024 16:27:45 -0400
Message-ID: <20240906202745.11159-7-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240906202745.11159-1-gourry@gourry.net>
References: <20240906202745.11159-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current code fails to check for an error case when reading events from
final event log to calculate offsets.  Check the error case, report the
error, and break early because all subsequent calls will also fail.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/firmware/efi/libstub/tpm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
index 4f9f0e049a7a..c71b0d3e66d2 100644
--- a/drivers/firmware/efi/libstub/tpm.c
+++ b/drivers/firmware/efi/libstub/tpm.c
@@ -124,6 +124,10 @@ static void efi_retrieve_tcg2_eventlog(int version, efi_physical_addr_t log_loca
 			event_size = __calc_tpm2_event_size(header,
 						   (void *)(long)log_location,
 						   false);
+			if (!event_size) {
+				efi_err("Invalid TPM Final Event Log Entry\n");
+				break;
+			}
 			final_events_size += event_size;
 			i--;
 		}
-- 
2.43.0


