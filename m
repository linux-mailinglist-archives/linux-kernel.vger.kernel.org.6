Return-Path: <linux-kernel+bounces-201483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE858FBEEE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 00:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BD8F2879A0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 22:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8F014C5A0;
	Tue,  4 Jun 2024 22:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1zUDT/p"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E292B14B97F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 22:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717540158; cv=none; b=hlK0WbyJI48CWBDdERWqhtkmPdvzfRB7rvqqiQedbSBCXyV0doUicqIK1KySNSg8m+drPHRrmAQEy0uxn9rW8XLXJ9gCSmT/C7PHkXxY+m3He8oTc0WVgJVHgJkXQyeO053ukZ+oHOgWWzyQ9qAfJ8LUwKrNr0ya1YyjmydNKoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717540158; c=relaxed/simple;
	bh=5jbZaRhnMJPW1tcuh8F+0dQdkhJQQKzpxeeSaP6I6gE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k7wyqaZ2DBtI1Y75Dg+m+3vpc41kNzEIORiWbrDX0QAsrxKAKQLZM+ME4G9xgtjwVKTkrj0ZyRyNk8+DAqFNbFn2hoWp9yS6Fcn+H4/QPX9/a7Ebs3k1/uiasKwDTE7UbXGflneHrm21VqfH22lMYkGqHgBumBFx82XmeqwuDXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1zUDT/p; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a68ca4d6545so56901466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 15:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717540155; x=1718144955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqM2hxS4FR6EOD/ApBIrT8QZc14gXJNY9tub2xlKA5E=;
        b=f1zUDT/p51xWkelOHdYFEGQoMy5VU2TWPDpPXL/l2AB0nVNB9fiN/9qD+pVgbsra1e
         ipnLGbJREaFnSVI8lT5wOKm/RnYKKLiLFlQevmufjFceK9dEHGYrJxZuK7mr7BKCtqIS
         0g+wRp7cN4iAY+mnh6DYqkpnCxjcWpbrACER1fNSaE4PBRDPp95sVa87n8jJxETVj1pN
         vv0c8+ZoYVBiXaMkCGpBT/vnrX/KgHEhovarkSsF5pwg/c+a+kwZ8tcJUYFYECP7dXFD
         0Zcr6YwE+C1I3kFcUKYjYfg6xEJvOVzzxMIDGoQwC3Alv6ZfitwI4ndqoA+R48GQRb3g
         whcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717540155; x=1718144955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GqM2hxS4FR6EOD/ApBIrT8QZc14gXJNY9tub2xlKA5E=;
        b=BHo/DLWhSNANp9JW6drB/hP988sNhvnulm1cyvvfiX9WibtjluBCitXKMS3NXPAqfz
         2dvy1pcAHADTyv9uA0mlChS9h/YDxWB0XRPa67kh+LspGtefUbjIMcG5ZIl412h2yxt3
         AMX9XxIh8fsHv8gb7MxsWDcgKdwTQbqvROx1dcNsYoksRMJXf68fJ921eS6tABkYKvqE
         boQJOFSaMmg6VH9jjY2a8U4bbL++W3acK+q/hMCWbprfDrvLnl5nNV4Slkk1oWtCwQDU
         J0iKhjtfF8JkE6loqtk9EDkqjjaB1aJWMoIgPRPR+YmylAwD/LauoVtMYBfz+XEdm/qq
         Iy+g==
X-Forwarded-Encrypted: i=1; AJvYcCUVZOUMU8adJUrB9M128xAzY+leKlP+a4ugkWjXe/3hXtfS4YRaXHfYRzTdA1aqCFhsM8EfaYYq5aQNMSkN/tyyTHX8GzRJ9VfotM4n
X-Gm-Message-State: AOJu0YzDHoN7+QQil7qBIFPN9Px7rIXlm/tNY8EzV5EOJICpcHYMKRwl
	9ml6xupp7lGVYRodhcpS9M9JXLwPDfJmZHQBZ2jRtLZQyXWZAcUVgztcXaHHgKgZrFvOT/PY/ym
	JUyZwJzVmMuZSTrqLCDP5OevUCcVDRw==
X-Google-Smtp-Source: AGHT+IHIe8oojZHH3BSc04qDCY6rnCKtmhfue3eiADcCFUkd8n3J7o617bnUH1b9t9siCp6QOzcAxh569eqIcgKG92w=
X-Received: by 2002:a17:907:8f0a:b0:a68:f43c:57dd with SMTP id
 a640c23a62f3a-a699d63f681mr58766666b.23.1717540154999; Tue, 04 Jun 2024
 15:29:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240602190959.2981-1-thomas.hellstrom@linux.intel.com>
In-Reply-To: <20240602190959.2981-1-thomas.hellstrom@linux.intel.com>
From: Dave Airlie <airlied@gmail.com>
Date: Wed, 5 Jun 2024 08:29:03 +1000
Message-ID: <CAPM=9ty=EMpFTumUCeAcHzn7j2Trs6r3_46jEvo_-CzPmAXcyg@mail.gmail.com>
Subject: Re: [PATCH v2] MAINTAINERS: Update Xe driver maintainers
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: intel-xe@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Lucas De Marchi <lucas.demarchi@intel.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Acked-by: Dave Airlie <airlied@redhat.com>

Please merge through xe-fixes

Dave.

On Mon, 3 Jun 2024 at 05:13, Thomas Hellstr=C3=B6m
<thomas.hellstrom@linux.intel.com> wrote:
>
> Add Rodrigo Vivi as an Xe driver maintainer.
>
> v2:
> - Cc also Lucas De Marchi (Rodrigo vivi)
> - Remove a blank line in commit the commit message (Lucas De Marchi)
>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> Acked-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Acked-by: Lucas De Marchi <lucas.demarchi@intel.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 572be0546e21..8f9982c99257 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11037,6 +11037,7 @@ F:      include/uapi/drm/i915_drm.h
>  INTEL DRM XE DRIVER (Lunar Lake and newer)
>  M:     Lucas De Marchi <lucas.demarchi@intel.com>
>  M:     Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> +M:     Rodrigo Vivi <rodrigo.vivi@intel.com>
>  L:     intel-xe@lists.freedesktop.org
>  S:     Supported
>  W:     https://drm.pages.freedesktop.org/intel-docs/
> --
> 2.44.0
>

