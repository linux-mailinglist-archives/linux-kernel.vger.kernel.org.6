Return-Path: <linux-kernel+bounces-445437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C479F1669
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 20:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33D20188F839
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 19:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE691F12E6;
	Fri, 13 Dec 2024 19:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Cob+kDWt"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1800F1EF0A3
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 19:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734118558; cv=none; b=dvLMQOccqTheYh6E/p6qSv3tEH7Ge0fMdkmlLZQ9ayqrSdijal0S53g99JX/OPw5iDlGDTyDK2TWCQV/5BeaOCUSv+kOphah7tHLk8peY7w33aZJQQR/uiQNdwMOsMUnx+PNrfL4UIeBj3rJYMpPJNuKWr17dPcnUVPS7CiFp04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734118558; c=relaxed/simple;
	bh=AVG5onnfQvs8+iU6qz/Y4bR5+DooUuKWyTYlN50ctus=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=b0uZMeRz1otmFyZHrnVJTI2x6oUU3ajO2Uo3rn0qtNpzxLJ75RQWTX+mB+yDHNUZZbjwEjBZX5QnKum3f/RXrHGtqnAWFgediwzFAp9icfgTQiE/C6okGtXW3212ZZU0wX3ZVx0irV19upEvAbWMZW8wb/CWHnJZvpampo6Zu4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Cob+kDWt; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-385de9f789cso1643685f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 11:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734118553; x=1734723353; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ctb+O+QkBtTHayJps0vIwHU3lfYjoUBnA3ZC8GD97Y4=;
        b=Cob+kDWtaXth9ZptVg3K6gQmxBddSiMORZpMoJkMm8yxL+ggGRURg5JOrX6ds9i1tw
         cl9lz/kaGWtAfr1zeixrdPgMqBbyVB0DTFZP3CPvp7Tt9ORNJn5Tkxqamn67nchZO07V
         e2Ul3kgU7rnjar3n0LGGH683KRfQvepYoHMdSKf1SaqXKUUARxB4x1Rm25Ah4oqp7eWx
         PUpC/t3wKaWSiqL9Eqj6MLwe6Q1zN9xMbKHjAtN6MQLwcNcndggQzukL4ohFv3iw83Yw
         6fCFcil/FqPw22yh219wPURpF6qv0wlsS1NWPGq5kii7xF3hWzPOkqCzSHlNRQTGyYjy
         g5jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734118553; x=1734723353;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ctb+O+QkBtTHayJps0vIwHU3lfYjoUBnA3ZC8GD97Y4=;
        b=mjg0R5vTinF7f5Oie8qkIwULO5Blbxc1rHC7+glptHVNI6PVbXcJHs1Wa7LaFrYkaZ
         7H7UNKjo+hx4w2kKdAiEZYLrxrMqJZcAZ7Mt8yB6BkO7yySvnyFaN5Z98IAQzKIUf4QM
         Cv/BvU0Is2NDi2Xppf5ATT/kM0ehTAh5EC/4yIHFnVHffd+Ot523vgvb6k/f18Hf6IZd
         chWyMPgPyF+tjy28IcEa5H4OblaT05LRy5lXQi8/om3Nf0Laetqs7tsLt2EglU/r48h4
         MMZB6lZLhbdDg+A7s8dozl1XxZ7PAKi0zQyUJUtldhEUAgsCh8M3ueTNWG8+RRqkxiJk
         yZNg==
X-Forwarded-Encrypted: i=1; AJvYcCWEPAtWgHwnWnIA/qM7pNoBlScnq1TJ2m2a8gz7MeemUk+iLbJmDYbabTvZ+1polFDa/JZNdCKSRBmL8uc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz2MJ9cNVMLGac2IZkRWUg1bzrAqq5Z2kwJTAbKsogz4mA43VK
	dRarwlCoxDDKRaAfLnpGFNrnrNtULQ3KsG0VrGifItOxXqvh3elOzhKB3inr9EM=
X-Gm-Gg: ASbGncvFWkZJXZHr0TSn5ryHpECjzeQ3Hf5NZDAgpIYWPFn0VeRRFYLRFKO6Gy8tz2u
	iPQZPj2UnLeWSPBUrIoljkXw7IjugfT5yujZ/J8VT5gqp0wfr6ZbXDbpIWYxu9WYBE6lMKZ5p+m
	BUgTrEBOHWCsT0SAeaURKd5lTFlrZfKsQXOK3lbbr0u+xp6iYgBbrHtkWoKk93IaumSlkKP8EnF
	scdCioy9hW0Q6EBLmdjN80L6neWPflrCO0OdDlB+lxt9Q==
X-Google-Smtp-Source: AGHT+IHjdMefGKHq7odDuQp5K0uGGft5FyrGiSjextJXpxOKkRftrzI0f+kJplHZxP/JnFTXIcO6jA==
X-Received: by 2002:a05:6000:1848:b0:385:f6de:6266 with SMTP id ffacd0b85a97d-3888e0ae4e6mr2977730f8f.24.1734118553152;
        Fri, 13 Dec 2024 11:35:53 -0800 (PST)
Received: from localhost ([152.250.153.103])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918ac7789sm152833b3a.12.2024.12.13.11.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 11:35:52 -0800 (PST)
From: "Ricardo B. Marliere" <rbm@suse.com>
Date: Fri, 13 Dec 2024 16:35:05 -0300
Subject: [PATCH] tty: Make sysctl table const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241213-sysctl_const-tty-v1-1-2e2bcec77f85@suse.com>
X-B4-Tracking: v=1; b=H4sIAGiMXGcC/x3MSwqAMAwA0atI1hZs/eJVRMTGqAGp0hRRxLtbX
 L7FzANCnkmgTR7wdLLw7iJ0mgCuo1tI8RQNJjOFNjpXcguGbcDdSVAh3Kqqpxm1xSa3JcTs8DT
 z9S+7/n0/nukgwGIAAAA=
X-Change-ID: 20241213-sysctl_const-tty-67dfc1bc83b5
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: Luis Felipe Hernandez <luis.hernandez093@gmail.com>, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 "Ricardo B. Marliere" <rbm@suse.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1173; i=rbm@suse.com;
 h=from:subject:message-id; bh=AVG5onnfQvs8+iU6qz/Y4bR5+DooUuKWyTYlN50ctus=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBnXIyWHZTzHm7yH5zgHyyvbhxKU8Id5B6Hjry+8
 2OaNNtGspCJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ1yMlgAKCRDJC4p8Y4ZY
 prfTEACyu97TJZ4jkx+0JiRyhUTNs81Ae7GGz59jQApoLrV915+GoGugAls1k9x0bPhHphtfSxD
 jyLI9/FW0hzlTaQJC6rzAGURAtWJmKK/2fIEWJfcl7MssNThWkiUj4kpBKSbzJ0X01tEOfwjovi
 5n/CNRLvzEMOGatyA9qd/6rJAw0kv92KNp2j34Qu0/T1+yW8d87NYnnaoN1I91jET6LrFi/L2Ta
 YgXQ053Px41L84aFCBU0b13NXqRyn/YGzvWrqO557Pdp0b1razXdWT1Q4S9a8+BDum+M83xwuX4
 LWT1i5kQmPGFr+1LTgPydHhXFhxMRlGGRBt3fDL9fwk/H+XwTP1EYqvhxUXw63ISr+8SXc74Mot
 Pwl5hLG9tfcQNwVntICeDjVpSmmaHhyQRVdsRh5HHFXJKoAkePjUruielJpDRZ/KWVQ+oa+0J2Q
 INICj/pm6fiVpH7I/KNIlvlqxEYHjiUG2oscCSu4SPxyU57vWl5c/S8jFgtZBS9ji8IkdQHFUhf
 iogr9Iax03ZTBoNDGIpuLFVJmXpevmlt+mL+kkPIdLalaeU+DFYMj25RwIPJWTN9A1+Dq4y+d18
 dbTCSGq89Ry391vTl8KfZDbHS/D2jgrTfGqyk1Kfstd39+jYhRXf4in+rn1YamoPgHAkR+6UfaK
 KV+ezEFhEvZ1tYg==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 7abc9b53bd51 ("sysctl: allow registration of const struct
ctl_table"), the sysctl registration API allows for struct ctl_table to be
in read-only memory. Move tty_table to be declared at build time, instead
of having to be dynamically allocated at boot time.

Cc: Thomas Weißschuh <linux@weissschuh.net>
Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Ricardo B. Marliere <rbm@suse.com>
---
 drivers/tty/tty_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index dcb1769c3625cd0f7d1555260adfe6051139a305..0e84677712b4e1eb72f209c4d9c54a940b3a9041 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3618,7 +3618,7 @@ void console_sysfs_notify(void)
 		sysfs_notify(&consdev->kobj, NULL, "active");
 }
 
-static struct ctl_table tty_table[] = {
+static const struct ctl_table tty_table[] = {
 	{
 		.procname	= "legacy_tiocsti",
 		.data		= &tty_legacy_tiocsti,

---
base-commit: 535a07698b8b3e6f305673102d297262cae2360a
change-id: 20241213-sysctl_const-tty-67dfc1bc83b5

Best regards,
-- 
Ricardo B. Marliere <rbm@suse.com>


