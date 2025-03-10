Return-Path: <linux-kernel+bounces-553743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B805A58E5A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C68E31886848
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DFF223710;
	Mon, 10 Mar 2025 08:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VB++FgA7"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4017CF9CB;
	Mon, 10 Mar 2025 08:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741596044; cv=none; b=Ix81n2IRn9NdWW8+L/CDCYaUj87Za21/nZkUFo+91NJ5JDfALSnYzBql82DUq817snPS+l1E0+B86zLHNThBSrTPMEwkEv3s/gSnMrv4PernXmfZdOLr1B6nWBgDQ+qkFqYwsiccYxjFnxQxeZN+UqkFYGHcSfZ19m+4O5iqFpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741596044; c=relaxed/simple;
	bh=Ens4mW/VOnDxf+/m0m0sz7eh4cSEe/GjTqbYLbm48l0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PhK8fNY3esap+c+ASL/1ArxTNALqf0eXMDcV6kYUzhALXgaETebfRsnJY2xXPAfJuzbwR8vIkP0mkGd/ifOkrtM981uwRS8n1qRihVDtZe4oDmFra1hSFpBGZDHe6OxzL1zL3yVjK/GnJ+u6w/SyrmZaT9ibS3Ob9IaOVH6K2h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VB++FgA7; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e6167d0536so3488385a12.1;
        Mon, 10 Mar 2025 01:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741596041; x=1742200841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uKRxHFwd/2vW4jmL6ANEf5eoCq9mv6fT9Ju/M9j0wwM=;
        b=VB++FgA7KGDhbSqk+FXpVOCPONz2zfScacKmO2NajMV1RbhdW1R/gX/0dmHn6FXxYA
         v2qafwCSK9Adw+wAiJfOeyk8JPfV37xngPrIBEIpl6RCQcx69GBnL01jM5gf9sVsaKls
         tnSaDckPLnFFMcN7Nu1t0nMBiF2qnCUJDD6J8Jyowoxc4FOmHhD+YFQlJNSv7UI+3LTi
         qLTMf0BMNq+LN2LAhthCq0/SkFJT8pmn6rVQESWxSyscYcwuX+eg83kmce/0zBxSx8DH
         5rEbJpmDZSrDYKR7MYe8L9z7kVkWqsN909vfaKKZRBMO+xutLwAYIP1o8tPCL+qIZmxk
         4Mcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741596041; x=1742200841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uKRxHFwd/2vW4jmL6ANEf5eoCq9mv6fT9Ju/M9j0wwM=;
        b=ho2iT4KaSr60hsfMRlKCkgiFbTQrSqBBALe2k0xYV9jeSUqn0NwiMX0dCIRaG/Tsou
         p3F0bqmEQuz4ZoPbaHpJKct93A8MPHeO+JzZXbzF6yw6cLiOYf/OhdsLlVnqNh8ZNNlG
         ycd5vEP/iW1aQc2/IZ5OM17YE5HcvNf7dG2N8VnlwMv7clMTQ8mbgCjzLBu9HTTiZzcM
         Lom86W1wqvlqVUYPzxMv+mrfQAPwO2PqNhOlC0pkrFyEbpiIaQTAEvzbF9U0/wncGRWn
         4jHZZrFRH3LDiSs/0WT27EhVXjtCGLmSLc36oSUXmsUI+YqLnHN5ZtiAEpnHwlKsHLgA
         tPNg==
X-Forwarded-Encrypted: i=1; AJvYcCWP1w9FQOt4boaIDrIYTTUBEIJZmyiZhrKQrjAMz1/0E0X7jJXF+N3lMMwhID50P6CLsaNTaibXZ7t5ww0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJVf1FJlusqVJQXLsmansAt545fxpxMltVetA1LncnwxOUQHlT
	movufSXoATaS8GDZmHM+1VjW6DCjc53LwNpnc12WFftGHf7QZ4zN3a7whA==
X-Gm-Gg: ASbGncvt2P7n7mp5AWkDp1WvrXi7NrPJR2I6zrhTlunVUNk1NNJWzu1DrsuXonbQipy
	IRCASb68i5Tm3U2C1ykktingO8w5KQUjt4uiX4ufHJ5TwFPVjl2Be9RfdA0EQpUn+7Eetcrmg7K
	r2t4xh9aa+jLQbN+ZCLnKvT31BsiYtW5vlmJQj5WWT0l53d3Hr5HJZIgzGHfRyB746FaKwtlXdj
	usocfSvbYm8Z44fi5BuK7+eTllNfwGoqXDsTqju7pqQPlL3vejbxkFr9Irlz/paw5RlnWyhxbEm
	hmqPf5+0FLHwlNiPoKCd/NG10hDN26QDM/f9YKEPAMFmJbNrjJ0rZwqs1tliJkBKVEm+/48e
X-Google-Smtp-Source: AGHT+IFhw9TBYLkR/DFN/0ojmMM3DShRsh6XKMKPnlE4NPHejTsc3h+RLUH4BZOKSBp6+0MdTdQRrw==
X-Received: by 2002:a17:907:938a:b0:ac2:92df:fab3 with SMTP id a640c23a62f3a-ac292e003e5mr325618066b.16.1741596041358;
        Mon, 10 Mar 2025 01:40:41 -0700 (PDT)
Received: from foxbook (adts246.neoplus.adsl.tpnet.pl. [79.185.230.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2394825adsm743622666b.56.2025.03.10.01.40.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Mar 2025 01:40:40 -0700 (PDT)
Date: Mon, 10 Mar 2025 09:40:37 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] usb: xhci: Don't change the status of stalled TDs on
 failed Stop EP
Message-ID: <20250310094037.52625e24@foxbook>
In-Reply-To: <20250310093605.2b3d0425@foxbook>
References: <20250310093605.2b3d0425@foxbook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

When the device stalls an endpoint, current TD is assigned -EPIPE
status and Reset Endpoint is queued. If a Stop Endpoint is pending
at the time, it will run before Reset Endpoint and fail due to the
stall. Its handler will change TD's status to -EPROTO before Reset
Endpoint handler runs and initiates giveback.

Check if the stall has already been handled and don't try to do it
again. Since xhci_handle_halted_endpoint() performs this check too,
not overwriting td->status is the only difference.

I haven't seen this case yet, but I have seen a related one where
the xHC has already executed Reset Endpoint, EP Context state is
now Stopped and EP_HALTED is set. If the xHC took a bit longer to
execute Reset Endpoint, said case would become this one.

Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
---
 drivers/usb/host/xhci-ring.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 9e4940220252..28ebc0fc5bc2 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1215,7 +1215,14 @@ static void xhci_handle_cmd_stop_ep(struct xhci_hcd *xhci, int slot_id,
 	 */
 		switch (GET_EP_CTX_STATE(ep_ctx)) {
 		case EP_STATE_HALTED:
-			xhci_dbg(xhci, "Stop ep completion raced with stall, reset ep\n");
+			xhci_dbg(xhci, "Stop ep completion raced with stall\n");
+			/*
+			 * If the halt happened before Stop Endpoint failed, its transfer event
+			 * should have already been handled and Reset Endpoint should be pending.
+			 */
+			if (ep->ep_state & EP_HALTED)
+				goto reset_done;
+
 			if (ep->ep_state & EP_HAS_STREAMS) {
 				reset_type = EP_SOFT_RESET;
 			} else {
@@ -1226,8 +1233,11 @@ static void xhci_handle_cmd_stop_ep(struct xhci_hcd *xhci, int slot_id,
 			}
 			/* reset ep, reset handler cleans up cancelled tds */
 			err = xhci_handle_halted_endpoint(xhci, ep, td, reset_type);
+			xhci_dbg(xhci, "Stop ep completion resetting ep, status %d\n", err);
 			if (err)
 				break;
+reset_done:
+			/* Reset EP handler will clean up cancelled TDs */
 			ep->ep_state &= ~EP_STOP_CMD_PENDING;
 			return;
 		case EP_STATE_STOPPED:
-- 
2.48.1

