Return-Path: <linux-kernel+bounces-568394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAC4A694CD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FED919C1617
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3C01DE89C;
	Wed, 19 Mar 2025 16:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="fRXoqkhu"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C0519B3CB
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 16:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742401432; cv=none; b=UETuo9NVVMhv30nM5wwu6erVwgxoJ7A90IrVDK/NOqaX5xEcGC3kXrMhOK1xxILU6i78x/ECj8azp0aLE6hrKVSFcSURGQgmJdLEb213Owov0z157F4vrmRyEHIZa6r/mSWqEsKiNpJa0bkCORRp6cGCPIzeo35bGZE/oKVojK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742401432; c=relaxed/simple;
	bh=eXFMareT0j729yCGcXp+ap+t+xyUPza11v3I+cq8P4M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=FmMpZuiEBaeti3xkwDZH1D+2qVExFn2nV3T/5DriLwuk5Y3veSrCG98j0yeedw1gGZQV+aPaywFbJFlJEWVF0Mb9+FzJDBdyA6V2qTCfnhf+6pMBQq68Rzjvd+Gg/I+t3LNPv39pk3vvM2JLALqYuS7AzsSnZtTNIiebCxOyAUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=fRXoqkhu reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=YIOAJuGEapQGaq2je2RAXjlrvCrqas88zQ1RK5Ljcxk=; b=f
	RXoqkhuDREMxb7lCuv8Xa7RKS0NDmqjFhZASymkwSTRBYfIAuDBxU2Huqr94NgLZ
	/XTzZfA9hzWOJj8tsMZLi7XqFxrc6anPkrKMVG5K5SYj0nwewgPIUvR3foAQ9ebD
	oYY0f5z3GRcsmqCKxTpTjTWHyF+UE5t9Vh/Oz2xtWg=
Received: from 00107082$163.com ( [111.35.188.213] ) by
 ajax-webmail-wmsvr-40-100 (Coremail) ; Thu, 20 Mar 2025 00:23:05 +0800
 (CST)
Date: Thu, 20 Mar 2025 00:23:05 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Keith Busch" <kbusch@kernel.org>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: nvme interrupt counters got reset after suspend/resume
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <Z9rpeIsNlf6SBWi6@kbusch-mbp>
References: <20250319153910.18684-1-00107082@163.com>
 <Z9rpeIsNlf6SBWi6@kbusch-mbp>
X-NTES-SC: AL_Qu2fAPibvksj4yifZekXn0oTju85XMCzuv8j3YJeN500siT23TInW29GB1LQws6qEAOhoAiNWwNEzf96Qpd9VIFdP9wFSrgCIMWd+3+S8/Jz
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <349dba2d.b878.195af373591.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:ZCgvCgAHyFlq79pnfgsoAA--.61915W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiqBcVqmfa6klc6AACso
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

SGksIAoKQXQgMjAyNS0wMy0xOSAyMzo1Nzo0NCwgIktlaXRoIEJ1c2NoIiA8a2J1c2NoQGtlcm5l
bC5vcmc+IHdyb3RlOgo+T24gV2VkLCBNYXIgMTksIDIwMjUgYXQgMTE6Mzk6MTBQTSArMDgwMCwg
RGF2aWQgV2FuZyB3cm90ZToKPj4gCj4+IFRoaXMgZG9lcyBub3QgaGFwcGVuZCB0byBjb3VudGVy
cyBmb3Igb3RoZXIgaW50ZXJydXB0cyBvbiBteSBzeXN0ZW0uCj4+IE5vdCBzdXJlIHdoZXRoZXIg
dGhpcyBpcyBkZXNpZ25lZCBleHBsaWNpdGx5IHRoaXMgd2F5LCBvciBoYXBwZW5kZWQgdG8gYmUg
dGhpcyB3YXkgdG8gbWFrZSBzdXNwZW5kL3Jlc3VtZSB3b3JrLAo+PiBvciB0aGVyZSBpcyBzb21l
IGJ1ZyBiZWhpbmQgdGhpcy4KPgo+VGhlIG52bWUgZHJpdmVyIGNvbXBsZXRlbHkgYnJpbmdzIGRv
d24gdGhlIGludGVycnVwdHMgb24gc3VzcGVuZCBhbmQKPmNyZWF0ZXMgbmV3IG9uZXMgb24gcmVz
dW1lLiBUaGV5IG1pZ2h0IGhhdmUgdGhlIHNhbWUgbnVtYmVycyBhbmQgbGFiZWxzCj5vbiB0aGUg
b3RoZXIgc2lkZSBvZiB0aGUgcmVzdW1lLCBidXQgdGhleSdyZSBub3QgZnJvbSB0aGUgc2FtZSBv
cmlnaW5hbAo+YWxsb2NhdGlvbiB0aGF0IHRyYWNrcyB0aGVzZSBzdGF0cy4gSG9wZSB0aGF0IGhl
bHBzLgoKQ29weSB0aGF0fiEgIEFuZCB0aGFua3MgZm9yIGNsZWFyaW5nIHRoaW5ncyBvdXQuCgoK
CkRhdmlkCg==

