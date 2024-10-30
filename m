Return-Path: <linux-kernel+bounces-388274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A13529B5CF9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 08:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C8E1B23733
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 07:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CF01DF751;
	Wed, 30 Oct 2024 07:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="oJonf/SG"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E911DE4FF
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 07:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730273521; cv=none; b=biUOOZr8uPjrCwAHK8patYgYKPymzK4PLuGiwzwPAiwuurqoSTgjMqqabvYs6z8uMhwqVaEcHQ9swAdS56EuFR/hmatsD2AiwYb0jyWNTLVHgHX5bfNXKb1jID52Jz1BKAot4HrNAArVZJLcbUuhJM/yxjpMZWLwzDbqSGVyHsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730273521; c=relaxed/simple;
	bh=DpWnGCoIDJZ5+b+a4BqhyygyqQSOflZ46KZvpLf5uZ0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PvncZyZddxroNWzXSi6aTSNedu+0rXPQ+KrxcNSZvmrC44ezeVmw3QixN7xr6x0nEI8H5gc5u3edz4u7kDD2NrGUXmGZURpBSb581DSyqLqFMEqE4pkZv/SCv/0tPqB0/dCwdYL/B79x6i5GQ7kCkhfoljku15tllw7mue8Q/6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=oJonf/SG; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=DpWnGCoIDJZ5+b+a4BqhyygyqQSOflZ46KZvpLf5uZ0=;
	t=1730273519; x=1731483119; b=oJonf/SGvPiEuryaBiG50YcpxhnTfsKgvA59wKQsRYiR4ga
	l8loKwApylueyw4dI6Rko12CmMYvC/nGFSIp0na6ylA/crR1FFNJqFJcN4pyNC5VVtIIV031yPhOA
	Fy8voGYV+sFvaRCGIkD/+YhXgK6mPc9kwON/2cMVDlvCBYstB9aRAHcB62ivsgulLKvPttr2Yijr5
	ljxSAtJlxGSNuUZDBuEGRHi00WJSt6Xo9qufWxww731eZtdFUi29CgIdR/FEqcPGuy2naF/ajzubv
	iGBeZ+TQtIAZ10pZOCFNQkLwbJx7veIHrY12Yek4pkTgIZWOW0B9hy5qJ6FC9qVg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t63BD-00000009F9L-3xES;
	Wed, 30 Oct 2024 08:31:48 +0100
Message-ID: <2592d27930288d6631076de4f2f11c9f269f362a.camel@sipsolutions.net>
Subject: Re: [PATCH] um: Remove double zero check
From: Johannes Berg <johannes@sipsolutions.net>
To: Shaojie Dong <quic_shaojied@quicinc.com>, Richard Weinberger
	 <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Benjamin Berg <benjamin.berg@intel.com>, Tiwei Bie
 <tiwei.btw@antgroup.com>,  linux-um@lists.infradead.org,
 linux-kernel@vger.kernel.org
Date: Wed, 30 Oct 2024 08:31:47 +0100
In-Reply-To: <20241030072609.1645401-1-quic_shaojied@quicinc.com>
References: <20241030072609.1645401-1-quic_shaojied@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2024-10-30 at 15:26 +0800, Shaojie Dong wrote:
> free_pages() performs a parameter null check inside
> therefore remove double zero check here.
>=20

Ok, so, I get it, you want to make some cleanup - but you've just send
pretty much the same patch *six* times (although most of them were
incorrectly addressed) - if you want to find something to experiment
with please do it elsewhere.

(And also, why resend this again _without_ a new version?)

johannes

