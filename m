Return-Path: <linux-kernel+bounces-400165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 326C39C09C7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63F991C21098
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFE22144B7;
	Thu,  7 Nov 2024 15:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="fEvCKv79"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E408213157
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 15:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730992414; cv=none; b=iHovxw0t2r0kgB0cYnu2snx/uxswFfsUONcPf/vkfcqKptmPAuJhTn1Bv5GMf9gKdBE7tg0DxqQctFbBLizIiNJZvaknp+X3jdAXWuR073Ojg1iMvJke1EwtMSqF9Y0KA1b5VENaNXBXnoklWvKGTCD4DOgitWQa//mbzZm/vuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730992414; c=relaxed/simple;
	bh=DHX8ouM0mjOZJhCZSF2ORZpQdIyaW/O3bJFn6RvnLi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uB9x5rEg8qwH/seQB09GITTh7Bxp+55lV+J+4WX0mRB9kwYqaCtGgSce/J64UhqCz63RH09LLChfB8Yi9f3bP6qsOU6I3TNomhWZwPfVtYd2cCWzYTo0/bsfyXXPlh4tHfnoMRsz5DuctFtzXdE/H/Pa/kKtIhNDit0uT+Rq6x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=fEvCKv79; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-224.bstnma.fios.verizon.net [173.48.82.224])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4A7FD6FU003522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Nov 2024 10:13:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1730992388; bh=LHIMNJt1AsV12J7iWyhtxwhvOO9nmuY/oYo6OO5n+6U=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=fEvCKv79blMbtOQs+U+8gtvffOQa9HI7Cb9zw9gs5IYP+xOo2KZ6y9QT4vSNs3q9y
	 QmOtQbMPO4aG13Wv4sS2KRqKTRWXMCQwa19uUHzNkA1IiAm/NU6v+Jr1mFyahD7mf0
	 i1jbKqdOqt0qrmPUsFoZcJluH8AcHrwXn7nkxAQUf0wOmis+evSlzcdw5F9xb78+Y+
	 C0BDEAawUwsY6+ACQJUPEjnjNKWGmMJe6e96Ezc7tb+P8HyG19aHC+IPIEYADO7HHd
	 3kNVX8uVQHnT5m8dtvpikBI/4tguP1TjjNjUk8TNkxYit0Sr+A16A4MVZPEHEBNq3D
	 JSi+TWAQ/H32g==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 40A9A15C0328; Thu, 07 Nov 2024 10:13:06 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v1 1/1] ext4: Mark ctx_*_flags() with __maybe_unused
Date: Thu,  7 Nov 2024 10:12:54 -0500
Message-ID: <173099237652.321265.10285147314842197735.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240905163229.140522-1-andriy.shevchenko@linux.intel.com>
References: <20240905163229.140522-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 05 Sep 2024 19:32:29 +0300, Andy Shevchenko wrote:
> When ctx_set_flags() is unused, it prevents kernel builds
> with clang, `make W=1` and CONFIG_WERROR=y:
> 
> .../ext4/super.c:2120:1: error: unused function 'ctx_set_flags' [-Werror,-Wunused-function]
>  2120 | EXT4_SET_CTX(flags); /* set only */
>       | ^~~~~~~~~~~~~~~~~~~
> 
> [...]

Applied, thanks!

[1/1] ext4: Mark ctx_*_flags() with __maybe_unused
      commit: 7bdb90e0f6c832c00a4c0a5d841aa367502dbfef

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

