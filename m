Return-Path: <linux-kernel+bounces-550730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D36A5635B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9322F170831
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9350E1DE3C3;
	Fri,  7 Mar 2025 09:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6uFzcDh"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1201C84CC
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 09:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741338941; cv=none; b=ccrbV66LudRu1A0EV/EPpKWDxom9rONmgR7l7FwK435hmGlXtQZ0gSti+VwmIjaFNSZJ5vC5ablcCeQdXOF2vWDIKyAMbVRTkH96lLt6t9cAVNqJO4DYSTcN7e1T9YglQU/xfhoqUq2eVJPBhjsouD88IaE1K6b0BR/0mGVQ4Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741338941; c=relaxed/simple;
	bh=HKN2O1xXxM8jWfR/wKOnCMm8qNfVtd3/gRDNhwp4vBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LYX5mUYb+96vHm4DCAPiuwyVefFPZvtw3TVegPsjZmMR5XRd4bUdIKjofriw95fWJbd41z68z83vdO6MSpBgXPQzprRzn/GBLCVIaV0e9oPt/z7k0ZlVJYlNE1l4FlGZiWn1K+feJo894mqomlk3HZiCZ0sOn5tJi7gjdSwcPmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6uFzcDh; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2239c066347so28950595ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 01:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741338939; x=1741943739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sHBKKzshGSI6hL7EG6ZIvM89MIwiECzUbfWIxwk2NAc=;
        b=g6uFzcDhYAGMye4VbsO15PP81cy3IY3D+Ju/ZSti2DFop6pyQAYzvo6bFdbTYJNCwW
         RCjQqITiFBVU7ILf28l+3FmEs7bJMAHvo/Wu2IBJN4bwhgFkTPxN1Vo2VgvPeCJaUj+z
         Igd3Ffa/IW2wtn+55ginbc3LHBhpDsCRTGEYNS8RtY3X9xzZ141qJw/wYnCSAa6aZfa3
         7vFHqbkaPXSWEqD9Vf/1JGb5HjItPVCuPRO9E3vQdQmlSTUcgbVt/vU/4DNK8MiQK2Ik
         ss8nvWZbwKTqgDZMZs7F7sAdeqe6rZ0F85ufVq0b6HVI+TGzQbz2fPIhWHEq7Pqsro3Q
         xIhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741338939; x=1741943739;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sHBKKzshGSI6hL7EG6ZIvM89MIwiECzUbfWIxwk2NAc=;
        b=dcNnXOlvHq84TGdjO/pJeWD5CsqhtR/YUJ5ZWtcJfv/UjbKSXX/6L+1IvJIxtGXn+I
         vrXgNcfCnXzPOI+yLP0+TzZqSfRw2fGmDTK7WvFThQEdLZg+i75uJMsA4hB+9SBSuZ2z
         Kd/njb4Imkxmzqr9zYZfdO70zIdd9u6OK2bR1WGLLXQLvIZ/aFZzlAz4lWwfU2P1jA9I
         UZZ2Fk0prg6MTWrUHml10/QBLinWvzmUOu1lusP680IO7RhcoUlK99a30jXPatu4tNP9
         23uqPQUDzSAa9HNHmoOVrJncdDhOqZHjpqpQ1CUprNZrqXGj6l87cRfxuEN3CkK4bUg/
         Ekbg==
X-Forwarded-Encrypted: i=1; AJvYcCXE5jIUIcihQ/Gzq1z2wb3ywYIL5eWVQ0Mw2RGSFxlk8GVe/qQ0Y3tNZsYV1Pci3zCB6coYnhqRuGcLJBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcSYpPp2oXRttYy+4hMDcRAG59RB+0J2XiJvhxYMwZoTQW5LK9
	thFUydUxg7xwIVDbIFFa0h0yclhc/xJzfFVWQA3ogOExztAoAXPd
X-Gm-Gg: ASbGnct4yml0P1AsD/vjVYFDWfGcGZQsj+az6anqnh7Am/nDdzH7cYz2nQskq/pOcwR
	v34YbycAC832lyecWeVpEmQm1OVG9uG0TS/TJoaEtyC8p7jHbxS/mvhK0NHUQAJ8D/CCAczqUtf
	mRT+JnMsTYI5c73JdVw8CwLBLehnMRebuzUPos+dNUZN9UodAgFZ4q21o8oJFf1AfQCQ+D+KNYh
	yep3tdVbP5zPXU2Q3VaIc6EyNKgKw3QgIbTN7IYSb2B7CC1R31lZ8AVCYg44/8ygmtgIif0s+US
	GTV5r5e78Ux94wKK4EY8Ug26UK7iMEanTXeQnEo7t2M1Ttfp0M0TkRIWHQV/zTY=
X-Google-Smtp-Source: AGHT+IEec9pMlf2KOix/XihNQ581VxoPi3BNtjWLThoyon10QS1gS+pBOn8m3CutqsgYTli9zMzUIA==
X-Received: by 2002:a17:902:d48c:b0:223:5de7:6c81 with SMTP id d9443c01a7336-22428aa193bmr42571825ad.27.1741338938941;
        Fri, 07 Mar 2025 01:15:38 -0800 (PST)
Received: from distilledx.SRMIST.EDU.IN ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109de11asm25563985ad.31.2025.03.07.01.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 01:15:38 -0800 (PST)
From: Tejas Vipin <tejasvipin76@gmail.com>
To: neil.armstrong@linaro.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	lujianhua000@gmail.com
Cc: quic_jesszhan@quicinc.com,
	dianders@chromium.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	asrivats@redhat.com,
	Tejas Vipin <tejasvipin76@gmail.com>
Subject: [PATCH v2 0/2] Add mipi_dsi_dual_msleep and use multi functions in novatek-nt36523
Date: Fri,  7 Mar 2025 14:45:17 +0530
Message-ID: <20250307091519.245889-1-tejasvipin76@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduces mipi_dsi_dual_msleep to be used with double-DSI panels and
converts novatek-nt36523 to use multi style functions including
mipi_dsi_dual_msleep. In this process, minor changes to
novatek-nt36523's behavior are introduced.

Tejas Vipin (2):
  drm/mipi-dsi: Add mipi_dsi_dual_msleep
  drm/panel: novatek-nt36523: transition to mipi_dsi wrapped functions

 drivers/gpu/drm/panel/panel-novatek-nt36523.c | 1681 ++++++++---------
 include/drm/drm_mipi_dsi.h                    |    6 +
 2 files changed, 827 insertions(+), 860 deletions(-)

-- 
2.48.1


