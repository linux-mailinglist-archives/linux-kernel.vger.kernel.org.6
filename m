Return-Path: <linux-kernel+bounces-177326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 320E08C3CED
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 10:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7BF91F21EBF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 08:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F791474C9;
	Mon, 13 May 2024 08:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPq8leOO"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14CE146D62
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 08:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715587994; cv=none; b=SPu5gD43AQOq4ijVZEGJHv89VlHIl43pe1ww1bwMbW/pOLgF1VfNvglFDtXYv5/Vsvc4Wd5/YS+uz7W57hAFNOuy+52zgKTYqa2mmiCnr9FWEFJZXOTgVHBBjHc5d5UOv20Vku/bcKfr3RtqF/NPk/Cx2jl+6toJAD5rrEkaOYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715587994; c=relaxed/simple;
	bh=FUdlLBoU9E5VgyeKJsX9kcOBcDZzkpEsqNBxhlyWkZs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KCXQT5Ndp1jxDSXDwz+mUt6dKSrhHrfqlH8RCm/Rn1NPzNik2Zh/M5KmFsI1zgkFFLP7u3MvRlJQSPsR1t6sh+0TwaXNbuia5Ela3YC+edi0iIbhkq8acXYJ5f+XmtqbmMKJRJQi8Y6FtGG9gF1bL8IOz7YQlM8sLPs/ojbKOaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPq8leOO; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2e538a264e0so39030631fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 01:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715587991; x=1716192791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgKHgocriTlqxjVjw6xoeGLIqR6uQf/U72vB9VWFXgg=;
        b=aPq8leOOlu3xs57yHTomEb0cZUIl8x+7LS77bJoLGTouXQO7dAM+AvY1E3I0uYQNlx
         RKDMNGIBnZpnSC9JFnwTsbvJGPycPR3B3Q4FltzC1awKdaLBzggUkWMtnpG3/j7NsBXE
         vCZ6Ar1aon1n/gChOZn8xgqxxHtcxKuMBYAPFlicTpnKI5086wwTDStRBS1LnIgVCDYD
         QkgB50xO10m1KwpKTNjQqFLmI9g+Au/Csw810FC6n5fVtHBbMOTiNKe0jJx0SDhMMJcm
         BxgLXH5oipeJL2F0fuTC+47sk1jDN3WC9225caA9ykRtyPbHnMVFZ928O+RjQzOIitzp
         6PnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715587991; x=1716192791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HgKHgocriTlqxjVjw6xoeGLIqR6uQf/U72vB9VWFXgg=;
        b=a+tTllgFc+eJETiQYMoliX/UqnUZMyYvOUuuFaVSFJfxVM/NBKwZXYe9AaKUeHOD+H
         qhpWnZbfJYl7o9DULKXU7o7NG0l0KYrGds2ZE1YF+8E+wex+QVbMRjcQO07rClNh2rlY
         bogZpRHHYBi9BIWSQ56n/BphheV+VmXgyBl/tYrYMDZKIdCjZkTSRSziRHAaNif2tDwS
         ufaU0j1bp9MTr0cUZoGMJAfUhpiozH/b4yeezzvQornNQraibqndEVvbuRvi2OrjY4D1
         qoHZc4xK+Z6IY9IxVYjdcLje2UQ2pH3PUciaHcT3s2rErI83Neaf+4unZ1sKffEsNEOu
         u1dw==
X-Forwarded-Encrypted: i=1; AJvYcCVdSEjUbNGU3diLJzWNH4lZ0pvnb+2QIu30hK7UejFfy/Wfq7iBnKvdlz0lbf9g/y6ewnExMGawJU+o5qXkHgmMi7aleMHF8EEOd3m5
X-Gm-Message-State: AOJu0Yxplsc+k+cAQhcY1C8TLDodPqSk4/zdlgZzHcOhSenAp30mjhwl
	ktjp/2JprQEfMYYluMPhb/eotbEqnWVUSrrXs1pmCXQAI3xrDksq
X-Google-Smtp-Source: AGHT+IFjRgXbwhzzD/32gcfEiol/nn4vVD7ytzhFVIsl+UUcT22oB37EgXt7rBBwTgZlTBNEz8v/IQ==
X-Received: by 2002:a2e:8096:0:b0:2dd:d3a0:e096 with SMTP id 38308e7fff4ca-2e52005f693mr76119471fa.31.1715587990618;
        Mon, 13 May 2024 01:13:10 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:ac9:e686:c88b:6249:b2f4:9ae2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b8a77f8sm10399563f8f.54.2024.05.13.01.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 01:13:10 -0700 (PDT)
From: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
To: sudeep.holla@arm.com
Cc: vincenzo.mezzela@gmail.com,
	gregkh@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	julia.lawall@inria.fr,
	linux-kernel@vger.kernel.org,
	rafael@kernel.org,
	skhan@linuxfoundation.org
Subject: [PATCH 0/2 v4] drivers: arch_topology: introduce automatic cleanup feature
Date: Mon, 13 May 2024 10:13:02 +0200
Message-Id: <20240513081304.499915-1-vincenzo.mezzela@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501094313.407820-1-vincenzo.mezzela@gmail.com>
References: <20240501094313.407820-1-vincenzo.mezzela@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces the automatic cleanup feature using the __free
attribute. With this modification, resources allocated with __free are 
automatically released at the end of the scope.

In some cases, modifying the structure of loops is necessary to utilize the
__free attribute effectively. For example:

```
struct device_node *t;

do {
    t = of_get_child_by_name(..);
    if (t) {
        
        // some code here

        of_node_put(t);
    }
    i++;

} while (t);

//       ^
//       |
//  device_node here
```

To use the __free attribute here, we need to move the declaration of the device_node
within the loop, otherwise the automatic cleanup is called only at the end of the
function, and not at end of each iteration of the loop, being it scope-based. 

However, moving the declaration of the device_node within the loop, we can no
longer check the exit condition in the loop statement, being it outside
the loop's scope.

Therefore, this work is split into two patches. The first patch moves the exit
condition of the loop directly within the loop's scope with an explicit break
statement:

```
struct device_node *t;

do {
    t = of_get_child_by_name(..);
    if (!t)
        break;

    // some code here

    of_node_put(t);
    i++;

} while (1);
```
The second patch eliminates all of_node_put() calls, introducing the __free 
attribute to the device_node.


changes in v2:
    - check loop exit condition within the loop
    - add cleanup.h header

changes in v3:
    - split patch in two
    - fix misalignment
    - fix checkpatch warnings
    - replace break with return statement where possible

changes in v4:
    - fix commit subject
    - fix coding style 

Vincenzo Mezzela (2):
  drivers: arch_topology: Refactor do-while loops
  drivers: arch_topology: use __free attribute instead of of_node_put()

 drivers/base/arch_topology.c | 145 +++++++++++++++++------------------
 1 file changed, 72 insertions(+), 73 deletions(-)

-- 
2.34.1


