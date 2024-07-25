Return-Path: <linux-kernel+bounces-261936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4AF93BE02
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 10:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0DBE1F21743
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 08:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4889317623A;
	Thu, 25 Jul 2024 08:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="1nZXEOgt"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022C8172BB1
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 08:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721896381; cv=none; b=fRY1el6ZJ1HmD/3zT+me9T0c0EI64qnkWOqGGuMKk09boTnqbnPFTW+y1dU3rORboiX1hNDnhewIM2OQPoxcJ5fw9pQTmJ26Jdj4UtKSnKBYuT80QcUJTfCA/CdsuU8yxEVhjqhrhtorp8onTlPHj+8cAhcc2k6Rpu5oKlMg9jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721896381; c=relaxed/simple;
	bh=OJl20vm6Vc4udxJOVCzLs1UYtPTRZP8GQLwnGzw6P54=;
	h=From:To:Cc:Subject:Date:Message-Id; b=cBNhZDe/paiYx1P9kOMQBd4uf6t54tQ1jKUYGBG5b553V2gsE0YaQhNZpCJJQP2c101WlaSU2i4+YuRn047DfGwsCanQTz7IaG4mCI0GQO5bxZ0iREm6ZkxyjjTEA8lfMTKbuvSXknImyQ8FLngE+J+mrgCPikHmyx254unqHQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=1nZXEOgt; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fed72d23a7so4282225ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 01:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1721896379; x=1722501179; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fLpK4IsZZXZzigL8BlyMfcfMZdXZGh61R5/l1I9Kec4=;
        b=1nZXEOgte9JKFP8ZbsBta9GjSlm23+zBGcbLn/9nV3rZ9YjUOOR7e0rupr5Zt2jkqm
         PfW+JG9mNVCt8mlOZqK45i1vpCSJcUyB/szK0c9Mov0dKLOSDrcxQiYGxIVvnWEsSm6r
         rhLWqKR2iWud03BCwN6SYk71hArcyKTJ4+gcZppoURF26F0lmhFcNIaHm93V7b1ftJPQ
         StxvuVT5PqVzEK3M9hPyCz0a0BroSL2HHy64UboqsTrIjjSDox+0/g+H9JnsWRL/MSCV
         GDtMBVXN+yGokYBvHTd+DK9hDnaR1sDOeUc3e5Cb9hrHxlJQPMsQCcexgVYYx6gXMwks
         NvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721896379; x=1722501179;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fLpK4IsZZXZzigL8BlyMfcfMZdXZGh61R5/l1I9Kec4=;
        b=gq2mgkKrWOegCmaNjwCYTqYEzYcWBgp3gh6e/EJY+qOc4/sCewamHHpfAE1J0Q3Ukc
         rMt4590TWYc7MDhCx2CU0SN7VwBss1ZnG+1KkfauLgADK1AHAeuGrYwbca+DVLSI0KNF
         PPtTiGvb33zk0u1UGV1gqGbP6JU3P2L9viMpXmIloFTfU1BPLe9jrFNTwNu7bmcbrpyx
         E3AEqGOf7qyD7YW9MRwbfiv2tRijhi6MpGYl2rE/yInIrdUO7eLcINPfxjEqxozfJo8Z
         IXm5QzfpQ1xhdlUwmdcfNCRtNQNi7PZbKIcKEMrnlK/OQa32Is4uQ20tLLDsG9nPuWfT
         jDTQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4aTSJ0j09xZZKHSOI8Zeh5qL1KTEX7BSCgoKYUeqVrWlwX+mF4iZh5ZddmO26TjR0FiiOY+42ggRV5DwIZ9d8fJOQ7K9g8NlDO/+s
X-Gm-Message-State: AOJu0YwVyf+ncXo9x+RKd92W+Rsm5d1Ha11YwImaoz7myRv9QDBpjfx0
	E8Wua0DhyMhQoYxD/6pnqRZi1pg01AEQzuRIC7niiqgugGO78Jwh7geX9zjSt1o=
X-Google-Smtp-Source: AGHT+IHy/fBf1qd+/nEshN4ReuVn5u49Z5q+4pzr0GkT9vCyfTYvvnbpFYFwUsXuej3/QfbhLNvy9w==
X-Received: by 2002:a17:902:d507:b0:1fd:ae10:7246 with SMTP id d9443c01a7336-1fed923f5d3mr12268465ad.5.1721896379132;
        Thu, 25 Jul 2024 01:32:59 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ff9086sm8595595ad.302.2024.07.25.01.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 01:32:58 -0700 (PDT)
From: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
To: neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	dianders@chromium.org,
	hsinyi@google.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	jagan@edgeble.ai
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: [PATCH v1 0/2] Modify the method of sending 11/29 commands
Date: Thu, 25 Jul 2024 16:32:43 +0800
Message-Id: <20240725083245.12253-1-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This 11/29 command needs to be sent in LP mode, so move 11/29 command
to the init() function.

Modify the Melfas panel init code to satisfy the gamma value of 2.2.

Zhaoxiong Lv (2):
  drm/panel: jd9365da: Move the sending location of the 11/29 command
  drm/panel: jd9365da: Modify the init code of Melfas

 .../gpu/drm/panel/panel-jadard-jd9365da-h3.c  | 137 +++++++++---------
 1 file changed, 71 insertions(+), 66 deletions(-)

-- 
2.17.1


