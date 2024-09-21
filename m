Return-Path: <linux-kernel+bounces-334898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F4F97DE16
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 19:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5D31B212FC
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 17:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089AF174EF0;
	Sat, 21 Sep 2024 17:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8o8k5Hj"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D4D1799B
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 17:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726939866; cv=none; b=iNv8q7+X9f01HqvzHiLFml35bNqHQGdD5LNMGA+55i0y1tUUZl36jZO6z7hiwUyjeeVwFK2BvwQYrXKU6dGWVorg/L2UorHkuS37tee+TDdb/USAYWRiQdRs2+Ukbt5gOdx4T2y6YXx/2ggk7MOqYdCX3j5A7FX/Z0EAHFkoCQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726939866; c=relaxed/simple;
	bh=XGCYixI0vFK+yIAU0vI4gYEk54HBG/rMq52xNLmqow0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kygj55e4j5oxNb4+Qu+78wkGzZVJMCGBbvyXqX9LtFBQ/UyNPUKf4gMMSvRGmoRozHu0DF+6bqnTjKADDbA5xKdQUAv8sv6CjKIvdAAtf455S+KMzy0sN+1jbPQa329ILe2nNErxpf/AVOXD0flJBzxgbAICwftLerzizffPpU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B8o8k5Hj; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-205722ba00cso26159105ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 10:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726939864; x=1727544664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XGCYixI0vFK+yIAU0vI4gYEk54HBG/rMq52xNLmqow0=;
        b=B8o8k5Hjtvv/pF6BHNP0BPJwUfTKZdMbsjZ7JoGgBCavLe3EbfVwPsaJg2BxcZRqPZ
         c+BznyBS6vjTAGbndcJ95ZRgR3oNsSfYiMx44q6tE9iReU3dA0gdG4unuHwbiWEzh36X
         DNJJPxuyGSQ5WCN0vazuOlpvp92H9pkOpc9ZuPQ2TPuiDIdaICklJxr9j9JvOCnFIZcO
         BwMBHkB9rrEkYGwPr08+MyDKBpNpwyL1d2/bxIhgx3Nf+uvRmDJB/HzdCpP+nucZH9lc
         nWAWrojmbNr5f+tLoe3HogTb4p/ItaExVxbo2V07ZGWjY3D0WjOj7LzqaMULNud8f0FT
         +5IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726939864; x=1727544664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XGCYixI0vFK+yIAU0vI4gYEk54HBG/rMq52xNLmqow0=;
        b=E1gSBxQGidanaG4tZHNnCMW7+2zoyDmUa7cTvgd2POOob35QE/c0QB6yYIq9NXxdEL
         /VqSjcw4IO9LbKNTedX66q7pquQak4b4TZhpCZAn2AppsXW6kHrrYTb+LRBFYHqUBOV2
         5qarPVYbfi/61QdEo4y7FtssM/XG9uIPI6LGHYCSJCzZOQpBQQgO1xlrfr8TPiTevQPf
         OI4QuEzIAkM3+xwFzH0bSfnMTJcjDpltSl+BMRIKDxJ5zK/EinE2cl49aYpYoP+Jd3P0
         2RAmVHI5SJwWfKLv+fz4ZkljerGMdpRqwwxCn1L/Vq7bQB90mhRmGbGvN95p5ysSD97E
         cuhw==
X-Forwarded-Encrypted: i=1; AJvYcCWczbmpLMyjR38hs0CXKaNt9/fkCbFJgddv9kWIsZsIINBDMAA3KOZ/67CNV6NFyeJrJIVVYvfVav/gGDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAaw/+rVexR+IhnVclkzexVw6uxKVOxC7OPPiPTk4OD25ShX55
	pq5NSOrHfh20YzrQBc81bH4/KwbRVKf9gAGtPaYJzoRDnh0ka77Q
X-Google-Smtp-Source: AGHT+IHWqbbnm9qKaQ/XxFI7HrCdMk6rfQmgnvsR2dGXF9HTvrMr4x3N2MeZThdjkfoi4HE8uyrBpA==
X-Received: by 2002:a17:902:cec9:b0:202:38d8:16c with SMTP id d9443c01a7336-208d989f11bmr72151235ad.37.1726939864078;
        Sat, 21 Sep 2024 10:31:04 -0700 (PDT)
Received: from archlinux.. ([2405:201:e00c:517f:5e87:9cff:fe63:6000])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20794600fddsm110971495ad.82.2024.09.21.10.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 10:31:03 -0700 (PDT)
From: Mohammed Anees <pvmohammedanees2003@gmail.com>
To: heming.zhao@suse.com
Cc: jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	mark@fasheh.com,
	ocfs2-devel@lists.linux.dev,
	pvmohammedanees2003@gmail.com,
	syzbot+18a87160c7d64ba2e2f6@syzkaller.appspotmail.com
Subject: Re: [PATCH 2/2] osfs2: Fix kernel BUG in ocfs2_write_cluster
Date: Sat, 21 Sep 2024 17:30:27 +0000
Message-ID: <20240921173027.9425-1-pvmohammedanees2003@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <e068a56d-959c-43ad-aaea-839b89344693@suse.com>
References: <e068a56d-959c-43ad-aaea-839b89344693@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Yes, you are absolutely right, __ocfs2_claim_clusters indeed
allocates 0 as the bit_off, looking into this I believe the
problem is triggered due to ocfs2_search_chain called by
ocfs2_claim_suballoc_bits, what do you think would be the best
approach to solve this issue, what function I be looking for,
any insights will be highly appreciated.

Thanks!

