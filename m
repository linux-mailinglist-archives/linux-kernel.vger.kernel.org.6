Return-Path: <linux-kernel+bounces-300226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAE495E0D0
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 05:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C1B0282616
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 03:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17453D62;
	Sun, 25 Aug 2024 03:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tard5wd2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348AEB647
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 03:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724556592; cv=none; b=jQt0hErxCQu6gc0qNasdPQ7d8sp7S6GtPbwN7yDA9qUjlhZ3WrSexl+BSERv1XQ0epPtRBzq4IDQWByNdg7rm09MPlKCvwo0lldh/xw2t/WGJIfKK0W28w3JWeT/7f6BMoDXyuHfbwUWBh+de3u+utYVZ9obPwS+C10yJUvhmX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724556592; c=relaxed/simple;
	bh=4xLQFMqugB1RpTJGmvAdJwsDVt72hgC3qjvoz1pST8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fdjj1tZYF79+kPaG32p0NvTfFToEikCtztUUM0oIuu7DGTvgEmW3Z07bDwfjFvidStm18pjLJWuaQ6ketdQd4IzlzHthmTKkBgx1aJyRcLDkc628PxSDZoIgcKa9Fz0JsQTnlnN2uv/GIXnP+femPSddD6G0nxZlfAdeA5BykQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tard5wd2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F77C32782;
	Sun, 25 Aug 2024 03:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724556591;
	bh=4xLQFMqugB1RpTJGmvAdJwsDVt72hgC3qjvoz1pST8Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tard5wd2nGNJTdz6lR0jQA+aqKJVfCUuPemaF8G+jaWP5kycYAtSDz3xlOFGAVREw
	 f6w/sxlVfuH9soTJhFbqTYAMa4i8byEwEkTj8/huE7jdiJ8WcnzsLsAAqa4UVyZNK8
	 3bgl/SlMchVy92OoTcnOkgTQDzUNrxby60X1mGl4hhNea+si7CKHcfp81clnCBro/Z
	 TYvoEY2nkB04WzwSc/jYUEtGLHGomAoyfcijFTmAIOO74l3QqVTJlsgsD9NvVbPYpH
	 AwYXW2dir8qzampyVBw8UVWUUymfDdhLcirAClIgS0fpTJ6q0IfORkAyhvb6KkLVCW
	 EK+zNfyNJOadw==
Date: Sun, 25 Aug 2024 05:29:23 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v8 06/13] acpi/ghes: add support for generic error
 injection via QAPI
Message-ID: <20240825052923.715f88bc@sal.lan>
In-Reply-To: <20240819145136.0452ff2b@imammedo.users.ipa.redhat.com>
References: <cover.1723793768.git.mchehab+huawei@kernel.org>
	<2c8970b5d54d17b601dc65d778cc8b5fb288984b.1723793768.git.mchehab+huawei@kernel.org>
	<20240819145136.0452ff2b@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Em Mon, 19 Aug 2024 14:51:36 +0200
Igor Mammedov <imammedo@redhat.com> escreveu:

> > +        read_ack =3D 1;
> > +        cpu_physical_memory_write(read_ack_start_addr,
> > +                                  &read_ack, (uint64_t)); =20
> we don't do this for SEV so, why are you setting it to 1 here?

According with:
https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#generic-h=
ardware-error-source-version-2-ghesv2-type-10

   "These are the steps the OS must take once detecting an error from a par=
ticular GHESv2 error source:

    OSPM detects error (via interrupt/exception or polling the block status)

    OSPM copies the error status block

    OSPM clears the block status field of the error status block

    OSPM acknowledges the error via Read Ack register. For example:

        OSPM reads the Read Ack register =E2=80=93> X

        OSPM writes =E2=80=93> (( X & ReadAckPreserve) | ReadAckWrite)"


So, basically the guest OS takes some time to detect that an error
is raised. When it detects, it needs to mark that the error was
handled.

IMO, this is needed, independently of the notification mechanism.

Regards,
Mauro

