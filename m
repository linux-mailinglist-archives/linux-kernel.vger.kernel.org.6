Return-Path: <linux-kernel+bounces-285340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3FE950C42
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 20:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01FD01F23310
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 18:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C751A4F37;
	Tue, 13 Aug 2024 18:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JtAT5yIh"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCCC1A7063
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 18:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723573693; cv=none; b=pSpXlXbyFTG+FHrPU1Td3v4b+UNeFgNUgl4On/Edicux1w4RlH6YUnMDcQr1cPk4BVwhssQ9SafOfxHQ28deQSAL5hi7OlPOpOGlHcJ9rmv0vbaKpLljpLCIcLupMRXjwQfMC7Nn1PXpApZSz10z9QRR6C2lZlECiix6XT/K+9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723573693; c=relaxed/simple;
	bh=mFkftTIu02mfcYwHXBEgJrzZ1AKjIW4aHcghMUbRkOw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UBFpwA/l1r+cXvI9pOpIFjmLS2l1LfyIJuesMRRUZrlWkl4obxEsPyWvrrVJmgX+PM5vidtbj+zZ2vjzm4dhUmCT3w+u+hHgBIna5EkdQ3UMgKeDeb7o32e03UDBn9aYzSHe6vFfEWyRw3PYZ0CKPMOFlEg4v0RISFCv1lCQifY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--manojvishy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JtAT5yIh; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--manojvishy.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0be1808a36so8481600276.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 11:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723573691; x=1724178491; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2l203xNbbDmQFlGySVGE48ihh5ns60KyrsTrGKa57JU=;
        b=JtAT5yIhxSVnFOVNQxpQtPI0Skwsvb0Z4tn/opjN3IbB4pfEXjfWCkrfslRjKnkViT
         3Db+DTf5TFRpfF+omJsZuI0PNLpgJFZhWKAgFCz9LU4FtMv6TBA9rrjhPLMeQMYsNuua
         BxAh01ncKAUFzFy1QgAS3dniFLNF1Go5vbvp3fC4hJAHnpgcRhoqmB5C3a+CxP8R8ajf
         8KquqEuZTqFcM/Q6MQQv6t/WzEl+sdEPkslNXxKh7GXfRxJ02fGarYUDV9l23mZTi6nf
         YBExgpH5YsHVzq1V7cnTeZ0iBiS1lBLhWzcjkjm00dxLwa4uxNkPGuAzfZm1RnnWx2jv
         LNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723573691; x=1724178491;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2l203xNbbDmQFlGySVGE48ihh5ns60KyrsTrGKa57JU=;
        b=bhDs1DkiBvATXpGpJ53Voafxv7i1Q2Oee/XkIXpSAu83eXoatem/Ya37Q4JvnHMP+u
         XQPSV8abpjRhvMdV+Q0M98d4qhfdYJINxDkiXJou9bGpMJ7SdFVx6qe1/3AZ7Ao4QggT
         08+MaEqU+hCbWYIaJvMPWeNXp2943HULgsn4T6dbHoEEogVuVsshU5jx5vBsOd83Gw+7
         1a6dvPdMGXxZWO03Kyp5M9XWy/ExwM+sLTpVVFGW9TTHXSUs67fbiet7/wfRCQIRQsV4
         XB25k/IYNZluQG91cqhEDtVKPpEK+fuFAdpxOsVTpXD7uCHuaemp7SsDUWbPDsob4MUd
         k7RA==
X-Forwarded-Encrypted: i=1; AJvYcCV2aS2ZNy52+b24WLDL4Es5x1i9mzveEpgwmZH3H4GSqbXOM+dO1bCwTNcaSLG6unWwhqmEQEc936+cjXFoic/4TXKC2dTYiKvStjG/
X-Gm-Message-State: AOJu0YykzAGfuRbFuC6fG4P422Tfa7oT5IlK1LswW3SATNEtW59Dq2+6
	+oqpSJk4+2xSxmtExEsmE2QmgFNBtNhAsBovFDcqclstqLC8DesJ4VlEgIZZB89P6zGTboCAJla
	9gqnJzyRWhUtokd9d1g==
X-Google-Smtp-Source: AGHT+IEjC2wQwCxOJBrBI4mvt/RtCshXJNtsKgTfCt4RfM09XRcGt/PRVIU4C6Llzti+4BVUOLQboVqmXWvBEOBm
X-Received: from manojvishy.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:413f])
 (user=manojvishy job=sendgmr) by 2002:a25:c5d1:0:b0:e0e:3f14:c29d with SMTP
 id 3f1490d57ef6-e1155a94bdbmr13662276.4.1723573690732; Tue, 13 Aug 2024
 11:28:10 -0700 (PDT)
Date: Tue, 13 Aug 2024 18:27:47 +0000
In-Reply-To: <20240813182747.1770032-1-manojvishy@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240813182747.1770032-1-manojvishy@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240813182747.1770032-6-manojvishy@google.com>
Subject: [PATCH v1 5/5] idpf: warn on possible ctlq overflow
From: Manoj Vishwanathan <manojvishy@google.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	google-lan-reviews@googlegroups.com, Willem de Bruijn <willemb@google.com>, 
	Manoj Vishwanathan <manojvishy@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Willem de Bruijn <willemb@google.com>

The virtchannel control queue is lossy to avoid deadlock. Ensure that
no losses occur in practice. Detect a full queue, when overflows may
have happened.

In practice, virtchnl is synchronous currenty and messages generally
take a single slot. Using up anywhere near the full ring is not
expected.

Tested: Running several traffic tests and no logs seen in the dmesg

Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Manoj Vishwanathan <manojvishy@google.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 07239afb285e..1852836d81e4 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -218,6 +218,15 @@ static int idpf_mb_clean(struct idpf_adapter *adapter)
 	if (err)
 		goto err_kfree;
 
+	/* Warn if messages may have been dropped */
+	if (num_q_msg == IDPF_DFLT_MBX_Q_LEN) {
+		static atomic_t mbx_full = ATOMIC_INIT(0);
+		int cnt;
+
+		cnt = atomic_inc_return(&mbx_full);
+		net_warn_ratelimited("%s: ctlq full (%d)\n", __func__, cnt);
+	}
+
 	for (i = 0; i < num_q_msg; i++) {
 		if (!q_msg[i])
 			continue;
-- 
2.46.0.76.ge559c4bf1a-goog


