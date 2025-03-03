Return-Path: <linux-kernel+bounces-542370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 369D9A4C90B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A6DF3A5166
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262C725D8FF;
	Mon,  3 Mar 2025 16:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z++2FkJ2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0373325D8FE
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741020787; cv=none; b=o5/oyo7NxTQX7cTkEKcy4vgYIVGmYA31CdUljydQHloDsxc3yO1wTpUcoqVCv7K4Y+Swx3ZvMbDmDpjfqnkWUmqHl9IDXZ5RsMC+m+cHkjVw30Pt+Ycni+TpX/QEYrZIUGw6LTBxCJJSelO7vIabXG+WqfPMB0EUHQCvKS0cCJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741020787; c=relaxed/simple;
	bh=0Z3jKPZTqkfGGv8vGqjyKdLv1jksJJM8yOmu5pzo7EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqWG51vM/7YkEB/s7Ue3y92bYb+aGMWtbmveUvq7juSgzG3Jgp/+EAlX9lX2wBleQf5ZFUHLv+x93ZAobOBe5SbKbXprjZSnaaiEP4gFCTHJT96JiwJSzDd9+bAlzmCaMx6/cTZ8bqaYz4RACzfwTeZ3udIty3YfbmkVbe79/bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z++2FkJ2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741020785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lqVj5C1JB+xLPX8Cc+LBmGK7OkMIN2JKNHM/ZrubAN0=;
	b=Z++2FkJ2Gsiv59OQyzqnja0bLS2HKfoD5B+qa0wzHV8PV9ZL5Rod+VniZV3peGbCKcq5/9
	2NqIMqO3umpsUZSq6/czZyXuNRKfi8rD9OBMPDBtrv3qt6ikcEiDXy1OpkXcu9EtQpoCRn
	ZtsuyUliA/S8fGhAjJTrwU1Ah173m7E=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-360-RrGXdx_OOWG6mmAQauOuRg-1; Mon,
 03 Mar 2025 11:53:01 -0500
X-MC-Unique: RrGXdx_OOWG6mmAQauOuRg-1
X-Mimecast-MFC-AGG-ID: RrGXdx_OOWG6mmAQauOuRg_1741020780
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8811C18EB2D3;
	Mon,  3 Mar 2025 16:53:00 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.32.16])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id C12691954B00;
	Mon,  3 Mar 2025 16:52:58 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  3 Mar 2025 17:52:30 +0100 (CET)
Date: Mon, 3 Mar 2025 17:52:27 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] signal: avoid clearing TIF_SIGPENDING in
 recalc_sigpending() if unset
Message-ID: <20250303165226.GB9870@redhat.com>
References: <20250303134908.423242-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303134908.423242-1-mjguzik@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 03/03, Mateusz Guzik wrote:
>
>  void recalc_sigpending(void)
>  {
> -	if (!recalc_sigpending_tsk(current) && !freezing(current))
> -		clear_thread_flag(TIF_SIGPENDING);
> -
> +	if (!recalc_sigpending_tsk(current) && !freezing(current)) {
> +		if (test_thread_flag(TIF_SIGPENDING))
> +			clear_thread_flag(TIF_SIGPENDING);
> +	}

Acked-by: Oleg Nesterov <oleg@redhat.com>


