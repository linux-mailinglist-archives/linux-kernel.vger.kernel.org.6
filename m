Return-Path: <linux-kernel+bounces-444068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FCC9F0039
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 00:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0D0E16440C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 23:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519891DF738;
	Thu, 12 Dec 2024 23:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tGxAbfoT"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349A91DF279
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 23:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734046450; cv=none; b=Ez7FeZVjITYbK+8i+dOkh2vlzXlqruv9DvDB3tWbAsH+ITrFnmiinW8ydY0gp4RzoB6z9NJLn4n0KAPo58gcx+lCgZTh1HIXbi8Tm5nYQmFE0V86dgxJQmWZoMohLFwPAHKo86BjPILfKCmTwQNq9xq3JHGzvyycy6GGBHKX8N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734046450; c=relaxed/simple;
	bh=AoRYYxuyz7m5d82P6sXHJGPnueytngGYQ+K6deJQYew=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eFXy0G/YLkoCU95NsdRDyfz67Z9Xyk1ihr0zX3JwObTzU7HjacoQa39xxKThk05QEPeY6PekVPupW4EIdMl3zxX4F9HhGwSmax9hw6v2qh06QcF9T9Q0+Mj4LDKjo16g4j6+qamUM/b7ivOJht1nx+vjj1z13xwJfWn1Mg+7oLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--brianvv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tGxAbfoT; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--brianvv.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-8019f05c61aso818287a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 15:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734046448; x=1734651248; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lVwHov0X10aPJDd/Xn/qoYct9Gn29vQtlHXe3AbUYiU=;
        b=tGxAbfoTjvERxPb/BpR68l8OIQO6kFlhcYZAZIPBXb7XUTF6EVV7+9B+yy3iKdq8vk
         B2HkaSoyx31ylSlVYxF/cnKG4TEsCKEEsnNc76tu0PYvFkSrfrIX/It5cSgAOen8W78A
         mfZRFgGatzCik4D3SxxUp7alsXTNj57hbfb8HDRPU62JgEE89oW46H1qXEw2S/SHjwjN
         nWe56WU3fK0W1PZ2rbe/wqg4ef2QRZzoOr6R5civjbGjU+KWYnLY/qeJuPALalSTJhU9
         rhtwueYhlQPSUhGcDovDNKCM6aIzkPJnRpEk4XL8ROZo3cHljMQFC0p2eG+Q5f7As/t6
         Gqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734046448; x=1734651248;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lVwHov0X10aPJDd/Xn/qoYct9Gn29vQtlHXe3AbUYiU=;
        b=PaEa3sfPpfBou5TmaeSvAF5nOgPCvWtNTucm+5L4nSVECO44nZDBykTBiWCALAgFS1
         5nQFsoy5nlbu1ZfPFY668PbKd8cUSlWNauG/qt4MdaGtEeNwOfwVOduj4SCGd9zW4T6I
         6QzKzeEyiH4AH80PCgD0wDNeqYe/OyyYuH2Dy4CSn4mO0b+27UHHWSpHiPuYR+nUC5Pt
         GCxd9g67/6MDMFDz97jJ3MmSuCle/X/XeMgk2pSIEH4Z3D7FxQoVsoSMFTjzLwjgDKng
         T9dLPS6K7UI8slEoFvhHSV/EbGazH7Iayg5+QtBcBjb/cS/cF5RpIxrRUtQqfWKj8zov
         gLEQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4PIh9A3DdYyj+NHX8522yqmJkDNNKHYGCUp6Y6+Wx/1DVoOJs8arqBSIZddxIKDIYs9DydA5MYGIqk8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMeaCyBUDbdYfo/uCK4vLU6mbENz32WZZgSjo3m76oBtQEqTW1
	9R8J7SooeI5pR1NLGrv+1+ujz5DQZnQajLh20X2Sn/RCwdkIC6eGE+vtv8YaFFhlz4OIWpYhyZB
	GoNauhw==
X-Google-Smtp-Source: AGHT+IGe7FiBmEImdX0XEsLZOBwrOk+VTTkGoZbu8+xZqBSfxUA2PcZQtkQcbVVi3V7YTKio7yX0EY8giLOl
X-Received: from pji5.prod.google.com ([2002:a17:90b:3fc5:b0:2ea:4139:e72d])
 (user=brianvv job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:53d0:b0:2ea:a9ac:eee1
 with SMTP id 98e67ed59e1d1-2f28fb5fd68mr962924a91.10.1734046448532; Thu, 12
 Dec 2024 15:34:08 -0800 (PST)
Date: Thu, 12 Dec 2024 23:33:33 +0000
In-Reply-To: <20241212233333.3743239-1-brianvv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241212233333.3743239-1-brianvv@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212233333.3743239-4-brianvv@google.com>
Subject: [iwl-next PATCH v3 3/3] idpf: add more info during virtchnl
 transaction time out
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

Add more information related to the transaction like cookie, vc_op,
salt when transaction times out and include similar information
when transaction salt does not match.

Info output for transaction timeout:
-------------------
(op:5015 cookie:45fe vc_op:5015 salt:45 timeout:60000ms)
-------------------

Signed-off-by: Manoj Vishwanathan <manojvishy@google.com>
Signed-off-by: Brian Vazquez <brianvv@google.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 13274544f7f4..c7d82f142f4e 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -517,8 +516,10 @@ static ssize_t idpf_vc_xn_exec(struct idpf_adapter *adapter,
 		retval = -ENXIO;
 		goto only_unlock;
 	case IDPF_VC_XN_WAITING:
-		dev_notice_ratelimited(&adapter->pdev->dev, "Transaction timed-out (op %d, %dms)\n",
-				       params->vc_op, params->timeout_ms);
+		dev_notice_ratelimited(&adapter->pdev->dev,
+				       "Transaction timed-out (op:%d cookie:%04x vc_op:%d salt:%02x timeout:%dms)\n",
+				       params->vc_op, cookie, xn->vc_op,
+				       xn->salt, params->timeout_ms);
 		retval = -ETIME;
 		break;
 	case IDPF_VC_XN_COMPLETED_SUCCESS:
@@ -615,8 +613,9 @@ idpf_vc_xn_forward_reply(struct idpf_adapter *adapter,
 	idpf_vc_xn_lock(xn);
 	salt = FIELD_GET(IDPF_VC_XN_SALT_M, msg_info);
 	if (xn->salt != salt) {
-		dev_err_ratelimited(&adapter->pdev->dev, "Transaction salt does not match (%02x != %02x)\n",
-				    xn->salt, salt);
+		dev_err_ratelimited(&adapter->pdev->dev, "Transaction salt does not match (exp:%d@%02x(%d) != got:%d@%02x)\n",
+				    xn->vc_op, xn->salt, xn->state,
+				    ctlq_msg->cookie.mbx.chnl_opcode, salt);
 		idpf_vc_xn_unlock(xn);
 		return -EINVAL;
 	}
-- 
2.47.1.613.gc27f4b7a9f-goog


