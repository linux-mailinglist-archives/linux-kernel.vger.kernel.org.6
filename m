Return-Path: <linux-kernel+bounces-419368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACB59D6D01
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 09:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B3BAB212A2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 08:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6BC3BB24;
	Sun, 24 Nov 2024 08:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNJQnYcT"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C592FE33
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 08:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732435335; cv=none; b=LYjog1Ux5+KkWO5oJAuQmmHgFmUp0DbaLIJH3UFwChlPaXFKeKufrSOZVxkMiDd9p6AQP7Df2xuvRSzG3LN1eLqdxfUM957VKOYDUhM6Dk6TVyv9p/rGAWTH+MhuKevDpH1uy8lYaSyOrpGu0bERrHhlTkGXL1f67DX05OMCypQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732435335; c=relaxed/simple;
	bh=JOHw3e3/XbcsstmbJzaEuaJ+VJyMXp37tlJTGQDgyBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ga/9EeaPZoYGx79iF92210OdncS1Yctbdf7pwcrKDeguZJyqEoyNTHo/crizZmuMyGP344asfo3no/9dEJ4KtMmYF8r6XO0RaEahvMwX8Xs9Vkezfi3jaPoUNuu2YIGdJ2tjYZgqLq26abFPLQ1k9HQNQu7XSipo6aKeh57U/Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNJQnYcT; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-724e6c53fe2so1659789b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 00:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732435333; x=1733040133; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K1IUJJ7iDDce6J1FT3PFuteos2N215Dgw4ubzBI4cK8=;
        b=jNJQnYcTronanYeHfFbGVC2aA4hNi576xnmsulqILQP0b27FBIt1oVuhYinY9T1qlY
         sSci1nFhSYIlCdPc4q5H5znwPrNJ7yu8Q4q0jucZitrRhADYRmqMtRvf9WsPZq6uSXFb
         Dg/m8uv++YWVB+0A91Sswc0FHFXG7+0DhphapTGIkQDVJlqQLE0hmAKD3+Ok0X54cngp
         TIcguvToAEbuAwcFxR/mycNnMfXzijDBgVfcL9DnzizQRLvziSBdVNwxrRm+cFos2wAR
         bpwFOlS7V37qTLfgnof1CX+Otr/cd6bpvqOjpxJZVe3qRCNGjKxfYa+Lwphib/nCucBZ
         vocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732435333; x=1733040133;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K1IUJJ7iDDce6J1FT3PFuteos2N215Dgw4ubzBI4cK8=;
        b=Q7Vl7lvL84yD9H05zC1TyJ6+lQA3viEpFKn574GGEIxAXsltWPTnNvZNV/B5PIso7o
         N71am8I67iQO+hKgpV3KFVfO0of2ZnDZj1jnYTwSLVifk1eK/eIjGPKwz05lG5bw3zhb
         kApf89mDWKoQwwFzmvCzokUcevfoqKpBWfFOxoifNwlqaSS8lAUyOwFGR2CR6yQ1gy4p
         qBBPlInT+FAbxJCQ2K4gNMrFtkVJXEPyT0fz4xfaXmod6vFRrZ7XlM8nwqukdR7BcFRs
         w4BXFdLYo1o/HpV7TxTrCqKvoce9IJUbYFKuYsGqaJNn09H4eTcM8phMet27bpDXUkaE
         11QQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQL06Ra1+URgGXKn/l0/7ATmfOzIcmuP0kYgL7RIO/ECcd7Ru+ejJtoLS6j+5CQyWl+siXFgCRWCx75Ac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcj6uGl/Sdy+L9GJDOkQrjMkIrIkASl4B4CB3rREceLP8hm4Kx
	0eZ4DL51mGm3oAqLKc3lG07caVU1NKXxu61/AGeejNlc00lo4Beg
X-Gm-Gg: ASbGncu2PcvECECe/5hQSQg5giLJvHKac02U0Q26qcuxMyj75j7SKq/FsB+WepnJaKR
	u3qqcTjLJPhM1NOMNrLr6i5G2LZHGYzYBwEKbEh7uuvDKF41FNgOPlRCOOzZrC5wDh4aK0w+RRF
	lVzYCvu4msXXlXiUBwrwhAjFhMhBwYdvEAMww6fM0CtYTeVU30W4+kN1IfHvt0/GK+4QzfIN9Qx
	h+qBiuVQbxQzTJVBzLB3OH8K6tRScFKyMWAUjdEsZlQnTfp
X-Google-Smtp-Source: AGHT+IEyJHYn59HUVxOfQgI6lMoD4L0Eb/C4r0+f3QB1xea1sMXi82EGiYMHPOxfHRarwkmHqinZKA==
X-Received: by 2002:a17:903:40ce:b0:20b:8a93:eeff with SMTP id d9443c01a7336-2129f6803c4mr115362765ad.37.1732435332601;
        Sun, 24 Nov 2024 00:02:12 -0800 (PST)
Received: from Emma ([2401:4900:1c21:cadf:5054:ff:fe53:2787])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc22952sm42576335ad.268.2024.11.24.00.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 00:02:11 -0800 (PST)
Date: Sun, 24 Nov 2024 08:02:06 +0000
From: Karan Sanghavi <karansanghvi98@gmail.com>
To: Gabriel Krisman Bertazi <gabriel@krisman.be>, 
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>
Cc: Hugh Dickins <hughd@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] mm: shmem: Fix variable type to int to evaluate negative
 conditions
Message-ID: <cjg3somsmbqe7e6hllvlmebp7i3uzuajnzihazimiejwnvmjch@v6bmarryiv5w>
References: <20241111-unsignedcompare1601569-v1-1-c4a9c3c75a52@gmail.com>
 <87ttcdwr9k.fsf@mailhost.krisman.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ttcdwr9k.fsf@mailhost.krisman.be>

On Mon, Nov 11, 2024 at 01:37:43PM -0500, Gabriel Krisman Bertazi wrote:
> Karan Sanghavi <karansanghvi98@gmail.com> writes:
> 
> > version variable captures return value from utf8_parse_version
> > function which can be negative, but unsigned won't
> > let it capture, thus missing the further checks on negative values.
> >
> > Fixes: 58e55efd6c72 ("tmpfs: Add casefold lookup support")
> > Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
> > ---
> > Coverity Message:
> > CID 1601569: (#1 of 1): Unsigned compared against 0 (NO_EFFECT)
> > unsigned_compare: This less-than-zero comparison of an unsigned 
> > value is never true. version < 0U
> 
> 
> Reviewed-by: Gabriel Krisman Bertazi <gabriel@krisman.be>
> 
> >
> > Coverity Link:
> > https://scan7.scan.coverity.com/#/project-view/10043/11354?selectedIssue=1601569
> > ---
> >  mm/shmem.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index 7987deb2be9b..17a1d4fa8870 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -4367,7 +4367,7 @@ static int shmem_parse_opt_casefold(struct fs_context *fc, struct fs_parameter *
> >  				    bool latest_version)
> >  {
> >  	struct shmem_options *ctx = fc->fs_private;
> > -	unsigned int version = UTF8_LATEST;
> > +	int version = UTF8_LATEST;
> >  	struct unicode_map *encoding;
> >  	char *version_str = param->string + 5;
> >  
> >
> > ---
> > base-commit: 6d59cab07b8d74d0f0422b750038123334f6ecc2
> > change-id: 20241111-unsignedcompare1601569-05b5932145ef
> >
> > Best regards,
> 
> -- 
> Gabriel Krisman Bertazi

Dear Gabriel and André,

I hope this email finds you well. 
I'm following up on the patch I had submitted linked below.
https://lore.kernel.org/all/20241111-unsignedcompare1601569-v1-1-c4a9c3c75a52@gmail.com/
I noticed it hasn't been applied yet, and I wanted to see if there was anything 
else needed from my end.
Please let me know if any further information or modifications are required.
I appreciate your time and feedback.  

Thank you!

Sincerely,
Karan. 

