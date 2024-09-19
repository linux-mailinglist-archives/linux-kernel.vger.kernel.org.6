Return-Path: <linux-kernel+bounces-333800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9A897CE44
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 21:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D578E2850F1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 19:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8786A022;
	Thu, 19 Sep 2024 19:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2fLlKPJ"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A51F73514
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 19:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726775574; cv=none; b=F3+lF4AAQkl0fXei6lsgtlYOaknfjAGmhLa6opjpiwR0VGYf95eNHTe62iSnT2OHU61xYAYuTg70CtEbVjNJQzxGGLS+1zp6FaWvij+nPZ49AYl/EFFLKoJDyh1E80rXgJNYH1zxgH4KNVOMg2totu40+r0fSsEBAwYWPQBuYAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726775574; c=relaxed/simple;
	bh=NZ6G/VtUATX8ekNTFJRo4bx4oZRkid/ResYLhskkwl4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R5pnDoJb/Vh5668/3B9yGWsmIMrqy0Fqe5EWX2FCIJ3ClU6vQnuu8eUp6AaBRL+GNnbTcgZ8j9z+b/CsePDITfVNAckY2MBEoOMEohceDcq6ox8CDPoX4APR2HNVZlCNLxstmuYB10g49+vXyDTMPHFqLQdbZcY/GhQsGzJk9IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2fLlKPJ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cb58d810eso14984655e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 12:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726775571; x=1727380371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5gZ+1I4rq1yzW0JMGbPByU2NI2LeuSKH1Kjd88ewoH4=;
        b=W2fLlKPJ9aK3zuq9WU8YyY+9Ld8iuzl02vEiXMGaMDVkEloY5NjfC4LNnzP0SQt/Na
         151y95luX8h4IOFDOPDFLHTjnTcNV2rgm6ujx4GABOtKaFQWKM4uleufAvt3Sir2ibhm
         3U7MgK9OPW0nfJiJkAeZvvWmfAhVSji0EGMm3k5XP5FzHLGjDsf3i/sdQzFVbVoM8UmO
         y/U81i5RXc+H4EgmqywzCAsx4gSkNywjFx3YfpxqruofaggBNMeB7toGVcH8f/ZqUs1r
         60R1WxOi0vLr8mqMQGVsffKkr/5/mZsBd0W4zR5lHfQRLXZwdYa+LXcTXOJM4mo/+TFP
         PjeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726775571; x=1727380371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5gZ+1I4rq1yzW0JMGbPByU2NI2LeuSKH1Kjd88ewoH4=;
        b=rB3awPaxFj9BSwTv9iNkl6QOughL9XM50nykFLZBes1xuGLA4HfJD7JPAPc48accl5
         2WTxEGx2bEZmREB0/4sTREfzMjlNO90TpeH7TB46DWO/aiD4llr9wg27rWRydTFvuMkk
         MzzsgSDjryEXQd9kLTgnLjSyTHiEMkbfakVXkG3lO2JshB5rFGtVAJFDaGWyYlgyrh+Q
         YAbohp9brFqsJ+7qILXROMzDbc067uXx9FgVA8yBGdqEXMWWNcByOqpY94tQhyEtrLwh
         xJVHIenFBg1yW5n0nncD9/7/NdtKeAA6X83UNW44n40ewNY4WCys5ssdtubbnDxBN/vh
         rZCA==
X-Gm-Message-State: AOJu0Yw4rke/zN6OhJbUvWRjsiY8eSADORkZI/1FZC7ZVoLazbzf6oeh
	bzNX1jOuKIuSPDlZJXlusxvvZcHiEjE6wsWM5QVisVQWkP/CayRF
X-Google-Smtp-Source: AGHT+IGnCWFWCodgYb4a5kyWuvrq9MjJ0l5xatqlj7q5XlP8Am1NxAJzmf5cdRemY+BFX6oJrUoJFg==
X-Received: by 2002:adf:e348:0:b0:374:c79d:5f7e with SMTP id ffacd0b85a97d-379a860b6f9mr2381500f8f.26.1726775571252;
        Thu, 19 Sep 2024 12:52:51 -0700 (PDT)
Received: from gi4n-KLVL-WXX9.. ([2a01:e11:5400:7400:42fd:1678:5874:1467])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e780455csm15843085f8f.93.2024.09.19.12.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 12:52:50 -0700 (PDT)
From: Gianfranco Trad <gianf.trad@gmail.com>
To: jack@suse.com
Cc: linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	Gianfranco Trad <gianf.trad@gmail.com>,
	syzbot+8901c4560b7ab5c2f9df@syzkaller.appspotmail.com
Subject: [PATCH] udf: fix uninit-value use in udf_get_fileshortad
Date: Thu, 19 Sep 2024 21:52:27 +0200
Message-ID: <20240919195227.412583-1-gianf.trad@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot reported a udf uninit-value use in udf_get_fileshortad[1].
The uninit-value use occurs when udf_get_fileshortad is called
with alen having a negative value and epos->offset being equal
to epos->bh->b_size. This check was inserted to mitigate
the uninit-value use. After applying the patch reproducer did
not trigget any issue[2].

[1] https://syzkaller.appspot.com/bug?extid=8901c4560b7ab5c2f9df
[2] https://syzkaller.appspot.com/x/log.txt?x=133ab69f980000

Reported-by: syzbot+8901c4560b7ab5c2f9df@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=8901c4560b7ab5c2f9df
Tested-by: syzbot+8901c4560b7ab5c2f9df@syzkaller.appspotmail.com
Signed-off-by: Gianfranco Trad <gianf.trad@gmail.com>
---
 fs/udf/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 4726a4d014b6..d21665164779 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -2222,6 +2222,8 @@ int8_t udf_current_aext(struct inode *inode, struct extent_position *epos,
 
 	switch (iinfo->i_alloc_type) {
 	case ICBTAG_FLAG_AD_SHORT:
+		if (unlikely(alen < 0 && epos->offset == epos->bh->b_size))
+			return -1;
 		sad = udf_get_fileshortad(ptr, alen, &epos->offset, inc);
 		if (!sad)
 			return -1;
-- 
2.43.0


