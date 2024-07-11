Return-Path: <linux-kernel+bounces-248529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4772792DE7C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 04:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02A62281EC7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 02:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1C460BBE;
	Thu, 11 Jul 2024 02:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="nibOIFLX"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474131C294
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 02:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720665361; cv=none; b=qQMOpLd8WuoW+GFdnrHhuqn9Rkm3cLOy2pTI5roppp97/tYA/uCJ34exk+3sgkT57xxD2ypGXZr7dR2xsXlaUQkRfhl4L51mETekdYHsPVytToBrhCLEDMG53FJ1Duex6Zg/8UuH9/BJBYtbyIzNWVkjkzkcbS7Yggb5s2S6bvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720665361; c=relaxed/simple;
	bh=9wMzDL0KaW2gHUI1KAWqOWRV9+6GzNO8Mc7bxiu9yJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jN7tjiYpESENUykGqQEn6Qajst7RXvkXfPB+oRm8tdVo577t5z1C0QlAVeJ6OSpFpx8ANRLZgMzQ3wzPwdsG64f4bWyKAK7NDeT7Nm5GdnTsGvX/Ehig/FS1StPWPlfGOmEQJBtRiUQV5riGBzWLrITDfLyK7K9vTz4K2vrAf4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=nibOIFLX; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-116-79.bstnma.fios.verizon.net [173.48.116.79])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 46B2ZhS3025453
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 22:35:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1720665345; bh=A5QZ+2y8gx7d7h2gzy9P1f8ysBc8YRyJZ55h+SMYJls=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=nibOIFLXsKtLduGFEN2cCg8kBQTN0e5ql5RfW2t6YkshGrUf71wIK280Vj8sX7VgP
	 rpuCf3+MKQSqvkB3Is9FTkgwcrodQbpTrnOJ9h+aNNKYtfGjeHX8kYXdw7q00ND4gy
	 UmazD78tTr1nH2IFaI8eG6fG8Dpw+NMimCxa+khQMtsjc3l41fqXrsMtJAMJAIxnJ5
	 JaQzy4UxYBUQfFSAd8CHPAJ4UppqxDPuLyo9FEYQWnxI2Ls8SoSfsd2NdkepG3fx8A
	 HqIZsendxPrkpiEb8KE29ONCQDK5ICNLU02Vj+6tkVeGsQVV+oWGkS0OUQo9bziMfz
	 YriYLHWycSt6w==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id D820D15C1920; Wed, 10 Jul 2024 22:35:41 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: syzbot+18df508cf00a0598d9a6@syzkaller.appspotmail.com,
        =?UTF-8?q?Wojciech=20G=C5=82adysz?= <wojciech.gladysz@infogain.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] kernel/ext4: sanity check for NULL pointer after ext4_force_shutdown
Date: Wed, 10 Jul 2024 22:35:36 -0400
Message-ID: <172066485818.400039.5921961627558810054.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703070112.10235-1-wojciech.gladysz@infogain.com>
References: <000000000000f19a1406109eb5c5@google.com> <20240703070112.10235-1-wojciech.gladysz@infogain.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 03 Jul 2024 09:01:12 +0200, Wojciech Gładysz wrote:
> Test case: 2 threads write short inline data to a file.
> In ext4_page_mkwrite the resulting inline data is converted.
> Handling ext4_grp_locked_error with description "block bitmap
> and bg descriptor inconsistent: X vs Y free clusters" calls
> ext4_force_shutdown. The conversion clears
> EXT4_STATE_MAY_INLINE_DATA but fails for
> ext4_destroy_inline_data_nolock and ext4_mark_iloc_dirty due
> to ext4_forced_shutdown. The restoration of inline data fails
> for the same reason not setting EXT4_STATE_MAY_INLINE_DATA.
> Without the flag set a regular process path in ext4_da_write_end
> follows trying to dereference page folio private pointer that has
> not been set. The fix calls early return with -EIO error shall the
> pointer to private be NULL.
> 
> [...]

Applied, thanks!

[1/1] kernel/ext4: sanity check for NULL pointer after ext4_force_shutdown
      commit: 83f4414b8f84249d538905825b088ff3ae555652

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

