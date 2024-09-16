Return-Path: <linux-kernel+bounces-330110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 592D29799D8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 03:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A41B1C22632
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 01:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA16A927;
	Mon, 16 Sep 2024 01:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b="gcYMUCsJ"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FD17483
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 01:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726451192; cv=none; b=AFAuSJyIK8qTKTzdt9gv4/hFs4orMYsRvAVPzvPHPq8HbPrMMJdkX1QjWzFA/m751vLNV6eo2O5TzgB8nhsDrtHDcL8TUa6V5c7JchztgZI0L6J/TOQ9l0e6v2ULdHVjBZ1crw3oiW53T1qq3QW46f5N1o7gdKdHXg6gvKsKQ1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726451192; c=relaxed/simple;
	bh=xE/fdlG6ydZQllBtKyFWLr5BsH11sTnbp+iFO5aF6dI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jAw816m2MeOV9fDI8uy2FidzQwD6edUpzhX61ZsfgEUth4J21/CrSJWbLYLG50X1Rij8aVMSshD60Df8825FU6ePFsAaHIIN4A3w4PD48aZPmIAHXEx9TxRwlIYi/WKseDabtI5bHxsn9dcMzpGJoMoyv/UqiG0dWzQzVq/2eGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=everestkc.com.np; spf=none smtp.mailfrom=everestkc.com.np; dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b=gcYMUCsJ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=everestkc.com.np
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7191ee537cbso2809294b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 18:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc-com-np.20230601.gappssmtp.com; s=20230601; t=1726451190; x=1727055990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ppeTr2u8I2Un8Fu3bec/meFpGK501IK9rm4AM6FtSDA=;
        b=gcYMUCsJxoTf2sGjjM9J5X3MPpHLcGAh8on4ZvLehTcHqTzXNIi0YxjfGo1vC/P3T7
         MSr1Al2QwJyZXt+tFuw0w4MwD+OWYL4yaEl05JRgw+IndtSRsbiY4gdsba/SlhgixGHp
         8UrI4F7HEn3WtfmAiDXpeTOYl37lKsePRdH8BNj19/6T+DfITXRyCPf0OMKgEIFXAViS
         LV/D2hfdoDOq88MeAnqBktR574GYELVIpHJYhBACqccHEsGBFBmJ8fh9lYej4yKCepfF
         GK32g7CdCB4skR4KOSIYxWTCsI2WagA4VWpt72iktmQjuWe5iropAQ72kuAUJgaZxVpr
         xsCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726451190; x=1727055990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ppeTr2u8I2Un8Fu3bec/meFpGK501IK9rm4AM6FtSDA=;
        b=XW221uX9mo4oJvnwo+sddnAXIPcZwBrlz4r1vHjuYdW7l4GT0bNd4knQgKsJdmObB7
         Q9K0nkmTpwguowaIkSGdJZ9KYkn5CYjaHRFTGFNoU05kldDkcDvPo6RWyPWBfjtwqWRL
         CUh8eF/+pnX76aO9kFtwEaGenbegE44yBfTSClGZvEM5eZ0mFAJxJykV2mkpsByYE0LS
         bmObIxL/tUHZhZx6fyTppYGtoWAUyne28cjkA+z6/8aB9q6sU/8uVUyBf2sPz0Dt3kDB
         f9AETorppySNn1T9IG9O2SZin2vf6lxrfjbPyEnSWNcKrjGOB7fkCjJIUu5jJFn8pO3M
         w4bg==
X-Forwarded-Encrypted: i=1; AJvYcCXhK1ueerIK5MN2b5tnf7BcNRvX5cgH9tC/i/8nmDExCThlcZzATPEXYJJ+Cd2QFhuKvsGyuXUFkj4Lq5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIkwmrGEBGah3X13zFzWtBRs8Gs1JUbykZLxz5MrVLxFnGR0oj
	nR9Eto54LUloaQ/kd+247fF0NtPDJdg3IaG4PaXnRnjCs55Yzj7okXr2WSbrLYkOvvzmrGdqRIO
	abR8=
X-Google-Smtp-Source: AGHT+IG1m4qPjI+QqXPoM3f4N/A5UNKrK1vTMJmDpcSIgfw9T63TKvVVkYDriEN2bD5uYSXGJOhRMQ==
X-Received: by 2002:a05:6a00:4f85:b0:717:81b3:4c7a with SMTP id d2e1a72fcca58-719262060abmr22528974b3a.24.1726451189784;
        Sun, 15 Sep 2024 18:46:29 -0700 (PDT)
Received: from localhost.localdomain ([132.178.238.28])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71944adfa72sm2884129b3a.93.2024.09.15.18.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 18:46:29 -0700 (PDT)
From: "Everest K.C." <everestkc@everestkc.com.np>
To: gregkh@linuxfoundation.org,
	u.kleine-koenig@pengutronix.de
Cc: "Everest K.C." <everestkc@everestkc.com.np>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Fix spelling errors and codestyle in file drivers/usb/gadget/udc/m66592-udc.c
Date: Sun, 15 Sep 2024 19:45:07 -0600
Message-ID: <20240916014509.5871-1-everestkc@everestkc.com.np>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed spelling errors in error message and comments that
were reported by codespell as follows:
	unexpect  --> unexpected
	workaound --> workaround
Also, fixed codestyle error and  replaced a hardcoded function
name in a pr_err statement with __func__.

Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
---
 drivers/usb/gadget/udc/m66592-udc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/gadget/udc/m66592-udc.c b/drivers/usb/gadget/udc/m66592-udc.c
index bfaa5291e6c8..e0b261ff0828 100644
--- a/drivers/usb/gadget/udc/m66592-udc.c
+++ b/drivers/usb/gadget/udc/m66592-udc.c
@@ -110,7 +110,7 @@ static inline u16 control_reg_get_pid(struct m66592 *m66592, u16 pipenum)
 		offset = get_pipectr_addr(pipenum);
 		pid = m66592_read(m66592, offset) & M66592_PID;
 	} else
-		pr_err("unexpect pipe num (%d)\n", pipenum);
+		pr_err("unexpected pipe num (%d)\n", pipenum);
 
 	return pid;
 }
@@ -126,7 +126,7 @@ static inline void control_reg_set_pid(struct m66592 *m66592, u16 pipenum,
 		offset = get_pipectr_addr(pipenum);
 		m66592_mdfy(m66592, pid, M66592_PID, offset);
 	} else
-		pr_err("unexpect pipe num (%d)\n", pipenum);
+		pr_err("unexpected pipe num (%d)\n", pipenum);
 }
 
 static inline void pipe_start(struct m66592 *m66592, u16 pipenum)
@@ -155,7 +155,7 @@ static inline u16 control_reg_get(struct m66592 *m66592, u16 pipenum)
 		offset = get_pipectr_addr(pipenum);
 		ret = m66592_read(m66592, offset);
 	} else
-		pr_err("unexpect pipe num (%d)\n", pipenum);
+		pr_err("unexpected pipe num (%d)\n", pipenum);
 
 	return ret;
 }
@@ -172,7 +172,7 @@ static inline void control_reg_sqclr(struct m66592 *m66592, u16 pipenum)
 		offset = get_pipectr_addr(pipenum);
 		m66592_bset(m66592, M66592_SQCLR, offset);
 	} else
-		pr_err("unexpect pipe num(%d)\n", pipenum);
+		pr_err("unexpected pipe num(%d)\n", pipenum);
 }
 
 static inline int get_buffer_size(struct m66592 *m66592, u16 pipenum)
@@ -293,7 +293,7 @@ static void pipe_buffer_release(struct m66592 *m66592,
 		if (info->type == M66592_BULK)
 			m66592->bulk--;
 	} else
-		pr_err("ep_release: unexpect pipenum (%d)\n",
+		pr_err("ep_release: unexpected pipenum (%d)\n",
 				info->pipe);
 }
 
@@ -428,7 +428,7 @@ static int alloc_pipe_config(struct m66592_ep *ep,
 		counter = &m66592->isochronous;
 		break;
 	default:
-		pr_err("unexpect xfer type\n");
+		pr_err("unexpected xfer type\n");
 		return -EINVAL;
 	}
 	ep->type = info.type;
@@ -579,7 +579,7 @@ static void start_ep0(struct m66592_ep *ep, struct m66592_request *req)
 		control_end(ep->m66592, 0);
 		break;
 	default:
-		pr_err("start_ep0: unexpect ctsq(%x)\n", ctsq);
+		pr_err("%s: unexpected ctsq(%x)\n", __func__, ctsq);
 		break;
 	}
 }
@@ -599,7 +599,7 @@ static void init_controller(struct m66592 *m66592)
 		m66592_bclr(m66592, M66592_DPRPU, M66592_SYSCFG);
 		m66592_bset(m66592, M66592_USBE, M66592_SYSCFG);
 
-		/* This is a workaound for SH7722 2nd cut */
+		/* This is a workaround for SH7722 2nd cut */
 		m66592_bset(m66592, 0x8000, M66592_DVSTCTR);
 		m66592_bset(m66592, 0x1000, M66592_TESTMODE);
 		m66592_bclr(m66592, 0x8000, M66592_DVSTCTR);
@@ -1186,7 +1186,7 @@ __acquires(m66592->lock)
 		control_end(m66592, 0);
 		break;
 	default:
-		pr_err("ctrl_stage: unexpect ctsq(%x)\n", ctsq);
+		pr_err("ctrl_stage: unexpected ctsq(%x)\n", ctsq);
 		break;
 	}
 }
-- 
2.43.0


