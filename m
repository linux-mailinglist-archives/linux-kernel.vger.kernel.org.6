Return-Path: <linux-kernel+bounces-553760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEF6A58E82
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 411C63A67FF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3B3224232;
	Mon, 10 Mar 2025 08:47:14 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A63170826
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 08:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741596433; cv=none; b=mT0LpwQg87cILB4Cq/8fqdq5kkDFSzighhVBSFLGSVWnbk10DR9GEP8CwQcsWXpzHdIruPdYs7V7SmS5Kd9+nLAf6cB4T8eZzQ9aK6smVbYRXb0fyiqTxvhaJOre1C3/JYQ8m52aEmTxjY5l2eHjbOKbOx3dMd+ZjuhFAhDAAWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741596433; c=relaxed/simple;
	bh=DItlkzr2g/B9nWTj2UVQXdaXC7POZqiNBC6hEJmbNWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QpCzARQkr6Ete2wC/uAw7grMDi87yF44EqqF0nkuXBiopyzMrwqVOIoTiO5ZzePuDv9TX74ohlePC8lBdTLMEVHPObhUWmEWrNKQov7zjZtKptM0i57/vy2D9Gq2/XnKvcf3VLGcLt0wy57qUwAuSJQH0u40tQElwAO0BmEPgZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43bc63876f1so33556755e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 01:47:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741596430; x=1742201230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kPPYfHjW9LOl7mwKsENaGcZH5O/veKl4xmyfKUC9VtE=;
        b=w41iA/xjhuAAfIpWW8LrsW17ZZ/nWE2nCjBE8V5DO2jl+ZCqTz29IdlDJmdTAz0DtK
         gEavdlgZaG07Zw4c0ZItUTa4yNs5kJ/Z1mAqZrY6qU4tJ/5Os/53qqw8XiIJ9Fuk5bEB
         yu0d+yLXseIXk5cTBuoTYWzTnf8kHrEGPSEWwr9I1t+0TR/5eb1NcbMw8EFtL39ke6wU
         Sz/vCQOlq4Hvc8DsAiX4I0RqKC6NrBa7/fZc4oX1tLTeOUacClTa1Fb9ssgSh/y8xJrm
         pJ/KODfy7gAfv29lr7jIBZTE7kB0kA7AIHc7HFvJqrHLPmem1PJ8HE3WWKVh1rZD2fh4
         hpcg==
X-Gm-Message-State: AOJu0YxDn3DJigPSpXoDJHhKASRJLG83btYxGucw3sp1LkvEV2iHErJS
	IobIjuaM8ovm4jp+pdKxDmL8Cx9qe+NQp9RK+lkmcgflvnp4kIujuOFvAA==
X-Gm-Gg: ASbGncsHiCpA/kUvETUb38b4yO2tWAj8g8t3UWxQbMROx37wEQjqWgtYLxeCF0jIi46
	8sBeSId9LBPlgFlvbtpa80WQYdhVOHw1OUGaQk02FRxxDySebib7fN9kBWWVqFo9nbZSKmZpMyE
	Vwcf0iMQhld1tsERujk1WwbxITie/QbU400/vsYoJNXAl+XnFOVogAoIHVxjb64VHIaI+CYl6wD
	sq+LXWPgINd9KzP4A/ehOAO3g7alDw/kibqjz8rbU9XveNalKljmps8JujK6lTh8BqM8pdxlFiw
	dyiLlOd9Snc75sEaIy9Nt+AwDVtgIaYIRk4QbeY1hMauv48QaQywQE3/nS2jEEThzf4345YwTrK
	V7SheqvfX0yVan4hUo3tyz78O/BQ=
X-Google-Smtp-Source: AGHT+IH0qoXrg896WV1Vg1+kR0nyNfo2wlNj0wVfH/F6dtta2oEDp1gaqTVt0Ji3OYMBl4E+i5z6mg==
X-Received: by 2002:a05:600c:4f0c:b0:43c:eeee:b713 with SMTP id 5b1f17b1804b1-43ceeeeb9e3mr29203425e9.20.1741596430296;
        Mon, 10 Mar 2025 01:47:10 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f7433100fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f743:3100:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ce70d13b4sm77093465e9.38.2025.03.10.01.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 01:47:09 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH 0/1] mcb: update for 6.15
Date: Mon, 10 Mar 2025 09:46:56 +0100
Message-ID: <cover.1741596225.git.jth@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg,

Here's an update for drivers/mcb for 6.15 from Haoxiang Li fixing a double
free in an error path in chameleon_parse_gdd().

Haoxiang Li (1):
  mcb: fix a double free bug in chameleon_parse_gdd()

 drivers/mcb/mcb-parse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.43.0


