Return-Path: <linux-kernel+bounces-346666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B0C98C74B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 23:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8A5E282EF8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 21:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE9F1CF7AB;
	Tue,  1 Oct 2024 21:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="JxbUgWs/"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881A81CEAD7
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 21:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727816698; cv=none; b=pHGQaq24SlKS+7BVfBhLw7fIiHJ+V4qenYyM+ODhGqSWi7q/yUgk3tPTrqNFi518D+qKBBfzTebN6KYZeqmxQRj7OfuKm4oZXxcZG8CzVnl6rfIGQ30v44yAYHyOi/4GF/clFTjhG/3gI36nKUjEVPwKhPEEA+ugeDu7mFfwki8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727816698; c=relaxed/simple;
	bh=qPyDujOFTLNSxbcnmHDSi+KZgC/UzTfXThHY/68Uscw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=buYN+1RzhP0z72nPzBrD7LcfWgisUVqgbBZG+6dmZbhcE4lQZgxshp91xs/Pwk9AAl+1Vfy3XrEj7SfdSuz4T2OI85gMgPxZB+B5NEXE7hdRV85pXuf9LxPrfw88dugk6vMvUxF152w3LI0J1xx9jSdeSkQxJo7LlwJitFVBEno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=JxbUgWs/; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20b7eb9e81eso30127625ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 14:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1727816696; x=1728421496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPyDujOFTLNSxbcnmHDSi+KZgC/UzTfXThHY/68Uscw=;
        b=JxbUgWs/Mrn53vTrW9mJuJLzR4Y1avvysyrxw1FrApHxbQI1QjZIoyr4r8/8SotFTs
         yv9aZViGghRBaZ0B++k+3Nc+NvOM7qi9DYW2+N66EJ3AjUM8YOZpVlXs4mtoDjAKnmj1
         YL34V3hlPegyCZkbY45vlcV9n1kifgvvN4MK+5U9WewSxrfIG5yYdH4ABz/md+IIKV4k
         9y23L5VF6F6HJ6VRM6LbQ6GuCaGOXqZApi6vh5STT79cbL4tK0RzoF3VuBr7y5prUzGu
         p45qPuL79wRsaesIXzgV6yAG48xPPgG43yA3FJi2YxScNKGGD9Lu5d3uO5msg3rDi5zO
         1CZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727816696; x=1728421496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPyDujOFTLNSxbcnmHDSi+KZgC/UzTfXThHY/68Uscw=;
        b=pd09MVFaq5pjvYVUHV0CGUWx1eKFyuD1Uqn22kD/JlGMNlrUbsKYNTVKcMsfw/1EcH
         stQSXoZN/5mOJVTPI/j60hsUzjoB0wfhCWZr0LVO0wcqYB/bWuGTMuSxSmOdYRnMz2Rr
         xdjKxxH77VUn7sW37VYWIjDP+aYvgi7VbVBqK/0jOfcDQtE3Q8SDj45qHyGb6BtD00S/
         drOtzBpPyLaVwSRuRMukSWF9mY2WjLuChn3fEbTXgF1oU7J2TdFXun9yia2s1Er+qqEy
         yHe6M22EHXVzA+bSzOr/ohsUAt9ngbRqDOQTQT2L+B5nGGa9G/dvy4pTEqQP6Nm8Ihlq
         3TKw==
X-Forwarded-Encrypted: i=1; AJvYcCVQVGcuNKXy9aVX3wiE5YTSh6+jsXgJEIOTTRiJeenqCsjstFJ8viW1xW3rRwcagzPS5ADPUyeJEJQcZoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaWSbkjjgEHi3ZgHuKlop1Wtu5Of4jXlFeIsDMDv49As1Trfgd
	uO7OcS3R42K6c424FImm1ia9l7x+ilyRbzLg1iD8QXLdFtaNxxzL7KWX7/TaVEI=
X-Google-Smtp-Source: AGHT+IHOCKqwJNquHm6zECkIBJWswhGFdb4YTpGgI9Bdwu0jMqj8A4NHRSk3KDE5XuPFEDX+sBe2ng==
X-Received: by 2002:a17:902:ec8f:b0:20b:6f02:b4e5 with SMTP id d9443c01a7336-20bc59ae323mr13811435ad.9.1727816695778;
        Tue, 01 Oct 2024 14:04:55 -0700 (PDT)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20b37e37168sm73412995ad.186.2024.10.01.14.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 14:04:55 -0700 (PDT)
From: Matthew W Carlis <mattc@purestorage.com>
To: macro@orcam.me.uk
Cc: alex.williamson@redhat.com,
	bhelgaas@google.com,
	davem@davemloft.net,
	david.abdurachmanov@gmail.com,
	edumazet@google.com,
	helgaas@kernel.org,
	kuba@kernel.org,
	leon@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	lukas@wunner.de,
	mahesh@linux.ibm.com,
	mattc@purestorage.com,
	mika.westerberg@linux.intel.com,
	netdev@vger.kernel.org,
	npiggin@gmail.com,
	oohall@gmail.com,
	pabeni@redhat.com,
	pali@kernel.org,
	saeedm@nvidia.com,
	sr@denx.de,
	wilson@tuliptree.org
Subject: PCI: Work around PCIe link training failures
Date: Tue,  1 Oct 2024 15:04:46 -0600
Message-ID: <20241001210446.14547-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <alpine.DEB.2.21.2408160312180.59022@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2408160312180.59022@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I just wanted to follow up with our testing results for the mentioned
patches. It took me a while to get them running in our test pool, but
we just got it going yesterday and the initial results look really good.
We will continue running them in our testing from now on & if any issues
come up I'll try to report them, but otherwise I wanted to say thank you
for entertaining the discussion & reacting so quickly with new patches.

The patches we pulled into our testing:

[PATCH v3 1/4] PCI: Clear the LBMS bit after a link retrain
[PATCH v3 2/4] PCI: Revert to the original speed after PCIe failed link retraining

- Matt

