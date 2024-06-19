Return-Path: <linux-kernel+bounces-221100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 192DF90EDB5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 15:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 134911C21416
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 13:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC80914B970;
	Wed, 19 Jun 2024 13:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oj7Vvcjv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C662214B07B
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 13:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718803273; cv=none; b=QL1114iMNyDiAxUf8q3qDa/6MpPcYSV6K3nXKq1+RBTIUaxJYYLwb7cB+zne/PDDdhv39KAVB9gC6NSyvEcpcChva/npKZpW/L1tCy2h9DXkkOZlAdar6OD6tdlhoV5hMyxcVyjVhHXlm5tJRCQMYbhPvAOrVMOKpADGw02x5Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718803273; c=relaxed/simple;
	bh=r7JK+ojeJzz+ITwNKEu20e+lIYE4Nz4rAa+kLRpPCHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mM9yY/4cW2mWJcNt0c8nVWL7uM8Mu9yklSsz16WGsedec2rvRjnaIW1pTsiC30Niq60EuSfqHyEcqVhxxzfT68wRYkl5EanKdYd5hxrgPBMqkCDASSQffSqqPDsSDi+20kP54uzHCQax7PKGMJH000Je6CyUw3G/YUt04r0eknI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oj7Vvcjv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718803270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RVUc+CEwoyjb/GFZAG0m5bh7U/Mt7pB/alNJ5Y2rN30=;
	b=Oj7VvcjvaThVYxizxkUCMC082ijpKSLIYkrzTwAoZNuVKFC9QhWsxIBEtAV9HwsDFYZZMg
	e9dHwtz6/R50ANPFtQMZ6xArBffGeSS38SdFTWSyI+b9ahJhSnnJ7bqnrz4r5PurDvOF+6
	bdTjiKbde1LeIsJ2mfpLTr40prgdyQE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-O3Ge1h0bPgGCnYgMHOJPTA-1; Wed, 19 Jun 2024 09:21:09 -0400
X-MC-Unique: O3Ge1h0bPgGCnYgMHOJPTA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3580f213373so3913566f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 06:21:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718803268; x=1719408068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RVUc+CEwoyjb/GFZAG0m5bh7U/Mt7pB/alNJ5Y2rN30=;
        b=iRc5VvvG7KUqxNSYXbIq9CCw0zLmYwUpzXEavyrRIba5XYIf+ma2KzkNldrR1kVc2A
         8KAebAXrjISIcj1EGlvgqQ1LuvAlKyhx32XIhUncIJzbqzQCaVRgkbL8uzyu+uuNclAm
         BunR+GXa74c1vMY79YJ8oZ+Vv97amJ6p8IkuRvxnPKUCXjFogiPMCGCaI/DuJDlFle/9
         KqUaY3elFyudL5aSG3UzSVG2K+lesaZS+K2z/kOYtEkOaYGNjokwycbJ237k0ZScY+P7
         MZoALg06ealCtJFBSykpdbgB9M6PY5jgWPbL8D1w2okO8vKXh1C0qNR1dI6IzMghr7mn
         U31g==
X-Gm-Message-State: AOJu0YzUSvY1DdB8uiEwFgEK3Gc8mNdkRxRW+Osmn81Omr95mv/totON
	SSU7mei4Z7cGWXSaKHUc2ZG/aYLtTvrcy6mqYqiGewnFvDnfCIDltPntD3v+AI9jNkh2ue8QWhw
	57AFH/gU6QdXm75cV+KAR86MJ0ph6WsjTuJ/KhpJeKJpplX77BY6XwcSJ0J+/2g==
X-Received: by 2002:a5d:680a:0:b0:362:69f1:a08 with SMTP id ffacd0b85a97d-363175b8321mr1692295f8f.19.1718803268432;
        Wed, 19 Jun 2024 06:21:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdSrprgbJVizfzP3Lh3e2ypK5PlSphzExI5JfLf6vuuDdd27R8n5w8Z2hqucadLKqzsHlOzg==
X-Received: by 2002:a5d:680a:0:b0:362:69f1:a08 with SMTP id ffacd0b85a97d-363175b8321mr1692281f8f.19.1718803268131;
        Wed, 19 Jun 2024 06:21:08 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750935ecsm17282204f8f.3.2024.06.19.06.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 06:21:07 -0700 (PDT)
From: Danilo Krummrich <dakr@redhat.com>
To: mcgrof@kernel.org,
	russ.weight@linux.dev,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH 2/3] MAINTAINERS: add Rust FW abstractions to FIRMWARE LOADER
Date: Wed, 19 Jun 2024 15:20:13 +0200
Message-ID: <20240619132029.59296-2-dakr@redhat.com>
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

Add missing file path of the Rust abstractions to the maintainers entry,
until we can move it to 'drivers/base/firmware_loader/'.

CC: Luis Chamberlain <mcgrof@kernel.org>
CC: Russ Weight <russ.weight@linux.dev>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cf9c9221c388..38e7e0edd9b8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8573,6 +8573,7 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	Documentation/firmware_class/
 F:	drivers/base/firmware_loader/
+F:	rust/kernel/firmware.rs
 F:	include/linux/firmware.h
 
 FLEXTIMER FTM-QUADDEC DRIVER
-- 
2.45.1


