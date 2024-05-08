Return-Path: <linux-kernel+bounces-172338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D3E8BF140
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 01:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3491E28236D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 23:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2992912BEB6;
	Tue,  7 May 2024 23:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="cIynFjfY"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E856782480
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 23:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123060; cv=none; b=asFAsojWOboM4hQQfNYWuMWVepYRtKXeoFTN9eL6r1ab4SQdL4u52O5J6IBHP3v+0T06nya7QNXnJ33XeNrOtfYPFSqqH84Bb2cwO/ksdRlN+aEV3qr/Ko3BHRyURJmZIRPv0KOt8FIFYVXRkTSX2vllkg9SSl7dtkMZRgFlbqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123060; c=relaxed/simple;
	bh=aRJ5eOavtxFoeQm1a6aVCBNYqrvRZt62HRm6bVv8Ny0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WbNxDp/HsrucxXkucdfFKcRFWhkvYPcWJY3xPv8ffXMphLxj7te6S4H6s8PCtl5PhJ9dZCPdgVpb7idqMzmAhDf2vo2aW/GAEFB1paAkv0Ns7EYJBRco+yRhQEGvvpwM42cui0sx8B7uBGyFT9I+lgIRezKfEuofKSYbbVrhyRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=cIynFjfY; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-2.bstnma.fios.verizon.net [173.48.113.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 447N40sJ026165
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 7 May 2024 19:04:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1715123043; bh=BrnPvZaXuhBO9HN4Y46xIKgyPSVHIWkzEKshZvIldG4=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=cIynFjfYTyECIo2HKBZpMvLi82qvbCKbOalj4zG4fUoLOvq4FDkH4ZCO1Hj6LtBfr
	 Rq4Hq+acRsdkwHoswLqPL155lqRDqYg1gB25kL76a734MAlduBecQuSsl89LLsHunK
	 IAtei87uSWL/FyErzv47NmJo14L8nX+8rdLGyfvEy7HzlR9RdHDi/g+B7ABCSN9fbt
	 2SoWVx9i/mM5CyFCT5rBiTLMAVMe8cLvxYiJPMbB4Ph7TKqykasZ0oE+kAAjTHZLQc
	 dmEgGmTf6905q2Q36s/QKeSNN+4Oxv3UdCcfCQ7cqjE8S9Dez7cpnPI2yQGzwIj18A
	 LPex+qo2jLv5w==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 0AE6B15C026F; Tue, 07 May 2024 19:04:00 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ext4: fix potential unnitialized variable
Date: Tue,  7 May 2024 19:03:50 -0400
Message-ID: <171512302197.3602678.10166283423942285304.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <363a4673-0fb8-4adf-b4fb-90a499077276@moroto.mountain>
References: <363a4673-0fb8-4adf-b4fb-90a499077276@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 17 Apr 2024 21:10:40 +0300, Dan Carpenter wrote:
> Smatch complains "err" can be uninitialized in the caller.
> 
>     fs/ext4/indirect.c:349 ext4_alloc_branch()
>     error: uninitialized symbol 'err'.
> 
> Set the error to zero on the success path.
> 
> [...]

Applied, thanks!

[1/1] ext4: fix potential unnitialized variable
      commit: 3f4830abd236d0428e50451e1ecb62e14c365e9b

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

