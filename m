Return-Path: <linux-kernel+bounces-531554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B530DA441DB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA40619C01E6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCB126B0B6;
	Tue, 25 Feb 2025 14:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="vAR6wyMv"
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C128A2686A8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 14:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740492357; cv=none; b=i4jORb09DAxDthX2hlAVQvRADRdT+ODl40zhKb4FsIKBf1N04VUnvJfTP92klDOugnn0doly36iyj3L1ZQxvlmkD3M+qdeTJ2QgV8m+FERfiicbqMepiT4M5NsneEGmsHM2g8HGgcsyYdw2wr5u3SycLrk8ydTGid0D0fyt4wbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740492357; c=relaxed/simple;
	bh=XLSpEGcC77wIQmZJksee9yhIIq3PSjdTX1aHfxbQZVY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QN66zq6LroPdWQ8wSxfKKTVGoWTC35AFhjU8VGKqkStwfmTSgbN3/X+ME0vKONscXPWWcSNjcq5vnvOhaQHrtWV+537/hA/1EsH1idQBHK0F1RpwRZviHXoVrOgH70edC98N5XBKLLnm2eTo+8SPCdEuC4d+DJX1nXq3Qppfw8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=vAR6wyMv; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Z2KBd5wcTz9t2V;
	Tue, 25 Feb 2025 15:05:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1740492345; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XLSpEGcC77wIQmZJksee9yhIIq3PSjdTX1aHfxbQZVY=;
	b=vAR6wyMvZfVbcbaiRKOMNdm12/hhF2EyyB3sqhwVOTPT1Yxhgu6eIK8wssbIej3sA5akqG
	TTt7XmiEBrU07kSQwLFS4egYesTPGsuE+WXKLyanVqrWa1bxIH0Jv+hybXoL2lCfQxTVbF
	/xE7bLNLIUXx7nNAjoXMfIzTxT2HUvo9H+hj3+SIpckMCDlKfqD1unlnk6AFGSH6QgCLVW
	I2PdQsezRx6eWyHBxORPmJg78tToQylsRsTPWE2DLGfAE7BHkHOCMgnqn3N8XBS58Bx/w/
	cHKwfUjKC2QXWSI8uCr3jVUS5baSA/rNaxyWfNsVwQrVYlLxA6p7irF1vzodiA==
Message-ID: <811ba40a31484ca5db4b0c380b9e67bec6517e4b.camel@mailbox.org>
Subject: Re: [PATCH] drm/scheduler: Fix mem leak when last_scheduled signaled
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Markus Elfring <Markus.Elfring@web.de>, Qianyi Liu
 <liuqianyi125@gmail.com>,  dri-devel@lists.freedesktop.org
Cc: LKML <linux-kernel@vger.kernel.org>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <ckoenig.leichtzumerken@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Danilo
 Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Matthew Brost
 <matthew.brost@intel.com>,  Maxime Ripard <mripard@kernel.org>, Philipp
 Stanner <phasta@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Date: Tue, 25 Feb 2025 15:05:41 +0100
In-Reply-To: <bc3ae5a6-9b04-4f1b-9045-2182138f748e@web.de>
References: <20250221062702.1293754-1-liuqianyi125@gmail.com>
	 <bc3ae5a6-9b04-4f1b-9045-2182138f748e@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: dd6a6nf7oo9ofk4m88751433po3qicsf
X-MBO-RS-ID: 63c041e860d98793a80

T24gVHVlLCAyMDI1LTAyLTI1IGF0IDE1OjAwICswMTAwLCBNYXJrdXMgRWxmcmluZyB3cm90ZToK
PiA+IFByb2JsZW06IElmIHByZXYobGFzdF9zY2hlZHVsZWQpIHdhcyBhbHJlYWR5IHNpZ25hbGVk
IEkgZW5jb3VudHJlZAo+ID4gYQo+IAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHNpZ25hbGxlZD8KPiBlbmNvdW50ZXJlZD8KPiAKPiAKPiA+IG1lbW9yeSBsZWFrIGluIGRy
bV9zY2hlZF9lbnRpdHlfZmluaS4gVGhpcyBpcyBiZWNhdXNlIHRoZQo+ID4gcHJldihsYXN0X3Nj
aGVkdWxlZCkgZmVuY2UgaXMgbm90IGZyZWUgcHJvcGVybHkuCj4gCj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBm
cmVlZD8KPiAKPiAKPiA+IEZpeDogQmFsYW5jZSB0aGUgcHJldihsYXN0X3NjaGVkdWxlZCkgZmVu
Y2UgcmVmY250IHdoZW4KPiDigKYKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cmVmZXJlbmNlIGNvdW50Pwo+IAo+IAo+IFdvdWxkIGEgc3VtbWFyeSBwaHJhc2UgbGlrZSDigJxG
aXggbWVtb3J5IGxlYWsgd2hlbiBsYXN0X3NjaGVkdWxlZAo+IHNpZ25hbGxlZOKAnQo+IGJlIG1v
cmUgYXBwcm9wcmlhdGU/Cj4gCj4gCj4gSG93IGRvIHlvdSB0aGluayBhYm91dCB0byBhZGQgYW55
IHRhZ3MgKGxpa2Ug4oCcRml4ZXPigJ0gYW5kIOKAnENj4oCdKQo+IGFjY29yZGluZ2x5Pwo+IGh0
dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xp
bnV4LmdpdC90cmVlL0RvY3VtZW50YXRpb24vcHJvY2Vzcy9zdWJtaXR0aW5nLXBhdGNoZXMucnN0
P2g9djYuMTQtcmM0I24xNDUKPiAKCkhlIGhhcyBhbHJlYWR5IGFkZHJlc3NlZCB0aGF0IGluIHYy
LgoKaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjUwMjI1MDk0MTI1LjIyNDU4MC0xLWxp
dXFpYW55aTEyNUBnbWFpbC5jb20vCgoKQmVzaWRlcywgTWF0dGhldyBhbmQgSSBtYWRlIHRob3Nl
IHJlbWFya3MgYWxyZWFkeSBoZXJlIGluIHYxLgoKClAuCgo+IFJlZ2FyZHMsCj4gTWFya3VzCgo=


