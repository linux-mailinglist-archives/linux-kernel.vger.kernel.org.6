Return-Path: <linux-kernel+bounces-302235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC8395FB73
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 23:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF4161C21B5E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 21:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF1C19B3F3;
	Mon, 26 Aug 2024 21:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FenU7q1Y"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1D319AD7D
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 21:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724706885; cv=none; b=cp551ELGk+4ce/RaSshyk2NjfRPDbCeMfCgPWC82+BTUEEaQTPSPaFQh3iGBIGxjxBCNJ0xcszFvUZqNyJ6lprSud8US/iZWvNy0Bkbz3QsAeSDkKL+jRF00RRRG38EqCT7XoJUm8btxeCs7JjsGMHOhfq7xKp3bE/MO4Ieow0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724706885; c=relaxed/simple;
	bh=yBQ5y+Mb/CKBn/Iu+oeyfy0yTYtT35Q0Pi8FqyJi4Ds=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=C7vNFTS6EqdwUZvaMaTEIa45+fw3TO2CG2PUUJPYsEeznJZ/gIfoyCppQPDq3NL4UVpfE66e6EmFxYebGMRu46bhZwq7nM66XMQNy71gbE8ZfR0UTeH4aQC2k7PzmQgQCfMfVMyyGvYCa7wjZy5X5J6JazoUnA46UHQQTHu+bxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FenU7q1Y; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e115eb44752so5147887276.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 14:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1724706882; x=1725311682; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OfqvTXWrFldpunr+TQo/yeqa5OS+oEjv/nJw1AhDV/M=;
        b=FenU7q1Yw8t+4WiKBZThmfET6KwI2suyOv6R/XgPPEVyJ+nI/oj10zNY7xEzs6EUeI
         bT84tQy/ErWs5VFjmbYc2GMACE7aFy5OjpoBn2PcclkE3gRGoRu9C1qTGGmkcu+UpxyM
         cJZBMAuxH+OTbcKZk3Ind0+fw8+DmvMr5FhBbP43tx6JWPLUS8gtyWh6tyCEnnIYkj17
         3MZ4a6dsyYdCRQF1P8BsCI4zKJm4m9aldAz/p2Dd/gYclfDfKyOj00skTZVP7Xa6CmCb
         SCSBTp8xZgm7kk4uMKyO47TfPwGJgDS3DLBGdS39W/gW3tgq+5l2m2UsrYgh+7p0d78W
         rqxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724706882; x=1725311682;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OfqvTXWrFldpunr+TQo/yeqa5OS+oEjv/nJw1AhDV/M=;
        b=jqkhLZVWEfro5mD8Ax5p2Sfexl1r41cgnwwa3zeyNS2TI4UnSzWezj1WJCDVRKLkhW
         gSwC7iKiR52pDBbE/jHx0Q2+M5QxqNuchbsqa3KU+cnqDK+9Zve6hgq4wksa4Wcfzpd7
         i2WfT63yRFB5oloonWiwkVohJBG/yCfEO2HYhKYmlD6aqrx3EbVa8PsmA26z6GZiZXEG
         KtA7ncXUpI5VNgnw5BUzwC0g3ZfvFdG101DW+Gf6ln189JbBwv7v6yZeAV7bHhAC4e9q
         5Zg4J6shT00M5LTDGc4MxgukL8d6nMd6ppOQLQKIYpF+ZmNHXbIF5QJd6Imj5JcJ2N+M
         XtPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAtY8Z1kbF6aVW3WyXcSe5EscUGFhv5pPwKczood7saaK1z4B66HuHpzx+me3Xe2LNRVK9tHQWnZkGhLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY7XdtgVt+IOXnvkCP0mIUAdcwG45diiAGaxBFjecJ5n0qjRDU
	eP2EiePgk/8BtKBVPKsG5Hh5gWr+UVe8nRemTSqfrCuViVg9YTFW4yECpM9icQ==
X-Google-Smtp-Source: AGHT+IEbYWdr5Hnl4ZVk1T1sAYpHTMGnsK6xf7bfqR4BRfFMeNhZqzWNrEjRK6NPwcMTOvklx7UWzw==
X-Received: by 2002:a05:6902:144e:b0:e11:7a26:29a with SMTP id 3f1490d57ef6-e17a8add737mr13085054276.1.1724706882186;
        Mon, 26 Aug 2024 14:14:42 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162dcd3a4sm49877986d6.113.2024.08.26.14.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 14:14:41 -0700 (PDT)
Date: Mon, 26 Aug 2024 17:14:41 -0400
Message-ID: <3447459d08dd7ebb58972129cddf1c44@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Masahiro Yamada <masahiroy@kernel.org>, linux-security-module@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, Daniel Gomez <da.gomez@samsung.com>, Masahiro Yamada <masahiroy@kernel.org>, Ondrej Mosnacek <omosnace@redhat.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Subject: Re: [PATCH 2/2] selinux: move genheaders to security/selinux/
References: <20240809122007.1220219-3-masahiroy@kernel.org>
In-Reply-To: <20240809122007.1220219-3-masahiroy@kernel.org>

On Aug  9, 2024 Masahiro Yamada <masahiroy@kernel.org> wrote:
> 
> This tool is only used in security/selinux/Makefile.
> 
> There is no reason to keep it under scripts/.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>  scripts/remove-stale-files                                 | 3 +++
>  scripts/selinux/Makefile                                   | 2 +-
>  scripts/selinux/genheaders/.gitignore                      | 2 --
>  scripts/selinux/genheaders/Makefile                        | 3 ---
>  security/selinux/.gitignore                                | 1 +
>  security/selinux/Makefile                                  | 7 +++++--
>  .../selinux/genheaders => security/selinux}/genheaders.c   | 0
>  7 files changed, 10 insertions(+), 8 deletions(-)
>  delete mode 100644 scripts/selinux/genheaders/.gitignore
>  delete mode 100644 scripts/selinux/genheaders/Makefile
>  rename {scripts/selinux/genheaders => security/selinux}/genheaders.c (100%)

As long as there is no harm in keeping genheaders under scripts/selinux,
and based on your cover letter it would appear that there is no problem
with the current location, I would prefer to keep it where it currently
lives.

--
paul-moore.com

