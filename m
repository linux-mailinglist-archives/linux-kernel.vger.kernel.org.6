Return-Path: <linux-kernel+bounces-395639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 130A49BC0E3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 23:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8730CB21BB6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 22:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104A51D5CE7;
	Mon,  4 Nov 2024 22:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kpMl9DZ0"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF371D319B
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 22:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730759278; cv=none; b=e/1z4O/1SOp6GsRg2Iedrleqwi9LV/GQmhrdFHgdiCmCcI7Inyc9w8IVZHJFRiBGkp0cKtsbMCweZtf3k9WL4GHSABpjgMtYjwrbsNrIdQmgbjbeP+5Gnsuqalw2QK5LhyYBDkVC1LNxkf7nOtwCfizFiIZr2LjnYbkhNh7k/bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730759278; c=relaxed/simple;
	bh=TvzIPlQ5D61Fv05UDW0gkeINVQdDASr4ry+iQ28HvLo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pkWPiIWo7+EYAWG23v0DoeYJB5BYuMCkBpxdQSysR8KalnT8P12PYQdQyDbKzqKIAYLf99X4Fg0qw/q6EE5C6jKR7Vr6pyfaZX8OAufyv3NQ3nyN4AqvC7uT9RADfNr3qEyjmQfGIZ2NdGFWRMye8obSmCpw5lbIssjOTVK+X8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kerensun.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kpMl9DZ0; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kerensun.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e59dc7df64so60988737b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 14:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730759276; x=1731364076; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eLnYMXR0eJ0WVOXHu5ohmzLISM/yif+XEsN4c7cAuuw=;
        b=kpMl9DZ0UbCoxaOwgiYVtpYbyQKBnzNVs14AIggjGskr+hXM+iFbrQ/xJfv2mVWcOQ
         qBznlE5kye0fasx91ydlggIYREzeikW+aooAu3v4EOLQESuitwpjrrhjbTuxqOuFTBsy
         OM5r6AFAasHa5pu+Um+pjvLaCCwZb62Pr7QBq/mIBsmDQGhVEOaAMLMK91OI0grcCvQn
         sysvyynGCWQ9jsbo3q8PNqsrHV2fcukRhd1YRuaAWS7JXc0eVTKV6mYxyBK/HAFXY1qt
         3Lee4YJvwGSYNwDstptc1KhD93nmhp+LF07aieDDkLgUj0IlSUNl1GaXiIYDTkhC4VMZ
         2cHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730759276; x=1731364076;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eLnYMXR0eJ0WVOXHu5ohmzLISM/yif+XEsN4c7cAuuw=;
        b=fD3gRMtfUGf2Uob6NxqbfjBw0k/Q2Qo66DYNIkSyq0dE28aqzF4rGPFofShMHjRYTR
         5aALw0qYeRh6g9CdHKUDF+EtWMBp1l1WhRNq/nubt8IvfWOezboOnC4z8SxOqHzbZjd9
         FQK5kfv2YbKvgHHuVdDGvYVAyyzGJboHCjAla/0sKPvcRw3+t91QbYOqM/W21HONpmTd
         a6QNbyyXGt7kqVPgf6C26OOhaZ9APV22uWZlpD6/Yc/26Xa3udoIlcgIgO6fjNvuZxoV
         9D4Fd7czu+SxpVzl4oFMZeqQAnZ5wo0FYVnnDKDJAbOivMn/rWswoKjKRhhMKclr9FOe
         VRow==
X-Forwarded-Encrypted: i=1; AJvYcCXmKgycBRylXELkkqnS9UWYFkeTmYY1nQVgGqnSib8fgqKVwapEhIU4efgxpdxv+XQyb6xUdaeAg5wHHOM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8SvrxdqCXyoRZKN95cc9rQHdPTasXNdkAh+H0pzk666cOGflj
	xOs8yR34OPnbDcMQ7KprkN7Q3gmkyyo2ajZl2NIB+jPQZBaWyq57XM0I0/rdu17kCa9/6A8kPGK
	F6j8oQegNjw==
X-Google-Smtp-Source: AGHT+IH47mWu7tl+7jg9xhI8qwcAtywVoHaauR6iyeePJxOJs2WneI4NavVt60+ZcgqgGKJ9n9EcOYgF7JbeEg==
X-Received: from kerensun.svl.corp.google.com ([2620:15c:2c5:11:2520:b863:90ba:85bc])
 (user=kerensun job=sendgmr) by 2002:a05:690c:7004:b0:620:32ea:e1d4 with SMTP
 id 00721157ae682-6ea554802ffmr2326227b3.0.1730759276104; Mon, 04 Nov 2024
 14:27:56 -0800 (PST)
Date: Mon,  4 Nov 2024 14:27:33 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241104222737.298130-1-kerensun@google.com>
Subject: [PATCH 0/4] mm: fix checkpatch.pl warnings in memcg v1 code
From: Keren Sun <kerensun@google.com>
To: akpm@linux-foundation.org
Cc: roman.gushchin@linux.dev, hannes@cmpxchg.org, mhocko@kernel.org, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Keren Sun <kerensun@google.com>
Content-Type: text/plain; charset="UTF-8"

The patch series fixes 1 error and 27 warnings found by checkpatch.pl in the
memcg1 code.

Keren Sun (4):
  mm: fix quoted strings spliting across lines
  mm: Fix minor formatting issues for mm control
  mm: Prefer 'unsigned int' to bare use of 'unsigned'
  mm: Replace simple_strtoul() with kstrtoul()

 mm/memcontrol-v1.c | 63 +++++++++++++++++-----------------------------
 1 file changed, 23 insertions(+), 40 deletions(-)

-- 
2.47.0.163.g1226f6d8fa-goog


