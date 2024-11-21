Return-Path: <linux-kernel+bounces-417197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 356E89D5056
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 17:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE6A8283014
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 16:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1058157476;
	Thu, 21 Nov 2024 16:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RTYmVzA3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE18487A7
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 16:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732205012; cv=none; b=sgdDMaZ/TVKtUddQCqtL+1LPszKndHuKfltUnazlk7OcSbPJ6KWkdYmuhOJ12iTji3Hz2OLL8CSWY9ZABtxaY780GAvDZkx2NwoXjpoHU9fbSNvlt5wZGLaKGXTRQ9rUH9GvZT30cY3TlCDA/i8TFq8kv9zCHqAiv4aWWy1UpOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732205012; c=relaxed/simple;
	bh=C8vJ8qggLtWzD+4pWCb0BepOavKWkMVHadcpxi6E8SI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XRiYdKTwM5h9TPRXQEHoGVSdgy+IPqXVa26cW96T3A2qlI9lMbMgleL443W7CtNsSNBZmsKiIa1wdIvOa2XSUeZOaLhTpm6XPlCSLpMf2FUstG/jsyB/DQZakIG5YmOQqO2pEjmeOAZQOSaX8rELk2EBUTjTQmbKGmBeSbrWA/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RTYmVzA3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732205009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=ikxJGaHMDVtELpb2AD5zG6Lr+OC44aX1EesfMQD2K0E=;
	b=RTYmVzA37rrZg29XM2MEETlJdhVHFHdYUBBP+zG4hkCEFv1doz/1lViXbI1/Pike4MaPBN
	ENK17ivdbmN0pjfat4WmZaxUWrDcMLikRwmOwjinzKDAM2P26SJWVns00hgMqj2m0uLYKv
	XRnLMUPMry1YW1+tvZUSaQSQWQG4kLk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-CTo-EI5dNBW7-cdnyn7IfA-1; Thu,
 21 Nov 2024 11:03:27 -0500
X-MC-Unique: CTo-EI5dNBW7-cdnyn7IfA-1
X-Mimecast-MFC-AGG-ID: CTo-EI5dNBW7-cdnyn7IfA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7FF8A195395F;
	Thu, 21 Nov 2024 16:03:26 +0000 (UTC)
Received: from redhat.com (unknown [10.22.82.7])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 960E51956056;
	Thu, 21 Nov 2024 16:03:25 +0000 (UTC)
Date: Thu, 21 Nov 2024 10:03:22 -0600
From: David Teigland <teigland@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, gfs2@lists.linux.dev
Subject: [GIT PULL] dlm updates for 6.13
Message-ID: <Zz9Zyoho_wbCImkJ@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi Linus,

Please pull dlm updates from tag:

git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.13

Summary:

- Fix recovery of locks that are being converted between PR/CW modes.
- Fix cleanup of rsb list if recovery is interrupted during recover_members.
- Fix null dereference in debug code if dlm api is called improperly.
- Fix wrong args passed to trace function.
- Move error checks out of add_to_waiters so the function can't fail.
- Clean up some code for configfs.

Thanks,
Dave


Alexander Aring (9):
      dlm: fix swapped args sb_flags vs sb_status
      dlm: fix possible lkb_resource null dereference
      dlm: disallow different configs nodeid storages
      dlm: handle port as __be16 network byte order
      dlm: use dlm_config as only cluster configuration
      dlm: dlm_config_info config fields to unsigned int
      dlm: make add_to_waiters() that it can't fail
      dlm: fix recovery of middle conversions
      dlm: fix dlm_recover_members refcount on error


 fs/dlm/ast.c      |   2 +-
 fs/dlm/config.c   | 170 +++++++++++++++++++++++++++++-------------------------
 fs/dlm/config.h   |  26 ++++-----
 fs/dlm/lock.c     |  73 ++++++++++-------------
 fs/dlm/lowcomms.c |   8 +--
 fs/dlm/member.c   |   2 +-
 fs/dlm/recover.c  |  35 ++++++-----
 fs/dlm/recoverd.c |   2 +-
 8 files changed, 165 insertions(+), 153 deletions(-)


