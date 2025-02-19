Return-Path: <linux-kernel+bounces-520773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE45FA3AF11
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 02:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B74543AD770
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 01:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C2982D91;
	Wed, 19 Feb 2025 01:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="D27AbScZ"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930CC33E1;
	Wed, 19 Feb 2025 01:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739929561; cv=none; b=ZfvgJZ4qoaPRB4t6ij6NJbJp+1Y2r5GGAZSCRhvb6EV75cYDXYnayKTHuczLtYWiZFa0yRXPYkmllR7WKjGIJrccxiZaV60IYbwweyxan3ZealAK3tkd6YcvgequK+lbCV/LEG+ZpN4KDR/LQ5xwiuXnOP/SNdagDStHtu7Eq00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739929561; c=relaxed/simple;
	bh=74xYjySCliVdpwpeHKHjLflozO6ng9l0aqrEbzOmci4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d5B8XUv+oaE3hkA7oRgZwwu5xXTit7LAo+5hhkGGL7EZN4LzKBlLlswTZvbL5k7JtqtCVPLz/NMXKJtZHTNzv97fw+9MXRwkSAW0chIE5QOY77gkN4n5Ky2ecbi5mjIYSnjSZgJ2qzEuWjOFVGN2t67vToF3hY5DwIuFrFdxL0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=D27AbScZ; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=eDVTCyQHw5Tqo13mf9mhPAmNsRvkJ0OX5ngfkpoZ894=; b=D27AbScZDeK3bFkr
	j9YNyuFQLt3dU7R3jEPGTJr8q7rMo+IUQv7erxK1qET+ILA3OFIIrRFmiKlb8zR5nKJc3A4tsfNPn
	E3+7barBYyLWO3AAQ+avw6gg3pbxfrzpsj2kwkeTsT7vGcmyOCnMfpgJkUXdax85JoxG3YVaVRNkD
	lBQ9Agx6wdmOGY0Kk93RuyEdanr+DQKq2vKYpQ/PmtUl68tnemZHirIZ0Kv17zzQwfpz7UN6nR/7F
	EstrJWGp54Njppjk4ILigY1vIE1lj4MMdO7h4n/8EMZrzvlIBMHTng3h/wNPQXZa9rpmfmOBD4TmN
	I2tpEX+xKzMya9SpqA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tkZ9x-00GmJC-03;
	Wed, 19 Feb 2025 01:45:57 +0000
From: linux@treblig.org
To: almaz.alexandrovich@paragon-software.com,
	ntfs3@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 0/3] fs/ntfs3: Deadcoding
Date: Wed, 19 Feb 2025 01:45:53 +0000
Message-ID: <20250219014556.293497-1-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

Hi,
  This is a small set of deadcode removal;
whole functions that haven't been called.

Note the last one in the set has a commented
out call which makes me a little suspicious what the intent
is.

Dave

Dr. David Alan Gilbert (3):
  fs/ntfs3: Remove unused ni_load_attr
  fs/ntfs3: Remove unused ntfs_sb_read
  fs/ntfs3: Remove unused ntfs_flush_inodes

 fs/ntfs3/frecord.c | 57 ----------------------------------------------
 fs/ntfs3/fsntfs.c  | 28 -----------------------
 fs/ntfs3/inode.c   | 40 --------------------------------
 fs/ntfs3/ntfs_fs.h |  6 -----
 4 files changed, 131 deletions(-)

-- 
2.48.1


