Return-Path: <linux-kernel+bounces-300878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8198495E9EB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 09:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B518F1C21385
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 07:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94A4770E5;
	Mon, 26 Aug 2024 07:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lJe1qhzj"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACD418C36
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 07:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724656018; cv=none; b=ubX2mnBDZ062BmHR4U/lx+W2ObdyytISG0qurJ7xsFRIvFWKmf2ZCjsupN5TOqbw7MOXu1qWdCTGCCxMGAnwDVZAm0ivhNyPogjbehttg3jomUMPiW1/sD/C245pLSQ5WOxo1KY0KsP78ZXq61qBNOqjMXSmRyvELScquShSBs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724656018; c=relaxed/simple;
	bh=SNFRIgBjVGxWaU8ivtlCUq9fNoElyookR1hHqJENiVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u7vd4KP39OgjYvWwZTv/8ZuXZ6GtsLHrkYR7tdiYBxL8U4UTQMqPmZtAGEecBXFUekYMDqNSZufv90q/da86OrKvNIwznEaFceyFz6BXHr+fDtZ6+KAlUSo2sMvjJPxPONPLvVuOq3sdOJo7RrFMIKPC0Wh2NU3RttHv/y9ouA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lJe1qhzj; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-371893dd249so2204523f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 00:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724656015; x=1725260815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cou5hke/PmBsaGSWYmEtI+A/77Tv+wsmqhvz0fRoOco=;
        b=lJe1qhzjlRugjNqoEn3AlnIhUpOYbBqPrdJEKubcFYASZ7LBhT52O7KsBUmbuLaCIt
         BaYoCP1mKasBm2KOT1qtQ6eTkuM8Q6LpLTG16Yoj6Xk7jSLru6a/K+u/Gp5Zb/dbEHE/
         B+i6jLI5c7r4Jcpn3MJ6eT42wUc34ZY1fSQ1WQlhE6YboIE/HZGm3FU1CZgbYZoqbrwd
         YuYBL+sJolGnIKiYwrdUaxSf5RwbA/nbP/H1hs8DEDL4InyFX1oYY3oDv34dHL9yGTbX
         mR4p0c+BX6GzHXuKm3rricfEM6bDH7U+W9004s2QgYm/QvfgCaXdYS7F3bxJFUlaokI7
         uKyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724656015; x=1725260815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cou5hke/PmBsaGSWYmEtI+A/77Tv+wsmqhvz0fRoOco=;
        b=MOS9md+bHcZ53CMTULdMRTVdvd7OFPbE7LZ0TBWxOBuyr+r+rw8l03fwmEr5MKGgPN
         ZmrMuomrHueHf9ZG+FXpBjo3ABoN/bcTrUeilXCpMQh6ERY9acmBOZVP+rxNKBZUPLdh
         n24oAChB3iV9jNAvsXt5X+DOhVFXjgGtnzUCynOieasGvwyJL+Wd2hmJrL/5O4iGGDMY
         PiSFKDkEvROEmiIPIlU7u5j6gSLKN/vijyQxzdI8/cIDO+oq2lf4ynvh0hPp6vonpRoQ
         dI9YJJ/JDQ4CEjtojFCdscKvkODjU6TrDuSx2LPkTKSanWPDIpZJGHeCz1aAwo3odSSu
         JnVA==
X-Forwarded-Encrypted: i=1; AJvYcCVEKBxXaXEZyw0NVDCW6t4BVoxYEIA86byx8J89Q8ttNCtFncrBvUMb173dZDG8++PBTEpfIJTqII8NzTE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7zm5R1ng8d6sUq0wMUYSnqLfgttSqjlZhYvRWdTGr7fuX6eMK
	JFpwk0ojFhdCaG6RvJdcGju2yJIG1eFrFkr1XqlXSNDDr+eyahQdH5d0jt9lPaU/ui6rdp5pilv
	H7rqRBeuz1dtNyUDHma272B1QoVNTqAypf+xVIg==
X-Google-Smtp-Source: AGHT+IH0yjPV9DOuSzxG5nR7SIxFbQUEOfD/AQ3YPBP4CCB95G07H3GrdBQdq+CphyFDEtYdwCNVbzC3/qRbcDo9HGE=
X-Received: by 2002:a5d:66c1:0:b0:371:882d:ce9d with SMTP id
 ffacd0b85a97d-373118643dbmr5639415f8f.36.1724656015242; Mon, 26 Aug 2024
 00:06:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240811101921.4031-1-songmuchun@bytedance.com>
 <20240811101921.4031-5-songmuchun@bytedance.com> <ZshyPVEc9w4sqXJy@fedora>
In-Reply-To: <ZshyPVEc9w4sqXJy@fedora>
From: Muchun Song <songmuchun@bytedance.com>
Date: Mon, 26 Aug 2024 15:06:18 +0800
Message-ID: <CAMZfGtW-AG9gBD2f=FwNAZqxoFZwoEECbS0+4eurnSoxN5AhRg@mail.gmail.com>
Subject: Re: Re: [PATCH 4/4] block: fix fix ordering between checking
 QUEUE_FLAG_QUIESCED and adding requests to hctx->dispatch
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, "open list:BLOCK LAYER" <linux-block@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, muchun.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 7:28=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Sun, Aug 11, 2024 at 06:19:21 PM +0800, Muchun Song wrote:
> > Supposing the following scenario.
> >
> > CPU0                                                                CPU=
1
> >
> > blk_mq_request_issue_directly()                                     blk=
_mq_unquiesce_queue()
> >     if (blk_queue_quiesced())                                          =
 blk_queue_flag_clear(QUEUE_FLAG_QUIESCED)   3) store
> >         blk_mq_insert_request()                                        =
 blk_mq_run_hw_queues()
> >             /*                                                         =
     blk_mq_run_hw_queue()
> >              * Add request to dispatch list or set bitmap of           =
         if (!blk_mq_hctx_has_pending())     4) load
> >              * software queue.                  1) store               =
             return
> >              */
> >         blk_mq_run_hw_queue()
> >             if (blk_queue_quiesced())           2) load
> >                 return
> >             blk_mq_sched_dispatch_requests()
> >
> > The full memory barrier should be inserted between 1) and 2), as well a=
s
> > between 3) and 4) to make sure that either CPU0 sees QUEUE_FLAG_QUIESCE=
D is
> > cleared or CPU1 sees dispatch list or setting of bitmap of software que=
ue.
> > Otherwise, either CPU will not re-run the hardware queue causing starva=
tion.
>
> Memory barrier shouldn't serve as bug fix for two slow code paths.
>
> One simple fix is to add helper of blk_queue_quiesced_lock(), and
> call the following check on CPU0:
>
>         if (blk_queue_quiesced_lock())
>          blk_mq_run_hw_queue();

This only fixes blk_mq_request_issue_directly(), I think anywhere that
matching this
pattern (inserting a request to dispatch list and then running the
hardware queue)
should be fixed. And I think there are many places which match this
pattern (E.g.
blk_mq_submit_bio()). The above graph should be adjusted to the following.

CPU0                                        CPU1

blk_mq_insert_request()         1) store    blk_mq_unquiesce_queue()
blk_mq_run_hw_queue()
blk_queue_flag_clear(QUEUE_FLAG_QUIESCED)       3) store
    if (blk_queue_quiesced())   2) load         blk_mq_run_hw_queues()
        return                                      blk_mq_run_hw_queue()
    blk_mq_sched_dispatch_requests()                    if
(!blk_mq_hctx_has_pending())     4) load
                                                            return

So I think fixing blk_mq_run_hw_queue() could cover all of the situations.
Maybe I thought wrongly. Please correct me.

Muchun,
Thanks.

