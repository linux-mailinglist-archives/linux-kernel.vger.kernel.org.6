Return-Path: <linux-kernel+bounces-256134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AC793498C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 10:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADFFB283CD7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 08:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4CF78C71;
	Thu, 18 Jul 2024 08:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="e41d7O0M"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE9F78C7A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 08:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721290104; cv=none; b=H33wjsfJHoppeYBDoZci1mO/GiuZ6ho86CDSrekRh9unh34XBio6sfG4wiJQj5lckzw9TqY3D2WCNOANz+C/SnYtRdtaZI09ze5hyVyxHQKcNteR3jE/RkgpcNeYXmBRkzkpx0HZJ2x+B70W0NgIr8o1ceV/inm8C865Z9KlgJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721290104; c=relaxed/simple;
	bh=stIAApLHsv13L2+WlRqAXQuJPOPJT4+musbzWj6h73Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zn4QkD/38dA8d/qBN9ouWQUQ+sOQt3MsAEDAqdj8oMLYV6+UCYuok0laoKMvH4aQtMTkTjzNvjLotVWdV243Gi8NgfSnoYuEzbgViKV7O87CzW2bes/y1HQbFypCVWj/8DaPcFBp5gWj3kdq0EB6UHEo3eqUB85EjHZM60ebwhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=e41d7O0M; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70b05260c39so405430b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 01:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1721290102; x=1721894902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SL2KhlCSShY0ltqGwzoWJU5urIFwQY8SPKFX14sWSc0=;
        b=e41d7O0MsDxQW+zruB0nEKBohm2SxO8sCUL/M5D/24/m2U/UatcqbBfSTpC4Fq7SJ/
         lsTD1FlVaiVrYIekKMwoxssxmhnnLmm/uYusiW9r0jTnw5Iz+L2gl+N6+IouLrY0aA59
         jgc8Q+RD5zgB6WeIS2w0Hz1irYvgteM9XaCgi+cdsaNzg/hmhH99S+No4LGsnIqv535a
         b8QumOf7Qsun0Nnk8E7ZvguBLj72eOruIsF7zkdhAfg/21NNx2aYSiWri8zwvBqCzRO0
         OWcjVLJiG0wqLjD7R2YwK78mU671PeX0+ImqB7jRyMMapIGUl0tnEnHgiAcwOWIpWZrd
         ot+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721290102; x=1721894902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SL2KhlCSShY0ltqGwzoWJU5urIFwQY8SPKFX14sWSc0=;
        b=QNM3p0B1WpXf/VwC6PRQW7og6MY645wQl3esNM+z8XkbHDSKkCEZjCu1MJzKCB0uqb
         SGxWMur5uK5wv7sYs1aOyGoixlOb4L+BjiSTIUuvkN9fy0MuI+lEs74ektBNWhkjiDxf
         cTW+GI5+nI8CVCnrGOEsxd/EiNAUK8oIjWsOUpN2DDaVePPgniye8U1JcuIKFY+kWHOv
         Ldq6yNEDg8seD9pMUX1V6sL/UVhMBY7SYlRrbyMfqpx7GmtiX0UM8/0hom43XFAJ2VD6
         E5TZQwiFt9eDw7KtA48So0UQJ8412m4D/tJZSnvLNX5009A0t3Hsx1dXdeNqP5UsTEmx
         9Fiw==
X-Forwarded-Encrypted: i=1; AJvYcCU2EfgMCmt4fla+nXFRNV4+LUJbfo8b2MgbbVthfJ+NSEuKicKwpiaL+QmA76p3J9LhioG/YohS8CN/gSXdazuiqXRziLJdEA7AlgSg
X-Gm-Message-State: AOJu0YzB5smlwGWzmBEGt4hgdY90plFccuptGAOL46oPyqVH3oEsW00A
	rlOHXnx+owe9IpqlyIfq4dUNOSpBGLQNMnXnwbU/aTf6YivHV+EO/Kx075lxu4I=
X-Google-Smtp-Source: AGHT+IGWp7a/4CKcmDOndp+K3rVQWgNFjYmK4qQZAtiVYwy6rZx/wzfXNJ0BvsLjioBoer7jFnyauQ==
X-Received: by 2002:aa7:8887:0:b0:704:1c78:4f8a with SMTP id d2e1a72fcca58-70ce4f1fea2mr4813895b3a.21.1721290101544;
        Thu, 18 Jul 2024 01:08:21 -0700 (PDT)
Received: from localhost.localdomain.gitgo.cc (vps-bd302c4a.vps.ovh.ca. [15.235.142.94])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-78e34d2c4d3sm7385958a12.48.2024.07.18.01.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 01:08:21 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
To: Jens Axboe <axboe@kernel.dk>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-scsi@vger.kernel.org (open list:SCSI SUBSYSTEM),
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH v3 0/2] scsi discard fix
Date: Thu, 18 Jul 2024 16:07:21 +0800
Message-ID: <20240718080751.313102-1-fengli@smartx.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jens,

These two patches have been reviewed but have not been merged into
linux-next. Can they be merged into 6.11?

Thanks,

v3:
- rebased to the latest linux-next branch;
- put the separate patch2 in this patchset;
- add reviewed-by tag.

v2:
- rewrite the patch.

Haoqian He (1):
  scsi: sd: remove some redundant initialization code

Li Feng (1):
  scsi: sd: Keep the discard mode stable

 drivers/scsi/sd.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

-- 
2.45.2


