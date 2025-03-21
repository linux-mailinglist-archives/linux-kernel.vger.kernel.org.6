Return-Path: <linux-kernel+bounces-570726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D44A6B3EE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 06:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22702466962
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 05:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA701E7C1E;
	Fri, 21 Mar 2025 05:09:34 +0000 (UTC)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78E81E3793
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 05:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742533774; cv=none; b=l7Xt6YfnYPauJDa6PS9r+Xac13VngsFWeogI3+8ekOxzyio9BeMWsdzuCMYfLEmknLt2lpLb1zEDWXdbfaEfxoMCZ6Q0rumAe272eCoersI4KX/SMucUkwFHji4vC1M4Lgjo55R117LWOplH/YaqGCkQViLQGUmDd86miuSNRcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742533774; c=relaxed/simple;
	bh=thSOFIOaa7CQ3M84B093YYjHWrRsz7Aqtb8JBKOH6rA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lwcwYq62DKnmd63lHFZWzbbmTIJJyExObWOiJv9FTK6pQXGXpV9Ktb+xGcHOFi+Zyzz3m0774UQpBn//97S1chF+XzehlCWezvyLFrM4jOGJIX4bVceCgRA6wHOjKHD5ArIry4dtpsQ14qu3CsJwlGrACF5ZxEpAed7+zy2lvcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-222.bstnma.fios.verizon.net [173.48.82.222])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52L58sAT020188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 01:08:54 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 0C89A2E010B; Fri, 21 Mar 2025 01:08:54 -0400 (EDT)
Date: Fri, 21 Mar 2025 01:08:54 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Charles Han <hanchunchao@inspur.com>
Cc: adilger.kernel@dilger.ca, shikemeng@huaweicloud.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: Fix potential null dereference in ext4 test
Message-ID: <20250321050854.GC1161423@mit.edu>
References: <20250307115432.2112-1-hanchunchao@inspur.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307115432.2112-1-hanchunchao@inspur.com>

On Fri, Mar 07, 2025 at 07:54:31PM +0800, Charles Han wrote:
> kunit_kzalloc() may return a NULL pointer, dereferencing it without
> NULL check may lead to NULL dereference.
> Add a NULL check for test_state

Thanks, others have submitted the same fix.  It's now fixed in my tree
and linux-next.

	       	    	      	       - Ted

