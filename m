Return-Path: <linux-kernel+bounces-224445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1585E912280
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 12:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFA1A28BAEB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 10:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CC7172794;
	Fri, 21 Jun 2024 10:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jAXMQVV+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487AB171679
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 10:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718966065; cv=none; b=JMvt+2XFKfTQPuWW3F3zxisMex/VwhB/UdmU9Dr/WhqirDY3W+8VOtL4GNT8+AlOvkq6KjtO2fmEutMpO/ogyIclyLgRr9hWpU9u8tMSWTB4aU5tNLaQ1IlwpfKTLuZ3KcSMCa7abEYymsQkxvmFJzZdFT3CMiO9l6DIYqQKP80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718966065; c=relaxed/simple;
	bh=SSeHh9kklPfPOkBvM8SO62iwOdE98d/i16mJy6LV0A8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMP0fiMpFq5mi7s+88tys94IGxZVpi06oFLMTzPHP1309J3BQ+BVRnHSvljWZDJZC1cM7N9qXuuxKChlXaPXe28Lq0vp3LAXsSTfq5HUz/d7spI/Nc5E7qviyU/llnxAhMoud2pYEkApvbT21uh8BP1Rm2rOqY0LBCZADuRc1W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jAXMQVV+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718966062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jicH10kgnAem7iqh38i51ASJS4+fEuc9yNE84SfuDqU=;
	b=jAXMQVV+07xtGzte3T6SahzIgHp/u80zc9dnq909lVOy3IjWitZbwWITvAud4djt5r6dSu
	pnAsQ9q92Hi6wtatBQIAjFov2lTodyrM5hD1zMofli56jrzDJoR3uEkLSGpk8Xfebv+w7t
	VlKthkLQPhc+XMBz4/V/LxRKSHwmnjk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-_ORWPx8OPLyyNfRCaGy8xw-1; Fri, 21 Jun 2024 06:34:21 -0400
X-MC-Unique: _ORWPx8OPLyyNfRCaGy8xw-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-57c6979daf7so951631a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 03:34:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718966060; x=1719570860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jicH10kgnAem7iqh38i51ASJS4+fEuc9yNE84SfuDqU=;
        b=kE5K4vTYDKF8xwKy0g7NT2Jm3Dx93oiVodX0VMutgih0ZhhQLQiMaQhAsFvyRSBx1m
         rVBxm00M1OZxCffwvqbMMHjnBqqypZb0YLlHTQ5K4s4WxGPnEyG+QWmc5CMz2NTyVOZE
         U4lyp1TYN+RkLTb9LIHlTF03nUHtcmakYMLMSbNVoCMF+NIFe5jcwVC547Cs76ahqg2U
         DCL1+s+ICSOD8f7damhCDBOKyyxm+EpNww2I+HYk2OKDfk3I6VKLNgnvJpWl7QavtJzn
         ImNsTCGDPiQ5QFtYQ+/r9UMYTqpmR/bU70Aa+FyOOZ67T7bqiKY9B/FEcmv1UvuY8v0N
         9mhA==
X-Forwarded-Encrypted: i=1; AJvYcCVYtYTOD218qUvwRgevGTM2Urpkt2UBIpdwY1UP1nnvbr1s7rD+umJd64v8nSxwOIbP0jvJDJS+wqQwZkiS8OVV0EWg1SN6EIAeqHxI
X-Gm-Message-State: AOJu0YwThtTKo5ij4r1lYqqemLWMaEjOkLTc03lt5UthviFTjoUbFWd2
	fiOrmNBqn9bbf5v64QmkZGBVnXxkdnG51sZ/VeHZHLMBk9BTiQdaTOPVZODqfVko9U9GX5Nbtb7
	NxaWNBCHdl47mpsI2FUUFEPxYs7YGVAoxdO4OG7z0jb/FruCZQBLoSLE/KAs5IQ==
X-Received: by 2002:a50:ab52:0:b0:57d:50e:d76b with SMTP id 4fb4d7f45d1cf-57d07e2c81amr4589279a12.7.1718966059592;
        Fri, 21 Jun 2024 03:34:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFj+LHC14k3j9hWJnw+AA9J/VaHS6CBPN7VDxZhc4wOnEY9CizAlhrLs2CdLC8RK9nzYWVisQ==
X-Received: by 2002:a50:ab52:0:b0:57d:50e:d76b with SMTP id 4fb4d7f45d1cf-57d07e2c81amr4589250a12.7.1718966058632;
        Fri, 21 Jun 2024 03:34:18 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d30562ee6sm747252a12.87.2024.06.21.03.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 03:34:18 -0700 (PDT)
Date: Fri, 21 Jun 2024 06:34:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	ksummit@lists.linux.dev
Subject: Re: [PATCH v2 2/2] Documentation: best practices for using Link
 trailers
Message-ID: <20240621062741-mutt-send-email-mst@kernel.org>
References: <20240619-docs-patch-msgid-link-v2-0-72dd272bfe37@linuxfoundation.org>
 <20240619-docs-patch-msgid-link-v2-2-72dd272bfe37@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619-docs-patch-msgid-link-v2-2-72dd272bfe37@linuxfoundation.org>

On Wed, Jun 19, 2024 at 02:24:07PM -0400, Konstantin Ryabitsev wrote:
> Based on multiple conversations, most recently on the ksummit mailing
> list [1], add some best practices for using the Link trailer, such as:
> 
> - how to use markdown-like bracketed numbers in the commit message to
> indicate the corresponding link
> - when to use lore.kernel.org vs patch.msgid.link domains
> 
> Cc: ksummit@lists.linux.dev
> Link: https://lore.kernel.org/20240617-arboreal-industrious-hedgehog-5b84ae@meerkat # [1]
> Signed-off-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
> ---
>  Documentation/process/maintainer-tip.rst | 30 ++++++++++++++++++++++--------
>  1 file changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/process/maintainer-tip.rst b/Documentation/process/maintainer-tip.rst
> index 64739968afa6..ba312345d030 100644
> --- a/Documentation/process/maintainer-tip.rst
> +++ b/Documentation/process/maintainer-tip.rst
> @@ -372,17 +372,31 @@ following tag ordering scheme:
>  
>   - Link: ``https://link/to/information``
>  
> -   For referring to an email on LKML or other kernel mailing lists,
> -   please use the lore.kernel.org redirector URL::
> +   For referring to an email posted to the kernel mailing lists, please
> +   use the lore.kernel.org redirector URL::
>  
> -     https://lore.kernel.org/r/email-message@id
> +     Link: https://lore.kernel.org/email-message-id@here
>  
> -   The kernel.org redirector is considered a stable URL, unlike other email
> -   archives.
> +   This URL should be used when referring to relevant mailing list
> +   topics, related patch sets, or other notable discussion threads.
> +   A convenient way to associate ``Link:`` trailers with the commit
> +   message is to use markdown-like bracketed notation, for example::
>  
> -   Maintainers will add a Link tag referencing the email of the patch
> -   submission when they apply a patch to the tip tree. This tag is useful
> -   for later reference and is also used for commit notifications.
> +     A similar approach was attempted before as part of a different
> +     effort [1], but the initial implementation caused too many
> +     regressions [2], so it was backed out and reimplemented.
> +
> +     Link: https://lore.kernel.org/some-msgid@here # [1]
> +     Link: https://bugzilla.example.org/bug/12345  # [2]
> +
> +   You can also use ``Link:`` trailers to indicate the origin of the
> +   patch when applying it to your git tree. In that case, please use the
> +   dedicated ``patch.msgid.link`` domain instead of ``lore.kernel.org``.
> +   This practice makes it possible for automated tooling to identify
> +   which link to use to retrieve the original patch submission. For
> +   example::
> +
> +     Link: https://patch.msgid.link/patch-source-message-id@here
>  
>  Please do not use combined tags, e.g. ``Reported-and-tested-by``, as
>  they just complicate automated extraction of tags.

Could you please add a hint on configuring git am to create these?

I think something like this in .git/hooks/applypatch-msg will work:

. git-sh-setup
perl -pi -e 's|^Message-Id:\s*<?([^>]+)>?$|Link: https://patch.msgid.link/$1|g;' "$1"
test -x "$GIT_DIR/hooks/commit-msg" &&
        exec "$GIT_DIR/hooks/commit-msg" ${1+"$@"}
:

but I didn't actually try.

Thanks!

> -- 
> 2.45.2
> 


