Return-Path: <linux-kernel+bounces-208303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8536290234D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F1A9282058
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 14:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671CA13F43B;
	Mon, 10 Jun 2024 13:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="GaRzqfUL"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8810712E1F1
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 13:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718027698; cv=none; b=fCNMvnVJEK2rN8KBNpik5A74CElFbp3pj7ajD7NYGbXa7EaEP+gsD5+ivhi6ik/KDn3BYmX+qYZw9Rap9shcIvoTJIy4GJ9XuSbHRMxBDtZGOr+OuGJm9Bx72hpsUV4C4HN//QnThPyjipKL8hc1CBRMGjx84HGghMgSbaZPvlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718027698; c=relaxed/simple;
	bh=lvxIxeL6Mm0yE1f5pw3ycsGiXjH9Cq/+WZaQIL07XPc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=ZvXga0rW1DJi5n6wTZaC+/OUDgiHktUIwKAhFRxzlPrFUaqTO+dPHXqSLxP98CgYPXIHsUI54PkfuV8/whTwhJNk7n4Wkyn2nV3PYDfot6Ufjn/ZupLYpH/rz//uXirWYBU3WbVNCBDBSCje7jfVDMo9roJlBe34l4X7EBYHgFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=GaRzqfUL reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=QA1XVnVP1x+MLWoIZQZUTYtXlLK83VadTR0Q+V0rM3M=; b=G
	aRzqfULtMjVEEauo4cfNotD0cYY+Itymj9zJy8dgyAZ5qzxcp2APfUDOCbve6p0n
	aX0QnO7a7XvrlEiqc2PcrFp8etF5VSu1VNfjOUnp9dAWihkGw8NGuEnlInKlDSCD
	weLcWtCLi7g0RMkuU74fOuda74bdH2bO46WR4bF0wI=
Received: from 00107082$163.com ( [111.35.186.64] ) by
 ajax-webmail-wmsvr-40-128 (Coremail) ; Mon, 10 Jun 2024 21:54:16 +0800
 (CST)
Date: Mon, 10 Jun 2024 21:54:16 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Vasant Hegde" <vasant.hegde@amd.com>
Cc: jsnitsel@redhat.com, joro@8bytes.org, suravee.suthikulpanit@amd.com, 
	baolu.lu@linux.intel.com, jroedel@suse.de, kevin.tian@intel.com, 
	linux-kernel@vger.kernel.org, sivanich@hpe.com
Subject: Re: [Regression] 6.10-rc1: Fail to resurrect from suspend.
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <682dfa6e-7f81-48cf-920e-14d4f2c46fc1@amd.com>
References: <31f16e4e.afe2.18fc9d5dad0.Coremail.00107082@163.com>
 <20240610131550.53651-1-00107082@163.com>
 <682dfa6e-7f81-48cf-920e-14d4f2c46fc1@amd.com>
X-NTES-SC: AL_Qu2aCvyZuE4u4CWfZekXn0oTju85XMCzuv8j3YJeN500liTt8QkkdEZ5PnHm/8SMKjCHiSGtbgNvy+V8Yq5gboQXXi2qHLwBdjLSnEGI3fu6
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <373a0740.2481.190026d9d87.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3f4eJBWdmgTA8AA--.34549W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbB0hX5qmWXyRc+OwACs-
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjQtMDYtMTAgMjE6NDQ6MDIsICJWYXNhbnQgSGVnZGUiIDx2YXNhbnQuaGVnZGVAYW1k
LmNvbT4gd3JvdGU6Cj5IaSBEYXZpZCwKPgo+Cj5PbiA2LzEwLzIwMjQgNjo0NSBQTSwgRGF2aWQg
V2FuZyB3cm90ZToKPj4gSGksCj4+IAo+PiBUaGlzIHN0aWxsIGhhcHBlbnMgd2l0aCA2LjEwLXJj
My4uLgo+PiBJIHRoaW5rIHRoaXMgaXMgYSBzZXJpb3VzIHByb2JsZW0gZm9yIEFNRCB1c2VycyB3
aG8gdXNlZCB0byBgc3VzcGVuZGAuLi4KPgo+Cj5JIGFtIHNvcnJ5LiBDYW4geW91IHRlbGwgdXMg
d2hpY2ggaXNzdWUgeW91YXJlIHJlZmVycmluZz8KCk9oLCAgSSB3YXMgbWVudGlvbmluZyB0aGlz
IHRocmVhZDogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDI0MDUzMDEyMDExMC4yMjE0
MS0xLTAwMTA3MDgyQDE2My5jb20vCgo+Cj5JcyB0aGlzIGBJTExFR0FMX0RFVl9UQUJMRV9FTlRS
WWAgKG9uZSBkZXNjcmliZWQgaW4gYnVnemlsbGEgWzFdKT8gLU9SLQo+dGhlIGtlcm5lbCBwYW5p
YyBpbiBhbWRfaW9tbXVfZW5hYmxlX2ZhdWx0aW5nKCkgcGF0aD8KPgo+SWYgaXRzIGtlcm5lbCBw
YW5pYywgdGhlbiBwYXRjaCBbMl0gZGlkbid0IG1ha2UgaXQgaW50byByYzMgZml4ZXMuCj4KPgo+
WzFdIGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjE4OTAwCj5b
Ml0KPmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWlvbW11L2xzYWhiZnJ0MjZ5c2p6Z2c2
cDZlemNyZjUyNWIyNWQ3bm51cXhnaXM1azZnM3pzbnp0QHFzbXplY3dkam5lbi9ULyN0Cj4KPgo+
LVZhc2FudAoKWWVzLCBpdCBpcyB0aGUgcGF0Y2hbMl07IHNhZCB0byBoZWFyIGl0IGRpZG4ndCBt
YWtlIGludG8gcmMzLi4uLiBJIGhhdmUgdG8gcGF0Y2ggbXkgc3lzdGVtIG1hbnVhbGx5IGV2ZXIg
c2luY2UgcmMxLi4uLi4KCgpUaHgKRGF2aWQgCg==

