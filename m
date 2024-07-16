Return-Path: <linux-kernel+bounces-253534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A653F932293
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 11:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62C26283FC5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 09:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A85195806;
	Tue, 16 Jul 2024 09:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pb/iEJEe"
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B934A33C5
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 09:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721121524; cv=none; b=HgVIxCLvBRJxQ43jj/ww8OcTYBrE9o2pm6uVgASSL78epZsw0TMDm26VM+yfjvcZ7P952XkKNQGz3y5vcozyDnvD0i9kFoUVB0DAskD5Brz1rYT/1O7LumA4LlrzlVp+dZ7uchGs0XG91xY+yu1Ad0gw6AfaPNxW7YglU1A9b5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721121524; c=relaxed/simple;
	bh=nb3xb3sXwEanxjCXlbGAWGwIaoxkVr8ECUVkNCAabwg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=TUG3UytvkoZCm9lF01aBvGnirRozSdrkfhiUw8KBtsyMPurxXIWvhsmAecIkQJ9AJhOG0C9llvwxNJPbWh4rkgAnEduG2DuhUG5yfA8TSOMfA3hD4SHJMYbckwcLF98kBegWeJh68kf5y7nPy7sjC6JhyNIx9FQikOa4+N6F+wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pb/iEJEe; arc=none smtp.client-ip=45.254.50.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=nb3xb3sXwEanxjCXlbGAWGwIaoxkVr8ECUVkNCAabwg=; b=p
	b/iEJEeB0LvNrUnHOAehGFIUnRDLqzN3O7CYD4XDRIv4XwGDB+N7PPjGKGspSwS+
	GLQz00dhR9rgw0kZ/wRA/kVX0Pk3VDZjo59/iljlbE0GGfScm8dc0XR8ChpiXPG8
	KQwHr7ePHxD890K1rLcpVX08je7/56GvkZcNChtjes=
Received: from xavier_qy$163.com ( [59.82.45.126] ) by
 ajax-webmail-wmsvr-40-107 (Coremail) ; Tue, 16 Jul 2024 17:17:50 +0800
 (CST)
Date: Tue, 16 Jul 2024 17:17:50 +0800 (CST)
From: Xavier  <xavier_qy@163.com>
To: "Peter Zijlstra" <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org, oliver.sang@intel.com
Subject: Re:Re: [PATCH-RT sched v3 0/2] Optimize the RT group scheduling
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <20240716085926.GP14400@noisy.programming.kicks-ass.net>
References: <20240716052543.302383-1-xavier_qy@163.com>
 <20240716085926.GP14400@noisy.programming.kicks-ass.net>
X-CM-CTRLMSGS: z3no6nBsdXM9MTcyMTEyMTQ3MDkxNV80ZmFmOTFhZTg0NzBjZWQ0NmQ1MjJlO
 GZjMmY5NDY2NQ==
X-NTES-SC: AL_Qu2ZA/2Zvkws5imaY+kfmk4aj+k+XsG0vfUj34FWOp9wjCHp1AQlXU1tJ0H/1eaKCR2gmja5byVM7/5qUbd7TYYLQeXDscmwbG8rymwAIvzNDg==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <6af6feef.83df.190bad579d3.Coremail.xavier_qy@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wDnr5y+OpZmP0wuAA--.37731W
X-CM-SenderInfo: 50dyxvpubt5qqrwthudrp/1tbiZQEeEGXAnEnBpAACs9
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkhpIFBldGVyLAoKWW91ciBtZWFuaW5nIGlzLCB3aWxsIHRoZSBSVCBzY2hlZHVsaW5nIHBvbGlj
eSBiZSByZW1vdmVkPyBJIHNlZSB0aGF0IHRoZQpjdXJyZW50IGtlcm5lbCBhbHJlYWR5IGluY2x1
ZGVzIHRoZSBkZWFkbGluZSBhbmQgRUVWREYgc2NoZWR1bGluZyBwb2xpY2llcy4KSSBub3RpY2Vk
IHRoYXQgdGhlIGVucXVldWUgYW5kIGRlcXVldWUgb3BlcmF0aW9ucyBmb3IgUlQgYXJlIHF1aXRl
CmNvbXBsaWNhdGVkLCBzbyBJIHByb3Bvc2VkIHRoaXMgcGF0Y2ggZm9yIG9wdGltaXphdGlvbi4K
CgoKQXQgMjAyNC0wNy0xNiAxNjo1OToyNiwgIlBldGVyIFppamxzdHJhIiA8cGV0ZXJ6QGluZnJh
ZGVhZC5vcmc+IHdyb3RlOgo+T24gVHVlLCBKdWwgMTYsIDIwMjQgYXQgMDE6MjU6NDFQTSArMDgw
MCwgWGF2aWVyIHdyb3RlOgo+PiBIaSBhbGwsCj4+IAo+PiBQYXRjaCAzIGZpeGVkIHRoZSBpc3N1
ZSB3aXRoIGhhbmRsaW5nIHRhc2tzIHdpdGggcHJpbyBzZXQgdG8gMCBkdXJpbmcKPj4gdGhlIGV4
ZWN1dGlvbiBvZiBibGt0ZXN0cy4KPgo+KnNpZ2gqLi4uIGFyZSB5b3UgYWN0dWFsbHkgdXNpbmcg
dGhpcyBob3Jyb3Igc2hvdz8KPgo+VGhlIHBsYW4gd2FzIHRvIHNjcmFwIHRoaXMgY29kZSAtLSBh
bmQgcmVwbGFjZSBpdCB3aXRoIHNvbWV0aGluZyBiYXNlZAo+b24gZGVhZGxpbmUgc2VydmVycy4g
U2FkbHkgbm90IGEgbG90IG9mIHBlb3BsZSBhcmUgYWJsZSB0byB3b3JrIG9uIHRoYXQKPjovCg==


