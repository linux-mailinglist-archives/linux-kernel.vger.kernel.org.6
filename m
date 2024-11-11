Return-Path: <linux-kernel+bounces-404551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0B39C4507
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 041201F2482A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1371AAE24;
	Mon, 11 Nov 2024 18:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKkwCSLY"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAA61AA787;
	Mon, 11 Nov 2024 18:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731350024; cv=none; b=AMHzTnUbTbIcRh9Wnk6ImKri9LUB/7dM/BrE3VkepAV7Cu4LZGt7JJ7KpXj3GYfO1VYze/5ltuENvWS+lXkrVvblyLjBbgxYypf+IWEkdx1SRJX75n3Vwl2IkUfP4kvW1GtLNbe0ApTSg9BUmAS4aEkCSrlzx5k3WwCJkdAFULM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731350024; c=relaxed/simple;
	bh=rXdD1oT6KgLnQ/pe7yWmTd+J9qmQH/4AG+g/e9zGCs0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eOtPoTgR9NQ9AlAw6oP5MglKtkJoQFUUiZaeiLrw6YwjuoxKEbjMe3yiDRbyBhsi6mS6+6FZnrytgOCdpFtqHA4JyTKTkSEJl8ZQGqyFh2x4pFTmiGhiHKUxu+Idm9KqbQ4aq0AS6bQWnQ1IDZq/+H0lBEoVYA345OX3nKWyx4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKkwCSLY; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-720be27db74so3585214b3a.1;
        Mon, 11 Nov 2024 10:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731350022; x=1731954822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OhDoeGPGQSclK0b1CMHj/7Ipo+GIKYolTtBk4YgDi9Y=;
        b=BKkwCSLYQUDtmOuznfdLbsNyvwD1/eWADS/ccw1VKFveHOiViuCaySsiwRzmJ9iuH3
         RDnTo6vp7j59ToTprwKZ11rRuwM9W9x0szr5ktdU12N4T9YzXGCBDiaRizULsFFSwUwM
         Ie2t1kyNXryQYuhOsIOgXL+Zx28NAvfcsHybWExWk8bHRpbupg9kUnpF4L68um0B2RIs
         SowfT9Wi9i1aNElcNfI2qRj1uZ6RNniBZ4p1NaRVjj5S3TyPAHMpHT0RhjiD37rNRQiC
         o/W2U9hhc1O5T6fJr/YyUgR/QdJ+3UgcUbqpCrT962k5268xmQnb3QLuhWhZFZYcrT5l
         b2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731350022; x=1731954822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OhDoeGPGQSclK0b1CMHj/7Ipo+GIKYolTtBk4YgDi9Y=;
        b=T8IGlhEiWSsHPu0D7FTZtalypE6Aob26QRBVolc6grShEHDVWydXvlRa/dAoSf3OW3
         uUcqI3Irhi8eeLVNQ+HXQ63/AwanNY9qpu6ymT7w5NR6T2Ooa5CwouBeSFHxi63ZPXqM
         QrsNN7sZuz8VX57vUrKYlqjmjhg4FKBlmdMaLTl/gFLoIM3lg52vJ1ZLZa/JC/qgMPqI
         Qf7wjEudEp/FC8CpW0UJXBCbQR7OsTf8zSObmgXPALPHAz1ItJXyBcELUvU+dfCeWwIo
         +n7wGD7inm+X2qo/QyUPVIZN5iqcwQa8njhbt8L5YDq77MdGEafQLxL9kUcVlimw2O5T
         JACg==
X-Forwarded-Encrypted: i=1; AJvYcCVEAU8EsEFFhhA2Kff9btkf0tSnCDTx6eswBoeyrq5xuy5de2e0x71xB+is2cL1+rSS3EbRv7/V2es8gdCXxgH8KpUGPQ==@vger.kernel.org, AJvYcCWHkB+aWBk0nECUJEbq16YqynDcjb7gM/o89pqZUt2U3vrC6u2nxOFo2nEbDeYspRhDoW6dQBI8BW8TdoE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj7fJ0ZQMYUU4hY19jM7E0u6M34TusdfFCr+8EfPJv0+4s1xZj
	bZUHmcUqY8Munh8cojK6iEVyCSTd7b5ay7PJsJutJUKAosd6siR+
X-Google-Smtp-Source: AGHT+IF8zo6FIWAmimgIxaU2f+zhwXAwfFuxwo4SGyqC5LN0d7hRRKE5Xb+l8KPh1aP3CNVLPBWGiw==
X-Received: by 2002:a05:6a00:3c92:b0:71e:44f6:690f with SMTP id d2e1a72fcca58-7241407ca6emr20927435b3a.8.1731350021827;
        Mon, 11 Nov 2024 10:33:41 -0800 (PST)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a5ebaasm9517037b3a.191.2024.11.11.10.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 10:33:41 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: ilpo.jarvinen@linux.intel.com,
	w_armin@gmx.de,
	hdegoede@redhat.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Dell.Client.Kernel@dell.com
Subject: [PATCH 0/5] Better thermal mode probing + support for 9 models
Date: Mon, 11 Nov 2024 15:33:10 -0300
Message-ID: <20241111183308.14081-3-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

I added models for all the acpidumps I could find. Also I find a way to
not brute force create_thermal_profile and that's always a good thing.

I hope you all have a great week!

Kurt Borja (5):
  alienware-wmi: order alienware_quirks[] alphabetically
  alienware-wmi: extends the list of supported models
  alienware-wmi: Adds support to Alienware x17 R2
  alienware-wmi: create_thermal_profile no longer brute-forces IDs
  Documentation: alienware-wmi: Describe THERMAL_INFORMATION operation
    0x02

 Documentation/wmi/devices/alienware-wmi.rst |  12 +-
 drivers/platform/x86/dell/alienware-wmi.c   | 150 ++++++++++++++++----
 2 files changed, 136 insertions(+), 26 deletions(-)

-- 
2.47.0


