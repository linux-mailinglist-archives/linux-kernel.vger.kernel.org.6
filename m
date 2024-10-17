Return-Path: <linux-kernel+bounces-368982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B239A1745
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 02:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECCB91F224F9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 00:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A7BDF71;
	Thu, 17 Oct 2024 00:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VDbs4/gw"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23F55661
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 00:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729125894; cv=none; b=HJbAJwtRjSFo3zflw/ZQvh9a9nZOrpAy8vYIgrzlVU97/c1rVxt9Zw6EnbQ5115U2efUelpm84lDdt+cnnolC7Nu7Cxluy5UL6ke5ETevPjHBbAQyR0nv5A9zD+mD1cfTVTTHrNQ318ePFQHnMOmvlgBmaiBGnwB+jcbe6xoFYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729125894; c=relaxed/simple;
	bh=q38Gk75NQ3Y05W/bT7Aw1wLV2+4Q3MEANDoCrYZhOww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T4VXnHkCBHCurfZ2ZIzeJm9n23GiHpgxpORdUaODY3RigC1RSba5Top8qRd0KDA45dPFQkost6ysA9FiHwPzsfwfEMI+SzQlAvHoDUNdD6te8WdU9Sgi75nMPOO0cyexMXYUP0pVYcRPHtlZlgAI3bEKkcXviyDtM75NbyurBcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VDbs4/gw; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-45fb0ebb1d0so79961cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 17:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729125892; x=1729730692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDVTSiiju+/i8uVx/5igK7HXQnS/pAXMN54tJaymcIs=;
        b=VDbs4/gw+LgN0yybuhmMRR7SNsLjmqZoaRJ+NZNgSyghJhvqIXEtkBZsIPvjW1ugF5
         0E9Nm/Ikme5acGHyo2UgjFWmDHzbb6mUKfITV3prU33ddEsMxOJkZSC29zdCQLfKxn3d
         xqTUo74V82cqjO3hhXDhHAJKATJ+tjwDC060H8bYcaKgFQX79aUmOCcnyEXcG1guuD9a
         GFH+GubmNhdRfoRTBaI1+MpkvItC0RWd5LFChZxNm7vjv5lMl6GACUXiKSx7WE5w0Vds
         /pnrf5o90psBjQpw5DgCcQHtYY740eir5JW9c0IeYkqZpsADDzBSFy7SmQd9tZckAuAa
         nfJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729125892; x=1729730692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bDVTSiiju+/i8uVx/5igK7HXQnS/pAXMN54tJaymcIs=;
        b=rwb5RIubKq+HT+0VZyiu6yGQ2eklaa93K2qqaQZLfgs4fjqht00NtylcESdMASKOcs
         PwgYhgjrJxbTUncH6Gla/M2EGluZl4zX7kUaq84AcYiHB2KxK7JFCwR+IggT6z1MLK3w
         M0N0+EZm4/T/Y5UMNyYq7WjUrIY6uLeXGBkkVUj6La12PKuCLDAIOeNhkCGa1GQin4sV
         iEaMZEiciZMUkqop0F3rG+FHF6d6D3KHgIekspfEyVaXjDirWXCayGolNUDnR+UXdXAC
         Ab7n0KWHQGwHfM34ENZ/S7IjEXutuKbew0ipueSXqzBiXQFfJZsvkoBhWbsoKKAfNwj0
         mOfw==
X-Forwarded-Encrypted: i=1; AJvYcCXzubwZAbpiXK+kGTW9lYQ5jVeYzo4QTNIah/wJfiu+2Hnps8VN2DhtovqItHZW8X54tXfLE+ZSFDZ5ZE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwunDLyoJBeZu1dNd8QzYunaZY2tNH62nE8vmSB0LfRieAfAhwg
	lhmlg4NUD8hOU6vTR3Gy5qHMb0p5BsSYWVDzes5fD9YTJqLu6urojAUrusSPWTj/cB9HcNqf62F
	V58Q+MbunQtCFjzFotcyYfc+Po0csdVCnxkxe
X-Google-Smtp-Source: AGHT+IHGsHS9kd3lV9IPjVl/ZP3eT/Hgf527JCJgpbosa0wkAa/UhNg9JyYeaHygJfVEjoItGGw850c9B3soz7Ac6tQ=
X-Received: by 2002:a05:622a:1303:b0:45f:7d4:5007 with SMTP id
 d75a77b69052e-4609c8e1a90mr1672431cf.18.1729125891569; Wed, 16 Oct 2024
 17:44:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015231651.3851138-1-mmaurer@google.com>
In-Reply-To: <20241015231651.3851138-1-mmaurer@google.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Wed, 16 Oct 2024 17:44:14 -0700
Message-ID: <CABCJKucRKzMXF-mCxztAgOJxofEGAd33DMC_MHgPBsTmsdJcww@mail.gmail.com>
Subject: Re: [PATCH 00/12] Module Validation Refactor
To: Matthew Maurer <mmaurer@google.com>
Cc: mcgrof@kernel.org, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 15, 2024 at 4:16=E2=80=AFPM Matthew Maurer <mmaurer@google.com>=
 wrote:
>
> Split out from Extended MODVERSIONS Support [1]
>
> This series refactors module validation during loading to ensure that
> everything is checked on its way in. This is intended to make the code
> robust enough that we can more confidently add new pieces like extended
> MODVERSIONS.
>
> [1] https://lore.kernel.org/all/20240925233854.90072-1-mmaurer@google.com=
/
>
> Matthew Maurer (12):
>   module: Take const arg in validate_section_offset
>   module: Factor out elf_validity_ehdr
>   module: Factor out elf_validity_cache_sechdrs
>   module: Factor out elf_validity_cache_secstrings
>   module: Factor out elf_validity_cache_index_info
>   module: Factor out elf_validity_cache_index_mod
>   module: Factor out elf_validity_cache_index_sym
>   module: Factor out elf_validity_cache_index_str
>   module: Group section index calculations together
>   module: Factor out elf_validity_cache_strtab
>   module: Additional validation in elf_validity_cache_strtab
>   module: Reformat struct for code style
>
>  kernel/module/internal.h |   7 +-
>  kernel/module/main.c     | 569 +++++++++++++++++++++++++++++----------
>  2 files changed, 428 insertions(+), 148 deletions(-)

Looks like these patches are unchanged from the pre-split version[1].
For the series:

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

[1] https://lore.kernel.org/linux-modules/20240925233854.90072-1-mmaurer@go=
ogle.com/

Sami

