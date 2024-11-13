Return-Path: <linux-kernel+bounces-407949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1B19C7988
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 18:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37CCBB295A8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5806B15AAC1;
	Wed, 13 Nov 2024 15:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Woz/m7VV"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2730184D13
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 15:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731513005; cv=none; b=D2E2aalKK6hEmIxxGRrr5T+vMboDDwl6KFY90oJoRE0guQBKaqojqcts22jVfzOYRx60cZum8VOsAaLMr/rzAz+58+G3CR3WajuhDPhON7FjXlscvMyjblzj365VvvOfeCjvSLRaE5jfODHSbuqNLuz5Wo0HwtgU67NsL/QRrqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731513005; c=relaxed/simple;
	bh=qrf/MX5X0AlGXFJLUG/+BKtBhPdJUqAIibpijCzk5yM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ux9sSNbmsWfKoj+YlS+CqcJiITLY7lLrlh1Ue4dDVUXYQyOJVM6MWtsb6QHOjzYnJJdQi0naCLAgstZz0golEl0DItVIMk449z/88zlz7ORcjVZpuW3jD5p8bHVG59cQBSPCqQMT6I4e8YunRSAZSfpkw/ea7oCtOZ9Ejq3vWos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Woz/m7VV; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-462d8b29c14so43997141cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 07:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1731513003; x=1732117803; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F31sh03i/CliLI3oNgShFd0ApDGB/QRNyhmfoCFlyGs=;
        b=Woz/m7VV8Y/+/WzjHzxxbfSYuQt+dTFp0g3FGhHI5F053A9RuynSdV8fPTLG5nVwr1
         7auWO8JNKQKKJHYiTM6NoLAhfS8Wsc51TDfn18eErGWkvTsFr0hv2Ns4W9FDCuDV8wZE
         wgW63fYhI73LyQVxAYOUh4/wu+9HV3OufclIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731513003; x=1732117803;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F31sh03i/CliLI3oNgShFd0ApDGB/QRNyhmfoCFlyGs=;
        b=XUxhWlvRMilt9wiskBXX8R3mP4qa27maleKmOVRnZSSXc4hZCkzjj9D+yeHuh5GCoZ
         jWm5yZaZMlq5m860gFqOcF09pgKm80bx3wpv5wlITLfpU+K3PiUmJhQ23nJyjJFNgDKa
         Fd15R7ZTY8yJmzN3frf0BhbrVwdJwBEuQOvxsMJOYC7KW3qPOQbT+SFy+/23/WJ/o9CF
         r2Cyzc3p7gHTE8Opdk2maTqTIotisqm/QPcCKS0VzbGbfWamBUJbrhRq7OhrtgriCzh3
         kEyzdlrZr9XfuQsvC0DsZ0SYDVNOaxn7R0O1jytkgmIP+sHKud+cyADI3IlV9y3+KbDN
         GRfA==
X-Forwarded-Encrypted: i=1; AJvYcCV1TE2JETiMSHpzpRKUOIRUmx+u4IBOpMVbtZVKRACoiswUogYvNCv4i4kGh8s52nGd52ntH5FR5m61/Zc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIowxTUj2d47ghD5QOJm6zzsU8doKfHlnr3BiRIM9SybhT5KRb
	zbqsu/fdHjT74u7VJYwVkco7u2Iw8pi/Qt0IB+aZiGrKpdqIwx1Dae+zdmvZaAY8gLwfEkSgxX5
	cgb7FvZKbYpwjZZUGz6yNs8QD3U/PERnFI8yhAg==
X-Google-Smtp-Source: AGHT+IEz2vBQN8hRZ8EkBdXBC1NMCb1WkDSP1kv0lHCN9eUb5EuuKrzEddrDEc5mNi805ys4pKBxJF9Fv++NH94aHFA=
X-Received: by 2002:ac8:5dc6:0:b0:458:4129:1135 with SMTP id
 d75a77b69052e-4630930660fmr304637211cf.9.1731513003130; Wed, 13 Nov 2024
 07:50:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111-statmount-v4-0-2eaf35d07a80@kernel.org>
 <20241112-antiseptisch-kinowelt-6634948a413e@brauner> <hss5w5in3wj3af3o2x3v3zfaj47gx6w7faeeuvnxwx2uieu3xu@zqqllubl6m4i>
 <63f3aa4b3d69b33f1193f4740f655ce6dae06870.camel@kernel.org> <20241113151848.hta3zax57z7lprxg@quack3>
In-Reply-To: <20241113151848.hta3zax57z7lprxg@quack3>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 13 Nov 2024 16:49:52 +0100
Message-ID: <CAJfpegt5_5z1qSefL-Y7HGo0_j6OZGTQfM74wG6N2Q__vB0DsQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] fs: allow statmount to fetch the fs_subtype and sb_source
To: Jan Kara <jack@suse.cz>
Cc: Jeff Layton <jlayton@kernel.org>, Karel Zak <kzak@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Ian Kent <raven@themaw.net>, 
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Lennart Poettering <lennart@poettering.net>
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Nov 2024 at 16:18, Jan Kara <jack@suse.cz> wrote:
>
> On Wed 13-11-24 08:45:06, Jeff Layton wrote:
> > On Wed, 2024-11-13 at 12:27 +0100, Karel Zak wrote:
> > > On Tue, Nov 12, 2024 at 02:39:21PM GMT, Christian Brauner wrote:
> > > Next on the wish list is a notification (a file descriptor that can be
> > > used in epoll) that returns a 64-bit ID when there is a change in the
> > > mount node. This will enable us to enhance systemd so that it does not
> > > have to read the entire mount table after every change.
> > >
> >
> > New fanotify events for mount table changes, perhaps?
>
> Now that I'm looking at it I'm not sure fanotify is a great fit for this
> usecase. A lot of fanotify functionality does not really work for virtual
> filesystems such as proc and hence we generally try to discourage use of
> fanotify for them. So just supporting one type of event (like FAN_MODIFY)
> on one file inside proc looks as rather inconsistent interface. But I
> vaguely remember we were discussing some kind of mount event, weren't we?
> Or was that for something else?

Yeah, if memory serves right what we agreed on was that placing a
watch on a mount would result in events being generated for
mount/umount/move_mount directly under that mount.  So this would not
be monitoring the entire namespace as poll on /proc/$$/mountinfo does.
IIRC Lennart said that this is okay and even desirable for systemd,
since it's only interested in a particular set of mounts.

Thanks,
Miklos

