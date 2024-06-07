Return-Path: <linux-kernel+bounces-205788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D1E900047
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 852D828DC5A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34FB1411E4;
	Fri,  7 Jun 2024 10:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KRGZPq5A"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE28157A76
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 10:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717754798; cv=none; b=NG4uPKKp181/mCrxPss4UTCOxxH8jj/vGhUtgmmh+T+nZURuiFwlu3WIrgewn3677jnTHF8ftB1rvzMGKdclPyT+MlaDmSvoJ9J+9enaQL84wvb5tHNLzAyrlV8w6oC6HmoO0oW3X0ouSqzQHprTVUHcefBpnRox7hqtxMnvhfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717754798; c=relaxed/simple;
	bh=yfXT27/V8eVslu1sjaWJNY2m3Cho9rYaMlS4D6NlPsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c2+pJ17gobFs8btwJWWxHs5t7DLhvd46GU8WKYgW02ThRfiBkv0uRzfqJY+y3pb/29Ds+l+Y2TaXgOdy3BDvy/YnROGdIfBN3adv7hytGU3gXFjd/Q2jVYRI6QGVrkJkRwgelzaxZMKqbiHz1A9qVvSL0EOhNXgBiG+1rK3MFEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KRGZPq5A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717754795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yfXT27/V8eVslu1sjaWJNY2m3Cho9rYaMlS4D6NlPsY=;
	b=KRGZPq5A869TYCTgSyUFtn/i5JqyR/J2XA2tuvVs0FAwH6nbfd1AGxA5Evz01hy8omeOXW
	umBumk5m5hm0SAb8mdZ6sWheO9fsIeJ/g5qbQQZ8Z7ED8LAoSLemYJLDAYGAxgaQ15umhs
	EV+TikG2ZeVAg2fBywC3hHbcYznheMk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-4sTFOuXlMYqDBJj7T7zW-w-1; Fri,
 07 Jun 2024 06:06:31 -0400
X-MC-Unique: 4sTFOuXlMYqDBJj7T7zW-w-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CBBD21955DB5;
	Fri,  7 Jun 2024 10:06:29 +0000 (UTC)
Received: from localhost (unknown [10.72.113.124])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7725919560AB;
	Fri,  7 Jun 2024 10:06:23 +0000 (UTC)
Date: Fri, 7 Jun 2024 18:06:18 +0800
From: Baoquan He <bhe@redhat.com>
To: Coiby Xu <coxu@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>, Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH v4 0/7] Support kdump with LUKS encryption by reusing
 LUKS volume keys
Message-ID: <ZmLbmriQYol2JHKe@MiWiFi-R3L-srv>
References: <20240523050451.788754-1-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523050451.788754-1-coxu@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi Coiby,

On 05/23/24 at 01:04pm, Coiby Xu wrote:
> LUKS is the standard for Linux disk encryption. Many users choose LUKS
> and in some use cases like Confidential VM it's mandated. With kdump
> enabled, when the 1st kernel crashes, the system could boot into the
> kdump/crash kernel and dump the memory image i.e. /proc/vmcore to a
> specified target. Currently, when dumping vmcore to a LUKS
> encrypted device, there are two problems,

I am done with this round of reviewing. The overall approach looks good
to me, while there are places to improve or fix. I have added comment on
all things I am concerned about, please check. Thanks for the effort.

By the way, do you get confirmation on the solution from encryption/keys
developer of redhat internally or upstream? With my understanding, it
looks good. It may need their confirmation or approval in some ways.

Thanks
Baoquan


