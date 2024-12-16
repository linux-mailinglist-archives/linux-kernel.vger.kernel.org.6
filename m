Return-Path: <linux-kernel+bounces-447414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4930C9F31E3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 14:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D9F8165667
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 13:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC962205AA7;
	Mon, 16 Dec 2024 13:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="jL7puin4"
Received: from out203-205-221-210.mail.qq.com (out203-205-221-210.mail.qq.com [203.205.221.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC13205AA1
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 13:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734356667; cv=none; b=FqiG/TgvLpQVXmC5RYiP9P5Z4d+18jFImvY8MhqBNAodyIDBcQGrNTxhwHGmK7FXN57FyBjkIAibpgJtP2Eu3okj8d5uSGx/iDoGOf8us2Kt51VmJNOAmaLsS7olPg7O91zVMBKwCoS8WRzont8CgFugP0sWxsT2ghwWEZ6+IWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734356667; c=relaxed/simple;
	bh=04zQHk+cxFKJCggWSm8vFhaLmIIlm8UVuZdzF8ZTqvE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=jX+pmrB0N82uiJoPyVJ0wHcAoZvw8IuTFS8CBXAw3VOgVFpdfKQK9IcFpeel/YKneCUVmO4d7XPGLHxRsieQ4UOyqUO8C6lj9FvOa2G1p2iE1PUdKRLpdwPYv3OlyoVZno6BzZGdlPUzbV/o0LYv8REnJ5N/D39n5ktlosZ1pew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=jL7puin4; arc=none smtp.client-ip=203.205.221.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1734356655; bh=04zQHk+cxFKJCggWSm8vFhaLmIIlm8UVuZdzF8ZTqvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jL7puin4UX50aE8qb/cWYVtlsZyiMsGxa1iByWs98CitOdn+2vDzno3khZFkBl1XT
	 7tFFWHDaY5UE+k4PxAJ1183GxsUN2DcmXNcHrl3MwMfPit72sMAPbpwcpBnWzDbLU9
	 VItjdMEvb3Kw0aFT4OmYYCDZCWWc9jxLpxQUNMVs=
Received: from pek-lxu-l1.wrs.com ([114.244.57.34])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id AB714AFF; Mon, 16 Dec 2024 21:42:55 +0800
X-QQ-mid: xmsmtpt1734356575tbbss4gr2
Message-ID: <tencent_0C51664E3C61368097F836764B8274597609@qq.com>
X-QQ-XMAILINFO: Mnoah5gai5w93f33iG2rANk9zpwDYXOP99XsNInzvEl217MlLhr4nVr9xoi13M
	 qzP75iY2bbWCTl5i0jByn+pt9Ky87A9kqKxsdmyfmN9uZ8X6tHv7nxhpT1wm2eHZXyGT1bLEdCOt
	 I8xSi2zh/pQkSXlpqssUCOsFyvctV5+0n1mCQxKGPUZWdjuOEL/SndNVXm0L8AwGIwjQJsAWQOrQ
	 Wdk9n9S0zCvsPepJFDRbto9PbMQAQwVcrOMmrX9LWLNklpiXfNt8zcQGNVkEPPGuzOWX02pZ1GKP
	 zdzA0vdl8LprQztz+IweOV7lDRyjvFGbmb4PafAUirMcibeWD5iVCnoKw7tC3CKX8m6goxHoUuER
	 +eIQnRkE5vMD/0TqXOCEivmFSQt0mkw+wk561OIEcZx0M87onBjWW5JWFrxzCf019MXI+8Pc4ULz
	 J+QVxTs5wOhfmVe3yeKjOp3anDKhKY81yygaL/GHob9UgolpKqXmRek2K4lYd/CHT5NvbPKOUOCa
	 qiHDd0kBB/+EBrkw72lqB1ZibLhNfWyE0x5KivbDg9UjY3cUwXXqFaUYxq5pxKF/SOgZiGS+ACSX
	 bWmJicX+Q9EVO7fVE1NLHCpaPzdFJn9r7Agmuas9EH8/sbSRHs9NhHPe7E6C6oifRTqIN+GiEZjF
	 xsXzwDfUmGE50a+s1lZeCeWefoXceQixlek6YPXRe3cjeTLL8h+q1EIqiAiSYKnwkcfQ4N4nEO2Q
	 DvjxdqQUgCysYNHHsQtLyiSRvkgXUCkdPyRWafe/B1k0bLcObm2Vw1DsGukh+fk61xGfW8RzP5+/
	 Xac8p+HWiNwxdRQry1L6epd4cGonFpLQcGEAacBNsVD7j29NI6zVDc8xOGv8E1sN95rxX5WupM9R
	 78T47M5PI0VYKCiPJEGvAfFK/VHTKvQw==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+345e4443a21200874b18@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [trace?] KASAN: use-after-free Read in ring_buffer_map
Date: Mon, 16 Dec 2024 21:42:55 +0800
X-OQ-MSGID: <20241216134254.2376659-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <675fe376.050a0220.37aaf.011e.GAE@google.com>
References: <675fe376.050a0220.37aaf.011e.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test:https://github.com/ea1davis/linux.git kt/syz



