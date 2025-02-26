Return-Path: <linux-kernel+bounces-534679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DE5A469E4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D7CC7A44F6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A896023496B;
	Wed, 26 Feb 2025 18:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e99E2+IV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D232222CF
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740595012; cv=none; b=cqDCfMp/1Zf51ktjDpDHfCRYmrelNYvdYWzmGBzHVhqH2uKsUhmPAj/QITUo4xUQOKLGXGXH8ve3j4xrLY+NhK2z5VRs4TByqS8TcuNJfZo/e3yTTQgm6HFYCDQeXkVr/dHtW1ECsxUV100lV/StIGNMJSuzXuUbSlx030ug1A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740595012; c=relaxed/simple;
	bh=BGjV0w00ij161BMADAgPqDFOufDOmhKwjE1OwCm1P/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AS6oGW+XM7/oKFBzrp3rmz7SwBtRMBfA17byam69kLb3HbyBRxR7IAeLhFs0vYBoG8Mt0jTtdK+4pOL/ACurgxzl1HE7RSzOeWDOl12hXaowPcfaHEPPjzs+/gEuJxMwBJ0slsrfNmAPLmE+DZ7fDGL9pNvy13oWT9ExWN/g+1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e99E2+IV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740595009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BGjV0w00ij161BMADAgPqDFOufDOmhKwjE1OwCm1P/Y=;
	b=e99E2+IVScDRbLxyCR5/9wge/9ovU+IoQzbluH40BnO3zUiasEHRIBLsweCOSWQC1C5zt+
	jJP36TkvtR2myJDaycJTlhIdD0C1Ump66mc3PbCbkj+0P/bg1Y0x3vdarpAawH64o7F8mD
	QIlcqEJImAE6Uelk3ZsaTP3PiX68qWQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-vf9XWD1GMDCPO6yTI_5H6Q-1; Wed,
 26 Feb 2025 13:36:44 -0500
X-MC-Unique: vf9XWD1GMDCPO6yTI_5H6Q-1
X-Mimecast-MFC-AGG-ID: vf9XWD1GMDCPO6yTI_5H6Q_1740595002
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BCCCC18EB2CB;
	Wed, 26 Feb 2025 18:36:42 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.247])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D5F3619560AE;
	Wed, 26 Feb 2025 18:36:39 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 26 Feb 2025 19:36:12 +0100 (CET)
Date: Wed, 26 Feb 2025 19:36:08 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] task_work: Consume only item at a time while invoking
 the callbacks.
Message-ID: <20250226183608.GA21149@redhat.com>
References: <20250221170530.L3yMvO0i@linutronix.de>
 <20250223224014.GC23282@redhat.com>
 <Z73Tj3SAzNjaHwV3@localhost.localdomain>
 <20250225163549.GB29585@redhat.com>
 <Z75CKDw6uJZmNKYt@pavilion.home>
 <20250226131315.GD8995@redhat.com>
 <20250226140114.GE8995@redhat.com>
 <Z78oRqnN9-NZO_LJ@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z78oRqnN9-NZO_LJ@localhost.localdomain>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 02/26, Frederic Weisbecker wrote:
>
> Right it works but it does a parallel implementation of events refcounting.

Yes, yes, and this is the main reason why I think it is ugly.

> > But it is certainly more ugly, and perhaps the very idea is wrong. So I will
> > be happy if we go with your patch.
>
> Ok I'll prepare a changelog and see where it goes.

Great! thanks.

Oleg.


