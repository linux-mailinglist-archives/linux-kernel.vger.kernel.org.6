Return-Path: <linux-kernel+bounces-557867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC26AA5DEDD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE61D189A60F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6734924E001;
	Wed, 12 Mar 2025 14:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b="Q5I2of1G"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59DE245039
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741789445; cv=none; b=qTugSy504fRu5mEqLJlDkqeg6X4Tk9geyUuKHdKYHdd7eDk/lbdjJTy5El37LFUSdiHqT+47MJdi6oZsEGw5wIb7V9xY6qBf22svAke8FRnjm7J/F5aTZexWGkZpirboruLtAiavWCgNcGpMSAtUsw2LoomLHAMlJShTujY+5CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741789445; c=relaxed/simple;
	bh=b5GNVKf0dUozoYT4vENKJWq/5eyWVDh3jS26Zidli60=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LtoyJ9Jx8aDVWQkiEtHZk/b1yfz+dxidxos6gWxck/l2Db0gcBS/n2nOiX5Y+hX40RdMqBqrQdv9R3g6nypxAkjaczRcyOGlUrcH5mobw8YJn7J/f0Z6Fnam93+WID4+GezZ/6wBeIBU1HoAbBQeRYYH0MtvNSxz84JcQV0dLWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b=Q5I2of1G; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22438c356c8so92926875ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 07:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa-ai.20230601.gappssmtp.com; s=20230601; t=1741789442; x=1742394242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=85OatdnhR8vOMPUDmzQa+fglJ8ydwkYnTnhnCnWHZkY=;
        b=Q5I2of1GLTvXARl7P6XKgGPccFo7U0WQf/BRsVRbU94b53/9EDrWi383hq0fGRcObe
         YFzfhLn6eNdm6/aLctOk71Vof5aDfoyR1DhS47By6o8Lo+n4YphdujNWyA2i1Q0YxxQc
         zgz/KjB7EjNFpIEY4p6QGezHE08hTNRt1X5Hvj2q2SmOYST4HqpVC2u8ncq+ZqqwRDSc
         smNvIkQJ6ZQ55zVTv563pmidhDfaxrPWCs+i1rUx0+Ec+A4s82BYrsyuaOzlNVXA6Gg4
         RNwNuu88nLX2MmHOyIeuerjm4XJhuHJ68XzcKnZDxodrabTtSKtJuipji3xNXqwqyT1h
         W4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741789442; x=1742394242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=85OatdnhR8vOMPUDmzQa+fglJ8ydwkYnTnhnCnWHZkY=;
        b=wpqnfE3mV2bO9BCBXHf+sPCmvDW8hlIdx92j3XWAG4U7uuQMh6Bmj5tC7PGskeL0e9
         QszWHXyb39/zP9MGG0m9BoVQQQJvrcfkwwpFN0O4YNT1HOJPH+XQP6M/4xhKCXCIF0nO
         I6gzHjrX248I2AVI/NXuR0jlYTw2hvx0NP/uPI7pgTB7N/Wa8z6qwMOnio0fT+mfcJtU
         quI6+Hk+axMUNfiyTgDd+rfmQcc6f/oQRtHoOetR5JgaZcV/y8zlWojJX8UqGmFufMf3
         53G9rv804Lk562QwPz7w/kupMDPSUD3Y1BdG0jlRN+D9s14v0MFEO6CyXzWEYfdcEgdI
         ZFoA==
X-Forwarded-Encrypted: i=1; AJvYcCVWO51U6w86iZLFOxQ651BSGNwPeVMCU3aFl7fIgbgwCI8IIleb1wjttY38VUrUV8uCfNdyZ7DfcPVuklw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfV5qoTxl3p4F33vrijlV1dmN+zeqapCaFhgMM8A2Fmf/wvOuO
	AMHUj2SvXBUbCcWZRkbcOmb4ZV9CwWRxveZ/puXT7QX+uK853xdm+oF9C+N7Br4=
X-Gm-Gg: ASbGncvrCgQUI4MNFiS+T1bG9cKs06J/j7cPWVqe6rjAVhCGgkAPzm3PDIRlOwi2a4f
	Q+DdfXE0JVPmijFdxtrUD6qZqV9BumoTiOekdKPE3WAkfY7baEur1V5nzaehlq1PPi/aHmP8QNu
	piSnF1JvsBJhL3DXRt+xFWjs/+2u5pl4fUidFAyzzfRl3WHnu6mpKnFhhlWBMxh2BNlratFEtPE
	KlNB6GDaEKXdTB3krUwEPaXSYjlVKBoLpO7A9aPk3PQQmuYUQ1SR+qMZhOa8tPWhXLxo0dlJ9xS
	kOmh+Da6do6TneYhOTw69dVKC4y6AYuazi4dy7lUq2uZs8M0nuAOfiuIAVzW19L87lL/cWJS2wi
	E1mrl
X-Google-Smtp-Source: AGHT+IE5Kw99rmsO+aGISXKk7+NkabJNBq8xp8xHITBkdCvmzgnas/3E8b+v2s7QvMJWwmkI1EknQQ==
X-Received: by 2002:a05:6a00:928b:b0:730:75b1:7219 with SMTP id d2e1a72fcca58-736aaa22109mr32117339b3a.12.1741789442019;
        Wed, 12 Mar 2025 07:24:02 -0700 (PDT)
Received: from sidong.sidong.yang.office.furiosa.vpn ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736cc972eabsm7413860b3a.144.2025.03.12.07.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 07:24:01 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org,
	Sidong Yang <sidong.yang@furiosa.ai>
Subject: [RFC PATCH v2 0/2] introduce io_uring_cmd_import_fixed_vec
Date: Wed, 12 Mar 2025 14:23:24 +0000
Message-ID: <20250312142326.11660-1-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patche series introduce io_uring_cmd_import_vec. With this function,
Multiple fixed buffer could be used in uring cmd. It's vectored version
for io_uring_cmd_import_fixed(). Also this patch series includes a usage
for new api for encoded read in btrfs by using uring cmd.

Sorry for mis-sending noisy mails.

v2:
 - don't export iou_vc, use bvec for btrfs
 - use io_is_compat for checking compat
 - reduce allocation/free for import fixed vec
 
Sidong Yang (2):
  io_uring: cmd: introduce io_uring_cmd_import_fixed_vec
  btrfs: ioctl: use registered buffer for IORING_URING_CMD_FIXED

 fs/btrfs/ioctl.c             | 27 ++++++++++++++++++++++-----
 include/linux/io_uring/cmd.h | 14 ++++++++++++++
 io_uring/uring_cmd.c         | 31 +++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+), 5 deletions(-)

--
2.43.0


