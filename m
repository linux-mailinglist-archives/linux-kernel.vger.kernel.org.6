Return-Path: <linux-kernel+bounces-274904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1615947E12
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E24DC1C21F93
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9B21494DA;
	Mon,  5 Aug 2024 15:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XeS4Fbxh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C297613AD29
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 15:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722871661; cv=none; b=fsNiU5974tGcK8B6Tj77zBiL04IH/w6CNybfehFbplTQPc4o7/8tXs4CBANSqJOaF5sKHXYPjccYEzsKV0D7tFkLl1bJNoz8Y2BaGfQ149jxcqw8bPYu3qWpHvo2EgfF5a0JSsW3iY1/B5lbULKt0hH/62zTsMcd9n6MS55X97s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722871661; c=relaxed/simple;
	bh=hxRY3ugPzahtlJ8uky/sfXgV1yIeyy/QzuvDtaq8kEY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=HHwZ5OCdDcDf8kA32eqRhFBgKUq0+UwLRTmjzZnNrtjNaORIK25QfqZhWsDJAosxpbS40XpNcGigvfHFKuWYtanYXgdmdlpNT9Bqs+XzBvLSZS0dTn3asqqH8AKJtVA7iMTClbeLZrfzJPubG9ee7HDOb76q2MuYObuPMZimOgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XeS4Fbxh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722871658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=vNZpfi1ggYr8TiK+jucofPwRIqJVZNg4BEDMG6gzA30=;
	b=XeS4Fbxh6Qd3tC3lGbMSZFmS8HV8ynI95EcuwmeLH/jBE1nmqDMv6A1aUfqO/sX1gs1QYf
	ft6XIf7q0G95yc21xOiSfaGHHOl+PFavr4oKO/1do52fRLKP3Nw8C2EjimhnzJ47ruQWZ/
	kEQSdalAIyypu/LwIOBZA98UdZBAU5w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-502-m1vkRD4HNpO_A6RebKAxUA-1; Mon,
 05 Aug 2024 11:27:36 -0400
X-MC-Unique: m1vkRD4HNpO_A6RebKAxUA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9B3A01955BEF;
	Mon,  5 Aug 2024 15:27:35 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1258919560AA;
	Mon,  5 Aug 2024 15:27:35 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id 04C4D30F3625; Mon,  5 Aug 2024 15:27:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 020FE45586;
	Mon,  5 Aug 2024 17:27:34 +0200 (CEST)
Date: Mon, 5 Aug 2024 17:27:33 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
    dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
    Khazhismel Kumykov <khazhy@google.com>, 
    Zdenek Kabelac <zdenek.kabelac@gmail.com>
Subject: [PATCH 1/2] dm suspend: return -ERESTARTSYS instead of -EINTR
Message-ID: <ef2ae856-54dc-4428-a8e-47efedc52e1@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

This commit changes device mapper, so that it returns -ERESTARTSYS
instead of -EINTR when it is interrupted by a signal (so that the syscal
will restart the ioctl).

The manpage signal(7) says that the ioctl function should be restarted if
the signal was handled with SA_RESTART.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 drivers/md/dm.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/md/dm.c
===================================================================
--- linux-2.6.orig/drivers/md/dm.c	2024-07-30 14:06:55.000000000 +0200
+++ linux-2.6/drivers/md/dm.c	2024-07-31 18:10:21.000000000 +0200
@@ -2737,7 +2737,7 @@ static int dm_wait_for_bios_completion(s
 			break;
 
 		if (signal_pending_state(task_state, current)) {
-			r = -EINTR;
+			r = -ERESTARTSYS;
 			break;
 		}
 
@@ -2762,7 +2762,7 @@ static int dm_wait_for_completion(struct
 			break;
 
 		if (signal_pending_state(task_state, current)) {
-			r = -EINTR;
+			r = -ERESTARTSYS;
 			break;
 		}
 


