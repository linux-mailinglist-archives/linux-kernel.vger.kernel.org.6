Return-Path: <linux-kernel+bounces-421855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD6B9D90FB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 05:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35F9CB26176
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 04:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6AE77F1B;
	Tue, 26 Nov 2024 04:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQQ2IydN"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EAC2107;
	Tue, 26 Nov 2024 04:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732594705; cv=none; b=bbsOgHOYmlYHcifWg6p3DGVJhnHrE/AmP0iS2cUL5/UoNfn0nFvMMERMxJ64KR8LBfmlqZ0f+86sThlH9nUa3wEOkS5L7xRkQzMoqJKTQHQ4SObzk7j6lVDyooHkMbYCq7UEbGQPnN1J+nhCZR2eoHcO8iWoadEmT0mcVUGEq0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732594705; c=relaxed/simple;
	bh=oRM0HsFTk2wU7HvCLDT6Pa5hXmoyMl0puEFlGUmMJyM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LoDziP0y1xwjZWMb+oMrFLoSp8rNGiXZUNf85RKABdga8AT/PrteS1O+ICTRtQ5MSzOyjt5/KkPob6KtffHGqh9VrVLFOh+/P/DlRzmKr7vF+o5V5mCWSCcXZD6PtVGs4zgoeWJSZiIM1YABhi4qnCcP0kXiS+uthyyKSEHMHS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQQ2IydN; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3ea3cc9a5ddso1143088b6e.3;
        Mon, 25 Nov 2024 20:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732594702; x=1733199502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=lSDE9com4R7x0vADv5rq1zwIlnAyk6rKDwmzqFciQVE=;
        b=YQQ2IydNZi0j4QwwjY8qIL/LY7hoPBhVwPkrKVvadLrk48PiCcjHh6i3nFpN4sfHbL
         aITIzAckJtsMjkc0UbmqgMcwcxi3bAXe3AZhJ13rnkPEUpHhl6WH0eBv0r062+4e9PJd
         tOk62F/IIH4KhMIgoJNna0tWjOhYu35zKud0eZbxd9g6niuJX+gzRwkS3NrhcHJNuCEM
         oQwtI48D/e67QZg4PPVlJgrUOlFzrNW8YhTXOo3iVgjoGNpRIRDjIMDFmvqr9na/lNPo
         m2k3nyoJ2E6Y5OMKA/sjPEWtRyo6sh2ciLgAvu18jDf5Rzv2LJP3FElFyj55Fa7z9fcZ
         NhFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732594702; x=1733199502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSDE9com4R7x0vADv5rq1zwIlnAyk6rKDwmzqFciQVE=;
        b=LoQaJIcYpZ301aneX9F1W0gwfL1IfGUNahAZqU1bP/QYwZe8dCiJ3i5qWGaxv9lNQ+
         sBuqtYErmT97/UVKT7XmE0IeeNEsLRRS5ibKb+6rN4qNnVyeUNNhDIYZUKqFiMdScs5X
         syceGok2k00E8MEWxYqj85VtuW9kHd4fVwtfrNH7wxs4PG9tuKR1zwZbK8b6lygxxPvs
         +lXK+x+LKEA5l6wus69gytpOvrlu9hyLNIiTU4JdXzEVaoIDxUh0+ljAVSFIzN/r3sVi
         Y0NdD7wFE7zX9cAWJo7dzNqp/q1gsnDOaxu3evym1Lwpqnpc3vPIECq8wVytFD3CnY8Z
         ba3g==
X-Forwarded-Encrypted: i=1; AJvYcCVbsoaYsLtZhkdCODv20uW00U6vvGHaN9ZKYthikL/d5zrihF/2XRAu9Jye3J7odmFXr0BecfOqKocE1z0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2fiyXjTPAuyGXv3ulyDR9IIajEexEOhZJCYQOnUF5MkcjGMt4
	JIY1wZd+n2mnIVYBgkX6sjxePZYw5IaFBbv/ohKghfXakEayMLQTUwT+Fw==
X-Gm-Gg: ASbGncv1daPrM//qWqfMLgerLAw2cRTBE2YkquXBcx6wnp8iwtWPwg+eSq666j81LTp
	XxtL4M8UrWU531HirWh6Y/hY5CfITgMtfJiwVbDlfpIS0BU4nU0pf+kjLQ+irFZJcR01zDfj39x
	al7WV2tsWZHZttgHV6TJef++V7ZtRDlASnH2oOatzV6EeYbFOBfIZ1KIqzwieu/wI7mtu/R8NS3
	c6BHIFjl0yKyaPrybWfgbX90HdTeWgGqgroTOOjPbDQlJ/kcPqMCyu2zuKcVao=
X-Google-Smtp-Source: AGHT+IGH3QP1vr1ATj0dpTi1qcaFjNCXKQSq7paSS5U4BWl9rBzN+7PAYRfr3lsM5NlVOCJ64/XKCw==
X-Received: by 2002:a05:6808:23c3:b0:3e6:3860:596b with SMTP id 5614622812f47-3e9157ab4abmr16562123b6e.8.1732594702488;
        Mon, 25 Nov 2024 20:18:22 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de53c05csm7334985b3a.98.2024.11.25.20.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 20:18:21 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v6.13-rc1 (take 2)
Date: Mon, 25 Nov 2024 20:18:20 -0800
Message-ID: <20241126041820.1054214-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull hwmon fixes for Linux v6.13-rc1 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.13-rc1-take2

Thanks,
Guenter
------

The following changes since commit 228a1157fb9fec47eb135b51c0202b574e079ebf:

  Merge tag '6.13-rc-part1-SMB3-client-fixes' of git://git.samba.org/sfrench/cifs-2.6 (2024-11-22 21:54:14 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v6.13-rc1-take2

for you to fetch changes up to 998b5a78a9ce1cc4378e7281e4ea310e37596170:

  hwmon: (aquacomputer_d5next) Fix length of speed_input array (2024-11-24 07:36:47 -0800)

----------------------------------------------------------------
hwmon fixes for v6.13-rc1 (take 2)

Three fixes for v6.13-rc1

- aquacomputer_d5next: Fix length of speed_input array

- tps23861: Fix reporting of negative temperatures

- tmp108: Do not fail in I3C probe when I3C regmap is a module

----------------------------------------------------------------
Aleksa Savic (1):
      hwmon: (aquacomputer_d5next) Fix length of speed_input array

Jarkko Nikula (1):
      hwmon: (tmp108) Do not fail in I3C probe when I3C regmap is a module

Murad Masimov (1):
      hwmon: (tps23861) Fix reporting of negative temperatures

 drivers/hwmon/aquacomputer_d5next.c | 2 +-
 drivers/hwmon/tmp108.c              | 5 -----
 drivers/hwmon/tps23861.c            | 2 +-
 3 files changed, 2 insertions(+), 7 deletions(-)

