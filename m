Return-Path: <linux-kernel+bounces-539960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B12A4AB55
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 14:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69BF21717E7
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 13:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AFC1DEFDC;
	Sat,  1 Mar 2025 13:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ixfCo152"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598F92FC23
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 13:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740836813; cv=none; b=tQ6bJ9SMgJwr4I7uksQtPWbGsBp/esjd8IWw8Ho/qnUnrF6YQRXuMD7sfXJa3Jip/UQkoXchg9YiwZBvKAEf9FNVxyX5QBquj6qqS5sfdx7isVwM+WyZj2ycecsWSU3QKJp4jS310e2PnsydQTzhT+ZoBQZa8F/LznNMjoR3yzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740836813; c=relaxed/simple;
	bh=AVBWkyZ3LMxgKkSczZAawyXgVQNArhDYT2iwv3Msc5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z745qdxG4u2QpsYksh58UPC5pB6ptT405YwJSUb0XgNTHDtjPUgdWoX82JuYXui3OBEcIRmgZicmf9x/hJjMO0hgNu95YzMWxTxN2aEkVmRdpa8kQWw9LRayOX+IXrVsS4DjV3QYRg0KFn96bqB4I+tOjDgBNM787k9z6VEZeak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ixfCo152; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740836810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DQGzwDx59Gq1VVsGiIVi022MkT/gIDUdTTMFq5L87I4=;
	b=ixfCo152L7s4GbNT+sF7l8cC4HZqf9c1241gOdmyGfn+d5e2MLgKa3P9m632Do7PNwsMjI
	6TQbS11vZbNFRlSIp2zmPI3uG0qTUdjLOvRyVkmwPQfZlPPlTVitxK7YWtT+E5hE7ykDm+
	nDnZvcWA0wicAJ6AICVXJbmwGFxts9s=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-TIaTt3fwP4i4agqURAwcHQ-1; Sat,
 01 Mar 2025 08:46:47 -0500
X-MC-Unique: TIaTt3fwP4i4agqURAwcHQ-1
X-Mimecast-MFC-AGG-ID: TIaTt3fwP4i4agqURAwcHQ_1740836806
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 708671944D69;
	Sat,  1 Mar 2025 13:46:45 +0000 (UTC)
Received: from fedora (unknown [10.72.120.3])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BC48818009AE;
	Sat,  1 Mar 2025 13:46:40 +0000 (UTC)
Date: Sat, 1 Mar 2025 21:46:35 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Mike Christie <michael.christie@oracle.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ublk: enforce ublks_max only for unprivileged devices
Message-ID: <Z8MPux2zzjcr7ipo@fedora>
References: <20250228-ublks_max-v1-1-04b7379190c0@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228-ublks_max-v1-1-04b7379190c0@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Fri, Feb 28, 2025 at 09:31:48PM -0700, Uday Shankar wrote:
> Commit 403ebc877832 ("ublk_drv: add module parameter of ublks_max for
> limiting max allowed ublk dev"), claimed ublks_max was added to prevent
> a DoS situation with an untrusted user creating too many ublk devices.
> If that's the case, ublks_max should only restrict the number of
> unprivileged ublk devices in the system. Enforce the limit only for
> unprivileged ublk devices, and rename variables accordingly. Leave the
> external-facing parameter name unchanged, since changing it may break
> systems which use it (but still update its documentation to reflect its
> new meaning).
> 
> As a result of this change, in a system where there are only normal
> (non-unprivileged) devices, the maximum number of such devices is
> increased to 1 << MINORBITS, or 1048576. That ought to be enough for
> anyone, right?
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>

Looks fine,

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming


