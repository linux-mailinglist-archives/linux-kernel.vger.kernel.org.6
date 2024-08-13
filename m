Return-Path: <linux-kernel+bounces-284158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 016F394FDAF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80D0E1F23DA5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 06:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73C93CF4F;
	Tue, 13 Aug 2024 06:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A2MqLtS+"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0398B3BB32
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 06:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723529802; cv=none; b=AUTmnBvVSPpgsNtDQVUk9FvgwP7aVAps4Ckk24A7N0MJx9ma1O5G1VYkNos6lyHNfupQgMSJ2Y3Or357obEDZm9Z1FoTNkqy1efK3TcU33ZnFhr6u2erCdeibR5CAHrkxNk+eThaOlj/5Z569WpvMNUB9aG6M0XqFTSxg5SFb9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723529802; c=relaxed/simple;
	bh=1zLrMufGpEPo2TCKDZ0r0bnUQSrSwKfLuQZpXazyGqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hsYDyhgITdkvmZN3lcC4hquqoXurNCHmraN685g5q9zEG7wellv3zjas2xWKj/+i+4xCeKwGcesBzY3ynBVJK1Q66Mp2WXjBffPbOer36F+XYFr8t1DWiIqY0gEpdKfcUK3iIjZATFamU7wPAjIYYy0xaPA2ipljGMvg144P2dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=A2MqLtS+; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-530e22878cfso4685476e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 23:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723529799; x=1724134599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmzoXafzzOE1rMuPRaQhJ4b0giBbMD8YUbTNEAqnvGA=;
        b=A2MqLtS+PQRqT/K8UFGoWdy/uqB0tzLYN0O+rgZ55kW8Ajvu9DEKTPJfKEEojTvlFu
         Bfzb60oI1PTQOsKb9O26Rr0VqSco27nvfuXB2cQzaQynLNEqufS/rQIr5gQzCJfFQNDE
         pPmtVfSPF5PIZSv+Nhqz3T1gIpLWRTkVRNa5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723529799; x=1724134599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YmzoXafzzOE1rMuPRaQhJ4b0giBbMD8YUbTNEAqnvGA=;
        b=sawGyztwrvTdwWzzFo9LUBbHkhnQzXXFU7giuzIgvjfj7a3+7xFmnGw9iIharwc2TC
         FavTi3iOmthLNLPHZf5X0MaUSV7SY9egCKFP8rUkUsuzpleShyqSQRoZQZOU5VrxuHG2
         9H06zoCfLeCIMQXzdAoSbXR+w3ybx/D/agkkLrwWTq45Nr3MBl2ZJvjh9y9RoFkEA/h1
         MvYF8ueFE/AAdYmTqJUQaiezHW58yg3KIt3JdwY38QJTUBloq6S09+ysjgxM/qF8J2gL
         GuSLUOnfHnnidoltrvTuxMdHqY/tFpEJmMup4cUIC6jSaSfSNek/cEOsN2YYq0pOMJGF
         Wi7A==
X-Forwarded-Encrypted: i=1; AJvYcCWDWEwvLeZiZeFWtNednbKKP6zUqA9T053oAuDWhBrDD6yBEqd2rKpSKxpQNCzJAXCzHntVYfjTw97QNIP+X4ZIAdafAO3bnZsJ90Io
X-Gm-Message-State: AOJu0YxkAXbsWUtG9OMGCpGm8VhRdzE4WcmviY0hl8daNXRNlbPsz2Jf
	eTh5R1bZwH23pULcrqEZAtBbAgq4MmCfiZeovD5JT+Lwiit6BIrjdmefqjfKgnBpsHdbyJp3IQa
	bASdROSWKprTKyGzEI+11mx6NifuXLCtcZstE
X-Google-Smtp-Source: AGHT+IHu6zKBIZ4X+Jnv0cVaNkX2ByqQvEYyg3vpF7NwXvrGAvo32O6JWXjruspUcp673wvWIwcVakKmZkhIdZctkMc=
X-Received: by 2002:a05:6512:3083:b0:52e:9d2c:1c56 with SMTP id
 2adb3069b0e04-5321366369amr1519996e87.35.1723529798714; Mon, 12 Aug 2024
 23:16:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812211844.4107494-1-dualli@chromium.org> <2024081341-egging-custodian-428d@gregkh>
In-Reply-To: <2024081341-egging-custodian-428d@gregkh>
From: Li Li <dualli@chromium.org>
Date: Mon, 12 Aug 2024 23:16:27 -0700
Message-ID: <CANBPYPjCobjbtyKoFJHAciE3=m0Z_QeDTdD9C=ggCcvaWy0daA@mail.gmail.com>
Subject: Re: [PATCH v1] add binder genl for txn report
To: Greg KH <gregkh@linuxfoundation.org>
Cc: dualli@google.com, arve@android.com, tkjos@android.com, maco@android.com, 
	joel@joelfernandes.org, brauner@kernel.org, cmllamas@google.com, 
	surenb@google.com, arnd@arndb.de, masahiroy@kernel.org, 
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, hridya@google.com, 
	smoreland@google.com, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 10:13=E2=80=AFPM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Mon, Aug 12, 2024 at 02:18:44PM -0700, Li Li wrote:
> > From: Li Li <dualli@google.com>
>
> Sorry, but I can not parse your Subject: line at all.  Please use
> vowels, we don't have a lack of them :)
>
> Also look at how other patches are formatted for these files to get an
> idea of how to create a good subject line.

Thank you for reviewing the patch!

Sure, I'll find a more meaningful subject in v2.

> > To prevent making the already bloated binder.c even bigger, a new sourc=
e
> > file binder_genl.c is created to host those generic netlink code.
>
> "genl" is a rough abbreviation that is not going to be easy to remember,
> what's wrong with "binder_netlink.c"?

It's just because genl has already been used in both of generic netlink
kernel code (e.g. in linux/include/net/genetlink.h) and user space librarie=
s
https://man7.org/linux/man-pages/man8/genl.8.html.

I'm happy to rename it to binder_netlink.c if that's easier to remember.

>
>
> >
> > Usage example (user space pseudo code):
> >
> >       // enable binder report from the interested binder context(s)
> >       struct binder_report_info info =3D {0, BINDER_REPORT_ALL};
> >       ioctl(binder1, BINDER_ENABLE_REPORT, &info);
> >       ioctl(binder2, BINDER_ENABLE_REPORT, &info);
> >
> >       // set optional per-process report, overriding the global one
> >       struct binder_report_info info2;
> >       info2.pid =3D getpid();
> >       info2.flags =3D BINDER_REPORT_FAILED | BINDER_REPORT_OVERRIDE;
> >       ioctl(binder2, BINDER_ENABLE_REPORT, &info2);
> >
> >       // open netlink socket
> >       int fd =3D socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
> >
> >       // bind netlink socket
> >       bind(fd, struct socketaddr);
> >
> >       // get the family id of binder generic netlink
> >       send(fd, CTRL_CMD_GETFAMILY, CTRL_ATTR_FAMILY_NAME);
> >       int id =3D recv(CTRL_ATTR_FAMILY_ID);
> >
> >       // register the current process to receive binder reports
> >       send(fd, id, BINDER_GENL_CMD_REGISTER);
> >
> >       // verify registration by reading back the registered pid
> >       recv(fd, BINDER_GENL_ATTR_PID, &pid);
> >
> >       // wait and read all binder reports
> >       while (running) {
> >               struct binder_report report;
> >               recv(fd, BINDER_GENL_ATTR_REPORT, &report);
> >
> >               // process struct binder_report
> >               do_something(&report);
> >       }
> >
> >       // clean up
> >       close(fd);
>
> What userspace code is now going to use this and require it?  How was it
> tested?  Where is the test code?  Where is the new user/kernel api that
> you created here documented?

As mentioned in the commit message, binder is used in Android OS. But the
user space administration process can do little to deal with binder transac=
tion
errors. This is tested with Android. I'll upload the user space code to AOS=
P.
If there's a better option to host the test code, e.g. a smaller and
simpler project
that uses binder, please let me know.

>
> You added a new ioctl here as well, why not mention that?  Why is it
> needed?  Why not always emit netlink messages?  How do you turn them
> off?

The generic netlink message is a convenient way for the kernel driver to se=
nd
information to user space. Technically it's possible to replace this
new ioctl with
a netlink message. But that requires much more unnecessary code parsing the
raw byte streams and accessing internal binder_proc and other structures fr=
om
netlink layer. It's much more elegant to use an ioctl with only a
couple lines of
source code.

To turn them off, just call the same ioctl, resetting the flags to 0.
That said, the
name of this new ioctl (BINDER_ENABLE_REPORT) isn't good enough.
What do you think if I change it to BINDER_SET_NETLINK_REPORT?

>
> And how does this deal with binder namespaces?  Are these messages all
> now "global" somehow?  Or are they separated properly per namespace?

The new ioctl BINDER_ENABLE_REPORT (again, it deserves a better name)
sets the report_flags for its associated binder context. Each binder contex=
t has
its own settings. The messages from all binder contexts are sent to user sp=
ace
via the same netlink socket. The user space code can enable the reports for
each binder context separately and distinguish the netlink messages by the
name of the binder context.

It's also possible to have one netlink socket for each binder context.
But it seems
like overkill to me.

Thanks,
Li

