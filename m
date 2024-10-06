Return-Path: <linux-kernel+bounces-352497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBD3992007
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 19:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E501D1F216C6
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 17:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E5B189B84;
	Sun,  6 Oct 2024 17:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HyTWUFas"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65059189BA4
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 17:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728236317; cv=none; b=abNYAg/uT9Zv1P4pMQcnJB4XulZ6/REnbOWj2Yuk120DTtkZtEn/8EuXXxxpQbTCrnMD2UojhX642j0WfkXigq0d1bf4/pppJB2Ej7Y0Hw4sROoUub4oBLG7nrfTPgh9uFfJ9MeJA32zQMQ/IcEm/jnCGObndAgxRSg0PD/45rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728236317; c=relaxed/simple;
	bh=RC5rSN5QumXmHPMdRMbBoRyWcYqwG9hkWX9yN7m291A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=If7TCmkfILgF2v3Lphwk2ppRmQm+H4tb7XBvdpbaOIWNQr99fU9aWg/jiHnlG1v6GSo6DBjIKpLM8NpY2DHj3Ow3NRGY5HRFZMc1ee5VBnmSd8aa8XX2wPbdFpd/ZBeEkIMGJS48uebj8RNeZO++HJ6EQ8o0C/RBOApDbwzEbX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HyTWUFas; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728236314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=geAJ4PX49d7ESasX6Dhzf9KG9odQRpsaqakuzJUUmwk=;
	b=HyTWUFasabsiCLD6955KOHsf7GJTSRUsxnQePDBJsU0TJcaONAMn1sYCX8aealOzmlZS8t
	FqcISOlOhUQoXJZs6MUMYBmlHQ33ZWdU93yUUu6TKo+9PFO7gy3omcezCHMhcsITD3RcIi
	hc26kusvLNQgztOK/EsVu31KUVSzzSU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-498-3LAzauMrOV-1-3ZbMz1VQg-1; Sun,
 06 Oct 2024 13:38:30 -0400
X-MC-Unique: 3LAzauMrOV-1-3ZbMz1VQg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A02D119560A5;
	Sun,  6 Oct 2024 17:38:29 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.57])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 167C419560A3;
	Sun,  6 Oct 2024 17:38:27 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  6 Oct 2024 19:38:15 +0200 (CEST)
Date: Sun, 6 Oct 2024 19:38:13 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: luca.boccassi@gmail.com
Cc: linux-kernel@vger.kernel.org, christian@brauner.io
Subject: Re: [PATCH v5] pidfd: add ioctl to retrieve pid info
Message-ID: <20241006173812.GB10213@redhat.com>
References: <20241006145727.291401-1-luca.boccassi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241006145727.291401-1-luca.boccassi@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 10/06, luca.boccassi@gmail.com wrote:
>
> +#ifdef CONFIG_CGROUPS
> +	if (request_mask & PIDFD_INFO_CGROUPID) {

Should we nack other bits in request_mask?

> +		struct cgroup *cgrp = task_css_check(task, pids_cgrp_id, 1)->cgroup;

Well, the last "1" argument just fools CONFIG_PROVE_RCU, right?

It seems you need rcu_read_lock() + task_cgroup(pids_cgrp_id)...

Oleg.


