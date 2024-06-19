Return-Path: <linux-kernel+bounces-221101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9EE90EDB8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 15:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B9461F2282C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 13:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E7914D6E7;
	Wed, 19 Jun 2024 13:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UPaZUMcI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90B214659A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 13:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718803279; cv=none; b=k1NseCybz2KIupzeSlM/oAqocYMyBGEinKiBFx6Nc4N5FKhbaERN/qOLU7IgPFcX/8QlpHwJ5j/cIqOyQ6gggbik1FRY63yB5Ye6AX6CqYgtUMYK8i4Mu9Nx7Sv3v4Z1SDrUUK1i6thc10DBIZGCy/4V8/CrfqPwW28luhYrPIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718803279; c=relaxed/simple;
	bh=O7y/8GQKJpL9pypMRDSGZHFznl5aYJrfBDozLuBVJG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HSNFjKM88ZWFl5M4dUllI4b6tqLgKvz8iLpskIn7FKUzO4viCm/aY1uqanXPHE7Ob3DQNfcO44G5BrjhiVZYUZmBusbA7lZeyUkrqay6m+RRduXGg+5jFDo/uLngqBaYLEmSCrnGaXwpnSJCFEoxT2Of2OTYGdbs43kOqVJT3Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UPaZUMcI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718803276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vVXcCL6bH3hJLBrtW5nul9is0NHqTNh55v2IFf+anwo=;
	b=UPaZUMcIVublAdiM+sHfC8//og68FIRKNkaGYBK1PvdlogiZKg7GoZMZfWj0DlrE2VIsCf
	puBAtllaxsxpyTKOZUdgHewzDtpDbTwOjmKB1hu4JQILrIk/wcW2OSpmPyVkOYVxAR4IAE
	P2240X4ln5vwbWyQh11ezYXMC38n5Ew=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-MnNcJde9N3ypqirCMzKxug-1; Wed, 19 Jun 2024 09:21:15 -0400
X-MC-Unique: MnNcJde9N3ypqirCMzKxug-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-362a0c1041dso685148f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 06:21:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718803272; x=1719408072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vVXcCL6bH3hJLBrtW5nul9is0NHqTNh55v2IFf+anwo=;
        b=bVcpN8XFVQv5a98Tcf3fAM1MlKyyuLBvazf6qw7mSsU1HsycWeSl8HvHNpnGJY3zLw
         +f6MkRsDxN2E3qt5uI77EXfy4OiuiHh/6VqKkyh62q9LmY/c+VNPKLBhnydsNlDl5eH1
         7OKAeyGbl7GVmNrl6ktORIHiy/KMNyfowK5GIorGEKDwc4fdPpyb/hldPPfXoC1p2OC4
         721KLljSYjgPyucLo9umu8W8dbelIf180x73iqDJyOY2eZ2enKoSd0mc7Wo2fgoBQ62S
         4GKlLOXV2SI/UJltKzzGbefz97gHqcP/ocpVIHu911OI2hgFcEy0sCbCoFWQL6WEkq2k
         gs2A==
X-Gm-Message-State: AOJu0YzmtHLuJ05HR1wNk07HDaghjO+sx1Xmp2V2Mm3M5LgJomrFUb9K
	Ba1CUlXtJ6/GFUIEMuck5hkwoYYExkli0ENLE1Eh3wdXBQDAyHYIZFnEKm4+dtU7d/cJNS40Iwd
	JptIi19vPriBSUPUObC1/tpN6obijN3tqw4wQjnzHIriQKhjCsueT0JAyefrfhQ==
X-Received: by 2002:a5d:4f82:0:b0:362:bb3e:93da with SMTP id ffacd0b85a97d-3631998eebbmr1914386f8f.62.1718803272698;
        Wed, 19 Jun 2024 06:21:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIlW73KAkOwDRcPRuvHSGy4wqiMt0mgnebBuyTv5FiPDVqkiGOQ5fggLB28PPn9sbHyJarng==
X-Received: by 2002:a5d:4f82:0:b0:362:bb3e:93da with SMTP id ffacd0b85a97d-3631998eebbmr1914374f8f.62.1718803272471;
        Wed, 19 Jun 2024 06:21:12 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509c79bsm17475715f8f.41.2024.06.19.06.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 06:21:12 -0700 (PDT)
From: Danilo Krummrich <dakr@redhat.com>
To: mcgrof@kernel.org,
	russ.weight@linux.dev,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH 3/3] MAINTAINERS: add Danilo as FIRMWARE LOADER maintainer
Date: Wed, 19 Jun 2024 15:20:14 +0200
Message-ID: <20240619132029.59296-3-dakr@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240619132029.59296-1-dakr@redhat.com>
References: <20240619132029.59296-1-dakr@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add myself as firmware loader maintainer, as suggested by Luis in [1].

CC: Luis Chamberlain <mcgrof@kernel.org>
CC: Russ Weight <russ.weight@linux.dev>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/rust-for-linux/ZnHkQpyiX4UKdLEt@bombadil.infradead.org/ [1]
Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 38e7e0edd9b8..19e4a21e574e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8569,6 +8569,7 @@ F:	include/linux/arm_ffa.h
 FIRMWARE LOADER (request_firmware)
 M:	Luis Chamberlain <mcgrof@kernel.org>
 M:	Russ Weight <russ.weight@linux.dev>
+M:	Danilo Krummrich <dakr@redhat.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	Documentation/firmware_class/
-- 
2.45.1


