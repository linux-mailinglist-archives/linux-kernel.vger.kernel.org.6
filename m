Return-Path: <linux-kernel+bounces-574090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95293A6E079
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 18:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2EF316DA22
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A317263F49;
	Mon, 24 Mar 2025 17:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T9ptDgiy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C4525FA3A
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 17:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742835834; cv=none; b=jGk2IPBIVPX/XQm5sHJbEDu+LAQGdOiLtiNMyySXqqZrkjbHv1hVkyBXxtr4/Q1TLB3bIR18gcWwo5F4R0OlLrPLvY4aIu9W8ct0TdRAzjUwyPemvherc6oXKrCLilkbh1y4FeO5HwU0i71lu826ism3bdtiQDvPpwxqY/wHNRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742835834; c=relaxed/simple;
	bh=Fhymql5LrqYvf7WCwoI6ll3vFidOMHuqPT4bj9qwPS4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fpgeoFLRd3k4h9ldPf3w3Ha22KlYVRmzVT6Vsc9OdL/4gsNb1dIJTjVmIWCRAAb6AxVGMGJmuG7ads82qIJZ9jAgvQ89YTId0S/sBy9yozXO5h+InafG8sDXxyjyy8uuSF6zjmRrGWq0QNTjcn2J/6nzYTD4P0/bagQRhji9icY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T9ptDgiy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742835831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=WJBEzIEgkwg9EgWyF2dr13gaP+P0+1At/o/fBqLpVSg=;
	b=T9ptDgiy4T5deCHh6jO810dM1+k3MqdEMttegUBIthMyfcxj32wrG9RUZnJIZDJz/WcUgZ
	klOEH3e8kLy1CxOLsEfrTmYP/ckZTGHuOM17nydNa+swdq/CXTugnSxTob4EluU5X2u2zm
	j+xfZvDQrk6r3kI/LT/wKfvPD6eOVc0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-BNKKAnTsMQCZ9nQMlKRSCw-1; Mon,
 24 Mar 2025 13:03:48 -0400
X-MC-Unique: BNKKAnTsMQCZ9nQMlKRSCw-1
X-Mimecast-MFC-AGG-ID: BNKKAnTsMQCZ9nQMlKRSCw_1742835827
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9AEE71809CA6;
	Mon, 24 Mar 2025 17:03:46 +0000 (UTC)
Received: from redhat.com (unknown [10.22.66.35])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AD5EE1801750;
	Mon, 24 Mar 2025 17:03:45 +0000 (UTC)
Date: Mon, 24 Mar 2025 12:03:43 -0500
From: David Teigland <teigland@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, gfs2@lists.linux.dev
Subject: [GIT PULL] dlm updates for 6.15
Message-ID: <Z-GQbyqwct3BVdiH@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hi Linus,

Please pull dlm updates from tag:

git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.15

This set includes:
- two fixes to the recent rcu lookup optimizations
- a change allowing TCP to be configured with the first of
  multiple IP address

Thanks,
Dave


Alexander Aring (2):
      dlm: fix error if inactive rsb is not hashed
      dlm: fix error if active rsb is not hashed

Heming Zhao (2):
      dlm: increase max number of links for corosync3/knet
      dlm: make tcp still work in multi-link env

Thadeu Lima de Souza Cascardo (1):
      dlm: prevent NPD when writing a positive value to event_done


 fs/dlm/config.h    | 2 +-
 fs/dlm/lock.c      | 2 ++
 fs/dlm/lockspace.c | 2 +-
 fs/dlm/lowcomms.c  | 4 ++--
 4 files changed, 6 insertions(+), 4 deletions(-)


