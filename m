Return-Path: <linux-kernel+bounces-243682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC430929935
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 19:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75D6728153B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 17:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F1357CA6;
	Sun,  7 Jul 2024 17:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkS8l/eo"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4061F3FB96;
	Sun,  7 Jul 2024 17:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720374987; cv=none; b=YwBZaIWaQarQLbQ4xCcjluaan4xDpp2p8CVRi3RiaN+siyXRrG7HEvbbqqNrTa/3TkK+tYQvTw2kX2OENE6tVzlLv5H8zdYhr7/3JDu5KCquAg1Nl7OUE60PCIrcc5tWm4a3mB78JDktUoq94SgnNdBILRtBb8WkuxXIGe+v5MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720374987; c=relaxed/simple;
	bh=zqxRC/OCWtMYzBfgDiMrxFE0R1/qK2xdfC7+ctzGRKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jBniJ5ITFDBTQVXs78iIeGbLvI/1wLpxtD9yU5qnAsL3k4cnML0RtTlUQwRkSAgxQu0tJ++7lRTXHFQpHAK0Ut98Vws+V6Agva1WYkWWNRKiYcea7qKAiwqPgD8IhQ5gZTvJc/2IzrEdBL+oIjVX3koqW16K9RECSr3WR+GknOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DkS8l/eo; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4265ddc879aso9020115e9.0;
        Sun, 07 Jul 2024 10:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720374984; x=1720979784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iFovd2CBsLr5gf/in/j/bQ114RRO4t9SF/VVgwyJEPs=;
        b=DkS8l/eoLtZ36X6dno+ib+pyoVEvJ3FSzaRHi8ROV2SrJS0h96o2+uGm7VSFwSwCMQ
         i5S/Eaw0mJc6fNUwvx4j5m8kFqttanVzeP+CL9HsGAQRFIqdB5mnNutxgnUtgIrp1uO3
         sQKZnEmOeyMYIZfuMXjgQa9nMp5CdRxl4yD++EkaZ06cYAj3ki9cPsfg7lVOwryQoym4
         6QHSpVb1sklE6sdv+adUuQIJuw9Vdo6No+DQ15hHSZrNOmXTAygIudSArJhrAF/lmdH+
         YW5NvTRpvSzV8cJpNiQKYJFNiCRwFRLiXGETNsov9bAhSrhWfHVYeHVfeG5fmoAAQSCI
         i3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720374984; x=1720979784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iFovd2CBsLr5gf/in/j/bQ114RRO4t9SF/VVgwyJEPs=;
        b=tkXDp/F+OeJEs6a3f2/H7yVnBa26u25+ydJBuTXCoaPijyQZWZ2b98ahePglggWlDJ
         BVyAyTYU4e/zDRitMG8yhbK+kx3nEbdCOlswrnVZMH1s1/WG1dCuOFaiHWOK5U0yTiH2
         2DEeFSqst8KQG0rLNDYsdfwi2ON2RyNaYGV2JokR6g0ZBvwd44aMBLmLuSXgiXu60prb
         ySeYWSVm9s0QvEYHs2gkASTTgr2E0r7fZ93+9skKpLAq/1SBDDCGQK8iredTQrOQQxx1
         p5hHZzKpeicUcC5xchhQ6xSOaGYnumptrFKMRWZAyi5MFJUzkHqHrss+5zA+AsDx+17/
         W1Sg==
X-Forwarded-Encrypted: i=1; AJvYcCU0wOnwTBQKeXoIryN87r3CTS13SF2Lwb0y27777OHTJNB9rELrMQyZxXppn6TIuW43iaiPzF/f5/n087z2+L0nBTRGVN0HtrbWZvCz
X-Gm-Message-State: AOJu0Yyckbr12BEItKuXxTotUSv9mqnwhtRlUqypXH3OXYMf+P4cK1kO
	+/bxklzUN1ZQtL5n6asntQNkqbrAkI04mttfs25bdwnXbN5M7PU8
X-Google-Smtp-Source: AGHT+IGb1GhRm1vZcj8aUuS3EJE02jgDiPhrPJvQiEI+4bEFweCdI20pOMzoETgdSUFh/j5hTSE1iw==
X-Received: by 2002:a05:600c:19cf:b0:426:66fb:fcd6 with SMTP id 5b1f17b1804b1-42666fbfd5fmr10513615e9.3.1720374984470;
        Sun, 07 Jul 2024 10:56:24 -0700 (PDT)
Received: from localhost.localdomain ([2001:8a0:ed72:2800:17de:b512:9f9e:464b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a28355csm135562825e9.43.2024.07.07.10.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jul 2024 10:56:24 -0700 (PDT)
From: Carlos Ferreira <carlosmiguelferreira.2003@gmail.com>
To: hdegoede@redhat.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	carlosmiguelferreira.2003@gmail.com
Subject: [PATCH v3 0/1] HP: wmi: added support for 4 zone keyboard rgb
Date: Sun,  7 Jul 2024 18:54:53 +0100
Message-ID: <20240707175613.27529-1-carlosmiguelferreira.2003@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
As suggested, this driver now uses the multicolor led api.

Please note that for brightness, it takes the brightness files in
each zone and uses them as one as there is no per zone brightness
control, so all the files control the brightness of the entire keyboard.
Also, when the backlight toggle key is pressed it updates the brightness
on all the zones to avoid some edge case problems i ran into
where setting the same color more than once would set the brightness
to the previous value.

Please let me know if this is a good approach.

Carlos Ferreira (1):
  HP: wmi: added support for 4 zone keyboard rgb

 drivers/platform/x86/hp/hp-wmi.c | 248 +++++++++++++++++++++++++++++--
 1 file changed, 239 insertions(+), 9 deletions(-)

-- 
2.45.2


