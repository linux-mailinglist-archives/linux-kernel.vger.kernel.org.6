Return-Path: <linux-kernel+bounces-406975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 147D79C66EC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 02:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D4261F259D8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 01:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831F960890;
	Wed, 13 Nov 2024 01:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="lkWGilCc"
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3293F9FB;
	Wed, 13 Nov 2024 01:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731462849; cv=none; b=jjfjZMC8P0EIiSDSdS03Ck/Sf2uZ93m3QmOzHC1r5Ewi4LLcri8hnlcMUL3YZ0gOZ31gIeWL/wqzAss7guY0+NfRjS1LI8lsiVvsv7DIHovGvnb5r5XL7J074hppNW39hMd2fAfnziNVqCGkwivpiu39XpKO15ebRf8RePgxEvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731462849; c=relaxed/simple;
	bh=DGfzfgtFtmm9Op45fZ60+QzicBwp3DJIRdRAC6XS6AE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=lfQobqQL5Rt/ZlYCX642APTRi3S5dbeOyV9HVxo+tABO61j7F/0wwj+TUL9IywDzOD/xQJjocdxd29923Q/0z4WV0LFAAt+AHKPFpWlVjbbhUvOIFgu6I/lI5nOv9rNfbFCY0W71dF+k1fYBpI35oeqzR6krVbu1dPbLgl5aK1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=lkWGilCc; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1731462530; bh=mXkqNuSGKTzuC2TOeivMF/ydgWANTlG4BtllfcdHm8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lkWGilCcRgl648rw2sEi4YeP9ipRQCEy0fzq4CnwPox/havQbn9BiXV6Ot+hFOARH
	 U4WziEkzT+sQ2qwRMAmV4RK6BpkRp4UAQrCVKO/984tZ96QqtoTbC8ICvyPtzDgbdd
	 0HCH2D/8/Z/rKIueqGswCVwJUbkKAg37kmRkt6uw=
Received: from pek-lxu-l1.wrs.com ([111.198.227.254])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id C3010CFF; Wed, 13 Nov 2024 09:48:48 +0800
X-QQ-mid: xmsmtpt1731462528tqx2qm50p
Message-ID: <tencent_F41B22255CBA04BB3B33319E461BFF4B3708@qq.com>
X-QQ-XMAILINFO: MpvVxjO9l39xH+iVuCocCvZEa3gNcmvfqJCZF6cpWf3Xt4VyNqiJ05jQDr8WQ5
	 tAocq8CciWxj7FVJHynam3aOtI/nARUJJ03b0QWURQyHLWSJfIUWfLiwkEgahJcV1tMb/nz1LO/u
	 ke5hh2uM6DLPV9Ixer86raIXsDj8AbAHLgyrOa/6scNTvdxJhwRuoKgQseh3+2tI220ZR9uqRdOI
	 AlLWcDy9JKebRbkI6VPNJQdPrHNRG4B/gFKUWKyvm/zhsOC8cBzyC6GGTVHT1uKNWnA2vcw2w8Wv
	 Gjl1hAYD7xw0JTLFzbFQXHfAnum18YDhLvzzaeAjN6gJZSrEhgY7UjiUj9nIwBlGfEbnXs+l6qhy
	 cpwSDGVkojhRLg35xDs2tArjmVyZGqiye1ETeZpZRo2ZJYq77H1NXTmBJFRN0ZBCGi2fswfuZ6tr
	 3HrQBaqdxXUKuXBMd5SjdmhQ8zu6fu+lWv5sT108AZ/Iko+gx+JCTclu48K0DAVXHAvWkw77htqf
	 PVXg6dpPaDeDnWHeie1hQFAkemUV1hnV4XUTvSGubI+EIwZ8epuXhlwa+1QlKCQx1LkjASaVbexu
	 mrRO5OV/dGKh9PtGLNkubIAwlzcM/mn3TueKPXsoJRxdnnQAuVIOsd7kwzE5W9BZOB1gHSz63TFQ
	 UIXhNIJdwslvlbIQwwqg9oVUpAe5UJfVnDbEYuA+Sm7ojwVWt7qt5UbPFEWXb6o3GIxee0LN78ij
	 SMzSFSNBAF77XgyP3lLxYkmhoXNTUvSB1BWuFp8NZGmGnaRcGtyUXpzgpSzP9IF/IObOlyR7X0Q5
	 PztgBuDfs4C7YT724ez/KCj7wv/8LNYULCPgftFwWarVuD/+ySqA7xDjQOKXaTJlsoHYROTlWNEN
	 nJ2Mi8Tpw7SsuZ7DVXE3ra1hyquVp4pMbUj4vSiOAsqvahl1/m9dTVcAqGAWzLf8WTw+xBuwwy
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: tiwai@suse.de
Cc: eadavis@qq.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	syzbot+73582d08864d8268b6fd@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	tiwai@suse.com
Subject: Re: [PATCH] usb: fix a task hung in snd_card_free
Date: Wed, 13 Nov 2024 09:48:49 +0800
X-OQ-MSGID: <20241113014848.1785212-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <874j4ctp57.wl-tiwai@suse.de>
References: <874j4ctp57.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 12 Nov 2024 17:04:04 +0100, Takashi Iwai wrote:
> On Wed, 06 Nov 2024 03:15:49 +0100,
> Edward Adam Davis wrote:
> >
> > task 1: snd ctrl will add card_dev ref count and can't call close to dec it,
> >         it is blocked waiting for task 2 to release the USB dev lock.
> >
> > task 2: usb dev lock has been locked by hung task (here is usb_disconnect),
> >         it is hung waiting for task 1 to exit and release card_dev.
> >
> > Adjust the USB lock acquisition method to non-blocking in ioctl to avoid
> > hang when the USB connection is closed.
> 
> I'm afraid that this change would break things too badly.
> i.e. changing the blocking behavior to non-blocking is no-go.
> 
> > Reported-and-tested-by: syzbot+73582d08864d8268b6fd@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=73582d08864d8268b6fd
> 
> This particular syzkaller entry can be fixed rather by replacing
> snd_card_free() in snd_usx2y_disconnect() with
> snd_card_free_when_closed() like other USB audio drivers, something
> like below.
> 
> Judging from the git log, it had been with snd_card_free_in_thread(),
> but was switch to snd_card_free() around year 2005.  Meanwhile the
> handling of async card release got improved, and it's very likely OK
> to use snd_card_free_when_closed() there with the recent kernel.
The snd_card instance will be released in snd_card_do_free().
So, if snd_card_free_when_closed() is used to replace snd_card_free(), who will release the snd_card instance?

BR,
Edward
> 
> 
> thanks,
> 
> Takashi
> 
> -- 8< --
> --- a/sound/usb/usx2y/usbusx2y.c
> +++ b/sound/usb/usx2y/usbusx2y.c
> @@ -422,7 +422,7 @@ static void snd_usx2y_disconnect(struct usb_interface *intf)
>  	}
>  	if (usx2y->us428ctls_sharedmem)
>  		wake_up(&usx2y->us428ctls_wait_queue_head);
> -	snd_card_free(card);
> +	snd_card_free_when_closed(card);
>  }
> 
>  static int snd_usx2y_probe(struct usb_interface *intf,



