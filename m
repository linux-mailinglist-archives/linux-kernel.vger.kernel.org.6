Return-Path: <linux-kernel+bounces-185176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF17B8CB197
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 17:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 816551F21519
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 15:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA8D1448DA;
	Tue, 21 May 2024 15:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KWU2y3RX"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143078C1A
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 15:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716306346; cv=none; b=mgJtTnbxMBo+MXQ3Edc98TftOt5FeEvRNfHHj+HvFNSdNZP1jRAWa17vGwX5542kZY2Jv7jQbc9ewuEtfGk3dLaqRZ+d/iSSqR0wBxgFTviOsjqE/57MpB9mPVaFjiU5JbOKdo1WXD4Kf3afGhoSwW2m4ovYQMONyc39CdhSL/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716306346; c=relaxed/simple;
	bh=JiQ17E0QBTkV+Se7Q96uFdgZdo8+hkE/n9fXzqqZ01o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=clYhTDpuD0AAceXNdGcxrC25bcUqaijWRmrBwnIqaeyWe5SQ5Zl5+mFRx8mEubgPfVgpr3tk6hOMcrbHAvsiXKEhL9xC/PWrLKFe4ru6vFa36+UJYM4JNIfcDGbaFS8gkBK+lcvLGR/QLc4qwrcU2t1haCKh0EWbr7q5wbx3510=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KWU2y3RX; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: tytso@mit.edu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716306342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fBSyg5xRMAlmaP9c4FGvfzgdGgjv2gN6Yl2qAEyO8/w=;
	b=KWU2y3RXle5w5DQrOGIUA55HkhlSzeJ+aT33D2WOjXE2K5EgYhXclGFG5zIsNn4cF9YM6P
	pu3AM5I8Y45KnyU89OmpTl4oE1UJenu49KnBfvtH9G/YTY04MtJxoP/MeDGcX3eMynAEpf
	B8kiWgxF2ok1fKiMxUR/aTD61mWvOro=
X-Envelope-To: jack@suse.com
X-Envelope-To: linux-ext4@vger.kernel.org
X-Envelope-To: luis.henriques@linux.dev
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: adilger@dilger.ca
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger@dilger.ca>,
	Jan Kara <jack@suse.com>
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Subject: [RFC PATCH 0/2] ext4: two small fast commit fixes
Date: Tue, 21 May 2024 16:45:33 +0100
Message-ID: <20240521154535.12911-1-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi!

I've spent some time investigating an fstest failure when running it using
'-O fast_commit'.  As a result, I'm sending two patches that hopefully fix
this failure.  The first patch is the actual bug fix for the generic/047
fstest.  The second patch was just something I saw through code inspection.

Note that this generic/047 test also requires the fix I sent before[1], for
a different fstest failure.

[1] https://lore.kernel.org/all/20240515082857.32730-1-luis.henriques@linux.dev

Luis Henriques (SUSE) (2):
  ext4: fix fast commit inode enqueueing during a full journal commit
  jbd2: reset fast commit offset only after fs cleanup is done

 fs/ext4/fast_commit.c | 19 +++++++++++++------
 fs/jbd2/commit.c      |  2 +-
 2 files changed, 14 insertions(+), 7 deletions(-)


