Return-Path: <linux-kernel+bounces-343088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7622098969F
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 19:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98F9E1C2105B
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 17:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078F542056;
	Sun, 29 Sep 2024 17:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="fYxSDrF7"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3952B2E3EE
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 17:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727631355; cv=none; b=etz1NdKuJB2L77zUVvw/TBMueoYvwmXQ62PxQ/yrhNUw6Sb7/6/CdtT0Thj02HxpMnTpqk/X4+SQFz0Ahi8NRRVPG/XDCQmgPVmOM5oLFcq9IZIjmzM95NL1PGMgOoU7aJMRsgbxcxGqBqpQtUI/uLq22qtG+q5bYCjxSMXhzEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727631355; c=relaxed/simple;
	bh=7FJYoAf4UNnJsGqA3YqqHhA0Hb//TkkxwczcqdaRjo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=THVops9WMsRzx2fa2h84ifeYf8WltSS1tcurafYbrxrL0FSETRHQKk0qjs7giQqTNJ/AwOc+KueXqPah8r1KdlXRF6K1rhPoVs4zZTjtsZ3Txmqh0GTjnmYAk014JIxDBUvrC5EDwzv82rbIH8LXsRBJMXhOlwOZeoXnv10ry2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=fYxSDrF7; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7E17D3F5E4
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 17:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1727631349;
	bh=Rl/pS/wt7QkZsPdEO+ufS/ZfVUHdqAefjBl7pvxI0CY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=fYxSDrF7mpS9t1g7O6pChWQ0In0dCf+fRJGGGeFKWsrqlyFQEK0ASqj9vqlf9EKY2
	 s1wNoY66Z2DW8ax9x40Z9Y32FM06xoJyGalHJdVppmuQz4oxDF7pFHU3fM6cQdwZGp
	 5ARdAkxeGO4HqaV9Q3U5F0DdpNoGaykeha9bqZyPtGt2fnkqvamtZsmW4GJs+x81fa
	 tmNnXyPxpdfzJLrrGdsd42P4go5dxzEdsPLAgtpTzA878QSzou0wTeT7pLROZOH1Lu
	 XdbGOy0kBmwIHmixg0T7s28yUj+JX9fhRmZdggkQ+ZmZjN/oXNDELfMnT5dXEP84yw
	 rP6tLWbRzCTHg==
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-498d181bfaeso810514137.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 10:35:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727631348; x=1728236148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rl/pS/wt7QkZsPdEO+ufS/ZfVUHdqAefjBl7pvxI0CY=;
        b=T+Qx1BKkozPdjo9uHxXR4zgAk1SoFmrYX7VobeMt0OYHyvXPtfuROcH20K2vzXHtS4
         lggsk7tm+3XB6N26ZGqwOgWxfU0N5Cn4AmyNbxjx9ygSVSBT4aTuBaAI9yQTX5XrpDI/
         Nwe/kbY6oxCKwMfoFuTHrWW9Q78YfHvblM2r2zpkzjG2spyWe0+Gb4CDqKug+5kiWUIx
         nfGYf3sqfQ6H8Us1czlF1TBH0ulRFqT8QplHa/ocGo5OIi9Q22DB+0ioh8OY7XFCDXFd
         XTVpIBEhqd61sqwROZv+BVbH8SsAJXfEhiZLy18vw6NZxazCpG4WCN5NAcj6i/Pip8oU
         hPzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXpFdc9A6XG1mKf06B44y7qdV2VMKlPfAA476lwwDPG7bGEeFqr9p0cKqPk7caskeAD7aD3s2vWQabi/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVOuasFU2AE0+ROOM1D2rwLAdaEdPxMrX1KV4BkIrrrIeJ+DpJ
	PCdZXTsQVLLAM6w8lGARei8I4KLCL4WnPNPFdaW1AHWD3VvahzMGPstIcbGscmpCLXgWlt0D9ml
	fZjaWr/ptd3XpMSLDs9wC4QfHlpUR3sGAc6Q1nFMWg223vMZfV6eC3wjtMQ749BrBZx6yt/zoH4
	h3df9qHWV1B0Q93mw90/V566dVfXeFqaKzlPMw0T361tq0TU15c0Jc
X-Received: by 2002:a05:6102:3909:b0:4a3:c48a:6d with SMTP id ada2fe7eead31-4a3c48a072amr568328137.7.1727631347977;
        Sun, 29 Sep 2024 10:35:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGumyMX+ocvMCel4pVMoToxGxjM87jX1L3K8ElBWypvEO0i4r1+ozb3p2pk+hDYSgoZzgLzkpNtCwVQexZ4Wy8=
X-Received: by 2002:a05:6102:3909:b0:4a3:c48a:6d with SMTP id
 ada2fe7eead31-4a3c48a072amr568306137.7.1727631346626; Sun, 29 Sep 2024
 10:35:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926161641.189193-1-aleksandr.mikhalitsyn@canonical.com> <20240929125245-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240929125245-mutt-send-email-mst@kernel.org>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Sun, 29 Sep 2024 19:35:35 +0200
Message-ID: <CAEivzxdiEu3Tzg7rK=TqDg4Ats-H+=JiPjvZRAnmqO7-jZv2Zw@mail.gmail.com>
Subject: Re: [PATCH] vhost/vsock: specify module version
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: stefanha@redhat.com, Stefano Garzarella <sgarzare@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 29, 2024 at 6:56=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Sep 26, 2024 at 06:16:40PM +0200, Alexander Mikhalitsyn wrote:
> > Add an explicit MODULE_VERSION("0.0.1") specification
> > for a vhost_vsock module. It is useful because it allows
> > userspace to check if vhost_vsock is there when it is
> > configured as a built-in.
> >
> > Without this change, there is no /sys/module/vhost_vsock directory.
> >
> > With this change:
> > $ ls -la /sys/module/vhost_vsock/
> > total 0
> > drwxr-xr-x   2 root root    0 Sep 26 15:59 .
> > drwxr-xr-x 100 root root    0 Sep 26 15:59 ..
> > --w-------   1 root root 4096 Sep 26 15:59 uevent
> > -r--r--r--   1 root root 4096 Sep 26 15:59 version
> >
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.c=
om>
>
>

Dear Michael,

> Why not check that the misc device is registered?

It is possible to read /proc/misc and check if "241 vhost-vsock" is
there, but it means that userspace
needs to have a specific logic for vsock. At the same time, it's quite
convenient to do something like:
    if [ ! -d /sys/modules/vhost_vsock ]; then
        modprobe vhost_vsock
    fi

> I'd rather not add a new UAPI until actually necessary.

I don't insist. I decided to send this patch because, while I was
debugging a non-related kernel issue
on my local dev environment I accidentally discovered that LXD
(containers and VM manager)
fails to run VMs because it fails to load the vhost_vsock module (but
it was built-in in my debug kernel
and the module file didn't exist). Then I discovered that before
trying to load a module we
check if /sys/module/<module name> exists. And found that, for some
reason /sys/module/vhost_vsock
does not exist when vhost_vsock is configured as a built-in, and
/sys/module/vhost_vsock *does* exist when
vhost_vsock is loaded as a module. It looks like an inconsistency and
I also checked that other modules in
drivers/vhost have MODULE_VERSION specified and version is 0.0.1. I
thought that this change looks legitimate
and convenient for userspace consumers.

Kind regards,
Alex

>
> > ---
> >  drivers/vhost/vsock.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> > index 802153e23073..287ea8e480b5 100644
> > --- a/drivers/vhost/vsock.c
> > +++ b/drivers/vhost/vsock.c
> > @@ -956,6 +956,7 @@ static void __exit vhost_vsock_exit(void)
> >
> >  module_init(vhost_vsock_init);
> >  module_exit(vhost_vsock_exit);
> > +MODULE_VERSION("0.0.1");
> >  MODULE_LICENSE("GPL v2");
> >  MODULE_AUTHOR("Asias He");
> >  MODULE_DESCRIPTION("vhost transport for vsock ");
> > --
> > 2.34.1
>

