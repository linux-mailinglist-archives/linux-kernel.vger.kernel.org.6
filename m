Return-Path: <linux-kernel+bounces-570723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB72A6B3E9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 06:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3E8D18928B0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 05:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA72B1E51FF;
	Fri, 21 Mar 2025 05:04:11 +0000 (UTC)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C2E1CAA81
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 05:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742533451; cv=none; b=VR0ItwgpbtCfT3gH2ElRaTyFKfTtoQeWAF78SaNnbmYXoMRgXB0A3MJ4duCOBMF+16FA25qMeoXNvttpDGwNi1Qw8OjA3UCGF8Ha7dAu2czaNklxokJF1SRAi3arY1UQMLA2cOYcRmyWqCgORVeox08YRoFSm+eLrsn4UxRnBL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742533451; c=relaxed/simple;
	bh=k3aRHFcNldUWetmuSyA8ckpn2xNWFy4NQ23Oj8LtJQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0ffiRDwlI5gLqvTy16QcEMlvN3Sud3UO6drDMlAno77U+NIjvyqbg/85ny5wytZhdT+oAmcmHxr5W5WKyemqKifIMB26kcajaPy6cqcxAeYZ9OP/QotBSgfTuJ7IiXBVrWiUHDCuCNZmISGKCNrAn8x4xvrvAEUYKUh/fmqnFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-222.bstnma.fios.verizon.net [173.48.82.222])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52L53rw1019049
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 01:03:53 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id E21112E010B; Fri, 21 Mar 2025 01:03:52 -0400 (EDT)
Date: Fri, 21 Mar 2025 01:03:52 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Qasim Ijaz <qasdev00@gmail.com>
Cc: adilger.kernel@dilger.ca, shikemeng@huaweicloud.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH RESEND] ext4: Fix potential NULL pointer dereferences in
 test_mb_mark_used() and test_mb_free_blocks()
Message-ID: <20250321050352.GB1161423@mit.edu>
References: <20250313000021.18170-1-qasdev00@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313000021.18170-1-qasdev00@gmail.com>

On Thu, Mar 13, 2025 at 12:00:21AM +0000, Qasim Ijaz wrote:
> test_mb_mark_used() and test_mb_free_blocks() call kunit_kzalloc() to 
> allocate memory, however both fail to ensure that the allocations 
> succeeded. If kunit_kzalloc() returns NULL, then dereferencing the 
> corresponding pointer without checking for NULL will lead to 
> a NULL pointer dereference.
> 
> To fix this call KUNIT_ASSERT_NOT_ERR_OR_NULL() to ensure 
> the allocation succeeded.

Thanks; other folks have sent this fix.

	      	    	      	   - Ted

