Return-Path: <linux-kernel+bounces-331547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E542C97AE2F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 11:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4674B29EC9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 09:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC25517C7A5;
	Tue, 17 Sep 2024 09:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="x7adQPPx"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC3217921D
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 09:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726566403; cv=none; b=LnRiylbJFq7nx9o8onazu6HyIr6Pn3UBFyXUcbYzHxWz8V0P+WOVvrF4cKTqQMwyUg2RHSNQ4wFYjBAnGVvZe0vJmks3GILp+wXFKQJ//jRXgfHRDwFzPpXsKMfR9nKn0bfol42QVDUvI+p/moYbtqjrgO1T4kz+e3hEXVgoYtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726566403; c=relaxed/simple;
	bh=ZmYKhf4vmEW/E7NahV8giMLTGRkWMghWO0I0cUnqrVE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z01yol1JVRc4QMnN2jvYzI4E25LmRPtigosnHDZeKoT9EUMS8rgLh4lmlracNqEYlIjtBOoubR02Xfh8huUNgJ9P2yvW0g7Onz4pUhHLHHlKAjxlt4RrICmJhjyiPc7jErZXGIFF96KFbcVZ3CQPaExlXrdhG9uaZGBr0ey85mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=x7adQPPx; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8a7596b7dfso797177166b.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 02:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1726566362; x=1727171162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yjricXX/Ap/NeTWKCWeNSw+7TkReM6+VHnzcmIqkLpc=;
        b=x7adQPPx3acW3H0qiDpTRX+qzWXKxOaT2VqnO913x5Erlhbwtk8VrzKGkSWT91TepY
         DgW4x0IziY7kA5Xuo3Hqxivs3zSeWk7hTB3WOHIdX8+sR0yZ7bUTsWA/hs3eaBEf+IWJ
         glILV+Ik3Loz0gx2hWDi0J3926STnoC/IMidndOy55nRCHN6euig6mIrGsS0dOPrr58r
         H6bOesfnsh3rNX8rdkmFm0WrX1lxjVMp3aiXq1UJtQM/lLpJB5PAYRDrR8SGiWcfQesp
         uVM0ygziePaqBo08bD8GYrH0sIQZgZa/13clW898m2CuB65CvAZ5pZwEKySPY7nZjkAG
         bVCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726566362; x=1727171162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yjricXX/Ap/NeTWKCWeNSw+7TkReM6+VHnzcmIqkLpc=;
        b=M4Gum2yrrJ9f/CIdKdS6XK2PNsHDJ/NnfJ/FVW/olI+iHVTmccisQz5gyn5u5wVw/D
         b4YEKYGckrRAQ8UH3dInm7Q8KGMqpu5kKrJSZd86MGOvJqe/4RYkpOvs+20xaLnsiQxO
         KqsdikzRyxVj0+fUJLEzX4LGCCJFcQHtgFx4qRDAq1sM8zuILISufGaxGubQ68OooOfD
         zL9sqFVpp3StnitNqbYw7ryULtQYzq3rfqCV6w/C7g6PwY2pc1+2fF4vrx0rWdQE6vdK
         bN8cqS7J7/hFwSkylJIRBArVHJwQ+vevEcqXp5af6j/C+ukvm/5iTXEnxBLjgmFLp7YW
         q4CQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIeNH5+Su4m84FtSBIpijEiGwNzNG9TjN2dmpO6NlZ3ZE+F5nm849RZUxC/Fb9CCeWKBH2nWIvJOfvuDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgrePhyqaBzKEDVzMWRNt4FluMEWpoUe903J3YpnZ/omui4Lwo
	WBZaLu7SBQVOZrsQsvVe1PwvqKp+4LnnFyr2U3DNUk5/Mf4pboz0wFmEQAyrJt8=
X-Google-Smtp-Source: AGHT+IHh9SUBmZvohUs6HhszQ8imfPwPKRUtgNljAyYRO9S0wlPZQqsGye124tPbyjnLe8/wYTS5jA==
X-Received: by 2002:a17:906:6a01:b0:a8d:43c5:9a16 with SMTP id a640c23a62f3a-a902a3d6986mr2055463666b.6.1726566362219;
        Tue, 17 Sep 2024 02:46:02 -0700 (PDT)
Received: from brgl-uxlite.pool3009.local ([83.68.141.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610f42b1sm427516966b.46.2024.09.17.02.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 02:46:01 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] power sequencing updates for v6.12-rc1
Date: Tue, 17 Sep 2024 11:45:57 +0200
Message-ID: <20240917094557.6419-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Linus,

Please pull the following updates for the power sequencing subsystem.
There's one change adding support for a new PMU model and another adding
documentation for the subsystem which probably should have been part of
the initial commit but better late than never.

Details are in the signed tag.

Thanks,
Bartosz Golaszewski

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-updates-for-v6.12-rc1

for you to fetch changes up to 8b7e0a6c443e855374a426dcdfd0a19912d70df3:

  Documentation: add a driver API doc for the power sequencing subsystem (2024-08-22 15:29:29 +0200)

----------------------------------------------------------------
power sequencing updates for v6.12-rc1

- add support for the new PMU variant inside the WCN6855 chipset
- add documentation for the subsystem

----------------------------------------------------------------
Bartosz Golaszewski (1):
      Documentation: add a driver API doc for the power sequencing subsystem

Konrad Dybcio (1):
      power: sequencing: qcom-wcn: add support for the WCN6855 PMU

 Documentation/driver-api/index.rst         |  1 +
 Documentation/driver-api/pwrseq.rst        | 95 ++++++++++++++++++++++++++++++
 MAINTAINERS                                |  1 +
 drivers/power/sequencing/pwrseq-qcom-wcn.c | 11 ++++
 4 files changed, 108 insertions(+)
 create mode 100644 Documentation/driver-api/pwrseq.rst

