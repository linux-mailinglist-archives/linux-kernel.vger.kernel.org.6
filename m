Return-Path: <linux-kernel+bounces-405341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21ABF9C5003
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 08:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ACC1288E39
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 07:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC9D20A5F7;
	Tue, 12 Nov 2024 07:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1WPXrmR"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D6C1A726D
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 07:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731398037; cv=none; b=PMxYgVPHSVelOP8SI+QSdm4DXKAaVuND0AB7AQH2pmsslZ7roDjNLBtVi/wNEM3Hc+olTaRAS0XtUbFDovl5ePVN1Rw43Wumkn0f6759A3shYPjNk74RGgEcYpTvBlo21SDY/fGY6FZkGuWWsiTsx3llvFkz2ns11OuDWhsGmiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731398037; c=relaxed/simple;
	bh=NpZ+tkyj0H9hR4z/jJIFShCiFPa+eC0FyFaknV6Kdto=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hcFkoqXmcEOM6CwW7Xy8R5fcsm7ZouOhfz8ewhLH9OJYO7cIJQb6SfbN4ffMpGkYQIp0UvzHwZl3ioMQ6jjY2P647iUst6JvZDhGS2DGdoz8Xp5ZtQz66hqNTLSdIeif2Pq1sPgU9wPNa7cBrABflbLKAioZk4R1zZImfj/xpGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1WPXrmR; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71e79f73aaeso4315483b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 23:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731398035; x=1732002835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LUwAJIZH9sTo680OiXmze6FtZ8WG1hRbdJzQt/q5QBk=;
        b=A1WPXrmRIuwMDEvULqYy8HW2AIDpE1DJM4X7EEWtHlrQog3mPs2Hz5AVf5AoO+iDYf
         RlFRheKqu6zUkkE8KOmz2ALHrXWZ2dzqlivq2i1WM+6FzrMR9K5MzEKpUc9sh2hy75ew
         wVT+4A5r1xJyssjlOhanVb9fZ1qRSxSJR87YJwSHElnzPAKBpmCSIEmpAowTuhvvDuZq
         Ccu9HCTbgO7RhNpK8h7Yc0AH7h9ll7D87ai9BMbOP/9wULLDLTKa1uWwq1P7WAGoWWrV
         40fgPuVQ2Ugxo7v4thqkXGHhOy9On5aPk26+8PXgwHX3/zaIpmXAUTilfrhiH9DRionG
         PgdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731398035; x=1732002835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LUwAJIZH9sTo680OiXmze6FtZ8WG1hRbdJzQt/q5QBk=;
        b=qGXD5qHxewngBiIqk30iVlzTk+VbAW5paW/JTxGSIBg1vm1NoWAVMTsiONG0OZML67
         xtRtZ70xB6oER3GPT7/7EHgvwNW81R2E/HTlNGvc4AD3FnhTbO0V38MT2z2Rp8V+MiOI
         zkSl/JxNj18TAFamcON/KuQOc9BhfrgFyYjaOTuq9M5Rn6kiYov3mn7k5N9fnV/TqA96
         UbAnNmCMpl3bIzykUSdy0uoSvaSFwmyd7KeCNGneIIibpf4uoViV7rDNrxhcZ9IcHV8k
         nVWu39H/4quJcOMrqpX+cmOMkKh84Yxf1tddE9W/1nLICHrNXrDpZzW8Jg65NEhLNJhj
         kBbw==
X-Forwarded-Encrypted: i=1; AJvYcCV8TQWsRjXaIVwFzKHCP9nFMeagAJdBD0UwtYD9yhjtfNqvAz0aeBKbz0vwwIjePs8QlwB8jhmgBe8O/vU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlll7d0SYQQcj41TR9EbPmv5uU4P7vlg2NTqgcrFfm+YyGJ7HO
	CnZoMGE7jCtCPmTJ6GP+IATFvlLpzqPTkoISlzdH8EEhOa9YsYBm
X-Google-Smtp-Source: AGHT+IH4leXedmlfE+VTVXUnzIMfMbk7THOnMiR0cPkkaSiIWMOKES5RK1O4lVDpN+mPy3W5vAKqWw==
X-Received: by 2002:a05:6a00:2e1d:b0:71e:7c92:a192 with SMTP id d2e1a72fcca58-7241336afb8mr21476069b3a.24.1731398035391;
        Mon, 11 Nov 2024 23:53:55 -0800 (PST)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a17ed3sm10798564b3a.142.2024.11.11.23.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 23:53:54 -0800 (PST)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id 9659D802EC;
	Tue, 12 Nov 2024 16:00:23 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: tudor.ambarus@linaro.org,
	pratyush@kernel.org,
	mwalle@kernel.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: alvinzhou@mxic.com.tw,
	leoyu@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: [PATCH v2 0/1] mtd: spi-nor: core: replace dummy buswidth from addr to data
Date: Tue, 12 Nov 2024 15:52:41 +0800
Message-Id: <20241112075242.174010-1-linchengming884@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cheng Ming Lin <chengminglin@mxic.com.tw>

Set the dummy buswidth to match the data buswidth.

v2:
* Add fixes tag and cc to stable.

Cheng Ming Lin (1):
  mtd: spi-nor: core: replace dummy buswidth from addr to data

 drivers/mtd/spi-nor/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.25.1


