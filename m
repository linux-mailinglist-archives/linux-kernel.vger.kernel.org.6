Return-Path: <linux-kernel+bounces-330193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E86D2979ABD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 07:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60D34B2235A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 05:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E145C481AA;
	Mon, 16 Sep 2024 05:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b="ZPp1wIzE"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8853A4437F
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 05:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726464316; cv=none; b=FbY/IlvT1wfJ+FaSYcVF/OF0YSHjTxLW6F/GmDn38Z61/oFUdKrWD0ANi+bS4oE/1AnmlyUUtLEzs/E8up5PnO0+D3uxwhYcosG4dNOJK1ywZN2LiUZOXyeSCjQMhEEuRMkl/xPSGPrO7rbobvMY7DEIjbmj6Uk9gNe2RzwJFNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726464316; c=relaxed/simple;
	bh=9PL0KJkREBXZCsZeUMZCiVV9MTdg3kNhpdgdTCTbBVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQKZox+P7/0JcVPTesUX6k2uajLLx7AnRqPTAtwdIx9R1+T7ReK9vwriGmsZzio0/WFLrF1xeVcBAJLpYLzUX6eS7KtoDGL5CBSXKeHqPwzTjlVntaXzt4JtkY9pYgN/mEpDisqYauDOULoWhPzYT/job1dZu9AIZ2JC3JrTNto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=everestkc.com.np; spf=none smtp.mailfrom=everestkc.com.np; dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b=ZPp1wIzE; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=everestkc.com.np
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-207115e3056so35889955ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 22:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc-com-np.20230601.gappssmtp.com; s=20230601; t=1726464314; x=1727069114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LuSOh5erKMKm0kXqVEy8c5VHv8IQUs4PbHs0ClPNTXk=;
        b=ZPp1wIzEQaj6a7MHF6tfZdM4RHOaYYdfJcL1OUBW69/jbn2pe29vCqu4f4BeuwpKOt
         4zszxipGgqlYGJpEXyUMMqIrx096FeZdG3CicilWFWnFPf3TXVyMrry7TF0h+wnxIMbW
         D3VbMsFaFwaw4A81pGJ9ZQLswalGjWjdbCnDOEf7F0DVY/DajFPBmXm62WzA5n+B+cod
         +gX2nN/webFRpQ48S4a+UWqRVHSgSMGpCpnETGtM/UZLfKqMEyE9VGK1hWI6yxsl6A+p
         InfQuapNmOCFRuRycRMTIqeaZIDXDVtmnUfWVm/cuf6PLKaX1kPVJ8vDO6wkN61PadNE
         6v4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726464314; x=1727069114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LuSOh5erKMKm0kXqVEy8c5VHv8IQUs4PbHs0ClPNTXk=;
        b=nU2rYfG49GP+BRpPG61XPBetT1Fk2ikNSBkJsQM7RUeZCvmEYHLCMqcLFh3bWzlHN8
         bEkQY32xjDOFkjnMYmW/xrawaPXpcNiplcC5wy8GNpeA4dzxsK6KQN3nDcfptIoBF2kz
         Gn+XgomOqMoZgRNOo2g4+m0dkSjSP7ebYDExSZonQsKmg+XL80V6Ifr9woRdEgeXx2sR
         UPQCOXxiy84bt9RH0E81N0w1UgJ3XETpSOEECa3TtfN6618JSQ0bNlXfHKuscy1H2fBQ
         iCGHnBPoFH1xmw8+DUjJLJ69D4cYf93NHRSvlXgQdIAlQJjflHWFpB4UArfMH8faXa5+
         ixzg==
X-Forwarded-Encrypted: i=1; AJvYcCUNOhLjeNt2XeM2jvJ+mVzyst0pPi7yofKC5sT6xvho7IjPBL9OoA6uT9azalcZABnLit+12Z43yB9r1mw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJNWtcpOzM7vUVo9Q51RiBs499xxAj3fylw0oLJI38jyiwbHb6
	1PUyvWw6CYw2kmtFGl9n+qq8ej9RVFLnKRKUYs9ibmG9y6RKTRfBvcOoI2AMdq+jU7oXOBBbPkv
	tXNw=
X-Google-Smtp-Source: AGHT+IHmQ63E/FEOpoDXOeA0lDDGe6ISeVicf0+BYH3UfBDH+OXq+7L1AczokPEJBRu4wR99+sU0NQ==
X-Received: by 2002:a17:903:11ce:b0:1f7:26f:9185 with SMTP id d9443c01a7336-2076e36a649mr238332795ad.10.1726464313734;
        Sun, 15 Sep 2024 22:25:13 -0700 (PDT)
Received: from localhost.localdomain ([132.178.238.28])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-207946f3558sm29624865ad.183.2024.09.15.22.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 22:25:13 -0700 (PDT)
From: "Everest K.C." <everestkc@everestkc.com.np>
To: gregkh@linuxfoundation.org,
	u.kleine-koenig@pengutronix.de
Cc: "Everest K.C." <everestkc@everestkc.com.np>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] Fix spelling errors in file drivers/usb/gadget/udc/m66592-udc.c
Date: Sun, 15 Sep 2024 23:23:56 -0600
Message-ID: <20240916052357.6487-1-everestkc@everestkc.com.np>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024091626-trailside-grandkid-5f86@gregkh>
References: <2024091626-trailside-grandkid-5f86@gregkh>
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

Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
---
 v1 --> v2: Removed the coding style fix. This patch now only
	    fixes spelling errors. The coding style will be fixed
	    in a separate patch. 

 drivers/usb/gadget/udc/m66592-udc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/gadget/udc/m66592-udc.c b/drivers/usb/gadget/udc/m66592-udc.c
index bfaa5291e6c8..c5e68caaac8d 100644
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
+		pr_err("start_ep0: unexpected ctsq(%x)\n", ctsq);
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


