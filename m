Return-Path: <linux-kernel+bounces-316056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D494896CA8C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 00:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91C49283BC0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 22:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5B61714B2;
	Wed,  4 Sep 2024 22:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MuZHFgBC"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10841154458
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 22:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725489466; cv=none; b=NZRAEAVPFC5qBM7l1ZDTRBr7hyIgFe4r7OOs+ZIPHrTSFZA0hjUdml6af6r1E7kID3rp3nU8+Z9emQvuTU91cJ+WPQ3tM6YWeC96mbp1DHNs8tUYsJvtcnU2qv9Lw5MTGYuyVBru7asVI+LMKgWxDpu/kUUunuS3MVzCfJ8lbOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725489466; c=relaxed/simple;
	bh=55A94q2uIAcfHQgoZ/TQhxg4Fzdi8TDEazEFMyc1W5A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ghtnYUHk4LLYQAqIGn89UAcZKHh44EVeymGEdB9nnIBvU4jmKTvbf7o8otsl9Hg57NJ+RhnMZCCsEm0WdiETblzQ1ssyX933h4rKMO8QN1kOK8wKXeIPyW3szNE36APUrfPN8fbjQxvgGcho/wMor0peZp7XY7bt7SLeqLbzG80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MuZHFgBC; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7d4fb78fe49so188030a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 15:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725489464; x=1726094264; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RJz5BwpSqcmwVPAPNTz8F/kb5jxfiYrhQSyjUval4vU=;
        b=MuZHFgBCW5tiOMSm55oIfDMAKpFY1G04PuM6Z0A2F2BmFWLUzlR1S5Upag+bAXSnxN
         LAOxiyOV/8klXE9h3w+hR+w1kLmr4qjannobKetV3CElzSuwY2b5pKJYaHHGQfNsAlEp
         AQDYeENRUquUtZeqCD1Sf5gKqj6pzVG62q3bi0z2oNvzavSZUrJ4eyT6PaMX2xnB88S3
         sHofkEGQFQC3LBr/5yNCwugZ9ORWEh8Wod72bQtNU8Po8pp36lfvXQr9K1S1BZY53v61
         /0VCj+XW++m+bsU7CB4Tr9UiUnmm6Jini+idXnwBXZcJC0HQCrsjbdDxyMSA11tqvnWS
         SInw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725489464; x=1726094264;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RJz5BwpSqcmwVPAPNTz8F/kb5jxfiYrhQSyjUval4vU=;
        b=C0ITiBngLJq69lNByeP2EixAyHzW4DKxqL5oKdZPcuqtBKQEmjHwXn5we6hVAOx4O6
         MeZR2JKjbhSeqh3wwXAZxth/Lj4wIDXZtD2x0RbrRoCFhZMQMflzsv+WG8dSB2URYYr+
         tZNUmfQx2NbYsLMoJv9EIOjuaj3qrsbi3Shx5VmlywMUdzWHDF9UqaDfF3/SoSyn4l+T
         +CkIyKOc3JcVuy3RXRjkXRggbKbkP2ru8rFcaem2ASy+tAQ++ScyxlH/0TRS5jDkzRH6
         33Z6/VdKSs5vVp+mbb9uyyup5yIExrecwjEJ9jmHgufgWiuhWIWb2/doucDq5KubIN5/
         +gKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbfTPZJSM66qBrT1ZwrcMA2xbcbcYWwpEsKafXxjdnz46+1VBHBpdRVO4fFjZUBnzAzjbgTn6DYnJ1O6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCmIS0GMAUsAd8egioJLvk8VL49IkpC3M/1cjWGqYbqFkKip3V
	DetwcMagw4JYfBuMOB0v0MPqzU4/d+fLhf8XOH5w/T/YmetdbYb9TY1/62Z5MqOMUuW7GEpTn97
	l4DmpoA45uw==
X-Google-Smtp-Source: AGHT+IEbQZx8pfGo0dd1GOt1EE/7QtgONM5C6dGvw9uuv3rMZhCVuCHQAKlzk+8/yDYc8HAhZ4IJhcArEBy9QQ==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:ef:85c8:ac13:4138])
 (user=ipylypiv job=sendgmr) by 2002:a63:6302:0:b0:75b:fd10:a196 with SMTP id
 41be03b00d2f7-7d4c10182e2mr45024a12.1.1725489463168; Wed, 04 Sep 2024
 15:37:43 -0700 (PDT)
Date: Wed,  4 Sep 2024 22:37:27 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240904223727.1149294-1-ipylypiv@google.com>
Subject: [PATCH] ata: libata-eh: Clear scsicmd->result when setting SAM_STAT_CHECK_CONDITION
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

commit 24aeebbf8ea9 ("scsi: ata: libata: Change ata_eh_request_sense() to
not set CHECK_CONDITION") changed the way how SAM_STAT_CHECK_CONDITION is
set. Assignment "scmd->result = SAM_STAT_CHECK_CONDITION;" was replaced by
set_status_byte() which does not clear the scsicmd->result.

By not clearing the scsicmd->result we end up in a state where both
the DID_TIME_OUT host byte and the SAM_STAT_CHECK_CONDITION status
bytes are set.

The DID_TIME_OUT host byte is getting set a part of error handling:

ata_qc_complete()
    ata_qc_schedule_eh()
        blk_abort_request()
            WRITE_ONCE(req->deadline, jiffies);

blk_mq_timeout_work()
    blk_mq_check_expired()
        blk_mq_rq_timed_out()
	    req->q->mq_ops->timeout() / scsi_timeout()
                set_host_byte(scmd, DID_TIME_OUT);

Having the host byte set to DID_TIME_OUT for a command that didn't timeout
is confusing. Let's bring the old behavior back by setting scmd->result to
SAM_STAT_CHECK_CONDITION.

Fixes: 24aeebbf8ea9 ("scsi: ata: libata: Change ata_eh_request_sense() to not set CHECK_CONDITION")
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/ata/libata-eh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 214b935c2ced..4927b40e782f 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1605,7 +1605,7 @@ static unsigned int ata_eh_analyze_tf(struct ata_queued_cmd *qc)
 		 */
 		if (!(qc->flags & ATA_QCFLAG_SENSE_VALID) &&
 		    (stat & ATA_SENSE) && ata_eh_request_sense(qc))
-			set_status_byte(qc->scsicmd, SAM_STAT_CHECK_CONDITION);
+			qc->scsicmd->result = SAM_STAT_CHECK_CONDITION;
 		if (err & ATA_ICRC)
 			qc->err_mask |= AC_ERR_ATA_BUS;
 		if (err & (ATA_UNC | ATA_AMNF))
-- 
2.46.0.469.g59c65b2a67-goog


