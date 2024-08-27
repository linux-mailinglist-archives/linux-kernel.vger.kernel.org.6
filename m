Return-Path: <linux-kernel+bounces-303343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC01960B00
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F1B01C22A95
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6967B1C578A;
	Tue, 27 Aug 2024 12:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="bfNh6WBO"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E09F1C460A
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 12:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724762882; cv=none; b=DUQaI+mjMhb/Wj9gj0u2+dElsYa3H62BhMB9c+GdT5bJvBEK8YLrgJcCTHSr2pB57yZu1j4FWZhnPJ3xEWZQEVXtEMjSEsre6K2Jl7505/9G0dFWcGZ3JKuRAMUGReurblCvdPG0X5npfsxVdHRMZmxIdUFPXq7sgbGzxLO9AMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724762882; c=relaxed/simple;
	bh=R6D7+qQnQm3jzPsIpmE3Q9GrFtEYUrdUsuVPo5UPswk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tHDWnm2NAM90v7R4jjUsq++bLa/GMh6WdOwn7YcURtt5hgnkBzK+9vpwLaCrtP6UsXuSJI39i66yH6Y0XTQFLfySO4GDNc4CH+bhpLhDW5pF0EF2jOmID1abgy/aZseab59adnHU50RBkCCveGE3MRpBIqmpkR//B24U8Lda8QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=bfNh6WBO; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-112-93.bstnma.fios.verizon.net [173.48.112.93])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 47RClf7P021540
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 08:47:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1724762864; bh=U19LhhR9iTB/RKGBv97tak0iv7y0eTeJ8XQThvjLR/c=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=bfNh6WBOqcmJ2065PFYfR423gWY/0Ik/9ZgBbHhi0PPjmMHHqhuDbn8zWs9exiNxA
	 y/D0wiAHCkFM9IBjFARNoW9Usc943BIUP89R1Ezfog2zfwY58FTTFg2+77EptQXInB
	 oi5xA+tg8OtbcOMOtM5TGtJCABt6T0/gQHEbTElhhlmDjqafdoiliQzit+3ArDGj4/
	 jsI3ZYbMZcM+SmK9yc6AEi/Axkq/v/ONIj0/D6GOK8+tNEF1br289GqTLkgt7IOUh1
	 q0QXHKapovmLjFt+i91ZUdVo2j0qIoyfCYUWQifYMO3ayw3O5YhTRHSad/ZWjnC/Jl
	 qYbYLxSW59zWA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id C34E415C1C63; Tue, 27 Aug 2024 08:47:38 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: adilger.kernel@dilger.ca, kees@kernel.org, gustavoars@kernel.org,
        Thorsten Blum <thorsten.blum@toblux.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4] ext4: Annotate struct ext4_xattr_inode_array with __counted_by()
Date: Tue, 27 Aug 2024 08:47:32 -0400
Message-ID: <172476284022.635532.12692920677759695178.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730220200.410939-3-thorsten.blum@toblux.com>
References: <20240730220200.410939-3-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 31 Jul 2024 00:02:02 +0200, Thorsten Blum wrote:
> Add the __counted_by compiler attribute to the flexible array member
> inodes to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.
> 
> Remove the now obsolete comment on the count field.
> 
> In ext4_expand_inode_array(), use struct_size() instead of offsetof()
> and remove the local variable count. Increment the count field before
> adding a new inode to the inodes array.
> 
> [...]

Applied, thanks!

[1/1] ext4: Annotate struct ext4_xattr_inode_array with __counted_by()
      commit: 01cdf03b1378f2d860d4eb5951895a92002226a3

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

