Return-Path: <linux-kernel+bounces-394251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C689BAC70
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 07:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09BAE281FFF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 06:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B009185952;
	Mon,  4 Nov 2024 06:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YKlR3aGc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BBCE552
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 06:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730701082; cv=none; b=rD7AJzD1iOWVSdWVZMw0PoCT2UtXWl2AkZcK/WDj7sBgR4kn3eT158KCDX6BV90RrgHsn9KDG5Uj48A566tjAaxrlFSwwMFCrLDSYQk1nkExDR46nFkirYhc8mAqRvQGa44FtmTiOGw/wmk3CpE6yOv3ToOCZ/JYSqBbHWjfErE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730701082; c=relaxed/simple;
	bh=+p10IWtB1sSrA9yYFxJ5xn0FXS5OrAz3GX32mwmGlV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bzhOAqa+aBy/oqrKqpE227vXT6Ad8OgxFY7E8a3yvEgvzJTI8THL5JfoEcz8ARnsn+cDUHeb4QFfTNNZpxTrTGcB1/0PV+qX4o3Cf6AUC2zgsH92/aWAkbh1rTs5/Bo+ZCwrxV0AUwlrsWmMgl0HgzwttTyVdE0ojkj2X4+Vyuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YKlR3aGc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730701078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Do/2TiELOGIeqU3m4GK74cp6r6SIjB0QSr9SYGDc+Tc=;
	b=YKlR3aGc7hkVjYt/RGgYP4jqvaKMpwV4mp5SCaMo9/63RO07q9w0aoVi6RU0nNIo8LRBWn
	A3n22N6cJLrT60ogTFdZIvnbZD9lTX0bUJetXgvE11cMIq5RbNbYyvDWfYwaM27UcYf5PE
	oh0L9YBjVZgjCm2IQfX/F8Wenk/XXWc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-533-2cIPdUKtPMy9hOiHaNGHWw-1; Mon,
 04 Nov 2024 01:17:57 -0500
X-MC-Unique: 2cIPdUKtPMy9hOiHaNGHWw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7F5A11955EE9;
	Mon,  4 Nov 2024 06:17:55 +0000 (UTC)
Received: from localhost (unknown [10.72.112.78])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BF30719560AD;
	Mon,  4 Nov 2024 06:17:52 +0000 (UTC)
Date: Mon, 4 Nov 2024 14:17:48 +0800
From: Baoquan He <bhe@redhat.com>
To: Coiby Xu <coxu@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>,
	akpm@linux-foundation.org, Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>, Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6 0/7] Support kdump with LUKS encryption by reusing
 LUKS volume keys
Message-ID: <ZyhnDBmhvsG2TZ5V@MiWiFi-R3L-srv>
References: <20241029055223.210039-1-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029055223.210039-1-coxu@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hi Coiby,

On 10/29/24 at 01:52pm, Coiby Xu wrote:
> LUKS is the standard for Linux disk encryption, widely adopted by users,
> and in some cases, such as Confidential VMs, it is a requirement. With 
> kdump enabled, when the first kernel crashes, the system can boot into
> the kdump/crash kernel to dump the memory image (i.e., /proc/vmcore) 
> to a specified target. However, there are two challenges when dumping
> vmcore to a LUKS-encrypted device:

I am doing RHEL code rebasing to upstream kernel, will review this next
week.

Thanks
Baoquan


