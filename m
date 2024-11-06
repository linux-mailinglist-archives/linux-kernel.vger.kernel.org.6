Return-Path: <linux-kernel+bounces-397894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 307919BE203
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 10:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E878F28331A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06F41DA622;
	Wed,  6 Nov 2024 09:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ts8RqOkv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748BB1DA0E1
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 09:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730884196; cv=none; b=puchDM7qrtCrsUbnCMi8u+A1a68seQQ44MzkKIn64jDBuLE3lqwYHfDT9fWwjcvh0lmalWDClNd1WXCtcXBD2jwljWXL6hi9IHTfkXD4EZoS4jjf5X9JkMH4sXtAOV9ukXK8qqm4JdQX2o4P+3F/hUojWw2RiA2xn0/A7smzt8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730884196; c=relaxed/simple;
	bh=Ve3ngN2EEXHIJllVwR94QiODyXjYWDIRJ59WcErDYVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LORdMRay9IGw+zL7fIKGP9VI6+0q12DyynIRVUnoFGJTFHtLBsdIVdA7tUh5d8USbeTllnFBTid8+bvhHS3AwLfv0IiKwL793N+TqNo/k7v4sa3956eZ/uWOPoxUKxypE1L0bbW5uIWT4qRTzVMS71vpJJS004kmZQbMje1DmaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ts8RqOkv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730884193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eGIM5USzAXYsKg5z2NxV6SvyDptl8f4iMkBBwNNtWVo=;
	b=Ts8RqOkvtmYR0V2a//4lP6iKh7EP6DbfKfPE9JnogIcLO0t5Ed7sIhE1hgw+FPcu21K1p/
	o4PaLs+HkIt3kXFeKWupB3bo2he1ta/myVzcjoH/FJKL4QiByTk0r+kqn7DivfF+n3iz6c
	J/7v16wvNdVUNlbN0JPdzPM126t9N/g=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-QxO4E2ABPRy-SNd0nF9W7A-1; Wed, 06 Nov 2024 04:09:52 -0500
X-MC-Unique: QxO4E2ABPRy-SNd0nF9W7A-1
X-Mimecast-MFC-AGG-ID: QxO4E2ABPRy-SNd0nF9W7A
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6cc10cd78e4so106486146d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 01:09:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730884191; x=1731488991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eGIM5USzAXYsKg5z2NxV6SvyDptl8f4iMkBBwNNtWVo=;
        b=g/K+mhcdLg6LdYGCEFyo/knEZjzznOkBebjw8loIvEa4mbkhR6SGigc6ZbLFbONnNd
         pUBD1B9n09UhrSOYjClxQXufxueuZsoVE6y0HlIFMeNlo9HSsY0dhJiAETJc+uV176cU
         BdmNHpOvtW6A5pfe1IPNVCLQIpl1C+pnuBqIXYR6aD/jEIjbmO603o0wDL2rcID1FmCK
         R8TtIZinRkofyI8kzx1a9qj7PdPJnkvWAhW5Djt3wXjxl3cyBvJVzId/hKW342cEgTPI
         HX3c35ffCZHZWVm6OAjBwcHwmvxrZjidL+UoZd3ZIeXAVV8vwj95if4KNRC3KkLc1jLD
         rS8w==
X-Forwarded-Encrypted: i=1; AJvYcCUUB4///GJsCkGSm3GOXfmExm1ADCf2d9VcRbwTLnGCxsm111N6kRsSJh8S6RjU5w1wUYlgtQRWuXWy6wE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdk0XLyEyk/R/TwfWi2jZtGDAYcIRDK3fuCRCYx/WCAVodjVPd
	nevKpsfjxyInPcPPEVrp5d9fqyI7hGTfJqe9Z7xn5mxMzdl7189V7Tu9ssf4H00oLa91ITBdHo+
	L3zDUkiTfZPFF9nU/6RMiMCShee0njS1EtZfHt9usi10mzW09Oa/NwTOlHxwlgO9/7sl6rxyL+A
	f3xoZ3+HRRNojjKyhypfwEeGYrNHqC0pErBGNT
X-Received: by 2002:a05:6214:2c0f:b0:6d3:71ab:adb9 with SMTP id 6a1803df08f44-6d371abc487mr181888996d6.45.1730884191749;
        Wed, 06 Nov 2024 01:09:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLsFkorkkGw4mojt664zWvWPLr3Scpo66osjjuJqG5oZ4qhtX+rowBC3sywsaK62RI3BDLKaQTGDUzR5Jf7D0=
X-Received: by 2002:a05:6214:2c0f:b0:6d3:71ab:adb9 with SMTP id
 6a1803df08f44-6d371abc487mr181888866d6.45.1730884191530; Wed, 06 Nov 2024
 01:09:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <672ad9a8.050a0220.2a847.1aac.GAE@google.com>
In-Reply-To: <672ad9a8.050a0220.2a847.1aac.GAE@google.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Wed, 6 Nov 2024 17:09:40 +0800
Message-ID: <CAFj5m9LSOvbaOdM8Gvgt8HVprB_DAxiFDOW3Qou8bfAtEz_e8g@mail.gmail.com>
Subject: Re: [syzbot] [usb?] [scsi?] WARNING: bad unlock balance in sd_revalidate_disk
To: syzbot <syzbot+331e232a5d7a69fa7c81@syzkaller.appspotmail.com>
Cc: James.Bottomley@hansenpartnership.com, linux-kernel@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org, 
	martin.petersen@oracle.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 10:51=E2=80=AFAM syzbot
<syzbot+331e232a5d7a69fa7c81@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    c88416ba074a Add linux-next specific files for 20241101
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1051f55f98000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D704b6be2ac2f2=
05f
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D331e232a5d7a69f=
a7c81
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D16952b40580=
000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/760a8c88d0c3/dis=
k-c88416ba.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/46e4b0a851a2/vmlinu=
x-c88416ba.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/428e2c784b75/b=
zImage-c88416ba.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+331e232a5d7a69fa7c81@syzkaller.appspotmail.com

#syz test: https://github.com/ming1/linux.git for-next


