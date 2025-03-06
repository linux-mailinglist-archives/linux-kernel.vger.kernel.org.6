Return-Path: <linux-kernel+bounces-549585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDBFA55432
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62B013A6604
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246B5272909;
	Thu,  6 Mar 2025 18:05:09 +0000 (UTC)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F83126B080
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 18:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741284308; cv=none; b=QO0y9rf+e5pxao9P+lrW88J8RfInPx+GEquZT1iUDLhVnN4uLHJmq0pKCK6ehCt2p2yAyPxTXQQKRL9w0sgJDTBtn/wnuHb5+27PwA/fMItM7UmHGjKn5ivf1riGeA41MY3kF7X6jnscptbHjtRiPX/m1PSdJ0N/NVgbkdip9ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741284308; c=relaxed/simple;
	bh=HnOiXdIEGgi0ajA46Ao4q0OHXUgw4cbdKL3Zt6BVsoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6g53x+SgYATTTHYm+g8AFJhoX6rCE60xWyaIcmMHgEAWz0YB/UZI+F9l2PwrplY0GEBshwPIhL/2sQ+g/JWPUqiHX7XxX9kSRsXDuUuOdUASQbB9VApBo0X2v0QSnCFTKK6ID0Fv7ZLIKnlTuFcW13EL6Ku61gQBMQQCAoz/4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-112-92.bstnma.fios.verizon.net [173.48.112.92])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 526I4Rql015568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 6 Mar 2025 13:04:27 -0500
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 419262E010B; Thu, 06 Mar 2025 13:04:27 -0500 (EST)
Date: Thu, 6 Mar 2025 13:04:27 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Aditya Garg <gargaditya08@live.com>
Cc: Ethan Carter Edwards <ethan@ethancedwards.com>,
        Sven Peter <sven@svenpeter.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "asahi@lists.linux.dev" <asahi@lists.linux.dev>,
        "ernesto@corellium.com" <ernesto@corellium.com>
Subject: Re: [RFC] apfs: thoughts on upstreaming an out-of-tree module
Message-ID: <20250306180427.GB279274@mit.edu>
References: <rxefeexzo2lol3qph7xo5tgnykp5c6wcepqewrze6cqfk22leu@wwkiu7yzkpvp>
 <d0be518b-3abf-497a-b342-ff862dd985a7@app.fastmail.com>
 <upqd7zp2cwg2nzfuc7spttzf44yr3ylkmti46d5udutme4cpgv@nbi3tpjsbx5e>
 <795A00D4-503C-4DCB-A84F-FACFB28FA159@live.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <795A00D4-503C-4DCB-A84F-FACFB28FA159@live.com>

On Wed, Mar 05, 2025 at 07:23:55AM +0000, Aditya Garg wrote:
> 
> This driver tbh will not ‘really’ be helpful as far as T2 Macs are
> concerned.
> 
> On these Macs, the T2 Security Chip encrypts all the APFS partitions
> on the internal SSD, and the key is in the T2 Chip. Even proprietary
> APFS drivers cannot read these partitions.  I dunno how it works in
> Apple Silicon Macs.

How this workings on Apple Silicon Macs is described in this article:

   https://eclecticlight.co/2022/04/23/explainer-filevault/

It appears such a driver will also be useful if there are external
SSD's using APFS.  (Although I suspect many external SSD's would end
up using some other file system that might be more portable like VFS.)

In terms of making it work with the internal SSD, it sounds like Linux
would need to talk to the secure enclave on the T2 Security Chip and
convince it to upload the encryption key into the hardware in-line
encryption engine.  I don't know if presenting the user's password is
sufficient, or if there is a requirement that the OS prove that it is
"approved" software that was loaded via a certified boot chain, which
various secure enclaves (such as TPM) are wont to do.

	       		      	      - Ted

