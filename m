Return-Path: <linux-kernel+bounces-200313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF398FAE5D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B247A1C22E3F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6092143C41;
	Tue,  4 Jun 2024 09:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="K8amYOfo"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FF714372F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 09:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717492152; cv=none; b=FuVy71c1F9wnUi+cb6XypfcCFdlKm5n/McAXls03q41lZuNtwXX6FaZBQjIEKknAg+/kL+r4llT25m5gnRNzb/ZBBbfypjK0y3zNfIt5t2DS5dSv/oJsb4Yvku9oLAdrteOtCV6C+606VARIOm7UeUxWPc7fSCPwcsuu2iyzdtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717492152; c=relaxed/simple;
	bh=DWv4Ts4UPDewpPAZDKo61Q6cBJ8156Q/JPUenZNlwS8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EYCk7aRLbDR6qo2KY7EnbQgGvPa5rtwcZYtgX4RYgWW/PSFOiL8CJd6nuMinFP5PG636vfaPjWxasclP4USUrd28ugoJ7IWi4YGpdpHN22zE/24CN8Dmf63KC7NKvZtrEPo2mUYFDl+1V1Ji9knUb/sqaiiBDaxkko5inAoeQ6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=K8amYOfo; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57a50ac2ca1so3261344a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 02:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1717492149; x=1718096949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TwZhGhfqKNwGAAazIH0NZHq5xaKIh/aom8Ka+wD6k0o=;
        b=K8amYOfowrokWNPT6gXG/PlWCasoziDhTFdXG4oNVQo9BuMRz2hYJdmxDFpi+5IvVG
         VBBe8Zy2FqHRStnxZQHW+R/bYoQxrpjMQ/w/+FZzJVBOIIZXNqMinqC9HISAGkkHJIkZ
         JTNQy8xvjWLpGdYvMSHczW5PO/T5nZY9AYT9NYg+bgrk5BLloheUbvi+clLD81SqvZAe
         hcsXE24eNMZJI+v1zN96ihqUdRKX6XMnucp9yUD3jGECZSc/Zz4cH3xmHu2W7BL2W2fP
         qkN+Y2hiAb5LHch1N/rLvMoUymHHAx9A7dl/Sot0bzDW19ecYWv/MLZvtqIXlPy0nZmy
         9wng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717492149; x=1718096949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TwZhGhfqKNwGAAazIH0NZHq5xaKIh/aom8Ka+wD6k0o=;
        b=nAcjh4unktlITGaqRmX6tW3EJo8m1d/MHuWd8fRlgaOQD7sNqWQ4ap3ecub+nToRUU
         T5J43VY7GKEqNBUrOyaA1Jnjw5RGzaLcX97vakGWFIi+AjSAJiLqqL3qxkdD2SmiT5IQ
         tp+f4alLTASa6VSZqeuNIAJ0lJzaU+b3TxbeMH6fAEAf8PvrzltWGqMVagv/d1+EOqN+
         +cT22RD5wnmudYKjKORB9U7bUgDiqH29ii3LIoIj9cljgMt9hlcoHgoVIep19RaIk7od
         AtU0Io+kLuOo8gfB3+D0vtAQPA1uCRghvt/5iA4B06mEt75/s7M/r5k1iylj9iXc2k3w
         8LXw==
X-Forwarded-Encrypted: i=1; AJvYcCWfhuR08zetxjtTjds3BeNeeNRw+OGyqC1DHtnBbgdNDJ912oFY9K3VguhAhMsEZlPyHhGS2Ir8+4efYUacJikLUIKpHnqzbWs40E+o
X-Gm-Message-State: AOJu0YwvYvf8/Z2HFt2JLaXjFS5a5dGwfLY4zS+3FvivdaymBsrbdw28
	kklzHTzq9Br4frnWjnOpNm3eE43UNxHkZyxfHwD4zDyMw61pOm+9oUG/ClTAml8=
X-Google-Smtp-Source: AGHT+IHidc0HMkZpoHuW0F0Uuz8Q2jiGIktaIZ3mnWU/29ySDASkCqqcBJVcUe29ebu6h5fIJXGpJA==
X-Received: by 2002:a17:906:4bd3:b0:a65:ab25:24da with SMTP id a640c23a62f3a-a681ff4540amr819129466b.22.1717492149299;
        Tue, 04 Jun 2024 02:09:09 -0700 (PDT)
Received: from raven.blarg.de (p200300dc6f4f9200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f4f:9200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68fa49e66fsm328376766b.129.2024.06.04.02.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 02:09:08 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	sfr@canb.auug.org.au,
	david@redhat.com,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v6 03/15] include/scsi/scsicam.h: forward-declare struct block_device
Date: Tue,  4 Jun 2024 11:08:33 +0200
Message-Id: <20240604090845.2182265-4-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240604090845.2182265-1-max.kellermann@ionos.com>
References: <20240604090845.2182265-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After eliminating includes of linux/mm.h, the following build failure
occurred:

 In file included from drivers/scsi/fdomain.c:87:
 ./include/scsi/scsicam.h:16:31: error: 'struct block_device' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
    16 | int scsicam_bios_param(struct block_device *bdev, sector_t capacity, int *ip);
       |                               ^~~~~~~~~~~~
 ./include/scsi/scsicam.h:17:27: error: 'struct block_device' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
    17 | bool scsi_partsize(struct block_device *bdev, sector_t capacity, int geom[3]);
       |                           ^~~~~~~~~~~~
 ./include/scsi/scsicam.h:18:40: error: 'struct block_device' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
    18 | unsigned char *scsi_bios_ptable(struct block_device *bdev);
       |                                        ^~~~~~~~~~~~
 drivers/scsi/fdomain.c: In function 'fdomain_biosparam':
 drivers/scsi/fdomain.c:475:45: error: passing argument 1 of 'scsi_bios_ptable' from incompatible pointer type [-Werror=incompatible-pointer-types]
   475 |         unsigned char *p = scsi_bios_ptable(bdev);
       |                                             ^~~~
       |                                             |
       |                                             struct block_device *
 ./include/scsi/scsicam.h:18:54: note: expected 'struct block_device *' but argument is of type 'struct block_device *'
    18 | unsigned char *scsi_bios_ptable(struct block_device *bdev);
       |                                 ~~~~~~~~~~~~~~~~~~~~~^~~~

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/scsi/scsicam.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/scsi/scsicam.h b/include/scsi/scsicam.h
index 6eb9fb7a57d0..c0de038b76b5 100644
--- a/include/scsi/scsicam.h
+++ b/include/scsi/scsicam.h
@@ -16,6 +16,8 @@
 
 #include <linux/types.h> // for sector_t
 
+struct block_device;
+
 int scsicam_bios_param(struct block_device *bdev, sector_t capacity, int *ip);
 bool scsi_partsize(struct block_device *bdev, sector_t capacity, int geom[3]);
 unsigned char *scsi_bios_ptable(struct block_device *bdev);
-- 
2.39.2


