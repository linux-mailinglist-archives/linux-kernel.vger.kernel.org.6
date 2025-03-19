Return-Path: <linux-kernel+bounces-567198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC64FA6832F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 03:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C067883922
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 02:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A23B24E01F;
	Wed, 19 Mar 2025 02:33:56 +0000 (UTC)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D2A24E015
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 02:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742351635; cv=none; b=gNOQa0teLNqK4FH3efk+Bc/nOjEaLmiAS+48F8UUflTpUNYDfvze6iB8O9KM0t6nIz/1Txzp685rRz5WENmiTHUNP8GHln8+/alvvjX3GnKuYmg6JuLLzLzTtIc7fd19/6juRRmlHDGrsRDnG6WuvC51tABM27NHdulrfCgjels=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742351635; c=relaxed/simple;
	bh=pN4eCyKXTLYZ7VNKyoF7qW3oGBKZhbwvpeeM5v/LZ48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpdBrx4tHw1jTuRXj1L97Y3AzID3RmHtZsaEg067kxM8jGbF3i2KYrn6qyaj3Dp96N4V9WoHe8wA2kV/HSbggj+4C1MaQFPx121AWbIJ+UGat6FCNb4n0Bp/FQF7awp1X2DF5E5g2Yu+TWO3IPPjObM8+gqY3YGrzz9eqQwNslI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-222.bstnma.fios.verizon.net [173.48.82.222])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52J2VTHn031919
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 22:31:30 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 6592A2E010B; Tue, 18 Mar 2025 22:31:29 -0400 (EDT)
Date: Tue, 18 Mar 2025 22:31:29 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Baokun Li <libaokun1@huawei.com>,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: cache es->s_journal_inum in ext4_sb_info
Message-ID: <20250319023129.GF787758@mit.edu>
References: <d1a9328a41029f6210a1924b192a59afcd3c5cee.1741952406.git.ojaswin@linux.ibm.com>
 <20250316014128.GA787758@mit.edu>
 <Z9kq744Q1zbbxOKH@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9kq744Q1zbbxOKH@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>

On Tue, Mar 18, 2025 at 01:42:31PM +0530, Ojaswin Mujoo wrote:
> > So this is something we need to do if the journal is actived, and if
> > it's active, then sbi->s_journal will be non-NULL, and so we can just
> > check to see if inode == sbi->s_journal instead.  This will simplify
> 
> I believe you mean inode == sbi->s_journal->j_inode here right?

Yes, that's what I meant; sorry for the not catching this before I
sent my reply.

Cheers,

					- Ted

