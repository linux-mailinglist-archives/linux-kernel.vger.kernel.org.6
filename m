Return-Path: <linux-kernel+bounces-380339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A571C9AEC8F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 18:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D603F1C22F1A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7140C1F76BF;
	Thu, 24 Oct 2024 16:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="eKS3QLoR"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B60949652
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 16:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729788604; cv=none; b=eqHbHWc7DDa1XFvh0oz7CvtlokxKns/y0TbjGfvwc1vxZQzFFnz1KIvUZLmi0stgN+OsANrUojDZ7nj/2ZbG4xDiTTsRtSNYgQTC6O7EYXvGJQdTnn+2IasR4gvhbCbAHgCempVBiGvtiGmMcRVAi956z7Gx9XiHUS31tNohTts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729788604; c=relaxed/simple;
	bh=npDJVqUl3+iQUhp5igezvUqM9bDLXvZ/sShDG2Wvb9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJbQfpPFCmtRNy7wSThA9z/ar+pls3p2dAcMPzAIiBN2Fewkq8CQldbKASoyMhvKVtzC9BRIaHsLKCDqjz6zpEYyLRH/7uY8TZpstHD1ht6OH/6PWjj+Vc5cm5454goPkUYUL+hsNQwuH1giJMGb4fWngan4oAJNF5ky4w+I0ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=eKS3QLoR; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-115-113.bstnma.fios.verizon.net [173.48.115.113])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 49OGnd7k006531
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 12:49:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1729788581; bh=Q9s/1anCq5AePVGIPh5uPxKl8iOIwJpgLY4GsZUxfcw=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=eKS3QLoRJsRAfIUNyaXi2ZsE8LQ6qukpOlXVT5xJdddLM422BABMhhorCZRnf70Nh
	 w0aLtRguNlb5hhTkbaES8v705rHgd5YgWTFzQu0xBSKuSoAhv9pQ6AndWVlD4P8izD
	 qQLCRXid0zGO8fc+uftNW5aZ3mPLpb5jSJvUfnOe1G3VJAa7XPB6aOLlC77jcZGm48
	 yC+7uU+U+Q6Zs/eVJ4uB4zZFjYx2JLf0Bv33szTeIvkJAa4xHDlhBtijgKPg1eqBTQ
	 VvkpkPtEuPss1sgKF3fAdCBDL9cVJalreHKbvw19/mYa031Y7s1HDFhhKCBa2oVATy
	 /yMCxN4AJ+IlA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 3428515C0329; Thu, 24 Oct 2024 12:49:39 -0400 (EDT)
Date: Thu, 24 Oct 2024 12:49:39 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: quake <quake.wang@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove Huawei
Message-ID: <20241024164939.GL3204734@mit.edu>
References: <20241024032637.34286-1-quake.wang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024032637.34286-1-quake.wang@gmail.com>

On Thu, Oct 24, 2024 at 12:26:37PM +0900, quake wrote:
> From: Quake Wang <quake.wang@gmail.com>
> 
> Remove some entries due to various compliance requirements. They
> cannot come back in the future as huawei is sanctioned by most
> freedom countries in the world.

Note that there are multiple sanction regimes and exactly what the
rules are vary from country to country.  At least in the US there are
exemptions that mean that I can accept patches and send code reviews
for engineers from Huawei so long as they occur in a public forum,
such as the LKML mailing lists.  As a result, folks may have noticed
that there are ext4 patches from Huawei, and I personally consider
them very valuable contributors to the ext4 community.

These exemptions may not apply in different countries, and for
different sanctioned entities.  I will note that China is not
currently attacking Taiwan militarily at the moment, while Russian
misiles and drones, some of which might be using embedded Linux
controllers, *are* actively attacking another country even as we
speak.  So it might not be surprising that the rules might be
different for different sanctioned entities.

Finally, please remember that kernel developers don't make the rules.
Those laws are made by the US, European, Japanese, and other
governments.  My personal priorites are to make sure that *I* don't
run afoul of any local civil or criminal penalties, and to make sure
that other Linux developers can also stay safe.  That being said, I'm
not a lawyer, and so please don't take anything I say as legal advice.
What I'm comfortable doing as the ext4 maintainer living in the US
might not be applicable for someone else who might have different
circumstances.

So for example, it could very much be the case that other countries
have *stricter* laws, and if you are acting as a maintainer, in terms
of accepting other people's code, or providing design guidance (which
may be considered "providing technical assistance" in some countries'
laws) --- if you are uncertain, please reach out to a lawyer.

	       		     	      - Ted

P.S.  This has always been the case, even before one country invaded
another; maintainers take on real legal responsibilities as part of
their work.  It's just that the consequences of copyright and patent
issues were much less than when there are sanctions involving
countries who are actively at war with others.

