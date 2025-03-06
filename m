Return-Path: <linux-kernel+bounces-548827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17431A549C5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE6B53B4BA3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9122116F0;
	Thu,  6 Mar 2025 11:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xWTDk3TK"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E1521147B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 11:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741260959; cv=none; b=o2bpV/zQ9qyR9MeVEHq54pOegMqpaLnfiMtRTgYTp469HK8PvISYYIzEFPgI34H14vgjsFRlGNw9xBYN2FviNTIf6RJ0pZ5OedaXgaGXGn4LhYG70TtlRoM5FWKihKYkBLFe97fMhA+hND+MEm4sr6vn6lcG9bBb0blLJkbzAj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741260959; c=relaxed/simple;
	bh=wE0XHXR6nqEKsVcSdvuh0LfsQm3Tu2aGta4ii19Feok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fUu5opMxiwFzRifprWpYthBrpYzvJ+TkTy8l9i6IXn+svdsOGihwWPmdAKzyCxbVCl31IlvapC91TfqYcJjLQJwfzgIlZBI0d6rRbRBFNPv+0qXmhCPnxHkEkuzwOv8u2tUGQ3JY5B3Br9IukguX1trFRPk0AE++DqPsOMPC05M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xWTDk3TK; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30bb184ab24so4647121fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 03:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741260956; x=1741865756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=koqRd4APX0wnsxAaTRkwWjS/3ijbfY8HBfEo6EAo4wU=;
        b=xWTDk3TKz3GnHtcy080IguR1Eb/ygXROmKK5J8g2WYtTk4Onukr+ZtxNfEMXN8a8LD
         PbJI25KWCSwDJWJZUut7f13If0afa7I+bEv5e4dM6J4l/7pHVj0eSUb0DEicdIiiUMFZ
         MSZoEyK7bXtl/JSgPqKqAeNKaFcDb/JATe1REqOlIh+I/LVzuSUuZ8gaUDp2LoN30tF5
         CZbIXos3IbHR9RB/4xW2Y1MfhTZGHr5RvJjPIhK3I70CDSk220qcnbHUGPH+LokMFs20
         DfCgfYq9DzHn7+VHSMxgxj7yr/bQ9oWf4FtsCggN+6tWToTyZUUlmgaYR9iRdI3MUp7G
         mtOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741260956; x=1741865756;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=koqRd4APX0wnsxAaTRkwWjS/3ijbfY8HBfEo6EAo4wU=;
        b=B3bLyJ5JEfHDhBCezrs5rkzRxRg6jNLWXNTR/6sIaG4DAbVgA8buth2zqAAKUtq1K1
         GUtPCFjiaaTWVSrllYpvANIGyOlaIC67enTbnUUn/6QJAXkQ6MY4H/41kT/XVRCJAUGn
         78L6otWUqTmSnajI665MJS1g4kSvKPYPxC44UF3Vb106SJll8A+lNtieRRs9W7jYldwN
         i+CKBfFV4D5YNdU+zum+Jzfdphxlafjmv/NxTRNZpKjxwZF5ETJzHymBjW232CEFXhV1
         SheCQTGqp072jwq+IKSWLuIF3uPyTpNxCElLCzWwwDv5sIexJoJhvI/TflWCtHChhSDz
         DHqA==
X-Forwarded-Encrypted: i=1; AJvYcCXo1rYRm73Akqd+RLkD0c+ZRsK71/9+7CEM/cuHuck6lB9yYqLaUESr6Re+jrhkGqP/EQY1u8+PRN/FaHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwraiWLvOj6VsUyLTAhMFfYBW2tw2Cy7ovL3uNRg67N9wK8+UoI
	jJR8z2GtNIgtPFyMUKDKy6Lpjq7m+NwxziqH4ObD1DDMyMZzohva/SIyZ6sFmPw=
X-Gm-Gg: ASbGncvSLsqmzaIDH81yOpo6JxaqX2F8jdJrLDBg2u9HU0Hw6IiCQqHdiSV/EgFAhGf
	MTicgw/PAmTWZ8w1zBjrtuK6zK/W4GjVFpIxrzxPxh+q3Y6+Zw7LRyOwN9BuxO/hYDMFvg/HOBd
	cJmz9ayZpYK1SmBip9gK7YqWjLZnnrU5vgBXXgJKM1476yRP5rwQV4RPPDm5a0SYG9n7N9Ji1z/
	BSqAyiJ67EJ78BobROnJWh1Fqd2jnog6GOO21IRmyy4KYuVy1P7/NMcvheDKzLfz/ZNtj3DSwTe
	c6v2CC1O0syhSYFkdrfBbFDCs/H2hGgCC6WYGkqDyBenUk2FQtrF5TtN4dMBsu6felkGjZhaAPX
	xRtyb7W3pz1BNIdmw7GY=
X-Google-Smtp-Source: AGHT+IGvhVCvrTJYtOe0f5Z+wlP8TVv9YwPwB9pxjrMJLEmfXqGPhLQZUmk5FXV48QUWuIm1wY6nnw==
X-Received: by 2002:a2e:964d:0:b0:30b:d656:1485 with SMTP id 38308e7fff4ca-30bd7b1c8abmr21290181fa.32.1741260955997;
        Thu, 06 Mar 2025 03:35:55 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30be9918086sm1809511fa.54.2025.03.06.03.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 03:35:55 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] PM: s2idle: A couple of minor lock-simplifications
Date: Thu,  6 Mar 2025 12:35:39 +0100
Message-ID: <20250306113549.796524-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While working on s2idle a few things caught my attention when looking
closer in the code in the s2idle_enter(), in regards to locks. These two
patches tries to improve the situation a bit.

Kind regards
Ulf Hansson

Ulf Hansson (2):
  PM: s2idle: Drop redundant locks when entering s2idle
  PM: s2idle: Avoid holding the s2idle_lock when calling
    pm_wakeup_pending()

 kernel/power/suspend.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

-- 
2.43.0


