Return-Path: <linux-kernel+bounces-330673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D4897A293
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 14:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E636288B67
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 12:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2600A14D2B3;
	Mon, 16 Sep 2024 12:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=math.uni-bielefeld.de header.i=@math.uni-bielefeld.de header.b="itD/OWPK"
Received: from smtp1.math.uni-bielefeld.de (smtp1.math.uni-bielefeld.de [129.70.45.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FA8155725
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 12:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.70.45.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726491271; cv=none; b=GmC+ynIob5tP6mrjC0EGI2TOx2M2LVw9OaLB8hDMXK/D5jMnYuP5898x5j3WwGCmeH9irwNbZoyTFZ2D2Vcf0ERCcV3JiUsNYikw19ZVuFe+gzyvRo3ZAFu5q9TA6gM5Fk5oN0+hH9osjC3hAl3mNhzO8cIvekZ+KOogFQRVVfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726491271; c=relaxed/simple;
	bh=/Z5Nn18wF5NFp17J1Z5FLfwLIoP3zSuoMbx4aP+cBHo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UamX4rmDrarFiEGqnaLrL3pWd1nreUlTrdzOhWGG56qHK7A6Jn6tm523Z54r+81AF8OuDxLyZpUBpklRAppiUPQyIwZprZCyKHu/CjY9Zo1Zyg4nFiEtj2Hr3D93ZmXynEm5RaUyA2Ya5i5AQOL1IdLV2fhKedVHTeEqupmV7gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=math.uni-bielefeld.de; spf=pass smtp.mailfrom=math.uni-bielefeld.de; dkim=pass (2048-bit key) header.d=math.uni-bielefeld.de header.i=@math.uni-bielefeld.de header.b=itD/OWPK; arc=none smtp.client-ip=129.70.45.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=math.uni-bielefeld.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=math.uni-bielefeld.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=math.uni-bielefeld.de; s=default; t=1726491258;
	bh=/Z5Nn18wF5NFp17J1Z5FLfwLIoP3zSuoMbx4aP+cBHo=;
	h=From:To:Cc:Subject:Date:From;
	b=itD/OWPKAKUj+wCKHLBgTm39Polq9kxX0othsq+7RXf1tn1Cq2a6hqbB/2ow1AutG
	 CBjfADJU6M9Je2HhqrDr3IJMSaDJpuuaz1t41tVDwaxmm5i5D33ACJjfcxCsgsz4aG
	 lj7BqqTqp4Nxus2WpetvIEiRFmVJqKjLupkXAQIV0SbVNYB0RWTaEf+Kk3SqMoywd0
	 ieANETr9Y6lLvS7MzkT0Ox74I7zJ5/11624wm9cwGR2Q/9NBAXlIpk2NAdPEraGoT3
	 jRXuNvCQOUj81nmG/uHLixQhhZY52Oj1Zy2R3nbfXx8YyCu2XkHHoz8xLAtsX+r9l1
	 lmlTSlWXsct6g==
Received: from localhost (dslb-088-074-203-146.088.074.pools.vodafone-ip.de [88.74.203.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp1.math.uni-bielefeld.de (Postfix) with ESMTPSA id E994B20359;
	Mon, 16 Sep 2024 14:54:17 +0200 (CEST)
From: tjakobi@math.uni-bielefeld.de
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Subject: [PATCH 0/1] drm/amd: more VRR race fixes during IRQ handling
Date: Mon, 16 Sep 2024 14:54:04 +0200
Message-ID: <cover.1726490926.git.tjakobi@math.uni-bielefeld.de>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>

Hello,

this is a follow-up for these (already merged) patches:
https://lore.kernel.org/all/cover.1725269643.git.tjakobi@math.uni-bielefeld.de/

A user on the GitLab issue tracker pointed out that the problem
also manifests itself on DCE110 hardware.

This is a straight port of DCE10/DCE35 code.

With best wishes,
Tobias

Tobias Jakobi (1):
  drm/amd/display: handle nulled pipe context in DCE110's set_drr()

 .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 21 ++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

-- 
2.44.2


