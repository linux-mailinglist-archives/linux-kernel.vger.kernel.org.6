Return-Path: <linux-kernel+bounces-565410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CACA667A4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 04:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C1E719A55FF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 03:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435FA1DE4F8;
	Tue, 18 Mar 2025 03:42:18 +0000 (UTC)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FD01D90B9
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 03:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742269337; cv=none; b=YcKFZ6GBKl4s0keXBL8t/ZCKmKb6AOP4+PW2qQS8ihKOPNTCEgRfKabQycRylACPBYg6diEY/7LlxyYoFhmyoslOrY/OUhBrgxGcemP+5HsZezhUnkFia/k5zCNQyeahePAuqJ1VxErElkoynpF3Cm9l0zFckUooElG1NI2xX2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742269337; c=relaxed/simple;
	bh=yy357oTBrx7rBB5s67K7o4s7AIZ375/lMXuhAXP/BYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W+WC7pH8DQ/f0h4nH5axM6HkqnPuC4zF2IcwIA/JJB5NYfM6PlMcINyVlyx3q3/ro2m5Iee/vxTgc2Sz3aftC7vjm5USoluozBc/pOtu72yLykQKncTfQmJd+D4gU/vk7yxCgUQYjJai8+AnFn6JkqC071BtUb52ZwcA5qJId/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-34.bstnma.fios.verizon.net [173.48.111.34])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52I3fjhF012113
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 23:41:48 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id C906B2E010B; Mon, 17 Mar 2025 23:41:45 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Bhupesh <bhupesh@igalia.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, kernel-dev@igalia.com,
        linux-kernel@vger.kernel.org, revest@google.com,
        adilger.kernel@dilger.ca, cascardo@igalia.com
Subject: Re: [PATCH v2 0/2] fs/ext4/xattr: Fix issues seen while deleting xattr inode(s)
Date: Mon, 17 Mar 2025 23:41:13 -0400
Message-ID: <174226639134.1025346.10423819005675734722.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250128082751.124948-1-bhupesh@igalia.com>
References: <20250128082751.124948-1-bhupesh@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 28 Jan 2025 13:57:49 +0530, Bhupesh wrote:
> Changes since v1:
> ----------------
> - v1 can be seen here: https://lore.kernel.org/lkml/1dddb237-1460-8122-7caf-f0acd7c91b5c@igalia.com/T/
> - As suggested by Cascardo while reviewing v1, there are two
>   patches in v2:
>   [PATCH 1/2] Ignores xattr entries past the end entry.
>   [PATCH 2/2] Hold 'EXT4_I(inode)->xattr_sem' semaphore while deleting the inode.
> 
> [...]

Applied, thanks!

[1/2] fs/ext4/xattr: Ignore xattrs past end
      commit: c8e008b60492cf6fd31ef127aea6d02fd3d314cd
[2/2] fs/ext4/xattr: Check for 'xattr_sem' inside 'ext4_xattr_delete_inode'
      (dropped because it breaks ext4/026)

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

