Return-Path: <linux-kernel+bounces-190369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C508CFD60
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 905EAB22563
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F53413A86B;
	Mon, 27 May 2024 09:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNjN9+8W"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236362232A
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 09:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716803149; cv=none; b=qEFygPPnzxTAYjx9rgya1LxK47xfEFnOtwtgsOddIf0NcMU/sQPZ3W+Fj5K+Ods3dwwoi/Hr1HBiC0qClNG+vCklZ2fizooQXsBfIrJmn1hhDp3KmL17yuSULk2mw6J/jqLvb/uaejZcKlUCazKy79wgfs8J5uK6lzyoCxvWATQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716803149; c=relaxed/simple;
	bh=cBVp7Eifp7yDkONw50FbDLe9jRStO/EOErIG9jhddpo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OT0OyVNlqL/WBY8GCu5tM+xEl2xLZ0NIjOO6jo/qCC/tKS1M7vaFOhBVKFK20md0AIF1dRb5Lt4jRQeSFfcdK/z6vw8jWUmXvxje3UqIvA8i5ePlIR9rsRfVNN0KKjaixbAuGDf/HKhk3t6Rfs2Tg9DTJebm0KwBDyVCLY6ooFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dNjN9+8W; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57822392a0dso8110278a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 02:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716803146; x=1717407946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+jJQAZCfqqzKp/yT4Fe8nzJklXty4v0i4TpeOod95No=;
        b=dNjN9+8WAQfGG8zD2o3d2wrxeYkuXGwM6GmBZNZAy8tACYZwAi1gM3XImV/qAOc3+i
         FHPaues8w+pw4hO1X8eXQAUqDo76xvxVuYOiQ9aj4VHnK1MgReb6JoX7Hqrjp0D5xp88
         5UKw5MNqr2nt5rphXiVIRkOn9oKWHvsvwj2PKaPi7Je1wpeCifQPKxQnOSU7rdnjEN6t
         1SKf040p64m6U3JfL9erlr2P7Let7UjyypQJGzFSDnbp5oc9hLPZskmNPC7fwIWXkzBX
         d7xALu/R6MxYwEm0yS6/EttZz4z+c76MwY2UkijG+/zfdM7pTDbLf4vG17pdPcN3kFwj
         cCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716803146; x=1717407946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+jJQAZCfqqzKp/yT4Fe8nzJklXty4v0i4TpeOod95No=;
        b=j+IiH4PIkQrzuC7LzZ8iXgNp0qUjuYi1UttrO7T1yGw2+963D8v7hJyCRarb6XPblI
         hGHE5TkTr/NA9JGXWvUXRleS7+EbxMUtC896Gd5q5Aw2JiZDIPz7AalXvqEhJHSwtKe2
         0tLVc9vZ66BSZe2Ox5RD4MQi66utvJJ4zjtc0LaTcAUrcicUL9U1YMZZ2+W3E2xRH4pG
         VuLw6iLTTs/hPKBmIyXXdUNEPsCsN847SehacMEMBA0LMCUOcE6v+xzX5Hzww+j3aFHq
         teUEbPIoOfhZqwgftvccnyQX5LaDqzRKETzjEBZ/bBt4R7UA0klQTDv/SH8c3B85gzlB
         MYOA==
X-Forwarded-Encrypted: i=1; AJvYcCWQD/EWp4tx0EiHGYZ27ialvrFfDIfi9f3mv4GIJp7JOF5BiHp3tuqiGGoUjx1mzYDC+e+Zs+jXKOx4TIXTqVqKFF5sSX0Q0J63TGbg
X-Gm-Message-State: AOJu0YzNiAiYbErkZXq8V2ksTd47aqUdOnCH+Lh6KghjY3Wf0RlzYV52
	U1MGzPbSiSgDzSc5GEGgJdNkrDy6SxuwSQ+SgTmaAL6xwfr3RydW
X-Google-Smtp-Source: AGHT+IEj3c842/5ft9ggGZPWNRE5Uh6s2O92WQgTQa2GXAvGXatkoz3IByBSlddnC3LBVgPOKO2w1Q==
X-Received: by 2002:a50:9e6d:0:b0:572:9dbf:1de5 with SMTP id 4fb4d7f45d1cf-578519ba565mr4991060a12.40.1716803146254;
        Mon, 27 May 2024 02:45:46 -0700 (PDT)
Received: from localhost.localdomain (ip-77-25-34-87.web.vodafone.de. [77.25.34.87])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-579c6c72ed3sm2304178a12.87.2024.05.27.02.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 02:45:45 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: philipp.g.hortmann@gmail.com,
	namcao@linutronix.de,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 0/2] staging: rtl8192e: some refactoring
Date: Mon, 27 May 2024 11:45:25 +0200
Message-ID: <20240527094527.2046-1-straube.linux@gmail.com>
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

v1 -> v2
- Removed patch 3/3
- Added Nam Cao's reviewed-by tags from v1

Michael Straube (2):
  staging: rtl8192e: reduce indentation level
  staging: rtl8192e: remove unnecessary line breaks

 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 160 ++++++++++-----------
 1 file changed, 77 insertions(+), 83 deletions(-)

-- 
2.45.1


