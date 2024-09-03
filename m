Return-Path: <linux-kernel+bounces-312158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4949692CD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 06:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3ED11F231F3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 04:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B571CDFB5;
	Tue,  3 Sep 2024 04:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFHNJieH"
Received: from mail-oo1-f68.google.com (mail-oo1-f68.google.com [209.85.161.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C5B3201
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 04:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725336817; cv=none; b=OAQo0iDf/w00WFqCsc2vAaunjnGpwjAlqlS93huIgRaCncSBOa8wTh3dyNFh59axXyPdKhCqxRpMI1X0juF3pZtxdQzKN++0XDz/PDWZ2DfvrKm1QnVHu4CEw4kedl1bSci9Z8idnvM6n6Rl7wXbuwtZeTV6gb24hKQmpjrlpOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725336817; c=relaxed/simple;
	bh=FYF/FMgMIg4K+7LzKgbsqij41obXZhEudINNu1PCDbc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kOAzz5R4iwSAqgbe4wdJmrxaVBogno9rIE/jLkSHnaldKVcZH/8/ZkYye2wbGtSw42JH4Df/37vHqyy8kknIeRuI1M4adM7nPUteIbC0uZFJzWL9H86t6Q8n0hmCKBorotFWBv+8s9QVErL6GlY8hgRt4+Z1a9hFNsBe/Rmi284=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFHNJieH; arc=none smtp.client-ip=209.85.161.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f68.google.com with SMTP id 006d021491bc7-5dfb53d4b13so2023590eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 21:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725336815; x=1725941615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYF/FMgMIg4K+7LzKgbsqij41obXZhEudINNu1PCDbc=;
        b=cFHNJieHmuvXPTp/MspSjHDlbWzhlSR9GN+goVjU/yOsTXp9e+K+V17UzdX0piDuyi
         rBl+b8dSgBEIv0fLpGF4HBaIhEQom/PhYAVfsPPApI3g+PhDfPwkLDB6KqnVAGB0XnFZ
         chQx3r3am7qzBnufyQKMqd8xElhl9KccwvZhutgwiIjrbAOm6DgHfYuXvMbGknkAlgoB
         4dh5YnqjF4fOn5tSGB2uNfR1T3M8LpykAUY081mkaBqHRX4hRUHrkpPdHHdeGG5xEPtH
         xmTDCuyOuInqVZlb+TODWyn8qoEDXaVcotCt7SZvXyaAYspCOaWjaqwFiDa8xBCegj6C
         XbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725336815; x=1725941615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FYF/FMgMIg4K+7LzKgbsqij41obXZhEudINNu1PCDbc=;
        b=CpgkaqHL8YS1IQFduH0ED9RI3eRQHz7cuzi14tGdCGkil4xh8AMrzYwV255Lud9N1D
         8FuZ93di+zUGKL8PY5PPxJ0Gd1EiUJCjfa98ef/1QWGQFEOEDW+nWlTg9y9pNzDEPQqe
         uG4rhpBMKahgcuj0EbqRl7aSrucjuTzMH7Bc8xfddTh1qSm9sVO73YxIr9/F5TH1nT86
         Mo2aECEm1x3e2C3DiifA0aTIx4WK9rVCTJaAvnCx877bwCXHwqMlSoPImgpgfjETsFCk
         GIyu9xp41cf7Ni9sKlCfTMWRyEaDQN9mkNqpk/HMc+113ll88Xv18q9M8JQQo8m1TcR6
         kvhA==
X-Gm-Message-State: AOJu0YxMhPw974ATe0g3pE5pNYPysAHB9UyZuzWHWRCcEjXSm/K1golk
	415sFLtFnKpN9fIYwU6bmcjnNrAuoXom6NX8105wPzcCqevBRTvP
X-Google-Smtp-Source: AGHT+IFVkcJFquRYy+leE3/FGIQIE3eStBMiXwvNmDxxdtwufj3G88TjP0kHsbhgUltLOEnX+lweuQ==
X-Received: by 2002:a05:6358:60c6:b0:1b5:fb36:8176 with SMTP id e5c5f4694b2df-1b7f19e1294mr1312266255d.12.1725336815311;
        Mon, 02 Sep 2024 21:13:35 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e77cd5csm8330871a12.38.2024.09.02.21.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 21:13:34 -0700 (PDT)
From: xu xin <xu.xin.sc@gmail.com>
X-Google-Original-From: xu xin <xu.xin16@zte.com.cn>
To: david@redhat.com
Cc: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	shr@devkernel.io,
	hughd@google.com,
	xu.xin16@zte.com.cn
Subject: Re: [PATCH 2/3] mm/ksm: Support prctl controlling KSM with pid
Date: Tue,  3 Sep 2024 04:13:31 +0000
Message-Id: <20240903041331.1775424-1-xu.xin16@zte.com.cn>
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

