Return-Path: <linux-kernel+bounces-526438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD13A3FEB6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0D9819C1265
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93B32512E1;
	Fri, 21 Feb 2025 18:24:55 +0000 (UTC)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EF7252903
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 18:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740162295; cv=none; b=O67Rj3sCEqFxk8UxBKZ+VLPUwffFi89ofKS5D9Cp672F6PoVZtGmsfgcO3RoKSCc95Z+TZmgHFOE9K4yoQEFiB8IytfcobvdddBIi/I0KuYjai6DVxsXrrPBnz8jRBPT+xql47V+V1rYPs0U1Dk17MvFahS97hm1IhA0lObmtuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740162295; c=relaxed/simple;
	bh=ydmGVURAeTjRhlYXuCLvdNQzmLGiLTBlaszgnc/fihs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=csSaAXjt0GEsXj0QE7Qx7V4RCQpL4gIueromvBCzJp8Fv4ekqYOV8v0iV4c3QTKHvcaKsp8g8mLu+H9T0tTpe6TunRzhmzHOY5Jx5RS4UrNdih0AtaWl84ZiJQN1x9UFG1YaZaSsCxY1NorG1KoUG7ixLS+W6FKM5+eJQlUaKNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-114-12.bstnma.fios.verizon.net [173.48.114.12])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 51LIOGib007540
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 13:24:17 -0500
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 73B972E011A; Fri, 21 Feb 2025 13:24:16 -0500 (EST)
Date: Fri, 21 Feb 2025 13:24:16 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, "Darrick J. Wong" <djwong@kernel.org>,
        ronnie sahlberg <ronniesahlberg@gmail.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Steve French <sfrench@samba.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/4] fs: Implement support for fsx_xflags_mask,
 fsx_xflags2 and fsx_xflags2_mask into vfs
Message-ID: <20250221182416.GA2252164@mit.edu>
References: <20250216164029.20673-1-pali@kernel.org>
 <20250216164029.20673-4-pali@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250216164029.20673-4-pali@kernel.org>

On Sun, Feb 16, 2025 at 05:40:28PM +0100, Pali Rohár wrote:
> This change adds support for new struct fileattr fields fsx_xflags_mask,
> fsx_xflags2 and fsx_xflags2_mask into FS_IOC_FSGETXATTR and
> FS_IOC_FSSETXATTR ioctls.

I don't think I saw an answer to this question (but the discussions of
the mail thread have really sprawled a bit and so it's hard to review
all of the messages in the thread) --- so.... what's your reason for
creating this new fsx_xflags2 field as opposed to just defining new
flags bits for fsx_xflags field?  There are plenty of unused bits in
the FS_XFLAG_* space.

Cheers,

					- Ted
					

