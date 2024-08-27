Return-Path: <linux-kernel+bounces-302661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 600F9960190
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 08:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 929631C208BE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 06:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07311552E0;
	Tue, 27 Aug 2024 06:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FlRPL94n"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D131494B5
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 06:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724739946; cv=none; b=l/7n2U6tqfDQWnEat0dYc+byHM85eYatQuGx3HKTMPvFtJf5+HGwIU+Zys0ECO3l2za2cEFlRb1bsi4XX+O5l+IkrgDii9Fjs8NTiTsqeYGbmrdpwoUn3xPR4hthnnFBR7OpUcADANtlHI9kSYCObCpRAwj4YrGpExOEoe09l8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724739946; c=relaxed/simple;
	bh=WmB0wo2kGM2nwplrjypHlZtd9IRU7iJe1X+JRXxRYVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m8XSmS62oEqe+qx3VUnmyhl6SpseWRH1cOM6FfZp89q/3J6JrLBs70JSIn5Bn6VGyXX7a6w1KCefGFu35Trm538Zm40kiLZdEFgAIeCqbvLMEjM1VnCoUfVyHWCynsE5uS2PMno3z3SkjRzR2NJ9gWvt1HWHfgsGg589zbYsck0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FlRPL94n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724739943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tChrxO1HuAIgDg5Agw3TuPA4TMpEaBjY2k6lF8kLxg0=;
	b=FlRPL94nDZ3p4ZCc+5K7BbtUxzqJY/Kge9c8cwcjpMQNpAmkyUvPJlysxDI+CeoHUWUmPT
	MEDjHGOxFZHw9da3O5afF0Yid8QZS7IWuwsGbQTmiR6/+lpcoy57XYtFG++zbgU8dIkOYq
	ECqMc0Ro2+vCX3hXGpDfP418OK6ZTvs=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438--yImuWslP3-SU79xSXIMhg-1; Tue, 27 Aug 2024 02:25:41 -0400
X-MC-Unique: -yImuWslP3-SU79xSXIMhg-1
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-842f6f5deaaso490912241.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 23:25:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724739941; x=1725344741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tChrxO1HuAIgDg5Agw3TuPA4TMpEaBjY2k6lF8kLxg0=;
        b=evhLTcUkAbjnTv0sq4fgw/MNYiXPpnzRDiHoQYARFgCBOs3VtOYKECFwl0ARDWHusU
         hABRhnR0ZtISH5AeEvjYdsJ+DnNhqJOHKWrGPYiwquEcXjemjT7NaCVxtpDNziRq8WS4
         YZ7TkS3qgrUEb9QfvVfSgpSNiI0EvxwIYvuma/jClAGojKbvUqr2/MvjVSxIXsJ0sOmk
         vGe+vosMFWFjYo1d85LZH2MJopbtJreGVbm3cnkNcrcBWxAV2+Fb/87Ew9oU/2dWmVHY
         GSRJQfzLwsqkFFsb3fId6XD3ABAEJFvmEfNCsW5jkuRNxtxg56PLltz7ZG7GDMCmqiDP
         YNiw==
X-Forwarded-Encrypted: i=1; AJvYcCURJRqpsV4l/6jLFZxZ43M+7LnTDNdMcUDzn09pr8rC1ZHyyNj3asT8gPFRxcgPsZkTl77Znb/y94E7vGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx12FZp+zYb5LXcv45qnSI8Si90P3zQywDFAHz5c7m6GAUtMbas
	xY/UV2p3s6zl3YQd8m2IUA2Tn0s0Mfxv5bMiQj/GQ1ItbQYg1HiYErKYUBvFkzCX+JzAc3SmqEV
	LgAfFidsTn22FLAqunybT+/DNYaBbxpOOV3mkil+isfOUhNO32x6YDyxXrdNiyQ==
X-Received: by 2002:a05:6102:2ac3:b0:497:6360:6454 with SMTP id ada2fe7eead31-498f4527b10mr10077648137.1.1724739940808;
        Mon, 26 Aug 2024 23:25:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKJOfa1bnLznhnu8Wk2lq1SZIINHqonjeWtxA62MU4NC0rheKOcp5i9yqAIel7fXo9kfvaag==
X-Received: by 2002:a05:6102:2ac3:b0:497:6360:6454 with SMTP id ada2fe7eead31-498f4527b10mr10077631137.1.1724739940420;
        Mon, 26 Aug 2024 23:25:40 -0700 (PDT)
Received: from rhfedora.. ([71.217.43.75])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f1fe176sm521044185a.0.2024.08.26.23.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 23:25:39 -0700 (PDT)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-pm@vger.kernel.org,
	Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Arnaldo Melo <acme@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: [PATCH v2 4/4] MAINTAINERS: Add Maintainers for SWIG Python bindings
Date: Tue, 27 Aug 2024 02:24:36 -0400
Message-ID: <20240827062438.71809-5-jwyatt@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827062438.71809-1-jwyatt@redhat.com>
References: <20240827062438.71809-1-jwyatt@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding myself as the primary maintainer and John Kacur as the backup
maintainer for the libcpupower SWIG generated Python bindings.

Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
---

Changes in v2:
	- Added as requested.

---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f328373463b0..80d5475c943b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5819,6 +5819,9 @@ CPU POWER MONITORING SUBSYSTEM
 M:	Thomas Renninger <trenn@suse.com>
 M:	Shuah Khan <shuah@kernel.org>
 M:	Shuah Khan <skhan@linuxfoundation.org>
+M:	John B. Wyatt IV <jwyatt@redhat.com>
+M:	John B. Wyatt IV <sageofredondo@gmail.com>
+M:	John Kacur <jkacur@redhat.com>
 L:	linux-pm@vger.kernel.org
 S:	Maintained
 F:	tools/power/cpupower/
-- 
2.46.0


