Return-Path: <linux-kernel+bounces-189720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0549B8CF40F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 13:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D89CE281D9D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 11:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25594D266;
	Sun, 26 May 2024 11:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dl9jj5lx"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DD19454
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 11:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716722446; cv=none; b=HK7aYaPNCrtYmfK3R1HaEz1n7JXuiVZ1iwJG/xx372zrkVoGNJQHBlYvS1+0a5GE5cc2fBjZwGvSbuEJ65C6pnO6sGyoj5O7dpE68nchy1FME9dnx4rbKFhP90/XKwuo4a+hQMk9R5gQO/QPkbUyuybhPqdOITg86Da7W28vcBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716722446; c=relaxed/simple;
	bh=+QyzVB+hF/W0F7duXYUqSZVzerWLK56Lq1XaLySrJfU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LSdhM7US5D9YxPpzNet647LF3JdYm5r9ACUGUVddS/FevPRmnTOujLxRtXpvzR/leghdf7OFm/vuAPOBp6uNTWWWUs/zwmXTbd7MiP9gFc+ekDB3NRAuvzcRBlUhq6nwuID8St990GhvUk87ayaLnIcOgHmqq57nE6yecflvQaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dl9jj5lx; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5789733769dso1456116a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 04:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716722443; x=1717327243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kOnZ78TgB4Zxh2HcKouq8wUbppxd3i0KcEghV6k4HzI=;
        b=dl9jj5lxoZvQOiEez8c2Dj3JfNujfzH3EG9mqGeZA9LDWSMhEbQ/WQN0GKYPnzpNoG
         joMceJUWYsV8NLLa/K2KBdlUxgRLRUivneyvKpd76Oog/3tmecxtucBCie3t9esexK2w
         VkW/bPsEHc2xDmJs+6KR7ePNF2QoXXqflJB08HhcfvmCuybhwucPnWAjzGxzCWaO2pPL
         J4ZTIUnugdax1VzTXneu0dSXQkrDrdya9qyuwX8mMx1mXUYTzd1p+A6U+kjMi1H09IrK
         pcCPDU3iqtol/eqWOAYy42R1fJ0ym5QMipG03+XvfBhJiLXOMJF/9p9lpQWvNNrjDTnC
         RA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716722443; x=1717327243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kOnZ78TgB4Zxh2HcKouq8wUbppxd3i0KcEghV6k4HzI=;
        b=utChO4F5L/HQUcRlyOdD349cfwmr4Xg3TRDFyLKvrXBbTRNLKYp7tQg9WtmGTdXoLP
         miD8JHTZatxJIJkKC0sq18TKUwdsSgpPUmUcPX8YXxsFwoleQg6daJYjycID/Yal5sx0
         t5g5wYegoOjynDtOXrzy4deZla0U7AudipYr43z1th5zgOrPW0NmnRfFnjKazxb4Tbnz
         z3lYLCv3PCplFQJ9F5E5xCAHDiPA+9D4y7uGdRVsE5Cr5ZrIdd73wu0raO0yi0x5qJGc
         wNUu6G2yApwtKXjfmQovrAVO1uENIKeA1blqG6WRE0xsWss3HhlHCsQg73mmugbd72Sb
         wN0g==
X-Forwarded-Encrypted: i=1; AJvYcCUhNCkQdwmyppDN4FwpT2fHgwwzKaOK701IYpV9QV1xQqAEaTxunvSaN1sPOXhO4pqHcBu+n5zjoO/cB87YO57ffKkCnJFh8VrLkrsC
X-Gm-Message-State: AOJu0YxarBixentdCYbJ7NhM1KSxAEBAQPtXg+ziK/SBpyPqKVX5/Lda
	G5iqCoQaWrf6TuGJ3zZTxpN2+In0ry8dXa71GnZE9R0aXaocfWS7
X-Google-Smtp-Source: AGHT+IH+8lftp06Xp7fZ3kAF6+csz1iu2s5FwfpZw54pP2vg0ijtiylT487UVwvIvD3zFKQKlZfsxg==
X-Received: by 2002:a17:906:f0c3:b0:a59:9ed5:eefc with SMTP id a640c23a62f3a-a6262b14494mr583538466b.32.1716722443159;
        Sun, 26 May 2024 04:20:43 -0700 (PDT)
Received: from localhost.localdomain (ip-77-25-34-87.web.vodafone.de. [77.25.34.87])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc8e534sm373983366b.170.2024.05.26.04.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 04:20:42 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: philipp.g.hortmann@gmail.com,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/3] staging: rtl8192e: some refactoring
Date: Sun, 26 May 2024 13:19:25 +0200
Message-ID: <20240526111928.14574-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series refactors two for loops in _rtl92e_dm_rx_path_sel_byrssi()
to reduce indentation and improve readability.

Compile-tested only, due to lack of hardware.

Michael Straube (3):
  staging: rtl8192e: reduce indentation level
  staging: rtl8192e: remove unnecessary line breaks
  staging: rtl8192e: remove dead code

 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 154 ++++++++++-----------
 1 file changed, 71 insertions(+), 83 deletions(-)

-- 
2.45.1


