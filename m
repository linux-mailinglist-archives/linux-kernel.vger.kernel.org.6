Return-Path: <linux-kernel+bounces-573466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E74DA6D7BF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 10:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C3F816E08E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 09:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0571925DAE6;
	Mon, 24 Mar 2025 09:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bGCb9mZU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2D3170A13
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 09:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742809407; cv=none; b=pPhJP6n0J7K8riSzncSHmEPKCZ1SS4akBnfA+VH/Bypfj7rLHecPxKdvcKLckSf+lUGYaMcYa57Y97hp3bZtzlGIk1Ag8Sb3t+H1oeIIPihhd07/wlxO9Mv5rh3KHXlKlf3WLiMNQlBJDfBZfTWVrrbDPiJTIHjWp8GlSVTJlL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742809407; c=relaxed/simple;
	bh=sUwMoW1N+6j1u5OCROWXxbQhi2uVQ4/eh02wGNvr17I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wknuhebp0I012ygLkV3CmrBPBsnM5FUzusv2iuwKcXhZotXOh+BGeYfmY5qoq7Cj8wI5GHqoFt5e2wJvUxBa6RMS3bGa84CVsyBv2H4U7bykE11IbBFvg2442oFI14HIJ6f9ugeKTSEki+HBveLeDv9vwBO1xysc7iyDECAYncI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bGCb9mZU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742809404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sXgHgtcldaqEgL1B2MyW4inEnkIl1i2EB10yamCb83E=;
	b=bGCb9mZUCd1TMnFrd4VXfqT6Su1nIpduH+BOX0KLw6tIMf5gJepX9qu4mcLugWTGUj9lmp
	H+RSDx1LHVIu0CQcuuwwg7MeJSJr8J76S2KHl3XEgxyO0rhnMs282xm8AhyUCRN+Q2d98+
	uvdddUeopjPhiGIHvrVFfLH9mQpHSWA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-svbXV-eaMs6sb0RZzUgyDg-1; Mon,
 24 Mar 2025 05:43:19 -0400
X-MC-Unique: svbXV-eaMs6sb0RZzUgyDg-1
X-Mimecast-MFC-AGG-ID: svbXV-eaMs6sb0RZzUgyDg_1742809398
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 46732180025A;
	Mon, 24 Mar 2025 09:43:18 +0000 (UTC)
Received: from localhost (unknown [10.72.112.24])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5855F1801764;
	Mon, 24 Mar 2025 09:43:15 +0000 (UTC)
Date: Mon, 24 Mar 2025 17:43:11 +0800
From: Baoquan He <bhe@redhat.com>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: akpm@linux-foundation.org, kasong@tencent.com,
	tim.c.chen@linux.intel.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/8] Minor cleanups and improvements to swap freeing
 code
Message-ID: <Z+EpL2zXWP2HM+GX@MiWiFi-R3L-srv>
References: <20250320114829.25751-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320114829.25751-1-shikemeng@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 03/20/25 at 07:48pm, Kemeng Shi wrote:
> v2->v3:
> -Extent VM_BUG_ON instead of remove it
> -Keep bracket for more readability
> -Collect RVG from Tim for rest part
> 
> v1->v2:
> -Collect RVB from Tim
> -Drop patch to factor out __swap_entry_free()
> -Improve changelog and add more comment.
> -Avoid unneeded lock re-aquire
> 
> Hi All,
> This series contains some cleanups and improvements which are made
> during learning swapfile. Here is a summary of the changes:

Nice improvements about swapfile.c. Those kinds of swap_free_xxx
confused me, I planned to clean up them. Thanks for great work.

Reviewed-by: Baoquan He <bhe@redhat.com>


