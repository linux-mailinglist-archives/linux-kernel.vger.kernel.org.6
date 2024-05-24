Return-Path: <linux-kernel+bounces-188633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5B88CE4AC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 13:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6235828270A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 11:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF7885C76;
	Fri, 24 May 2024 11:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b="d1Rwt3xP"
Received: from smtp1.tecnico.ulisboa.pt (smtp1.tecnico.ulisboa.pt [193.136.128.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F8F538A;
	Fri, 24 May 2024 11:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.136.128.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716548888; cv=none; b=sQwhnXhdSKm8wdVLTUc6hbu9SL7BfJOkPiT4uTj2S3ptbxJljCDBxoNipDLDwznbg/fHegSnY9P4jSv/xWJL/qiJHGDViVsfOy/MDIEFAOkmAUJCpxNXgesmSo7APqZfm6Q9wmiORXr3cDvUNtYrJ5gXw/L6mpU2xSn7PQ6gK1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716548888; c=relaxed/simple;
	bh=aobGFHrNAmzx66DLpRMw5mDXkqBVPCqNhQg8h+R0sJI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gekz2MrsOCnMeoRYaYeEh/HEJJ8uRJKsSGmpxXDpPw5+Nj/MiV1MWPJnGL5b2Gxp/sfifzh/tDrqdkiTPbDAKzyoGzLhbsp3YNyizQWsji6O1Mlls4UDUFkKrpZqW+bf2GcRFVq5LgsUc6I8Kw8H1gGNoMfB3C15K8oBSxs53Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt; spf=pass smtp.mailfrom=tecnico.ulisboa.pt; dkim=pass (1024-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b=d1Rwt3xP; arc=none smtp.client-ip=193.136.128.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tecnico.ulisboa.pt
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTP id 5188B601A40B;
	Fri, 24 May 2024 11:59:54 +0100 (WEST)
X-Virus-Scanned: by amavis-2.13.0 (20230106) (Debian) at tecnico.ulisboa.pt
Received: from smtp1.tecnico.ulisboa.pt ([127.0.0.1])
 by localhost (smtp1.tecnico.ulisboa.pt [127.0.0.1]) (amavis, port 10025)
 with UTF8LMTP id rhYQrkTG_LQd; Fri, 24 May 2024 11:59:52 +0100 (WEST)
Received: from mail1.tecnico.ulisboa.pt (mail1.ist.utl.pt [IPv6:2001:690:2100:1::b3dd:b9ac])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTPS id C718F601A40A;
	Fri, 24 May 2024 11:59:51 +0100 (WEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tecnico.ulisboa.pt;
	s=mail; t=1716548392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=A5Em7Sh3O/lWid7jYeEGOI0eJ7PSTbvOF01x+rjq3wM=;
	b=d1Rwt3xPaUWzfNGHTmCqVxA3Z4y8yzr2kIgf5ngD4q6e7CW4SSIJUDydJp53pniKHGL6iU
	Y9mstG/e+qgGDpdAE5cdLGBa3ImHhfi8IVM9tGy2cHMjj5bfAJNSW800GrKiGao2axmn8+
	LsRTEqsQF/0hIpybqa36IDQub0cQVTI=
Received: from diogo-gram.. (unknown [136.226.215.14])
	(Authenticated sender: ist187313)
	by mail1.tecnico.ulisboa.pt (Postfix) with ESMTPSA id 5D1553600C8;
	Fri, 24 May 2024 11:59:49 +0100 (WEST)
From: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
To: heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org,
	dmitry.baryshkov@linaro.org,
	jthies@google.com,
	bleung@chromium.org,
	abhishekpandit@chromium.org,
	saranya.gopal@intel.com,
	lk@c--e.de,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pmalani@chromium.org
Cc: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
Subject: [PATCH 0/2] usb: typec: ucsi: Update optional notifications for UCSI v2.0
Date: Fri, 24 May 2024 11:58:19 +0100
Message-ID: <20240524105837.15342-1-diogo.ivo@tecnico.ulisboa.pt>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

These two patches enable checking and enabling the new optional
notification types defined in UCSI v2.0 and greater. For that, patch 1
defines the new optional capability bits and patch 2 adds the logic for
checking/enabling these new notification types.

Diogo Ivo (2):
  usb: typec: ucsi: Add new capability bits
  usb: typec: ucsi: Enable UCSI v2.0 notifications

 drivers/usb/typec/ucsi/ucsi.c | 19 ++++++++++++++++++-
 drivers/usb/typec/ucsi/ucsi.h |  8 +++++++-
 2 files changed, 25 insertions(+), 2 deletions(-)

-- 
2.45.1


