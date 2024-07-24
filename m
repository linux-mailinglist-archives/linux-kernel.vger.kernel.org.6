Return-Path: <linux-kernel+bounces-261262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 378C593B4E1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 18:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6729B1C234E0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B975415ECC6;
	Wed, 24 Jul 2024 16:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="pg3VmUUc"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6226515ECE6
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 16:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721838111; cv=none; b=q4dEXlUZ/pKxdQLjZXl5Zge1xWpnxBgz0VQKyJb/9JOhAez+Qz7XCWmZaMj8K5Xm95OdeKh8sST/++DT6unzlZc9Y5xgE4z11o3d8OG6BwNzYOMiJRV5ErduaVUmZYjKR8rw2K4FicAZZys483fynUMtyQq89+UE8MGgpYqYC/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721838111; c=relaxed/simple;
	bh=vB9Yae19v7LUa5zWDxNrPhM5ExpUn167kiKlRJHhN/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QcW4vSZkPgiE9pxhcOEJrUvzNrxDcYD/iY3dqgyo9eami38fkifluosH+/VP/VFC1zPamH8Uk/Hgwlb5HCBCr1o4Wt6K5mqrFxL3bgDdzqed9pOHr+NNRgQKy99ytG4uyOWxv6180ZK21jDnU4hD47keMOYtKBdPv5VFHZp66qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=pg3VmUUc; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-198.bstnma.fios.verizon.net [173.48.113.198])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 46OGLWub017898
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 12:21:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1721838094; bh=ofF7hcycKI1A3je2myhR7t0W6v1DJnMOehPToQdbRyQ=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=pg3VmUUcM3zAFe/Nj5tA9Qy1lDlgmYnGrjVRjh/xX7yHcndBx7fqWjHenoKbfywT8
	 lUZbx54qpnqRnxYGF3A6F65zmF6zluUocXbvh2NXFYGBfcakvK5Pb5qEobO1aX7Vkj
	 xQjjcoWwWcze4wdM/rfoWfQ8AMSbWUVntpuae4JjaNiCwHtXZslF2p8DRChV76BMJJ
	 LVCR+/uffm6anG/f5HYtqRzCqdB/2pj9higN/B7uRUFWwyIAEHBqS+3UML7z8zhbpl
	 Bt+eLjzJi+gfQj6S9j+VMLL/easDK+EoR5l2rmOrPtgbpOdpq1Du5z1JrajZ+nZikO
	 ojwkAweMguM6A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id CF2F915C0251; Wed, 24 Jul 2024 12:21:32 -0400 (EDT)
Date: Wed, 24 Jul 2024 12:21:32 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Yuvaraj Ranganathan <yrangana@qti.qualcomm.com>
Cc: "linux-fscrypt@vger.kernel.org" <linux-fscrypt@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Software encryption at fscrypt causing the filesystem access
 unresponsive
Message-ID: <20240724162132.GB131596@mit.edu>
References: <PH0PR02MB731916ECDB6C613665863B6CFFAA2@PH0PR02MB7319.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR02MB731916ECDB6C613665863B6CFFAA2@PH0PR02MB7319.namprd02.prod.outlook.com>

On Wed, Jul 24, 2024 at 02:21:26PM +0000, Yuvaraj Ranganathan wrote:
> Hello developers,
> 
> We are trying to validate a Software file based encryption with
> standard key by disabling Inline encryption and we are observing the
> adb session is hung.  We are not able to access the same filesystem
> at that moment.

The stack trace seems to indicate that the fast_commit feature is
enabled.  That's a relatively new feature; can you replicate the hang
without fast_commit being enabled?

						- Ted

