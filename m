Return-Path: <linux-kernel+bounces-324390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE013974BF0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 09:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23B721C24AB4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 07:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E557613D601;
	Wed, 11 Sep 2024 07:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OOGMfHdD"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A1F39FE5
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 07:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726041536; cv=none; b=cJ3w7QUbF92XFZ4FKEpDAQOCJC1oi5FGy8WFTd1mxgHQOMMaM4E0q4sGbP105eSdUKFAcGYkLoPdMe/mBFnYba1xwt6wU4O5usBh9iT45r6Zu0t7L1k1f1faM8n1GAhkrJH0obcJG4tHmHoAegB8j4EXQ7We/3ZFtcR8Lh3fL+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726041536; c=relaxed/simple;
	bh=4JsL+3kidMLwcsHvK4aaiB2YieNwR4iKsTqskubRSN8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KQl9R1AOXW2BqjJCbFFd56QrmFZO3WmvIDEwQT7mm89ReEZDWFHiia9Q2kN3X8rx75BAc9ZkMeISy9Jf5OZMHJaJ+IQLKAd2rrVMlTsassZfwqcRMQYRUiaS+X4qanfUGhimcf5X2NpOaxp1c+nGwn4Czo6ycj8+DCOywdqiES0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OOGMfHdD; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a8d6d0fe021so385432566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 00:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726041532; x=1726646332; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fJ1ASTjb5hX+WxeLuk9CuMjsO14cU8MsR1XGN8DocxE=;
        b=OOGMfHdDL0m3wLA730I2sck5z1bRa80jVWLicohicti6n5DOhj/ixFO2fl1fKpokZI
         yQ35gT5aQuJX4PHtlBK7xhyNZ+XppZHIiYxQQsatXZ2zVsfPVrVDbPALnR/3UfepYeUQ
         iJNOQobyf/xm/ABieCVTZY3HlfTdPwvhegGZPEom6pIw1BgyxMm0vqFk5mNOZzbAKKxr
         8TKvWedjydKbbCCdVOLc1GqkJhWev67OZUz4495y9SIHshsnZtknnNxa6RD08b8eGLds
         giJYD5cn/Xa7wlveX9ooaa9m0HRx5TSt3ftdPmzApqBSwHJK/E3vK2O8WLfZ8V7vSjYT
         j34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726041532; x=1726646332;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fJ1ASTjb5hX+WxeLuk9CuMjsO14cU8MsR1XGN8DocxE=;
        b=kIIM9oLD+rmfc4Giaoacj/09zm09Z1cO3lItJyFDLIpZY1lsTacb3lDkKNh67LbY1G
         u92JcrUa/AW+JqwlvUZUc29eiDiH75pcY0jlaU5Umuawfm1CKh01r5bp/BBKvg/UeGXM
         ZFrvIDTj3NTE40/Tb/l7UqG2mm7pMP1cCrIXuo524gk6DzP51Jv0N71P/AbNJ8UJHREp
         SYr6ViApLDsRpcnX/vT7Wh/LXNbNIvMeChLW77VeaF9nKaBPdIEIchN+oGAbhDBqJ3Y8
         0NhS723t9eivVX4cs2SLHhHJKlK7vJ4D+qh4lVJhII3HHvOKFsY8JLCScr4qyxh/QWHx
         MO1w==
X-Forwarded-Encrypted: i=1; AJvYcCU9kKtr9TucjzjFyy2icLewu9HfBbN6cBaCvx/18oiRA2GPJvF6q/TOkTAjlCxlWpCHe5vArgN7NgGWeoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzKyGofWoRdeZ6PASmmUfrB0Z9/O0axx7IB8/OUdBN97BfoJ5V
	1p1P+2i2Dk8KnAK7xL0ULDcOjnuHUcMLLJSoOART+0R+c56Ci5MpnIS90AOEyz0=
X-Google-Smtp-Source: AGHT+IGnF/CsQo/WcRDi9WpPtWj+FwdgPhFRtkxX6764oM87KsqsNrUVS/Z8JoqJHtGZL8SF353yNQ==
X-Received: by 2002:a17:907:7ea3:b0:a7a:b385:37c5 with SMTP id a640c23a62f3a-a8ffaac1fe4mr348902666b.17.1726041532422;
        Wed, 11 Sep 2024 00:58:52 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25a2b281sm588149466b.92.2024.09.11.00.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 00:58:51 -0700 (PDT)
Date: Wed, 11 Sep 2024 09:58:49 +0200
From: Petr Mladek <pmladek@suse.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>, Jan Kara <jack@suse.cz>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
	Tony Lindgren <tony.lindgren@linux.intel.com>,
	Yu Liao <liaoyu15@huawei.com>
Subject: [GIT PULL] printk build fixup for 6.11
Message-ID: <ZuFNuY0sGlrCgZpy@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

please pull a printk related build fix for 6.11 from

  git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-6.11-fixup

=====================================

- Fix build of serial_core as a module.

----------------------------------------------------------------
Petr Mladek (1):
      Merge branch 'for-6.11-fixup' into for-linus

Yu Liao (1):
      printk: Export match_devname_and_update_preferred_console()

 kernel/printk/printk.c | 1 +
 1 file changed, 1 insertion(+)

