Return-Path: <linux-kernel+bounces-553741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D90A58E54
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D7161886480
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B7622370A;
	Mon, 10 Mar 2025 08:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZENk5Fqd"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3A9F9CB;
	Mon, 10 Mar 2025 08:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741595980; cv=none; b=pHmKLMYAN3k7Y5ZcE79Mir0xmkrIqgC+I9xgAY10iTX7hFB2ebn67J6+08r05NKh3iGcfTCQ4VqOCFwWRvKHzLJn2X/m7/EOMMuJV7ge32eIOyF4ZNlyTtHPQZB++s8Af90ZmIpa1ZddTjMtVFx8ONq7w2yeBvSo8Dtjq4T0ApI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741595980; c=relaxed/simple;
	bh=Ens4mW/VOnDxf+/m0m0sz7eh4cSEe/GjTqbYLbm48l0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BCWLZRiQBnrLvtGil3eVChFi7Vp964CBb93OyxvHiPbmu0enaQ8+oaA9Iec7cbXL44HrVOFyC0KafioewJues3Gqfi0tZT5Dfl53uzUnGzPQTV+V2howmrhdVmwr1UwXm2ihJHwYyK5oNTED3urnkupIewym2PJ9/QsZ+elSNeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZENk5Fqd; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac2a9a74d9cso69553166b.1;
        Mon, 10 Mar 2025 01:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741595977; x=1742200777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uKRxHFwd/2vW4jmL6ANEf5eoCq9mv6fT9Ju/M9j0wwM=;
        b=ZENk5FqdTCkn/J5g5pVWl9sQDNMDhtdJCctG5IZbtCVwp26hzjC8NLTSb7KLAT2Ver
         3hj/GoBKwz1G+PiqLvoImWFULJ6rlx81ZeBOmiPiQxv+rHDoYwg08HgyRkiod3+cj0wd
         jVd/kPGe3fvEwy+hs9vrNUqDoO0GdqTznaDZm+bI+YBDll6Klm+lRZokfaimoE/sjIHU
         gAXgVShXUsHZuw+Tfm03gO00W68ypgL853BoiFY3Td+CQ4/yP9HV7xfO98VEcj4sBPE0
         OiWyZsuNaJwnxwtA1DJ+jt8//mNAEI1NPxzh+dwhSDasJ3N5IlUrx2UOluj3gSOpSrKN
         BZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741595977; x=1742200777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uKRxHFwd/2vW4jmL6ANEf5eoCq9mv6fT9Ju/M9j0wwM=;
        b=e74yMYjg9h677OA2l0h0pF61luFWsVwFzBUmea671opi0JdRCLr5NEeZts9Vi34V0J
         YMEE9zceTyKr88bFL/3Tm1mrq3oDNo04TKSsthAHyfy1LtQIG6MFW2EJqO2Vi31jQpQh
         YL5nQqGNsHvAk+oV1+DD33dwwcZNwwq4Cybjm8/u2VEyAPP5oo6Nqtm7Q0mjLvPAXPab
         BEPAidwzY0QRoKQdn1h6uvxvDrRIr8d9v3sdenRI/+zYS4tFbX8mYgeZBNVwFdb2IGlB
         QEFHKQBxGoruMMz3OmSVvQTSHpPLTpEphqXta1pejGo4u+NlhQYlVigxad7a1qimVtGa
         DXWg==
X-Forwarded-Encrypted: i=1; AJvYcCWYG7nOVZuAXGl2vXOYaQwADo4JpqKJFE9BzmTLTFFU1iwmpTB66llXoAd2OcDnjlGDb7Q92DykYXUklJs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhxqc8g9YIcutgytIUi0gN0EjVdzm5T0mawWaV1ML8MGod6mXd
	3tjO0dP+b7+9ERfS3k1AaeOPii3uVr7ssqQRtlWXZdrvmkiEyiD9sbMrqA==
X-Gm-Gg: ASbGncsHFdRNfH/kd6/+yvJr/U3Z0JcNTzsBARMZXypdXm06s5ucFfsuLg3C6e+R+hC
	rAVE3O4BRM9MqIczEfe/dbhY/tNRJkUV4Yzcwgj9vMltyfpSA464h70qs1XwVDJsZI3lgTXvCSa
	hnRKbkBYsSr6xxF3gzveTv2SBsDNwHyE7jA1pyPebqpKVXChDrymk1mi3o6mvT7mV3ZD1yBwyXD
	B/I7NeSSgFO1LMMO1ge0WVAwJz6v8VGzVJdGJI9y+WtHwmYPR6pM95feacRzmzqqxcJqj4Fzq9i
	g9B90xsRGm594wpLSjLyaoI1QgpQQoDp7rtt7OnkX64gkDnjLLcA+wQRlZDBcw==
X-Google-Smtp-Source: AGHT+IF2h3Qh1MvINc7TntMvj5jAzgE+ZNvvLSHkKYUgAkJukRlJZtIgiFfNea5wX6bX/oYSXRML4A==
X-Received: by 2002:a17:907:7e8c:b0:ac2:892f:43b with SMTP id a640c23a62f3a-ac2892f1376mr643454666b.36.1741595977178;
        Mon, 10 Mar 2025 01:39:37 -0700 (PDT)
Received: from foxbook (adts246.neoplus.adsl.tpnet.pl. [79.185.230.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac25d376342sm550846466b.106.2025.03.10.01.39.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Mar 2025 01:39:36 -0700 (PDT)
Date: Mon, 10 Mar 2025 09:39:34 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: usb: xhci: Don't change the status of stalled TDs on failed Stop EP
Message-ID: <20250310093934.7d688648@foxbook>
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

