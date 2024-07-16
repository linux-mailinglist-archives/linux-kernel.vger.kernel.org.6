Return-Path: <linux-kernel+bounces-253190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E8B931DFC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 02:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6AD21C21756
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 00:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFE0A38;
	Tue, 16 Jul 2024 00:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YntR+zqG"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC49182
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 00:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721088828; cv=none; b=CcWZ7Cex0zBE39hpKFq1MXPmNn26XArH8y/0F1i6lDa/IZNgHxi3w9IEZx8iglr6e35dPHpzeT6VxGOejlLgsqnZFYQVhyeUPDzsDzcIYUcqnxMU2hzfdUm/BgfwY9qP9Bws0dXzV2xnq2X461H4LLRhLOB/k4uWq5ScGOM518c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721088828; c=relaxed/simple;
	bh=YdVCX3YywAJBa4Gk8PYuxk7t6BkBmlWRVXx/IJIZMl8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HSMrHLsmAnj5ZgplYQ4tagd9GQM0Aqkg3PzsnAYHalwUR1NAmbH5LTJW/iMtdkcE2tEwSHlxBJHbsrP4eE/q96XVV2cGkXGbnaOWjluOaYAJ4xUl5vpoaCrlTXguTWtLPJxi70mrSj7BKRAsfAs8iXf3D47r4dTcQrTwLserGOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YntR+zqG; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70af22a9c19so3672608b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 17:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721088825; x=1721693625; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=w2rODVH+LbK0mOeiSXNhDECcAPUkRLDUzDgrBzXz0aE=;
        b=YntR+zqGnTCNwaoRxUUb5BECl1tZ/xiq++MMZEjEh9+hSKvrVfAvdVdbwKNYV3QDCq
         lO1jWVzeoY37rmGSnb+tZPJcCEHuD/9Y7eoOKDFxUfUFq8RP//r9tl6cqNMrE/IcFn5i
         HrJR8BaVQxDyAQAZK29WV8ZQQ4vq7k4y7qoXxU0VYMREiUHg9/FJ2Qbzf0rOxnIfznMk
         ntRtuVPtNWZM1UJ2bG/7ppV8volenB7/l04WkQ31xMlTJehnQxkVovucnoXeIjgXJeSs
         xZd0ZLavde8SEIIt5toqYd6zR3eED8Tk558nycj/eXktQmVuIfs2bEq3wHhBTcIQX/To
         HjcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721088825; x=1721693625;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w2rODVH+LbK0mOeiSXNhDECcAPUkRLDUzDgrBzXz0aE=;
        b=DdI1MWaMbnWooNws52Q09ZP4z6b4KWPot0QZn+qIi0CjS0RQ74ct2/IqiwqKudiU9m
         wIAheKITy8z1kp1MqhUdzt4aBIcz3XhVIDXQ+UrIzUpK3uE8UC7YvWrRUwGN/9KID6KO
         EqnJWR5JXxfuiAW2Qxumj1y6UJExS9rC7JRmWMxdJGtFtYS8i6q6LNQoxSGqf7duMKo1
         37J8FyTmNd13dX/hBblmkeMzpnQ0PoKafij6N33geIHGhuN6wp/2zm355yFpDKC/lTu2
         2rbpN3n0RxAANQRHiTD0b2VbXziy9D4m2LZN5SmBHIlPjR8OYXg4J1ubBMnWbuE5o6JZ
         Lz0Q==
X-Gm-Message-State: AOJu0YwMyCsvhcYZW1rCSZTwtYRmtjMBHUXSSHPplOx2pMBBtviAQfTj
	s+7nx332K9LwHxqy1B0xwLXlCwtNS1vsqNeY7kccMiKecCGUukcP5eqVtw==
X-Google-Smtp-Source: AGHT+IFuEH31vIZZIuzbiQORFblDAYsIHjyEIuIPIS8Lha0IPvI8kX6Je/shlCGsXvQN9of/XOnrvg==
X-Received: by 2002:a05:6a00:14c9:b0:706:9030:895c with SMTP id d2e1a72fcca58-70c1fb67617mr908125b3a.3.1721088825431;
        Mon, 15 Jul 2024 17:13:45 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ecac7c3sm4949964b3a.184.2024.07.15.17.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 17:13:45 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 15 Jul 2024 14:13:43 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>
Subject: [GIT PULL] workqueue: Fixes for v6.11-rc1
Message-ID: <ZpW7N55a5usrGoVw@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit b02c520fee6327eb4b25696c5e2d6732f362213c:

  Merge tag 'wq-for-6.11' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq (2024-07-15 16:51:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.11-rc1-fixes

for you to fetch changes up to aa8684755a283536bd8ad93141052f47a4faa5a3:

  workqueue: Remove unneeded lockdep_assert_cpus_held() (2024-07-15 14:01:14 -1000)

----------------------------------------------------------------
workqueue: Fixes for v6.11-rc1

cpus_read_lock() is dropped from workqueue creation path but there were
still remaining lockdep_assert_cpus_held() triggering spurious lockdep
failures. Remove them.

----------------------------------------------------------------
Lai Jiangshan (1):
      workqueue: Remove unneeded lockdep_assert_cpus_held()

 kernel/workqueue.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)


