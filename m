Return-Path: <linux-kernel+bounces-179228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0128C5DAF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 00:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CF4F1C20D34
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 22:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D8F182C85;
	Tue, 14 May 2024 22:41:44 +0000 (UTC)
Received: from mail78-58.sinamail.sina.com.cn (mail78-58.sinamail.sina.com.cn [219.142.78.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E51182C80
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 22:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715726503; cv=none; b=n+zJfm/StV4BQP8BOdeg8InQCOR2rQ2/xwEzrXslJf8IewPfmRxD9IzlxWGkuCrdHfwDZzkXER3c7dBoK8WBfUkQ5FELUAV2CoSBwdpvuNfkZutjI3VIZm+UwAoI/050wfowbJ5+lv5S047hV99uPWvM2LFvpb3J1xEmbEpOeck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715726503; c=relaxed/simple;
	bh=wTowMFQeP+s8VNwXEh3brReMvOID0bPlrW7RzXlCHF0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NtfLtmSxqDiaTOFJpR4GYQnmVlJoUG0iQlrJGjO6QdAKLsoisKj5LZ4OEO/zkda1V16S9n/nKQjF1ljbFF6WsCOd/6xHbOps6ydqkwGu70RTleJLBsVjbbPwCVcYOqPZlv+zqwli+JwLbPJyW+4vC/ZJI/aKnGWPTR7HohXDBsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.48.224])
	by sina.com (172.16.235.25) with ESMTP
	id 6643E89700004537; Tue, 15 May 2024 06:41:30 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8668234210443
X-SMAIL-UIID: 1733999AA79743E18E1F2194E8D4C6E7-20240515-064130-1
From: Hillf Danton <hdanton@sina.com>
To: Sam Sun <samsun1006219@gmail.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	axboe@kernel.dk,
	syzkaller-bugs@googlegroups.com,
	xrivendell7@gmail.com
Subject: Re: [Linux kernel bug] INFO: task hung in blk_mq_get_tag
Date: Wed, 15 May 2024 06:41:17 +0800
Message-Id: <20240514224117.3191-1-hdanton@sina.com>
In-Reply-To: <CAEkJfYPH3SJ6J3kLSjMGqkWOzgbgKZV_f2Hq05cpZZv7RmhvOg@mail.gmail.com>
References: <CAEkJfYMhv8AxxHSVdPT9bCX1cJZXw39+bMFh=2N9uNOB4Hcr=w@mail.gmail.com> <20240514103742.3137-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 14 May 2024 20:07:34 +0800 Sam Sun <samsun1006219@gmail.com>
> 
> I tried to run
> 
> # echo 0 > /proc/sys/kernel/hung_task_all_cpu_backtrace
> 
> before running the reproducer, the kernel stops panic. But still, even
> if I terminate the execution of the reproducer, kernel continues
> dumping task hung logs. After setting bung_task_all_cpu_backtrace back
> to 1, it panic immediately during next dump. So I guess it is still a
> task hung instead of general protection fault.

Given kworker/u10:2:53 blocked for more than 143 seconds, or the subject
line, how could it trigger gpf?

