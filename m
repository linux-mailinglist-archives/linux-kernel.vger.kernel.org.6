Return-Path: <linux-kernel+bounces-426106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6959DEF03
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 05:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35FEFB20FD9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 04:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0F113C3D3;
	Sat, 30 Nov 2024 04:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="c1B4BF3t"
Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CF629A0
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 04:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732942782; cv=none; b=BApwnqt6BrcNIx7RXo+YNNx1EGm+jRPntY2mJMPdiYJnuh5e8z2YOJRDCeTl3uAxNTgAUzsm7ccrrhNjTyiQlkPISW1CBV4c50eQblE7r8aMQXcvMNlSl9m8xG52R/ttbyTv0yoyYcHQQeESrX8oyaTOQZvmxZSFKAQB+yIa8vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732942782; c=relaxed/simple;
	bh=YFtkqhNjbd5vFkZwCOnIIi1SFmWs7ecSaJNCKjzwktw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ki5+wIqKwMXKhBuajWTyu4isrY2nG8+oJtDjOuodabiuLb7amiW3Jx8q2W5t/O50nfTTksKByF7zEJMqnWjxc3YRM1xUiGFyzetjxP/kmrVSTY8nn899R3gQI/0Xby/iC+VjhNJepxJJeLYwqWZiJCzh60jmTUtDylnoyeXeW18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=c1B4BF3t; arc=none smtp.client-ip=203.205.221.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1732942469; bh=YFtkqhNjbd5vFkZwCOnIIi1SFmWs7ecSaJNCKjzwktw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c1B4BF3t2G4CWAXixQlkBU0u6LEJw3dSIiEqxd50xUWvSYDFAaf8iIpPIiH7yYEoB
	 AyygME4Ej+dqECsJEkvBGXhw0ZZ5kaN+0j6MQHP0HQI73kf6gQk5Gc4GcmaPMqo5mA
	 pyiXjJ/Eq++nZU4SKuYQOdidRqpfGEQGy42ybhn4=
Received: from pek-lxu-l1.wrs.com ([114.244.57.34])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id D9B36827; Sat, 30 Nov 2024 12:54:27 +0800
X-QQ-mid: xmsmtpt1732942467tasnhf03m
Message-ID: <tencent_7B89671C3C9D36B6964636904B60744F7709@qq.com>
X-QQ-XMAILINFO: Mm/8i8/T4ynexcsPg9G5PMAzcy/ymatxaDiWsCWeweT2acFcwffpjX9E3Bvku4
	 W5Me+aif1hSIE7TYEcxUCFMt0HsalfI9eAcIQ1wTUi5W9ybtKqfmSO+FCSXCS/gaJojf0YIy2kLM
	 jtqKu7W77mBQlc5R1f/3UpqIJqS2ou6QYN6A/SAafeaD9quzU6oVU8httXL07tGSiUn+7z6KF9MG
	 HkbYILWRMtd4xTi/bA3nQmwECdqYrJKUO6aLiWM0aBmqcz6jdfdj4xSiQX8pCkmdr1scnF54FvOY
	 YP21AGnNz6PmIqA46Vz5zpBk44VHYLRs/m8tYfDcPp3uMxuqPNNF9eHlgsnw13qh8xjF/lwoeFG/
	 HCCfoSbBKoMPxbf4RqY5WxEGqwEj2pchCGXUAJlYnsCs0lQISJ8Mbpk6tXNNuXRhCjMxA1n8j+ik
	 kStL1nyN5eKPtjRXI0waCTJ51rnyh7+mx8y9f+TRGaNoR1QBvRuwdU6zFZ8kb70rTCwoW8fqViyd
	 rtL3LaEkQcA8WyGMHkqgCtYZIHqLQM6agSabpA9WcwcswidZ3KRMtaXNgJiRXA/10mY3+W0zwjr8
	 3nzV0BWGs2qAk3yzEcPxfZd/53ra3hRlHbkPTwWBOCObE3LC1W0CNlhN1VTsP0Zw4JqI8Lbo1cZ+
	 eQhF/Q7fdA9Hy1dnxbJkRdMSXH8lw18T8TpXoeK0nulsOURic45wDEiyYFxQdQAr/pAdARQs4xRJ
	 7xrRNzVLLqqAZ3FoLIKYECWUwZNUJ42tssnRQcb/UqqbU99odAn2l9YQxlQlJJTT6tkS+2N719d5
	 wCHTrMQ6NALyqC+gfxMPWG/Mwyzr+Ym2B3PCVfY6s0DnpGECGUwtTeVaVT2ix2vefnkUhsrg3qGA
	 YE3kubL50d
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+41821903c04037f57f20@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ntfs3?] kernel panic: stack is corrupted in ntfs_printk
Date: Sat, 30 Nov 2024 12:54:27 +0800
X-OQ-MSGID: <20241130045426.1991232-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <67477394.050a0220.21d33d.0026.GAE@google.com>
References: <67477394.050a0220.21d33d.0026.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test: https://github.com/ea1davis/linux ntfs/syz


