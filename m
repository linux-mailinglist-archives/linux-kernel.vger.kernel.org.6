Return-Path: <linux-kernel+bounces-177894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B54588C45EF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 19:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5E1B1C21929
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6585821342;
	Mon, 13 May 2024 17:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="HSI2oNt6"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6571C6B4
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 17:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715621165; cv=none; b=WzCPvZA4yi/p+E4Rx5ZqvL5i9fCBKKguM0eq3GfuaAoUIjX2Qiub6z3cj3Fz4+MnIFh2t5WIslq1+llHOp63/I1FUeqZA6fL3SbbiAsIqYETVkF6WtqzpqJvjh8Amyv3grG33WyBX7sVMY7J3h9NM1a+PRo4iZGuSUWHDZoa3iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715621165; c=relaxed/simple;
	bh=bRxRdIb0qEI1l9lUD47p5esn/0bH1Sob3rRa5SRDNKM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=uMkWVD60PXYX801U2oUAkKAaWstpEJuzvHCjuBQzWeNAouxhGt64mu4XTQ3bYhNgTrERI6hDbCl5s4bE1DTDTaFuprmBm+zpASKw3DBuw0+b2xGdj+CTurpmI8k2yzHMEcsrnx30fg7wnJ1BQT2b3MCHDrTQO6HXEOYxnfl6nug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=HSI2oNt6; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:From:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=POuc8bRKw+ZVfGGWi70gcI/cCCyHEzzAaSLFlGjszDA=; b=HSI2oNt6Yh57ovfuHJ5icM3Rlv
	WsWN54QXqAd4ZXRDRyE5fUSi3VewXqwCc0Ih7lyZo+x3/r18FWYF06qArhZpunt/0fxs5CVA8XPbi
	DxrcO0lWQGt5jyWR3a/BHNU2oMDy5MAXxhkNzkRTbt0Epnd1n78rI42l7A3ufEAfMr7RwdSOjJhO8
	+ZA1X4J4huVSWAicVXQEIiRUftnycuVH2CCCTpMeoPubjugIulzYPyFnVYLCZq2MwFNsq3pAuRG6s
	ARP/5Si9zA0horNtHKetuUG9xbmCK78Ft6IVozTHlZswkImxjgpB/Jxwod+l54PWktDgxI38qzsCT
	DfpYLNsQ==;
Received: from [179.193.1.248] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1s6YpJ-007aPo-Vx; Mon, 13 May 2024 18:47:02 +0200
Message-ID: <92bacfe3-efac-4615-9d30-a6215f6bba29@igalia.com>
Date: Mon, 13 May 2024 13:46:58 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Subject: [ANNOUNCE] Graphics & DRM MC at LPC 2024
To: dri-devel <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Daniel Stone <daniel@fooishbar.org>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

The Graphics and DRM Microconference was accepted for Linux Plumbers 
2024! Please, submit your proposal in the following page:

	https://lpc.events/event/18/abstracts/

Remember to select "Graphics & DRM MC" in the Track field. The deadline 
for submissions is Sunday 30th June. The accepted proposals will be 
listed here:

	https://lpc.events/event/18/contributions/1664/

LPC 2024 will happen in Vienna, Austria, on September 18-20:

	https://lpc.events/event/18/

Thanks!

