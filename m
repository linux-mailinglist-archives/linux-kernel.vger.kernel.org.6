Return-Path: <linux-kernel+bounces-545333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0195BA4EBC0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6B36189500A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0E2255249;
	Tue,  4 Mar 2025 18:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHt35s6t"
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2548205E20
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741112442; cv=pass; b=AC5sAilJZu9TOrq0t3UcU9law6WKO+tb0qJizXA8B8M3FGbjJHKdQvKx/jtyWnM6ysaAevNf0U4lMn8q5tR5MrJG2nwjKedmpca1L7O8AC060xshXx34oVUtDYPJ3eI7X4o5nwgDhQ8VoasOBz5TdnAmbszfyk4IUO7XCI0eUjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741112442; c=relaxed/simple;
	bh=oQAhDNZZHIdM8IkJONvRddVJgR3R9DzHAQ1ARr50o4w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vEm5MSF8oSapyG/Hjgfzn9k2bJgcy6rZ6LO/IwfLoGN0JRDJRKynxARQXUL+miuNOVd8kJeRS6BeSulUH/Ovzlc9CoBaT8BEMCTATRp73W/vyO3qAb/5IO4ucCguGEPXMrqgkhDsjEQoqeXlmcOVJj55SpSxQBeTEEr7S2Tr91w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHt35s6t; arc=none smtp.client-ip=10.30.226.201; arc=pass smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id F027940D047C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 21:20:38 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6fjr1lLrzG0KZ
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:29:20 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id B251542720; Tue,  4 Mar 2025 18:29:13 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHt35s6t
X-Envelope-From: <linux-kernel+bounces-541645-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHt35s6t
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 75FA4423FC
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:55:50 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 2A9B8305F789
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:55:50 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8704616C57C
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A28D20D4E3;
	Mon,  3 Mar 2025 11:54:23 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B3220CCE6;
	Mon,  3 Mar 2025 11:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002860; cv=none; b=NGP2qCJjl2C8JvrNAKP3sTKANne46NqJ+flgooEvKiYQ0JVSh4t7v3YqmsEsKotmP2gzpm2xUr0q0C5wnr/clueJT24x6WMjJQvkmB+n474pch7V23GKnCTTH44HTvcdrrVrOQZb4uqp1ISAUGOEgGGKeKM2fa6FbXdbOC/YoB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002860; c=relaxed/simple;
	bh=oQAhDNZZHIdM8IkJONvRddVJgR3R9DzHAQ1ARr50o4w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QZBzZZsXNX/g6ZRfh/b5W4Bp4KlvYCZEKVrngxipYIRgddsGyMDIadT7Q7ZvdhsPpZp/cdbV2db2yPzZ0elmyivcoXL/kPXZHINcZb8ayLo6zNoCWfwHCtJLJFN9rfXVc6e3Rir5l8ExPU1tvne0gF8i94/+G18LjssB85zwW3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHt35s6t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 505B4C4CEE8;
	Mon,  3 Mar 2025 11:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741002860;
	bh=oQAhDNZZHIdM8IkJONvRddVJgR3R9DzHAQ1ARr50o4w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=YHt35s6t01Ze5P7mJ3/0Qr824U8rW/eB3bCnSoYVjbseNMmDzgtsKkKlK26uYT3ib
	 TItoFMKSD+C98d4zTtNDgaYFEZOAsNeCnE3UZwi1Mns9O4bMEPFjJOtUeAD056oXBM
	 NobX724F5a/rAmOcUCWa7FwrliPpSnk8RSRSmvQnjqWA/tzD/iv9susiJnNjFF98Qe
	 nr6ybnyOfDWXGMyAmFMd7+YBQrmc+fm0PChhtHZD5tY8j1ViMUBbNPB0WWOKCXND8C
	 9ykLjojN6i03Bf4cBGCt3mhQZHo2S8J48GvvETucW/trH9vVNmGTO/HfyufhfJdwo3
	 gPAkVdCeLnC0Q==
Message-ID: <f5ab160dadc2219b9576e50588dce88f22e9bcb1.camel@kernel.org>
Subject: Re: [PATCH] virtio: console: Make resizing compliant with virtio
 spec
From: Amit Shah <amit@kernel.org>
To: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, brueckner@linux.ibm.com, 
	schnelle@linux.ibm.com, pasic@linux.ibm.com
Date: Mon, 03 Mar 2025 12:54:16 +0100
In-Reply-To: <20250225092135.1200551-1-maxbr@linux.ibm.com>
References: <20250225092135.1200551-1-maxbr@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6fjr1lLrzG0KZ
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741717127.91863@iczvlgiyH+CBF1U76iIjew
X-ITU-MailScanner-SpamCheck: not spam

On Tue, 2025-02-25 at 10:21 +0100, Maximilian Immanuel Brandtner wrote:
> According to the virtio spec[0] the virtio console resize struct
> defines
> cols before rows. In the kernel implementation it is the other way
> around
> resulting in the two properties being switched.

Not true, see below.

> While QEMU doesn't currently support resizing consoles, TinyEMU

QEMU does support console resizing - just that it uses the classical
way of doing it: via the config space, and not via a control message
(yet).

https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/char/virtio_console.c#n1787

https://lists.nongnu.org/archive/html/qemu-devel/2010-05/msg00031.html

> diff --git a/drivers/char/virtio_console.c
> b/drivers/char/virtio_console.c
> index 24442485e73e..9668e89873cf 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -1579,8 +1579,8 @@ static void handle_control_message(struct
> virtio_device *vdev,
> =C2=A0		break;
> =C2=A0	case VIRTIO_CONSOLE_RESIZE: {
> =C2=A0		struct {
> -			__u16 rows;
> =C2=A0			__u16 cols;
> +			__u16 rows;
> =C2=A0		} size;
> =C2=A0
> =C2=A0		if (!is_console_port(port))

This VIRTIO_CONSOLE_RESIZE message is a control message, as opposed to
the config space row/col values that is documented in the spec.

Maybe more context will be helpful:

Initially, virtio_console was just a way to create one hvc console port
over the virtio transport.  The size of that console port could be
changed by changing the size parameters in the virtio device's
configuration space.  Those are the values documented in the spec.=20
These are read via virtio_cread(), and do not have a struct
representation.

When the MULTIPORT feature was added to the virtio_console.c driver,
more than one console port could be associated with the single device.
Eg. we could have hvc0, hvc1, hvc2 all as part of the same device.=20
With this, the single config space value for row/col could not be used
for the "extra" hvc1/hvc2 devices -- so a new VIRTIO_CONSOLE_RESIZE
control message was added that conveys each console's dimensions.

Your patch is trying to change the control message, and not the config
space.

Now - the lack of the 'struct size' definition for the control message
in the spec is unfortunate, but that can be easily added -- and I
prefer we add it based on this Linux implementation (ie. first rows,
then cols).

But note that all this only affects devices that implement multiport
support, and have multiple console ports on a single device.  I don't
recall there are any implementations using such a configuration.

... which all leads me to ask if you've actually seen a
misconfiguration happen when trying to resize consoles which led to
this patch.

		Amit


