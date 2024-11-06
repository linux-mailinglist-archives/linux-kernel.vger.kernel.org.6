Return-Path: <linux-kernel+bounces-397596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DF19BDDCF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 04:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B54528505B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 03:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503AE19066D;
	Wed,  6 Nov 2024 03:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PTk+ySqb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F032318DF73
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 03:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730865175; cv=none; b=H5AUn5ytDC45POq08HG7J11TrDu+l6rUFfgMnK7wizNOaHHaJhCBV+HTMzX0tJnSdHRV+k/UgWj/jPa6uahNab931kGv1jg7OpCQqYK3f64jktZkShyV/mAeYfDCB6ZKKcReQwxa35AMbQ0HBkp9KhH3aVDMFjd8idHLxHO2gik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730865175; c=relaxed/simple;
	bh=5aE09eJAw+DWO/GK0+6zxMbedIgfEssWtZFIf9Rdfcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OfU1qjIsyz2Nl6zPrhNaTyDBbClRU2OLMDHnszE8pj83Z+wV4dFakh+YbCKIR2L1VHTt+u16YT9q07Anc2V9OgvELERWZfv/AfHmwbuK+tdQo1IDZFvvWXnYRd/q469+r7fq7CDy0CSW7rzRcm0oI/IQB2CXsk1vmL4pAgYrJ7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PTk+ySqb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730865172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1TiMSpJJDatpGrOSJe9rj+NgTUiSiplFcFvJnfcnFCY=;
	b=PTk+ySqbMqcS7O7CB3Yqq4I1JOGfy1sDW3gN+I9oh0Eu00v4N+CWlD3I//ZvcHum2LWDCd
	V1vRI22QpMOJoh3nGR9LOCKqRGf/yDeM9DIAH2b49ASKL7HnGrzM2f+fSM57aVqmnjXePf
	BBfcUKNHuUmzxHmEsCtjKn6+VVY82AY=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-CGpo-tHSO_WINf_T1JTvlg-1; Tue, 05 Nov 2024 22:52:51 -0500
X-MC-Unique: CGpo-tHSO_WINf_T1JTvlg-1
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-84feb9e9a14so1433241241.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 19:52:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730865170; x=1731469970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1TiMSpJJDatpGrOSJe9rj+NgTUiSiplFcFvJnfcnFCY=;
        b=nhCYH4X+XrL8EBownBJZAM+Sn9gJDlda5rRrKNbPt+ONpPsdwBoqExTBFtvlUqYbv+
         NoqE5ddDlmh6yG+m96YrWhfuHXb1wmkpORRkf46SLdWSNP4ZLhJ+Q28CBSYz1djjKyNl
         GkPlitlGXS/FNmAbdewb/G09BcsNUVlxPJ6HJjZ2DiV4GF6cEvo9ky8FcswbwgBvHQ6+
         AaKfgw28RdSE3SwhhexA8vM6B8xxXhMgadDZJgqA/KrvJVsJp3Ejffs2WiZXfFilCWA+
         Z5mCCCkUW37j4EZOX6/MEk8TmvQ93rtYUCUe9s/sepr6X0GjHicxJJpu/9jiGP+DOFdr
         N9AQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1N3k6GmHds3YnjEd7y1gv+AFV0hBzhEESP1AxTcBDWf4uri4Jl7o/1AuhtuMADxiIsiswmJHwJtxGnFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAqZredTI+h0JbqSPIwhrHyFzv9himCCALpo8t31p8X7efNTYO
	M9vioRNJfkNFiccrlXTm1ANpvoHQYLDIlMkahVFPTwxUnDRTmawPlWjRiGI7YKHytZTqRROh6Uo
	pnCRKQ1MAXKjIek3EGKYxqCQUpKf8T0Tg6CQRDCiDQUPhleR6KCk6R19J6sk7s9gqgkuTWGs8Sz
	cyAeRKWt+OEwlDIetbaR9bssdfetroJxYHrOKfB9JnXsrFtZVRew==
X-Received: by 2002:a05:6102:54a6:b0:4a3:a137:ba7 with SMTP id ada2fe7eead31-4a9542a6648mr20367582137.9.1730865170500;
        Tue, 05 Nov 2024 19:52:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhhXYpi0AcG+0c1Qcso/83tNVaNoAmn2rY1up2L2z39Hn10xr/7RtAngqs2ZydHcl7R3SGQT71bMWdEEDqwlk=
X-Received: by 2002:a05:6102:54a6:b0:4a3:a137:ba7 with SMTP id
 ada2fe7eead31-4a9542a6648mr20367570137.9.1730865170142; Tue, 05 Nov 2024
 19:52:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <672ad483.050a0220.2edce.1518.GAE@google.com>
In-Reply-To: <672ad483.050a0220.2edce.1518.GAE@google.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Wed, 6 Nov 2024 11:52:39 +0800
Message-ID: <CAFj5m9+1dZtWufO0xzGgWPyMjD1NZ_a-kfeW+Q3ujH_rnR09hg@mail.gmail.com>
Subject: Re: [syzbot] [block?] [usb?] WARNING: bad unlock balance in blk_mq_update_tag_set_shared
To: syzbot <syzbot+5007209c85ecdb50b5da@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 10:38=E2=80=AFAM syzbot
<syzbot+5007209c85ecdb50b5da@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    c88416ba074a Add linux-next specific files for 20241101
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D12d3474058000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D704b6be2ac2f2=
05f
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D5007209c85ecdb5=
0b5da
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D16d34740580=
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
> Reported-by: syzbot+5007209c85ecdb50b5da@syzkaller.appspotmail.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> WARNING: bad unlock balance detected!
> 6.12.0-rc5-next-20241101-syzkaller #0 Not tainted
> -------------------------------------
> kworker/1:1/57 is trying to release lock (&q->q_usage_counter(queue)) at:
> [<ffffffff8497aa7f>] blk_mq_update_tag_set_shared+0x27f/0x350 block/blk-m=
q.c:4131
> but there are no more locks to release!

#syz test: https://github.com/ming1/linux.git for-next


