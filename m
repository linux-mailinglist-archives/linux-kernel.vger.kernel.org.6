Return-Path: <linux-kernel+bounces-352130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C46D1991A9C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 22:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E223B2187B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 20:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65550158DCC;
	Sat,  5 Oct 2024 20:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gqhzIVTp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D98132122
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 20:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728159568; cv=none; b=dY/PWpX7gnbk15SR4OpxWWOrBOeK50YLtZMP48HqjUNWMF1QcvH1w9DIeEYPRSEiVRAEv29LZgKeomorL/3f1sJ0VDQCx8hIG58C+TUcacttEA/mnrMH6fLmZTyXnFg9IMzD3HJNHMeNZJ7FQWvCYuXfT+DEicV1QqtAhQj2yF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728159568; c=relaxed/simple;
	bh=t0NDO9VgiNPZ24RdkXQ8lWvfSvJhLvVvsvgtuUVQfmI=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=e6PTWZ8WbY/cMKY3lkkGMlmttJrBlp2wDffBbVqYOAASmAxnb9h+icIpcjgV+iGWx2QUHTpZ2Yg3up8bPf5oNb0ILfpQ+fQCOZ6qaGdd5e+E/8/0QJRgKOrl5l9RHhyi8KUr/mBAgEMaF5xklXq0oQSjyarOPM/Zg81yboSaUmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gqhzIVTp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728159566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wVzDdN5Z7OcoeNqeUSnflKTOF7ZiYV9hEqk8inqht1Q=;
	b=gqhzIVTpAHiWD6UBQ1YcfjVcHOQj3Aa+vqdYRiwPv4nCKp86DFtImxSwCZ0QhILDZEVxaZ
	LLdQkWVBgo5E86TD673m0Hlw6LUkNalB+kCeIUX7vhFXAVC5hzR2LI2deHlZHAPLomid+A
	HWcBljIXeNVYDPTD4sKmRIZMHDZugtU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-262-NDcjYh1vO8mWhfdSGL7PFA-1; Sat,
 05 Oct 2024 16:19:23 -0400
X-MC-Unique: NDcjYh1vO8mWhfdSGL7PFA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 550C4197904D;
	Sat,  5 Oct 2024 20:19:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.145])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AE1A41955F30;
	Sat,  5 Oct 2024 20:19:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20241004103051.43862-1-advaitdhamorikar@gmail.com>
References: <20241004103051.43862-1-advaitdhamorikar@gmail.com>
To: Advait Dhamorikar <advaitdhamorikar@gmail.com>
Cc: dhowells@redhat.com, Steve French <sfrench@samba.org>,
    Paulo Alcantara <pc@manguebit.com>,
    Ronnie Sahlberg <ronniesahlberg@gmail.com>,
    Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
    Bharath SM <bharathsm@microsoft.com>,
    Enzo Matsumiya <ematsumiya@suse.de>, linux-cifs@vger.kernel.org,
    samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
    skhan@linuxfoundation.org, anupnewsmail@gmail.com
Subject: Re: [PATCH] Fix logically dead code
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3912622.1728159551.1@warthog.procyon.org.uk>
Date: Sat, 05 Oct 2024 21:19:11 +0100
Message-ID: <3912623.1728159551@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Can you tag your subject with some sort of subsystem ID so that we know what
it affects?  Something like "cifs:" or "smb:" in this case.

Thanks,
David


