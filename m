Return-Path: <linux-kernel+bounces-312157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F32B79692CC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 06:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5915E285229
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 04:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8370B1CCEF9;
	Tue,  3 Sep 2024 04:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SfWKzFTo"
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35D73201
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 04:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725336801; cv=none; b=NveV1BxHpybP4dKl+c5wajfePB0c6S9XxYwgK7xoNW5DT+p8ejKXmzq8nfgMFM6VOsCo37k2MLFAV+ui5zje1Eci7FH919maxy9by+zIzbxdFf2ifP4PQlYoNnGsH4KTFZRjelEo541EmBH7WZDjww/NjUeC0LOmCgN9Jo0H8H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725336801; c=relaxed/simple;
	bh=FYF/FMgMIg4K+7LzKgbsqij41obXZhEudINNu1PCDbc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EQ7ZqOVnbbmOLk0Q4dcXrMowdszAaoi/hd1QGV9AMLta72u+DWhn0qqZ+BaVYzxIwDXhMlTXPa4iDrk2ZTDwQ7kn6wlNHPKCFfIPBh7ghv1v1cACGG6d9pnaVWjWMKZ3/b7OrzFuYMSzkQ0+RbcvbMFgh/XbZFPpYQ44pwqHc3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SfWKzFTo; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-7cf5e179b68so3036750a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 21:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725336799; x=1725941599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYF/FMgMIg4K+7LzKgbsqij41obXZhEudINNu1PCDbc=;
        b=SfWKzFToH0lY+ityTzYL3hJ8JyyRl+zBDB6fU8lkw1Wx/gZ9Xe+QU1kJfddjRUO4Sn
         8xK2wD2Y310e9FEVkqD5EfyygfF3QIGj/cvcB6PaagKXL6b0zCjskra3UG3lTNnz5mZ0
         zJWIY6Hsr8CPl8nCAKJWeURA7ud34AYaEHJyN23HDOtI4D4d4j/x7dAj7whmjtpd6Py5
         NGxx/l2eqcZSL+fjoHut/tATVMojUbwh8K5VdcdOqdUsH9DlzW0Jlyds+mdwHgWZFzpM
         CYfR+GopdSyaHZPRVPJI1wl4uCiYMlqiZ9D6UkGrDX9MMvD68fgMqcBw5IXHU+bWUeVK
         4xeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725336799; x=1725941599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FYF/FMgMIg4K+7LzKgbsqij41obXZhEudINNu1PCDbc=;
        b=OaNq2q9yFVT7XTSUoCuz+e/L/wIcxyi3mrs2pUYTiXB79yjfff6PaI37lN6tGSN7/s
         frfjy1FLw7ZKnFFKW1CeRJ7C48U9lDudHdQu2WS8Zcl0p1BcD21DLwt4DpslujvQglqI
         76odEFocRlF2o/IYEhMmvZgKfMW/lP9foQKghQRSfeLCFgDA2MQcehNNKKD2Z5YWpGkI
         rpI7OITVcivHhqlVp0ZFQYhNvIL3+qi38ekHEermJLPx8dmplT9GzrOvtGnY0M6AO2sE
         Gr7bG5Zy2Usdd0ixRYa4ftyI84RrREV8nfWjeO8tXQ3BRc8KDagBhNlJEjJm/OEDoICF
         jlJg==
X-Gm-Message-State: AOJu0YzPx6tFxrkkflCrlnNDen15UpZi/SxxZDUi30jV7KhIcWmRbg9l
	rjq/5XDTH87jZUA++2MmlhQJ54bg7q5mtumzc5odqY/NXxyYPeyr
X-Google-Smtp-Source: AGHT+IHoF4OjYgZqSZARidTJ6sAFMubvYqXsWxkvj3dpQPAuS8JSgtkeZxXymjSvO6yMpILyVPimxA==
X-Received: by 2002:a17:902:ea02:b0:205:59b7:69c2 with SMTP id d9443c01a7336-20559b76c79mr137599365ad.7.1725336798787;
        Mon, 02 Sep 2024 21:13:18 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2054e2ff670sm40772845ad.183.2024.09.02.21.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 21:13:18 -0700 (PDT)
From: xu xin <xu.xin.sc@gmail.com>
X-Google-Original-From: xu xin <xu.xin16@zte.com.cn>
To: david@redhat.com
Cc: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	shr@devkernel.io,
	hughd@google.com
Subject: Re: [PATCH 2/3] mm/ksm: Support prctl controlling KSM with pid
Date: Tue,  3 Sep 2024 04:13:14 +0000
Message-Id: <20240903041314.1775342-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240901043525.1683177-1-xu.xin16@zte.com.cn>
References: <20240901043525.1683177-1-xu.xin16@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for your reply.

Selection of interface
======================

At this point, I have been thinking for a long time, and in order to achieve
the control of the KSM scanning of an already running process, the current
prctl PR_SET_MEMORY_MERGE is the most suitable interface. On the one hand,
it is compatible with the existing KSM PRCTL interface, making it easier
for users to get used to and adapt to it; On the other hand, it adds prctl
control over processes that have already been started through PID. Lastly,
I referred to the PR_SCHED_CORE option of prctl, which also uses arg3 to
perform operations on tasks pointed to by specific PID.

Anyway, the current way may not necessarily violates "prctl() manipulates
various aspects of the behavior of the calling thread or process." ,
becasue we can consider controlling KSM scanning of pid as a behavior of
the calling thread.

By the way, I explain some more about why we want to manipulates KSM
behavior of an already running process.

Purpose (or usecase):
=====================

In the field of embedded Linux for cost considerations, resources including
cpu and memory, are often not very sufficient, so the global deployment of
KSM can be a mitigation strategy, which is feasible for closed system
(scenarios without Internet connection). However, KSM has a side effect of
increasing write time replication latency, which is somewhat unacceptable
for latency sensitive applications. Therefore, it can be combined with the
QoS of the business tasks to dynamically close some part of those already
started processes in real time if the QoS degrade. Although it is also
beneficial for server/cloud OS, the requirement of embedded system is more
urgent and strong compared to cloud or server operating systems with
sufficient memory.

