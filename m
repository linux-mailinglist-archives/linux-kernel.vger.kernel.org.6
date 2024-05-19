Return-Path: <linux-kernel+bounces-183273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBD98C96B7
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 23:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88C62B20A86
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 21:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA4C6E602;
	Sun, 19 May 2024 21:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kg8dRbWs"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EEB15491
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 21:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716153385; cv=none; b=rS90CGC3T522J0r/d6NrT8+hq5fi5lCW78TgDtK0odcjG4jslmI/a/LFvcK9rxEaIFcO9HrnMRdMdRniuiUWCQNI9ZMOkGWyv08H0ZQ4FzqboICm98ULHeVpi7b5JxuzlTGMLlOHpi3Mi/8GjwLYRluMJ+EMGj002wbHxkpatk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716153385; c=relaxed/simple;
	bh=7G5O0pVNX6O64kNvrCRObeZruVYh1lO1jtt6i684H/0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=OXNWQ6M7pm5iixORcebf6wkYQhNxvTNMHgBdESy90aNCSc7pwQFbJUtNi6rYDZkDVIO2z/JO50R11SDRP+ocnHYhboyLcR9AQ79h7psVajmeo//l/1pJGOQMncxeFd1NFShvitkTq0uPoj8P2tr0wYUMvmAqd+sSv3LfYTNItss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kg8dRbWs; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a59c0a6415fso693641066b.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 14:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716153382; x=1716758182; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v7DSWcjLrtFO5GaTtTI45y7FSFiCS2MtpG3NKa8KpWg=;
        b=kg8dRbWsOdgAZ0XLllHRvvq/CP9ZkpqFrhoxily16Ti4Po7UPAAo2FNv0I8Z/y2qRD
         LsHc9rOXgRIofZozDvvMTAk9ILxzf8cTCH7fXNVcp1ZDlFGBr/0Iy+p5gS9n6mepyoA6
         lW9vbwjvuk0rjniVnz4Lqfqew7odRkP0l6lzGksrYzCx9+7TeMLo0I02bOrOdU7T2/WQ
         sRol5jGAaOVBynaD1HP//uS2n15dxbmvh0B4SVSBbXDikpAe5eFekCeksbHCrm70QBI5
         rNTO/zzSqK3kXVDEYlp7JhNk1kx/p5rYE+AWsYQrDgDo6WvKOjoJn4hvUmAVxxA71x4c
         xTpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716153382; x=1716758182;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v7DSWcjLrtFO5GaTtTI45y7FSFiCS2MtpG3NKa8KpWg=;
        b=YEJAPfzDIKfA9rBsMflx13edsmAhzdNNiO+afqHvBNsq0cK45/drjbOxjiIlX81udw
         ujgPWv+OvAGjcFm72gWJg2xvcla7ZrLTx15WpL3QvP0W6xYVKHmFhaxqcEyLQZCnRHXp
         JE4M/VDfxRQaUGDz5Zwd1kYZefeRpXwSeHaHD/v+l6CT7OvMMP3HI9Pvy4PQwEi2NuKm
         V8KzQtBF8meI+nVqtE4spOasXtkBGj4nGL18jdSMw/gho2fYeJTYxMoWvgvQx9yDnFVb
         QjwlC2XT59a+3zAfLxDYOTNcO3+QoEe1M26sOiZUQaKHh+5XZvH24e3stOTPk08m7kyJ
         GmiQ==
X-Gm-Message-State: AOJu0Yza9edM3ZQTnKe/uFrEStg5AraasB5gxUG2VoiE4MgSE7EPDwqu
	pmqnv19+cQx/o+W3TvHysGeAfAAKrNarN0pPvSqJacJUGkZeGebC8Rscus7mvkTBZEBhd3o/lc7
	/QlWsBRNMEKUowYS3naXu8/BmFOnkzLTu
X-Google-Smtp-Source: AGHT+IGuI2HtaaXoYABFhKsKa/QdCI2JIMBqKO9jADIxtOZB0QSLq9dUhtdgXyRuAhHB8YW8btddDi4pgiz/tSgGOQs=
X-Received: by 2002:a17:907:1b0b:b0:a59:a3ef:21eb with SMTP id
 a640c23a62f3a-a5a2d675b19mr2315813566b.73.1716153382117; Sun, 19 May 2024
 14:16:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Mon, 20 May 2024 07:16:10 +1000
Message-ID: <CAPM=9twvbtHFZ9O_-yXGSgnN5p8e2cHPcr1LzNDc_7w+VEAmAQ@mail.gmail.com>
Subject: [git pull] drm urgent (part 2) for 6.10-rc1
To: LKML <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, 
	"Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, 
	Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Here is Arunpravin's second fix for the buddy allocator warnings you
have been seeing, hopefully this is the end of that, and thanks for
your patience.

Regards,
Dave.

drm-next-2024-05-20:
drm urgent (the 2nd) for 6.10-rc1

buddy:
- fix WARN_ONs during force merge
The following changes since commit 431c590c3ab0469dfedad3a832fe73556396ee52:

  drm/tests: Add a unit test for range bias allocation (2024-05-16
12:50:14 +1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-next-2024-05-20

for you to fetch changes up to 5a5a10d9db77939a22e1d65fc0a4ba6b5d8f4fce:

  drm/buddy: Fix the warn on's during force merge (2024-05-20 06:42:12 +1000)

----------------------------------------------------------------
drm urgent (the 2nd) for 6.10-rc1

buddy:
- fix WARN_ONs during force merge

----------------------------------------------------------------
Arunpravin Paneer Selvam (1):
      drm/buddy: Fix the warn on's during force merge

 drivers/gpu/drm/drm_buddy.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

