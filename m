Return-Path: <linux-kernel+bounces-562972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AA6A63539
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 12:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3740E16E651
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 11:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B8E1A3150;
	Sun, 16 Mar 2025 11:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7SjcQbP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D6719CC3E;
	Sun, 16 Mar 2025 11:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742123415; cv=none; b=fyDCuGYXtiF35M/KXbJyrDBGBAL9GuwjFsoBuQh+IgBLQlT7sHsavsefvRV/lRqoiwhGjbxwN5ebb4ev7G0g9kgUtoqXeBhRZrpr9dHTDZ2AjjOPT3wUKlW8DEq3USLCwivN4dphtJfrVzLX2CM1G+9W1GJNEHw2k7U6kepZAXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742123415; c=relaxed/simple;
	bh=0PDC8C0gTBkj5wmLeck9baY3eXSFemGyTut/439OrNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YJ3PG2rxzcsoBAhqNN/CYLuwuDOQaOjok7J2v+6jUEzL3bhqj8w9H0iVR4f73Kzw6886hAD110nj2ce8h8ytPvWk+Gqq9pkzgjBWo66qdXoBCw35xyzJhSNvgpZfdQHzMuhD9kjf4j5PkF+IKfQY3svsp7BJ5lOkKtgy58XJ24c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7SjcQbP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD53C4CEEA;
	Sun, 16 Mar 2025 11:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742123414;
	bh=0PDC8C0gTBkj5wmLeck9baY3eXSFemGyTut/439OrNI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=u7SjcQbP5Yi65Flq/P50MssJLKvcvW0Kj7yig+ExWtkEE6vYai1AgrdfSk+ea6BHZ
	 nCHfqGxVbDBE0jjKAWp5VH96cs9+5lfV6o7VWuyzZ332EgC8XmoxtpmVjsdL3ii5px
	 JsDDDJNYp/rgjmZ+ZFrc28+rqeGQ9xCQSFQ5Mu9ubQ0L0IWM7ACqDVZPwpqw2YWAir
	 1C4ga9wUZGCsSXHWvIjbFSWMBxxkkhlCobuNdCBQ3FzPR6BW8ihyvgdndXWTAvzmfr
	 k0FxF3ahq6OIludW4pTKlePbKAkO4SLh4V9IdWFJ0SeqPIeagAIqHiE0ITTDRPhT90
	 7+VSFf41hPbAg==
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3f6ab1b8fc1so2225742b6e.0;
        Sun, 16 Mar 2025 04:10:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVp/V1nJtvHEsLxID4tqb0aw9cmVXHuMZmo+TWz98uX+4Xw95edYSibBGFgDu+TnJKzlKAWrbAqfpgk4jG1Ig==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqLGbp3r8XeZzS90Lc+tNdr8JDwt8HYQ2+ey4jj1Zdm2IRetlE
	XuhFxK06osWXWsgA/M9WQEwt6PQA7P9fZxAkQ50j53h6NNxAJp6gyFiqD2Qtc2kveQQYeSUlLqe
	8hCR4WxKOAbjbkoBDQunQ0zbHoN0=
X-Google-Smtp-Source: AGHT+IEKA9NXgbDXHvzu8iCEbvMJp3lA+yQY4XrI4MCf6p990YzOfAxxojD/oSanLhGXgdRem392hNTa/88RkpE6jgM=
X-Received: by 2002:a05:6808:17a8:b0:3fa:3922:5fbe with SMTP id
 5614622812f47-3fdee55a37fmr5187648b6e.5.1742123413897; Sun, 16 Mar 2025
 04:10:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025031634-playing-lark-95f9@gregkh>
In-Reply-To: <2025031634-playing-lark-95f9@gregkh>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sun, 16 Mar 2025 12:10:01 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iPCuaLfG1ao_LVsGo1n+E5KK5Hz179BtZkz3NvDG5-Ag@mail.gmail.com>
X-Gm-Features: AQ5f1JpcGdkPogNxITYPTCpjZN0sv9namY2P_rB0gBqBIJ5WL9fX4i5gFkQaAOc
Message-ID: <CAJZ5v0iPCuaLfG1ao_LVsGo1n+E5KK5Hz179BtZkz3NvDG5-Ag@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: driver core: mark Rafael and Danilo as co-maintainers
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 16, 2025 at 7:07=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> In talking it over with Rafael and Danilo, it makes more sense for
> everyone to be a maintainer here, to share the load where possible.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0427b32b3688..2f6e379547bd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7101,8 +7101,8 @@ F:        include/linux/component.h
>
>  DRIVER CORE, KOBJECTS, DEBUGFS AND SYSFS
>  M:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> -R:     "Rafael J. Wysocki" <rafael@kernel.org>
> -R:     Danilo Krummrich <dakr@kernel.org>
> +M:     "Rafael J. Wysocki" <rafael@kernel.org>
> +M:     Danilo Krummrich <dakr@kernel.org>
>  S:     Supported
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-c=
ore.git
>  F:     Documentation/core-api/kobject.rst
> --

