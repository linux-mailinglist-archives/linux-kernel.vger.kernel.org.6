Return-Path: <linux-kernel+bounces-265573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F09B593F2F8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 12:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A24C02815FC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 10:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6C614430E;
	Mon, 29 Jul 2024 10:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dZdHUJPG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECE628399
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 10:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722249647; cv=none; b=iR54goowwFZaDCBfUu4zzvkTk4nHaHw5xHYmgJN89m9uU181YyVsgwuXUYOpVYC6BVwfkQIP+SeOrllwsGYzZ6nRzkNsBybsvu1QkbCd8hbmYnTkZc2cGaI21EKHFF4FtOrClFAalobhXd4m7whLzw2nfvyTJIeSYoU1qBWUpwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722249647; c=relaxed/simple;
	bh=6bfTWEmY7adZFRzBLuYfHsgyhzfx/9hvBN57Q13Jyn8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fdansH/gLiHAEj6Ywkuzh2k8VYexDHjO2lD8uKXglHWBzQqaKf8FBAHR/djMu1hAAjf+VjWOD08Uumn1Rs0ETdZPeoYY6is6YtyvUAK1BAYQ1SSf/h5zgD4WNaySOyzbFJTT/JT6+i+IkrdSVLvRazIGKrmfsJvsuc1O4d+1Pg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dZdHUJPG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722249643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dm2wu96gLk/Degb19SGPk73QQMk/RdMvun2wsoe8bRE=;
	b=dZdHUJPGltOROajz6o32mMH1MFrw6oR1ZrRwSr494ZPD8bVaOQPclJyWsrAAw4UJ4QoAMr
	9L5Wt3vKy7d5h2Qt6x9RdSLIhgE6m9QtTWqTh33d+gZ5LPRJmT/xbhZGT6a8H4cGPmqzZc
	xCNXmy1oCqIvDoyWnftrx61TRRR+PN8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-541-grURU8TnPH-VlooMwkPHSg-1; Mon,
 29 Jul 2024 06:40:41 -0400
X-MC-Unique: grURU8TnPH-VlooMwkPHSg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D6D431955D42;
	Mon, 29 Jul 2024 10:40:40 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.45.224.31])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9011F1955D42;
	Mon, 29 Jul 2024 10:40:38 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-api@vger.kernel.org,  Dave Chinner <dchinner@redhat.com>
Subject: Re: Testing if two open descriptors refer to the same inode
In-Reply-To: <ghqndyn4x7ujxvybbwet5vxiahus4zey6nkfsv6he3d4en6ehu@bq5s23lstzor>
	(Mateusz Guzik's message of "Mon, 29 Jul 2024 12:18:15 +0200")
References: <874j88sn4d.fsf@oldenburg.str.redhat.com>
	<ghqndyn4x7ujxvybbwet5vxiahus4zey6nkfsv6he3d4en6ehu@bq5s23lstzor>
Date: Mon, 29 Jul 2024 12:40:35 +0200
Message-ID: <875xsoqy58.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

* Mateusz Guzik:

> On Mon, Jul 29, 2024 at 08:55:46AM +0200, Florian Weimer wrote:
>> It was pointed out to me that inode numbers on Linux are no longer
>> expected to be unique per file system, even for local file systems.
>
> I don't know if I'm parsing this correctly.
>
> Are you claiming on-disk inode numbers are not guaranteed unique per
> filesystem? It sounds like utter breakage, with capital 'f'.

Yes, POSIX semantics and traditional Linux semantics for POSIX-like
local file systems are different.

> While the above is not what's needed here, I guess it sets a precedent
> for F_DUPINODE_QUERY (or whatever other name) to be added to handily
> compare inode pointers. It may be worthwhile regardless of the above.
> (or maybe kcmp could be extended?)

I looked at kcmp as well, but I think it's dependent on
checkpoint/restore.  File sameness checks are much more basic than that.

Thanks,
Florian


