Return-Path: <linux-kernel+bounces-411518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF2B9CFB64
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 00:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6B80284F57
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 23:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3435A1D63E0;
	Fri, 15 Nov 2024 23:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fel6xbRW"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A9D1E1023
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 23:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731715090; cv=none; b=Fgc5w+kK57/x6FX/S1DIYDPnVGKMq5Wl7ZKpFJL/bSedWUQc6REA66iXW2uRJEnfW/wPrvtXZWzlavlIlZp3NCimZ6bjcSw5Bi+juNpJA04Y2UFFAqbE1sb1/IYmPS4NorPuSNKNDYrqwGln4usQhIxX+TGBrgWMYk6Rviqmziw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731715090; c=relaxed/simple;
	bh=Pw3c2RN7eyECjfKplynfRokR3DtRXubdMSw2fJ+25ls=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AZv9X1d/kfQdr9/c/gRIN1zqlZiN/YVLKsHnQoRZecHQ2dxdEqn3nT3vv5LDnPn6cOUQBnHOX0u8dVEkFKyACrJfWV3SY8y6cfnl3kRyxOk9ZJHLdv4tOZHIqjXgqndYaVi/aDauvAIq5sbf9Li7uj+YraujlYLa3Y8qtCNMqhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kerensun.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fel6xbRW; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kerensun.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e3877744e45so1196014276.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 15:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731715087; x=1732319887; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o1RIpUDtZXSgBRqjmugzkaN5U5eWQ9w7S4LovaiX8vs=;
        b=fel6xbRW843q98uxnPXgw2OvJ2PxXDBJ0bLmepsHSCLwucnfWNC/r1XvnmPhOFk7OE
         wFsy4gYFRIk2aISrzywUfLXJd/HCUstPnXjb9jSJQHHsvP+kj4017WjMlRo1Vx3P9e2V
         IduE+G+ypTODkY5QhumswaXUwUMfq0+dAx5URqZn1leCQcy8ctDiV/+0yLNQFFM1Rp7n
         AwIQgOxwwWdFFwp9Q1nrQUqMOORq/EaF8CBoAL+OPe+wbVrUQuhI9vmF0UHDZmTmZg6d
         8bK1lUteMoWQizcQBzWr0cLY6UF2Z9V/php5NcJ2EprA0AhOo36Pv+XLRtnDcSPbrcpp
         JffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731715087; x=1732319887;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o1RIpUDtZXSgBRqjmugzkaN5U5eWQ9w7S4LovaiX8vs=;
        b=AjySqaKGxYlwXwBFGjFgHE8aqO+l8NH/lqIS8cadx1TruaAqMtiWtk9J21rEqHUFmE
         8RFKq8WlHOFNikJhJ9Bu5G0KG2FDgj6ut5PFCtc1cAysLvXSAPGlx7LCCLnFZGVMy6pg
         ArOxOiiNCikhrhutHYVdvQM0jAqrGQSn2U+58XYpeQ9rmhMeKLsutoHcG1KQYzvAZDHV
         852HeKtkXKGQmMY32V/EmQqB0Lxa2ao7wP4GpPtTIksAAIX3NAfYHyIP7fr3UgQXnYgp
         eKucVd4AzUqb01SHtcnNEvOImyUqasiaoSfrinpyt58PnBSgWRccJALkMdh7OWscNam9
         bFpQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7AKXTP7kxqZD6biaqu80QCqpwW0R5MMxlMAADBvcHnVQ2AOPIwtn14QGvs7mzCDHoTBjv5kirAUpyTYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YywkvK0F4lvZGqXnWbTtr/OiZeTOIrvXQaOexuoM4TeT9VKB0Zi
	AQonhtod2ycQ5HTaOB5KmvFKXmLj4xuw0iDLMKxWmEzM6cJQRR8dobUins2MTnElcYQtr9qK09y
	ujoyqx5gd2A==
X-Google-Smtp-Source: AGHT+IFHD4awoAKkBJnBwCEuXy6ozkFUMt2EYzDoJvjoWIITqKtBMoKHRd36j2A63QZEq6HL+REkETq/YEWdvA==
X-Received: from kerensun.svl.corp.google.com ([2620:15c:2c5:11:f2d6:8e6c:5a90:ef1e])
 (user=kerensun job=sendgmr) by 2002:a25:bb0e:0:b0:e38:2136:9482 with SMTP id
 3f1490d57ef6-e3826614e75mr3790276.10.1731715087375; Fri, 15 Nov 2024 15:58:07
 -0800 (PST)
Date: Fri, 15 Nov 2024 15:57:44 -0800
In-Reply-To: <20241115235744.1419580-1-kerensun@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241115235744.1419580-1-kerensun@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241115235744.1419580-4-kerensun@google.com>
Subject: [PATCH 3/3] mm: remove the non-useful else after a break in a if statement
From: Keren Sun <kerensun@google.com>
To: akpm@linux-foundation.org
Cc: roman.gushchin@linux.dev, hannes@cmpxchg.org, mhocko@kernel.org, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Keren Sun <kerensun@google.com>
Content-Type: text/plain; charset="UTF-8"

Remove the else block since there is already a break in the statement of
if (iter->oom_lock), just set iter->oom_lock true after the if block
ends.

Signed-off-by: Keren Sun <kerensun@google.com>
---
 mm/memcontrol-v1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 4cbbced0c8a1..423c861acdd8 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -1148,8 +1148,8 @@ static bool mem_cgroup_oom_trylock(struct mem_cgroup *memcg)
 			failed = iter;
 			mem_cgroup_iter_break(memcg, iter);
 			break;
-		} else
-			iter->oom_lock = true;
+		}
+		iter->oom_lock = true;
 	}
 
 	if (failed) {
-- 
2.47.0.338.g60cca15819-goog


