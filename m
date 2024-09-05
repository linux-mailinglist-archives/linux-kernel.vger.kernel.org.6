Return-Path: <linux-kernel+bounces-316933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFA996D734
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 13:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5442F1F23FCE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2211199E9D;
	Thu,  5 Sep 2024 11:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="WLkA+EYE"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C87199252
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 11:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725535972; cv=none; b=Tc/U5pXFN5kKj2UutteFUCth5VfDOSLO+MhkguXBBW9Ahwf+Nuxd9d5mewiRBU+w0i9dtpLG84pk6+IRsac1GcSFlfNBbjiA6ebInwVMYAfRvodhV+daQEJWbDTO43VRuTvSkazbzsALPJN8WngCXZvkvZ7ExtKZ6HsM1eH46XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725535972; c=relaxed/simple;
	bh=kFhA/Qv5rWim3v3g3Hj0b+57TeTX5HpaotzAdEfiR5U=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=hz1f0YqeHPVg3md3ConZaMxaQJ6JYbomtC7bvJlkblpO78GfujZPN9aCndbI9X5MMvUUaEzAU/B+RA6UsC1Bj4Z1EJPldi9DjuAAnpNB1DcZcPpdprnf88+Sa8jY5R6i5s4Uew1dkRFjKQTQJ9pujMKX9xVnMyLzF0PrwVEhsr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=WLkA+EYE; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1725535659; bh=Is0kaIHEOqUZYJxf0FtbTMe+6i+0nRp47P0uLHNKHN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WLkA+EYEuz2OOxp6Kl7X1c8wcGElEQ2KmV74YW/NE4TqM+lsy977MvHXsNniBEwja
	 R0wMboqrfgP+ONisVmHHJ2EB++PsbOwBV0mLIUXC/Nid4o0K30AMURhK4QiyCuFtBr
	 ZzyJn7B+se2W6tE5q28SYMNKbx6sZwdoS9PpDzYM=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 6E50C0E0; Thu, 05 Sep 2024 19:27:37 +0800
X-QQ-mid: xmsmtpt1725535657t13dh4uya
Message-ID: <tencent_0A6AED06CEFC7A8E6C402E156C009578E80A@qq.com>
X-QQ-XMAILINFO: MI8xiyr9SLuAQJRTD5JLeonz6MCirJeyq9i54AUlmHz+9f2HyuK4ryOJgvIeE8
	 EMKJuLBXTiEovETFQLR9XF/5bwsEkE9GAmpg7tBAqGgsmZc1Vc/6niRRjVSDmyhNzgHaF+aXJ0P1
	 un45wS7/EVlWWI8JGYY++jbyNKU+PtfjDq7tV3zl5pr/rF9ktX+dsGYD186hhfSLXc+GXSZY9I8b
	 k/6+A475UHwJC5NrXuZmy6Z2wG/rAz56kAkHlcUGDlVGA35LKVuQSy6vOluuJmT7322rOqz1ho4X
	 eglmqZtaFC9HJWAUY/0fV/xjrr0nvATo1/f7riQITDpfIvB6I7g/bMZtwFVyFNMTJCIZa2jkVtOK
	 iM+ObHvxlwi+fJfHo1HtAgYmtRdnRWQllXQJSYW34BMDsWTTW8IpxXAjeUcVf9e1Enaq354za4sY
	 FvLG/wlV++zjnle+hUnI1ULvOfp6S7fv9xW1QltjNDqq+DRCQrO11sqT+WopmGSk4NY4acRcsrA4
	 02oZWtn/akyy6dOLIlwkjKrPh+LmyYkBYTg1YhRUHLIL9R5g8B8jKwVtpddxTrHiIV9IgRniqBvk
	 Y+NCfdHqgz5QBkbsMmoXsWg8ak1wcA2rP4d29z7RLheLnSbMdYQYP/l7Z+kqaVNdPUUT34Oj951t
	 QFbiEFy+67iqxWCtcsphaZJP0v4dh20RPMhxNI99h8g+RreQjzlNk4Imm4fGralEzmElgKpmlZQl
	 mJ0bM9E4KvpVAgyYufdSLx3aU8mAmgJ1/JgVyrNaWCaOcvMmYuC7oo3iup6dUGhmmQNDPmY9ZwFx
	 2F777FbeDdCTiqDfsShu3ezjWaYQ6uXgn7291GUR0Sqhw6AGewX+SXZP4SCe+3flQOvRc1JounVE
	 haNrnZq4zwD/YiIq8F+2VVFRD82c+MVEdGVYGAFJCsVgDO8Eyrl/g=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] KMSAN: kernel-usb-infoleak in usbtmc_write
Date: Thu,  5 Sep 2024 19:27:37 +0800
X-OQ-MSGID: <20240905112736.39932-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <000000000000a338d6062149eb22@google.com>
References: <000000000000a338d6062149eb22@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

clear save user data buf before copying data from user.

#syz test

diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
index e9ddaa9b580d..19bfe25e675c 100644
--- a/drivers/usb/class/usbtmc.c
+++ b/drivers/usb/class/usbtmc.c
@@ -1586,6 +1586,7 @@ static ssize_t usbtmc_write(struct file *filp, const char __user *buf,
 		aligned = (transfersize + (USBTMC_HEADER_SIZE + 3)) & ~3;
 	}
 
+	memset(&buffer[USBTMC_HEADER_SIZE], 0, aligned - count);
 	if (copy_from_user(&buffer[USBTMC_HEADER_SIZE], buf, transfersize)) {
 		retval = -EFAULT;
 		up(&file_data->limit_write_sem);


