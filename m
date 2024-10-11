Return-Path: <linux-kernel+bounces-361116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B3D99A3B3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 14:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB8132810ED
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E4F213EEB;
	Fri, 11 Oct 2024 12:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N8/I6eo+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188811494D4
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 12:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728649043; cv=none; b=RO5sJUROdvjqOdBjtOwbfwcS348BXgAVfgILWk+8Kzu4ntnAijiCy+zeJA4EGcQLVzfwnLNKWvsG1wVvvWC+qy9XC9fT41NtgWp857ud4+vtOem7s18p5tXro+k3wBj4Tdf99lrqYP9FqK0TfGhqfIANkcEhrsbuZbRDCAhcwsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728649043; c=relaxed/simple;
	bh=xUgb4R5FICKpCQdMDBd10yi6Lqwa1iDP8UCTVv+3HFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J9oQgCaJrSmF7pzonGFAkmyW5S+X7EtlkXLjkqjjonVix5/DQIhxlJLlyiLQd/haMD7cs+xeeIBeKjIWEe6F139kBB3msi0YSJrzmSU/jLS9DwYWYhYDOFquT930qPwOJpM9pbVF2TrU5ubJroLjDL2tWUuhJzIztyd1+8fLLQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N8/I6eo+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728649041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NfRk+zZ1X+PHF3tfT7ep00eGftErXB3cJqE2i/veZMM=;
	b=N8/I6eo+P2fHsiAvOypgrudoQQlZMIP25pxIKepUpt+uaO4NvY2bFCBxai6ao9OvxaDUTb
	dPonFkwQuptXxiFbP+UCUKJqFNKPt5HtZ5U6UzORmE//basUC+6hy5/nCcBqOq216vIjK1
	LQrf1Ptg1xtNfq27DNkU4LBeCIr4wsM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-176-jEs7gmNTMMSDn8Vhnicqcg-1; Fri,
 11 Oct 2024 08:17:17 -0400
X-MC-Unique: jEs7gmNTMMSDn8Vhnicqcg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 410931954AE1;
	Fri, 11 Oct 2024 12:17:16 +0000 (UTC)
Received: from fedora (unknown [10.72.116.16])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 662EA1956052;
	Fri, 11 Oct 2024 12:17:09 +0000 (UTC)
Date: Fri, 11 Oct 2024 20:17:04 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH V2] lib/iov_iter.c: extract virt-contiguous pages in
 iov_iter_extract_bvec_pages
Message-ID: <ZwkXQBywT9mkvi-l@fedora>
References: <20241011035247.2444033-1-ming.lei@redhat.com>
 <ZwjlXoSu6zA5Xcy7@infradead.org>
 <ZwkUJaXM8XLgl8in@fedora>
 <ZwkVRW25x6MSaBmk@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwkVRW25x6MSaBmk@infradead.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Fri, Oct 11, 2024 at 05:08:37AM -0700, Christoph Hellwig wrote:
> On Fri, Oct 11, 2024 at 08:03:49PM +0800, Ming Lei wrote:
> > Looks open-code iterator is more readable, the patch looks fine, and
> > I have verified it works as expected.
> 
> Do you want me to resend this formally or pick it up from here?
> (either way you should be credited as my take was just a trivial
> cleanup)

Yeah, please re-send the patch formally.


Thanks,
Ming


