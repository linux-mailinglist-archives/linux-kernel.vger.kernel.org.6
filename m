Return-Path: <linux-kernel+bounces-226916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 482AB9145A5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F15791F22369
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 09:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795EC745E2;
	Mon, 24 Jun 2024 09:01:21 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE92487A9
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 09:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719219681; cv=none; b=HLod2yJr734kZ36onxQ4lK+Rhx7CdKwDhxMocg0GKl+YS/iB5kwSNXBAln6GTcyVMrmvZveWZ1oSmUDgyiQ7/6rbg40rtjnf7vfEXYPfWL8oYItaap8lPskJCP25HD6A4aTDcKtJYZa86DFAdrxibI4YJbM2X62vxHQrrb/QYYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719219681; c=relaxed/simple;
	bh=d99tIHQnO/8OXPAT68JhsrpTyXi5rLW63FZY6p9jHC4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i1pyCoO9LMFQbe66EtRa0hOUM2WH6fobt9Am7uKJ5yLh32R1Y7oalZE8+ytcsy1+djH2joLJOtEP8pJSdwj5FwgmLuOeQyT6LPF2UQib5iV6rF8LS+iUk7fz9W2zJluWi8ejQpiyOk2Nsd2h4dGwISoG3iQu5i/HYzr1E8Sy0iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57d26a4ee65so3717811a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 02:01:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719219678; x=1719824478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2d7FuBNzOfxIXFIDGywIIPXtSjvFIdXGhYIMU66nk4o=;
        b=LcPvaZEXzyB5o4KWawOUamqCAk/aXYgi3glaEcwL7R0/2sJbmCsLQ21IDAICtiVaMm
         6Kjr+ccKFXNJr6wP4uKJ+RoBdAQ3lrExA3Ppwx4CapNsXiIvSNSDx2a8cTbVNoqka1G2
         9o2YQuDMPvv1o0wZ80eMiBxXKTwO45g1CfhY1Lcmq1ikb6bTu9f7E/gdLTo3jGPEKmDZ
         vFtOD/nJ0lrlLpKaQh+J8on3sm1yDnDTMQL7nvRXwNNAAZxBj0FVRdD+eNejMGnjs44c
         VQHMzeSIDIoe/hjGXf54uWUoF37F6ZwN26Ov/x54x4Uf2xX8lDta7/ANcaBMYsH76G+B
         krjA==
X-Gm-Message-State: AOJu0Yx5CHbXBuQx6CygItOSm40JYQfbs1xzcmju9Q5r8m9GSn952EXd
	kcFlMtUhii3rEqo49n/Fa+1FuIRTURNLLcHHsRf8Y2AEu3/1KnmqxCJwLg==
X-Google-Smtp-Source: AGHT+IHr2Xa+71DyF9TpU+hmWOhDJ16ohPsbXEqt8nSL14qmj/Rk5JRJZGZMk9DhQrMTMs8J5/i4kA==
X-Received: by 2002:a17:906:7f90:b0:a6f:57f1:cebb with SMTP id a640c23a62f3a-a7242da6ac6mr250396166b.50.1719219677545;
        Mon, 24 Jun 2024 02:01:17 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f7415600fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f741:5600:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a724162f037sm225997666b.194.2024.06.24.02.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 02:01:16 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH 0/1] mcb update for 6.11
Date: Mon, 24 Jun 2024 11:01:03 +0200
Message-ID: <20240624090104.12871-1-jth@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg,

here is one update for mcb I've collected for 6.11 from David removing an
unused structure.

Dr. David Alan Gilbert (1):
  mcb: remove unused struct 'mcb_parse_priv'

 drivers/mcb/mcb-parse.c | 5 -----
 1 file changed, 5 deletions(-)

-- 
2.43.0


