Return-Path: <linux-kernel+bounces-309281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1B5966879
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 19:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 683B81F24754
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524971BBBF8;
	Fri, 30 Aug 2024 17:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTi7wFDm"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301751BBBCA;
	Fri, 30 Aug 2024 17:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725040541; cv=none; b=mKNSArAbDSYS7NtbmrI1XFN+rGNG9cQGqJLC8SyGgSL17Of1VfZFwIPBVxArxDR+tSOKwZaXQnaJ20i/HbmdG6WNltfnPYNiaqxC7CsXk1pFvfCOuYkjUV8fDKWIblFhHzZovvS+UfC2w4ZrEX/kbDpcsomjFv8NxIcV4me5xPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725040541; c=relaxed/simple;
	bh=P8Os9iGKKE8AqW4YXSOE3zMpcGDQthfWpQeEccij78A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aW4tiX4uWlmAxTbKdoUeWJcGz2UcW2R/NtbkXvYG9LsiA6HLY7j6660KK5uVA/xO2qJarfGYu1js581WUu04zdp5VxDx8wv25GpIFpU2OeGFSbtGod+m2I8ZvEjIpg7Nwa99MgjFcPyQqsTU1sreu9tUWAucelmciPk1QTgY2i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTi7wFDm; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-39d47a9ffb9so7830355ab.1;
        Fri, 30 Aug 2024 10:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725040539; x=1725645339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6MF+sXceWEcBfG7p4hvfyj5a5Bti98QDvGTaVeFBZ7w=;
        b=fTi7wFDmBvXYuud2MBLfkcnBJKSLFkiRM3H+WdLVu1AejUzFSTZw3bkBYqno57yhHG
         DG2elTjXeejF3HOtc7TZkkvVxfAu9Ymt6KpY1053RxEw5toTpot7lqN+mkmSEn+OwCLX
         eP+W9y5YLSZ3cY46yXlZ55nUOts4xHcvNngt2wBtAsxVuLdp7+KRY68ngf+5jChI/KRJ
         b5lFeYDwSRWIxTvxUD8f4yePe/R/O9262MGe2E7u2wiBlwEOoML49hM3t2DyyaTBdt/V
         j2y4lOau32lO2QMl2xc2G6ARmSag3IlHmWZX9C9rWqOSD1UJH3+AvJoT/JL0U+6TVhCz
         8eUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725040539; x=1725645339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6MF+sXceWEcBfG7p4hvfyj5a5Bti98QDvGTaVeFBZ7w=;
        b=b69Pt4g8AKIXE2CigGY7sNjQTSzzFONCNzSiMsKckb8KPBEBTfN1nUXPai5SSm3BBs
         QwJs0xxyf0HslvwciXqewhyaeeVRbw1axGaUG8cP625eyTAnk6qZeGxJCImohQ7RSLy+
         09JifjTP0vzev+QiKrxtLsoCo8XFk+XynlHnJMJMmRtgxh64pCzZYtw5k4j7zEDNCZRZ
         XPpc16AzBMVTlsvaZX6sYAY7VH/jl/hvl3BkEYSKsTRRl0fvo3b/g23dlp7ej20HwZpp
         YJT6z+gsF4PEbPyVMYEd0NV3diOxC66GQVOmSOnIGCDZ+g+gjneagkNQMkfK3IHKjPr4
         0RZg==
X-Forwarded-Encrypted: i=1; AJvYcCUCgQZ/eHsJCpE5a0jyQLeRTxPNvWRHvi7xi04m2/9msvNhlcJnZ9200KUnv39Ftj6QUBN6CbxVxGm3@vger.kernel.org, AJvYcCVMV4E+PwXL3KHmAaCLO7yf+rWi0cCs9Gol5h0xmBHNoUy24edi1FxKfCTREZIxC2EMYtYhj0B4rtkfrBID@vger.kernel.org
X-Gm-Message-State: AOJu0Yy11IlYYnLo6GyugwU9NJv+TaBn/ZG5kJ4dUSIbFKHhV4AltjaV
	nMvCnBVnw+fYd5onh/gFhRYTKHv4RoNkbJoVP+2UQXJ/o6E8oEkD
X-Google-Smtp-Source: AGHT+IEJO+rT64x31n995BvsAz22y/GdYxKgQSigICRU69AK6S1WIiCNnm+JI0H61qKRycetlf7dgQ==
X-Received: by 2002:a05:6e02:b46:b0:376:410b:ae67 with SMTP id e9e14a558f8ab-39f379376bamr77474555ab.16.1725040539147;
        Fri, 30 Aug 2024 10:55:39 -0700 (PDT)
Received: from localhost.localdomain (174-20-195-90.mpls.qwest.net. [174.20.195.90])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39f3b03fb67sm9548685ab.67.2024.08.30.10.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 10:55:38 -0700 (PDT)
From: Shimrra Shai <shimrrashai@gmail.com>
To: cristian.ciocaltea@collabora.com
Cc: Laurent.pinchart@ideasonboard.com,
	aarnoud@me.com,
	airlied@gmail.com,
	algea.cao@rock-chips.com,
	andrzej.hajda@intel.com,
	andy.yan@rock-chips.com,
	conor+dt@kernel.org,
	daniel@ffwll.ch,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	heiko@sntech.de,
	hjc@rock-chips.com,
	jernej.skrabec@gmail.com,
	jonas@kwiboo.se,
	krzk+dt@kernel.org,
	ldearquer@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	maarten.lankhorst@linux.intel.com,
	markyao0591@gmail.com,
	mripard@kernel.org,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shimrrashai@gmail.com,
	tzimmermann@suse.de
Subject: Re: Re: [PATCH v5? 0/6] Tweaked basic Synopsys DW HDMI QP TX driver for Rockchip RK3588
Date: Fri, 30 Aug 2024 12:54:40 -0500
Message-ID: <20240830175440.2596-1-shimrrashai@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <68e78629-5a2c-433b-8c83-50ffced04268@collabora.com>
References: <68e78629-5a2c-433b-8c83-50ffced04268@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cristian Ciocaltea wrote:
> Please stop doing this!
>
> I appreciate your intention to help, but this is not the proper way of
> doing it.  This is a work-in-progress series and you should have asked
> before taking over.  Please do not interfere with other people's work
> without having a preliminary agreement with the author(s).
>
> Additionally, before submitting any other patches, you should get
> familiar with the process - see [1] for a starting point.
>

Hi Cristian,

Sorry, I did not know what the rules/norms/customs were around this
kind of thing here as I figured it was an open contribution space. I
did not know that I should have asked for agreement with you
beforehand. So go ahead and ignore this patch series if it goes
against the rules/customs. Even more if these points have already been
addressed, as redundant work is obviously not helpful.

That said, if there is some way to help along this project "the right
way", I would like to for sure! Just tell me what you'd _really_ need
help/assistance with to get this moved ahead and I'll see if I can
give it.

Thank you!

- Shimrra

(BTW, I thought I read a lot of that stuff in your [1], but I guess I
glossed over some of the finest details; unfortunately my mind tends
to do that a lot [drop details], so I will not contest your complaint
about the substance of the submission as containing mistakes, either.

And I only think I submitted one other patch before so I am not very
experienced at this group, despite being much more experienced with
coding. So again I apologize.)

