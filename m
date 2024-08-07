Return-Path: <linux-kernel+bounces-277571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F7694A316
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27814285632
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 08:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE211C9DDB;
	Wed,  7 Aug 2024 08:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="JN/4y98n"
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8B37C6D4
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 08:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723020168; cv=none; b=nVoxVaMhRHE1ptjS8YAQJhZY51wLjntut8QdBVw/W6TJS+je8WJzCbf153//198PvUFN4OEUv5IVadwd2lJ+4KYKywa3oPTw9HpRdHMz1GVpeM+jwRp0Ey26nxT/BnPwHmPx21VtC7JaEn610Y6O35MZSHEbPdRNiuPK4AYk6LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723020168; c=relaxed/simple;
	bh=AC5FXQbLkPBwVkZs3Bs3InP+z88Ns1CWbwSUFdRYQ5M=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=YqqumOdP+FWSySJOcLVK9zaLHE8rex1+rHmVzd4hXK+C+m0isouPlG2ujVEd8ZCZvHhvyOcNF3J9DHyx9q6s7mZjBe+DsRzBxXlEVgnBex7PGLoKXHVyQHmSp8cBE7R5sdDocHgngme4sCeOlg4FI1fPfNyy7eH7fkpV4TAFhMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=JN/4y98n; arc=none smtp.client-ip=203.205.221.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1723020164; bh=MIhj4S5GZcVrVx8Cfz000B/AeSXrx3jD2uJw0FOJvtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JN/4y98nlodw6ZeWViksonSyKWwVJ40VY23yNUNceLkPuEHB90Tky/M37fPHP6Un7
	 2QWXOX/PiTpcwNf9kpXn8SbFTmQwkThCLEAxR1hsDQNf7TU22e85jZxdCAkyowvVso
	 04FBaMYxhZ2YnnRHT9gHIfwbaVn6hxDfd2kBI9ZU=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 79B250C8; Wed, 07 Aug 2024 16:30:27 +0800
X-QQ-mid: xmsmtpt1723019427twu66f5xy
Message-ID: <tencent_EF9E7E1BB84BDC1B3825FFBA27BBE0333908@qq.com>
X-QQ-XMAILINFO: Mdc3TkmnJyI/wsuTk5GiXDIMJ7Xh72cQ6TTLdvEHy5G9ep/rF9HfhrrVhAtE61
	 cp2ZJKnIff7wQunR/ow9EwPcclPKdsVOcHra9vWl0ivoh+VyPdyfGhm5Sg9GvDsb6vbFGykLZT+o
	 cX80/3q5r5Zj3vMTDY1RYz37QLdCdyF8fjmogIKz6Hq6BaweY7FXPlrJzn4/x1CH2fsPRXinE82J
	 Bz6dUQaw4DkdEyQex0b5eoSzGEJfXuyYnnUAMDhQnM3yVYrwnwvWQ7fFdL/WlmuSfNIXV/FSsunO
	 toIK1h7NhkWYfEYcDq+QACykAGNFuv9OHNY+U0ZzusvMBHhNskYwyJXUcX88gTUNoQY+6cJokWw9
	 iK4MtRVm/DlKc7KA/4UVhP1X+XXBYbwMRpTq+1Nau7eEj4AD2Oj/ZGFO2vqAFMYMKHmsETd6QISm
	 Rbkx3a1vfsVLxw1Mvo07AJ/3/SHMnKr8zT3MDYqUbYRmfLEaXDXG9jWD50BfgB7n/QzvOADuoyU8
	 XisH6LwYhwTSH38GI/SJ8CO4fGfrfBreSdsmCX3K+nUT7L5IbZThuTU3Gnh/J/It5Je3fBxw5ini
	 q2DRfvyQXv3qtBoBNEdIBZpnsidyfRg8mLyy1R4k3Qj961tUbZr07ITtU3Q8Pxf9650z/DpI6x5F
	 rFhLv5Cnk9pYbgZcR5CKtdOvL0EVIx4wrvUhcK8p/KmDkj7AIGbpoet5elZYOX0A71gYJ7qHvwwi
	 gnSVQ3sC6tiNUBepWwU0aAFB7praQEKQBb3MwQbY0r3naxkuZn7Ldf79/IDciZJhN6W/Dg3djhNT
	 13ncwajP48kM24taTWWyOjD3qEJX59piRT75eFp7Yq73jh1MX/JHpRQ7mgoXQsnr+yEICAb+aoOA
	 QFMQBVfUunmkBvFxKcv/rf4Gk7DeNzLub85ZdCkpPuWT3AVGoTJpvAjEke5mIY9ZLaAfX3Q4/Y
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+ad601904231505ad6617@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [can?] WARNING: refcount bug in j1939_session_put
Date: Wed,  7 Aug 2024 16:30:28 +0800
X-OQ-MSGID: <20240807083027.213665-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000af9991061ef63774@google.com>
References: <000000000000af9991061ef63774@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes: c9c0ee5f20c5 ("net: skbuff: Skip early return in skb_unref when debugging")

Root cause: In commit c9c0ee5f20c5, There are following rules:
In debug builds (CONFIG_DEBUG_NET set), the reference count is always  decremented, even when it's 1

This rule will cause the reference count to be 0 after calling skc_unref,
which will affect the release of skb.

#syz test: upstream master


