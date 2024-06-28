Return-Path: <linux-kernel+bounces-234287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C5991C4AD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 19:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ADF0284134
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 17:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42931CF3EA;
	Fri, 28 Jun 2024 17:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="lbVIy3aE"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B411CF3DA
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 17:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719595107; cv=none; b=dptMwybHj4y26xQPxHjRDksFccSA+sf6nZZ4QCDingsHIa7OflnMqBjz3tbgTOvFdszQZPqDnAltRnFP6V39Oab+DkWE9A3pDdo3LVg39NKsliGwiKxrKs3AnZr83ez4LW+cNzsY1SGWUtuMtFqPp2Pp4IuK/gNiHDmT4qN5hZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719595107; c=relaxed/simple;
	bh=j6JO8xnyqMthfQl9cUoRuoYJrzy8B24x9G+tgF0oCf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YP7OFy5PQUphmVxOKkEZRi5UpFX1mc5BRvmHKNLawpUpTUsblRPm19rJpyzprNYr5W4EufxffoacRZUNcsHmssyf79f5q/wBRSJSI7cQ7Jbw292/UwuAbzeDGm9jnR5mF/xUDuf1/oiSVF3Ilf5PhMHkOQB6DBhsjafRYBObAVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=lbVIy3aE; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-120-63.bstnma.fios.verizon.net [173.48.120.63])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 45SHHtj3024133
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 13:17:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1719595077; bh=X1ZgjNTwhvsPZeB1iqG8J+FyPbhfO8IrQNQBkJW9UsM=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=lbVIy3aEgzoDnpDkZQ/0rMvVad4dPzab+VELImZHfTv0k2rQFQdHCxzgaUkAEcp8F
	 zFVjU9UVxn0hTb06cglFIDW3XziJD3h9H0VDn1KyMAZZ7CbRO4Zv8uygPzuWNPnB24
	 6PwczJkCVKnM0mYJsdmSImSqhnahGyS41yRQLE9jh1yXMzcJTOjAs4EFMDm7IXnjFl
	 /X/F9+ZA6WsvD1IDD5CPxra9O32NIrU56Z46+6IpPudu63CRndCdexiw0ByZotCg4z
	 a1yCMd9Fkfk1r2XWfyhePkmzZh1EiPYwxrO7udiMK0HcFvIz3cRg7vW23Upxb3UdPG
	 t2wCi6MDNK0LA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id D2D8C15C00DC; Fri, 28 Jun 2024 13:17:54 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andreas Dilger <adilger@dilger.ca>, Zhang Yi <yi.zhang@huaweicloud.com>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ext4: fix infinite loop when replaying fast_commit
Date: Fri, 28 Jun 2024 13:17:46 -0400
Message-ID: <171959506219.737463.11804303304019797243.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240515082857.32730-1-luis.henriques@linux.dev>
References: <20240515082857.32730-1-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 15 May 2024 09:28:57 +0100, Luis Henriques (SUSE) wrote:
> When doing fast_commit replay an infinite loop may occur due to an
> uninitialized extent_status struct.  ext4_ext_determine_insert_hole() does
> not detect the replay and calls ext4_es_find_extent_range(), which will
> return immediately without initializing the 'es' variable.
> 
> Because 'es' contains garbage, an integer overflow may happen causing an
> infinite loop in this function, easily reproducible using fstest generic/039.
> 
> [...]

Applied, thanks!

[1/1] ext4: fix infinite loop when replaying fast_commit
      commit: 907c3fe532253a6ef4eb9c4d67efb71fab58c706

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

