Return-Path: <linux-kernel+bounces-389262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 002C99B6AB2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 18:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F3821F261BD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 17:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5884B219487;
	Wed, 30 Oct 2024 17:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="EwDQJ15G"
Received: from mail-40137.protonmail.ch (mail-40137.protonmail.ch [185.70.40.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C2F217471
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 17:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730308141; cv=none; b=p9Ht3W6A0k5iN0rbRm38v/xRcgt6TjJBt24eREnwqG76iEv6IdlQ9XwQkFFn9sOL3pG8KKT8SIZKbKfbXr872mRxeFAFghmDDH3ES0d5AguxFG01ZGGbqCO5dreZgS1QzPrjSFGFPhx51uP5C0/z8CutA53XOFCnPC4hU3XLW/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730308141; c=relaxed/simple;
	bh=uh35IyzRr1i4zoHbPM0a1fKANpSoImgEFhhrxYbiL7w=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=ozg2oVlDazZgWor+pLh3I1FXr7sjDakjRy0q8b/iN/P+b73NmMgzNZhGjoeWoAhzxX+oW1wCVvr5CZk7qKXTIv5iIfcAkiw+m5VafgZ57oXzHWV+/nUVLyOTY2Z9W6fyxlM66iQ2nZZCngTXY9V5DZGHI2ClyPRBPCVcnR5eMAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=EwDQJ15G; arc=none smtp.client-ip=185.70.40.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1730308135; x=1730567335;
	bh=uh35IyzRr1i4zoHbPM0a1fKANpSoImgEFhhrxYbiL7w=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=EwDQJ15GsE2A5UbLNmwuEx/pBh4ciKrUTELwEoQK8q9vmYeTm+ozUpGt/fPm3+rPR
	 XF1wjOQcxvVCPhhKrGt3EAVLLR2BHvowuXWoRWLmhcY+e4aRxvrEs3YthIWOjTl55e
	 Xrnxun8VWPzWwQb+BmrRBiZya8v/MFrT9mdaywXXCSDZG5PXM84Be+9j3cPSqwT2S+
	 q1bVSYUgryJRvUsCVRmk92oPNoOgDp3V7HlKiu+XFb0u6CYfF+YC1mI3gtwTuRQ811
	 9rGBCWQCNWD4DoBsBTGycEpeoUo+Z5aahO7DeL5zJXJ//SxP5aL+bYlBy3CZ4sMQC7
	 KK7WxfaIvd80Q==
Date: Wed, 30 Oct 2024 17:08:52 +0000
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Michael Mitra <michael.mitra@proton.me>
Subject: pifdctl data corruption with refst pointer
Message-ID: <_RND6kwJsrjQL9BVS0M0vl2h7mjRMF0WTCL2a-gQuYFGAl1Hna34-NhImyvcs84TnrcprFKijS9xjKV1oYU-voZa-Xl_DRIcTlbzL1tui2A=@proton.me>
Feedback-ID: 120849688:user:proton
X-Pm-Message-ID: 14904c55f48bba2ae184dbb30ed3ef9b35e068d8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

In the case of frobbling, we reinitialize the device after a

5-second sleep.

https://jerando.com/uploads/user_617/CB-menuiserie/.store/20161121_164609.e=
xe

