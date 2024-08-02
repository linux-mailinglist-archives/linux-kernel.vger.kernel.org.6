Return-Path: <linux-kernel+bounces-272957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D26D9462C5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 19:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D52571F22265
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0F415C12E;
	Fri,  2 Aug 2024 17:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJWRGauX"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E481AE021
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 17:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722621477; cv=none; b=Mg/pGh9gaMRQcL3gw6joizxsoEUQQfWbVBvDko8e+v+ESQYDPXveOu4T+HxgZFSJkswrReouZi2qeecEp20Ercq0HHUmxOtxBE8UD5CUejKFcsgOEqUU+busGtrXdWbJ3lM56NkuvUcaeVl5JRMAm6f6DIjZDFLFuEwCtoUlOYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722621477; c=relaxed/simple;
	bh=Ke/p5Rf+xv0YTdEcPr+ksjhoaSabRGdDrA29XLJaXio=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IRmpIXbh+xQAM+yOfn97bNomoiwg6rIvZsToZWGGxhfwv4Eu87olmzxBBVjIJT85jXPR2r8UhgYGRk425f+QknxFfAf2sm+u6dVWXNqmO6uCbic0piAgPlSvUIvGLE/LBNUH6cbY1HfvknzQJE5+Xq/ZTXQTKsqe1pILlSxJe/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJWRGauX; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fd66cddd07so64231335ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 10:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722621475; x=1723226275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4qWeLbFqoedEXg8FzbHQ1a6NAME4QmYZOrRlqNUSYtk=;
        b=kJWRGauXgp6DovXqk8scmQIYOcoX51TEcInIdQBgCniYmISmLLlq57Szuw5tGiKh+b
         IGzp7ExUqqnRrEDC2ct+BlEN/CKMcduwdcqp7k5+0Y0ZPH7/xiqndf6i8M3PxdrCqjXp
         OuXpb1e/DCJSmF5fQG+RdLbRgCaYpbI61oLUQRjI2QHQyNAJ94yF+SPnBF9S3dw/Eqdc
         iYjEkouX6WMLiI9jNKc6DFmR4vfIEXUsoU0p/tqJP0V4DIwniCUckZ63m7tGPvyD+iIZ
         HpkFrvGoxdnM01rALfxjImULBUujM8fx/roVakEc5H4uKp09BF5g3I3+jdkpIKPJdZC0
         or2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722621475; x=1723226275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4qWeLbFqoedEXg8FzbHQ1a6NAME4QmYZOrRlqNUSYtk=;
        b=lHCCesCeVGAzUH+/MyYpkGBjc0KahfkPfU3SYYMnNCAYcIAeoAnF8QmoEXPjBN5uO6
         VlTyrohWxCRUw8cXP2PE1l1bGG0vxHi4ltE6SKaooUg5BhI/AVJmukUQ6bLX9WqVEUfj
         3zz8oNrKeL/V5wDTSdCndjxqXrWyKsxcTD+yWqt1yO4W8fIod2kbAl0y3XAyuiBCwSqM
         z8IfM1U+MwGQRN3ko1zfrMNN6MRpqS62bs4mxBlI4s8Os1ULpExag474OyWDubf7jiIE
         XQCPrfUk4HC4E3ve/IGFed2ZRuFX8vVE1WU5uahZOnF/xMW1VxTW2tlD0WBIWUnGfVul
         SpyQ==
X-Gm-Message-State: AOJu0YxOR5k64qztPvbKpRC3Us7AdIRmTGCqMDRVajNet17OyP+jIBdq
	I1R+GtCb4hTMqV2k3jbfxSA0d+ihXGvIaovg8o9d3TToSggMvU+smQgrz5Ll
X-Google-Smtp-Source: AGHT+IFVH1IGJOtdgyCrNO3mZuR5RMs7V/5ijQOpUTyMFqOPdHZCiw7aFxvcffwQI/9mg3fxl0UBcQ==
X-Received: by 2002:a17:902:d2c9:b0:1fd:99e8:f866 with SMTP id d9443c01a7336-1ff5735a4fcmr61894635ad.39.1722621475378;
        Fri, 02 Aug 2024 10:57:55 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59294e92sm20019245ad.240.2024.08.02.10.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 10:57:54 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Leonardo Bras <leobras@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH 0/2] sched/topology: optimize topology_span_sane()
Date: Fri,  2 Aug 2024 10:57:41 -0700
Message-ID: <20240802175750.1152788-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pre-compute pre-compute topology_span_sane() loop params and optimize
the functtion to avoid calling cpumask_equal() when masks are the same.

This series follows up comments from here:

https://lore.kernel.org/lkml/ZqqV5OxZPHUgjhag@LeoBras/T/#md6b2b6bdd09e63740bbf010530211842a79b5f57


Yury Norov (2):
  sched/topology: pre-compute topology_span_sane() loop params
  sched/topology: optimize topology_span_sane()

 kernel/sched/topology.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

-- 
2.43.0


