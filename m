Return-Path: <linux-kernel+bounces-435874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 394DB9E7E24
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 05:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E994B16CB0D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 04:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE93BA49;
	Sat,  7 Dec 2024 04:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxtkVHWS"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D2145038
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 04:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733544014; cv=none; b=EBHumOt1XI1VBBLoEPMMLiuSMzlqaQScML4I7UHk+NZ0dxLVxpqrAXI7vF4Yz9k3GbGIj9piCK4Yut2uqB2kq1jiunkKbK24903vnHSO/0ia1HpwceDSuC/jzCCpVqWsMNhwH5sRR1XwBIYjNV+ptoKRofrqCtYMFk9GEO+pMwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733544014; c=relaxed/simple;
	bh=KxPUpGxCXPbny5Scxopyn/Kb7EHxic1JJJU0QM9y2hw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XvbyWAErUFa2JsZ2PLWjkLuJ3A4ChS12SXLOqmQ3TNDgS9s/6fYV509eOfa9hdup58i4IEoBeh2QA4q3zJD4YOW4Ce6uXf/cNzoobVguOMjPOIPM36Lz1nnumbxVbcCOhNCsFQtC7nhn4wczfMIl5bHvail9pQ1czy+21jsYqn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxtkVHWS; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2155157c58cso17425895ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 20:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733544012; x=1734148812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KxPUpGxCXPbny5Scxopyn/Kb7EHxic1JJJU0QM9y2hw=;
        b=gxtkVHWSGbO+dabWzTKfU9spj/8OrF9fjdd+CScJi11b1KCmHPbU5FwCYYFl/8d2NM
         hVUW/oAvcI3CVLPcu4xRqhISghRo+vSUqf+B84OsV1vvCVBrU4vNPWIONq2rx5KNuzGZ
         hErV+vZLnsTylSlbt1UrglkrcPBzyyQvHJxaQ6gb9U6jPOdP3+iBDjL8W09emXhA6sfT
         1jaGfPoWJ/K96Wzi8U5QmcrgEpRt2KKRnP16PNhe/cW3sO4xy8zWqoRW0PFZKwrtr32C
         uesViLQk1ZQWJjfF4/LhlP57k9cOPKB/A6mhNZVeVr4Pb/r0jjPMgnwiwanBMXNiOPpf
         ay/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733544012; x=1734148812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KxPUpGxCXPbny5Scxopyn/Kb7EHxic1JJJU0QM9y2hw=;
        b=erFI1KyvZ1CIkamjhK5iM2b/+aN54IwQhVw/61ygnwgnHrEiXoATpz/Zx3S16QzSUc
         FsJDs8o2twbF6mBFJ2QgcGRU/LXypXZf+ki/tS4/FMigTrnZq++wS3s8LrVKaUZKwvOV
         ie+PbMh9PqEjd94+tl0I+Dly5UY1GjbVXSDjQGFSOsDPvVxnePAZQvXi8ZeuGpaND3hU
         mpyMTMf9Gh0KdrsfJzCqarflkTXdtZegZfmlLddih5P3+BWRQHbeLJH7vcVkYCPrKfZ/
         ZYEMjO/qIyYcgjwOjnPBSNpFtdWYpI+7B28f7ZkshJjVfm7NpnSTIuOhgv+joXmY35lC
         ugvw==
X-Forwarded-Encrypted: i=1; AJvYcCVdLfmbdyELO+soHUWQ6rup7wqBUByGzsp2/iV3QDKqvNPTq8HBNQvYS2fIwVOynPDt49MWBMgUGLOV3Lk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI4hKtVvFb8GHsuCXB2/NhkGSHjww8eSx4QgVMYrxBsBXPBhnX
	gHD9Y/iBtadN+9h9YVzUrSVVdajafN3MqMxxXMJTk6J3JmJizyha
X-Gm-Gg: ASbGncs2i0dCr9g1Ue+MHQfBo6DN4GDhjesRTnR9f7Tar+0tkm2MG9dePBLc9DmzhJT
	WKn9F/Hf6yrtmczJQJC976EzWr9sGpn9trCcRN39hxf2jTtNqXNr1CMpkmAnTdMIHZfMSgcG1a5
	iFqZV6s+btatT2iEjRQWeyVOP0eJTHADXQzsAdxCbBXeX2b67XPeNSO11e4kx7Pp5ecqYbBfrGE
	d6Ti0tTw8sF/16mT8KkaX6sapS0q61Pq9LO164ICFNo4nGBML8BsE7yIVg5JNM=
X-Google-Smtp-Source: AGHT+IFqm4ORse/wXivucw1HWwPP+d49S1d+HpAtb2hy/Ls+PeUgB4UJQVofScI44fedpDlbORpONg==
X-Received: by 2002:a17:902:c406:b0:215:9d58:6f35 with SMTP id d9443c01a7336-21614d1f241mr84521255ad.1.1733544012437;
        Fri, 06 Dec 2024 20:00:12 -0800 (PST)
Received: from noel.flets-west.jp ([2405:6586:4480:a10:fa8f:7c3e:835f:c642])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2162c0ab697sm3022435ad.131.2024.12.06.20.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 20:00:11 -0800 (PST)
From: Hironori KIKUCHI <kikuchan98@gmail.com>
To: Philippe Simons <simons.philippe@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Carlo Caione <carlo@caione.org>,
	linux-kernel@vger.kernel.org,
	Hironori KIKUCHI <kikuchan98@gmail.com>
Subject: Re: [PATCH] regulator: axp20x: AXP717: set ramp_delay
Date: Sat,  7 Dec 2024 12:58:06 +0900
Message-ID: <20241207035807.1360835-1-kikuchan98@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241206123751.981977-1-simons.philippe@gmail.com>
References: <20241206123751.981977-1-simons.philippe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch resolves the freezing issue. Tested on Anbernic RG35XX Plus with AXP717 PMIC.

Tested-by: Hironori KIKUCHI <kikuchan98@gmail.com>

