Return-Path: <linux-kernel+bounces-283779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AD994F89C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AAE91C2233A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E615D168488;
	Mon, 12 Aug 2024 20:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VjUMPZje"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24CA14D70A
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 20:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495991; cv=none; b=CQjN8Vz5FYYJVU2uB8flSMhnhApe3v38iCes+NF9FxUezeoTZg3AI0NNMBVq9aj4ly+F5oyV2FeAbV8DXKdVJ3sLWU8/ldMcB/pCAVpbYyLmjOiaRvkZ5nTmAt4EOQarTErnxCYoLGMowlKIlJDZLs1fwKXdnWtTKndiJeRCr70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495991; c=relaxed/simple;
	bh=nIOrVokjny/dHg7RBav1tg1ajJ6o6gO3zIt0EtRORw8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=q+hdGPYjLzSzqq5qUjVsDeA/PXyr+H0FEirZUlCX+6hq81kaWQrDefgqyg2TJ/XrlevGHR09bu6+8vqMbVpfbloVwoPMdBWETw5jDz3a2yocxEGThYhQ6wMggpsYtnJAB76CpnOp9j+aMGpaQCJRyUBXY9qGhSMEpJPPBDPk3e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VjUMPZje; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0b3d35ccfbso6913563276.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 13:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723495989; x=1724100789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=88bVHoRsxbRrvGL5pbopsa/PY4mJcz4Ns16/n4GjTEM=;
        b=VjUMPZjeNR58BcVLgahMVm3uufCMLTKOdcOhdqp26ZUKbGBqs7xs/J0S29dw5TSmN2
         sTrKu8xTpcN+y5WT9kvhm2a2g3qyQaCe0FmIUPypiaAisyzjO+DFaGoS7UdLTphpWL5X
         V2WHEpXXuE1vMidVUDU4GQ32jaT0ixWHOotBaQqOKFdnXQpuOOlKgw9kbu33/AJLWazV
         bkT4lBQtmMjzh5GJr5Oq4BIXg2Foh9r381PrhEkc//ACLSZKJuIf4e1ED6onp2vEmBID
         62+lk0qH/o2O5VJyQG2ejYl7p+etjNOyTISR4KUatZFH0QGVyPsWqy/c884bCBBqCUC0
         jTrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723495989; x=1724100789;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88bVHoRsxbRrvGL5pbopsa/PY4mJcz4Ns16/n4GjTEM=;
        b=OMnfBeVZhmoivjNqKrkQDFZCoQ/AqKN0thx115v9X2By+xR8gVdsj3JiuG/pGoeLKx
         p72KIBuXoRmk2Wiz54bwrwIi6Gv1S+asFCgr8jZuye8n8xRNyOoebnsYATNfHNFWWI2D
         ggFaSKnzD7qHWSiw+0eAjcX3T3lPW8WIUARkTqufxWNg9U6jPExSbPVCmadVVQso9Vys
         dG+yPzih22xCeWiMhB5bp9OU7a2eDkivXNt7RSwuD0TU9oYeViSWUk4QUCOgiw8itmqR
         wMjwRxiDb0iVzelkY6meuzCmLbdLMAeD9ZXnwUiunjncKO51NXva9uCkYVYWlZhhETVP
         pR9Q==
X-Gm-Message-State: AOJu0YzRUQ3r1caZSQ60xZrdjHTDXfXkG66hjgEOaRZW4bOezHhTT4Es
	Ptu5fIV3xNi+I6sRrOc+6wvE7Qh1XwNmYOEb0ynaUQDV4A4prK3Wt9vZkmc494XsKkkcuMQqrPg
	/8JfHZRjJoptDQ0JdqPn1MaraKvswcnyGymyYq2aTK8Y0g6CF7ZrbGvVyjRbl84+3XfYw+alLHZ
	FEssbI/UHYToWap9yevYO4hyBtdBscdLanpaQhaK3Qf9gSxeaSAuQ=
X-Google-Smtp-Source: AGHT+IE+M3ZD7kW5OEAx0JM3HgxM7/yZxSBsb3zBQBn1c1T3spqqB7uD0VloVa5DqUJLt3JAncTwC2KgNLBnow==
X-Received: from mostafa.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a5b:483:0:b0:e0b:f69b:da0a with SMTP id
 3f1490d57ef6-e113d2c151bmr2350276.12.1723495987868; Mon, 12 Aug 2024 13:53:07
 -0700 (PDT)
Date: Mon, 12 Aug 2024 20:52:53 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240812205255.97781-1-smostafa@google.com>
Subject: [PATCH 0/2] Fix handling of S2 stalls
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, will@kernel.org, robin.murphy@arm.com, 
	joro@8bytes.org
Cc: jgg@ziepe.ca, nicolinc@nvidia.com, mshavit@google.com, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

While debugging something else, I spent hours looking at hexdumps of
STEs, CDs and commands while comparing them against the arch specs,
where I noticed a minor violation in the driver regarding handling of
S2S bit in the STE.

This has been there for ages, so it=E2=80=99s highly unlikely that any HW (=
if
it exists with such features) running Linux is affected.

I don=E2=80=99t have access to HW with stalls so I just tested normal usage
and (terminated) translation fault events.

Mostafa Saleh (2):
  iommu/arm-smmu-v3: Match Stall behaviour for S2
  iommu/arm-smmu-v3: Report stalled S2 events

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 23 ++++++++++++++++-----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  3 +++
 2 files changed, 21 insertions(+), 5 deletions(-)

--=20
2.46.0.76.ge559c4bf1a-goog


