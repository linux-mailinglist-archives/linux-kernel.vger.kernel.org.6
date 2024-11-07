Return-Path: <linux-kernel+bounces-400166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB809C09C8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82459285516
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73211215009;
	Thu,  7 Nov 2024 15:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="hLW1iUDx"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DB72144AD
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 15:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730992416; cv=none; b=XJJuWhHsl72pmqrdGMNJ5wIFPTVSiIZtVp+H26ae4n6Oyh1wbeqjMUnenCiCt5HSjtr40DBAWQ3qPpfOsRxwYUiENcnDPBAMzaF4+QERWmnjaSzvQpVf7BIZy/Y/0xczm36HavraGapfsm7uji5GKZM/B2hi3NJWzRPvv2j4JfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730992416; c=relaxed/simple;
	bh=oGnI8pY+GrGRrG1icU2LRO+UbcWIZI78QAZqO9PaSRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tilSkOi6tP4apmbkO5j6ZL/seKjX1SXzOeR4nSMSiaCT7E3RpNOXmcOE++ZeJ/CqrWf8HUkVpWBRvRx2qgWP+PN7Gf2TMinfM3iW5Y5UYQj05iDN81f8ZXOofxOYJzYDZPnuig7Vq83/sSBCXUx/76hN05+BSHKn3uva1wv+aMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=hLW1iUDx; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-224.bstnma.fios.verizon.net [173.48.82.224])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4A7FD8uY003590
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Nov 2024 10:13:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1730992391; bh=w/1XCbdwr9TRaRkT6Js0Wv7GL70wgyHBACNKnw8Igck=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=hLW1iUDxOIhPmOcZVocZmGvqWReJ+eZ9Wvu3+EAiNebu0jeoAVk++Pii4bV6w0wyd
	 CYB0WEXgOG8HqMML+RPIn8CxIGeXrTriMTFQYFVNK0TkLxJ5UfsY+72wfArTTTjTUY
	 8Qg0Zd21M0gLIN6kTsa6FJ5YxtHW4phgZTwr4vckqgVz73x7DQ10/JKqkBATkLLdJ5
	 bU49GTYhM8ArgQx5zliIYk2WX5vvj6ahEpgfv1KqGLcCsOriO0sNfwgnDil0NP2QBp
	 Mc52CxD74kvsTI9coSeZYYbucnyv9a2M0cBnfaqVPjVqZhwWXHFh56PLvNYCrGgYPT
	 Ps3RtZXOJnZBA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 4AFA015C1942; Thu, 07 Nov 2024 10:13:06 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: adilger.kernel@dilger.ca, R Sundar <prosunofficial@gmail.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, riteshh@linux.ibm.com,
        kernel test robot <lkp@intel.com>,
        Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH linux-next] ext4: use string choices helpers
Date: Thu,  7 Nov 2024 10:12:59 -0500
Message-ID: <173099237656.321265.16418369156766314115.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241007172006.83339-1-prosunofficial@gmail.com>
References: <20241007172006.83339-1-prosunofficial@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 07 Oct 2024 22:50:06 +0530, R Sundar wrote:
> Use string choice helpers for better readability and to fix cocci warning
> 
> 

Applied, thanks!

[1/1] ext4: use string choices helpers
      commit: e4765b185abd8fa49709598559cedb2c0822955e

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

