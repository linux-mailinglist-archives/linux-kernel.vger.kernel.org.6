Return-Path: <linux-kernel+bounces-372496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3E19A4944
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 23:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25CC91F2243B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 21:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C8418E05A;
	Fri, 18 Oct 2024 21:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=m3y3r.de header.i=@m3y3r.de header.b="Jfny5lw8"
Received: from www17.your-server.de (www17.your-server.de [213.133.104.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509B218C332
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 21:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729288253; cv=none; b=eUAGq61BIoiKGdXGSoWDbQmMsGqMmIQZNm6k6L1EKyCyR1E9WaaGY9/iAbnbPSWuSZqXIIihfGAJZgpHi7yoyUa+FcSt9TJPFy1nS878DRRdtMt27/k0wCqzmYn95JraHVn4Qh4315dHeFyUAzCkbUrcO7Ix6N9o+UPt4KtjxqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729288253; c=relaxed/simple;
	bh=wDf7YMqe2XApniUYFtVC1vwBkrTu78Ck2MzC3Mtz7GM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aPjPvhQ3RfjRymbddQazoE0pFryxvkry1NQjHvYPrqFZmu/aWAgVGhH1Qx7e4XVO15uuoiBKs7m0T8b19aMtFPgHuqIRRxpA/qcFHwVdyjutt6z3C8KujSGbFL04CBWtZsIC07/HaWWJzl5gq2wyShpQGJMlprUxYhIXVgxeQa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=m3y3r.de; spf=pass smtp.mailfrom=m3y3r.de; dkim=pass (2048-bit key) header.d=m3y3r.de header.i=@m3y3r.de header.b=Jfny5lw8; arc=none smtp.client-ip=213.133.104.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=m3y3r.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m3y3r.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=m3y3r.de;
	s=default2402; h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:
	Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References; bh=wDf7YMqe2XApniUYFtVC1vwBkrTu78Ck2MzC3Mtz7GM=; b=Jf
	ny5lw8RTpJSd+2ksNh112V2dv3O/O4vr2Dk1KZPd5tABPqnX2BT8r9pjgAVpJ+m5xLFMvH499za3z
	LtPf0jRqo4scNmgcIYMkycPyOLMfvj6PFXS1Yg+/0PZRWjRiDGIKahXKaN+MilIief5lgfZqBmiHk
	T7UnAqLHbKQdWyFIxd7hidjC+oCVKmzlLnuBmt5Pj5le0DyP6G7+evg0Fl78tXuYYfIcnZzt8qvo/
	omvPI5KnMjQVwgXRUQqibMGRtYveDbfsGg/fhEeu9eLERjEpxuODm4uXgL407Dm+ckRP1CAbk3XzE
	zqsK0kHz1niGDc5Tupqh6LuNbHTpXjpg==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www17.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <thomas@m3y3r.de>)
	id 1t1uQP-0001Qh-0Y
	for linux-kernel@vger.kernel.org;
	Fri, 18 Oct 2024 23:22:21 +0200
Received: from [94.31.73.225] (helo=DESKTOP-DQBDJ0U.localdomain)
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <thomas@m3y3r.de>)
	id 1t1uQO-0000zN-3D
	for linux-kernel@vger.kernel.org;
	Fri, 18 Oct 2024 23:22:21 +0200
Date: Fri, 18 Oct 2024 23:22:29 +0200
From: Thomas Meyer <thomas@m3y3r.de>
To: linux-kernel@vger.kernel.org
Subject: Enable CONFIG_TRACEPOINTS only?
Message-ID: <ZxLRldQ688zYZJ8O@DESKTOP-DQBDJ0U.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Authenticated-Sender: thomas@m3y3r.de
X-Virus-Scanned: Clear (ClamAV 1.0.5/27431/Fri Oct 18 10:53:06 2024)

Hi,

is there a way to enable CONFIG_TRACEPOINTS only?
The commit 5f87f1121895dc09d2d1c1db5f14af6aa4ce3e94 seems to have removed the ability, for some reason.

The best I could come up with is:
- FTRACE = y
- ENABLE_DEFAULT_TRACERS = y (which selects TRACING which selects TRACEPOINTS, but has the side effect of also setting STACKTRACE = y)

Bug or feature?

mfg
thomas


