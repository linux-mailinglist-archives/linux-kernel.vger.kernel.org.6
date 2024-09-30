Return-Path: <linux-kernel+bounces-344508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 787BD98AA89
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 19:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0278D1F22400
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7036BFCA;
	Mon, 30 Sep 2024 17:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="T7m7ADgb"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E802B9A5
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 17:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727715851; cv=none; b=bQYREnjuapY2RASzX2C6Ru/sVgoDBSySDPkimaCKLbRaKoycuuZlRf42ufKuiXUaS6/Rn6cX9YEf0LVm29EHVxdX4raIDNfOLTeBu/cJbdmbIV28NbqWdFCCpPI2Rh/0mNG+vbppfWOdQ6Be8/q3bA68J86cp97vi0RbGW+1Gew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727715851; c=relaxed/simple;
	bh=Hxy5RRz3ZDbul6zT6nM1wJ24XgbC59beRrdTOnK6vH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aRe60PQ61MO9wN0f4JGBe+2GkcabAuZ7UoWLFt6VavXmmmWialhl6jSetFcWtVQqz/t5WzFZ9iC0OEe4zDO2vwfrtdzTvrL+UibVc9LDuVn/jvxqBlG/w3Lvr6Iv5VTSv8eIaPdU89wDq3HXYhEWEptoedmQ4PT4SIk9HO/ab1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=T7m7ADgb; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7AFBB3FDF0
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 17:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1727715845;
	bh=uCq97dcBwspUfA12XvnHz7wkL3yN6ZAbWmU3HPjeKvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=T7m7ADgb4MitXj+Zs9Dk7wDPbb2SS9YzRH+RhPdUYF56kUbnuhA4OKqw13PT3EFVb
	 Yw7BrIpYiuQcHFxQJiEe8pwVhquqjlk5O7Zp0l9cpR7Q86Jy8Nl4wHKvYxYZf7zCX7
	 +okTr3BxOH1zkZIYODG1cIs6LGqzygOSMr33kzkD8w8ICntiytFKXvx3smXD47jHXj
	 8ToN8YTlGNFGb4rH+LzrPj8e/RBGemf+mX5fg8vIW7Qr/vzISYIBgOdj3JAfga74Ef
	 e0IgoKIv01zv7syoBoTwZOP0naSaTYKK41Kg1ihvbo/79fViKWq9J989ZQb0gdsG0n
	 Kd1UmpWI0Y1dA==
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-50a3fbf5278so1275961e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 10:04:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727715844; x=1728320644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uCq97dcBwspUfA12XvnHz7wkL3yN6ZAbWmU3HPjeKvM=;
        b=OnVatQ10z+5wJgyG0jALYjgYxTLKok/BL7l0ZXYbxN8fCHWnPNfm0ZHRvGDY3tn5US
         UfDklWmpUmvhleuADkoiBmiWGD4l3KZyVGEDDpTpWvwBIebaG6t5twahrd2kESscRY4b
         1EW2tW5XqtQBVshmK4q1N2gHPSGhngm73S4NLMVbr9iOq+o9JYpTkFqlqtynNA87RJX8
         QXXgVFJEBYl7iHOZY9ucfxXTalncIHxCtsWPrfXD1+zweTPmdcAGjC/HHDtkxQFjfYJG
         mWYhh6x6bpCLK/0mHVzN1z4IyGW18nwQEm29BjDqVINdmkpA7TsGE9iQioRum8sXFFDE
         zMew==
X-Forwarded-Encrypted: i=1; AJvYcCXzR0zmFlY/Ct6Pl+/7tyZwM/eR58dMXzSOT2zuz5QIGaXmoaqr1PeU6UsJWXUx+z8aMEKYYDMOhqBD424=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr7EXue8xxoAx4VypaVeRj7HRPf+OMHbYJRGFCcRh4rqj8NU6E
	HuEnKbrZUAslU0qfyrvqdNzDxVM98Lyb7P5Cc1pOrb/yu+iAoNYmUSvegGxpXK6XO4fEWPaFyZK
	J7lcvUgiCV5x7UL4iY3/X3ZirEIoV6zFYewH6CEM1Qi35uBCewt4KKYNO1AjRxeOVeEVghoJKce
	BhewyqwYOLYPHOGA2PlRXkWQ7wDcpfLmci1XrfZxveV7yO5I/m+ih0GQCI8u0wRRo=
X-Received: by 2002:a05:6122:d0f:b0:507:a6a3:6d7 with SMTP id 71dfb90a1353d-50ad3b8cffdmr397273e0c.1.1727715843963;
        Mon, 30 Sep 2024 10:04:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEI10r0Myyi5Nwjiwg4H3fq4K1wjxeTVvrkOnj6DDSqCblFOLZtzteahkiAAEq+1E70tbSFfRQUqLdEHoDATvY=
X-Received: by 2002:a05:6122:d0f:b0:507:a6a3:6d7 with SMTP id
 71dfb90a1353d-50ad3b8cffdmr397203e0c.1.1727715843469; Mon, 30 Sep 2024
 10:04:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240929182103.21882-1-aleksandr.mikhalitsyn@canonical.com>
 <w3fc6fwdwaakygtoktjzavm4vsqq2ks3lnznyfcouesuu7cqog@uiq3y4gjj5m3>
 <CAEivzxe6MJWMPCYy1TEkp9fsvVMuoUu-k5XOt+hWg4rKR57qTw@mail.gmail.com> <ib52jo3gqsdmr23lpmsipytbxhecwvmjbjlgiw5ygwlbwletlu@rvuyibtxezwl>
In-Reply-To: <ib52jo3gqsdmr23lpmsipytbxhecwvmjbjlgiw5ygwlbwletlu@rvuyibtxezwl>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Mon, 30 Sep 2024 19:03:52 +0200
Message-ID: <CAEivzxdP+7q9vDk-0V8tPuCo1mFw92jVx0u3B8jkyYKv8sLcdA@mail.gmail.com>
Subject: Re: [PATCH v2] vhost/vsock: specify module version
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: kuba@kernel.org, stefanha@redhat.com, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mcgrof@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 5:43=E2=80=AFPM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> Hi Aleksandr,
>
> On Mon, Sep 30, 2024 at 04:43:36PM GMT, Aleksandr Mikhalitsyn wrote:
> >On Mon, Sep 30, 2024 at 4:27=E2=80=AFPM Stefano Garzarella
> ><sgarzare@redhat.com> wrote:
> >>
> >> On Sun, Sep 29, 2024 at 08:21:03PM GMT, Alexander Mikhalitsyn wrote:
> >> >Add an explicit MODULE_VERSION("0.0.1") specification for the vhost_v=
sock module.
> >> >
> >> >It is useful because it allows userspace to check if vhost_vsock is t=
here when it is
> >> >configured as a built-in.
> >> >
> >> >This is what we have *without* this change and when vhost_vsock is
> >> >configured
> >> >as a module and loaded:
> >> >
> >> >$ ls -la /sys/module/vhost_vsock
> >> >total 0
> >> >drwxr-xr-x   5 root root    0 Sep 29 19:00 .
> >> >drwxr-xr-x 337 root root    0 Sep 29 18:59 ..
> >> >-r--r--r--   1 root root 4096 Sep 29 20:05 coresize
> >> >drwxr-xr-x   2 root root    0 Sep 29 20:05 holders
> >> >-r--r--r--   1 root root 4096 Sep 29 20:05 initsize
> >> >-r--r--r--   1 root root 4096 Sep 29 20:05 initstate
> >> >drwxr-xr-x   2 root root    0 Sep 29 20:05 notes
> >> >-r--r--r--   1 root root 4096 Sep 29 20:05 refcnt
> >> >drwxr-xr-x   2 root root    0 Sep 29 20:05 sections
> >> >-r--r--r--   1 root root 4096 Sep 29 20:05 srcversion
> >> >-r--r--r--   1 root root 4096 Sep 29 20:05 taint
> >> >--w-------   1 root root 4096 Sep 29 19:00 uevent
> >> >
> >> >When vhost_vsock is configured as a built-in there is *no* /sys/modul=
e/vhost_vsock directory at all.
> >> >And this looks like an inconsistency.
> >> >
> >> >With this change, when vhost_vsock is configured as a built-in we get=
:
> >> >$ ls -la /sys/module/vhost_vsock/
> >> >total 0
> >> >drwxr-xr-x   2 root root    0 Sep 26 15:59 .
> >> >drwxr-xr-x 100 root root    0 Sep 26 15:59 ..
> >> >--w-------   1 root root 4096 Sep 26 15:59 uevent
> >> >-r--r--r--   1 root root 4096 Sep 26 15:59 version
> >> >
> >> >Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical=
.com>
> >> >---
> >> > drivers/vhost/vsock.c | 1 +
> >> > 1 file changed, 1 insertion(+)
> >> >
> >> >diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> >> >index 802153e23073..287ea8e480b5 100644
> >> >--- a/drivers/vhost/vsock.c
> >> >+++ b/drivers/vhost/vsock.c
> >> >@@ -956,6 +956,7 @@ static void __exit vhost_vsock_exit(void)
> >> >
> >> > module_init(vhost_vsock_init);
> >> > module_exit(vhost_vsock_exit);
> >> >+MODULE_VERSION("0.0.1");
> >
> >Hi Stefano,
> >
> >>
> >> I was looking at other commits to see how versioning is handled in ord=
er
> >> to make sense (e.g. using the same version of the kernel), and I saw
> >> many commits that are removing MODULE_VERSION because they say it
> >> doesn't make sense in in-tree modules.
> >
> >Yeah, I agree absolutely. I guess that's why all vhost modules have
> >had version 0.0.1 for years now
> >and there is no reason to increment version numbers at all.
>
> Yeah, I see.
>
> >
> >My proposal is not about version itself, having MODULE_VERSION
> >specified is a hack which
> >makes a built-in module appear in /sys/modules/ directory.
>
> Hmm, should we base a kind of UAPI on a hack?

Good question ;-)

>
> I don't want to block this change, but I just wonder why many modules
> are removing MODULE_VERSION and we are adding it instead.

Yep, that's a good point. I didn't know that other modules started to
remove MODULE_VERSION.

>
> >
> >I spent some time reading the code in kernel/params.c and
> >kernel/module/sysfs.c to figure out
> >why there is no /sys/module/vhost_vsock directory when vhost_vsock is
> >built-in. And figured out the
> >precise conditions which must be satisfied to have a module listed in
> >/sys/module.
> >
> >To be more precise, built-in module X appears in /sys/module/X if one
> >of two conditions are met:
> >- module has MODULE_VERSION declared
> >- module has any parameter declared
>
> At this point my question is, should we solve the problem higher and
> show all the modules in /sys/modules, either way?

Probably, yes. We can ask Luis Chamberlain's opinion on this one.

+cc Luis Chamberlain <mcgrof@kernel.org>

>
> Your use case makes sense to me, so that we could try something like
> that, but obviously it requires more work I think.

I personally am pretty happy to do more work on the generic side if
it's really valuable
for other use cases and folks support the idea.

My first intention was to make a quick and easy fix but it turns out
that there are some
drawbacks which I have not seen initially.

>
> Again, I don't want to block this patch, but I'd like to see if there's
> a better way than this hack :-)

Yeah, I understand. Thanks a lot for reacting to this patch. I
appreciate it a lot!

Kind regards,
Alex

>
> Thanks,
> Stefano
>
> >
> >Then I found "module: show version information for built-in modules in s=
ysfs":
> >https://github.com/torvalds/linux/commit/e94965ed5beb23c6fabf7ed31f625e6=
6d7ff28de
> >and it inspired me to make this minimalistic change.
> >
> >>
> >> In particular the interesting thing is from nfp, where
> >> `MODULE_VERSION(UTS_RELEASE);` was added with this commit:
> >>
> >> 1a5e8e350005 ("nfp: populate MODULE_VERSION")
> >>
> >> And then removed completely with this commit:
> >>
> >> b4f37219813f ("net/nfp: Update driver to use global kernel version")
> >>
> >> CCing Jakub since he was involved, so maybe he can give us some
> >> pointers.
> >
> >Kind regards,
> >Alex
> >
> >>
> >> Thanks,
> >> Stefano
> >>
> >> > MODULE_LICENSE("GPL v2");
> >> > MODULE_AUTHOR("Asias He");
> >> > MODULE_DESCRIPTION("vhost transport for vsock ");
> >> >--
> >> >2.34.1
> >> >
> >>
> >
>

