Return-Path: <linux-kernel+bounces-447687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEDA9F360B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD6F4188C42E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1452206F19;
	Mon, 16 Dec 2024 16:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YEXKbdiG"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADA5203D4C
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 16:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734366469; cv=none; b=tKJIxVgzyLVG5R3Tfnn8OBPCOBXILoUJl2wF7m2IA7J0MnQESKENOPk2jX9OKdslZLBwhr2nKdFDEbFAq3qHjdbMTfYtcDskM45A4EFzSamnM1zbq+DznlQ6v0//8WZFM1G2N8r482YAkuk6qubZkCJ7VyHd32T257zJGBDB8fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734366469; c=relaxed/simple;
	bh=HWXJI55Bbef5Ohuw0UPjmcWf0sUSE1PZpO0/NCDoUBg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h5hhiUwjU/31yyaNvzjfGxVIZ3qkc2+Mr894seXY6rul0t4ZPhuMrPGLHPwfC9/N5WXI2G523KPY93nWaUFa9vGmo1V0BGIgQ6oiFhz+aQbD4eptoSq09da4fHk50rqaxSCjYHaowWzQCHVj78Cu6UPOw2pyRs4RjwaszusRawU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--brianvv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YEXKbdiG; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--brianvv.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ee5668e09bso4046252a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 08:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734366467; x=1734971267; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OMUA0aQKK7WEbAxFgPhIKVdu3gMaz4/z872qXRxIgaM=;
        b=YEXKbdiGLG7vtwUi8FH/vfQeC4QPTgYyHLgPoexplvjBxvRzlzDCNCqBzmDPDCpN/m
         AkLNcqpqJKL054iUGRLzjR4SxC0VNGArhopjDTXgs+F7MMLtNJDmT9pnRPG0ArRZA96k
         9EFwRFw8ZkWjOT7uBY3zXM5bX3clJrAsuKJLMwtnhI9nXqaFW7GxNL0ADqWj6sjIBHNZ
         ftDoWNjkY5xckfkRxpV6ziYP6wcRmShSPnQNjpCKdUkz0qmTEhGi8HK116vhagzWte9h
         FTYMEkTYWznTG2kjzW6+0SmJLJ8hvl2q2QXUmrI4YRm/Z02hH7kwPrrMOvslKX6j+qUp
         XASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734366467; x=1734971267;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OMUA0aQKK7WEbAxFgPhIKVdu3gMaz4/z872qXRxIgaM=;
        b=XX3uxZIcDrCjgOWGuUahPNz//4yUqBfvtiaEWGnHHG5n7AzbRwHSTZKcuweSO5nvyy
         7Shw7yWoliVKgv7R23AG4SoCHznQ1zVz7pXE31Yk4ZBKMYGMucyEbkyECEGAbhyRyvZv
         gKIckHWD61Qnk0RgGjZu4ZFdXfPH0GLd4RcU/ttf/00VpOk4dl//EaTO5zrWKUyN80/E
         LHEFiAFklmMGH/ORGxziHEhU1gb+gPpEVvGDGdi3KNlRRiJcrWSnpDr2WeNqrCEaO+Ai
         rRv5sijzyRMaL5/2lUEuDEj5CNjAIsw1LuvmCQE15Gm6DYdwWxrG3HdBxZJIkwdLO01N
         hQ2w==
X-Forwarded-Encrypted: i=1; AJvYcCWnA1UTvj2+eCSptc9dOKGe1mKhlBk85ECcFstmhFXae7UOXW0cLPuRAPNWsPbm8FmEdmuQVYz8yJa5Cos=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlzRr8NxkDwp2yedWp/Hx7AJK2qP695ZfAvWGOt+z9NWhwSRx0
	599Dl3/oJchXCLlTFZR9KubRGALwk72LDzzcNiXiPBSOrn4znnjvYu4tL6aDEtDs+0QFtW3eQm8
	Kgs7dZg==
X-Google-Smtp-Source: AGHT+IH29wLjTLhFYC5SnJVDS+4WNLF1Yk10O+SW6jqm4mnWBwmXUCgH4x75maTCI76khncZvMc7FTYlHAjY
X-Received: from pjtd4.prod.google.com ([2002:a17:90b:44:b0:2ef:95f4:4619])
 (user=brianvv job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1b47:b0:2ee:c797:e276
 with SMTP id 98e67ed59e1d1-2f28f864a29mr21028983a91.0.1734366467107; Mon, 16
 Dec 2024 08:27:47 -0800 (PST)
Date: Mon, 16 Dec 2024 16:27:33 +0000
In-Reply-To: <20241216162735.2047544-1-brianvv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241216162735.2047544-1-brianvv@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241216162735.2047544-2-brianvv@google.com>
Subject: [iwl-next PATCH v4 1/3] idpf: Acquire the lock before accessing the xn->salt
From: Brian Vazquez <brianvv@google.com>
To: Brian Vazquez <brianvv.kernel@gmail.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	intel-wired-lan@lists.osuosl.org
Cc: David Decotigny <decot@google.com>, Vivek Kumar <vivekmr@google.com>, 
	Anjali Singhai <anjali.singhai@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	emil.s.tantilov@intel.com, Manoj Vishwanathan <manojvishy@google.com>, 
	Brian Vazquez <brianvv@google.com>, Jacob Keller <jacob.e.keller@intel.com>, 
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Content-Type: text/plain; charset="UTF-8"

From: Manoj Vishwanathan <manojvishy@google.com>

The transaction salt was being accessed before acquiring the
idpf_vc_xn_lock when idpf has to forward the virtchnl reply.

Fixes: 34c21fa894a1 ("idpf: implement virtchnl transaction manager")
Signed-off-by: Manoj Vishwanathan <manojvishy@google.com>
Signed-off-by: David Decotigny <decot@google.com>
Signed-off-by: Brian Vazquez <brianvv@google.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index d46c95f91b0d..13274544f7f4 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -612,14 +612,15 @@ idpf_vc_xn_forward_reply(struct idpf_adapter *adapter,
 		return -EINVAL;
 	}
 	xn = &adapter->vcxn_mngr->ring[xn_idx];
+	idpf_vc_xn_lock(xn);
 	salt = FIELD_GET(IDPF_VC_XN_SALT_M, msg_info);
 	if (xn->salt != salt) {
 		dev_err_ratelimited(&adapter->pdev->dev, "Transaction salt does not match (%02x != %02x)\n",
 				    xn->salt, salt);
+		idpf_vc_xn_unlock(xn);
 		return -EINVAL;
 	}
 
-	idpf_vc_xn_lock(xn);
 	switch (xn->state) {
 	case IDPF_VC_XN_WAITING:
 		/* success */
-- 
2.47.1.613.gc27f4b7a9f-goog


