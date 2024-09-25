Return-Path: <linux-kernel+bounces-337939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16550985137
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 05:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 471901C2354D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 03:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140871494B0;
	Wed, 25 Sep 2024 03:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKlkb+4e"
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808EB12D75C
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 03:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727233665; cv=none; b=in9C9cIY98XLR8MDvXvzT8CBHeoWGMTxSUdO8QhCO69FsR//d+6RN7wvWHHYy4GpuCxmQrPxrAnzj7SSwqo9gRViNStAZXYG0CWUOPpfKJTStLjZoWy/An2aSIjI4bxFNtmAGvocB9yNQZWeXnprQ74bDrVLDAJ0ivo9fpt7IPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727233665; c=relaxed/simple;
	bh=4fPZFq9GucltM9qF4rscl7ftDfoWZ+wWMtPS0pSK47E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uye9TCEMXzbQjiQgX93nSaS+MfSdFl/9DAFdfd+SAMo54LVV3qsw/QlL9ajKxzfIkIP+5mScx/DJLgn9iznoqZQWlUdfzzBdZJRYUxiEW/oS6qCABCsNKvg0vjS98baebZeeUslnzxNihFjb19cKaxa9L8WPkmJCPVBb7q/vg7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=uc.cl; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WKlkb+4e; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=uc.cl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-846cc83c3c4so1755833241.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 20:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727233662; x=1727838462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=EYpCc4I8glQ7ck+nhqJAvbOoAL+loG6airV9nPgLSA0=;
        b=WKlkb+4e+Pk4yVN52/7YbCR501iva8g/S0fUY7c621HEt4LLjU5CNKQvz2v17SDo+V
         bliUWBbg7+JhXWFgPViTo2YFTs5krGwgdN3YlFOkgujGHLwAajiEP9GjfC+ByrMbu+59
         EzaabimgM0ocPS4ZnfrhIQd8RwF45chQYPo+oKxedb0c9mx8AiZH/j1ig0D4xaiolh0d
         ekPmMv57GvZpB1/5ZP6Io7qNk1KtQcWB4MzinV7043A0GYAMB81dAaWDnHYNSDR1hv8M
         7sODv4Pm3Dw3ahXmwvePYg88XiYmCYfDKR+sroSVO23PvmQo3H1v9RYunQpcRQxJVnYQ
         iC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727233662; x=1727838462;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EYpCc4I8glQ7ck+nhqJAvbOoAL+loG6airV9nPgLSA0=;
        b=bQgYF2261UssFmKrzwBn4D/XFExJGieYeQt85aBMuK+Lup2Q/56j9YqmbUNDDHcwKz
         BExp+KuM94E7UbgCYCDugIcMgXqJD2G4eyo7rPCe9dk3PwES9aHhweKWulKfgzTBDcSc
         uiYbJocoqi8qoBktj1vzB5AuVKA4F9PLlunOnzIhHl66Sp53yM7hNVVImOtflhVM0Nz2
         crG1G+r9EC/wn4W2Qt3UKdclLC3wsoZlZLgpmkHF7XC1I1dAaH3L1EgpXZz29uAFEx38
         qabgiuJcgjZpgyioar83DhW1q0+mvPhRECrQd2SdiN8OB4hodT4uECEwyqQSb6wJt/B8
         1/sg==
X-Forwarded-Encrypted: i=1; AJvYcCWqN9thvL994NIjwlpMaDgibVE+KQCkztxuiAYDPdMXBs9t99kh/Mmb3bBEnp2CHC8YpluS0s6AItjmCgE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9Dm7ac1AXdxvD8iJbCvyCHJBJEADTc4EyA2YCLE31AGDahFHZ
	uXY1tqNlyKXWRRqyISVGgb0WRQdpiZlhD2JG7jIiZ7YIK1GjmzNe
X-Google-Smtp-Source: AGHT+IGHX3YR1tSYTG2yld904TImUX4Wt8i0FOff6GYl4zX2IlhtyXZHmm+gjvhabOxGdIUccbGoNA==
X-Received: by 2002:a05:6102:c11:b0:49b:c5df:ced6 with SMTP id ada2fe7eead31-4a15dc958c9mr1771357137.10.1727233662222;
        Tue, 24 Sep 2024 20:07:42 -0700 (PDT)
Received: from lenovoKubuntu.. ([2800:150:11c:b79:f1b0:792c:c69:ad52])
        by smtp.googlemail.com with ESMTPSA id a1e0cc1a2514c-84e73d22f77sm1272575241.33.2024.09.24.20.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 20:07:41 -0700 (PDT)
Sender: =?UTF-8?Q?Hans_Peter_M=C3=B6ller?= <hmoller@gmail.com>
From: Hans P Moller <hmoller@uc.cl>
To: tiwai@suse.com,
	perex@perex.cz,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Cc: Hans P Moller <hmoller@uc.cl>
Subject: [PATCH] ALSA: line6: add hw monitor volume control to POD HD500X
Date: Wed, 25 Sep 2024 00:05:54 -0300
Message-ID: <20240925030554.31829-1-hmoller@uc.cl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add hw monitor volume control for POD HD500X. This is done adding
LINE6_CAP_HWMON_CTL to the capabilities

Signed-off-by: Hans P. Moller <hmoller@uc.cl>
---
 sound/usb/line6/podhd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/line6/podhd.c b/sound/usb/line6/podhd.c
index ffd8c157a281..70de08635f54 100644
--- a/sound/usb/line6/podhd.c
+++ b/sound/usb/line6/podhd.c
@@ -507,7 +507,7 @@ static const struct line6_properties podhd_properties_table[] = {
 	[LINE6_PODHD500X] = {
 		.id = "PODHD500X",
 		.name = "POD HD500X",
-		.capabilities	= LINE6_CAP_CONTROL
+		.capabilities	= LINE6_CAP_CONTROL | LINE6_CAP_HWMON_CTL
 				| LINE6_CAP_PCM | LINE6_CAP_HWMON,
 		.altsetting = 1,
 		.ep_ctrl_r = 0x81,
-- 
2.43.0


