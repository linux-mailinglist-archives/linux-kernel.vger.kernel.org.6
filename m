Return-Path: <linux-kernel+bounces-445836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7D09F1C12
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 03:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E0B3188E94B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 02:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA93F15E96;
	Sat, 14 Dec 2024 02:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V73S8Yj2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238101C36
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 02:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734143082; cv=none; b=mZV43LQZfXofgI+OnRU97wHsSrLxiDM9Wwm/IfGIFoVIdBUOpieZnp4NNA+AxeUgv44RpdFdpz23WYLFQvU7iifeZNtKBNjR6IsUDea3x62RyShJXd9sb8JfISOSQ02mHjKS+eHbx0r8L1vtubuOOyxYdtN3wV3WfTFeDaaH2OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734143082; c=relaxed/simple;
	bh=et1D6dfeplOdZeFaPO6hotSgn8lyeqC70x+GC6HjPE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GU/i4hqX1+CuZBdxXXz072aHFBDtZCSlROiYw4LN6QOcxnNF/OJO5dw8ZqRy5OjLK8SxdjRmj9jCsJzqroXhiUt7jNmGoL/dNosBSwtf8Wb9EFlsGBoo1yWCzIghOVAwrxOCTd1Ob5jRnooqZQdRRI5/29zScFH+1nvcYxkwFEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V73S8Yj2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734143078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H1dpSCmmqK/j/7n07sNfCg5XminxI/aT3vgOaLdpOTw=;
	b=V73S8Yj2KVQmvwE20f9dhXB8FOmhpJkMKQlIOLj457q33g7iC1zZG/s7FywLIa7QnFmgPJ
	r7kdjkeH9tpXC0sIPud71wjkiFn8+I6W7sw5blipCdUSibsEYW6GnCibIQ/8z51QiFTAOx
	03QYVGjdrJOXXvldB+/D/GlMlDzCjsk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-217-8OlSKUhYPvy85pFRhSU7hg-1; Fri,
 13 Dec 2024 21:24:35 -0500
X-MC-Unique: 8OlSKUhYPvy85pFRhSU7hg-1
X-Mimecast-MFC-AGG-ID: 8OlSKUhYPvy85pFRhSU7hg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 46A7019560A2;
	Sat, 14 Dec 2024 02:24:33 +0000 (UTC)
Received: from localhost (unknown [10.72.112.69])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 40893195605A;
	Sat, 14 Dec 2024 02:24:30 +0000 (UTC)
Date: Sat, 14 Dec 2024 10:24:26 +0800
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
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6 0/7] Support kdump with LUKS encryption by reusing
 LUKS volume keys
Message-ID: <Z1zsWoRhVaqXkVbb@MiWiFi-R3L-srv>
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

Other than those small concerns, and the lkp reported issue, the overral
series looks good to me. Thanks for the effort.

Thanks
Baoquan


