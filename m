Return-Path: <linux-kernel+bounces-393123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6C99B9C17
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 03:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1F351F21CB8
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 02:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4652EAEA;
	Sat,  2 Nov 2024 02:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Pzv6+ToJ"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708C333F9
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 02:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730512984; cv=none; b=rSMfkG4L0UkCfoa6owRy+MAEMwBCxKvUG1RMzRvhVq7Ph/7ISrXRhQmexvKe//AIwJUrmCkYpg3lvTr0QjgIAClgk6jsQxUKKWiO6tR68nVXZj7aOwRTuShLnWsVVUMHr5F2FeLpEmFm2PeLSbCY0F5aPFb1kP5dk0LQp3mlcPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730512984; c=relaxed/simple;
	bh=pMFMozzUZ5zBXpmPi5bdGsMbcBmWfnDsPgUJzUJ2E00=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=nUjOn6QP6aWw8zXPn9qJfI7owRFrMsU/05FSXcaTW5bojt9r9EUhGVOIfD45BvPrwQF5SHdNW4xoFkplvrO9p4om6ELxp4OetYC/hpMru93FRvKFS0nhxO6UStIdBp6zdPwoyVHbSsj825keR6ZAUIxfNDp98TX3WQRADZPidiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Pzv6+ToJ; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1730512675; bh=pMFMozzUZ5zBXpmPi5bdGsMbcBmWfnDsPgUJzUJ2E00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pzv6+ToJA7MBK4Tr5qrCPmREoVOAIVy0FnLgxJj8bHW0Lw/kp30CFPmxaFqhr+NKe
	 c41SCgmv8PIi7uItgNXLZif3MmT5BIW7qopOxEmPKIQU4qqWa31AbfdmyXzXUGa6EU
	 5RnlgXI4yDylK4jhZ9X8FyDg8cIoxt2TRncJ1fEE=
Received: from pek-lxu-l1.wrs.com ([111.198.227.254])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id E758DAB4; Sat, 02 Nov 2024 09:57:53 +0800
X-QQ-mid: xmsmtpt1730512673tij7ojqoq
Message-ID: <tencent_78E99EEC86CEF47AC26CE02E096EEC96BC0A@qq.com>
X-QQ-XMAILINFO: NFYAXF90nFLaTgNlf6kXlqgWVNhOvP5vAmWPSaSt0X2TP00XT4Tpt77BveAMwS
	 0hjwn46JMA9mLZIVG9x7sP70F+P/inEadVMEjM1M73hDeZ+HcT6X0uTmRrg6dBQ7E5Ya9JXuB2EA
	 mp9ABEr6fq1fVFoBIycskgxEOlTfkViHlqG7A07yu4N+ZptUjKGA5VAAX3OYhfXbcebEnq1pOywb
	 LDBJOtDD0NcRNm95/LGPw/L2QlgFPdaXDWtBtctG9OKAQ/46+2FCeZQYF/bs52STvyTLEA7jmlH2
	 aS+P2MeJ7xDTY1aWIwhJY/3aEbz3zmfIdyBQlG1zHFKgufF8SuJ7xt08YLV6ytFW4OFLM2dAdSeU
	 3kP0ajWuxzWaRZWS0/1EHg/9pWeYN4/2QuuE5oe4PZ2xncRSW0gbrouN0JLx58dXQCbKtwOdywbt
	 KKmBZ8hHw4RAk4ZMdgpgDhHmXBhC8/NpNx8MZaUpprPwJGCuCB8X+2hEK7C4ezv8bhKNUlbnmRm2
	 Pp/z1CPqUnKBt6AU45zy6PjD4RXrvmQFBLa1AHtcL13wIMWkl2EAEFP42nP8ue8LnJgqvlqYTcRb
	 ppiCyzwkAxY063valYi0VakeRG1tCnkwSjw+hWC5Ijx+Y/lqx+tE9MJoAb5Y/PCJBhWnGTq6tkCt
	 0kJYrJI+KyUMwrn2yebcduYnSQTR5GVMlyxpe+w8UwLFzP48hNiz4m269eI51Daa5PCLABn+SOY7
	 nzrp8TthAjfEMYhgYWK0NUtuOb2g24XeRzbi8BHuE8Qeg547UCT+sNeUeo/sOE3X5O34L+Z7OfNy
	 IKXCbmdssf9NgJNMmgEwVuY8P+MC1g3i5QjNBoL/fgILKWqjvn//n2DdW7+LzHrD2WACgxN9Sevk
	 gQcZzNvLGmfPgf2jxUjic=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+d2adb332fe371b0595e3@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bpf?] WARNING: locking bug in bpf_map_put
Date: Sat,  2 Nov 2024 09:57:54 +0800
X-OQ-MSGID: <20241102015753.4024468-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <67251dc5.050a0220.529b6.015c.GAE@google.com>
References: <67251dc5.050a0220.529b6.015c.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test: upstream master


