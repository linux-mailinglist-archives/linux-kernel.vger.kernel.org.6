Return-Path: <linux-kernel+bounces-325794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6A4975E47
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 02:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5649B240B1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 00:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCEB1A28D;
	Thu, 12 Sep 2024 00:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXNxUO15"
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D85851C3E;
	Thu, 12 Sep 2024 00:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726102761; cv=none; b=J9HFbkfY8O9M6J8Tyg0bnCX+ccTaHUhqqfIbEBTVfExEWDhXLZ5tgGBGekNkKaIOHbI0x6ud8ytDK5EnI5SW9RLwnEhLYVmfYyPXcNxp9hkJypCDNmdMLhV4qtIkH1c6gAbwjx1i/NEoGfdoOFt99nmhH7vEmBMvFj5UkGJ+yl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726102761; c=relaxed/simple;
	bh=Wtk+NZ17eG6o/WTYLkvBZ/8lcqFKouTKLchh8GISpBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HUEt7c758nN6AP+/m1gNK77eGuoP/F3t2TBRakTjZ05SUN7QjHsMpNz3eAeg5boTwAJu5m2gety8ZhnFPHI8X42hvlsyW57hqSJyx2reupkolhEhrxPMPsfOACgiFWkKQ4dm/V7Wr6ui3xh5CcrBUH7Bg4i0cHDtn2KpsDrr3Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iXNxUO15; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-49bd40d77e5so159932137.0;
        Wed, 11 Sep 2024 17:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726102758; x=1726707558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgX4sccRi8NJbo5dbrCJ26d2m0ZxHHlk5FqkNXTA4qQ=;
        b=iXNxUO15uZuz2ApcOLm3O2oSVKNtO9GB5+P/il8PuQph+Hq8nG0/xG42UcuGOSUDVE
         UHm7Yw5bPzxI9ELRwwz2AJppfBfP4/VHJ1a0GePPfUTrOKC1Lzg7NrTAucA1gp5AdbRD
         v5tNogv7H/DJlxTM5mxsiaItF0WRv/rIp2gIZOVSyVq2mv/3TRdtaQAHhAH2Xd6clg6H
         11627ScwMoZkgzS+BAtKDErRQLOthTUXD723+Tcxi7FIPob4K42hCEBuy9Y5S6cM/DIn
         uvJRJaGnQvGxnsN5xdvAXaWRGVtLh9ijgEQUKAtyvYlY0FD9FQhs9okOMBdqV6ruwx8a
         a73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726102758; x=1726707558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lgX4sccRi8NJbo5dbrCJ26d2m0ZxHHlk5FqkNXTA4qQ=;
        b=kNOrR6fl/ZG6NzR10JXaiCccsLekaRLe49CW1ZjK2g2AU5H1e3PiBdS3OmZvkU69Tr
         7RzYSl3J7SGV0ROPwljwuvRIhSXCaI8UxDhJQfREESwCEOSK86PSu4d5O1D18R8SanjP
         AJfG5QYlyVbnL8rGSC7eenvn9vOjD8WTdpJi5BLUcVMbEuN/Bx8f48FosuvwUHB2M6rx
         malUhVMY62V5P/NBT38EOLgn+cHWbJ0FVkCFiyiAgRZCwktMw5Ehof1QitcxaiTMUnW+
         dAS+mDM6uHKbnU/azl2GNjN96Wgf373gW376e9W7e3plKoK2WloCukTkozGE/2p7uqhn
         ZjRg==
X-Forwarded-Encrypted: i=1; AJvYcCWATaXE8xKBjeHnE0bN+zrXeG4hty6r+JbEj185O7JPoTr/jmJeIRLKPpAtzQu0yZMgh2TwzA0WNlQb65I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPKKdm8WS+mJY5596KXWFnsQeetBhUG7FA0vOOJLxjOmbCXc9p
	eQFxz9dtdQRhxk0oepmm1dqp//OLINnzUbIqsgQLgtwswAFsH6G2Mk6gLr7QO1QHQsGqmz+e4f1
	6hwt6XsJCl3diXJWX6fV6AKIoW/EIVw==
X-Google-Smtp-Source: AGHT+IEmqE1+LHxlcQWdn5sh6AQNRcr4az7NeDC//sBs8XprlYeT/G3iNb84SLPYkUdpvkA+29zR7DDGaTqjbNjk1jo=
X-Received: by 2002:a05:6102:26c4:b0:492:a11f:a878 with SMTP id
 ada2fe7eead31-49d4156b1d4mr1234032137.23.1726102758504; Wed, 11 Sep 2024
 17:59:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912004747.5417-2-dennis.lamerice@gmail.com>
In-Reply-To: <20240912004747.5417-2-dennis.lamerice@gmail.com>
From: Dennis Lam <dennis.lamerice@gmail.com>
Date: Wed, 11 Sep 2024 20:59:07 -0400
Message-ID: <CAGZfcdk9i7psbTxPah6banb7wCwXuE7tueTpWcpxZESSbZ-HZw@mail.gmail.com>
Subject: Re: [PATCH 0/1]
To: dennis.lamerice@gmail.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 8:48=E2=80=AFPM Dennis Lam <dennis.lamerice@gmail.c=
om> wrote:
>
> Removed the :c:func usage in the journaling filesystems page.
>
> Dennis Lam (1):
>   docs: filesystems: removed the :c:func usage in the journaling page
>
>  Documentation/filesystems/journalling.rst | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> --
> 2.46.0
>

Please ignore the post, this email was an accident.

Dennis

