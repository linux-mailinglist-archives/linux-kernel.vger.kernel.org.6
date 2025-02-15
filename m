Return-Path: <linux-kernel+bounces-516136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA94A36D49
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 11:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34BAB18965CF
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 10:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB481A2642;
	Sat, 15 Feb 2025 10:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EoEQR0li"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7750D155CB3
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 10:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739615301; cv=none; b=M6RuJqULXh/3aK/obkw74Wbz0S6tmCkCTwh+cY5hyPz8Cl03VJgspPPnhbCPxpLi5erBGSl54HTvwo1NXDCuCbdfu6rcMrxFy8i6LzVfVcR4sULbaGuv0UKNmyEDzGoGHQL3T0R5TAIaNrGov9BU5cTpXASj6XCnuP6F853BqbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739615301; c=relaxed/simple;
	bh=XtvbIPzvQqKYFe1wb9GBAWD+DWkkj6O9gaCnsRC7z1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2gCF0jkGCukwjq9VnGnYV0oB7DL7CoMChSXlKuXlGn2/PJ6KAN4UGoVIM2e5Ifs1Ka8jM8iW8hEy/TSnPfuYIctEr1c85i9SufTlhuA/SorU8/twLk/swWsPhSEXtnxtw2/E8CWvO9u2mOiXs7ldkE6xIVkjpINRAq6p/2LCLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EoEQR0li; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739615298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rQqwkeCetsLzXFYxcLLmFF2wPRgBA90OpzBTdvUtDcU=;
	b=EoEQR0liuAtgnQXHUqSgcyXlhowwDEmsQPBzj1RLLPn2Z60pAIDUDqu7TETQYeitIHmE4C
	YGwmeLR8iioWN/aIZfEFCFiBBJ+GOsQQQfVH+zyqldWKdvWuwKnUfYaYAaEmy3S22nHzY/
	PSuuUMGEJN1S8vEabQcMIkya1VrWXjY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-345-tL527mulOdqoGvq1ALhRNg-1; Sat,
 15 Feb 2025 05:28:12 -0500
X-MC-Unique: tL527mulOdqoGvq1ALhRNg-1
X-Mimecast-MFC-AGG-ID: tL527mulOdqoGvq1ALhRNg_1739615291
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6F29118EB2C3;
	Sat, 15 Feb 2025 10:28:10 +0000 (UTC)
Received: from localhost (unknown [10.72.112.76])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F228D1800874;
	Sat, 15 Feb 2025 10:28:07 +0000 (UTC)
Date: Sat, 15 Feb 2025 18:27:59 +0800
From: Baoquan He <bhe@redhat.com>
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Barry Song <v-songbaohua@oppo.com>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>,
	Kalesh Singh <kaleshsingh@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] mm, swap: remove swap slot cache
Message-ID: <Z7BsL2v6+oweqWE4@MiWiFi-R3L-srv>
References: <20250214175709.76029-1-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214175709.76029-1-ryncsn@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hi Kairui,

On 02/15/25 at 01:57am, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> Slot cache was initially introduced by commit 67afa38e012e ("mm/swap:
> add cache for swap slots allocation") to reduce the lock contention
> of si->lock.

Thanks for adding me in CC. While I got failure to apply this series
to the latest mainline kernel, could you tell what is the base commit
of this pathcset?

Thanks
Baoquan


