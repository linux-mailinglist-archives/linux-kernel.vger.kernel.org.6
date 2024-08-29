Return-Path: <linux-kernel+bounces-305981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF5F963796
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 03:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE41DB222B3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 01:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167711BC41;
	Thu, 29 Aug 2024 01:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bMxLvp++"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A38134B1
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 01:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724894494; cv=none; b=ssxh0SZci2WIBQ3dxIK1UzQ5dlpYELollMJplLzo7+ZTmUPU/mJo7nzgq8/LtsxT5BZb752ZxyIckcFfeXItWf7GYDrN9MAp/bIdzD5vmothNw4G82wUPk0uCMFwG9g6K6bFyM5OOCDfTE4CdOxyvAcOdwL4wv8XvxhfE3yqN2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724894494; c=relaxed/simple;
	bh=skcMYmkBzaPdB5Cqc+jAvVZYCWgXNtH/S9Wna3ROl98=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=duG9vhAGY/YLDXinyWn0pglUalKue3dFt1JyD9WF1+HnuB2qhXcN4iIc1s6aaxyUC9YtGuuG2pa6VW7jo3QSbzWg3WNx8TzwCQ/5b8GJGwRSq1jTn1GAxdBKuqbVQYWjD9hPmJTvmAYNPix0JhmCuOCcqy8y25aG3BOCC0aABtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bMxLvp++; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724894490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xA96S5hJVD7jAK1AQwcph0AMSK8pgIwZSqUYdNlyckI=;
	b=bMxLvp++oa3ANKiZcuJoWrL5XxhBjyM3WlyLvxG6gXmQMFJGielRsk4L3Bbn6HC8eoReR8
	mE/elEGRyndgtNPXu+ZAGXRKhPTD8DPCqc7ixr68YW1L73cc/nCDdvwViD8sTevyflyM9e
	eimjZrLpNgJFOZ3AAmC3xhKxI0t65XQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-a9j8mMCbMUGaljXC3eN4uA-1; Wed, 28 Aug 2024 21:21:28 -0400
X-MC-Unique: a9j8mMCbMUGaljXC3eN4uA-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6bf7ad66ab7so26187026d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 18:21:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724894487; x=1725499287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xA96S5hJVD7jAK1AQwcph0AMSK8pgIwZSqUYdNlyckI=;
        b=F68NI4koo099Lvax3gWW85yM7ljmAaZJVSdY7dQ6XGIQs2clValuYBf/sXoRUlXkUo
         tK03iVeWzeR9fLb7Re+qm0OixvcRVQ+ZV04cntxUQ1DFjTdv2/rfNVR/PEmejtEfsFT6
         9w/DqLSn2w+J2rNjuhCKHXKYdqxF46sxQh2LeXXJ7f+u0y1+SwotFBWrbPjl0bEzfVWm
         2cLyn16xqIEDnZKjpRFhoDlNHnnx742/YTq+FbQvitffZrT3Fjk5LeQKBU0v3x3JEqjj
         NtBFfez164Q+L5sq53CeW5eXOfnXajAo6Y86eGLBgy4ncyzS1IvU60twgnxH8VmdOkJn
         KgNg==
X-Forwarded-Encrypted: i=1; AJvYcCWoOs7fwfCEY37y+4484G3f9SN8LYHImQsBMrSdTxjYzywqAtqxyGayQCtxyMPMPZPGsSrTP67flX3+dvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyGa1P/nvfpXyTq7+BT7KxOEpLP5s0f/f0nMbua3Ahz6PTX8aV
	gf0EEmm07y8Edh9o1cnBA9eI6UX6PB4BCgnwrQYqj5T37bh0aD9PdMZFlAaG7HSkM38AsKIKQeF
	9GIHuF69T/TyF1zIFAIVqLeseZnTidkXmiSci0CwP/ogWfJhnqbDgk5XAN/6+9PQ/ek9OVXVm
X-Received: by 2002:a05:6214:2387:b0:6b7:923c:e0b7 with SMTP id 6a1803df08f44-6c33f3a4170mr20180356d6.21.1724894487575;
        Wed, 28 Aug 2024 18:21:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3ImsCNh+Reo0irARwQCo+4xKteQ5h6er6E2txS3nQ6+qHXf5Bul+76XAT8VTntFotrWpmRg==
X-Received: by 2002:a05:6214:2387:b0:6b7:923c:e0b7 with SMTP id 6a1803df08f44-6c33f3a4170mr20180076d6.21.1724894487205;
        Wed, 28 Aug 2024 18:21:27 -0700 (PDT)
Received: from x1.redhat.com (c-98-219-206-88.hsd1.pa.comcast.net. [98.219.206.88])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c340c96825sm1013236d6.75.2024.08.28.18.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 18:21:26 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
To: herbert@gondor.apana.org.au
Cc: davem@davemloft.net,
	quic_omprsing@quicinc.com,
	neil.armstrong@linaro.org,
	quic_bjorande@quicinc.com,
	linux-arm-msm@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] crypto: qcom-rng: fix support for ACPI-based systems
Date: Wed, 28 Aug 2024 21:20:03 -0400
Message-ID: <20240829012005.382715-1-bmasney@redhat.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit

The qcom-rng driver supports both ACPI and device tree based systems.
ACPI support was broken when the hw_random interface support was added.
This small series gets that working again.

This fix was boot tested on a Qualcomm Amberwing server.

Brian Masney (2):
  crypto: qcom-rng: rename *_of_data to *_match_data
  crypto: qcom-rng: fix support for ACPI-based systems

 drivers/crypto/qcom-rng.c | 50 +++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 23 deletions(-)

-- 
2.46.0


