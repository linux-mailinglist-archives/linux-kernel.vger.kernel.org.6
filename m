Return-Path: <linux-kernel+bounces-406191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0FA9C5BE1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41B3A1F22F97
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2455201022;
	Tue, 12 Nov 2024 15:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="bakYRW4X"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5A92309AF
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 15:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731425414; cv=none; b=sSOUXUb/WMiznVUdSc7P8eV46Zn4GV3p05W9zXMV/f0Bc8ULO7puNE7ad2/HcJPdbJGRNfsdDJdPIsSqvacIdby5I2gLyO6ckAoPdF5wiGISjIJUFokqmk3vLa7hiCIp5xxn+k09Sl5LKXfjxb+lhJfC4IOKXU+hTTKZdMmkyNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731425414; c=relaxed/simple;
	bh=oQ9Mawo8eznNYoQsqkyEFfAf2/wUTnTgbGaLN/tHA3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3d9cHel8F5kahJBmqao/dZAPgz+WQUOVz2DZlhUdz4PspMXeVUMe96juN3W+gktN6V/Rn8qCpoH+tUx5usWBqsABHr/5G9wQ5n4oez0zwHrjjP6TPodMIJeYuDXIZZFPq6AVENv5vUeVPccZ1GqkzduboYEKwLV8Ua2hqJ3//Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=bakYRW4X; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-121-29.bstnma.fios.verizon.net [173.48.121.29])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4ACFTvp0027398
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 10:29:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1731425400; bh=rrvedqOzFeSZjpHxGWb8TXSwhmJGjtA+Wkqmq03U788=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=bakYRW4XEXPeBjFlH9dhPHJ+rFzNfcGathmJI1BZWNWJN6awxcr9Bw8FHFGqb9GeL
	 nFainndszgXMVwx2QL0sQCxQM6F4qgcqy06Cc2EnvAWUGX9dyg3l0yprWz9+8zI+6o
	 TEIJe54Ff/aEHa7Y+XGk8umoQh4xLZLVKZuYcwqpiA53PWF8IOyTEFxKwRD7ZWKKMk
	 foJQhh8xXpWc3UizNAORih+nafBeczoaS1keA0DihhRidlHjO0i5Qp+dMyk63PmQGM
	 xmcJQN/eyA6VV4jWe4UrPChVDmtXg+hmK6daOANth29wNuS5yCgCEqp40TGVmi2Joe
	 riaC8hE4SqH0g==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 908E115C0317; Tue, 12 Nov 2024 10:29:57 -0500 (EST)
Date: Tue, 12 Nov 2024 10:29:57 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: ext4: possible circular locking dependency at
 ext4_xattr_inode_create
Message-ID: <20241112152957.GA317364@mit.edu>
References: <20241112073421.GD1458936@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112073421.GD1458936@google.com>

On Tue, Nov 12, 2024 at 04:34:21PM +0900, Sergey Senozhatsky wrote:
> 
> I've a following syzkaller report (no reproducer); the report is
> against 5.15, but the same call-chain seems possible in current
> upstream as well.  So I suspect that maybe ext4_xattr_inode_create()
> should take nested inode_lock (I_MUTEX_XATTR) instead.  Does the
> patch below make any sense?

These syzkaller reports result from mounting a corrupted (fuzzed) file
system typically when an inode is used in multiple contexts (e.g., as
a directory and an EA inode, etc.) at the same time.

I'd have to take a closer look to see if it makes sense, but in
general, very often whenever we try to fix one of these it ends up
triggering some other syzkaller failure.  And, these sorts of things
don't actually result in actual security problems (at worst, a hang /
denial of service attack), and the right thing to do is to just run
fsck on the !@#?!? file system before mounting the thing.

The best way to protect systems against threat model of users picking
up a random USB stick dropped in a parking lot that contains a
maliciously fuzzed file system is to either (a) run fsck before
allowing the file system to be mounted, (b) enable the enterprise
policy that prohibits USB thumb drives from being automounted, or (c)
mount USB stick in some kind of VM (e.g., CrosVM) and then use a
reverse virtiofs / 9pfs / fuse to make the file system be available in
the host system.

The last would be best solution, but it would require development
work.  So I mention it in the hopes that at some point I can convince
some company to pick it up, since it would significantly improve
security for all desktops, laptops, and mobile systems that want to
support mounting removeable storage.

In any case, trying to fix these sorts of syzkaller warnings is
essentially playing whack-a-mole, and so while I don't have objections
to these sorts of fixes, if it causes any kind of regression or worse,
*two* new syzkaller failures, it just makes life harder for overworked
ext4 developers.  :-)

Cheers,

						- Ted

