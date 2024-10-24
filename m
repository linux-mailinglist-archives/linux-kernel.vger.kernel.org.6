Return-Path: <linux-kernel+bounces-379097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C97719AD9E1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 04:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A41B1F22311
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 02:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4FB148838;
	Thu, 24 Oct 2024 02:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v+erznpW"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B0414B965
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 02:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729736559; cv=none; b=LZ66zRi+5GxF/uqWCaw/zPsf+tiw8+2QwgCdG35Z44OuhyqLaPDf+VgjFzMslk+kc2/hCZaTl9cA6RrallPPFaZsKTR+XF95OR4I4dBHPKlok51PuNs5k4bV2Dayszvwwdu5k8f1a2QVX2N6QXzoTYAvxLtZVgQG3qHSJEGqkHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729736559; c=relaxed/simple;
	bh=hGtFXbU9VAyW/8pRrl9hkSCxmzALYxOVKBLxqL2fk0A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=dIxSi5QbuQkJLzk1gaFfO1G59OJJ3PsoLYLdPrvEeo9ntg3jVUeFQG+cyZN11KcLsW5VPsmZa8+nbkpFnjYK6GaHdFnmDjwWzgql8ZIx4QiQ43VaAQEVKIYmy7Lhy2TtO7gs1fYyRUK995+1yNUDwY8mbMRPa1D8QUeI5Lb8vjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v+erznpW; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e2971589916so925946276.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 19:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729736557; x=1730341357; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RChQ6ImziR2UxxxuK55p/UZIl7zlomw2h99sUv/4Mus=;
        b=v+erznpWBQDEyOUMlqOzpaGZzerZyNvleKRA7ha7hTclyESeNCsp5NKe4DHk2VRdJ7
         igEJXgyd3s8GV3V530EhFsjZpQwwmhebCvIrLQkK0lgzf3L7ipCjzuwTElE/W/dm5r/d
         Wurh9ztigHb3davaIYXamgeBSM8KuPOMsP7DNk1ggihaUPE8DyE3xcmslSIAJRUmCpC7
         xfAH5z7aUbt432yCtupI7BHU+FvF3ug861L4IlFNurAOTbEGb4yZpJdJeiIc5FaAdTlr
         rgOLu4J0GRWtTIKerGY4ZjHwuGn6ra+4KE4UB1XhB56NDeRRtxO17MKYbQQP8hz8Ov+w
         GzAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729736557; x=1730341357;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RChQ6ImziR2UxxxuK55p/UZIl7zlomw2h99sUv/4Mus=;
        b=ptq7gS/5gMx6E4+PhxFgfeakUMFybP+cnC3/IQLc3OdFYyNxN6VzbwobSTyMfn7h8j
         rFkTrX3jNwn5wrt5YDXJQEJvs9BHVOBnxMDIv3zaI1MBqv+gd/Tz+T6hIXCSBml+xBJH
         lHJ7+t7VypTAhEog8a8jm4jnmu/Ri6jUjBo05QVICdQY1mduqWyAFkS+/x++p9PW0MaN
         hZztCz4EGbeiDcCRWZCRRvdM4yUT+GeMOviDzgBFwuRPddlyRD0Q+tlqApJZQwcZ1sAH
         YVZdc3T+8KTordaWUlCc5Lch+hFZ4WY2gw37RuC6k4LgWwjWylolBaf6mDBQykQbXbsM
         9vhg==
X-Forwarded-Encrypted: i=1; AJvYcCXELk01ILOBZFDiUIBGvviDDGurSuRPKOjdpetmUSzXmd/+zCCDwOLkeRU+mnM+afkUdIDYmglaA5UoW3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW7+rB8Hgtw0OPKKrt+gT+ZAF9Gq+sb4MChFu7dTpSl0dllj3r
	XIRUsCMu+MEDARsF/lJ1eS4u42Nm/YJ5MKYqbpdJADoF+oBKoIkNIJtHBbUec/QVLC4ZsQlSXsc
	oOw==
X-Google-Smtp-Source: AGHT+IHvpgV2IEy6a8M5p6FINEmbO9iwt7048YunZFeK8TEB+fKeKeGsJJogBorbRaYHFXdxrIma//8yhks=
X-Received: from amitsd-gti.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:827])
 (user=amitsd job=sendgmr) by 2002:a25:74c9:0:b0:e2e:2c11:bbf8 with SMTP id
 3f1490d57ef6-e2f2fbbb888mr230276.9.1729736556338; Wed, 23 Oct 2024 19:22:36
 -0700 (PDT)
Date: Wed, 23 Oct 2024 19:22:30 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241024022233.3276995-1-amitsd@google.com>
Subject: [PATCH v1] usb: typec: tcpm: restrict SNK_WAIT_CAPABILITIES_TIMEOUT
 transitions to non self-powered devices
From: Amit Sunil Dhamne <amitsd@google.com>
To: heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc: rdbabiera@google.com, badhri@google.com, xu.yang_2@nxp.com, 
	sebastian.reichel@collabora.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Amit Sunil Dhamne <amitsd@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

PD3.1 spec ("8.3.3.3.3 PE_SNK_Wait_for_Capabilities State") mandates
that the policy engine perform a hard reset when SinkWaitCapTimer
expires. Instead the code explicitly does a GET_SOURCE_CAP when the
timer expires as part of SNK_WAIT_CAPABILITIES_TIMEOUT. Due to this the
following compliance test failures are reported by the compliance tester
(added excerpts from the PD Test Spec):

* COMMON.PROC.PD.2#1:
  The Tester receives a Get_Source_Cap Message from the UUT. This
  message is valid except the following conditions: [COMMON.PROC.PD.2#1]
    a. The check fails if the UUT sends this message before the Tester
       has established an Explicit Contract
    ...

* TEST.PD.PROT.SNK.4:
  ...
  4. The check fails if the UUT does not send a Hard Reset between
    tTypeCSinkWaitCap min and max. [TEST.PD.PROT.SNK.4#1] The delay is
    between the VBUS present vSafe5V min and the time of the first bit
    of Preamble of the Hard Reset sent by the UUT.

For the purpose of interoperability, restrict the quirk introduced in
https://lore.kernel.org/all/20240523171806.223727-1-sebastian.reichel@collabora.com/
to only non self-powered devices as battery powered devices will not
have the issue mentioned in that commit.

Cc: stable@vger.kernel.org
Fixes: 122968f8dda8 ("usb: typec: tcpm: avoid resets for missing source capability messages")
Reported-by: Badhri Jagan Sridharan <badhri@google.com>
Closes: https://lore.kernel.org/all/CAPTae5LAwsVugb0dxuKLHFqncjeZeJ785nkY4Jfd+M-tCjHSnQ@mail.gmail.com/
Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index d6f2412381cf..c8f467d24fbb 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -4515,7 +4515,8 @@ static inline enum tcpm_state hard_reset_state(struct tcpm_port *port)
 		return ERROR_RECOVERY;
 	if (port->pwr_role == TYPEC_SOURCE)
 		return SRC_UNATTACHED;
-	if (port->state == SNK_WAIT_CAPABILITIES_TIMEOUT)
+	if (port->state == SNK_WAIT_CAPABILITIES ||
+	    port->state == SNK_WAIT_CAPABILITIES_TIMEOUT)
 		return SNK_READY;
 	return SNK_UNATTACHED;
 }
@@ -5043,8 +5044,11 @@ static void run_state_machine(struct tcpm_port *port)
 			tcpm_set_state(port, SNK_SOFT_RESET,
 				       PD_T_SINK_WAIT_CAP);
 		} else {
-			tcpm_set_state(port, SNK_WAIT_CAPABILITIES_TIMEOUT,
-				       PD_T_SINK_WAIT_CAP);
+			if (!port->self_powered)
+				upcoming_state = SNK_WAIT_CAPABILITIES_TIMEOUT;
+			else
+				upcoming_state = hard_reset_state(port);
+			tcpm_set_state(port, upcoming_state, PD_T_SINK_WAIT_CAP);
 		}
 		break;
 	case SNK_WAIT_CAPABILITIES_TIMEOUT:

base-commit: c6d9e43954bfa7415a1e9efdb2806ec1d8a8afc8
-- 
2.47.0.105.g07ac214952-goog


