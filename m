Return-Path: <linux-kernel+bounces-411515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 953639CFB5E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 00:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A8A0284BC8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 23:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBB51AF0D9;
	Fri, 15 Nov 2024 23:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wGsZWHPM"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D7818FC65
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 23:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731715071; cv=none; b=AJAi57q2zW2VT9bvmsRmK8P4KNktWz3YLCw43InqBA/qMBa+ovPc/BM0HnXtLel5V0KJFv1iMq7R2PMA0UCsX2ltY1zO+bcvAzMiKlHhBcc30RmxWTjPo4GnX+5HGyirFEt0PhUuGQ4ZKNeKxfVSu8uHyzuZ3825P2pIMApQcTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731715071; c=relaxed/simple;
	bh=4pH/4jK8LQaD3zhKr7EXmPSD8fui22bOqTjbQOiw9nI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=F/d2ysHOvbtUnhSabyCmzN+EEBuQb5XlLgMIcanvEGNfDql2aey0x0DZ+ud1h/AuHe+1o8NtmzS5GzXhaziO9MKpL0lUo+xlMjetG9qk3o+FQpwLjxnyEE+21aeyBbXe2Zxrz1z55HiSVypwRP6eYTc9/KxGdfnavGm4EoIQaGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kerensun.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wGsZWHPM; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kerensun.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e30b8fd4ca1so3281228276.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 15:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731715069; x=1732319869; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Nw3bU4V27TPmp6Re8ExQGjVU+DnBp9+SCSKcT6kc7do=;
        b=wGsZWHPM9DJFhYl7uYPChCdjLxC0U6w3Wjxr1b397gRk6h6PchEH+NmTkoBdEmLNb4
         WW9LyJ7rSqgqDnRXHQs7urQ+asNPGMWFwznVT3f7lx11Z9ksXnsNMAw9M8CCbWszfl8M
         UyEfqbZG7c4rYeMnF0bnIE5WrnxfHNAO+8gJEbO7KpZY/y/QWbfMA1QY13BvUajffJs4
         lNQvADMVHseOo2aRch6NX1HUVeWZkmJ0k2AwPzc1Rgl5UtEs8HWv4Cq1uQAK+yt2n6ic
         tWHzurJGC4GSctBpydVzWaGF/OpfoYvjIxXzHTK9HOvtEIv1mqeNmDqCNE1vDeTg6UNW
         u3DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731715069; x=1732319869;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nw3bU4V27TPmp6Re8ExQGjVU+DnBp9+SCSKcT6kc7do=;
        b=SjGThWSUZVBuOxos3OGCx/FmDdS1b5CPQ9z0qZ+q8Ftx1eIxbIk0BUucrqiADYjzGS
         WOztV+8b7UeADT0un8v8n1yenezgoMf1Li8+xivu950BYsb945uMTQxI4r7vBb+lvDwv
         YrBCZHLNitcQaIQS2bnzRmVf91wA6hCu3d3YePUmJuEhbytD0DuRw3pP+O0Zu2MehBbA
         C5/gqWglObE41ctmY/d4XDwedA/pdHlCO5bhcQeaFDpnK9EZ9EvbhF0t8s7aJx0Rf8XR
         PzFhU4aEhwFPbRSVU1kzX4uWMmd+Nr6/qulS5dPPM7yf7t4GxbEhG0bLQDOXiKPDkUm6
         2ygA==
X-Forwarded-Encrypted: i=1; AJvYcCXnSSXvjiW9Y/PGZ2EvginOfy233/Xl7m9pIBQkX+NcLuPzSgmCxZfvzOzwvmnjCD0FAPomCHxW2UN+1NU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4NMKuSlb/BdfGMQfOuUj6PnE6DaWJ1iU1SqS0C3l1zp2hta4o
	ptAprPvS8bOXN1QUIN0XUQF/FeqO59QlKQVD01KEPzhV/IaBDq4/uey3ifSvAThQrUvccQSTkKj
	denTAh7sT4Q==
X-Google-Smtp-Source: AGHT+IEWq7t1tAIsrlf5M+Kv66u7NJ88IRp2HxreC5eRJF9TCkRDpi6vsM+EPFKgV8XHfVDcd5aH59gbHkuWqA==
X-Received: from kerensun.svl.corp.google.com ([2620:15c:2c5:11:f2d6:8e6c:5a90:ef1e])
 (user=kerensun job=sendgmr) by 2002:a25:6b42:0:b0:e38:7c92:33c9 with SMTP id
 3f1490d57ef6-e387c9235d9mr800276.2.1731715069167; Fri, 15 Nov 2024 15:57:49
 -0800 (PST)
Date: Fri, 15 Nov 2024 15:57:41 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241115235744.1419580-1-kerensun@google.com>
Subject: [PATCH 0/3] mm: fix format issues and param types
From: Keren Sun <kerensun@google.com>
To: akpm@linux-foundation.org
Cc: roman.gushchin@linux.dev, hannes@cmpxchg.org, mhocko@kernel.org, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Keren Sun <kerensun@google.com>
Content-Type: text/plain; charset="UTF-8"

Fix some minor issues including improving formats, update params types in
functions, and removing logic duplicacies, most of which are warned by
checkpatch scirpt.

Keren Sun (3):
  mm: prefer 'unsigned int' to bare use of 'unsigned'
  mm: remove unnecessary whitespace before a quoted newline
  mm: remove the non-useful else after a break in a if statement

 mm/memcontrol-v1.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

-- 
2.47.0.338.g60cca15819-goog


