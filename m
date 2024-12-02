Return-Path: <linux-kernel+bounces-428112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 575989E0C2A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE411B3888A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DB31DD0F6;
	Mon,  2 Dec 2024 17:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DxGdxrTg"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C437E0E8
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 17:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733161576; cv=none; b=D3SDtFr9rJ7EPWXFdHN2Or5zkYQTJl1lG3qYT8T4dzNTBGZHXNMt66qibq/kmfdwzz80LHIEuzc4hVtbaTF6FSMrPquXnheYfr+5n1CmhvUHAaHoNhZG7YS7WjbakDBHsrfPDXqZhq0Qh59bOdzAHdeJ5zLdz05FhhfuAygimvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733161576; c=relaxed/simple;
	bh=b5il2Z2utd0lmXYJr0mtWGX8EWfbvnZlY+vNR6xuPY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IFKADCsDCxIKoBF+pPBOP6PbD7BJX3lCDvStVEkYW2Ni/CX85Nvj0tvocYFoH5zfpihWne+n+NX6K13e6A8m9dI+0Z8oCm8Isb/Nr4N8A/7Dd++gv2XeDoVnXn4uLDN9neccQJ2MxE0uzD7f2OTHzBAKRA3NhD+lTaDpf4wF9aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DxGdxrTg; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ffd6af012eso55332751fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 09:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733161573; x=1733766373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ZxEcd0jfIdJ43B0I6BAc7C6qxciSXMBMwXPC6dEEfQ=;
        b=DxGdxrTgCYcF4khuL9G36U0vsiJy18ndsKr43Fqljgdg+mkVVyCQsdTZtYmo45suEf
         hBaIrQpQtie9uZ6cGjXB97txfgJD8jUnBxwKeVnwMIofVttViOXFQObEK1PbqQfOZI7Q
         W8UCCORxhlsWPigBz+pbeT5UwsVJ4ON3HsdnXer+i3d7LEvB9z/RzB3fqHdnU9AFcoE5
         Zaz0OydHadBOnxkQ8BPqFJxF9vEN31lo5Z6N+EoXONg1JHKMIZm4ixtTdEXHEqOZOW8/
         2rVV82At9JxgudmJcokEQfg1Dt3DvNou+Xd25NIyOjX6O0R37CHw538dVEXM+q8tpzI0
         inOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733161573; x=1733766373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ZxEcd0jfIdJ43B0I6BAc7C6qxciSXMBMwXPC6dEEfQ=;
        b=LDXIlInyEeJQOruKgm96y2381FtEtDVG0Ff101OSIg5Vzq8aXoXjsTPgNaCpozmS+E
         42Ohw0X06fJ+SeHAJyEJit558qrHhUScBoVAHJfG14mwRs5qS7T8SrMUCx8mZ7Ze3fXo
         tKIrk8XVAlURbImzoNIJEhVnp2os8BAM+2/dMBt/wFKL+clpB0LwMyneRQxsfqFaIpB3
         exPx2P0C0YUU1J3N+EnX44BW+S5vh8c3dz3rqf1CM5NfzyKzerjhJBc1b4ghXF6cXrEX
         +Q12KqeBR2zO8ilU/q94Mgu4UrqPpACCW5J865hDA4KOaBNbalVIe6d/KfSMc1C2DNyG
         utkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUh+YlM61xfCPDnzM3sedwN8bBE0RIzQSkvO948flFS5IR6w5bUpYlEx7yUdlOj19z0V9rwcj/+qfz6+Ko=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm+X1lFsQUje8CrHCCI6wckOL+PjdR/VMRpdrUA+vgiM7pctBQ
	JyatxSnqI31u64aOK7Mri+rDDpyyM+jAqNi7bh9aCKvoivC1oUzBUENcfG+XAH0=
X-Gm-Gg: ASbGncvj97d3xJDidcSad8xkqZ5LKKC2HSmtCxkh2hN9SpxoVabfZS8NFEmFQ+Wr3Ti
	tl+s5aGwekMVcg6/q22Iy/5rUEfiWxI9IPGrHmgMEqUs1Wx4Otv2rtQZwBnzY+n3WBedkdOxnCO
	kA9ax4vddzK9QXGE6iA83bRqrm4FLcrXSYFTMH0fCnSdPVvNx1sQirq0PeARIc+0p3vtX1r85mJ
	3hmyo+6dDA3geUnrE0bYlaYpy5UxQWntmhRqESUWcx6KPCsUEk760NUnkE=
X-Google-Smtp-Source: AGHT+IGVUcNjfQ8+ZCeiCAJe+K4XXiQaOih19B14NrRnmqvuw2IAQ6AvgtCEfynTHH8cun3GlPJZVQ==
X-Received: by 2002:ac2:5695:0:b0:53d:eec1:a04e with SMTP id 2adb3069b0e04-53df00cf72dmr12684739e87.23.1733161573044;
        Mon, 02 Dec 2024 09:46:13 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:f271:ff3b:369e:33b6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7d29fbsm193275855e9.29.2024.12.02.09.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 09:46:11 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	linux-kernel@vger.kernel.org
Cc: kprateek.nayak@amd.com,
	pauld@redhat.com,
	efault@gmx.de,
	luis.machado@arm.com,
	tj@kernel.org,
	void@manifault.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 01/11 v3] sched/fair: Fix sched_can_stop_tick() for fair tasks
Date: Mon,  2 Dec 2024 18:45:56 +0100
Message-ID: <20241202174606.4074512-2-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241202174606.4074512-1-vincent.guittot@linaro.org>
References: <20241202174606.4074512-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We can't stop the tick of a rq if there are at least 2 tasks enqueued in
the whole hierarchy and not only at the root cfs rq.

rq->cfs.nr_running tracks the number of sched_entity at one level
whereas rq->cfs.h_nr_running tracks all queued tasks in the
hierarchy.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1dee3f5ef940..ed95861e9887 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1343,7 +1343,7 @@ bool sched_can_stop_tick(struct rq *rq)
 	if (scx_enabled() && !scx_can_stop_tick(rq))
 		return false;
 
-	if (rq->cfs.nr_running > 1)
+	if (rq->cfs.h_nr_running > 1)
 		return false;
 
 	/*
-- 
2.43.0


