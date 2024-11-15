Return-Path: <linux-kernel+bounces-410373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C079CDA8F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 09:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8707D282E99
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 08:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5238118C332;
	Fri, 15 Nov 2024 08:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GTtEJuxQ"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B689718C004
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 08:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731659571; cv=none; b=cqOiHeosgdVjnlHclFTKWqplTC50AFF9JJ2VhQbrUA6kwHFrHmDrptnypPhxbc9ebsSajvX1YOeloyRxVIktkemZQf3rfnq/GqX0v7psP8Hs20gQYNk56pOcVssQM5XGUSGfpCnIt9OA9aNmd1/+ULgBxIjUn8SHxG5SXfrlDXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731659571; c=relaxed/simple;
	bh=bwKXMZ/CqyKVXHRWjad7VNJ99PRPhanXO2k0v/9eehs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LJz+4F196KADCUyZ6i8WB8f7ppl5qb0oNOb2tgxN50HxiZ1SEMIRxPIZAm2J7NYuUfkz0Fg7koKZKt23OOqGPCZKmBwwDw8WYVJxpXICvZQjpJr/Zjh/xGknCcZtUZmwGccroEPzTIzq/Y9K8IBCE2HbqahE4RWIEelKCY4yw00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GTtEJuxQ; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-460a415633fso3085951cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 00:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731659567; x=1732264367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+oyM45fO7kqXMoRRUsCsV2dgNjzQvpxBqm/zmpiRHXg=;
        b=GTtEJuxQtRSaBvciE0/O4V34pZ7STyPdVt2dMCpwWrN1Bp+jAL6Dm048ct+xkbpfB+
         1XDNUdpqYfz4eS6KwONDWy2BhpftlINR4rF1NLU7vnKuFWydHUZ0UYh6Yk20CAhcRSmO
         L3XpjPMfAI39c9Y+JI34YvXxEpzPU3/A9TnfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731659567; x=1732264367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+oyM45fO7kqXMoRRUsCsV2dgNjzQvpxBqm/zmpiRHXg=;
        b=H+tgoOFgwEIxAIYLo3Pittf2yIguQehvT9SPkzm6DU8L3uewlD5zs3L1Bj+Q+gEvPN
         +k6wVj8JUzK4We5j3HI/74l/V2RtpFiff1bd/+Nrb4iTnZ3bAfN7QLIBVFcaFlaO9ed8
         1MwRfZQYwz4ehPdXWJNSlkDOGbtxMK4AEeeOK4DmmRa4af9uFQwkG7k/Uo/ZEvO8Z8Xd
         22cUBVDVcDGyo5rnxncNprrzdh7URhFMbGw6Ibwzl0pUD8Ca8PAo4Oh8dhmW1lEFJuAd
         cCV49IcLn6ZJPKBHg0G5yMpLcL5EI0VgDuInXfh6tfyzoW8d8A12v45OkN82c7Hj1UJF
         hwtw==
X-Forwarded-Encrypted: i=1; AJvYcCWzaieYEcVcjpkJ3N+CY51O36CuOwhhPv3hUwBQRltDRViR0jReXdn986tsbGviNa3URrQvze3FggrlFLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzKwBKWCAAO0F43vZeeWRsywVAPZ9twOFAMR/HGy6PzoZh1LmI
	DAOlR38q76Ub3TqODyY2F36aOLb4l9PJFIEqVB/Z3lLevF4lbptizNug/+7Ohw==
X-Google-Smtp-Source: AGHT+IEIC73NXLt7bHwh/TMQ6UkI0zrz/RHhFfkxb8RIMOzTdzyOAiIAIfCgAfuhcrXgqjJXvnY2dQ==
X-Received: by 2002:a05:622a:5187:b0:460:9ac7:8fcd with SMTP id d75a77b69052e-46363de864bmr26095761cf.1.1731659567548;
        Fri, 15 Nov 2024 00:32:47 -0800 (PST)
Received: from vb004028-vm1.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4635aa37c54sm16584231cf.53.2024.11.15.00.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 00:32:47 -0800 (PST)
From: Vamsi Krishna Brahmajosyula <vamsi-krishna.brahmajosyula@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: yuxuanzhe@outlook.com,
	linkinjeon@kernel.org,
	stfrench@microsoft.com,
	sashal@kernel.org,
	senozhatsky@chromium.org,
	tom@talpey.com,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Vamsi Krishna Brahmajosyula <vamsi-krishna.brahmajosyula@broadcom.com>
Subject: [PATCH v6.1 0/2] ksmbd: fix potencial out-of-bounds when buffer offset is invalid
Date: Fri, 15 Nov 2024 08:32:38 +0000
Message-Id: <20241115083240.230361-1-vamsi-krishna.brahmajosyula@broadcom.com>
X-Mailer: git-send-email 2.39.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dependent patch (slab-out-of-bounds) is backported from 6.7 instead of 6.6.
In the 6.6 commit (9e4937cbc150f), the upstream commit id points to an incorrect one.

Namjae Jeon (2):
  ksmbd: fix slab-out-of-bounds in smb_strndup_from_utf16()
  ksmbd: fix potencial out-of-bounds when buffer offset is invalid

 fs/smb/server/smb2misc.c | 26 ++++++++++++++++------
 fs/smb/server/smb2pdu.c  | 48 ++++++++++++++++++++++------------------
 2 files changed, 45 insertions(+), 29 deletions(-)

-- 
2.39.4


