Return-Path: <linux-kernel+bounces-326031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9948D976189
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 08:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60AC62829A5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 06:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97463189536;
	Thu, 12 Sep 2024 06:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="WKoZvoyg"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0571146A6F
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 06:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726122688; cv=none; b=GzuEm79WGkIw+zGbvB6DZiANsh7T1/iJ0WwGfbkRZj/KyEzxi9+/A3ub19MJX0WXkXkQIB6bK8N3my1x82DHGwxhamuK5IfkDoQVqomjCRm/1HW4irl7UmuVGWOYNQVwrnil3rt001X8uMu0DRJJKWLqJ++NJOZisc2bD5L0Oc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726122688; c=relaxed/simple;
	bh=pz7lmaCixmDU8jWsNlE+WokwdONvJ+P9anNkfWDN5Ew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iPjFhe0ATu2qTbFhF0X4I8rrWgyZyDRpLgweqZY5PeSucg3NpCsy5DNfk+o7Bs4n/+SreHXJGY1VS7pAq8bcwu9IrP0wq7XQvpqEFOInyVgpjR4RHgBXapx11C58qdnj01AYiDUeYm5Qff+AKhWFM3TblA+y43R8m6DqGrotLEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=WKoZvoyg; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6db449f274fso5001477b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 23:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1726122685; x=1726727485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VLqRk9xs0Z8USD34uHyus8ov3Zx+G/NGqLFegF19mAE=;
        b=WKoZvoygVK38SGFLWU5f6jRWtxmEaqTl1mFlyAVpaqqcmXaqQ4bh/gENk5PvTORPdF
         dlfgm4L7rMBWeYm3xpJOEPx7twISPN+RdpX7tQ56/5hy/aHJ4E/C+oM42iqQqeuFnPFb
         uNRUA3+KcVx1D1IEZ5ffJVVVpMH8lDOjnaZrHeu1Z1uEAuIx6BVZec6iSC7DBavnPRE0
         K6wNDB6JUKdTcNWUsC0yYYQu/rKzSjHC3rJA9o1xYEKKfBwkxjh0giBrf0g/v9N4ZOIh
         /MA77mxO1f9BVwUsVbnd+qEjfb6xSjtd6o0vQq7Vo2fqUWH2kOuGEb7FW3VRcITvB/fH
         XAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726122685; x=1726727485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VLqRk9xs0Z8USD34uHyus8ov3Zx+G/NGqLFegF19mAE=;
        b=QceYmGzpgGavkgeIWRUzajFLK18ndYtCh5Ph7jIZ/nxppKcs6qrqCtSQDLmSyHZAh5
         uvkcm026PyJmIwxyZXUe7nZ+0NqPdxU1lzpqxVsR5h1zCurl2i9/IeQK+Ew7no/0J5i6
         OQGOAFcshqo2ltUSSRp3NzXOAP/yX/me7nCYCb1FCtQJo2byaWvHt7YBvqYBNFCNMe7O
         4iF3d59xndZP18V/Jg+jiYKcQd3jPYMPJtdscwUSfxFd2jOFOstOylSEFJg5g1m5Vt3N
         uwfbY6cR19Y2028rG2xKiFbzDf0ZrhAbxtsJTWgDCNfhlGjMN4orxZcCwsI7YxkulLBn
         LCnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfu0oa8Q1kE3tbdgp5V4rBN7OM5UcIU/R+YH+P8dhg0qiptGuj/mSdtlTQMuBa0bBs2nagZ8G1bLDrMBk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx94Pn8fpQHP/tmoDl9i0SPmF2PJoiQwlLfZ7KUzgmQvyst/d7p
	0hFygAPtcTnw1Q7rXK9Bh8EcHPi1rEyFts7t5BYVVmAMPbYL5B9/fc4yN63DrNpWikLrRtIVsvg
	BC51tCkT0+Kh4wFfYb931xSyR92W0HyOUd+so4w==
X-Google-Smtp-Source: AGHT+IH4kBB8JN2cgcgO3jywYmXVWr3Ng49Lv24oVaKiZ9IuWZORUke+o0pxGQVji/XNXO5oMFwy9ZkLUHYHtIhC4S4=
X-Received: by 2002:a05:690c:f0f:b0:643:92a8:ba00 with SMTP id
 00721157ae682-6dbb69c3024mr19417697b3.0.1726122685709; Wed, 11 Sep 2024
 23:31:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
 <20240911062511.494855-21-patrick.rudolph@9elements.com> <CAFLszTgYrEk=UBd6zgesphC+rLPtkOG4fjBOYaGRQXYLNUomyA@mail.gmail.com>
In-Reply-To: <CAFLszTgYrEk=UBd6zgesphC+rLPtkOG4fjBOYaGRQXYLNUomyA@mail.gmail.com>
From: Patrick Rudolph <patrick.rudolph@9elements.com>
Date: Thu, 12 Sep 2024 08:31:14 +0200
Message-ID: <CALNFmy3cDCTzppfr5y=sAjKn0eBKsHPq9LD4zGg0KC9HT3qNMA@mail.gmail.com>
Subject: Re: [PATCH v3 20/30] drivers/arm: Implement acpi_fill_madt
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, linux-kernel@vger.kernel.org, 
	Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 2:58=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Patrick,
>
> On Wed, 11 Sept 2024 at 00:25, Patrick Rudolph
> <patrick.rudolph@9elements.com> wrote:
> >
> > Fill the MADT table in the GIC driver and armv8 CPU driver to
> > drop SoC specific code. While the GIC only needs devicetree
> > data, the CPU driver needs additional information stored in
> > the cpu_plat struct.
> >
> > While on it update the only board making use of the existing
> > drivers and writing ACPI MADT in mainboard code.
> >
> > TEST: Booted on QEMU sbsa using driver model generated MADT.
> > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > Cc: Simon Glass <sjg@chromium.org>
> > ---
> >  arch/arm/lib/acpi_table.c |  1 +
> >  arch/arm/lib/gic-v3-its.c | 89 ++++++++++++++++++++++++++++++++++++++-
> >  drivers/cpu/armv8_cpu.c   | 27 ++++++++++++
> >  include/cpu.h             | 27 +++++++++++-
> >  4 files changed, 141 insertions(+), 3 deletions(-)
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> Are the GIC values available by probing, or are they just 'known', and
> dependent on the compatible string?
Sorry I don't get that question.

The "arm_gic_v3_its" and "arm_gic_v3" driver uses existing DT
properties and should work with all existing boards.

The madt_gicc entries are board specific. Besides the mpidr all of
them can be 0.
Those entries currently do not have matching DT properties in the CPU
node that could be used.
Some of those entries are present in the GIC node, but there's no
direct association between CPU nodes and GIC nodes.

>
> Regards,
> Simon

