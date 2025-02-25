Return-Path: <linux-kernel+bounces-530428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAC8A43357
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 03:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A9B2173FA5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 02:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE92414EC7E;
	Tue, 25 Feb 2025 02:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOPpSx2r"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09E6610D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 02:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740452347; cv=none; b=u2pS8IbBeWp57eO5VcETpBS85QA484bWLDCWy/P1ZvzQPod9OQuakfaKWzkiztemZqn6NZFT5U89CQTQRhJbexJRMPQWRYdEHDknwIsF3iGzRae1RqkUssIdhOHvbXp7P9HTtLklzt2alduhPz8aBTo60V9u5Zhij73VgL226j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740452347; c=relaxed/simple;
	bh=uxLwz9pAWPv4wliE2pWI7MwI3tykU6R8KAu78IrFtBQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CQESwOUtV8m54MsY9SbwC1puZLATTfacg9bKAbeG8Zi50do6Pw+m4iAg2r7K5vRR7GkSiYX2k3Ug/k26vkl+IK3ahAELYIUfj9CiIZqwshqO0DpXexi7BfjRcSLVuMhzZ3fi++J3z36sOi8iNzQLgUhap6QnAe2ljdym/8SBdJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YOPpSx2r; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2fd02536660so786527a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 18:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740452345; x=1741057145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uxLwz9pAWPv4wliE2pWI7MwI3tykU6R8KAu78IrFtBQ=;
        b=YOPpSx2raldaVNiTSdQPEISrfxcI7iMPsazU47vmwZk6cCOzvvi4hzjX8WnX1upr8N
         cp1EoWqq/Y6Ifn1P7chvrtVJVyeNHECR99RmrFnp++V+Kgkkdz50TrZ4oajzD6RWIDlY
         gZqFmK0iQhcnY+aHkINV26/OYhK3EnM+jNEPP+ev/ZpqtDwtm7sUjff3C1cD8TK1TakD
         yOv2Zx5CgUypseyE9dzde2oS3DZ+IZ7t74hJIeOPHJyvDTI2NtOuBQASFtfVzAGtqdYi
         6Uqg9L56yAM0egYgJw4lodAzJZqMvZdH6R0xiFNQi/RD3Am4YWwOOX9CthHvtoy7f6P8
         LT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740452345; x=1741057145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uxLwz9pAWPv4wliE2pWI7MwI3tykU6R8KAu78IrFtBQ=;
        b=nkIaCn3STbSP1cpP58LtVElZV1CzYK1yR/a7aUf1gin73BbzgjX4918cEU/V5m2vUI
         yhXDCLSxZHNxBHPzRqAhXvdTSkBI503JabgsGoIg70SBBJKCvKgZc9mS4MdVdgj+FOFK
         R8xCn9sdOSp/SYGN5Ie6KP/GUadxW9z5iSUO16JqgPt0oUxsf+ePuA31oKJRp0fdBNgV
         BIq6JOGLZbvVh6aMH6tJ51Ily8MMgjcwahFnSJ4fxY4dzyOm6ZCxeY6BHTpQYs/Enqqm
         PKUfS6+p6IPH6+b2Z9ozeQgdgl6nbpDQAYSMqU8rHiW8JGbUgy7B4Zm9qGEeZ6MPtYXt
         U63g==
X-Forwarded-Encrypted: i=1; AJvYcCUZkGyvUNgImeGajzYEISJYnVVhP0N5Ob/0JeCLkbmPTGpJ2iRy4AkFNes/na4nSSnfpzAEwiDuOK7cBvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyAyfOY9Dhlk1FhPqxDXj4aa+zYfTSqubR1HFgeJ8BWTDb4LcV
	V5vgzogzrlC0GBV4XRC2nD4nL3EPq9XEPpbh6UOY1/QRpHLug1G8
X-Gm-Gg: ASbGnct4e2kqpuKHYFZ9A8vqm7ktiwQ/4I/mP0fO97vEDP9aCdWpPSjdbc6x9kLMtwL
	bXqzAge60SX1Y9V770HYQxW0eTvhGUy1vovvA8Thy6VqKHX8a2Eo1iAvOisn+lTtJl2GXT3tgip
	v/w+D5zNCF1tmPTiCha+SvO1LbKsl018Dqno94lVP98AN/jaHnAbdSz8pzAiUXv7ARPRcZWPkdC
	SM7bxl1Xa5IzH0OP2ek59QpsVefXPAeuiMDJZkk00dkWnZYZAYxRFLrx9wTMNGY9fRFA35woNzo
	ibphQfae0A53hO3T4la6JPkq69vCSKCuXIUJrSFOlA==
X-Google-Smtp-Source: AGHT+IEEHHuebk6f0XqdbdzxFm+LbP1RDneTW/XWyiaxf+6sAHyMqfxlMXYlNk6VtOFPABpWireG+Q==
X-Received: by 2002:a17:90b:4a07:b0:2f4:447b:f095 with SMTP id 98e67ed59e1d1-2fce7b14cc8mr9920933a91.4.1740452345260;
        Mon, 24 Feb 2025 18:59:05 -0800 (PST)
Received: from localhost.localdomain ([182.148.13.61])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe6a43cddbsm388655a91.31.2025.02.24.18.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 18:59:04 -0800 (PST)
From: Qianyi Liu <liuqianyi125@gmail.com>
To: phasta@mailbox.org
Cc: airlied@gmail.com,
	ckoenig.leichtzumerken@gmail.com,
	dakr@kernel.org,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	liuqianyi125@gmail.com,
	maarten.lankhorst@linux.intel.com,
	matthew.brost@intel.com,
	mripard@kernel.org,
	phasta@kernel.org,
	tzimmermann@suse.de
Subject: Re: [PATCH] drm/scheduler: Fix mem leak when last_scheduled signaled
Date: Tue, 25 Feb 2025 10:58:57 +0800
Message-Id: <20250225025857.36391-1-liuqianyi125@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <3b369e1a49b354852f361b103999673e4f7906a9.camel@mailbox.org>
References: <3b369e1a49b354852f361b103999673e4f7906a9.camel@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you for your patient reply. Let's first clarify the issue and send a new
patch if necessary.

As soon as it enters the drm_sched_entity_kill function, the entity
->last_stchedled reference count is incremented by 1. If there are still jobs in
the current entity, it will enter the while loop, assuming there is only one job
left. If entity ->last_stcheduled has already been signaled, it will enter
drm_sched_detity_kill_jobs_cb, but because null is passed in, the
last_stcheduled reference count will not be correctly reduced by 1.

Because the prev pointer has been updated to &s_sense ->defined, the
dma_ffence_put in the last line only reduces the reference count of s_fence
->finished. The reference count of entity ->last_stcheduled was not reduced by
1, causing a memory leak.

We should subtract 1 from the reference count of the prev when dma_ fence_ add_
callback fails, which is called balance.

Best Regards.
QianYi.

