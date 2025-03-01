Return-Path: <linux-kernel+bounces-539841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDC5A4A9A0
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 09:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBD443BAB04
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 08:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD581C5D53;
	Sat,  1 Mar 2025 08:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z/eZcQgN"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6FD156861
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 08:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740816677; cv=none; b=rSvE5ntqqngz2iM2xlj6QLddQqk+xQzafx3yxl34PyZ4ouTqsi4GBcirAg+CQHSObl0MpSeygdEyCzreX39Lornyvd1TnwpGuc5vioB0YDJvx1gfuhDnIDxlxS/B2YqNEmlrNssMJRrbHzQdBFN4FRi34KFETNGGttWE1EUiHA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740816677; c=relaxed/simple;
	bh=y/PM0okwX0Ed7bixbKlSzQClxakMqEJ6aJ39DwnMPLA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r3TuWnFM01yGmoY48vW2Rwoxg2ONDOxehWSjgcrwYOSbPqibQvP3yq7hJrBB1pIbQVgHD758FVdbjra2c2n1kk65V7VPvruFidq+ggHSYfjgGS2NWGBP4R+YnXd0kgh0EWSdBK42pS6Kj2eHE/8TrQYVznGmJ5tZ4Jb0cf37QMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Z/eZcQgN; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e4c0c12bccso5116170a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Mar 2025 00:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740816674; x=1741421474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mjLt20YjMampy8+UMdDtqCZbrxv2nFX7rkyDyefUrns=;
        b=Z/eZcQgNQ097JWDwDqvnIci2SU/Ku4BgxnoJkBBQjIzVy0QMKo+UMg4MFQSnqc3rVe
         o02JAbEtx47BJbwGvMDtR/7FSnaKBI7YBNAJktnkeZoH8/OuZijzJ67P4G2SxasxO3Oe
         KdGfEeM45IhIKsKmWXwZN3akgVehXALkSDkNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740816674; x=1741421474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mjLt20YjMampy8+UMdDtqCZbrxv2nFX7rkyDyefUrns=;
        b=PFyNgLu2bc7j7a4ylp3cG57sp/rgOpstiOmEbFVyp7eE0dPAw0Kr1EDCQHLA8y1fCY
         4AwmyU67QKmnQWx1vKQ/RW4f69avwfa/PYaESju+V5xXEeC7J8SqHJH/zazfPe8qYDfB
         n4E7i4EsLIr28CGS7wwSQB0xu+OWJW8jKLaFcPaXPh5r93vM9E1JiXX740egeJ/7BnLZ
         K+jr+3+VLTRjuG/u9tZ4q+RXHZxNwO1IvhlybTOI1CMv6TY8wnFywe7837c/Xzps0WFL
         bCA6ZtpNwP+u/nXOay1i+As8eibJaxI+rgqp2rDzzNJKdZtfOWS/rDi41BznnRRuRbAm
         9HOA==
X-Forwarded-Encrypted: i=1; AJvYcCWJLwJXf0WDt7TKGgK501T1aD9qbT2qSogmgJ9cmVodoE9Oi2K0XL1i40PIDP0O6N+wk+lcvCartJt69Vg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW2jvMo0uEMsKA4prB3R8Mxp04fEmg5ylU/RebjFW3ZdTJrjxC
	tPYJgxTfo6MZjtILii7LR+Zut39QdGMb6XbHy4DmvV3SpdVWyFGgLidIqty6Vw==
X-Gm-Gg: ASbGncs21z4usarEbBG9A25PFfv8GvjL/Q92PgKT0Ji5RBmMFjfCd6GUeGRIevU5URk
	O+waZhEgwz51+/MNZbAOiCi1q6yth6BLqIuOlyI0KkP6aV6iwyKoWu8uwwUrzxVYgDdZ+uaaM/v
	Aa7zKfvRSZMplV3jbXHCIdfmrEzUzgfsP1kMNIzP3GT/TUbJmQl6vO9sLfhHtpNJc8RVsqZhzKE
	82ZoK1u7C8Yh9GK6DPXyPZPWLAU009gZ1yrFCO3C7HJ29jtJZtiVg7ecQDkquGm3VCy92yVnnFS
	hSYeBf1/gx/uOabvzLgBH9Gxo3hQilSxFEa0eTIC9ESAkAz2AqG/Hw9ypB8H//k5wTa6XdlCOyx
	lcwSOtk4V2vI7CkLDktVBaX3vp4wYdvDfmAw=
X-Google-Smtp-Source: AGHT+IFWGjTqEOE7iDv+KUg8YX7v2GdNhxUdYlf7Mvz5UaXeO7udGrcXIKLthgLSbZd5OCdVON4QnQ==
X-Received: by 2002:a05:6402:5214:b0:5e4:d192:2373 with SMTP id 4fb4d7f45d1cf-5e4d6af23a4mr6484482a12.10.1740816673887;
        Sat, 01 Mar 2025 00:11:13 -0800 (PST)
Received: from akuchynski.c.googlers.com.com (140.20.91.34.bc.googleusercontent.com. [34.91.20.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3b4aa5dsm3693641a12.14.2025.03.01.00.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 00:11:12 -0800 (PST)
From: Andrei Kuchynski <akuchynski@chromium.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Benson Leung <bleung@chromium.org>,
	"Christian A. Ehrhardt" <lk@c--e.de>,
	Jameson Thies <jthies@google.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andrei Kuchynski <akuchynski@chromium.org>
Subject: [PATCH 0/1] Fix race condition causing NULL pointer dereference
Date: Sat,  1 Mar 2025 08:10:55 +0000
Message-ID: <20250301081057.1952519-1-akuchynski@chromium.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel crashes during UCSI initialization due to a race condition.
In ucsi_init():
1. ucsi_register_port() sets up a work queue and schedules
ucsi_check_connector_capability task.
2. "PPM policy conflict" causes ucsi_send_command to fail.
3. The error path (err_unregister) deallocates resources,
setting con->partner to NULL.
4. After that, ucsi_init() waits for the work queue to finish its task.
5. ucsi_check_connector_capability task, running in the work queue,
attempts to dereference the con->partner pointer, resulting in the crash.

The core issue is that con->partner is set to NULL before
the work queue task is guaranteed to have finished using it.

The crash log:

cros_ec_ucsi cros_ec_ucsi.3.auto: PPM Policy conflict
 BUG: kernel NULL pointer dereference, address: 000000000000030c
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
 CPU: 8 UID: 0 PID: 13 Comm: kworker/u64:1 Tainted: G     U  W          
 6.12.0-g15b373ee5573-dirty #1 b5276ebf6ba85f471d9524ce34509877165c9f58
 Tainted: [U]=USER, [W]=WARN
 Hardware name: Google Fatcat/Fatcat, BIOS Google_Fatcat.16163.0.0 01/15/2025
 Workqueue: cros_ec_ucsi.3.auto-con1 ucsi_poll_worker [typec_ucsi]
 RIP: 0010:typec_partner_set_pd_revision+0x5/0x80 [typec]
 Code: cc cc cc b8 ea ff ff ff c3 cc cc cc cc cc 0f 1f 80 00 00 00 00 90 90 90
 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 <66> 39 b7 0c 03 00 00
 75 06 c3 cc cc cc cc cc 55 48 89 e5 41 56 53
 RSP: 0018:ffffb532400c7dd8 EFLAGS: 00010206
 RAX: 0000000000000004 RBX: 0000000000000004 RCX: 0000000000000000
 RDX: ffffb532400c7cc0 RSI: 0000000000000300 RDI: 0000000000000000
 RBP: ffffb532400c7de8 R08: ffffa3ab042d28f0 R09: 0000000000000080
 R10: 0000000000000080 R11: 00000000000000c0 R12: ffffa3ab01dc6480
 R13: ffffa3ab120d12c0 R14: ffffa3ab120d12c0 R15: ffffa3ab12074000
 FS:  0000000000000000(0000) GS:ffffa3ae6f800000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 000000000000030c CR3: 000000010700e004 CR4: 0000000000772ef0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
 PKRU: 55555554
 Call Trace:
  <TASK>
  ? __die_body+0x6a/0xb0
  ? page_fault_oops+0x38e/0x400
  ? work_grab_pending+0x56/0x230
  ? exc_page_fault+0x5b/0xb0
  ? asm_exc_page_fault+0x22/0x30
  ? typec_partner_set_pd_revision+0x5/0x80 
  [typec bc1e7c7e089f4aaed440a0a5388387e3ef1ca2cb]
  ucsi_check_connector_capability+0x71/0xa0 \
  [typec_ucsi 843b0396f746abb17c01f8d4d12ead8b09b88609]
  ucsi_poll_worker+0x3c/0x110 
  [typec_ucsi 843b0396f746abb17c01f8d4d12ead8b09b88609]
  process_scheduled_works+0x20e/0x450
  worker_thread+0x2e0/0x390
  kthread+0xee/0x110
  ? __pfx_worker_thread+0x10/0x10
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x38/0x50
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1a/0x30
  </TASK>

Andrei Kuchynski (1):
  usb: typec: ucsi: Fix NULL pointer access

 drivers/usb/typec/ucsi/ucsi.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

-- 
2.48.1.711.g2feabab25a-goog


