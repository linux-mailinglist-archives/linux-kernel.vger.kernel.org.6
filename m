Return-Path: <linux-kernel+bounces-316292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B915B96CD8E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 06:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC7281C2085D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 04:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297E514F123;
	Thu,  5 Sep 2024 04:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="XlrfEKuV"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21397321A3
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 04:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725508992; cv=none; b=bdjSmcZBl5up9vr95f0YHWK0tYG7WlRRTM5Jsx4klP1aC5GJWFCmT2y2qzgJAGKJYvWPuGyDIcZARmSoIaq5JS2T2l17Zr6ijn2hu1CJgqVH95XHXiKnXlp5tRhpzCv3gHHTBYbWqZHKdsHVAHaSCx6ItKqASmMnIANPWJMTPE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725508992; c=relaxed/simple;
	bh=8pABicp+50IsLqxOyqWE6Sq8aD/+XIjO0scm9/7FURw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=thENaDOg7vPVKdJtd7nec/goDlfpHrYudRlHZFC6KIXbyvQI1+ewVA4qvvxocWnOSqDk5r1wO73Bo7W17sIBixVTYeaQtFXglVMX0rlBKL5iYF13/WsP+qZX5QWgoyZAg9IxeKsCTUaoo8Ms2qAgq0COBwhodgqHGcwE9g77QaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=XlrfEKuV; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a869332c2c2so257459066b.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 21:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1725508988; x=1726113788; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IlIByFDmC8Mahq3GIIzaKXynB+32bEHND/HXQox9Rro=;
        b=XlrfEKuVSf28QtNtngx6pcM+KmJsNtse8w1b/zkHUkpkakv6kKz0DtMcaHL/MEM9nn
         xcve+n72KTG0p2zLZOuwt+CN0RFT9Ya6Tm2Az/4VrKmBuJiEihdBxVEi+/V1esH4nhv5
         V9GiTtPLxJQ3r4L4Ibn7RUFBrNrlvWWBIUXNyLnGC12tOoNHqUWy7P/F5t52pnt4Pgvg
         DidfxtXchzq4znR1v5a2e+14W9RLdVz1TqsB/auzuGvaAoAo2fCqUYJ/kwxb4Vpc1DmA
         fVzv3zpPptqw9V2AJ1mqoNvD7BBQrTdvmhvv2sVgDdEep4wOfR3A2rHLSaeNGfqHLhIU
         lj3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725508988; x=1726113788;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IlIByFDmC8Mahq3GIIzaKXynB+32bEHND/HXQox9Rro=;
        b=FT3ann/gQf4raoZwq+uXme8LROmX8n40TopyNSDrGfxcoyDYA3WHTiqROVeYr+y3U2
         bhRrJIA//TvmqSZK7AVivw8qktz46yqAxNLGXfaX1bnnwbcOPozRVOVTz7uj/rZNFfyU
         GJxpUwPNHvhwILMcX4n8POgX8CwdhaerXjHLKv5uSg3PKGWFdMeQnJbRRdfcsQgp4ZkX
         pwBEEO6eFg6NoV1diZTRwwz+H3KvpGWfqfl3gcEGwTtqdDBD/14snprELTQCtKYwInhn
         BgXkleF1HptOI+/ZTpYGXCqINjzpPu0weFTY1qtX9iX5rUFu4Fc04f9QO6czY+UD7SBC
         sP6g==
X-Forwarded-Encrypted: i=1; AJvYcCV1eDm4ALoOyMVq/YOqQA9DBr/K7Ixi8ZxjZ7TzaXCzEPwsmr7IeR3A1frvjz4h0IRdbjyR/h404xDbpUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRoDGKx+C4ADzFlMvJPaycnEFvK6+cHvBR8A8cifaUZa4x3CTQ
	3nOF3XFxPtLRaIboH0rE+ZD2fPz4O1VuhrSpVoxjnw8sGBWhOL0YZUaIS0J66rs=
X-Google-Smtp-Source: AGHT+IFegv6CAdqeljKZjd+tW6xGIxlEnk5sl8GV8u0dq1pS2dAxSFJempXIEh11AlDG1b8kGZ4a8g==
X-Received: by 2002:a17:906:c146:b0:a80:b016:2525 with SMTP id a640c23a62f3a-a8a4301f534mr382421766b.8.1725508988250;
        Wed, 04 Sep 2024 21:03:08 -0700 (PDT)
Received: from dev-mkhalfella2.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a8a61fbb093sm74170266b.11.2024.09.04.21.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 21:03:07 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Tariq Toukan <tariqt@nvidia.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: yzhong@purestorage.com,
	Moshe Shemesh <moshe@nvidia.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Shay Drori <shayd@nvidia.com>,
	Mohamed Khalfella <mkhalfella@purestorage.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/1] Added cond_resched() to crdump collection
Date: Wed,  4 Sep 2024 22:02:47 -0600
Message-Id: <20240905040249.91241-1-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Changes in v3:
- Added Fixes: 8b9d8baae1de ("net/mlx5: Add Crdump support").
- Updated the commit message to mention why cond_resched() every 128
  registers read.
- Simplified the check that calls cond_resched().

v1: https://lore.kernel.org/all/20240819214259.38259-1-mkhalfella@purestorage.com/
v2: https://lore.kernel.org/all/20240829213856.77619-1-mkhalfella@purestorage.com/

Mohamed Khalfella (1):
  net/mlx5: Added cond_resched() to crdump collection

 drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

-- 
2.45.2


