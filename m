Return-Path: <linux-kernel+bounces-525622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AC7A3F261
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 11:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5D353BF127
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA9C206F35;
	Fri, 21 Feb 2025 10:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7OeFvPd"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9A9204C3A
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 10:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740134655; cv=none; b=cRm81F9R2sUBlbMQPopbSMLuKR5Z2pAubYtvkW2pKiv8gq+VBHFl9cMivurzCbIVsWXwCAxFagLg+2FOE5+sHw/lzahwdlFnmj6Z8LJ/nSTQJH/BONzEuf8aUiFYPnfXC0eBJM+StjHDTbMXHsS2UFwnIpj2ZzTX9Ya5w5sBq2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740134655; c=relaxed/simple;
	bh=w4iLK+g32pYcKCVfw3LkK60bPTa0FipcgGGc4wz+8Pg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NLjupF7Fb+QHQkMDaVQ/gcre5iSPZ1EGj9qoI/+rBhWXyOHpUFPTjRoJ6yEKkrg+ZPmmRwQGCCHa5VN3cCdLGY+wIMJ0r6/1u1de8kz4GXZvcTAtdvTMb2+SNVaeh0HtaaotJOKwk+nS3K58ibZ4KEqYWQ5E0WrELj/E1AWJtFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7OeFvPd; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-543d8badc30so2287728e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 02:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740134652; x=1740739452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6BS7onsO7kSNNzuYKYGVRsld0leREL2Z2/ajH0o0tVY=;
        b=E7OeFvPdi9Ivn5x2cFVVbfdumPzxHBt99A65ryd4qu2J8WufKcHiNtdR0D5f8MdG8c
         NEQxOZ2JKvtjrVscd/x/bAvkR9BQ1xIO6GwQ0HE+UlX/w0albEmAFTgD+ZFnBBd9Kab+
         Zcdj+9/A8vesJ88+sygEOGM0upkIZSa3s5K0DrWTiJawsCZnNwFJkdPlgXEOMv3+hzyZ
         bxsdaKw8JeCzv03nZSLB1f3M6YmoMWdT3BvfiweWa/EHXcHhkzh1zPpIBWEfRRBXsCMk
         CGlDPhtobdtcglmcPjuESGNcqbnai/01AwB82LfzbaGlzWc4WIHpGOG49xfXAO+2C5q9
         zU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740134652; x=1740739452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6BS7onsO7kSNNzuYKYGVRsld0leREL2Z2/ajH0o0tVY=;
        b=mXwQj3wSYvcTxX543EOKtDCCH21cDdqK297ueEItnkB1V3lJrBWpX39gS0IG/96cpt
         N66ceDIkbCR5SMuLZZTrODt4YAd5xqSqV4zT1weSJ/E1KAG6gmR3wO+yrNDGlv5BloZT
         oPuNHTeDwDxxAlCqz/wV/iO64yKFKb3Fy5SlPmbsfr8/LyKklVvmxd+FtWt/QFLRFMX1
         2g+x4HQdjueTHXK5BFynECaJer0Qc70+t6k1OPowNhE/Z6a0LOTmzjcp5IogqbfvpkdS
         AYYaGF+ggtNg1d3RMMTdQ/NTDWwnZSa2ThvlGW1ajWTyb3KUgqqx6mt1VabbSkpUkk3E
         zssA==
X-Forwarded-Encrypted: i=1; AJvYcCXoPcSuDiKQ3hqzJ3cNpFcH6f0fKWT4r8JdKMLFN0rLDu2gkk7Ng/MolLcNerCUDuBPzLk2L5cZicNZ/ZY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1yYlLVtM6Tr9i/CMj6UEwvl6kzQlJTqG86X8m2R3ASa78fjkU
	ycQuLdNyv8ojKI+bj8wVYF+BsXzdRL2bJh7Gp00siHQSvuJOF3NjEnOO9llktEcQpDBZ4HKS91v
	oXWAXUFnsfXdY4PHIoHjr+J3jz1Bc
X-Gm-Gg: ASbGncvNtQUqj9UFrevGA0rP79/jI36Fn3bfkJXe21BHACGggzIcrnC+cLwbHEAPfES
	JDmiOCCDc71E9eVfROg5zQMvzQLeuLT625GD6bsD+EMjFUidrjfZX/0Dh/mq3F0/TIO0V5Us640
	LLjjSAiqYiIMpgquFpbw5sHQ==
X-Google-Smtp-Source: AGHT+IElCXBChLLYNgT3p7IAhBhrNRWrZbxrVdqMPOi0NDp4FvMkm5xxiFTVXcqO2gCKD38y+f39UV4RWiXcugOPpao=
X-Received: by 2002:a05:6512:239b:b0:545:d27:e375 with SMTP id
 2adb3069b0e04-54838f590b3mr911776e87.42.1740134651883; Fri, 21 Feb 2025
 02:44:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220-x86-bump-min-llvm-for-stackp-v1-1-ecb3c906e790@kernel.org>
In-Reply-To: <20250220-x86-bump-min-llvm-for-stackp-v1-1-ecb3c906e790@kernel.org>
From: Brian Gerst <brgerst@gmail.com>
Date: Fri, 21 Feb 2025 05:43:59 -0500
X-Gm-Features: AWEUYZnqF_mUlVHI0riQC8xZE_YKMujs3DI5u4ZvdQ3_RWZkKEy9QhhZ85SbJ4E
Message-ID: <CAMzpN2gnYM8VhmHafBmh5+6+WWH+caWoMTssud_+H2_GvGbGzw@mail.gmail.com>
Subject: Re: [PATCH] x86/build: Raise the minimum LLVM version to 15.0.0
To: Nathan Chancellor <nathan@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, x86@kernel.org, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Uros Bizjak <ubizjak@gmail.com>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 3:08=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> In a similar vein as commit a3e8fe814ad1 ("x86/build: Raise the minimum
> GCC version to 8.1"), bump the minimum supported version of LLVM for
> building x86 kernels to 15.0.0, as that is the first version that has
> support for '-mstack-protector-guard-symbol', which is used
> unconditionally after commit 80d47defddc0 ("x86/stackprotector/64:
> Convert to normal per-CPU variable"):
>
>   clang-14: error: unknown argument: '-mstack-protector-guard-symbol=3D__=
ref_stack_chk_guard'
>
> Fixes: 80d47defddc0 ("x86/stackprotector/64: Convert to normal per-CPU va=
riable")
> Link: https://github.com/llvm/llvm-project/commit/efbaad1c4a526e91b034e56=
386e98a9268cd87b2
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  scripts/min-tool-version.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Brian Gerst <brgerst@gmail.com>

