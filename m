Return-Path: <linux-kernel+bounces-511883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC3AA330FF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 21:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E5B8188B1B4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 20:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189A11EEA4A;
	Wed, 12 Feb 2025 20:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="asumzZjL"
Received: from mail-il1-f227.google.com (mail-il1-f227.google.com [209.85.166.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B590E27183B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 20:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739393195; cv=none; b=SQuvaruD4COHLfWKwKKSsAKywht+UsdFg0O/RP6eMIjwIMa5PK2Y8z+zlIVoob+RUZYa12xEUUTIUJsu2i6HC6yhN1FTluOsSE91IE6xWq7bIkq9zbpbZSqWnBvWOYh8tJaOcSvkooP2wJraAcF+FNvdFeX+NYmsDd89PlvKNvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739393195; c=relaxed/simple;
	bh=WEbvghG5qG37wCBWMvGFFRMd/IgFtSFjI1yWwCpYjpU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hydJmHqzryVSO++//0mPkZ4DTbeWHjhspszBtLLviJt0DQpKARcSLJWjdBrTsOCRRYiJe27e5z1Dc+B/xvfO5owlFekSRbdsX+3UD5ej/S2CrrZUbSlOZJPnS5pfKWE2BFTw78RIvESNxTqDIyCaNVg12jzA1AKncI/yw490dc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=asumzZjL; arc=none smtp.client-ip=209.85.166.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-il1-f227.google.com with SMTP id e9e14a558f8ab-3cfb77a7e21so16955ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 12:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1739393193; x=1739997993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C1Szppuqbw+roNwcR7rWxy0Q8IaoVRiOv/Zo+HVKhVU=;
        b=asumzZjLUxObP7y+oqQwbEjVQA+59XA5DlnkgYtifN56VpeXFrMNRI7bJlNvuicXGm
         DoPlYrM8h6VE4rCwTCzd+OWrtneeDiLywZVXs1qRmm8w0beO1CcRz1h+kmp6pz+WB7Xz
         Wxz5inMa8FW9G2PyRrnMnySQAkvelgYkxm24z+DAVnmQOPtDpGjphcx7xk1xMyqp4RX/
         ViUuR6Ucegb2lySKR1KoeK7yVzeGQD9EZsI5Vtcx61rFfM5j9bHjq8ESYJR6ZRSuTqB0
         y8n9RyuLSL2HXpFgL1fU4Wcxt9cLz5Jn87QGURc9Ae7ZjHYClVgVqGbscfix4ZBP2Esn
         jWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739393193; x=1739997993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C1Szppuqbw+roNwcR7rWxy0Q8IaoVRiOv/Zo+HVKhVU=;
        b=Qp0EaYlF4dEs849OrEKlNWsN7G+XD7PsrJmdwP+xuLjat0m/4H3dLfesQR30hshL/W
         YpqVm4EWCejAd5t5tgwPsM7hd2MImDc3o5S4n7yNiYzf19BMepkC9e0eI9QgL6/Bnymg
         MGmvj1OK0kAVSD40OgL3VklAS6qkLssjxX6q02ERGdSQo5y5Ix8SKz5DFHx8f9lGOudK
         Hd4cWheHFFAbgcJHLydjZUUZxbqw3msmwg21uaTOdFbat2TiDcn+6n2A/ciQWWUXsNVW
         OEMAWtWkiD671yAMhSbdZ6MSa5E9YX1J9TaNhwoiBiVSqu+J6oITXRYMqd9W9Fwsf28m
         BpKw==
X-Forwarded-Encrypted: i=1; AJvYcCVAXvYp18dBtxYDAMvoSnSOIaJZmTJZ8Bj/WTCxWxAXhgUB0A/H+uYMibsc40pSNMHGfWsCk5R6YrRAieI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHaNUTx/xtsItzBvR5pGzVPpxCMbYAG7lkTrVLMea0BHiTrpXF
	ksgnRxnDB/oyUNX64aWx2FHHME7Xv+dRNQWuFGqdeQGEopn9xogVghpHC5gsAfOtOeuMPKHGfxX
	2kpqF2HsQd+pL7N7GxCwjDgiYBx+j85U2+80Vw0pH0iOWyZM4
X-Gm-Gg: ASbGncucj8zImKnnX/HodMIfPukjOVQDAPumNU5Z1CytLF+zGwL2JpbPKYViqyFPbhV
	cpd8BwHjtpEX9sPvNBgECqlFCngzZ6eAGycxbafO9D9xNLBs8W6E0fotQdho0Wrtdxh4J3Otsk7
	0eue28XEvF0H9Odptv+Dh3UzL5Zxkd4rKHgZUa2yEE8R1oRn+oGT5uEqCMmqAIiIedRDfcBDAnn
	3VFYFhHNOcjmB03PkC0ro/F+2LJaNtW8G7UUO6mc75u4bZOEVXxNV75Jt2MsG0x41Ys0OPEalsy
	ISqkj276s1JULz/XnlAOpWU=
X-Google-Smtp-Source: AGHT+IERRFz28hVonQcVW2NGKlN7rUa7EdvNtmcD5oahOamuqm8rs+l1MW3XjQINiNLg48cf22LBeVh8KsUC
X-Received: by 2002:a05:6e02:3208:b0:3ce:7ac0:64c2 with SMTP id e9e14a558f8ab-3d17d0725efmr8768165ab.1.1739393192833;
        Wed, 12 Feb 2025 12:46:32 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3d05e8d8fa9sm8855715ab.11.2025.02.12.12.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 12:46:32 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id A78583401A2;
	Wed, 12 Feb 2025 13:46:31 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 9D155E41973; Wed, 12 Feb 2025 13:46:01 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: Riley Thomasson <riley@purestorage.com>,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 0/2] uring_cmd SQE corruptions
Date: Wed, 12 Feb 2025 13:45:44 -0700
Message-ID: <20250212204546.3751645-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In our application issuing NVMe passthru commands, we have observed
nvme_uring_cmd fields being corrupted between when userspace initializes
the io_uring SQE and when nvme_uring_cmd_io() processes it.

We hypothesized that the uring_cmd's were executing asynchronously after
the io_uring_enter() syscall returned, yet were still reading the SQE in
the userspace-mapped SQ. Since io_uring_enter() had already incremented
the SQ head index, userspace reused the SQ slot for a new SQE once the
SQ wrapped around to it.

We confirmed this hypothesis by "poisoning" all SQEs up to the SQ head
index in userspace upon return from io_uring_enter(). By overwriting the
nvme_uring_cmd nsid field with a known garbage value, we were able to
trigger the err message in nvme_validate_passthru_nsid(), which logged
the garbage nsid value.

The issue is caused by commit 5eff57fa9f3a ("io_uring/uring_cmd: defer
SQE copying until it's needed"). With this commit reverted, the poisoned
values in the SQEs are no longer seen by nvme_uring_cmd_io().

Prior to the commit, each uring_cmd SQE was unconditionally memcpy()ed
to async_data at prep time. The commit moved this memcpy() to 2 cases
when the request goes async:
- If REQ_F_FORCE_ASYNC is set to force the initial issue to go async
- If ->uring_cmd() returns -EAGAIN in the initial non-blocking issue

This patch set fixes a bug in the EAGAIN case where the uring_cmd's sqe
pointer is not updated to point to async_data after the memcpy(),
as it correctly is in the REQ_F_FORCE_ASYNC case.

However, uring_cmd's can be issued async in other cases not enumerated
by 5eff57fa9f3a, also leading to SQE corruption. These include requests
besides the first in a linked chain, which are only issued once prior
requests complete. Requests waiting for a drain to complete would also
be initially issued async.

While it's probably possible for io_uring_cmd_prep_setup() to check for
each of these cases and avoid deferring the SQE memcpy(), we feel it
might be safer to revert 5eff57fa9f3a to avoid the corruption risk.
As discussed recently in regard to the ublk zero-copy patches[1], new
async paths added in the future could break these delicate assumptions.

Thoughts?

[1]: https://lore.kernel.org/io-uring/7c2c2668-4f23-41d9-9cdf-c8ddd1f13f7c@gmail.com/

Caleb Sander Mateos (2):
  io_uring/uring_cmd: don't assume io_uring_cmd_data layout
  io_uring/uring_cmd: switch sqe to async_data on EAGAIN

 io_uring/uring_cmd.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

-- 
2.45.2


