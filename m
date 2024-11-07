Return-Path: <linux-kernel+bounces-400168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA229C09CF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 345CD28598A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF87213156;
	Thu,  7 Nov 2024 15:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="AuRYnwfl"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614E9213132
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 15:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730992449; cv=none; b=MDXiZdggmtAVYsHKDqPjap7iYKWeIP3PTm0Q5uCOXcxlg4dP1Yr/FExqOYcwVD8ks9sxkRpkhoBaEt+21Lbqae5Ca6jr99UccMsYITyRtpyKHXRDHrGrgUESO34Cf4jICh8VzacQx1H+mmL8UvqPeh58envaSKv63VCBK5gH3+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730992449; c=relaxed/simple;
	bh=c85BsSZmQ0DhmZ5RtLeu+wH/FlicBcGBJ2jXQmcD3WE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SReYWRQkC3DjvBrkjVfXEJ+niCxUCWWhgnHOOhYqsZUd9UWq4j+Lb58TKehKscd8bl/FPooS2I/EGmRAwQwQTnBv7aS6BOSZC0FhDy502nEe8BurBDamYbrx8Gn+rtieFXHvGMBZPEA2CI6u+uG7SfTBw47wVN1C7XWk0diZnrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=AuRYnwfl; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-224.bstnma.fios.verizon.net [173.48.82.224])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4A7FD6CD003523
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Nov 2024 10:13:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1730992388; bh=pKZuY20VF6iSUTl+wgAMwKSZaeVnqSJpO1FMvnPZu7o=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=AuRYnwflDdH6klPK1+jb4T2h8jxEHKo+/qwBMfPLAr2LVkWrz827CFcnN7eYOIyeH
	 Zv+ZFukYvGg+vqurrSJ1ot8gtimmRRTqgByBer1/ankCeQDCcJ4ZKieTxPuyDI3A7J
	 dwuJTx2S4KXVuwniRfrl2iFcHPwfHut9AQ3sFvg3msIw67O7spxuYU1UbGen7g2HC1
	 IJPbVoW51xPjR2RRnC6z1kxaDE7oW9ZWxB9MxTSSX4zRaorx7KB10cvpOE7/ghfTVg
	 hTsva2OvpS+pJXhNkkEaXhUbKQWsWu1CToNL5asTkQtSQQKuPfamxxgPaX61MV9Zvn
	 h+1hQCmf2gAQA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 3D12415C02FA; Thu, 07 Nov 2024 10:13:06 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: adilger.kernel@dilger.ca, alexjlzheng@gmail.com
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jinliang Zheng <alexjlzheng@tencent.com>
Subject: Re: [RESEND PATCH] ext4: disambiguate the return value of ext4_dio_write_end_io()
Date: Thu,  7 Nov 2024 10:12:52 -0500
Message-ID: <173099237654.321265.14598292051529807032.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240919082539.381626-1-alexjlzheng@tencent.com>
References: <20240919082539.381626-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 19 Sep 2024 16:25:39 +0800, alexjlzheng@gmail.com wrote:
> The commit 91562895f803 ("ext4: properly sync file size update after O_SYNC
> direct IO") causes confusion about the meaning of the return value of
> ext4_dio_write_end_io().
> 
> Specifically, when the ext4_handle_inode_extension() operation succeeds,
> ext4_dio_write_end_io() directly returns count instead of 0.
> 
> [...]

Applied, thanks!

[1/1] ext4: disambiguate the return value of ext4_dio_write_end_io()
      commit: e88d17afcf8364c353942e951f8e968f66bfcaa0

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

